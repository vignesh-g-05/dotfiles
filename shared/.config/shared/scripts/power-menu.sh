
#!/usr/bin/env bash
 
options="|󰷛|󰜉|󰒲|󰍃"
 
response=$(printf '%s\n' "$options" | rofi -sep '|' -dmenu \
    -theme '~/.config/rofi/themes/power-menu.rasi')
 
case "$response" in
    "")
        systemctl poweroff
        ;;
    "󰷛")
        hyprlock
        ;;
    "󰜉")
        systemctl reboot
        ;;
    "󰒲")
        # Smoothly fade screen to black
        ~/.config/shared/scripts/fade-brightness.sh 0%
 
        # Prevent any visual flash
        hyprctl dispatch dpms off
 
        # Start hyprlock BEFORE suspend
        hyprlock &
 
        # Wait until hyprlock is actually running
        while ! pgrep -x hyprlock >/dev/null; do
            sleep 0.05
        done
 
        # Small safety delay
        sleep 0.2
 
        # Suspend only after lock is ready
        systemctl suspend
        ;;
    "󰍃")
        hyprctl dispatch exit
        ;;
esac
