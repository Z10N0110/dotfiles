ZSH_CUSTOM=~/.oh-my-zsh
ZSH=/usr/share/oh-my-zsh/
# ZSH_THEME="bullet-train"
ZSH_THEME="ys-modified"
DISABLE_AUTO_UPDATE="true"
plugins=(git)
# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

[[ "$ZSH_THEME" == "ys-modified" ]] && export VIRTUAL_ENV_DISABLE_PROMPT=yes

if [[ "$ZSH_THEME" == "bullet-train" ]]; then
  BULLETTRAIN_PROMPT_ORDER=(
    time 
    status 
    custom 
    dir 
    perl 
    ruby 
    virtualenv 
    go 
    git 
    hg 
    cmd_exec_time
  )
fi

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# export PATH=$HOME/bin:/usr/local/bin:$PATH
# dircolors
eval `dircolors ~/.dircolors`

# additional env
[[ -f ~/.env ]] && source ~/.env

# alias
source ~/.alias

# setup ssh-agent background
# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if [[ -f ~/.ssh/id_rsa ]]; then
  if ! pgrep -u $USER ssh-agent > /dev/null; then
      ssh-agent -a /tmp/ssh-agent.socket > ~/.ssh-agent-thing
  fi
  if [[ "$SSH_AGENT_PID" == "" ]]; then
      eval $(<~/.ssh-agent-thing)
  fi
  # this is for termite, when ssh to remote, set right TERM var
  ssh-add -l >/dev/null && alias ssh='TERM=xterm-256color ssh' || alias ssh='ssh-add -l >/dev/null || ssh-add && alias ssh="TERM=xterm-256color ssh";TERM=xterm-256color ssh'
fi

# for termite
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
fi

# setup nondisplay locale
# if [ -z "$DISPLAY" ];then
#   export LANG=en_US.UTF-8
#   unset LANGUAGE
# fi

unset PAGER
