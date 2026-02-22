show_install_summary() {
    local verbose_status="No"
    local installation_mode="Install"
    local install_success_text="Installed"
    local install_failed_text="Failed"

    $VERBOSE && verbose_status="Yes"

    if $DRY_RUN; then
        installation_mode="Dry Run"
        install_success_text="Would Install"
        install_failed_text="Missing"
    fi

    print_header "Install Summary"

    printf "${CYAN}${HORIZONTAL_LINE_OPEN}\n"
    print_line

    print_kv "Mode" "$installation_mode"
    print_kv "Verbose" "$verbose_status"

    print_kv_color "$install_success_text" "${#INSTALLED_PACKAGES[@]}" "$GREEN"
    print_kv_color "Skipped" "${#SKIPPED_PACKAGES[@]}" "$YELLOW"

    if (( ${#FAILED_PACKAGES[@]} > 0 )); then
        print_kv_color "$install_failed_text" "${#FAILED_PACKAGES[@]}" "$RED"
        print_list "$install_failed_text PACKAGES" "${FAILED_PACKAGES[@]}"
    fi

    print_line
    printf "${BOLD}${CYAN}${HORIZONTAL_LINE_CLOSE}${RESET}\n"
}
