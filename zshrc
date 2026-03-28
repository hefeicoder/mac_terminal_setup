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
