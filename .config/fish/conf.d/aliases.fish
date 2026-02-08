alias my_ip="ip address | grep -o \"inet 192.*/\" | awk '{ print \$2 }' | tr / ' ' | xargs"
alias vim="nvim"
alias wifi="nmtui"

alias devices="xinput --list"
alias check_port="sudo lsof -i"
alias hfzf="history | awk '\''{$1=""; sub(/^[ \t]+/, ""); print $0}'\'' | fzf --border --ansi | xclip -selection clipboard"

abbr -a eirc 'nvim $XDG_CONFIG_HOME/i3/config'

alias cclip="xclip -selection clipboard"
alias pclip="xclip -selection clipboard -o"

alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
