#!/usr/bin/env bash
DOTFILES_ROOT=$(pwd -P)

set -e
echo ''

info () {
  printf "\r  $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
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
    ln -fs $1 $2
    success "linked $1 to $2"
}

copy(){
  # Force copy
  cp -f $1 $2
  success "copied $1 to $2"
}

install_cf_plugin(){
  cf install-plugin -r CF-Community -f "$1" > /dev/null
  success "installed CF plugin $1"
}

install_npms(){
  npm install -g $1 > /dev/null
  success "installed $1 globally"
}

install_nvm(){
  export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"

  reload_bashrc
  nvm install node
  nvm install-latest-npm
}

copy_bin(){
  [[ -d "${HOME}/bin" ]] || mkdir "${HOME}/bin"
  cp -fr "${DOTFILES_ROOT}/bin" "${HOME}"
  find "${HOME}/bin" -type f -exec chmod +x {} \;
  success "bin folder is copied"
}

reload_bashrc(){
  source ${HOME}/.bashrc
  success "bashrc is reloaded"
}

check_prereq(){
  info "checking prerequisites"
  if ! [ -x "$(command -v cf)" ]; then
    #normally we would install CF, but sudo is not available in business application studio's integrated terminal
    fail "cf is not available, install it and try again"
    exit 1
  fi

  if ! [ -x "$(command -v node)" ]; then
    #normally we would install Node, but sudo is not available in business application studio's integrated terminal
    fail "node is not available, install it and try again"
    exit 1
  fi
}

info "📦 creating backup"
backup "${HOME}/.bashrc"
backup "${HOME}/.gitconfig"
backup "${HOME}/.theia/settings.json"
backup "${HOME}/.theia/keymaps.json"

info "📦 copying symlinks"
copy "${DOTFILES_ROOT}/bashrc" "${HOME}/.bashrc"
copy "${DOTFILES_ROOT}/gitconfig" "${HOME}/.gitconfig"
copy "${DOTFILES_ROOT}/git-completion.bash" "${HOME}/.git-completion.bash"

info "📦 copying bins"
copy_bin

info "📦 copying business application studio files"
[[ -d "${HOME}/.theia" ]] || mkdir "${HOME}/.theia"
copy "${DOTFILES_ROOT}/theia/settings.json" "${HOME}/.theia"
copy "${DOTFILES_ROOT}/theia/keymaps.json" "${HOME}/.theia"

info "📦 installing CF plugins"
install_cf_plugin "open"
install_cf_plugin "check-before-deploy"
install_cf_plugin "html5-plugin"

reload_bashrc 

echo ''
info '🧢🧢🧢 All installed! 🧢🧢🧢'
