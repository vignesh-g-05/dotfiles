import os
from pathlib import Path
import sys
import tomllib
from typing import Final

if len(sys.argv) < 2:
    file_name = os.path.basename(__file__)
    print(f"usage: ./{file_name} <colors.toml>", file=sys.stderr)
    sys.exit(1)

"""
GLOBALS
"""
INPUT_TOML_FILE: Final = sys.argv[1]
BUILD_DIR: Path = Path.home() / ".config/themes/build"
CSS_FILE: Final = f"{BUILD_DIR}/css/colors.css"
ROFI_CONF_FILE: Final = f"{BUILD_DIR}/rofi/colors.conf"
HYPR_CONF_FILE: Final = f"{BUILD_DIR}/hypr/colors.conf"
ORBIT_TOML_FILE: Final = f"{BUILD_DIR}/orbit/colors.toml"

COLOR_KEYS: Final = [
    "background",
    "surface",
    "foreground",
    "accent",
    "accent_hover",
    "accent_foreground",
    "success",
    "warning",
    "error",
]

"""
UTILITIES
"""


def load_colors() -> dict[str, str]:
    with open(INPUT_TOML_FILE, "rb") as f:
        data = tomllib.load(f)
    colors = data.get("colors")
    if colors is None:
        print("Error: missing 'colors' section in toml", file=sys.stderr)
        sys.exit(1)
    return colors


def validate_colors(colors: dict[str, str]) -> None:
    for key in COLOR_KEYS:
        if key not in colors:
            print(f"Error: missing '{key}'", file=sys.stderr)
            sys.exit(1)


def to_css_key(key: str) -> str:
    return key.replace("_", "-")


def hex_to_rgb(hex_color: str) -> str:
    return hex_color.replace("#", "")


def ensure_dir(path: str) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)


def write_file(path: str, content: str) -> None:
    ensure_dir(path)
    with open(path, "w") as f:
        f.write(content)


"""
FILE CREATORS
"""


def generate_css(colors: dict[str, str]) -> None:
    lines: list[str] = []
    for key in COLOR_KEYS:
        css_key = to_css_key(key)
        lines.append(f"@define-color {css_key} {colors[key]};")
    content = "\n".join(lines) + "\n"
    write_file(CSS_FILE, content)


def generate_hypr_conf(colors: dict[str, str]) -> None:
    lines: list[str] = []
    for key in COLOR_KEYS:
        hex_value = hex_to_rgb(colors[key])
        lines.append(f"${key}= rgb({hex_value})")
        if key == "background":
            lines.append(f"${key}_50= rgba({hex_value}99)")
    content = "\n".join(lines) + "\n"
    write_file(HYPR_CONF_FILE, content)


def generate_rofi_conf(colors: dict[str, str]) -> None:
    lines: list[str] = []
    for key in COLOR_KEYS:
        css_key = to_css_key(key)
        lines.append(f"{css_key}: {colors[key]};")
    content = "* {\n" + "\n".join(lines) + "\n}"
    write_file(ROFI_CONF_FILE, content)


def generate_orbit_toml(colors: dict[str, str]) -> None:
    lines: list[str] = []

    accent = colors["accent"]
    accent_foreground = colors["accent_foreground"]
    background = colors["background"]
    foreground = colors["foreground"]

    lines.append(f'accent_primary = "{accent}"')
    lines.append(f'accent_secondary = "{accent}"')
    lines.append(f'accent_primary_foreground = "{accent_foreground}"')
    lines.append(f'background = "{background}"')
    lines.append(f'foreground = "{foreground}"')

    content = "\n".join(lines) + "\n"

    write_file(ORBIT_TOML_FILE, content)


"""
MAIN
"""


def main():
    colors = load_colors()
    validate_colors(colors)
    generate_css(colors)
    generate_hypr_conf(colors)
    generate_rofi_conf(colors)
    generate_orbit_toml(colors)


if __name__ == "__main__":
    main()
