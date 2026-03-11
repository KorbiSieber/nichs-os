{ config, pkgs, ... }:

{
  home.username = "korbi";
  home.homeDirectory = "/home/korbi";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    # your zsh config here
  };
}
