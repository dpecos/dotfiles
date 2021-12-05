# dotfiles

## Installing on a fresh box

IMPORTANT: before initializing the home directory, setup ssh keys for GitLab and GitHub.

    alias home="git --work-tree=$HOME --git-dir=$HOME/.home.git"
    home init
    home remote add origin git@github.com:dpecos/dotfiles.git
    home fetch --all
    home reset --hard origin/master

### Manual steps after installation

*ZSH*

    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    #git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

*tmux*

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    prefix + I

*VIM*

    ~~git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim~~
    ~~:PluginInstall~~

    ln -s ~/.vimrc ~/.config/nvim/init.vim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    :PlugInstall

*Fonts*

    brew tap homebrew/cask-fonts
    brew cask install font-source-code-pro
    brew cask install font-hack-nerd-font

    yay -S nerd-fonts-source-code-pro adobe-source-code-pro-fonts

*Default Shell*

Add `which zsh` to /etc/shells

    chsh -s $(which zsh)

*ZSH security warning*

    sudo chmod go-w /usr/local/share
    sudo chmod go-w /usr/local/share/zsh
    sudo chmod go-w /usr/local/share/zsh/site-functions

*Other apps*

Config based on having this packages / applications installed:

- `zsh-syntax-highlighting`
- `zsh-autosuggestions`
- `zsh-completions`
- ~~`lsd`~~ `exa`
- `neofetch` (MacOSX) / `fastfetch`
- `fzf`
- `the_silver_searcher`
- `neovim`


MacOS:

```
brew install zsh-autosuggestions zsh-syntax-highlighting zsh-completions exa neofetch fzf the_silver_searcher neovim
```

Linux:

```
yay -S zsh-syntax-highlighting zsh-autosuggestions zsh-completions exa fastfetch fzf the_silver_searcher neovim neovim-symlinks
```

## Terminal apps configuration

### iTerm2

Setup `iterm2` to use font-hack-nerd-font: Preferences > Profiles > Text > Font

### Konsole

Create a new profile in order to edit Appearance:

- Color scheme: `Breeze`
- Set Font to `SauceCodePro Nerd Font 10pt` (not a typo, it's called `Sauce`)

## Local overrides

Creating any of these files, options can be localized to a local box:

- `~/.aliases.local`
- `~/.vimrc.local`
- `~/.zshrc.pre.local`
- `~/.zshrc.local`
- `~/.gitconfig.local`

### Disable GPG signing git commits:

.gitconfig.local:

```
[commit]
  gpgsign = false

[tag]
  forceSignedAnnotated = false
```

### Load SSH identities

.zshrc.pre.local:

```
zstyle :omz:plugins:ssh-agent identities darkmatter-github darkmatter-gitlab
zstyle :omz:plugins:ssh-agent lifetime 4h
zstyle :omz:plugins:ssh-agent helper ksshaskpass
```

## Adding new content

### Files & directories

You have to add the new content *forcing* it because everything is matched by git-ignore:

```
home add -f FILE
```

