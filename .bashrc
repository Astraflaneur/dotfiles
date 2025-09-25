# ~/.bashrc - Astraflaneur Edition
# Author: Sagar P. Barad | 2025
# created: 2024-12-21 | updated: 2025-10-01

clear
cat <<'EOF'
▄▀█ █▀▀ █▀▀ █▀▀ ▄▀█ █░░ ▄▀█ █▄░█ █▀▀
█▀█ █▄▄ █▄▄ ██▄ █▀█ █▄▄ █▀█ █░▀█ ██▄

   ML Developer & Research Toolkit ⚡
         Astraflaneur — Rise Above
EOF
echo

#---------------------------------------------------------------
# 🌌 Welcome
#---------------------------------------------------------------
echo -e "\n🌠 Welcome, Astraflaneur! Initializing dev environment...\n"

#---------------------------------------------------------------
# ⚙️ Shell Options & History Tweaks
#---------------------------------------------------------------
shopt -s histappend
shopt -s autocd
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=50000
export HISTFILESIZE=100000
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#---------------------------------------------------------------
# 📦 Environment Setup
#---------------------------------------------------------------
# Conda init
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
    export PATH="$HOME/miniconda3/bin:$PATH"
fi

# Python
export PYTHONSTARTUP=~/.pystartup
export PYTHONIOENCODING='utf-8'
export PAGER=less

# Jupyter Lab as default
export JUPYTER_PLATFORM_DIR="$HOME/.jupyter"

# W&B Shortcut
export WANDB_DIR="$HOME/wandb_logs"
export WANDB_CONSOLE="wrap"

#---------------------------------------------------------------
# 📊 System Info on Login
#---------------------------------------------------------------
function show_sysinfo() {
  echo -e "$(nproc) Cores | 🧬 $(free -h | awk '/Mem:/ {print $2 " RAM"}') | GPU: $(nvidia-smi --query-gpu=name --format=csv,noheader | head -n 1)"
}
show_sysinfo

#---------------------------------------------------------------
# 🪄 Prompt Enhancer
#---------------------------------------------------------------
parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

show_conda_env() {
  if [ -n "$CONDA_DEFAULT_ENV" ]; then
    echo -ne "(\[\e[35m\]$CONDA_DEFAULT_ENV\[\e[0m\]) "
  fi
}

parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* / /'
}

PROMPT_COMMAND='__prompt_command'
__prompt_command() {
  local conda_env="$(show_conda_env)"
  local git_branch="$(parse_git_branch)"
  PS1="${conda_env}\[\e[36m\]\u@\h \[\e[33;1m\]\w \[\033[32m\]${git_branch}\[\033[00m\] \$ "
}

#---------------------------------------------------------------
# ⚡ Aliases
#---------------------------------------------------------------
alias ll='ls -lah --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ginit='git_init_here'
alias gremote='git_add_remote'
alias gbranch='git_new_branch'
alias gpush='git_push_origin'
alias gstat='git status'
alias gadd='git add .'
alias gcm='git commit -m'
alias gpull='git pull'
alias glog='git log --oneline --graph --all --decorate'
alias activate='conda activate'
alias deactivate='conda deactivate'
alias jn='jupyter notebook'
alias jlab='jupyter lab'
alias nv='nvtop'
alias tf32='export NVIDIA_TF32_OVERRIDE=0'
alias codeproj='cd ~/Projects'
alias datadir='cd ~/Datasets'
alias cl='clear'



#---------------------------------------------------------------
# 📁 Smart Directory Navigation
#---------------------------------------------------------------
export PROJECTS_DIR="$HOME/Projects"
cdp () { cd "$PROJECTS_DIR/$1" || echo "❌ No such project"; }

#---------------------------------------------------------------
# 🧪 Experimental: Auto .env_name Activation
#---------------------------------------------------------------
auto_activate_conda_env() {
  [[ $- != *i* ]] && return

  local env_name=""
  
  # Check for .env_name in current directory
  if [[ -f ".env_name" ]]; then
    env_name=$(<.env_name)
  elif [[ "$PWD" == "$HOME" ]]; then
    # Default to base in home dir
    env_name="base"
  fi

  # Activate only if not already active
  if [[ -n "$env_name" && "$CONDA_DEFAULT_ENV" != "$env_name" ]]; then
    conda activate "$env_name" &> /dev/null
  fi
}

# Add safely to PROMPT_COMMAND (runs before each prompt)
if [[ "$PROMPT_COMMAND" != *auto_activate_conda_env* ]]; then
  PROMPT_COMMAND="auto_activate_conda_env${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi

#---------------------------------------------------------------
# 📜 Python REPL improvements (optional .pystartup)
#---------------------------------------------------------------
cat > ~/.pystartup << 'EOF'
import readline
import rlcompleter
readline.parse_and_bind("tab: complete")
import numpy as np
import matplotlib.pyplot as plt
print("🔬 NumPy and Matplotlib preloaded.")
EOF

#---------------------------------------------------------------
# ✅ Final Message
#---------------------------------------------------------------
echo -e "✅ Astraflaneur shell ready. Let the experiments begin.\n"


