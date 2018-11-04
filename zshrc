ZSH_CUSTOM=~/.oh-my-zsh-custom
ZSH=~/.oh-my-zsh
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

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
mkdir -p $ZSH_CACHE_DIR

source $ZSH/oh-my-zsh.sh

# gnu ls dircolors
eval `/usr/local/opt/coreutils/libexec/gnubin/dircolors ~/.dircolors`

# additional env
[[ -f ~/.env ]] && source ~/.env

