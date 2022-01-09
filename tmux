# remap prefix from 'C-b' to 'C-a'

bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

set -sg escape-time 0

set-window-option -g mode-keys vi
set -g base-index 1

set-window-option -g mode-keys vi
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

# vim-like pane switching
set -ga terminal-overrides ",xterm-256color*:Tc"

unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix
set -g status-style 'bg=#333333 fg=#5eacd3'
bind -r ^ last-window
bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R


set -g default-command /usr/local/bin/fish
set -g default-shell /usr/local/bin/fish
