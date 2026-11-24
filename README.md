# Dotfiles (chezmoi)

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

The repository lives at `github.com/RalfBeckesch/dotfiles.git` and is kept locally
under `~/.local/share/chezmoi`.

| Protocol | URL |
|----------|-----|
| SSH | `git@github.com:RalfBeckesch/dotfiles.git` |
| HTTPS | `https://github.com/RalfBeckesch/dotfiles.git` |

## Quick start (new machine)

### Install script from chezmoi.io

```sh
# SSH
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply git@github.com:RalfBeckesch/dotfiles.git

# HTTPS (no SSH key required)
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply https://github.com/RalfBeckesch/dotfiles.git
```

### Install with your distros or cross-platform package manager

```sh
# SSH
chezmoi init git@github.com:RalfBeckesch/dotfiles.git

# HTTPS
chezmoi init https://github.com/RalfBeckesch/dotfiles.git
```

### Autosetup the files inside your devpods

Alternatively, use the `setup.sh` script in this repository, which installs chezmoi
and applies the dotfiles if that hasn't happened yet. The `setup.sh` is intended to be used as `devpod` quick setup.

see `setup.sh`

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
| `bin/` | Wrapper scripts for companion repositories (see below) |
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

## Multi-repository architecture

This public dotfiles repo is the first of three chezmoi instances that work
together but manage **disjoint** target files:

| Instance | Source directory | Git repository | Content | Protection |
|---|---|---|---|---|
| `chezmoi` | `~/.local/share/chezmoi` | `git@github.com:RalfBeckesch/dotfiles.git` | Public shell config, aliases, portable tools | None (public) |
| `chezmoi-private` | `~/.local/share/chezmoi-private` | `git.beckesch.it:rb/chezmoi-private.git` | SSH config, `~/.hermes/config.yaml`, personal settings | Repository access control |
| `chezmoi-secrets` | `~/.local/share/chezmoi-secrets` | `git.beckesch.it:rb/chezmoi-secrets.git` | API tokens, `.env` files, credentials | Repository access + age encryption |

All three instances use the same `chezmoi` binary but different source directories,
config files, and (for secrets) persistent state. They deploy into the same `$HOME`
without conflict because no target file is managed by more than one instance.

### Ownership matrix

| Target file | Managed by |
|---|---|
| `~/.bashrc`, public shell snippets | Public repo (`chezmoi`) |
| `~/.ssh/config` | Private repo (`chezmoi-private`) |
| `~/.ssh/authorized_keys` | Private repo (`chezmoi-private`) |
| `~/.hermes/config.yaml` | Private repo (`chezmoi-private`) |
| Private SSH key files | Separate provisioning (never in any repo) |
| `~/.hermes/.env` | Secrets repo (`chezmoi-secrets`) |

## Companion repositories

Two wrapper scripts in `bin/` provide dedicated command names for the companion
repositories. Each wrapper invokes `chezmoi` with the correct `--config` and
`--source` flags so every command targets the right instance.

### chezmoi-private

**Purpose:** Version-controlled private configuration that does not belong in the
public dotfiles repo — SSH config, Hermes configuration, personal scripts.

**Wrapper** (`bin/executable_chezmoi-private.sh`):

```sh
#!/bin/sh
exec chezmoi \
  --config "$HOME/.config/chezmoi-private/chezmoi.toml" \
  --source "$HOME/.local/share/chezmoi-private" \
  "$@"
```

**Bootstrap on a new machine:**

```bash
# 1. Create the directory structure
mkdir -p ~/.local/bin ~/.config/chezmoi-private ~/.local/share/chezmoi-private

# 2. Install the wrapper (this repo provides it as bin/executable_chezmoi-private.sh)
#    Copy it manually or let the public dotfiles repo deploy it:
cp /path/to/dotfiles/bin/executable_chezmoi-private.sh ~/.local/bin/chezmoi-private
chmod 755 ~/.local/bin/chezmoi-private

# 3. Create an empty local config
touch ~/.config/chezmoi-private/chezmoi.toml
chmod 600 ~/.config/chezmoi-private/chezmoi.toml

# 4. Initialize from the remote repository
chezmoi-private init git@git.beckesch.it:rb/chezmoi-private.git

# 5. Review before applying — personal config may contain host-specific values
chezmoi-private diff
chezmoi-private apply
```

**Daily workflow:**

```bash
# Add a file to the private repo
chezmoi-private add ~/.ssh/config

# Edit a managed file (chezmoi handles the source → target mapping)
chezmoi-private edit ~/.ssh/config
chezmoi-private apply

# Review pending changes
chezmoi-private status
chezmoi-private diff

# Fetch and apply remote changes
chezmoi-private update

# Git operations from the source directory
git -C ~/.local/share/chezmoi-private status
git -C ~/.local/share/chezmoi-private add --all
git -C ~/.local/share/chezmoi-private commit -m "Update private config"
git -C ~/.local/share/chezmoi-private push
```

