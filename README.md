# Installation

## On a fresh box

IMPORTANT: before initializing the home directory, setup ssh keys for GitLab and GitHub.

    alias home="git --work-tree=$HOME --git-dir=$HOME/.home.git"
    home init
    home remote add origin git@gitlab.com:dpecos/dotfiles.git
    home fetch --all
    home reset --hard origin/master

## Manual steps after installation

*ZSH*

    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

*tmux*

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    prefix + I

*VIM*

     git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    :PluginInstall

*Fonts*

    brew tap homebrew/cask-fonts
    brew cask install font-source-code-pro
    brew cask install font-hack-nerd-font

Setup `iterm2` to use font-hack-nerd-font: Preferences > Profiles > Text > Font

*Default Shell*

Add `which zsh` to /etc/shells

    chsh -s $(which zsh)

*ZSH security warning*

    sudo chmod go-w /usr/local/share 
    sudo chmod go-w /usr/local/share/zsh
    sudo chmod go-w /usr/local/share/zsh/site-functions

*Other apps*

Config based on having this packages / applications installed:

- ~~lsd~~ exa
- zsh-syntax-highlighting
- zsh-autosuggestions
- zsh-completions
- ~~neofetch~~ fastfetch

## Local overrides

Creating any of these files, options can be localized to a local box:

- `~/.aliases.local`
- `~/.vimrc.local`
- `~/.zshrc.pre.local`
- `~/.zshrc.local`

# Adding new content

## Files & directories

You have to add the new content *forcing* it because everything is matched by git-ignore:

    home add -f FILE
