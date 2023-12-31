#!/usr/bin/sh

# make brightness read and writable
chmod a+rw /sys/class/backlight/amdgpu_bl1/brightness
chown deuzo:deuzo /sys/class/backlight/amdgpu_bl1/brightness
