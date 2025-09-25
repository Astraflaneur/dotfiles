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


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

#---------------------------------------------------------------
# Shell Options & History Tweaks (zsh-friendly)
#---------------------------------------------------------------
# zsh equivalents for bash shopt options
setopt APPEND_HISTORY      # append to history file, don't overwrite
setopt INC_APPEND_HISTORY  # write to history immediately
setopt HIST_IGNORE_DUPS    # don't record duplicate entries
setopt AUTO_CD             # allow `cdsomepath` -> `cd somepath`

# History sizes
export HISTSIZE=50000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history

# Use zsh bindkey for history-search (up/down browse current prefix)
# Works with many terminals. If your terminal sends different sequences you may need to tweak.
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
# Some terminals use different sequences for arrow keys; fallback:
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

#---------------------------------------------------------------
# 📦 Environment Setup
#---------------------------------------------------------------
# Conda init (Apple Silicon compatible; uses zsh hook)
# If you installed Miniconda/Miniforge at a different location, update the path.
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    # Prefer the conda zsh hook (works better than PATH-only activation)
    # If conda was initialized with `conda init zsh`, this block is similar.
    __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
    unset __conda_setup
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

show_sysinfo() {
  local cores mem_bytes mem_human gpu_info

  # CPU cores
  cores=$(sysctl -n hw.ncpu 2>/dev/null || echo "N/A")

  # Memory in human-readable form
  mem_bytes=$(sysctl -n hw.memsize 2>/dev/null || echo "0")
  if [[ "$mem_bytes" -gt 0 ]]; then
    mem_human=$(awk -v b="$mem_bytes" 'BEGIN{
      split("B K M G T", u);
      s=1;
      while (b>=1024 && s<5) { b=b/1024; s++}
      printf "%.1f%s\n", b, u[s]
    }')
  else
    mem_human="N/A"
  fi

  # GPU info (Apple Silicon integrated GPU)
  gpu_info=$(system_profiler SPDisplaysDataType 2>/dev/null | grep -E "Chipset Model" | head -n 1 | sed 's/^[ \t]*//')

  printf "CPU: %s cores | RAM: %s | GPU: %s\n" "${cores}" "${mem_human}" "${gpu_info}"
}

# Uncomment to enable:
show_sysinfo

#---------------------------------------------------------------
# 🪄 Prompt Enhancer
#---------------------------------------------------------------
parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/^/ /'
}

show_conda_env() {
  if [ -n "$CONDA_DEFAULT_ENV" ]; then
    # Keep this minimal; powerlevel10k will usually show active envs nicely.
    echo -n "($CONDA_DEFAULT_ENV) "
  fi
}

# Because you are using powerlevel10k, let p10k manage the prompt.
# If p10k isn't present or you prefer a simple fallback prompt, uncomment below:
# PROMPT='%{$fg[cyan]%}%n@%m %{$fg[yellow]%}%~ %{$fg[green]%}$(parse_git_branch) %{$reset_color%}$ '
# RPROMPT='$(show_conda_env)'

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

# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keep custom PATH additions
PATH=~/.console-ninja/.bin:$PATH
