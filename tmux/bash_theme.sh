# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
. "$HOME/.cargo/env"

# --- Custom Bash Theme ---

# Text Colors
Reset='\[\e[0m\]'
Blue='\[\e[0;34m\]'
Cyan='\[\e[0;36m\]'
Green='\[\e[0;32m\]'
Yellow='\[\e[0;33m\]'
Purple='\[\e[0;35m\]'

# Function to show Git Branch
# parse_git_branch() {
#      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }

parse_git_branch() {
     # Check if we are in a git repo
     if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
          local status="$(git status --porcelain 2>/dev/null)"
          local branch="$(git b-name 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null)"
          local marks=""

          # Check for uncommitted changes
          if echo "$status" | grep -q '^ [MADRCU]'; then
               marks+=" ✚" # Unstaged changes
          fi
          # Check for staged changes
          if echo "$status" | grep -q '^[MADRCU]'; then
               marks+=" ●" # Staged changes
          fi
          # Check for untracked files
          if echo "$status" | grep -q '??'; then
               marks+=" …" # Untracked files
          fi
          # Check if ahead of remote
          if git status -sb 2>/dev/null | grep -q 'ahead'; then
               marks+=" ↑" # Local is ahead
          fi

          echo -e " ($branch$marks)"
     fi
}

# The enhanced function (from above)
# parse_git_branch() {
#      if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
#           local status="$(git status --porcelain 2>/dev/null)"
#           local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
#           local marks=""
#           [[ "$status" =~ [[:space:]][MADRCU] ]] && marks+=" ✚"
#           [[ "$status" =~ ^[MADRCU] ]] && marks+=" ●"
#           [[ "$status" =~ \?\? ]] && marks+=" …"
#           [[ $(git status -sb 2>/dev/null) =~ ahead ]] && marks+=" ↑"
#           echo -e " \[\e[0;35m\]( \[\e[0;33m\]$branch$marks \[\e[0;35m\])"
#      fi
# }

# Define Icons (You can replace these with any emoji or symbol)
SuccessIcon="✔"
FailureIcon="✘"

# Function to determine which icon to show
prompt_status() {
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo -e "$Green$SuccessIcon" # Green check
    else
        echo -e "$Red$FailureIcon" # Red cross
    fi
}

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Usage: 
# sleep 5 & spinner $!



# Example aliases
alias bashconfig="mate ~/.bashrc"

export LANGUAGE=en_IN.UTF-8
. "$HOME/.cargo/env"


# --- 1. Zoxide (Smarter 'cd') ---
eval "$(zoxide init bash)"
alias cd="z"
alias ci="z -i" # Interactive jump using fzf

# --- 2. Eza (Modern 'ls' replacement) ---
# Check if eza is installed to set aliases
if command -v eza >/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lh --icons --git --group-directories-first'
  alias la='eza -a --icons --group-directories-first'
  alias lt='eza --tree --icons'
fi

# --- 3. Bat (Better 'cat') ---
alias cat="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# --- 4. FD & FZF Integration ---
# Use 'fd' instead of 'find' for speed and to respect .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Setup FZF UI with Bat Preview
# This shows a preview window on the right with syntax highlighting
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border \
--preview 'bat --color=always --style=numbers --line-range :500 {}'"

# --- 5. FZF Keybindings & Completion ---
# Load official Arch Linux integration for Bash
eval "$(fzf --bash)"
# Auto-start tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi

# export PS1="${Blue}\w${Yellow}\$(parse_git_branch)${Reset} "

# Final PS1
export PS1="$(prompt_status) ${Cyan}\w\$(parse_git_branch)${Reset} "
