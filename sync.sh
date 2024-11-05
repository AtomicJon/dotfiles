#!/bin/bash
# TODO: make list and rsync at once

# TODO Before including .zshrc ensure secrets are sanitized/separated out
# rsync -ai ~/.zshrc ./
rsync -ai ~/.vimrc ./
rsync -ai ~/.tmux.conf ./
rsync -ai --mkpath ~/.config/nvim/init.lua ./.config/nvim/init.lua
rsync -ai --mkpath ~/data/workspace/scripts/tmux/ ./scripts/tmux/

