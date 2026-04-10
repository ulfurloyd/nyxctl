require_cmd() {
    command -v "$1" >/dev/null 2>&1 || {
        log_error "Missing dependency: $1"
        exit 1
    }
}
