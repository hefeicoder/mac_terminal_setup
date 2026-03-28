#!/usr/bin/env bash
# Install .zshrc and .vimrc from this repo into the home directory.
# Backs up existing files if present.

set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${HOME}"

backup_if_exists() {
  local file="$1"
  if [[ -f "${HOME_DIR}/${file}" ]]; then
    local backup="${HOME_DIR}/${file}.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing ${file} to ${backup}"
    cp "${HOME_DIR}/${file}" "${backup}"
  fi
}

echo "Installing dotfiles from ${REPO_DIR} to ${HOME_DIR}..."
for f in .zshrc .vimrc; do
  if [[ ! -f "${REPO_DIR}/${f}" ]]; then
    echo "Warning: ${REPO_DIR}/${f} not found, skipping."
    continue
  fi
  backup_if_exists "${f}"
  cp "${REPO_DIR}/${f}" "${HOME_DIR}/${f}"
  echo "Installed ${f}"
done

# ── vim-plug ───────────────────────────────────────────────────────────────
# Install vim-plug if not already present. After this runs, open vim and
# run :PlugInstall to download all plugins declared in .vimrc.
VIM_PLUG_PATH="${HOME}/.vim/autoload/plug.vim"
if [[ ! -f "${VIM_PLUG_PATH}" ]]; then
  echo "Installing vim-plug..."
  curl -fLo "${VIM_PLUG_PATH}" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "vim-plug installed."
else
  echo "vim-plug already installed, skipping."
fi

echo ""
echo "Done. Next steps:"
echo "  1. Reload shell config:  source ~/.zshrc"
echo "  2. Install vim plugins:  open vim and run :PlugInstall"
