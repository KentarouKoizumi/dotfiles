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
  if [[ "$HOME" != "$script_dir" ]];then
    for f in $script_dir/.??*; do
      [[ `basename $f` == ".git" ]] && continue
      [[ `basename $f` == ".gitignore" ]] && continue
      if [[ -L "$HOME/`basename $f`" ]];then
        command rm -f "$HOME/`basename $f`"
      fi
      if [[ -e "$HOME/`basename $f`" ]];then
        command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
      fi

      command echo "$f"
      command ln -snf $f $HOME
    done
    command echo "dotfiles are completely installed."
    command echo "plese run the below command to install vim-plug"
    command echo ""
    command echo "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    command echo ""
    command echo "and the below command in vim to install plugins"
    command echo ""
    command echo ":PlugInstall"
    command echo ""
  else
    command echo "same install src dest"
  fi
}

link_to_homedir