**Host-specific template values:**

Local config `~/.config/chezmoi-private/chezmoi.toml`:

```toml
[data]
    hostRole = "workstation"
    sshIdentityFile = "~/.ssh/id_ed25519_personal"
```

Mark a managed file as a template and inject these values:

```bash
chezmoi-private chattr +template ~/.ssh/config
chezmoi-private edit ~/.ssh/config
```

Inside the template use `{{ .sshIdentityFile }}` etc. The local config stays
on each host — it is not distributed through the repository.

**Rules:**
- Always `diff` before `apply`
- A private repository is an access barrier, not encryption — do not commit
  secrets (API keys, passwords, tokens) here
- `private_` in chezmoi filenames = restrictive file permissions, not encryption
- SSH private keys and certificates are provisioned separately, never committed

---

### chezmoi-secrets

**Purpose:** Version-controlled encrypted secrets — API tokens, `.env` files,
and other credentials. File contents are encrypted with [age](https://age-encryption.org/)
at rest; the repository never sees plaintext.

**Wrapper** (`bin/executable_chezmoi-secrets.sh`):

```sh
#!/bin/sh
exec chezmoi \
  --config "$HOME/.config/chezmoi-secrets/chezmoi.toml" \
  --source "$HOME/.local/share/chezmoi-secrets" \
  --persistent-state "$HOME/.config/chezmoi-secrets/chezmoistate.boltdb" \
  "$@"
```

Note the `--persistent-state` flag — the secrets instance has its own BoltDB
state file, keeping it fully isolated from the public and private instances.

#### Security model and limitations

- In the source directory and Git repository, file contents are encrypted.
- When applied, chezmoi decrypts to the target path. Applications read plaintext.
- File names and directory structure are **not** hidden — only contents are encrypted.
- The private age key lives outside the repository (`~/.config/chezmoi-secrets/age-key.txt`).
- Anyone who obtains both the age key and the repository can decrypt everything.
- A compromised host can read secrets deployed to it; encryption in the repo
  does not change that.
- A private repository is an additional access barrier, not a substitute for encryption.
- Plaintext secrets once committed stay in Git history forever — rotate them.

#### Bootstrap on a new machine

**Step 1 — Create the directories and install the wrapper:**

```bash
mkdir -p ~/.local/bin ~/.config/chezmoi-secrets ~/.local/share/chezmoi-secrets
chmod 700 ~/.config/chezmoi-secrets ~/.local/share/chezmoi-secrets

cp /path/to/dotfiles/bin/executable_chezmoi-secrets.sh ~/.local/bin/chezmoi-secrets
chmod 755 ~/.local/bin/chezmoi-secrets
```

**Step 2 — Generate an age keypair (first host only):**

```bash
(
  umask 077
  chezmoi-secrets age-keygen --output="$HOME/.config/chezmoi-secrets/age-key.txt"
)
chmod 600 "$HOME/.config/chezmoi-secrets/age-key.txt"
```

The command prints the public key (`age1...`). Copy it — you will need it
for the config. **Back up `age-key.txt` separately** (password manager,
encrypted offline backup). Without it, encrypted files in the repository
are unrecoverable.

**Step 3 — Create the local config:**

```bash
touch ~/.config/chezmoi-secrets/chezmoi.toml
chmod 600 ~/.config/chezmoi-secrets/chezmoi.toml
```

**Step 4 — Configure encryption:**

```toml
# ~/.config/chezmoi-secrets/chezmoi.toml
encryption = "age"
useBuiltinAge = true

[add]
    encrypt = true

[age]
    identity = "~/.config/chezmoi-secrets/age-key.txt"
    recipient = "age1_YOUR_PUBLIC_KEY"
```

`add.encrypt = true` is a helpful default but not a policy — manually written
files in the source directory are not automatically encrypted. Always verify
before committing.

**Step 5 — Initialize the repository and apply:**

```bash
chezmoi-secrets init git@git.beckesch.it:rb/chezmoi-secrets.git
chezmoi-secrets diff    # verify before applying
chezmoi-secrets apply
```

#### Adding a secret

```bash
# Add an existing .env file
chezmoi-secrets add --encrypt ~/.hermes/.env

# Optionally set restrictive permissions explicitly
chezmoi-secrets chattr +private ~/.hermes/.env
```

Verify the source file is actually encrypted:

```bash
chezmoi-secrets status
git -C ~/.local/share/chezmoi-secrets diff --cached
# Should show encrypted content, not plaintext
```

#### Daily workflow

```bash
# Edit a secret safely — chezmoi decrypts to a private temp dir, opens your
# editor, then re-encrypts when you close it
chezmoi-secrets edit ~/.hermes/.env
chezmoi-secrets apply ~/.hermes/.env

# Status and diff (WARNING: diff decrypts for display)
chezmoi-secrets status
chezmoi-secrets diff ~/.hermes/.env

# Git status and push
git -C ~/.local/share/chezmoi-secrets status
git -C ~/.local/share/chezmoi-secrets add --all
git -C ~/.local/share/chezmoi-secrets commit -m "Update secrets"
git -C ~/.local/share/chezmoi-secrets push

# Update from remote (controlled — no auto-apply)
git -C ~/.local/share/chezmoi-secrets pull --ff-only
chezmoi-secrets apply ~/.hermes/.env
```

#### Multi-host setup (shared or per-host keys)

**Shared key** — simplest model: copy `age-key.txt` to each host via a secure
channel (password manager, encrypted USB). Use the same `recipient` in every
config. Configuration on the next host is identical except for steps 2-4.

**Per-host keys** — each host gets its own keypair. Add all public keys as
recipients:

```toml
[age]
    identity = "~/.config/chezmoi-secrets/age-key.txt"
    recipients = [
        "age1PUBLIC_KEY_LAPTOP",
        "age1PUBLIC_KEY_DESKTOP",
    ]
```

Important limits with per-host keys:
- All hosts must use the complete recipient list when re-encrypting files.
- Changing the recipient list does not retroactively re-encrypt existing files.
  For a new recipient, re-add affected files with `add --encrypt` on an already
  authorized host.
- Removing a recipient does not revoke access to older Git history entries that
  were encrypted for their key. If access must be revoked, rotate the secrets.
- Multiple recipients means every listed key can decrypt every file — there is
  no per-host file separation within one repo. For separate trust domains, use
  separate repos or a file-level encryption strategy.

#### What this setup does NOT provide

- No central password manager integration
- No time-limited or dynamically generated secrets
- No automatic API key rotation
- No encryption of deployed target files at rest
- No automatic Git history cleanup
- No automatic host-based access separation within a shared-key repo
- No passphrase-protected age identity — the local key file relies on
  filesystem permissions and a secure backup strategy

#### Checklist for a new secrets host

- [ ] Secrets repository is private
- [ ] Wrapper uses dedicated config, source, and state file
- [ ] age key created and backed up separately
- [ ] Private age key is NOT in the repository
- [ ] `[add] encrypt = true` is set
- [ ] Added file contents are actually encrypted (verified via `git diff --cached`)
- [ ] No target file is also managed by the public or private chezmoi instance
- [ ] No ancestor `exact_` directory removes files managed by another instance
- [ ] Target files have restrictive permissions
- [ ] Only secrets this host actually needs are deployed
- [ ] Recovery from a backed-up age key has been tested

---

### chezmoi_create_custom

**Purpose:** Helper script to bootstrap a new companion chezmoi repository — creates
the wrapper script with correct `--config` and `--source` paths for a custom
instance name.

**Script** (`bin/executable_chezmoi_create-custom.sh`):

```sh
#!/bin/sh
# Usage: ./bin/executable_chezmoi_create-custom.sh <name>
#
# Creates ~/bin/chezmoi-<name>.sh with:
#   --config  "$HOME/.config/chezmoi-<name>/chezmoi.toml"
#   --source  "$HOME/.local/share/chezmoi-<name>"
#
# Exits with an error if any of the three files/directories already exist.
```

**Usage example — creating a `chezmoi-work` instance:**

```bash
# Create the wrapper
./bin/executable_chezmoi_create-custom.sh work

# Set up the companion repo manually (wrapper exists, but config + source
# directories are still empty)
mkdir -p ~/.config/chezmoi-work ~/.local/share/chezmoi-work
touch ~/.config/chezmoi-work/chezmoi.toml
chmod 600 ~/.config/chezmoi-work/chezmoi.toml

# Initialize from a remote
chezmoi-work init git@example.com:user/chezmoi-work.git
chezmoi-work diff
chezmoi-work apply
```

The script is idempotent — it refuses to overwrite an existing wrapper, config,
or source directory. Delete those manually if you need to recreate an instance.

---

## Common workflows

```sh
# Bring a file from your home directory into the public repo
chezmoi add ~/.bashrc.d/my-snippet.sh

# Edit a managed file
chezmoi edit ~/.bashrc.d/my-snippet.sh

# Update and apply the public dotfiles
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
