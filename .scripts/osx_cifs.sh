#!/bin/bash
#set -x
OSX_CIFS_URI=''
CIFS_USER=''
CIFS_PASSWORD=''
MOUNT_ENDPOINT='/mnt/osx'
CREDENTIAL_FILE=~/.osx_cifs_credential

[[ ! -f "$CREDENTIAL_FILE" ]] && echo "credential file not exist." && exit 1
source "$CREDENTIAL_FILE"

EXT_OPTIONS='iocharset=utf8,uid=1000,gid=1000,nounix,sec=ntlmssp,noperm,rw'
OPTS="user=$CIFS_USER,password=$CIFS_PASSWORD,$EXT_OPTIONS"

is_mounted() {
  df -hP | grep -qw "$OSX_CIFS_URI" &>/dev/null && exit 0
}

do_mount() {
  is_mounted
  sudo mount -t cifs "$OSX_CIFS_URI" "$MOUNT_ENDPOINT" -o "$OPTS"
}

do_unmount() {
  sudo umount -f "$MOUNT_ENDPOINT"
}

sudo mkdir -p $MOUNT_ENDPOINT

case "$1" in
  mount)
    do_mount
  ;;
  umount)
    do_unmount
  ;;
  *)
    echo "Usage: $0 {mount|umount}"
  ;;
esac
