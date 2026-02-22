install_package_group(){
  local group_name="$1"
  local -n group_packages="$2"

  (( ${#group_packages[@]} == 0 )) && return 0

  print_header "Installing $group_name Packages"

  for package in "${group_packages[@]}"; do
    install_package "$package"
  done
}
