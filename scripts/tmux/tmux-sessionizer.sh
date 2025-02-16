#!/usr/bin/env bash

# Credit: [ThePrimeagen](https://github.com/ThePrimeagen/)
# Source: https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
#
# Modified with different session types
#


start_mode () {
    session_name=$1
    session_dir=$2
    echo "Mode for $session_name : $session_dir"
    select mode in "dockerdev" "dualdev" "single";
    do
        case $mode in
            dockerdev )
                tmux new-session -s "$session_name" -n code -d -c "$session_dir"
                tmux new-window -t "$session_name" -n cmd -c "$session_dir"
                tmux new-window -t "$session_name" -n docker -c "$session_dir"
                break ;;
            dualdev )
                tmux new-session -s "$session_name" -n code -d -c "$session_dir"
                tmux new-window -t "$session_name" -n cmd -c "$session_dir"
                break ;;
            single )
                tmux new-session -s "$session_name" -n code -d -c "$session_dir"
                break ;;
            * )
                echo "Invalid option"
        esac
    done
}


if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/data/workspace/ -mindepth 1 -maxdepth 2 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# Disabled for now, only using this script inside tmux
# if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
#     tmux new-session -s $selected_name -c $selected
#     exit 0
# fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    # tmux new-session -ds $selected_name -c $selected
    start_mode "$selected_name" "$selected"
fi

tmux switch-client -t "$selected_name"


