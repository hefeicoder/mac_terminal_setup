# Mac Terminal Setup

Dotfiles (`.zshrc`, `.vimrc`) and scripts to sync them across machines.

## What's included

### `.zshrc`
- **Shell**: oh-my-zsh with `robbyrussell` theme
- **Plugins**: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`
- **Tools**: pyenv (Python), gcloud SDK, kubectl (`ku` alias)
- **Aliases**: `ku` (kubectl), `ll`, `la`
- **QoL**: large history with dedup, `autocd`, typo correction

### `.vimrc`
- **Plugin manager**: [vim-plug](https://github.com/junegunn/vim-plug)
- **Plugins**: NERDTree (F2), NERDCommenter, vim-airline, vim-gitgutter, easymotion, molokai
- **Defaults**: 4-space indent, relative line numbers, smart search, system clipboard

## On this machine (upload)

```bash
./upload.sh
git push
```

## On a new machine (setup)

```bash
git clone https://github.com/YOUR_USERNAME/mac_terminal_setup.git
cd mac_terminal_setup
./setup.sh
source ~/.zshrc
```

`setup.sh` will:
1. Back up any existing `.zshrc` / `.vimrc`
2. Install the dotfiles
3. Auto-install vim-plug

Then open vim and run `:PlugInstall` to install all vim plugins.
