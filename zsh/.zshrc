setopt prompt_subst
nice=''
precmd() {
  nice=`git branch 2>/dev/null`
  if [ $? -eq 0 ]; then
    nice="`echo $nice | awk '/\*/ {print $2}'` 󰘬 "
  else
    nice=""
  fi
}
PROMPT='%(?.%F{15}󰈸.%F{196}%?)%f %B%F{215}%~%F{45}%b $nice%f'

echo
echo Perfect
echo

PA="/usr/local/go/bin:/home/deuzo/.cargo/bin:/home/deuzo/.bun/bin"
PA="$PA:/home/deuzo/.local/share/nvim/mason/bin"
export PATH="$PA:/home/deuzo/dev/scripts:/home/deuzo/app:/home/deuzo/dev/bin:$PATH"

fpath+=~/dev/scripts/completions

alias claer=clear
alias clea=clear
alias cler=clear

alias l="ls -A --color --group-directories-first"
alias rm="mv $@ /tmp/"

alias zl="zellij -c ~/dev/config/zellij/config_sweet.kdl"
alias vim="XDG_CONFIG_HOME=~/dev/config nvim"
alias code=~/app/VSCode-linux-x64/bin/code
alias hx="helix -c ~/dev/config/helix/config.toml"
alias sw=swayimg

alias nd="npm run dev"
alias ndev="npm run dev"
alias ndw="npm run dev -w"
alias n="npm run"
alias br="bun run"
alias btest="bun test"
alias cr="cargo r"

alias :q=exit
alias :Q=exit

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

run () { i3-msg "exec $1" }
look () { . ~/dev/scripts/project-list; zle reset-prompt }
sysctlfn () { sysctl; zle reset-prompt }
bunrun () { echo;bun run src/index.ts; zle reset-prompt }

zle -N look                  
zle -N sysctlfn
zle -N bunrun

bindkey "\e;" bunrun
bindkey "\e\t" look 
bindkey "\e\`" sysctlfn
# will emulate typing
# bindkey -s "\ew" "some word to type"

# completions
[ -s "/home/deuzo/.bun/_bun" ] && source "/home/deuzo/.bun/_bun"

if [[ $(which zellij) && -z $(ps -e | grep zellij) ]]; then
  zellij -c /home/deuzo/dev/config/zellij/config_sweet.kdl
fi

# Autocomplete

# autoload -U compinit
# compinit
# setopt APPEND_HISTORY
# setopt SHARE_HISTORY
# HISTFILE=$HOME/.zhistory
# SAVEHIST=1000
# HISTSIZE=999
# setopt HIST_EXPIRE_DUPS_FIRST
# setopt EXTENDED_HISTORY

# bindkey '\e[A' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward


