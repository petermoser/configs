export ZSH=$DOTFILES/zsh

if [[ -d $DOTFILES/zsh/functions ]]; then
    for func in $DOTFILES/zsh/functions/*(:t); autoload -U $func
fi

########################################################
# Configuration
########################################################

COLOR_BLACK="\e[0;30m"
COLOR_BLUE="\e[0;34m"
COLOR_GREEN="\e[0;32m"
COLOR_CYAN="\e[0;36m"
COLOR_PINK="\e[0;35m"
COLOR_RED="\e[0;31m"
COLOR_PURPLE="\e[0;35m"
COLOR_BROWN="\e[0;33m"
COLOR_LIGHTGRAY="\e[0;37m"
COLOR_DARKGRAY="\e[1;30m"
COLOR_LIGHTBLUE="\e[1;34m"
COLOR_LIGHTGREEN="\e[1;32m"
COLOR_LIGHTCYAN="\e[1;36m"
COLOR_LIGHTRED="\e[1;31m"
COLOR_LIGHTPURPLE="\e[1;35m"
COLOR_YELLOW="\e[1;33m"
COLOR_WHITE="\e[1;37m"
COLOR_NONE="\e[0m"

# if [ -z "$TMUX" ]; then
#     export TERM=xterm-256color-italic
# else
#     export TERM=tmux-256color
# fi

# export PATH="$PATH:/Users/petermoser/Projects/flutter/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# initialize autocomplete
autoload -U compinit add-zsh-hook
compinit

# prepend_path $HOME/npmbin/node_modules/.bin
prepend_path /usr/local/opt/grep/libexec/gnubin
prepend_path /usr/local/sbin
prepend_path $DOTFILES/bin
prepend_path $HOME/bin

# define the code directory
# This is where my code exists and where I want the `c` autocomplete to work from exclusively
if [[ -d ~/code ]]; then
    export CODE_DIR=~/code
fi

# display how long all tasks over 10 seconds take
export REPORTTIME=10

setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt PROMPT_SUBST

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

setopt COMPLETE_ALIASES

# make terminal command navigation sane again
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
bindkey "^A" vi-beginning-of-line

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# default to file completion
zstyle ':completion:*' completer _expand _complete _files _correct _approximate

# source all .zsh files inside of the zsh/ directory
source "$DOTFILES/zsh/utils.zsh"
source "$DOTFILES/zsh/prompt.zsh"


########################################################
# Plugin setup
########################################################

export ZPLUGDIR="$CACHEDIR/zsh/plugins"
[[ -d "$ZPLUGDIR" ]] || mkdir -p "$ZPLUGDIR"
# array containing plugin information (managed by zfetch)
typeset -A plugins

zfetch $ZPLUGDIR zsh-users/zsh-syntax-highlighting
zfetch $ZPLUGDIR zsh-users/zsh-autosuggestions
zfetch $ZPLUGDIR chriskempson/base16-shell

# add fnm
eval "`fnm env --multi --use-on-cd`"


[[ -e ~/.terminfo ]] && export TERMINFO_DIRS=~/.terminfo:/usr/share/terminfo

########################################################
# Setup
########################################################

if [[ -a ~/.localrc ]]; then
    source ~/.localrc
fi

# add a config file for ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# alias git to hub
if type hub > /dev/null 2>&1; then
    eval "$(hub alias -s)"
fi

# move to next word with ctrl-F
bindkey -M viins "^F" vi-forward-word
# Move to end of line with ctrl-E
bindkey -M viins "^E" vi-add-eol

# add color to man pages
export MANROFFOPT='-c'
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)

if hash brew 2>/dev/null; then
    source `brew --prefix`/etc/profile.d/z.sh
fi



########################################################
# Load version control information
# autoload -Uz vcs_info
# precmd() { vcs_info }

# # Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats 'on branch %b'
 
# # Set up the prompt (with git branch name)
# setopt PROMPT_SUBST
# RPROMPT=\$vcs_info_msg_0_
# PROMPT='%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_} > '
########################################################


########################################################
# Aliases
########################################################
# alias python=/usr/local/bin/python3
# reload zsh config
alias reload!='RELOAD=1 source ~/.zshrc'

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # macOS `ls`
    colorflag="-G"
fi

# use nvim, but don't make me think about it
alias vim="nvim"

# Filesystem aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias l="ls -lah ${colorflag}"
alias la="ls -AF ${colorflag}"
# alias ll="ls -lFh ${colorflag}"
alias lld="ls -l | grep ^d"
alias rmf="rm -rf"

alias cdp="cd ~/Projects"
alias findfile="find . -name "
alias aws=/usr/local/bin/aws
alias cd..="cd .."
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gss="git status"
alias gd="git diff"
alias gb="git branch"
alias gl="git log --all --decorate --oneline --graph"
alias gpm="git pull origin master"
alias cdp='cd ~/Projects'
alias cdn='cd ~/Projects/norae/spotlight-backend'
alias cdt='cd ~/Projects/thingsy/loopia-backend/backend/aws/base'
alias findstring="find . -name \"*\" -type f | xargs grep -l "
alias vim='nvim'
alias ll='ls -lhA'

# Helpers
alias grep='grep --color=auto'
alias df='df -h' # disk free, in Gigabytes, not bytes
alias du='du -h -c' # calculate disk usage for a folder

# Applications
alias ios='open -a /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"
# remove broken symlinks
alias clsym="find -L . -name . -o -type d -prune -o -type l -exec rm {} +"

# tmux aliases
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
# fnm
eval "$(fnm env --multi)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export NVM_DIR="$HOME/.nvm"
#   [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/petermoser/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/petermoser/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/petermoser/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/petermoser/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

autoload -Uz compinit && compinit -i
