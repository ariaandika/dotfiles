#!/bin/bash

# if no process run
# if [[ -z $(ps -A | grep tmux) ]]; then
#   echo oof
# else
#   echo bruv
# fi



if which Hyprland &> /dev/null; then
  echo star
elif which Hyprland &> /dev/null; then
  echo Hyper
fi

