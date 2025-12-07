#!/usr/bin/env bash
set +e

mute_state=$(pactl get-source-mute @DEFAULT_SOURCE@)
mute_state=${mute_state#Mute: }

if [[ $SWAYNC_TOGGLE_STATE == false && "$mute_state" == "yes" ]]; then
    swayosd-client --input-volume mute-toggle
elif [[ $SWAYNC_TOGGLE_STATE == true && "$mute_state" == "no" ]]; then
    swayosd-client --input-volume mute-toggle
fi

exit 0
