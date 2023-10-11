{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define hostname
  networking.networkmanager.enable = true;

  time.timeZone = "US/Pacific";

  services = {
    picom.enable = true;
    xserver = {
      enable = true;
      resolutions = [
        {
	  x = 2560;
	  y = 1440;
	}
      ];
      xrandrHeads = [
        {
	  output = "Virtual-1";
	  primary = true;
	}
      ];
      desktopManager = {
        xterm.enable = false;
	xfce = {
	  enable = true;
	  noDesktop = true;
	  enableXfwm = false;
	};
      };
      windowManager.i3 = {
        package = pkgs.i3-gaps;
        enable = true;
	extraPackages = with pkgs; [
	  dmenu
	  i3status
	  i3lock
	];
      };
      layout = "us";
      libinput.enable = true;
      displayManager = {
        defaultSession = "xfce+i3";
      };
    };
  
  };
  # Programs
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  # ZRAM
  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ben = {
    isNormalUser = true;
    initialPassword = "abc@123";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.Mesonflags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    fira-code
    meslo-lgs-nf
    jetbrains-mono

  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    eza
    feh
    bat
    wget
    meson
    gcc
    git
    kitty
    ranger
    tmux
    firefox
    starship
    picom
    zip
    unzip
    python3
  ];

  # Enable VMWare Tools
  virtualisation.vmware.guest.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  system.stateVersion = "23.05"; # Did you read the comment?
  # Enable flakes if not built from a flake
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}

