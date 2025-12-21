#!/usr/bin/env bash

options="|󰷛|󰜉|󰒲|󰍃"

response=$(printf '%s\n' "$options" | rofi -sep '|' -dmenu -theme '~/.config/rofi/themes/power-menu.rasi')

case "$response" in
	"")
		systemctl poweroff
		;;
	"󰷛")
		loginctl lock-session
		;;
	"󰜉")
		systemctl reboot
		;;
	"󰒲")
		systemctl suspend
		;;
	"󰍃")
		hyprctl dispatch exit
		;;
esac
