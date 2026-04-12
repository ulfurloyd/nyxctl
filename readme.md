# nyxctl

`nyxctl` is a lightweight CLI wrapper around `chezmoi` for managing and
applying my dotfiles in a reproducible and streamlined way.

It simplifies common workflows like initialization, applying changes, and
diagnostics, while remaining minimal and composable.

## Features
- Simple command interface for `chezmoi`
- Config-driven repository setup
- Safe initialization (prevents accidental re-init)
- Dry-run support for safety
- Built-in diagnostics

## Installation
Clone the repository and make the script executable:

```bash
git clone https://github.com/ulfurloyd/nyxctl.git
cd nyxctl
chmod +x nyxctl
```

Optionally, move it into your PATH:
```bash
mv nyxctl ~/.local/bin
```

## Configuration
Create a config file at:
`~/.config/nyxctl/config.yaml`

Example:
```
repo: git@github.com:yourname/dotfiles.git
branch: main
```

## Usage
### Initialize
`nyxctl init`

Initializes `chezmoi` using the configured repository.

### Apply dotfiles
`nyxctl apply`

Apply all managed dotfiles.

#### Dry run
`nyxctl apply --dry-run`

Preview changes without applying them.

#### Show differences
`nyxctl diff`

Display pending changes.

#### Diagnostics
`nyxctl doctor`

Check dependencies and environment state.

### Requirements
- `chezmoi`
- `git`
- `yq`

### License
MIT

