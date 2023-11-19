# blpearson44 Flake
Hello, and welcome to my flake! It's pretty barebones right now, I am drawing a bit of inspiration from some other sources, but trying to get everything going from the ground up.
# Install
As this project matures, I will update here with more detailed install instructions and an install script. Note that, as of this commit, this flake and system were created for a virtual machine. Installing as a host has not been tested.
In the meantime, install NixOS as described by [the official NixOS manual](https://nixos.org/manual/nixos/stable/#ch-installation), then clone this repository and run
`sudo nixos-rebuild switch --flake .#ben`
from the base of the repository. This should install all the needed packages and my dotfile configurations. If you would like to use your own dotfiles, be sure to change the REPO variable under `home-management/dotfiles.sh` and delete `dothash` so that it is re-generated.
`home-management/projects.sh` will look for a file called `home-management/projects` which includes links to github projects to be installed - it will then place these under `$HOME/projects` as separate github repos. If this file does not exist, then this script is skipped.
In the future these scripts may be written into my home-manager module.
