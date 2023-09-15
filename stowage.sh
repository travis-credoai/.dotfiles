#!/usr/bin/env bash
#
case $1 in
    delete) STOW_ACTION="-D" ;;
    restow) STOW_ACTION="-R" ;;
    *) STOW_ACTION="-S" ;;
esac

for DOT in tmux git_template editorconfig X11; do
    stow "$STOW_ACTION" -t ~ "$DOT"
done

for CFG_DOT in nvim fish foot iterm2-config starship yamllint sway; do
    if test -d ~/.config/$CFG_DOT; then
        stow "$STOW_ACTION" -t ~/.config/$CFG_DOT/ -d config "$CFG_DOT"
    else
        echo "Skipping $CFG_DOT... directory ~/.config/$CFG_DOT does not exist"
    fi
done

stow "$STOW_ACTION" -t ~/.config/fish/functions -d config fish-functions
stow "$STOW_ACTION" -t ~/.config/fish/completions -d config fish-completions
stow "$STOW_ACTION" -t ~/.ipython/profile_default -d ipython profile_default
