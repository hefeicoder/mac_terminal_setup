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

echo "Done. Reload shell config with: source ~/.zshrc"
