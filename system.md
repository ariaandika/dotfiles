# Installation

$ timedatectl set-timezone Asia/Jakarta

## Partition

$ cfdisk /dev/nvme0n1
# Create partition by tui
# Root partition
# Swap Partition, type=Linux swap
$ mkfs.ext4 /dev/{ROOT_PARTITION_DEVICE}
$ mkswap /dev/{SWAP_PARTITION_DEVICE}
$ swapon /dev/{SWAP_PARTITION_DEVICE}

## Mounting

$ mount /dev/{ROOT_PARTITION_DEVICE} /mnt
$ mount /dev/{DEV_PARTITION_DEVICE} /mnt/mnt
$ genfstab -U /mnt >> /mnt/etc/fstab
$ vim /mnt/etc/fstab
# Change {DEV_PARTITION_DEVICE} mounting point

## Arch Linux

$ cp /mnt/mnt/config/mirrorlist /mnt/etc/pacman.d/mirrorlist
$ pacman -Syu
$ pacstrap -i /mnt base base-devel linux linux-firmware \
    amd-ucode dhcpcd sudo vim git iwd
$ arch-chroot /mnt

## CHROOT

$ ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
$ hwclock --systohc
$ vim /etc/locale.gen
# Uncomment en_US.UTF-8 UTF-8
$ locale-gen
$ echo LANG=en_US.UTF-8 > /etc/locale.conf
$ export LANG=en_US.UTF-8

$ echo ArchLinuxHost > /etc/hostname
$ echo "127.0.0.1\tlocalhost" >> /etc/hosts
$ echo "::1\tlocalhost" >> /etc/hosts
$ echo "127.0.0.1\tArchLinuxHost.localdomain\tlocalhost" >> /etc/hosts

$ passwd
$ useradd -m deuzo
$ passwd deuzo
$ usermod -aG wheel,storage,power deuzo
$ visudo
# Uncomment to allow members of group wheel to execute ...

$ cp /mnt/session/startup.service /etc/systemd/system/startup.service
$ systemctl enable startup
$ systemctl enable dhcpcd
$ systemctl enable iwd

## Boot Loader

$ mkdir /boot/efi
$ mount /dev/nvme0n1p1 /boot/efi
$ pacman -S grub efibootmgr dosfstools mtools
$ grub-install --target=x86_64-efi --bootloader-id=ArchLinuxBoot --recheck
$ grub-mkconfig -o /boot/grub/grub.cfg
# TODO: create conf for grub background and custom entry, pin: /etc/default/grub

## Cleanup

$ exit
$ umount -lR /mnt
$ reboot

## Post Installation

$ sudo pacman -S polkit hyprland firefox alacritty noto-fonts zsh tmux fzf neovim
$ chsh /usr/bin/zsh
$ echo '. ~/dev/config/zsh/zprofile' > ~/.zprofile
$ echo '. ~/dev/config/zsh/zshrc' > ~/.zshrc
$ curl -fsSL https://bun.sh/install | bash
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
$ sudo pacman -S openssh pipewire pipewire-pulse wireplumber obsidian \
    bat nodejs github-cli jq ripgrep sccache man mariadb postgresql unrar zip unzip vlc \
    obs-studio playerctl grim libvips slurp wl-clipboard swappy swayidle swayimg \
    xdg-desktop-portal-hyprland ydotool pipewire-alsa

## Hypr ecosystem
$ sudo pacman -S hypridle hyprlock hyprpaper

## Postgres
$ sudo su postgres
$ initdb --locale=C.UTF-8 --encoding=UTF8 -D '/var/lib/postgres/data'

## Additional
$ sudo pacman -S sqlitebrowser pinta xsv rsync qbittorrent prettier lshw \
  libmtp cloudflared net-tools parallel

## Format usb as exFat
$ sudo pacman -S exfatprogs

## Elixir
$ sudo pacman -S elixir inotify-tools

## tealinux
$ sudo pacman -S parted dmidecode

## Libs
# Required when running tauri
$ sudo pacman -S libsoup webkit2gtk webkit2gtk-4.1 wget libvips \
    libappindicator-gtk3 appmenu-gtk-module

## if you love pain
$ sudo pacman -S cmake

## game: dont starve
$ sudo pacman -S libcurl-gnutls

## TODO
# copy fonts
# copy neovim plugin
# when different user for config/session/startup.service
