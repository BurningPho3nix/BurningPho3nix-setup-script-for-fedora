#!/bin/bash

echo "Welcome to the my repository installer!"

PS3='Please enter your choice: '

options=("Install RPM Fusion Free" "Install RPM Fusion Free Tainted" "Install RPM Fusion Non-Free" "Install RPM Fusion Non-Free Tainted" "Install Flathub (only needed if not enabled on first boot or if using a spin)" "Install All" "Update" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install RPM Fusion Free")
            sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf groupupdate -y core
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPM"
  else
    echo "Failed to install RPM"
    exit 1
  fi
            ;;
            
        "Install RPM Fusion Free Tainted")
            sudo dnf install -y rpmfusion-free-release-tainted
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPMs"
  else
    echo "Failed to install RPMs"
    exit 1
  fi
            ;;
            
        "Install RPM Fusion Non-Free")
            sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf groupupdate -y core
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPM"
  else
    echo "Failed to install RPM"
    exit 1
  fi
            ;;
            
        "Install RPM Fusion Non-Free Tainted")
            sudo dnf install -y rpmfusion-nonfree-release-tainted
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPM"
  else
    echo "Failed to install RPM"
    exit 1
  fi
            ;;
            
            "Install Flathub (only needed if not enabled on first boot or if using a spin)")
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            if [ $? -eq 0 ]; then
    echo "Successfully enabled Flathub"
  else
    echo "Failed to enable Flathub"
    exit 1
  fi
            ;;
            
        "Install All")
            sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf groupupdate -y core
            sudo dnf install -y rpmfusion-free-release-tainted
            sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            sudo dnf install -y rpmfusion-nonfree-release-tainted
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            if [ $? -eq 0 ]; then
    echo "Successfully installed RPMs"
  else
    echo "Failed to install RPMs"
    exit 1
  fi
            ;;
            
        "Update")
            sudo dnf update -y && flatpak update -y
            if [ $? -eq 0 ]; then
    echo "Successfully installed updates"
  else
    echo "Failed to install updates"
    exit 1
  fi
            ;;
            
        "Quit")
       if [ -f "start.sh" ]; then
        chmod +x start.sh
        ./start.sh
      else
        echo "The start.sh script does not exist."
      fi
      break
      ;;
      
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Thank you for using the my repository installer! Goodbye."
