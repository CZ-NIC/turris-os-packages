# Rainbow

Rainbow is RGB LEDs manipulation script. It is intended for runtime changes of
color and brightness of LEDs. The permanent configuration that is used as a
bases for runtime changes is stored in UCI (it has to be used directly to modify
it).


## UCI Configuration

The primary UCI config of Rainbow is `rainbow`. At the same time this is not the
only config Rainbow honors and uses. There is also `system`. The reason for this
is because OpenWrt's native LEDs handling already supports some of the features
Rainbow implements and having configuration on multiple places results in
conflicts. Rainbow tries to resolve them by almost always preferring `system`
configuration.

The `rainbow` config is expected to contain sections of type `led` where section
name is LED name or `all` for all LEDs. The available led names can be listed
using `rainbow -l`.

The `rainbow.LED` (where `LED` is valid name of LED) sections can contain
options:

* `color`: default color of LED (the default depends on specific LED). See
  `rainbow all -h` for possible values. Note that inheritence is not supported
  in UCI configuration as there is nowhere to iherit values from.
* `mode`: default mode of LED. Continue reading for all available modes (the
  default is `auto`).

The section `all` serves as global defaults for other LEDs. It has also one
additional option `brightness`. It is an integer between 0 and 255 specifying
global LEDs brightness.

The `mode` option can have the following values:

* `auto`: the default behavior for given LED.
* `disable`: disable LED, so it simply is not used.
* `enable`: enable LED, so it always shines when router is powered on.
* `activity`: the LED should blink with specific system events (see following
  section for explanation and configuration). This is not available on all
  platforms as it depends on Kernel support!
* `animate`: performs specified animation (see the following section for
  explanation and configuration).
* `ignore`: instruct Rainbow that this LED should be ignored by it (not
  touched).

### Activity

This mode allows LED to be controlled by events happening in the system (Kernel
events). This configuration is mostly possible in UCI config `system` and thus
we allow use that as well. When trigger is configured in both configs the
`sytem` is used.

The activity is not available on all platforms due to implementation. The
notable omission are Turris 1.x routers.

The supported activity triggers (UCI config `trigger` in appropriate LED section
in `rainbow` config):

* `activity`: Flash led with system activity (faster blinking for higher
  activity). This is default if no `trigger` option is specified.
* `activity-inverted`: Blink led with system activity (same as `activity` but in
  default it LED is enabled).
* `heartbeat`: Variant on `activity` that blinks twice instead of once.
* `heartbeat-inverted`: Variant on `activity-inverted` for `heartbeat`.
* `disk-activity`: Blinks with disk activity (any disks activity is considered).
* `usbport`: Blinks with activity on any USB port.
* `netdev-NETDEV`: Blink with activity on specific network device where `NETDEV`
  is the name of that device.
* `mmcX`: Flashes when writing or reading to and from specific MMC device where
  `X` is index of that device.
* `phyX`: Blinks with activity on wireless interface where `X`is index of that
  interface.
* `ataX`: Blink when writing or reading to and from specific ATA device where
  `X` is index of that device.
* `netfilter-ID`: Flashes when firewall rule with specified `ID` is triggered.

The full list of available activities is available by invoking:
`rainbow all activity -l`.

### Animate

This allows specification of animation pattern. The simplest variant is periodic
enable and disable of LED but more complex patterns can be specified as well.

The animation is specified as set of color and time in nanoseconds pairs. The
color changes from one color to the next one in duration of specified time.

In configuration animation is specified as a list of those color and time in
nanoseconds pairs. For example the following UCI list gradually dims and
light ups green color on power led:
`rainbow.all.animation='green 1000' 'black 1000'`


## Hardware integration

This section describes how to implement hardware integration for rainbow and
what that actually means. This is here as developer documentation not expected
by end-users to read this.

The integration has to be done by implementing shell file `backend.sh` and
installed in the same directory as the rest of the rainbow. This directory in
repository contains also a commented example backend file you can use to
understand what you have to implement to get Rainbow working on a new platform.

### Button sync

Some of the boards have hardware button that allows limited LED brightness
control. We have to sync the setting to configuration so the usage of button is
not wiped after reboot or any rainbow call. This is provided by
`rainbow-button-sync` service and shell script `button_sync.sh`. The
`button_sync.sh` uses the same backend file as `rainbow.sh` and needs only one
additional function to be present there `get_brightness`. The configuration is
saved to the UCI config `rainbow`.

### Animator

The animations are designed to work well with Kernel LED pattern trigger. The
issue is that not every board has kernel driver and not only that but also not
every kernel driver allows us to control color using the trigger. To allow
animations even on such platforms we have `rainbow-animator` service that runs
`animator.py`. To make this works you have to implement `animator_backend.py`
which is simplified backend implemented in Python. You also have to pause
animator in `preapply` function in `backend.sh` with
`/etc/init.d/rainbow-animator pause` and reload it in `postapply` function with
`/etc/init.d/rainbow-animator reload`. The example animator backend file with
commends is provided in this repository.

The animator can be configured to limit number of updates which is highly
desirable to not load CPU with LED animations. In default number of updates in
seconds is set to 15. You can use UCI `rainbow.animation.ups` to set different
value if you want tweak it.

