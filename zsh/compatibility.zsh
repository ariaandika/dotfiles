# if [[ $(which zellij) && -z $(ps -e | grep zellij) ]]; then
#   zellij -c /home/deuzo/dev/config/zellij/config_sweet.kdl
# fi
if [[ $(which tmux) && -z $(ps -e | rg tmux) ]]; then
  tmux
  tmux \; splitw -h
fi
