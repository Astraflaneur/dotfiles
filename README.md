# 🧠 Astraflaneur Dotfiles

My personal Linux/Unix development setup, fully portable and optimized for machine learning, research, and smooth CLI experience.

## 📦 What’s Inside

- `.bashrc` with quality-of-life tweaks
- Aliases and Git helpers
- Conda auto-activation
- SSH and Git configuration scripts
- ASCII banners + install automation
- Custom functions and environment scripts

## 🚀 Quick Setup

```bash
git clone git@github.com:Astraflaneur/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh
```

## 🛠️ Manual Symlinks (if needed)

```bash
\ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/aliases ~/.aliases
```

## 🔐 SSH & Git Setup
Run:

```bash
source ~/.dotfiles/functions/git.sh
gen_ssh_key "your.email@example.com"
git_help_configure
```

---

✨ Made with care by **Sagar P. Barad** · 2025 · Astraflaneur 🛰️
