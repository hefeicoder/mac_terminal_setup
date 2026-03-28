# Dotfiles Revamp Design
**Date:** 2026-03-27
**Scope:** `.zshrc` and `.vimrc` lean modernization (Option B)

---

## Goals

- Fix bugs (hardcoded `/Users/xwang/` paths)
- Remove dead tools (conda, nvm, p10k, C++ vim setup)
- Add quality-of-life defaults without over-engineering
- Good comments and clear section structure throughout

---

## `.zshrc`

### Sections

1. **Oh-My-Zsh** — theme: `robbyrussell`, plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `DISABLE_AUTO_UPDATE=true`
2. **History** — `HISTSIZE`/`SAVEHIST=1000000`, `EXTENDED_HISTORY`, `HIST_IGNORE_DUPS`, `HIST_IGNORE_SPACE`
3. **Shell behavior** — `setopt autocd`, `setopt correct`
4. **Path & Tools** — pyenv init, gcloud SDK, `$HOME/go/bin`, `$HOME/bin`
5. **Aliases** — `ku=kubectl`, `ll`, `la`

### Bugs Fixed

- All `/Users/xwang/` hardcoded paths replaced with `$HOME`
- gcloud SDK sourced via `$HOME`-relative paths (guarded with `-f` checks)

### Removed

- Powerlevel10k instant prompt block
- conda / miniforge initialization
- nvm initialization
- `$OOG` variable

---

## `.vimrc`

### Plugin Manager

Switch from **Vundle** (abandoned) to **vim-plug** (active, faster).

Install command (added to `setup.sh`):
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

After installing dotfiles, open vim and run `:PlugInstall` once.

### Sections

1. **Plugins (vim-plug)** — NERDTree (F2), NERDCommenter, vim-airline, vim-gitgutter, easymotion, molokai
2. **General** — `set nocompatible` (once), `set hidden`, `set mouse=a`, `set clipboard=unnamed`
3. **Appearance** — molokai colorscheme, `syntax enable` (once), number + relativenumber, `t_Co=256`, `laststatus=2`
4. **Indentation** — tabstop=4, shiftwidth=4, expandtab, autoindent, smartindent
5. **Search** — hlsearch, incsearch, ignorecase, smartcase

### Removed

- Vundle and all `Plugin` declarations
- Duplicate `set nocompatible`, `syntax on/enable`, `filetype` calls
- ctags, OmniCppComplete, C++ tag settings, `map <C-F12>`
- `set gfn` (GUI font, irrelevant in terminal)
- `set vb t_vb` (visual bell quirk)
- `a.vim` plugin

---

## `setup.sh` Updates

- Add vim-plug auto-install step
- Print reminder to run `:PlugInstall` in vim after setup
