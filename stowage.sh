#!/usr/bin/env bash
#
STOW_ACTION="-S"
if test "$1" = "delete"; then
    STOW_ACTION="-D"
fi

for DOT in tmux git_template editorconfig X11; do
    stow "$STOW_ACTION" -t ~ "$DOT"
done

for CFG_DOT in nvim fish starship yamllint sway; do
    stow "$STOW_ACTION" -t ~/.config/$CFG_DOT/ -d config "$CFG_DOT"
done

stow "$STOW_ACTION" -t ~/.config/fish/functions -d config fish-functions
stow "$STOW_ACTION" -t ~/.config/fish/completions -d config fish-completions
