detect_hostname() {
    hostname 
}

detect_profile() {
    local host
    host=$(detect_hostname)

    yq -r ".profiles | to_entries[] | select(.value.hostname == \"$host\") | .key" "$CONFIG_FILE"
}

