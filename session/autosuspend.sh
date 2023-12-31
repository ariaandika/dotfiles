#!/bin/bash

MAXMINUTE=1
MAXMS=$(( $MAXMINUTE * 60 * 1000 ))
MAX=$MAXMS
P=$(ps -A | grep autosuspend.sh | grep -o --perl-regexp "\d+" | head -n 1)
MINBATTERY=10

while true; do
  IDLE=$(xprintidle)
  AUDIO=$(pacmd list-sink-inputs | grep -oP "\d" | head -n1)
  if [[ $IDLE -gt $MAX && $AUDIO -eq 0 ]]; then
    notify-send 'sleep in 10 sec'
    sleep 10;
    IDLE=$(xprintidle)
    if [[ $(xprintidle) -gt $MAX ]]; then
      echo "$(date) sleeping..." >> /home/deuzo/.local/share/oofed
      i3lock -i $HOME/img/char/hu-tao-sama-1920.png -t && systemctl suspend
      echo "$(date) wakeup..." >> /tmp/oofed
      continue
    else
      echo "$(date) sleep canceled, idle $IDLE" >> /tmp/oofed
    fi
  else
    echo "$(date), idle: $IDLE, pid $P" >> /tmp/oofed
  fi

  if [[ $(cat /sys/class/power_supply/BAT0/status) == 'Discharging' && $(cat /sys/class/power_supply/BAT0/capacity) < $MINBATTERY ]]; then
    notify-send "low battery, sleep in 2 min..."
    sleep 120
    if [[ $(cat /sys/class/power_supply/BAT0/status) == 'Discharging' ]]; then
      echo "$(date) bat: $(cat /sys/class/power_supply/BAT0/capacity), sleeping low battery..." >> /home/deuzo/.local/share/oofed
      i3lock -i $HOME/img/char/hu-tao-sama-1920.png -t && systemctl suspend
      exit
    else
      echo "$(date) not sleeping, plugged in" >> /tmp/oofed
    fi
  fi

  # sleep 10 minute
  sleep 600
done


