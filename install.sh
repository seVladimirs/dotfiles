#!/usr/bin/env bash
DOTFILES_ROOT=$(pwd -P)

set -e
echo ''

info () {
  printf "\r ℹ️ $1\n"
}

success () {
  printf "\r 👌 $1\n"
}


backup(){
  local dst=$1
  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then
      cp "$dst" "${dst}.backup"
      success "backuped $dst to ${dst}.backup"
  fi
}

symlink(){
    # Force create/replace the symlink.
    ln -fs $1 "${HOME}/${2}"
    success "linked $1 to $2"
}

copy(){
  # Force copy
  cp -f $1 $2
  success "copied $1 to $2"
}

install_cf_plugin(){
  cf install-plugin -r CF-Community -f "$1"
  success "installed CF plugin $1"
}

install_npms(){
  npm install -g $1
  success "installed $1 globally"
}

info "creating backup"
backup "${HOME}/.bashrc"
backup "${HOME}/.bashrc_aliases"
backup "${HOME}/.gitconfig"
backup "${HOME}/.theia/settings.json"
backup "${HOME}/.theia/keymaps.json"

info "creating symlinks"
#symlink "${DOTFILES_ROOT}/bashrc_aliases"
#symlink "${DOTFILES_ROOT}/bashrc"
#symlink "${DOTFILES_ROOT}/gitconfig"

info "copying business application studio files"
[[ -d "${HOME}/.theia" ]] || mkdir "${HOME}/.theia"
copy "${DOTFILES_ROOT}/theia/settings.json" "${HOME}/.theia"
copy "${DOTFILES_ROOT}/theia/keymaps.json" "${HOME}/.theia"

info "install CF plugins"
install_cf_plugin "open"
install_cf_plugin "check-before-deploy"

info "install npms"
install_npms "hana-cli"

echo ''
echo '\n 🔥🔥🔥 All installed! 🧢🧢🧢'