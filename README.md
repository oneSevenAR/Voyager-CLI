# Voyager CLI

Voyager CLI is a small command-line tool that fetches NASAs Voyager 1 and Voyager 2 Earth-distance data directly from NASAs backend file (distance_data.js). The script interpolates the distance using NASAs timestamps and prints the current distance and one-way light time.

When used with the watch command the output updates every second.

## Installation User Mode Recommended

This installs voyager into your home bin directory.

### Option 1 One line install
curl -fsSL https://raw.githubusercontent.com/oneSevenAR/Voyager-CLI/main/install.sh | bash

### Option 2 Safer manual installation
curl -fsSL https://raw.githubusercontent.com/oneSevenAR/Voyager-CLI/main/install.sh -o install.sh
bash install.sh

After installation open a new terminal or run
source ~/.bashrc

## Installation System Wide

This installs voyager into usr local bin which requires sudo

curl -fsSL https://raw.githubusercontent.com/oneSevenAR/Voyager-CLI/main/install.sh -o install.sh
sudo bash install.sh --system

## Usage

voyager

For live updates every second
watch -n 1 -t voyager

## What This Tool Does

Downloads NASAs distance_data.js file  
Extracts Voyager Earth distance  
Interpolates live distance using NASAs timestamps  
Uses NASAs real velocities  
Computes one way light time  
Prints formatted output  

## Uninstall

User mode
rm -f ~/bin/voyager

System mode
sudo rm -f /usr/local/bin/voyager

## Repository
https://github.com/oneSevenAR/Voyager-CLI
