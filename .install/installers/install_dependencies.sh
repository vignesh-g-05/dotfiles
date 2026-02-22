install_dependencies () {
  ! [[ $DRY_RUN ]] && "${PKG_UPDATE_CMD[@]}"
  install_package_group "Core" CORE_PACKAGES
  install_package_group "Workspace" WORKSPACE_PACKAGES
  install_package_group "Optional" OPTIONAL_PACKAGES

  install_cargo_packages
  install_curl_packages
}
