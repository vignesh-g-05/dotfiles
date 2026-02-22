generate_horizontal_line() {
  local width="${1:-60}"
  local line=""

  for ((i=0; i<width; i++)); do
    line+="─"
  done

  printf "%s" "$line"
}

print_frame_open() {
    printf "%s%s%s" "┌" "$(generate_horizontal_line)" "┐"
}

print_frame_close() {
    printf "%s%s%s" "└" "$(generate_horizontal_line)" "┘"
}

print_header() {
  local title="$1"
  local width="${2:-60}"

  printf "${CYAN}%s${RESET}\n" "$(print_frame_open "$width")"
  printf "${CYAN}│ ${BOLD}%s${RESET}\n" "$title"
  printf "${CYAN}%s${RESET}\n" "$(print_frame_close "$width")"
}

print_line() {
    printf "${CYAN}${VERTICAL_LINE}\n"
}

print_kv() {
    local key="$1"
    local value="$2"
    printf "${CYAN}${VERTICAL_LINE} %-28s : ${RESET}%s\n" "$key" "$value"
}

print_kv_color() {
    local key="$1"
    local value="$2"
    local color="$3"
    printf "${CYAN}${VERTICAL_LINE} %-28s : ${color}%d${RESET}\n" "$key" "$value"
}

print_list() {
    local title="$1"
    shift
    local items=("$@")

    print_line
    printf "${CYAN}${VERTICAL_LINE} %-28s\n" "$title"
    for item in "${items[@]}"; do
        printf "${CYAN}${VERTICAL_LINE}   ➜ %s\n" "$item"
    done
}

