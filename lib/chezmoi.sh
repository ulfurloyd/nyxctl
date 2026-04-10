CHEZMOI_BIN="${CHEZMOI_BIN:-chezmoi}"

chezmoi_run() {
    "$CHEZMOI_BIN" "$@"
}

cmd_init() {
    require_cmd "$CHEZMOI_BIN"
    require_cmd git
    require_cmd yq

    local repo

    if chezmoi_run source-path >/dev/null 2>&1; then
        log_warn "chezmoi already initialized. aborting."
        exit 1
    fi

    if [[ ! -f "$CONFIG_FILE" ]]; then
        log_error "Config file not found: $CONFIG_FILE"
        exit 1
    fi

    repo=$(get_config '.repo')

    if [[ -z "$repo" || "$repo" == "null" ]]; then
        log_error "Usage: nyxctl init"
        exit 1
    fi

    log_info "Initializing chezmoi with repo: $repo"
    chezmoi_run init "$repo"
}

cmd_apply() {
    require_cmd "$CHEZMOI_BIN"

    log_info "Applying dotfiles..."
    chezmoi_run apply
}

cmd_diff() {
    require_cmd "$CHEZMOI_BIN"

    log_info "Showing differences..."
    chezmoi_run diff
}

cmd_doctor() {
    log_info "Running diagnostics..."

    require_cmd git
    require_cmd "$CHEZMOI_BIN"
    require_cmd yq

    log_info "All required dependencies are installed."

    if [[ ! -f "$CONFIG_FILE" ]]; then
        log_warn "Config file missing: $CONFIG_FILE"
    else
        log_info "Config file found"
    fi

    if chezmoi_run source-path >/dev/null 2>&1; then
        log_info "chezmoi initialized"
    else
        log_warn "chezmoi not initialized"
    fi

    if chezmoi_run doctor >/dev/null 2>&1; then
        log_info "chezmoi doctor passed"
    else
        log_warn "chezmoi doctor reported issues"
    fi
}
