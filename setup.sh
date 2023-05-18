#!/bin/bash
set -ue

link_to_homedir(){
  #make backup file
  command echo "backup old dotfiles...."
  if [ ! -d "$HOME/.dotbackup" ];then
    command echo "$HOME/.backup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  echo "$script_dir"
  if [[ "$HOME" != "$script_dir" ]];then
    for f in $script_dir/.??*; do
      [[ `basename $f` == ".git" ]] && continue
      if [[ -L "$HOME/`basename $f`" ]];then
        command rm -f "$HOME/`basename $f`"
      fi
      if [[ -e "$HOME/`basename $f`" ]];then
        command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
      fi

      command echo "$f"
      command ln -snf $f $HOME
    done
  else
    command echo "same install src dest"
  fi
}

link_to_homedir
