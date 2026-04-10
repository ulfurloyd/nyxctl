CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/nyxctl/config.yaml"

get_config() {
    require_cmd yq

    yq -r "$1" "$CONFIG_FILE"
}
