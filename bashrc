# History control
# don't use duplicate lines or lines starting with space
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
# append to the history file instead of overwrite
shopt -s histappend

# Aliases
alias cp='cp -Rv'
alias ls='ls --color=auto -ACF'
alias ll='ls --color=auto -alF'
alias dev='cd ~/projects'
alias grep='grep --color=auto'
alias grepw='grep --color=auto -Hrnwi'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias wget='wget -c'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cls='clear'
alias npmls='npm ls --global --depth=0'
alias myip='curl https://ipecho.net/plain'
alias tree="tree -aI 'test*|.git|node_modules|resources'"

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash

    # Add git completion to aliases
    __git_complete goto _git_checkout
fi

alias glog='git log --oneline --all --graph --decorate --color $*'
alias gstatus='git status -s'
alias gs='git status -s'
alias gcm='git commit -m $*'
alias gb='git branch --sort=-committerdate $*'


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Bash completion
source ~/.git-completion.bash

# Color prompt
export TERM=xterm-256color

# Colours have names too. Taken from @tomnomnom who stole it from Arch wiki
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;93m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;96m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

gitBranch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="${txtgrn}➜ ${bldcyn}\w ${bldred}\$(gitBranch) ${bldgrn}✗${txtrst} "

export PATH=$HOME/bin:$PATH
