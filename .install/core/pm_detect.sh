detect_package_manager() {
  if command -v pacman >/dev/null 2>&1; then
    PKG_MANAGER="pacman"
    PKG_INSTALL_CMD=(sudo pacman -S --noconfirm)
    PKG_UPDATE_CMD=(sudo pacman -Syu)
    PKG_INFO_CMD=(pacman -Si)

  elif command -v dnf >/dev/null 2>&1; then
    PKG_MANAGER="dnf"
    PKG_INSTALL_CMD=(sudo dnf install -y)
    PKG_UPDATE_CMD=(sudo dnf makecache)
    PKG_INFO_CMD=(dnf info)

  elif command -v apt >/dev/null 2>&1; then
    PKG_MANAGER="apt"
    PKG_INSTALL_CMD=(sudo apt install -y)
    PKG_UPDATE_CMD=(sudo apt update)
    PKG_INFO_CMD=(apt show)

  else
    return 1
  fi
  return 0
}
