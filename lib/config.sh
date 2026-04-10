require_cmd yq

CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/nyxctl/config.yaml"

get_config() {
    yq -r "$1" "$CONFIG_FILE"
}
