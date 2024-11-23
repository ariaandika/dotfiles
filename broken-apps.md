## Davinci Resolve

free version basically cannot import media in linux

[from forum 23/11/2024](https://forum.garudalinux.org/t/cant-import-videos-into-da-vinci-resolve/12355/2)

> You will have to use ffmpeg to convert the video file since the free resolve
> doesn't work with certain linux codecs you would have to buy studio for that.
>
> ...

### Installation attempt

```bash
## davinci resolve
$ sudo pacman -S glu libxcrypt-compat
## opencl gpu stuff
$ git clone https://aur.archlinux.org/opencl-amd.git
$ sudo pacman -S numactl
$ makepkg
$ sudo pacman -U opencl-amd-1:6.2.4-1-x86_64.pkg.tar.zst
## to run it
## https://github.com/boltgolt/howdy/issues/907
## https://bbs.archlinux.org/viewtopic.php?id=289533
$  LD_PRELOAD="/usr/lib/libgio-2.0.so /usr/lib/libgmodule-2.0.so /usr/lib/libglib-2.0.so" /opt/resolve/bin/resolve
```

