GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"

RESET="\e[0m"

BOLD="\e[1m"
INDENT="    "

VERTICAL_LINE="│${INDENT}${RESET}${BOLD}"

HORIZONTAL_LINE_OPEN="┌────────────────────────────────────────────────────────────┐"

HORIZONTAL_LINE_CLOSE="└────────────────────────────────────────────────────────────┘"

if [[ ! -t 1 ]]; then
  GREEN=""
  RED=""
  YELLOW=""
  BLUE=""
  CYAN=""
  BOLD=""
  RESET=""
fi
