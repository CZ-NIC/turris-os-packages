class Backend:
    """Handler for all leds we can control."""

    def update(self, ledid: int, red: int, green: int, blue: int) -> None:
        """Update color of led on given index."""
        # TODO

    def apply(self) -> None:
        """Apply previous LEDs state updates if that is required."""
        # TODO

    def handled(self, ledid: int) -> bool:
        """Informs animator if led animation for led on given index should be handled by it."""
        return False  # TODO
