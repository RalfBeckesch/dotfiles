# Dotfiles (chezmoi)

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

The repository lives at `git.beckesch.it:beckesch/dotfiles.git` and is kept locally
under `~/.local/share/chezmoi`.

## Quick start (new machine)

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply git@git.beckesch.it:beckesch/dotfiles.git
```

Alternatively, use the `setup.sh` script in this repository, which installs chezmoi
and applies the dotfiles if that hasn't happened yet.

## Structure

| Path | Description |
| --- | --- |
| `dot_bashrc` | Entry point for `~/.bashrc`; loads all snippets from `~/.bashrc.d` (interactive shells only) |
| `dot_bashrc.d/` | Modular bash config snippets, loaded in alphabetical/numeric order |
| `dot_bashrc.d/applications/` | Application-specific aliases and additions (e.g. chezmoi, kubernetes, devpod, containerlab, starship, ssh, lsd) |
| `dot_config/` | Config files under `~/.config/` (e.g. symlink to `starship.toml`) |
| `empty_dot_bash_aliases` | Empty `~/.bash_aliases` file (placeholder) |
| `setup.sh` | Bootstrap script: installs chezmoi and applies the repository |

### bashrc snippet load order

The numbered files in `dot_bashrc.d/` are sourced in this order:

1. `000-bash-setup-generic.sh` – basic shell setup
2. `010-bash-account-specific.sh` – account-/machine-specific settings
3. `100-generic-aliases.sh` / `100-applications.sh` – general aliases, loads the snippets in `applications/`
4. `200-networking.sh` – networking aliases and helpers
5. `300-shell-safety-nets.sh` – safety nets (e.g. safer aliases)

Files with a `.sh-off` suffix (e.g. `mybashrc.sh-off`) are intentionally not loaded.

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
