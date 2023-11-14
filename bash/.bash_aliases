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
alias lg="lazygit"

alias utar="tar -zxvf"

alias cdots="cd ~/.dotfiles && nvim ."
alias cvim="cd ~/.dotfiles/nvim && nvim ."
alias ci3="cd ~/.dotfiles/i3 && nvim ."
alias crofi="cd ~/.dotfiles/rofi && nvim ."
alias ckitty="cd ~/.dotfiles/kitty && nvim ."
alias notes="cd ~/obsnotes && nvim ."

alias getpass="pass show -c"
alias lg="lazygit"

# git stuff
alias gf="git fetch"
alias gs="git status"
alias gpl="git pull"
gcb() {
  git checkout -b "$1"
}
gc() {
  git commit -m "$1"
}
alias gps="git push"
gpsu() {
  git push --set-upstream origin $(git branch --show-current)
}

# alias aws="AWS_ACCESS_KEY=$(pass show aws/access_id) AWS_SECRET_ACCESS_KEY=$(pass show aws/access_token) aws"

# The last line is the grep command itself, so should be skipped
alias jestkillall="ps aux | grep jest | tr -s ' ' | cut -d ' ' -f2 | head -n -1 | xargs kill -9 $1"
alias projects=". ~/.scripts/projects.sh"
alias workspaces="projects"
alias cheat=". ~/.scripts/cheat.sh"

setkeyboard() {
  setxkbmap br brk2
  setxkbmap -option caps:escape
}

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

compileqmk() {
  rm -rf ~/qmk_firmware/keyboards/keebio/iris/keymaps/victoroliveirab/
  cp -r ~/.dotfiles/keyboard/victoroliveirab/ ~/qmk_firmware/keyboards/keebio/iris/keymaps/
  qmk compile -kb keebio/iris/rev5 -km victoroliveirab
}

flashqmk() {
  qmk flash -kb keebio/iris/rev5 -km victoroliveirab
}
