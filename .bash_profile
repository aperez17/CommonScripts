# BASH completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Catalina debugger
export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n -DwsptPrettyJson=true"

# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

alias ll="ls -al"
alias clr="clear"
alias ip="curl icanhazip.com"
alias ldir="ls -al | grep ^d"
alias o="open ."
alias ut="uptime"
