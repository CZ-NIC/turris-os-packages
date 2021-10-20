# Backend for generic rainbow script EXAMPLE

# This variable has to be always defined with full list of LED names. It is
# prefered to use self-describing but short names for those LEDs. It is prefered
# that those names match with labeling on the box.
LEDS="pwr lan0 lan1 lan2 wan"

# This function is required only if leds are kontrolled by kernel driver and
# kernel managed triggers are available. When this function is defined and
# successfully provides path to sysfs for specified LED then it unlocks
# activity triggers for it.
led2sysfs() {
	local led="$1" # one of leds from LEDS variable
	false
}

# Allows modification of defaults for specific leds (it is called with 'all' as
# well).
# It is called in environment where following variables are defined and
# available for modification:
# color_r: red color
# color_g: green color
# color_b: blue color
# mode: rainbow mode for the LED
# mode_args: additional arguments for the mode
led_defaults() {
	local led="$1"
	false
}

# This function is optional and is required only for button_sync.sh.
# It is really needed only if there is a hardware way to modify brightness.
# It is expected to echo the current brightness level as integer between 0 and
# 255.
get_brightness() {
	false
}

# The optional function that is called before application of state using
# set_led. This should be used to prepare environment as well as to pause
# animator for example.
preapply() {
	false
}

# This function has to be defined in every backend. It is a core component of
# rainbow functionality. This applies configuration to one specific LED.
# It gets LED name, color as RGB components, mode and mode's arguments.
set_led() {
	local led="$1" r="$2" g="$3" b="$4" mode="$5"
	shift 5
	false
}

# The optional function that is called after set_led was called for every led
# and thus state of them is set. This should be used to do cleanup and to resume
# animator for example.
postapply() {
	false
}


# Perform boot sequence specific for this device.
# This function is only optional and does not have to be defined if there is no
# boot sequence.
boot_sequence() {
	false
	# Note: The current state is always applied in the end in when this function
	# is called so we don't have to restore previous state here.
}


# Parse operations that were previously available with rainbow.
# This adds option to correctly replace previous rainbow command without being
# stuck with its argument parsing.
# This is for backward compatibility and you want to remove this function for
# new platforms.
compatibility() {
	local operation="$1"; shift # Operation user specified and we try to parse here
	false
	SHIFTARGS=$# # This is required to inform called how many arguments we consumed.
}
