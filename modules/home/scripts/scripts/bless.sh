#!/usr/bin/env bash

if [[ -z $1 ]]; then
  sudo asahi-bless
elif [[ -n $1 && $1 == *mac* ]]; then
  sudo asahi-bless --set-boot-macos -y && echo "Boot set to MacOS."
elif [[ -n $1 && $1 == *nix* ]]; then
    sudo asahi-bless --set-boot 2 -y && echo "Boot set to NixOS."
else
  sudo asahi bless "$1"
fi
