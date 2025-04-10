#!/usr/bin/env bash
#/////////////////////////////////////////////////////////////////////////////////////
#//                        Astraflaneur – Dotfiles Install Script                  //
#//                          By Sagar P. Barad | 2025                               //
#/////////////////////////////////////////////////////////////////////////////////////
#//                                                                                 //
#//  Script:     install.sh                                                          //
#//  Created:    10 April 2025                                                       //
#//  Platform:   Linux / Unix-like                                                   //
#//                                                                                 //
#/////////////////////////////////////////////////////////////////////////////////////

set -e

echo "🔧 Installing Astraflaneur dotfiles..."

# Helper to create symlinks with backup
link_dotfile() {
  src="$HOME/.dotfiles/$1"
  dest="$HOME/$2"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "⚠️  Backing up $dest → $dest.backup.$(date +%s)"
    mv "$dest" "$dest.backup.$(date +%s)"
  fi

  ln -sf "$src" "$dest"
  echo "🔗 Linked $src → $dest"
}

# === 🔗 SYMLINK KEY CONFIG FILES ===
link_dotfile ".bashrc" ".bashrc"
link_dotfile "aliases" ".aliases"

# === 📂 SOURCE FUNCTION + SCRIPT FILES ===
mkdir -p "$HOME/.config/astra"
echo "📂 Copying scripts and functions..."

cp -r "$HOME/.dotfiles/functions" "$HOME/.config/astra/"
cp -r "$HOME/.dotfiles/scripts" "$HOME/.config/astra/"

# === 🧠 Add sourcing logic to .bashrc if not already present ===
BASHRC="$HOME/.bashrc"

if ! grep -q "source ~/.aliases" "$BASHRC"; then
  echo "source ~/.aliases" >> "$BASHRC"
fi

if ! grep -q "source ~/.config/astra/functions/git.sh" "$BASHRC"; then
  echo "source ~/.config/astra/functions/git.sh" >> "$BASHRC"
fi

if ! grep -q "source ~/.config/astra/functions/conda.sh" "$BASHRC"; then
  echo "source ~/.config/astra/functions/conda.sh" >> "$BASHRC"
fi

if ! grep -q "source ~/.config/astra/scripts/banner.sh" "$BASHRC"; then
  echo "source ~/.config/astra/scripts/banner.sh" >> "$BASHRC"
fi

# === 🌀 Reload if interactive shell ===
if [[ $- == *i* ]]; then
  echo "🔄 Reloading shell..."
  source "$HOME/.bashrc"
fi

echo "✅ Astraflaneur dotfiles setup complete!"
