
#!/usr/bin/env bash

BATTERY_PATH="/sys/class/power_supply/BAT0/capacity"
STATE_DIR="$HOME/.local/state/battery"
STATE_FILE="$STATE_DIR/next_alert"

DEFAULT_ALERT=20
ALERT_STEP=5
MIN_ALERT=3

mkdir -p "$STATE_DIR"

current_battery_pct=$(< "$BATTERY_PATH")

# initialize state if missing
if [[ ! -f "$STATE_FILE" ]]; then
  echo "$DEFAULT_ALERT" > "$STATE_FILE"
fi

next_alert_pct=$(< "$STATE_FILE")

if (( current_battery_pct <= next_alert_pct )); then
  notify-send -i ~/.config/shared/icons/battery-caution.svg -u critical "Battery low" "Battery at ${current_battery_pct}%"

  # calculate next alert
  if (( next_alert_pct > MIN_ALERT )); then
    echo $(( next_alert_pct - ALERT_STEP )) > "$STATE_FILE"
  else
    echo "$MIN_ALERT" > "$STATE_FILE"
  fi
else
  # reset when battery recovers
  if (( current_battery_pct > DEFAULT_ALERT )); then
    echo "$DEFAULT_ALERT" > "$STATE_FILE"
  fi
fi
