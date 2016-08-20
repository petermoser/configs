export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx export PATH="/usr/local/share/npm/lib/node_modules/express/bin:$PATH"
export PATH="/usr/local/share/npm/lib/node_modules/grunt-cli/bin:$PATH"
export PATH="/usr/local/share/npm/bin:$PATH"
alias chrome="open /Applications/Google\ Chrome.app"
alias browser="open -a \"$(/usr/local/bin/DefaultApplication -url 'http:')\" " 
alias sublime="open /Applications/Sublime\ Text.app"
alias copypath="pwd | tr -d '\n' | pbcopy"
alias cdp="cd ~/Projects"
sl() { cd "$@" && ls; }
alias findfile="find . -name "
alias cd..="cd .."
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias findstring="find . -name \"*\" -type f | xargs grep -l "
alias vim='mvim -v'
alias ll='ls -lhA'
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
alias findprocess="ps auxwww | grep "
export PS1="\w$ "
ulimit -n 1024
HISTFILESIZE=2000

