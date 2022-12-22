#!/bin/sh
set -eu

if command -v tput > /dev/null; then
    YELLOW="$(tput setaf 3)"
    RESET="$(tput sgr0)"
else
    YELLOW=""
    RESET=""
fi

run() {
    echo "${YELLOW}\$ $@${RESET}"
    "$@"
    echo
}

SWITCH="$(basename $0)"
export HOME="$(mktemp -d)"
trap 'rm -rf -- "$HOME"' EXIT

run opam init --no-setup --compiler="$SWITCH"
run opam install -y merlin ocp-indent utop
