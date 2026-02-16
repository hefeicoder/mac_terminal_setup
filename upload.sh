#!/usr/bin/env bash
# Upload .zshrc and .vimrc from home directory to this repo and commit.

set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${HOME}"

echo "Copying dotfiles from ${HOME_DIR} to ${REPO_DIR}..."
cp "${HOME_DIR}/.zshrc" "${REPO_DIR}/.zshrc"
cp "${HOME_DIR}/.vimrc"  "${REPO_DIR}/.vimrc"

echo "Staging and committing..."
cd "${REPO_DIR}"
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  git init
fi
git add .zshrc .vimrc upload.sh setup.sh
if git diff --staged --quiet; then
  echo "No changes to commit."
else
  git commit -m "Update .zshrc and .vimrc"
  echo "Committed. Push with: git push"
fi
