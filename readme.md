# Arch Linux Config

minimal handcrafted arch linux config

the entrypoint is in `~/.zshrc` and `~/.zprofile` which source `zsh/*` respectively

## ZSH

`zsh/zshrc` contains configuration, alias, shell keybind, and run tmux if no session found

`zsh/zprofile` will run either `Hyprland` or `startx`

most gui apps is run by `hypr/hyprland.conf` config

> hyprland autorun can be canceled by `touch /tmp/.no-hypr`

## Hyprland

hyprland automatically run:

- dbus-update-activation-environment
- alacritty
- hyprpaper
- hypridle

## Neovim

more details in its [repo](https://github.com/ariaandika/nvimrc)

## Script

`script/*` contains utilities:

used directly in cli:

- `dev`, detect project kind and run corresponding dev command
- `wifi`, non interactive iwctl

bound to shell or hyprland keybind:

- `project-list`, list all project directories, use `fzf`, and `cd` into
- `screenshot`, well

used in embedded scripting, like neovim or tmux

- `google`, open link or google search in browser
- `show_status`, display brief current system status

