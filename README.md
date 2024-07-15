# dotfiles

## Installing on a fresh box

IMPORTANT: before initializing the home directory, setup ssh keys for GitLab and GitHub.

    alias home="git --work-tree=$HOME --git-dir=$HOME/.home.git"
    home init
    home remote add origin git@github.com:dpecos/dotfiles.git
    home fetch --all
    home reset --hard origin/master
    home branch -m main master
    home branch --set-upstream-to=origin/master master

### Setup tweaks

Hide untracked files:

    home config --local status.showUntrackedFiles no

MacOSX: Enable repeating keys:

    defaults write -g ApplePressAndHoldEnabled 0

### Manual steps after installation

#### (MacOSX only) HomeBrew

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

After that, we need to create the following content in `~/.zshrc.pre.local`:

    eval "$(/opt/homebrew/bin/brew shellenv)"

#### ZSH

    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    # git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

#### tmux

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    prefix + I

#### Fonts

MacOSX:

    brew tap homebrew/cask-fonts
    brew install font-source-code-pro font-hack-nerd-font font-sauce-code-pro-nerd-font font-ubuntu

Linux:

    yay -S adobe-source-code-pro-fonts ttf-ubuntu-font-family ttf-hack ttf-sourcecodepro-nerd

#### Default Shell

Add `which zsh` to /etc/shells

    chsh -s $(which zsh)

ZSH security warning

    sudo chmod go-w /usr/local/share
    sudo chmod go-w /usr/local/share/zsh
    sudo chmod go-w /usr/local/share/zsh/site-function

#### Other apps

MacOS:

    brew install tmux nodejs go autojump zsh-autosuggestions zsh-syntax-highlighting zsh-completions eza neofetch fzf ripgrep the_silver_searcher neovim dust fd bat difftastic tokei tealdeer vladkens/tap/macmon starship

Linux:

    yay -S tmux nodejs go autojump zsh-syntax-highlighting zsh-autosuggestions zsh-completions eza fastfetch fzf ripgrep the_silver_searcher neovim neovim-symlinks dust ncdu fd duf bat difftastic lfs tokei tealdeer kwalletcli starship

## Local overrides

Creating any of these files, options can be localized to a local box:

- `~/.alacritty_local.toml`
- `~/.aliases.local`
- `~/.zshrc.pre.local`
- `~/.zshrc.local`
- `~/.gitconfig.local`
- `~/.gitignore_global`

### Disable GPG signing git commits

`.gitconfig.local`:

    [commit]
      gpgsign = false

    [tag]
      gpgsign = false
      forceSignedAnnotated = false

### Git SSH to HTTPS

    [url "git@gitlab.xyz.com:"]
      insteadOf = https://gitlab.xyz.com/

### Load SSH identities

`.zshrc.pre.local`:

    zstyle :omz:plugins:ssh-agent identities darkmatter-github darkmatter-gitlab
    zstyle :omz:plugins:ssh-agent lifetime 4h
    zstyle :omz:plugins:ssh-agent helper ksshaskpass

### Alacritty: fonts

Alacritty does not overwrite font family defined in included files, so we have don't have a default in the root config. We need to define a `~/.alacritty_local.toml` file with the following contents:

For MacOS:

    [font]
    size = 13

    [font.normal]
    family = "SauceCodePro Nerd Font"

    [shell]
    program = "/opt/homebrew/bin/tmux"
    args = ["new-session", "-A", "-D", "-s", "main"]

For Linux:

    [font]
    size = 10

    [font.normal]
    family = "SauceCodePro Nerd Font Mono"

    [shell]
    program = "/usr/bin/tmux"
    args = ["new-session", "-A", "-D", "-s", "main"]

## Adding new content to the dotfiles repo

### Files & directories

You have to add the new content _forcing_ it because everything is matched by git-ignore:

    home add -f FILE
