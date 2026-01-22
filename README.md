# Neovim Configuration

A personal Neovim configuration built with Lua, focused on performance and usability.

## Structure

The configuration is organized into core settings and plugins:

- `init.lua`: Entry point.
- `lua/core/`: Core configuration (options, keymaps, autocmds, lazy.nvim bootstrap).
- `lua/plugins/`: Plugin specifications managed by `lazy.nvim`.

## Core Modules

- `core.options`: Sets Vim options (UI, search, indentation, etc.).
- `core.keymaps`: Defines global keymaps and leader key.
- `core.autocmds`: Configures automatic commands.
- `core.lazy`: Bootstraps the plugin manager.

## Plugins

- **Blink.cmp**: Fast completion engine.
- **Conform.nvim**: Formatter.
- **LSP Config**: Language Server Protocol setup.
- **Snacks.nvim**: Collection of utilities (picker, dashboard, etc.).
- **Treesitter**: Syntax highlighting and parsing.
- **Rainbow Delimiters**: Colored parentheses/brackets.
- **Autopairs**: Auto-closing pairs.

.tmux-conf.local --> tmux.md
## Tmux Integration

To run with tmux:
1. Install tmux: `brew install tmux` or `apt install tmux`.
2. Copy `.tmux.conf` to your home directory (`~/`).

.bashrc --> bashrc.md
##
Tool Combo,Action,Result
fzf + bat,CTRL + T,Search files; a bat preview appears on the right for each file.
fzf + history,CTRL + R,Search your command history with a fuzzy filter.
zoxide + fzf,zi,Interactively select a frequent directory from an fzf list.
eza + icons,ls,Lists files with Nerd Font icons and Git status (if in a repo).
fd + fzf,ALT + C,Fuzzy-find a sub-directory and jump into it immediately.

#Install Commands
sudo pacman -S fzf zoxide bat fd eza tmux neovim git


###Added the GNU stow
stow .
stow -D .
