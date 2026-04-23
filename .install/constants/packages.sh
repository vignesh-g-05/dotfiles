CORE_PACKAGES=(
    git
    curl
    unzip
    cargo
)

OPTIONAL_PACKAGES=(
    fastfetch
    bat
    starship
)

WORKSPACE_PACKAGES=(
    zsh
    neovim
)

CARGO_PACKAGES=(
    eza
)

declare -A CURL_PACKAGES_MAP=(
    [atuin]="curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --non-interactive"
    [nvm]="curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash"
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
    themes
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
