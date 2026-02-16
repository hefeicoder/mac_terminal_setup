# Mac Terminal Setup

Dotfiles (`.zshrc`, `.vimrc`) and scripts to sync them across machines.

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
