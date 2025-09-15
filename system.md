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

## Cleanup
```bash
exit
umount -lR /mnt
reboot
```

# Post Installation

## AMD backlight choke
source: Archwiki Backlight, Troubleshooting(6.12)
```bash
sudo vim /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet amdgpu.dcdebugmask=0x40000"
grub-mkconfig -o /boot/grub/grub.cfg
```


## Core Packages
```bash
sudo pacman -S polkit hyprland firefox alacritty noto-fonts zsh tmux fzf neovim
chsh /usr/bin/zsh
echo '. ~/dev/config/zsh/zprofile' > ~/.zprofile
echo '. ~/dev/config/zsh/zshrc' > ~/.zshrc
curl -fsSL https://bun.sh/install | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo pacman -S openssh pipewire pipewire-pulse wireplumber obsidian \
    bat nodejs github-cli jq ripgrep sccache man mariadb postgresql unrar zip unzip 7zip vlc \
    obs-studio playerctl grim libvips slurp wl-clipboard swappy swayidle swayimg \
    xdg-desktop-portal-hyprland ydotool pipewire-alsa
```

## VLC Choke on h264 not supported
```bash
sudo pacman -S vlc-plugin-gstreamer vlc-plugin-ffmpeg
```

## Hypr ecosystem
```bash
sudo pacman -S hypridle hyprlock hyprpaper
```

## Alternative Media Player
```bash
sudo pacman -S mpv
```

## Postgres
```bash
sudo su postgres
initdb --locale=C.UTF-8 --encoding=UTF8 -D '/var/lib/postgres/data'
```

## Additional
```bash
sudo pacman -S sqlitebrowser pinta xsv rsync qbittorrent prettier lshw \
    libmtp cloudflared net-tools parallel
```

## Format usb as exFat
```bash
sudo pacman -S exfatprogs
```

## Elixir
```bash
sudo pacman -S elixir inotify-tools
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

## Gamemode
```bash
sudo pacman -S lib32-gamemode gamemode
sudo usermod -aG gamemode
sudo nvim /etc/security/limits.conf
# # add line
# @gamemode      -        nice         10
# # This will enable user accounts that are members of the gamemode
# # group to increase (or ‘renice’) processes to a value of 10
gamemoderun %command%
# [source](https://github.com/DemonKingSwarn/linux-gaming)
```

## Gamescope
```bash
sudo pacman -S gamescope
gamescope -- %command%
```

## detecting external input
```bash
sudo pacman -S wev
```

## tealinux
```bash
sudo pacman -S parted dmidecode
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

## game: dont starve
```bash
sudo pacman -S libcurl-gnutls
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
