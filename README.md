# Arch Linux Config

minimal handcrafted arch linux config

the entrypoint is in `~/.zshrc` and `~/.zprofile` which source `zsh/*` respectively

## ZSH

`zsh/zshrc` contains configuration, alias, shell keybind, and run tmux if no session found

`zsh/zprofile` will only run either `Hyprland` or `startx`

most gui apps is run by `hypr/hyprland.conf` config

> hyprland autorun can be canceled by `touch ~/.no-display`

## Hyprland

hyprland automatically run:

- dbus-update-activation-environment
- alacritty
- hyprpaper
- hypridle

## Neovim

more details in its [repo](https://github.com/ariaandika/nvimrc)
