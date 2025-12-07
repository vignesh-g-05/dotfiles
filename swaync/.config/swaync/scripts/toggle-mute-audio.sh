#!/usr/bin/env bash
set +e

mute_state=$(pactl get-sink-mute @DEFAULT_SINK@)
mute_state=${mute_state#Mute: }

if [[ $SWAYNC_TOGGLE_STATE == false && "$mute_state" == "yes" ]]; then
    swayosd-client --output-volume mute-toggle
elif [[ $SWAYNC_TOGGLE_STATE == true && "$mute_state" == "no" ]]; then
    swayosd-client --output-volume mute-toggle
fi

exit 0
