# dotfiles

Home directory managed as a bare git repository.

---

## Fresh installation

### 1. Generate SSH keys

Before checking out the dotfiles, generate separate SSH keys for GitHub, GitLab, and Forgejo.

The helper script creates Ed25519 keys in `~/.ssh`, prefixed with the machine hostname:

```sh
~/.local/bin/generate_git_ssh_keys.sh
```

For example, on a machine named `macbook-pro`, it generates:

```text
~/.ssh/id_ed25519_macbook-pro_github
~/.ssh/id_ed25519_macbook-pro_gitlab
~/.ssh/id_ed25519_macbook-pro_forgejo
```

The script will, for each service:

1. Generate the SSH key if it does not already exist.
2. Copy the public key to the clipboard.
3. Open the appropriate SSH-key settings page in the browser.
4. Wait for confirmation before continuing to the next service.
5. Add all generated identities to `~/.zshrc.local` for the Oh My Zsh `ssh-agent` plugin.

The three services are:

* GitHub — `https://github.com/settings/ssh/new`
* GitLab — `https://gitlab.com/-/user_settings/ssh_keys`
* Forgejo — `https://code.dplabs.dev/user/settings/keys`

The script expects `pbcopy` on macOS. On Linux it can use `xclip` or `xsel`.

Make sure the script is executable:

```sh
chmod +x ~/.local/bin/generate_git_ssh_keys.sh
```

Run it:

```sh
~/.local/bin/generate_git_ssh_keys.sh
```

The generated SSH identities will be configured automatically in `~/.zshrc.pre.local`.

### 2. Set zsh as default shell

```sh
# Add zsh to the list of allowed shells if not already present
which zsh | sudo tee -a /etc/shells

chsh -s $(which zsh)
```

On Linux, fix the OhMyZsh security warning:

```sh
sudo chmod go-w /usr/local/share
sudo chmod go-w /usr/local/share/zsh
sudo chmod go-w /usr/local/share/zsh/site-function
```

### 3. Install Oh My Zsh

```sh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
```

### 4. Install fonts

**macOS:**

```sh
brew tap homebrew/cask-fonts
brew install font-sauce-code-pro-nerd-font
```

**Linux:**

```sh
paru -S ttf-sourcecodepro-nerd
```

### 5. Check out the dotfiles

```sh
git config --global init.defaultBranch master

alias home="git --work-tree=$HOME --git-dir=$HOME/.home.git"
home init
home remote add origin git@github.com:dpecos/dotfiles.git
home fetch --all
home reset --hard origin/master
home branch --set-upstream-to=origin/master master
home config --local status.showUntrackedFiles no
```

### 6. Install packages

**macOS** — install Homebrew first:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then add to `~/.zshrc.pre.local`:

```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Then install packages:

```sh
brew install tmux tmuxp nodejs go autojump zsh-autosuggestions zsh-syntax-highlighting \
  zsh-completions eza fastfetch fzf ripgrep the_silver_searcher neovim dust fd bat \
  difftastic tokei tealdeer vladkens/tap/macmon starship direnv rustup fnm lazygit \
  btop dtop tree-sitter-cli gnupg pinentry-mac
```

**Linux:**

```sh
paru -S base-devel

paru -S paru tmux tmuxp nodejs npm go autojump-rs-bin zsh-syntax-highlighting \
  zsh-autosuggestions zsh-completions eza fastfetch fzf ripgrep the_silver_searcher \
  neovim neovim-symlinks dust ncdu fd duf bat difftastic tokei tealdeer \
  starship direnv rustup unzip wl-clipboard fnm lazygit btop tree-sitter-cli dtop-bin \
  kwalletcli-bin kcoreaddons5 ki18n5
```

**Cargo (all platforms):**

```sh
cargo install ays
```

### 7. Install tmux plugin manager

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then open tmux and press `prefix + I` to fetch plugins.

### 8. Configure Alacritty (local overrides)

Alacritty does not overwrite font settings defined in included files, so the font family and shell must be set in `~/.alacritty_local.toml`.

**macOS:**

```toml
[font]
size = 13

[font.normal]
family = "SauceCodePro Nerd Font"

[terminal.shell]
program = "/opt/homebrew/bin/tmux"
args = ["new-session", "-A", "-D", "-s", "main"]

[[hints.enabled]]
regex = '[^ ]+(?:\s*)$'
command = { program = "/opt/homebrew/bin/tmux", args = ["split-window", "-h", "-c", "#{pane_current_path}", "sh", "-c", "/opt/homebrew/bin/nvim \"$0\""] }
binding = { key = "1", mods = "Control" }
```

**Linux:**

```toml
[font]
size = 10

[font.normal]
family = "SauceCodePro Nerd Font Mono"

[terminal.shell]
program = "/usr/bin/tmux"
args = ["new-session", "-A", "-D", "-s", "main"]

[[hints.enabled]]
regex = '[^ ]+(?:\s*)$'
command = { program = "/usr/bin/tmux", args = ["split-window", "-h", "-c", "#{pane_current_path}", "sh", "-c", "nvim \"$0\""] }
binding = { key = "1", mods = "Control" }
```

---

## Local overrides

These files are gitignored and allow machine-specific configuration without touching the shared dotfiles:

| File                      | Purpose                                              |
| ------------------------- | ---------------------------------------------------- |
| `~/.zshrc.pre.local`      | Sourced before Oh My Zsh loads (env vars, brew init) |
| `~/.zshrc.local`          | Sourced at the end of `.zshrc`                       |
| `~/.aliases.local`        | Extra aliases, appended to `.aliases`                |
| `~/.alacritty_local.toml` | Font, shell, platform-specific Alacritty settings    |
| `~/.gitconfig.local`      | Local git overrides (included via `[include]`)       |
| `~/.gitignore_global`     | Global gitignore patterns                            |

### Load SSH identities automatically

The SSH key generation script automatically adds the generated identities to `~/.zshrc.pre.local`.

The resulting configuration looks like:

```sh
zstyle :omz:plugins:ssh-agent identities \
  "$HOME/.ssh/id_ed25519_HOST_github" \
  "$HOME/.ssh/id_ed25519_HOST_gitlab" \
  "$HOME/.ssh/id_ed25519_HOST_forgejo"

zstyle :omz:plugins:ssh-agent lifetime 4h
zstyle :omz:plugins:ssh-agent helper ksshaskpass
```

`HOST` is replaced with the machine hostname. On macOS, the `.local` suffix is automatically removed from the hostname.

### GPG signing on mac

```bash
mkdir ~/.gnupg
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
echo 'use-agent' > ~/.gnupg/gpg.conf
```

### Disable GPG signing

`~/.gitconfig.local`:

```ini
[commit]
  gpgsign = false

[tag]
  gpgsign = false
  forceSignedAnnotated = false
```

### Rewrite HTTPS remotes to SSH

`~/.gitconfig.local`:

```ini
[url "git@gitlab.xyz.com:"]
  insteadOf = https://gitlab.xyz.com/
```

### macOS: enable key repeat

```sh
defaults write -g ApplePressAndHoldEnabled 0
```

---

## Managing the dotfiles repo

The `home` alias (defined in `.aliases`) wraps git for the bare repo:

```sh
alias home="git --work-tree=$HOME --git-dir=$HOME/.home.git"
alias h="home"
alias lazyhome="lazygit --work-tree=$HOME --git-dir=$HOME/.home.git"
```

### Add a new file

Everything is gitignored by default, so new files must be force-added:

```sh
home add -f FILE
```
