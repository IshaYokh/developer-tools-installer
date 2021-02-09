#!/bin/bash

# Author: IshaYokh
# Code repo: https://github.com/IshaYokh/developer-tools-installer

main(){
    # Array of programs to be installed
    tools=("vim" "net-tools" "curl" "ufw" "tmux" "neofetch" "htop" "python3" "python3-pip" "javascript-common" "npm" 
            "gcc" "g++" "make" "openjdk-8-jdk" "openjdk-8-dbg" "openjdk-8-jre" "git" "vsftpd" "apache2" "nordvpn"
            "xrdp" "nmap" "snap" "unrar" "dmg2img" "smbclient" "at" "cifs-utils" "samba" "wine" "wine32"
            "vlc" "qbittorrent" "remmina" "wireshark" "sqlitebrowser")

    # Array of services to be disabled after installing some tools
    services=("xrdp" "vsftpd" "apache2" "smbd")

    # Installing tools
    for tool in "${tools[@]}"; do
        # Checking if the tool to be installed is nordvpn then downloading the .deb file, adding it to repository and updating system
        if [[ $tool == "nordvpn" ]]; then
            sudo wget "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb"
            sudo dpkg -i nordvpn-release_1.0.0_all.deb
            updatesys
        fi

        # Enabling i386 architecture for wine 32 bit
        if [[ $tool == "wine32" ]]; then
            sudo dpkg --add-architecture i386
        fi

        sudo apt-get install $tool -y
    done

    # Disabling some service after installation
    for service in "${services[@]}"; do
        sudo systemctl stop $service && sudo systemctl disable $service
    done

    updatesys
}

updatesys(){
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
}

updatesys
main

# List of needed other tools that would need more of manual installation due to different versions and sources:
    # Visual studio code
    # Brackets
    # Eclipse
    # IntelliJ IDEA
    # Sublime text
    # Virtualbox
    # Sticky notes from snap store
    # Flameshot from snap store
    # Tweak tool for whatever desktop enviroment is being used (usually gnome)
    # Chrome
    # NodeJS/ReactJS
    # PHP 7
    # MySQL
    # Python pip packages: django, flask etc.

# Author: IshaYokh
# Code repo: https://github.com/IshaYokh/developer-tools-installer