#!/usr/bin/env python3
import argparse
import fcntl
import importlib.util
import math
import os
import pathlib
import signal
import sys
import time
import typing

DEFAULT_UPS = 15  # Configures how many updates we try to reach per second

COLORS = ("r", "g", "b")

# Load backend
backend_spec = importlib.util.spec_from_file_location("backend", pathlib.Path(__file__).parent / "animator_backend.py")
assert backend_spec
backend_module = importlib.util.module_from_spec(backend_spec)
backend_spec.loader.exec_module(backend_module)
backend = backend_module.Backend()

rainbowdir = pathlib.Path("/var/run/rainbow")

is_paused = False
configuration: dict[int, list[dict[str, int]]] = {}
state: dict[int, dict] = {}


def report(*args, **kwargs):
    """The replacement for simple print that immediatelly flushes output. The issue here is with pipe setup in procd
    that does not buffer simply to the end of line. The effect is that simple print is not immediatelly displayed in
    logs without this flush.
    """
    print(*args, **kwargs)
    sys.stdout.flush()


def pause():
    """Pause animation. To resume the reload has to be called."""
    global is_paused
    is_paused = True
    report("Paused")


def _field2value(field: str) -> typing.Optional[int]:
    """Converts field to integer or None in case of '-'."""
    if field == "-":
        return None
    return int(field)


def _base_color(base_color, i, color, new: str) -> typing.Optional[int]:
    new = _field2value(new)
    if new is None:
        if i in base_color:
            return base_color[i][color]
    return new


def reload():
    """Load latest rainbow configuration and resume animation."""
    report("Reloading...")
    configuration.clear()
    try:
        dirfd = os.open(rainbowdir, os.O_RDONLY | os.O_DIRECTORY)
    except FileNotFoundError:
        return  # No configuration so just simply skip loading
    fcntl.flock(dirfd, fcntl.LOCK_EX)

    base_color: dict[int, dict[str, typing.Optional[int]]] = {}
    files = [pth for pth in rainbowdir.iterdir() if pth.is_file and not pth.name.startswith(".")]
    files.sort()
    for filepath in files:
        with filepath.open() as file:
            i = 0
            for line in file:
                fields = line.rstrip().split("\t")
                base_color[i] = {COLORS[y]: _base_color(base_color, i, COLORS[y], fields[y]) for y in range(3)}
                if fields[3] == "animate" and backend.handled(i):
                    frames = []
                    offset = 4
                    while len(fields) - offset >= 4:
                        frame = {COLORS[y]: _field2value(fields[offset + y]) for y in range(3)}
                        frame["ns"] = int(fields[offset + 3]) * 1000000
                        frames.append(frame)
                        offset += 4
                    if frames:
                        configuration[i] = frames
                elif i in configuration and fields[3] != "-":
                    # Some different configuration so make sure that we ignore the previous one
                    del configuration[i]
                i += 1
    # Note: We have to collect base color from all levels first before we assign it as some higher level might change it
    # without updating mode.
    for ledid, points in configuration.items():  # Fill in base color
        for point in points:
            for color in COLORS:
                point[color] = (base_color[ledid][color] or 0) if point[color] is None else point[color]

    state_keys = set(state.keys())
    configuration_keys = set(configuration.keys())
    for ledid in state_keys - configuration_keys:  # Remove old states
        del state[ledid]
    for ledid in configuration_keys - state_keys:  # Initialize new states
        state[ledid] = {
            "index": 0,
            "start": time.monotonic_ns(),
        }

    os.close(dirfd)  # unlocks directory
    global is_paused
    is_paused = False


def _interpolate(a, b, point):
    return int(a + ((b - a) * point))


def interpolate(a, b, timeoff):
    """Interpolates two colors to the given point between them for given time offset."""
    point = timeoff / a["ns"]
    red = _interpolate(a["r"], b["r"], point)
    green = _interpolate(a["g"], b["g"], point)
    blue = _interpolate(a["b"], b["b"], point)
    return red, green, blue


def update():
    """Animation function."""
    for ledid, points in configuration.items():
        curi = state[ledid]["index"]
        nexti = curi + 1
        if len(points) <= nexti:
            nexti = 0
        timeoff = time.monotonic_ns() - state[ledid]["start"]
        while timeoff > points[curi]["ns"]:
            timeoff -= points[curi]["ns"]
            curi = nexti
            nexti += 1
            if len(points) <= nexti:
                nexti = 0
        red, green, blue = interpolate(points[curi], points[nexti], timeoff)
        backend.update(ledid, red, green, blue)
    backend.apply()


def parse_arguments():
    """Parse script arguments"""
    parser = argparse.ArgumentParser(
        description="Rainbow Animator. Helper for platforms that do not correctly support pattern trigger on LEDs."
    )
    parser.add_argument("--ups", "-u", default=15, help="Set number of updates per-second.")
    return parser.parse_args()


def main():
    args = parse_arguments()
    reload()  # Load the first configuration
    signal.signal(signal.SIGUSR1, lambda s, f: pause())
    signal.signal(signal.SIGUSR2, lambda s, f: reload())
    nano = math.pow(10, 9)
    frame = nano / args.ups
    while True:
        if not is_paused and configuration:
            stime = time.monotonic_ns()
            signal.pthread_sigmask(signal.SIG_BLOCK, [signal.SIGUSR1, signal.SIGUSR2])
            update()
            signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGUSR1, signal.SIGUSR2])
            rtime = time.monotonic_ns() - stime
            if rtime < frame:
                time.sleep((frame - rtime) / nano)  # sleep for rest of the frame
        else:
            sig = signal.sigwait([signal.SIGUSR1, signal.SIGUSR2])
            if sig == signal.SIGUSR1:
                pause()
            elif sig == signal.SIGUSR2:
                reload()


if __name__ == "__main__":
    sys.exit(main())
