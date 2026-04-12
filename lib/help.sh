#!/usr/bin/env bash

is_help_flag() {
	[[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]
}

show_help() {
	cat <<EOF
nyxctl — manage dotfiles with chezmoi

Usage:
  nyxctl <command> [options]

Commands:
  init        Initialize chezmoi with configured repo
  apply       Apply dotfiles
  diff        Show differences
  doctor      Run diagnostics

Options:
  -h, --help  Show this help message

Config:
  ${CONFIG_FILE:-~/.config/nyxctl/config.yaml}
EOF
}

show_init_help() {
	cat <<EOF
Usage: nyxctl init

Initializes chezmoi using the configured repository.

Requirements:
  - repo must be defined in config
  - chezmoi and git must be installed
EOF
}

show_apply_help() {
	cat <<EOF
Usage: nyxctl apply [options]

Apply dotfiles using chezmoi.

Options:
  -n, --dry-run   Show what would change without applying
  -h, --help      Show this help message

Examples:
  nyxctl apply
  nyxctl apply --dry-run
EOF
}
