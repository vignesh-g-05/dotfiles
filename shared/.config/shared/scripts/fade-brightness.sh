#!/usr/bin/env bash
# Smooth brightness fade (up or down)
# Usage: fade-brightness.sh 0%   | fade-brightness.sh 20%

TARGET="${1:?Missing target brightness (e.g. 0% or 20%)}"

STEP=2        # % per step (smaller = smoother)
DELAY=0.015   # seconds between steps

# Get current brightness in %
CURRENT=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')
TARGET_VAL=$(echo "$TARGET" | tr -d '%')

# Sanity check
if ! [[ "$TARGET_VAL" =~ ^[0-9]+$ ]]; then
    echo "Invalid brightness value"
    exit 1
fi

# No-op if already there
if (( CURRENT == TARGET_VAL )); then
    exit 0
fi

# Fade direction
if (( CURRENT > TARGET_VAL )); then
    # Fade down
    for (( b=CURRENT; b>=TARGET_VAL; b-=STEP )); do
        brightnessctl -s set "${b}%"
        sleep "$DELAY"
    done
else
    # Fade up
    for (( b=CURRENT; b<=TARGET_VAL; b+=STEP )); do
        brightnessctl -s set "${b}%"
        sleep "$DELAY"
    done
fi

# Ensure exact final value
brightnessctl -s set "${TARGET_VAL}%"
