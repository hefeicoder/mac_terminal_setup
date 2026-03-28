# Mac Terminal Setup

Dotfiles (`zshrc`, `vimrc`) and a setup script to bootstrap a new Mac.

Files are stored **without** the leading dot in this repo so they're visible when browsing — `setup.sh` installs them as `~/.zshrc` and `~/.vimrc`.

## What's included

### `zshrc`
- **Shell**: oh-my-zsh with `robbyrussell` theme
- **Plugins**: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`
- **Tools**: pyenv (Python), gcloud SDK, kubectl (`ku` alias)
- **Aliases**: `ku` (kubectl), `ll`, `la`
- **QoL**: large history with dedup, `autocd`, typo correction

### `vimrc`
- **Plugin manager**: [vim-plug](https://github.com/junegunn/vim-plug)
- **Plugins**: NERDTree (F2), NERDCommenter, vim-airline, vim-gitgutter, easymotion, molokai
- **Defaults**: 4-space indent, relative line numbers, smart search, system clipboard

## On a new machine (setup)

```bash
git clone https://github.com/YOUR_USERNAME/mac_terminal_setup.git
cd mac_terminal_setup
./setup.sh
source ~/.zshrc
```

`setup.sh` will:
1. Back up any existing `~/.zshrc` / `~/.vimrc`
2. Install the dotfiles
3. Auto-install vim-plug

Then open vim and run `:PlugInstall` to install all vim plugins.

## Sync changes

Edit `zshrc` or `vimrc` directly in this repo, then:

```bash
git add zshrc vimrc
git commit -m "Update dotfiles"
git push
```
