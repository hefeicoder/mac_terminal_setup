# Dotfiles Revamp Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rewrite `.zshrc` and `.vimrc` to fix bugs, remove dead tools, and add quality-of-life defaults with clear section structure and comments.

**Architecture:** Three files are modified in isolation — `.zshrc` (shell config), `.vimrc` (vim config), `setup.sh` (bootstrap script). Each is a full rewrite from the current state. No shared state between them; tasks are independent and can be done in any order.

**Tech Stack:** zsh, oh-my-zsh, vim-plug, Vim 8+

---

## File Map

| File | Action | Responsibility |
|------|--------|----------------|
| `.zshrc` | Rewrite | Shell env, history, pyenv, gcloud, kubectl alias |
| `.vimrc` | Rewrite | Vim settings, vim-plug plugins, keymaps |
| `setup.sh` | Modify | Add vim-plug auto-install step |

---

## Task 1: Rewrite `.zshrc`

**Files:**
- Modify: `.zshrc`

- [ ] **Step 1: Verify current file syntax (baseline)**

```bash
cd /Users/xishu/work/mac_terminal_setup
zsh -n .zshrc
```

Expected: errors about `/Users/xwang/` paths not existing (or silent failure). This confirms the bugs we're fixing.

- [ ] **Step 2: Replace `.zshrc` with the revamped version**

Replace the entire contents of `.zshrc` with:

```zsh
# ── Oh-My-Zsh ──────────────────────────────────────────────────────────────
# Docs: https://github.com/ohmyzsh/ohmyzsh
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

# Plugins: git (aliases), autosuggestions (fish-style), syntax-highlighting
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ── History ────────────────────────────────────────────────────────────────
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY     # save timestamp and duration with each entry
setopt HIST_IGNORE_DUPS     # skip saving duplicate consecutive commands
setopt HIST_IGNORE_SPACE    # skip saving commands prefixed with a space

# ── Shell Behavior ─────────────────────────────────────────────────────────
setopt autocd               # type a directory name to cd into it
setopt correct              # suggest corrections for mistyped commands

# ── Path ───────────────────────────────────────────────────────────────────
export PATH="$HOME/go/bin:$HOME/bin:$PATH"

# ── Python (pyenv) ─────────────────────────────────────────────────────────
# Manages multiple Python versions. Install: https://github.com/pyenv/pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &>/dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# ── Google Cloud SDK ───────────────────────────────────────────────────────
# Install: https://cloud.google.com/sdk/docs/install
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
    source "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
    source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# ── Aliases ────────────────────────────────────────────────────────────────
alias ku=kubectl            # short alias for kubectl
alias ll='ls -lh'           # long list with human-readable sizes
alias la='ls -lah'          # long list including hidden files
```

- [ ] **Step 3: Run syntax check on new file**

```bash
zsh -n .zshrc
```

Expected: no output (clean syntax).

- [ ] **Step 4: Commit**

```bash
git add .zshrc
git commit -m "revamp: rewrite .zshrc — fix xwang paths, remove conda/nvm/p10k, add QoL defaults"
```

---

## Task 2: Rewrite `.vimrc`

**Files:**
- Modify: `.vimrc`

- [ ] **Step 1: Verify current file loads without plugin errors (baseline)**

```bash
vim -u .vimrc --noplugin +q 2>&1 | head -20
```

Expected: errors about duplicate settings or missing Vundle. This is the broken baseline.

- [ ] **Step 2: Replace `.vimrc` with the revamped version**

Replace the entire contents of `.vimrc` with:

```vim
" ── Plugin Manager (vim-plug) ─────────────────────────────────────────────
" First-time setup: install vim-plug, then open vim and run :PlugInstall
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'           " File browser sidebar
Plug 'preservim/nerdcommenter'      " Toggle comments with <leader>cc
Plug 'vim-airline/vim-airline'      " Informative status bar
Plug 'airblade/vim-gitgutter'       " Git diff markers in the sign column
Plug 'easymotion/vim-easymotion'    " Jump anywhere with <leader><leader>w
Plug 'tomasr/molokai'               " Dark colorscheme

call plug#end()

" ── General ───────────────────────────────────────────────────────────────
set nocompatible            " Disable Vi compatibility mode
set hidden                  " Allow switching buffers without saving first
set mouse=a                 " Enable mouse support in all modes
set clipboard=unnamed       " Yank/paste uses the system clipboard

" ── Appearance ────────────────────────────────────────────────────────────
set t_Co=256                " Tell vim the terminal supports 256 colors
syntax enable               " Enable syntax highlighting
colorscheme molokai         " Dark theme with vivid colors
hi Comment ctermfg=184      " Brighter yellow for comments (easier to read)
set number                  " Show line number on the current line
set relativenumber          " Show relative numbers on all other lines
set laststatus=2            " Always show the status bar (required by airline)
set showmatch               " Briefly highlight matching bracket when inserted

" ── Indentation ───────────────────────────────────────────────────────────
filetype indent plugin on   " Enable filetype-aware indentation and plugins
set autoindent              " Copy indent level from the previous line
set smartindent             " Add extra indent after { and similar tokens
set tabstop=4               " A tab character appears 4 spaces wide
set shiftwidth=4            " >> and << indent/dedent by 4 spaces
set expandtab               " Insert spaces when Tab is pressed

" ── Search ────────────────────────────────────────────────────────────────
set hlsearch                " Highlight all matches for the current search
set incsearch               " Show matches incrementally as you type
set ignorecase              " Case-insensitive search by default
set smartcase               " Switch to case-sensitive if query has uppercase

" ── Key Mappings ──────────────────────────────────────────────────────────
map <F2> :NERDTreeToggle<CR>    " F2 toggles the file browser sidebar
```

- [ ] **Step 3: Verify new file loads without errors (no plugins)**

```bash
vim -u .vimrc --noplugin +q 2>&1 | head -20
```

Expected: one warning about `colorscheme molokai` not found (plugin not installed yet — that's fine). No other errors.

If you see `E117: Unknown function: plug#begin`, vim-plug isn't installed. Run:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then re-run the check — it should pass.

- [ ] **Step 4: Commit**

```bash
git add .vimrc
git commit -m "revamp: rewrite .vimrc — swap Vundle for vim-plug, remove C++ setup, fix duplicates"
```

---

## Task 3: Update `setup.sh`

**Files:**
- Modify: `setup.sh`

- [ ] **Step 1: Read the current setup.sh**

Open `setup.sh` and locate the end of the file (after the dotfiles copy loop).

- [ ] **Step 2: Add vim-plug install step**

After the `for f in .zshrc .vimrc` loop and before the final `echo "Done."` line, add the vim-plug installation block. The full updated `setup.sh` should be:

```bash
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
```

- [ ] **Step 3: Verify setup.sh is valid bash**

```bash
bash -n setup.sh
```

Expected: no output (clean syntax).

- [ ] **Step 4: Commit**

```bash
git add setup.sh
git commit -m "revamp: update setup.sh to auto-install vim-plug"
```

---

## Final Verification

- [ ] **Smoke-test .zshrc in a subshell**

```bash
zsh -c "source .zshrc && echo 'OK: zshrc loaded'" 2>&1
```

Expected: `OK: zshrc loaded` with no error lines. (oh-my-zsh may print its banner — that's fine.)

- [ ] **Smoke-test .vimrc**

```bash
vim -u .vimrc --noplugin +"echo 'OK'" +q 2>&1
```

Expected: `OK` printed, no `E`-prefixed error lines (the molokai warning is acceptable until plugins install).
