# Installation

```bash
timedatectl set-timezone Asia/Jakarta
```

## Partition
```bash
cfdisk /dev/nvme0n1
# Create partition by tui
# Root partition
# Swap Partition, type=Linux swap
mkfs.ext4 /dev/{ROOT_PARTITION_DEVICE}
mkswap /dev/{SWAP_PARTITION_DEVICE}
swapon /dev/{SWAP_PARTITION_DEVICE}
```

## Mounting
```bash
mount /dev/{ROOT_PARTITION_DEVICE} /mnt
mount /dev/{DEV_PARTITION_DEVICE} /mnt/mnt
genfstab -U /mnt >> /mnt/etc/fstab
vim /mnt/etc/fstab
# Change {DEV_PARTITION_DEVICE} mounting point
```

## Arch Linux
```bash
cp /mnt/mnt/config/mirrorlist /mnt/etc/pacman.d/mirrorlist
pacman -Syu
pacstrap -i /mnt base base-devel linux linux-firmware \
    amd-ucode dhcpcd sudo vim git iwd
arch-chroot /mnt
```

## CHROOT
```bash
ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
hwclock --systohc
vim /etc/locale.gen
# Uncomment en_US.UTF-8 UTF-8
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

echo ArchLinuxHost > /etc/hostname
echo "127.0.0.1\tlocalhost" >> /etc/hosts
echo "::1\tlocalhost" >> /etc/hosts
echo "127.0.0.1\tArchLinuxHost.localdomain\tlocalhost" >> /etc/hosts

passwd
useradd -m deuzo
passwd deuzo
usermod -aG wheel,storage,power deuzo
visudo
# Uncomment to allow members of group wheel to execute ...

vim /etc/systemd/logind.conf
# HandlePowerKey=ignore
# HandlePowerKeyLongPress=suspend

cp /mnt/session/startup.service /etc/systemd/system/startup.service
systemctl enable startup
systemctl enable dhcpcd
systemctl enable iwd
```

## Boot Loader
```bash
mkdir /boot/efi
mount /dev/nvme0n1p1 /boot/efi
pacman -S grub efibootmgr dosfstools mtools
grub-install --target=x86_64-efi --bootloader-id=ArchLinuxBoot --recheck
grub-mkconfig -o /boot/grub/grub.cfg
# TODO: create conf for grub background and custom entry, pin: /etc/default/grub
```

## Entrypoint
```bash
sudo pacman -S zsh
chsh /usr/bin/zsh
echo '. ~/dev/config/zsh/zprofile' > ~/.zprofile
echo '. ~/dev/config/zsh/zshrc' > ~/.zshrc
```

## Showtime
```bash
exit
umount -lR /mnt
reboot
```

# Post Installation

## Core but Utils
```bash
sudo pacman -S firefox alacritty neovim \
    openssh bat jq ripgrep man man-db tmux fzf \
    unrar zip unzip 7zip noto-fonts wl-clipboard pacman-contrib
```

## Hyprland
```bash
sudo pacman -S polkit hyprland \
    hypridle hyprlock hyprpaper xdg-desktop-portal-hyprland
```

## Multimedia
```bash
sudo pacman -S pipewire pipewire-pulse wireplumber pipewire-alsa \
    grim libvips slurp swappy swayimg \
    vlc mpv obs-studio playerctl
```

# Development

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://bun.sh/install | bash
sudo pacman -S nodejs npm github-cli sccache mariadb postgresql
```

## Postgres
```bash
sudo su postgres
initdb --locale=C.UTF-8 --encoding=UTF8 -D '/var/lib/postgres/data'
```

# Gaming

## Prerequisite
```bash
# vulkan-radeon:
# https://www.reddit.com/r/linux_gaming/comments/15s4yz0/gamescope_fails_to_start_with_vulkan_error/
sudo pacman -S wine gamescope scanmem gamemode lib32-gamemode vulkan-radeon
```

## Gamescope
```bash
gamescope -- %command%
gamescope -W 1280 -H 720 -r 60 -- wine Hades.exe
```

## Gamemode
```bash
sudo usermod -aG gamemode
sudo nvim /etc/security/limits.conf
# # add line
# @gamemode      -        nice         10
# # This will enable user accounts that are members of the gamemode
# # group to increase (or ‘renice’) processes to a value of 10
gamemoderun %command%
# [source](https://github.com/DemonKingSwarn/linux-gaming)
```

## Steam and Multilib
```bash
vim /etc/pacman.conf
# [multilib]
# Include = /etc/pacman.d/mirrorlist
sudo pacman -Syy
sudo pacman -S steam
# chose proper providers, though idk which is proper one
```

## Slay the Spire
```bash
sudo pacman -S xorg-xrandr
```

## Dont Starve
```bash
sudo pacman -S libcurl-gnutls
```

# Others

## Additional
```bash
sudo pacman -S sqlitebrowser pinta xsv rsync qbittorrent prettier lshw \
    libmtp cloudflared net-tools parallel obsidian
```

## AMD backlight choke
```bash
# https://wiki.archlinux.org/title/Backlight#Recent_(2025)_AMD_changes
sudo vim /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet amdgpu.dcdebugmask=0x40000"
grub-mkconfig -o /boot/grub/grub.cfg
```

## VLC Choke on h264 not supported
```bash
sudo pacman -S vlc-plugin-gstreamer vlc-plugin-ffmpeg
```

## Format usb as exFat
```bash
sudo pacman -S exfatprogs
```

## Elixir
```bash
sudo pacman -S elixir inotify-tools
```

## detecting external input
```bash
sudo pacman -S wev
```

## tealinux
```bash
sudo pacman -S parted dmidecode
```

## tealinux V2
```bash
sudo pacman -S lshw rsync fuse2 gcc-libs webkit2gtk-4.1 \
    libappindicator-gtk3 appmenu-gtk-module
```

## Tauri development
```bash
sudo pacman -S libsoup webkit2gtk webkit2gtk-4.1 wget libvips \
    libappindicator-gtk3 appmenu-gtk-module
```

## C build tools
```bash
sudo pacman -S cmake
```

## esp-idf
[souce](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/get-started/linux-macos-setup.html)
```bash
sudo pacman -S --needed gcc git make flex bison gperf python cmake ninja ccache dfu-util libusb
mkdir -p ~/iot && cd ~/iot
git clone -b v5.3.2 --recursive https://github.com/espressif/esp-idf.git
cd ./esp-idf && ./install.sh esp32
. $HOME/iot/esp-idf/export.sh
```

## TODO
```bash
# copy fonts
# copy neovim plugin
# when different user for config/session/startup.service
```
