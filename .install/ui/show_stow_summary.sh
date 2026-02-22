show_stow_summary() {
  local stow_success_text="Stowed"
  local success_count

  if $DRY_RUN; then
    stow_success_text="Would Stow"
    success_count=${#WOULD_STOW_PACKAGES[@]}
    else
      success_count=${#STOWED_PACKAGES[@]}
  fi

  print_header "Stow Summary"

  printf "${CYAN}${HORIZONTAL_LINE_OPEN}\n"
  print_line

  print_kv_color "$stow_success_text" "$success_count" "$GREEN"

  if (( ${#CONFLICTING_PACKAGES[@]} > 0 )); then
    print_kv_color "Conflicting" "${#CONFLICTING_PACKAGES[@]}" "$RED"
      print_list "CONFLICTING PACKAGES" "${CONFLICTING_PACKAGES[@]}"
      print_line
      print_kv "Action" "Backup conflicting configs and retry"
  fi

  print_line
  printf "${BOLD}${CYAN}${HORIZONTAL_LINE_CLOSE}${RESET}\n"
}
