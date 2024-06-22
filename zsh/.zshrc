setopt prompt_subst
setopt autocd
set -o noclobber

PROMPT='%(?.%F{15}󰈸.%F{196}%?)%f %B%F{215}%~%F{45}%b $nice%f'
MANROFFOPT="-c"
MANPAGER="sh -c 'col -bx | bat -l man -p'"
EDITOR='nvim'

echo
echo Perfect
echo

PA=""
PA="$PA:/home/deuzo/.cargo/bin"
PA="$PA:/home/deuzo/go/bin"
PA="$PA:/usr/local/go/bin"
PA="$PA:/home/deuzo/.bun/bin"
PA="$PA:/home/deuzo/.local/share/nvim/mason/bin"
PA="$PA:/home/deuzo/.surrealdb"
PA="$PA:/home/deuzo/dev/scripts"
PA="$PA:/home/deuzo/app"
PA="$PA:/home/deuzo/dev/bin"
export PATH="$PA:$PATH"
export RUSTC_WRAPPER="sccache"

alias cp='cp -i'
alias mv='mv -i'
alias l="ls -A --color --group-directories-first"
alias rm="printf yeet"
alias diff="diff --color=auto"
alias cat=bat
alias iwc=iwctl

alias alacritty="alacritty --config-file ~/dev/config/alacritty/alacritty.toml"
alias tmux="tmux -f ~/dev/config/tmux/tmux.conf"
alias vim="nvim -u ~/dev/config/nvim/init.lua"
alias chelp="bat --language=help"
alias sw=swayimg

alias br="bun run"
alias btest="bun test"
alias cr="cargo"
alias nd="npm run dev"
alias ndev="npm run dev"
alias ndw="npm run dev -w"
alias n="npm run"

alias :w="echo DeezNutz"
alias :W="echo DeezNutz"
alias :wa="echo DeezNutz"
alias :Wa="echo DeezNutz"
alias :WA="echo DeezNutz"
alias :q=exit
alias :Q=exit
alias p="ping google.com"
alias claer=clear
alias clae=clear
alias clea=clear
alias cler=clear

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

look () { . ~/dev/scripts/project-list; zle reset-prompt }
zle -N look
bindkey "\e\t" look
tmux_up () { tmux select-pane -U }
zle -N tmux_up
bindkey "^[[1;3A" tmux_up
tmux_down () { tmux select-pane -D }
zle -N tmux_down
bindkey "^[[1;3B" tmux_down

if [[ $(which tmux) && -z $(ps -e | rg tmux) ]]; then
  tmux
  tmux \; splitw -h
fi

# will emulate typing
# bindkey -s "\ew" "some word to type"

# completions
# [ -s "/home/deuzo/.bun/_bun" ] && source "/home/deuzo/.bun/_bun"

# . ~/dev/config/zsh/zsh-autosuggestions.zsh
