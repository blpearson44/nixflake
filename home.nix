{ config, pkgs, ... }:

{
  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  xdg.configFile = {
   "kitty".source = ./config/kitty;
   "starship.toml".source = ./config/starship.toml;
   "ranger".source = ./config/ranger;
   "i3".source = ./config/i3;
   "nvim".source = ./config/nvim;
   "tmux".source = ./tmux;
  };
  home.file = {
    ".bashrc".source = ./home/.bashrc;
    "wallpapers".source = ./home/wallpapers;
  };

  programs = {
    git = {
      enable = true;
      userName = "Ben Pearson";
      userEmail = "blpearson44@icloud.com";
      lfs.enable = true;
    };

  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
