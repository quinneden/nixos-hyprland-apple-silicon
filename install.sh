#!/usr/bin/env bash

init() {
    # Vars
    CURRENT_USERNAME='quinn'
    HOST='main'

    # Colors
    NORMAL=$(tput sgr0)
    WHITE=$(tput setaf 7)
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    BRIGHT=$(tput bold)
    UNDERLINE=$(tput smul)
}

confirm() {
    echo -en "[${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 0
    fi
}

print_header() {
    echo -E $CYAN'''
 __   __   __   __  __   ______   ______                                       
/\ "-.\ \ /\ \ /\_\_\_\ /\  __ \ /\  ___\                                      
\ \ \-.  \\ \ \\/_/\_\/_\ \ \/\ \\ \___  \                                     
 \ \_\\"\_\\ \_\ /\_\/\_\\ \_____\\/\_____\                                    
  \/_/ \/_/ \/_/ \/_/\/_/ \/_____/ \/_____/                                    
 __   __   __   ______   ______  ______   __       __       ______   ______    
/\ \ /\ "-.\ \ /\  ___\ /\__  _\/\  __ \ /\ \     /\ \     /\  ___\ /\  == \   
\ \ \\ \ \-.  \\ \___  \\/_/\ \/\ \  __ \\ \ \____\ \ \____\ \  __\ \ \  __<   
 \ \_\\ \_\\"\_\\/\_____\  \ \_\ \ \_\ \_\\ \_____\\ \_____\\ \_____\\ \_\ \_\ 
  \/_/ \/_/ \/_/ \/_____/   \/_/  \/_/\/_/ \/_____/ \/_____/ \/_____/ \/_/ /_/ 
                                                                               
'''
}

install() {
    echo -e "\n${RED}START INSTALL PHASE${NORMAL}\n"
    sleep 0.2

    if [[ ! -d $HOME/Documents && ! -d $HOME/Music && ! -d $HOME/Pictures/wallpapers ]]; then
        # Create basic directories
        echo -e "Creating folders:"
        echo -e "    - ${MAGENTA}~/Music${NORMAL}"
        echo -e "    - ${MAGENTA}~/Documents${NORMAL}"
        echo -e "    - ${MAGENTA}~/Pictures/wallpapers/others${NORMAL}"
        mkdir -p ~/Music
        mkdir -p ~/Documents
        mkdir -p ~/Pictures/wallpapers/others
        sleep 0.2
        # Copy the wallpapers
        echo -e "Copying all ${MAGENTA}wallpapers${NORMAL}"
        cp -r wallpapers/wallpaper.png ~/Pictures/wallpapers
        cp -r wallpapers/otherWallpaper/catppuccin/* ~/Pictures/wallpapers/others/
        cp -r wallpapers/otherWallpaper/nixos/* ~/Pictures/wallpapers/others/
        cp -r wallpapers/otherWallpaper/others/* ~/Pictures/wallpapers/others/
        sleep 0.2
    fi

    echo "Copying firmware..."
    if [[ ! -d $(pwd)/firmware ]]; then
        mkdir -p $(pwd)/firmware && sudo cp -r /boot/asahi/{all_firmware.tar.gz,kernelcache*} $(pwd)/firmware
    else
        sudo rm -rf $(pwd)/firmware/* && sudo cp -r /boot/asahi/{all_firmware.tar.gz,kernelcache*} $(pwd)/firmware
    fi
    sleep 0.2

    echo "Configuring hardware.nix..."
    if [[ -f /etc/nixos/hardware-configuration.nix ]]; then
        ROOT_UUID=$(cat /etc/nixos/hardware-configuration.nix | tr -d '{};=' | grep -A1 'fileSystems."/"' | grep -o 'uuid/.*"' | sed s/'uuid\/'/''/g | tr -d '"')
        BOOT_UUID=$(cat /etc/nixos/hardware-configuration.nix | tr -d '{};=' | grep -A1 'fileSystems."/boot"' | grep -o 'uuid/.*"' | sed s/'uuid\/'/''/g | tr -d '"')
        sed -i s/'ROOT_UUID'/"$ROOT_UUID"/g modules/core/hardware.nix
        sed -i s/'BOOT_UUID'/"$BOOT_UUID"/g modules/core/hardware.nix
    else
        ROOT_UUID=$(lsblk -l -f --noheadings /dev/nvme0n1 | tr -s ' ' | grep -i "nixos" | grep -v "/boot" | cut -f 4 -d ' ')
        BOOT_UUID=$(blkid -t TYPE=vfat | grep -o 'UUID="\w\{4\}-\w\{4\}"' | sed 's/UUID=//' | tr -d '"')
        sed -i s/'ROOT_UUID'/"$ROOT_UUID"/g modules/core/hardware.nix
        sed -i s/'BOOT_UUID'/"$BOOT_UUID"/g modules/core/hardware.nix
    fi
    unset ROOT_UUID
    unset BOOT_UUID
    sleep 0.2

    echo -en "You are about to start the system build, continue? "
    confirm

    echo -e "\nBuilding the system...\n"
    sudo nix --extra-experimental-features 'nix-command flakes' flake update
    sudo nixos-rebuild switch --flake .#main --impure
}

main() {
    init

    print_header

    install
}

main && exit 0
