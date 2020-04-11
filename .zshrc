export TERM=xterm-256color
export COLORTERM=truecolor

fpath=(/usr/local/share/zsh-completions $fpath)

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=false
ZSH_TMUX_AUTOCONNECT=false
#ZSH_TMUX_ITERM2=true

# 10ms for key sequences - tmux, vi integration
KEYTIMEOUT=1

#export GPG_TTY=$(tty)

# --------

plugins=(
  git
  git-flow
  tmux
  dotenv
  vi-mode
  iterm2
  osx
  golang
  npm
  yarn
  docker
  mvn
  ssh-agent
)

# --------

source ~/.zshrc.theme

# --------

# fix home / end / delete keys
bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line
bindkey "\033[3~" delete-char

# env variables - this needs to be used for GUI apps (like vscode) to work properly

[ -f ~/.env ] && . ~/.env

# aliases
source $HOME/.aliases
eval $(thefuck --alias)

# --------

# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52 
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# --------

# -- macosx
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# -- linux
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --------

echo
neofetch

# --------

[ -f ~/.zshrc.local ] && . ~/.zshrc.local
