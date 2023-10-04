{ config, pkgs, ... }:

{
  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
