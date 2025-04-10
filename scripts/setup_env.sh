#!/bin/bash

# Update and install quality-of-life tools
sudo apt update && sudo apt upgrade -y
sudo apt install -y nvtop htop git curl wget zsh tmux

# Check for zsh and set it as default if installed
if command -v zsh &> /dev/null; then
  echo "Setting zsh as default shell"
  chsh -s $(which zsh)
fi

# Add useful aliases and tools to .zshrc or .bashrc
SHELL_RC="$HOME/.zshrc"
if [ ! -f "$SHELL_RC" ]; then
  SHELL_RC="$HOME/.bashrc"
fi

echo -e "\n# Custom ML Dev Setup" >> "$SHELL_RC"
echo "alias gs='git status'" >> "$SHELL_RC"
echo "alias gl='git pull'" >> "$SHELL_RC"
echo "alias gp='git push'" >> "$SHELL_RC"
echo "alias nvtop='nvtop'" >> "$SHELL_RC"
echo "alias ll='ls -lah --color=auto'" >> "$SHELL_RC"
echo "alias wandb_open='xdg-open https://wandb.ai'" >> "$SHELL_RC"
echo "export PATH=\$HOME/miniconda3/bin:\$PATH" >> "$SHELL_RC"

source "$SHELL_RC"
echo "Shell configured!"
