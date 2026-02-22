
show_help() {
  cat <<EOF
Usage: ./install.sh [OPTIONS]

Options:
  -d, --dry-run      Simulate installation without making changes
  -v, --verbose      Show detailed output
  -h, --help         Show this help message

Examples:
  ./install.sh --dry-run
  ./install.sh --verbose
  ./install.sh --dry-run --verbose
EOF
}
