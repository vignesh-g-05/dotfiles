LOADING_PID=
LOG_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-installer/logs"
LOG_FILE="$LOG_DIR/installer-$(date +'%Y-%m-%d_%H-%M-%S').log"
LOG_ENABLED=true

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

printf "\n========== Dotfiles Installer ==========\n" >> "$LOG_FILE"
printf "Started at: %s\n" "$(date)" >> "$LOG_FILE"
printf "User: %s\n" "$USER" >> "$LOG_FILE"
printf '%s\n\n' "----------------------------------------" >> "$LOG_FILE"


frames=(
  "◜" "◠" "◝" "◞" "◡" "◟"
)

_write_log() {
  local level="$1"
  local message="$2"

  [[ "$LOG_ENABLED" == true ]] || return

  printf "[%s] [%s] %s\n" \
    "$(date +'%Y-%m-%d %H:%M:%S')" \
    "$level" \
    "$message" >> "$LOG_FILE"
}


run_command() {
  if [[ "$VERBOSE" == true ]]; then
    "$@" 2>&1 | tee -a "$LOG_FILE"
  else
    "$@" >> "$LOG_FILE" 2>&1
  fi
}

loading_spinner() {
  local msg="$1"
  while :; do
    for char in "${frames[@]}"; do
      printf "\r${CYAN}%s${RESET}  › ${BOLD}%s${RESET}" "$char" "$msg"
      sleep 0.08
    done
  done
}

stop_loading() {
  [ -n "$LOADING_PID" ] || return
  kill "$LOADING_PID" 2>/dev/null
  wait "$LOADING_PID" 2>/dev/null
  LOADING_PID=
  printf "\r\033[K"
  tput cnorm 2>/dev/null
}

log_loading() {
  stop_loading
  tput civis 2>/dev/null
  loading_spinner "$1" &
  LOADING_PID=$!
}

log_prompt() {
  printf "${BOLD} [?] › %s" "$1"
}

log_info() {
  stop_loading
  printf "${BLUE}${BOLD} [i] › %s${RESET}\n" "$1"
  _write_log "INFO" "$1"
}

log_warn() {
  stop_loading
  printf "${YELLOW}${BOLD} [⚠] › %s${RESET}\n" "$1"
  _write_log "WARN" "$1"
}

log_error() {
  stop_loading
  printf "${RED}${BOLD} [x] › %s${RESET}\n" "$1"
  _write_log "ERROR" "$1"
}

log_success() {
  stop_loading
  printf "${GREEN}${BOLD} [✔] › %s${RESET}\n" "$1"
  _write_log "SUCCESS" "$1"
}

cleanup() {
  stop_loading
  tput cnorm 2>/dev/null
}

log_info "Installation started."
log_info "Logs: $LOG_FILE"

trap 'echo -e "\n[ERROR] Installer failed at line $LINENO" >> "$LOG_FILE"' ERR
trap 'cleanup' EXIT
trap 'cleanup; exit 130' INT TERM
