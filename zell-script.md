
# ZELLIJ is set when inside zellij

```bash
if set -q ZELLIJ
else
  zellij
end
```

# List Session

`zellij list-sessions`


# List layout files and create a layout

List layout files saved in the default layout directory, opens the selected layout file. Depends on: tr, fd, sed, sk, grep & bash

```bash
set -euo pipefail
ZJ_LAYOUT_DIR=$(zellij setup --check \
    | grep "LAYOUT DIR" - \
    | grep -o '".*"' - | tr -d '"')

if [[ -d "${ZJ_LAYOUT_DIR}" ]];then
        ZJ_LAYOUT="$(fd --type file . "${ZJ_LAYOUT_DIR}" \
        | sed 's|.*/||' \
        | sk \
        || exit)"
    zellij --layout "${ZJ_LAYOUT}"
fi
```

# Lock Mode

`C-g`

# Toggle layout pane border at runtime

`C+p z`

# Options

set in config file

```kdl
pane_frames true
theme "default"
default_layout "compact"
scrollback_editor "/usr/bin/vim"
layout_dir "/path/to/my/layout_dir"
theme_dir "/path/to/my/theme_dir"
auto_layout true

ui {
    pane_frames {
        hide_session_name true
    }
}
```

# Keybinds

```kdl
keybinds {
    // keybinds are divided into modes
    normal {
        // bind instructions can include one or more keys (both keys will be bound separately)
        // bind keys can include one or more actions (all actions will be performed with no sequential guarantees)
        bind "Ctrl g" { SwitchToMode "locked"; }
        bind "Ctrl p" { SwitchToMode "pane"; }
    }
    pane {
        bind "h" "Left" { MoveFocus "Left"; }
    }
    locked {
        bind "Ctrl g" { SwitchToMode "normal"; }
    }
}
```

available modes:

normal
locked
resize
pane
move
tab
scroll
search
entersearch
renametab
renamepane
session
tmux

shared

```kdl
keybinds {
    shared {
        // these keybindings will be present in all modes
        bind "Ctrl g" { SwitchToMode "locked"; }
    }
    shared_except "resize" "locked" {
        // these keybindings will be present in all modes except "resize" and "locked"
        bind "Ctrl g" { SwitchToMode "locked"; }
    }
    shared_among "resize" "locked" {
        // these keybindings will be present in the "resize" and "locked" modes
        bind "Ctrl g" { SwitchToMode "locked"; }
    }
}
```

# Actions

Detach
Quit
DumpScreen "/tmp/my-dump.txt"
EditScrollback
Resize "Increase"
NextSwapLayout

CloseTab
GoToNextTab
GoToTab 1
NewTab

FocusNextPane
MoveFocus "Left"
MoveFocusOrTab "Left"
MovePane "Left"
NewPane "Right"

SwitchToMode "locked"
ToggleFloatingPanes
ToggleFocusFullscreen
TogglePaneFrames

// Float focused embedded pane or embed focused floating pane
TogglePaneEmbedOrFloating

bind "a" {
    Run "tail" "-f" "foo" {
        cwd "/tmp"
        direction "Down"
    }
}

ToggleTab
Write 102 111 111
WriteChars "hi there!"

Search "up"

