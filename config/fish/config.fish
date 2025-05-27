fish_vi_key_bindings

# spacefish
set -gx SPACEFISH_PROMPT_ORDER time user dir host git package node docker golang rust aws pyenv kubecontext line_sep battery char
set -gx SPACEFISH_GIT_SYMBOL ' '
set -gx SPACEFISH_VENV_SYMBOL ' '
set -gx SPACEFISH_VENV_SHOW true
set -gx SPACEFISH_VENV_GENERIC_NAMES .virtualenvs
set -gx SPACEFISH_KUBECONTEXT_SYMBOL 'ﴱ '
set -gx SPACEFISH_VI_MODE_SHOW false
set -gx SPACEFISH_GOLANG_SYMBOL 
set -gx SPACEFISH_CHAR_SYMBOL 
set -gx SPACEFISH_AWS_SYMBOL ' '

# TokyoNight Color Palette
# https://github.com/folke/tokyonight.nvim/blob/main/extras/fish/tokyonight_night.fish
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# the vapors color palette
set -l electro_green 00d72d
set -l bubble_pink d75fff
set -l vapor_purple 8787ff
set -l hulk_pants 9145ed
set -l deep_purple 5f5faf

# Syntax Highlighting Colors
set -g fish_color_normal $electro_green
set -g fish_color_command $electro_green
set -g fish_color_keyword $pink
set -g fish_color_quote $vapor_purple
set -g fish_color_redirection $electro_green
set -g fish_color_end $orange
set -g fish_color_error $bubble_pink
set -g fish_color_param $electro_green
set -g fish_color_valid_path $electro_green
set -g fish_color_option $electro_green
set -g fish_color_comment $deep_purple
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $electro_green
set -g fish_color_escape $electro_green
set -g fish_color_autosuggestion $deep_purple

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $hulk_pants
set -g fish_pager_color_completion $electro_green
set -g fish_pager_color_description $vapor_purple
set -g fish_pager_color_selected_background --background=$selection

starship init fish | source
enable_transience

mise activate fish | source

if test -f ~/.config/fish/env.fish
    source ~/.config/fish/env.fish
end

if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
