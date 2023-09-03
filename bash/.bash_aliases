# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cls="clear"
alias vim="nvim"
alias v="nvim"
alias setkeyboard="setxkbmap br brk2"

alias utar="tar -zxvf"

alias cdots="cd ~/.dotfiles && nvim ."
alias cvim="cd ~/.dotfiles/nvim && nvim ."
alias ci3="cd ~/.dotfiles/i3 && nvim ."
alias crofi="cd ~/.dotfiles/rofi && nvim ."
alias ckitty="cd ~/.dotfiles/kitty && nvim ."

alias getpass="pass show -c"

alias aws="AWS_ACCESS_KEY=$(pass show aws/access_id) AWS_SECRET_ACCESS_KEY=$(pass show aws/access_token) aws"

stash_all() {
  if [ -n "$1" ]
  then
    git stash push --include-untracked -m $1
    echo "Stash successfully with message $1"
  else
    git stash push --include-untracked
    echo "Stash successfully"
  fi
}
