#!/usr/bin/env bash

set -u -o pipefail

# Colored log messages
info()    { printf "\e[34m[INFO] %s\e[0m\n" "$1"; }
warn()    { printf "\e[33m[WARN] %s\e[0m\n" "$1"; }
error()   { printf "\e[31m[ERROR] %s\e[0m\n" "$1"; }
success() { printf "\e[32m[SUCCESS] %s\e[0m\n" "$1"; }

