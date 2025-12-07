#!/usr/bin/env bash
set +e

dnd_state=$(swaync-client -D)

if [[ $SWAYNC_TOGGLE_STATE == false && $dnd_state == true ]]; then
    swaync-client -df
elif [[ $SWAYNC_TOGGLE_STATE == true && $dnd_state == false ]]; then
    swaync-client -dn
fi

exit 0
