#!/bin/bash
# original source: https://gitlab.com/Nmoleo/i3-volume-brightness-indicator

# taken from here: https://gitlab.com/Nmoleo/i3-volume-brightness-indicator

# See README.md for usage instructions
bar_color="#7f7fff"
volume_step=1
brightness_step=2.5
max_volume=100

# Custom variables using xrandr instead of xbacklight
current_bright=$(xrandr --verbose | grep -w "Brightness" | cut -d " " -f2 | head -n1)
main_display=$(xrandr | grep -w 'connected' | head -n1 | cut -d ' ' -f1)

# Increase or decrease brightness given the current brightness
modify_brightness() {
	new_bright=$(echo $current_bright $1 0.1 | bc)
	echo $new_bright
	xrandr --output $main_display --brightness $new_bright
}

# Uses regex to get volume from pactl
function get_volume {
	pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

# Uses regex to get mute status from pactl
function get_mute {
	pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

# Uses regex to get brightness from xbacklight
function get_brightness {
	xbacklight | grep -Po '[0-9]{1,3}' | head -n 1
}

# Returns a mute icon, a volume-low icon, or a volume-high icon, depending on the volume
function get_volume_icon {
	volume=$(get_volume)
	mute=$(get_mute)
	if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ]; then
		volume_icon=""
	elif [ "$volume" -lt 50 ]; then
		volume_icon=""
	else
		volume_icon=""
	fi
}

# Always returns the same icon - I couldn't get the brightness-low icon to work with fontawesome
function get_brightness_icon {
	brightness_icon="  "
}

# Displays a volume notification using dunstify
function show_volume_notif {
	volume=$(get_mute)
	get_volume_icon
	dunstify -i audio-volume-muted-blocking -t 1000 -r 2593 -u normal "$volume_icon $volume%" -h int:value:$volume -h string:hlcolor:$bar_color
}

# Displays a brightness notification using dunstify
function show_brightness_notif {
	brightness=$(xrandr --verbose | grep -w "Brightness" | cut -d " " -f2 | head -n1)
	brightness_perc=$(echo "$brightness * 100" | bc | cut -d '.' -f1)
	get_brightness_icon
	dunstify -t 1000 -r 2593 -u normal "$brightness_icon  $brightness_perc%" -h int:value:$brightness_perc -h string:hlcolor:$bar_color
}

# Main function - Takes user input, "volume_up", "volume_down", "brightness_up", or "brightness_down"
case $1 in
volume_up)
	# Unmutes and increases volume, then displays the notification
	pactl set-sink-mute @DEFAULT_SINK@ 0
	volume=$(get_volume)
	if [ $(("$volume" + "$volume_step")) -gt $max_volume ]; then
		pactl set-sink-volume @DEFAULT_SINK@ $max_volume%
	else
		pactl set-sink-volume @DEFAULT_SINK@ +$volume_step%
	fi
	show_volume_notif
	;;

volume_down)
	# Raises volume and displays the notification
	pactl set-sink-volume @DEFAULT_SINK@ -$volume_step%
	show_volume_notif
	;;

volume_mute)
	# Toggles mute and displays the notification
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	show_volume_notif
	;;

brightness_up)
	# Increases brightness and displays the notification
	if [[ "$current_bright" != "1.0" ]]; then
		modify_brightness "+"
		show_brightness_notif
	fi
	;;

brightness_down)
	# Decreases brightness and displays the notification
	if [[ "$current_bright" != "0.20" ]]; then
		modify_brightness "-"
		show_brightness_notif
	fi
	;;
esac
