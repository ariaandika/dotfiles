# zsh tab autocomplete, eg: rustup, cargo
# fpath+=~/.zfunc

setopt prompt_subst
setopt autocd
set -o noclobber

PROMPT='%(?.%F{15}󰈸.%F{196}%?)%f %B%F{215}%~%F{45}%b $nice%f'
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export CONFY="$HOME/dev/config"
export RUSTC_WRAPPER="sccache"

# DONT EXPORT, IT BREAK STUFF, LIKE ALT + BACKSPACE
EDITOR='nvim'

alias latest="if [ -s $HOME/LATEST ]; then command cat ~/LATEST; fi"
alias setlatest="echo $1 >! ~/LATEST"

echo
echo Perfect
echo
echo Latest: `latest`

PA="$HOME/.cargo/bin"
PA="$PA:$HOME/.bun/bin"
PA="$PA:$HOME/dev/config/script"
PA="$PA:$HOME/app"
PA="$PA:$HOME/.surrealdb"
PA="$PA:$HOME/go/bin"
PA="$PA:/usr/local/go/bin"
export PATH="$PA:$PATH"

alias cp='cp -i'
alias mv='mv -i'
alias l="ls -A --color --group-directories-first"
alias rm="printf yeet"
alias diff="diff --color=auto"
alias cat=bat
alias p="ping 8.8.8.8"
alias :w="echo DeezNutz"
alias :W=:w
alias :wa=:w
alias :Wa=:w
alias :WA=:w
alias :q=exit
alias :Q=exit
alias claer=clear
alias clae=clear
alias clea=clear
alias cler=clear

alias alacritty="alacritty --config-file $CONFY/alacritty/alacritty.toml"
alias br="bun run"
alias chelp="bat --language=help"
alias cr="cargo"
alias gs="git status -s"
alias iwc=iwctl
alias ndev="npm run dev"
alias sw=swayimg
alias tmux="tmux -f $CONFY/tmux/tmux.conf"
alias vim="nvim -u $CONFY/nvim/init.lua"

bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e\`" clear-screen
bindkey "\eq" kill-whole-line
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

help_view () { $1 --help ${@:2} | chelp }
alias help=help_view
alias h=help_view
alias :h=help_view

look () { . "$CONFY/script/project-list"; zle reset-prompt }
zle -N look
bindkey "\e\t" look

tmux_up () { tmux select-pane -U }
zle -N tmux_up
bindkey "^[[1;3A" tmux_up

tmux_down () { tmux select-pane -D }
zle -N tmux_down
bindkey "^[[1;3B" tmux_down

if [[ $(which tmux) && -z $(ps -e | grep tmux) ]]; then
  tmux
  tmux \; splitw -h
fi

# will emulate typing
# bindkey -s "\ew" "some word to type"

