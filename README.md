# Dotfiles (chezmoi)

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

The repository lives at `git.beckesch.it:beckesch/dotfiles.git` and is kept locally
under `~/.local/share/chezmoi`.

## Quick start (new machine)

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply git@git.beckesch.it:beckesch/dotfiles.git
```

Alternatively, use the `setup.sh` script in this repository, which installs chezmoi
and applies the dotfiles if that hasn't happened yet. The `setup.sh` is intended to be used as `devpod` quick setup.

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
| `dot_bashrc.d/applications/` | Application-specific aliases and additions, loaded by `150-applications.sh` (cd, chezmoi, containerlab, date, devpod, grep, kubernetes, ls/lsd, mkdir, ssh, starship, sudo, vi/nvim) |
| `dot_config/` | Config files under `~/.config/` (e.g. symlink to `starship.toml`) |
| `empty_dot_bash_aliases` | Empty `~/.bash_aliases` file (placeholder) |
| `setup.sh` | Bootstrap script: installs chezmoi and applies the repository |

### bashrc snippet load order

The numbered files in `dot_bashrc.d/` are sourced in this order:

1. `000-bash-setup-generic.sh` – basic shell setup
2. `010-bash-account-specific.sh` – account-/machine-specific settings
3. `100-generic-aliases.sh` – general aliases
4. `150-applications.sh` – loads all snippets in `applications/`
5. `200-networking.sh` – networking aliases and helpers
6. `300-shell-safety-nets.sh` – safety nets (e.g. safer aliases)

Files with a suffix not equal to `.sh` (e.g. `mybashrc.sh-off`) are intentionally not loaded.

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

The file `~/.BASHRC_DEBUG` controls the debug output of `~/.bashrc`:
If it exists, its content is set as the debug level and messages are printed while
the snippets are loaded (see `debug()` in `dot_bashrc`).
