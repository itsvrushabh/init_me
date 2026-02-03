# .bashrc
# Function for yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

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

# Example aliases
alias bashconfig="mate ~/.bashrc"

export LANGUAGE=en_IN.UTF-8
export LANG=en_IN.UTF-8
. "$HOME/.cargo/env"

# Ping gping
alias ping="gping"

# --- 1. Zoxide (Smarter 'cd') ---
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
# Auto-start tmux
# if command -v tmux -u &> /dev/null && [ -z "$TMUX" ]; then
#     tmux -u attach-session -t default || tmux -u new-session -s default
# fi
# export PS1="${Blue}\w${Yellow}\$(parse_git_branch)${Reset} "
# Final PS1
# export PS1="${Green}$(parse_git_branch)${Reset} ${Cyan}\W ${Reset}"
# PS1: [Git Info (Purple)] [Folder (Cyan)] [Symbol]
# We use the literal variable names so they are interpreted every time
# export PS1="${Purple}\$(parse_git_branch)${Reset} ${Cyan}\W ${Reset}\$ "
eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash)"
