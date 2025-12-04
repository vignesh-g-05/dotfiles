#!/usr/bin/env bash

H=$(date +%H)
M=$(date +%M)
S=$(date +%S)

h=${H#0}; [ -z "$h" ] && h=0
m=${M#0}; [ -z "$m" ] && m=0

minute_of_12h=$(( (h % 12) * 60 + m ))

# Nerd Font 12-hour clock icons
CLOCK_ICONS=(
    "󱑊" # 12
    "󱐿" # 1
    "󱑀" # 2
    "󱑁" # 3
    "󱑂" # 4
    "󱑃" # 5
    "󱑄" # 6
    "󱑅" # 7
    "󱑆" # 8
    "󱑇" # 9
    "󱑈" # 10
    "󱑉" # 11
)

index=$(( h % 12 ))  # position for hour
icon="${CLOCK_ICONS[$index]}"
text="$(( h % 12 )):${M}"
tooltip="$((h % 12)):${M}:${S}"

if (( h % 12 < 10 )); then
    tooltip="0${tooltip}"
    text="0${text}"
fi


printf '{"text":"%s","tooltip":"%s"}\n' "${icon} ${text}" "$tooltip"
