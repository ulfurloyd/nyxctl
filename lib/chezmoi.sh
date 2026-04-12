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

	local dry_run=false

	# Parse flags
	while [[ $# -gt 0 ]]; do
		case "$1" in
		-n | --dry-run)
			dry_run=true
			shift
			;;
		-h | --help)
			show_apply_help
			exit 0
			;;
		*)
			log_error "Unknown option for apply: $1"
			exit 1
			;;
		esac
	done

	if $dry_run; then
		log_info "Applying dotfiles (dry-run)..."
		chezmoi_run apply --dry-run
	else
		log_info "Applying dotfiles..."
		chezmoi_run apply
	fi

}

cmd_diff() {
	require_cmd "$CHEZMOI_BIN"

	log_info "Showing differences..."
	chezmoi_run diff
}

cmd_status() {
	require_cmd "$CHEZMOI_BIN"

	log_info "Showing status..."
	chezmoi_run status
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
