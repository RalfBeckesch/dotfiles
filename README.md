# Dotfiles (chezmoi)

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

The repository lives at `git@github.com:RalfBeckesch/dotfiles.git`
(public: `https://github.com/RalfBeckesch/dotfiles.git`)
and is kept locally under `~/.local/share/chezmoi`.

## Quick start (new machine)
### Install script from chezmoi.io

```sh
# ssh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply git@github.com:RalfBeckesch/dotfiles.git
```

```sh
# https
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply https://github.com/RalfBeckesch/dotfiles.git
```

### Install with your distros or cross-platform package manager first...
...then initialize chezmoi with the repository

```
chezmoi init git@github.com:RalfBeckesch/dotfiles.git
```

### Autosetup the files inside your devpods

The `setup.sh` is intended to be used as `devpod` quick setup.

### Use your distros package manager
```
# Alpine
apk add chezmoi

# Arch
pacman -S chezmoi

# Debian
apt-get install chezmoi

# Fedora
dnf install chezmoi

# NixOS
nix-env -i chezmoi

# openSUSE Tumbleweed
zypper install chezmoi

# RHEL (EPEL)
dnf install epel-release && dnf install chezmoi

# Termux
pkg install chezmoi

# Void
xbps-install -S chezmoi
```

### Cross-platform package managers
```
# am
am -i chezmoi

# asdf
asdf plugin add chezmoi && asdf install chezmoi 2.72.2

# mise
mise use --global chezmoi@2.72.2

# Homebrew
brew install chezmoi

# Nix
nix-env -i chezmoi

# Snap
snap install chezmoi --classic
```

## Structure

| Path | Description |
| --- | --- |
| `dot_bashrc` | Entry point for `~/.bashrc`; loads all snippets from `~/.bashrc.d` (interactive shells only) |
| `dot_bashrc.d/` | Modular bash config snippets, loaded in alphabetical/numeric order |
| `dot_bashrc.d/applications/` | Application-specific aliases and additions, loaded by `150-applications.sh` (cd, chezmoi, containerlab, date, devpod, grep, homebrew, kubernetes, ls/lsd, mkdir, ssh-agent, ssh-completion, starship, sudo, synthing, vi/nvim) |
| `dot_config/` | Config files under `~/.config/` (e.g. `starship.toml`) |
| `empty_dot_bash_aliases` | Empty `~/.bash_aliases` file (placeholder) |
| `setup.sh` | Bootstrap script for `devpod` usage: installs chezmoi and applies the repository |

### bashrc snippet load order

The numbered files in `dot_bashrc.d/` are sourced in this order:

1. `000-bash-setup-generic.sh` – basic shell setup
2. `100-generic-aliases.sh` – general aliases
3. `150-applications.sh` – loads all `*.sh` snippets in `applications/`
4. `200-networking.sh` – networking aliases and helpers
5. `300-shell-safety-nets.sh` – safety nets (e.g. safer aliases)
6. `400-path.sh` – `$PATH` additions
7. `900-bash-account-specific.sh` – user-specific hook (see `~/.bashrc_for_this_user` below)

Files with a suffix not equal to `.sh` (e.g. `mybashrc.sh-off`) are intentionally not loaded.

### Application snippets (`dot_bashrc.d/applications/`)

| Snippet | Purpose |
| --- | --- |
| `cd.sh` | `cd` helpers/aliases |
| `chezmoi.sh` | chezmoi convenience aliases |
| `containerlab.sh` | containerlab aliases |
| `date-aliases.sh` | date-related aliases |
| `devpod.sh` | devpod aliases/helpers |
| `grep-color.sh` | colored grep output |
| `homebrew.sh` | Homebrew environment setup |
| `kubernetes.sh` | kubectl aliases/completions |
| `ls+lsd.sh` | `ls` via `lsd` where available |
| `mkdir.sh` | `mkdir` helpers |
| `ssh-agent.sh` | ssh-agent setup |
| `ssh-completion.sh` | ssh host completion |
| `starship.sh` | Starship prompt initialization |
| `sudo-prefix.sh` | sudo prefix helpers |
| `synthing.sh` | synthing aliases |
| `vi.sh` | vi/nvim aliases |

## Common workflows

```sh
# Bring a file from your home directory into the repo
chezmoi add ~/.bashrc.d/my-snippet.sh

# Update and apply the dotfiles
chezmoi update

# Show the diff between the repo and the actual home directory
chezmoi diff

# Sync on another machine
chezmoi cd   # opens the source directory; then git pull/push as usual
```

## Debugging the bashrc

The file `~/.bashrc_debug` controls the debug output of `~/.bashrc`:
If it exists and its content is non-empty, debug messages are printed to stderr while the snippets are loaded
(see `debug()` in `dot_bashrc`).

```sh
# Enable debug output
echo 1 > ~/.bashrc_debug

# Disable debug output (empty file)
rm ~/.bashrc_debug
```

## User-specific scripts (`~/.bashrc_for_this_user`)

The snippet `900-bash-account-specific.sh` (loaded last) sources the file
`~/.bashrc_for_this_user`, if it exists. Use it for local, user- or
machine-specific settings that should not be committed to the repository, e.g.:

```sh
# ~/.bashrc_for_this_user
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
```

Since this file is not managed by chezmoi, it survives dotfile updates and stays
private to the machine/account it was created for.
