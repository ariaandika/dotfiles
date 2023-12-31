#!/usr/bin/sh
# script run even before login
# run as root

# make brightness read and writable
chmod a+rw /sys/class/backlight/amdgpu_bl1/brightness
# make brightness file editable by non root
chown deuzo:deuzo /sys/class/backlight/amdgpu_bl1/brightness

# same but for battery status
chmod a+rw /sys/class/power_supply/BAT0/status
chown deuzo:deuzo /sys/class/power_supply/BAT0/status

# notification daemon
/usr/lib/notification-daemon-1.0/notification-daemon &
