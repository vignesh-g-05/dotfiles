CORE_PACKAGES=(
    git
    curl
    unzip
    cargo
)

OPTIONAL_PACKAGES=(
    fastfetch
    bat
)

WORKSPACE_PACKAGES=(
    stow
    zsh
    neovim
)

CARGO_PACKAGES=(
    eza
)

declare -A CURL_PACKAGES_MAP=(
    [atuin]="curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh"
    [nvm]="curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash"
    [starship]="curl -sS https://starship.rs/install.sh | sh"
)

STOW_PACKAGES=(
    atuin
    fastfetch
    flameshot
    git
    hyprland
    kitty
    nvim
    rofi
    starship
    swaync
    vscode
    waybar
    waypaper
    zsh
)

HYPRLAND_PACKAGES=(
    hyprland
    hyprlock
    hypridle
    rofi
    swaync
    swayosd
    waybar
    waypaper
)
