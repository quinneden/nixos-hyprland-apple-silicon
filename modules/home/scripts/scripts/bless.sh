#!/usr/bin/env bash

function bless() {
  MAC=$(echo $1 | grep -y -E "mac|macos")
  NIX=$(echo $1 | grep -y -E "nix|nixos")

  if [[ -z $1 ]]; then
    sudo asahi-bless
  elif [[ -n $1 && -n $MAC ]]; then
    sudo asahi-bless --set-boot-macos -y $2 && echo "Boot set to MacOS."
  elif [[ -n $1 && -n $NIX ]]; then
      sudo asahi-bless --set-boot 2 -y $2 && echo "Boot set to NixOS."
  else
    sudo asahi-bless "$@"
  fi
}
