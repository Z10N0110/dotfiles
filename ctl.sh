#!/bin/bash
DEST=$HOME
SELF_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function basic() {
    brew install jq tree zsh coreutils lua luarocks
    if ! grep /usr/local/bin/zsh /etc/shells; then
      sudo echo '/usr/local/bin/zsh' >> /etc/shells
    fi
}

function ctl() { 
  cd "$( dirname "${BASH_SOURCE[0]}" )"
  for i in $(ls); do 
    [[ $i == "README.md" || $i == "ctl.sh" ]] && continue
    unlink $DEST/.$i &>/dev/null
    [[ $1 == "install" ]] && ln -s $SELF_DIR/$i $DEST/.$i
  done
}

while getopts "iu" opt; do
  case $opt in
    i)
      ctl install
      ;;
    u)
      ctl uninstall
      ;;
    \?)
      echo "Invalid option: -$OPTARG" 
      ;;
  esac
done
