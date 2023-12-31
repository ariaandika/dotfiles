
if which Hyprland &> /dev/null; then
  if [[ -z $(ps -A | grep Hyprland) ]]; then
    echo Hyprland Detected
    exec Hyprland -c /home/deuzo/dev/config/hypr/hyprland.conf
  fi
elif which startx &> /dev/null; then
  if [[ -z $(ps -A | grep startx) ]]; then
    echo xorg Detected
    exec startx
  fi
fi

