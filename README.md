# Installation

## On a fresh box

    alias home="git --work-tree=$HOME --git-dir=$HOME/.home.git"
    home init
    home remote add origin git@gitlab.com:dpecos/dotfiles.git
    home fetch --all
    home reset --hard origin/master
    home submodule update --init

## Manual steps after installation

*ZSH*

    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k


*VIM*

    :PluginInstall

## Local overrides

Creating any of these files, options can be localized to a local box:

- `~/.aliases.local`
- `~/.vimrc.local`

## Updating existing installations

    home pull
    home submodule update --init

And check for *Manual steps* required after that. Probably installing vim plugins would best.

# Adding new content

## Files & directories

You have to add the new content *forcing* it because everything is matched by git-ignore:

    home add -f FILE

## Repositories

Remote repositories can be tracked as git submodules, unless their target path is already a module. In that case, a new manual step after installation will be required.

To track new repositories:

    home submodule add -f <repository> <relative/path/to/destination>

To update submodules and their git commit which this repo is pointing to:

    home submodule foreach 'git pull origin master && git gc --prune --aggressive'
    home commit -av