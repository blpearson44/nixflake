{ config, pkgs, ... }:

{
  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # xdg.configFile = {
  #  "kitty/kitty.conf".source = ./config/kitty/kitty.conf;
  #  # "starship.toml".source = ./config/starship.toml;
  #  "ranger/rifle.conf".source = ./config/ranger/rifle.conf;
  #  "ranger/rc.conf".source = ./config/ranger/rc.conf;
  #  "i3".source = ./config/i3/config;
  #  "tmux".source = ./config/tmux;
  # };
  # home.file = {
  #   ".bashrc".source = ./home/.bashrc;
  #   "wallpapers".source = ./home/wallpapers;
  # };

  programs = {
    git = {
      enable = true;
      userName = "Ben Pearson";
      userEmail = "blpearson44@icloud.com";
      lfs.enable = true;
    };
    starship =
      let
        flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
      in
      {
        enable = true;
        settings = {
          # Other config here
          format = "$all"; # Remove this line to disable the default prompt format
          palette = "catppuccin_${flavour}";
        } // builtins.fromTOML (builtins.readFile
          (pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "starship";
              rev = "5629d23"; # Replace with the latest commit hash
              sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
            } + /palettes/${flavour}.toml));
      };
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
