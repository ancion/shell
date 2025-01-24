#!/bin/bash

file=$(mktemp)
grim -g "`slurp`" $file
hyprctl dispatch exec [float] feh $file
wl-copy < $file
