#zmodload zsh/zprof

export COLORTERM="truecolor"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]; then
   ZSH_TMUX_AUTOSTART=true
fi
ZSH_TMUX_AUTOSTART_ONCE=false
ZSH_TMUX_AUTOCONNECT=false
#ZSH_TMUX_ITERM2=true

# 10ms for key sequences - tmux, vi integration
KEYTIMEOUT=1

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# --------

[ -f ~/.zshrc.pre.local ] && . ~/.zshrc.pre.local || true

# --------

plugins=(
  git
  direnv
  vi-mode
  fzf
  ssh-agent
  node
  autojump
  docker
  mvn
  rust
  gcloud
  sdk
)

if [ "$(uname)" = "Darwin" ]; then
  if [ -z "$HOMEBREW_PREFIX" ]
  then
    export HOMEBREW_PREFIX=/opt/homebrew
  fi

  # . $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  # . $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  #
  plugins+=(
    macos
    brew
  )
else
  # . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  # . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

  plugins+=(
    systemd
  )
fi

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

# Use neovim as the man pager
export MANPAGER='nvim +Man!'

# --------

echo

if [ "$(uname)" = "Darwin" ]; then
  neofetch
else
  fastfetch
fi

echo

# --------

if [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]; then
  if ! type "$starship" > /dev/null
  then
    eval "$(starship init zsh)"
  fi
fi

# --------

# Smarter completion initialization
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# --------

if [ "$(uname)" = "Darwin" ]; then
  if [ -z "$HOMEBREW_PREFIX" ]
  then
    export HOMEBREW_PREFIX=/opt/homebrew
  fi

  . $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  . $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# --------

# Alternative to 'nvm' - Node Version Manager, written in Rust with a faster startup time
eval "$(fnm env --use-on-cd --shell zsh)"

# --------

[ -f ~/.zshrc.local ] && . ~/.zshrc.local || true

#zprof
