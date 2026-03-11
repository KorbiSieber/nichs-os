{ config, pkgs, ... }:

let
  monetLogo = pkgs.fetchurl {
    url = "https://upload.wikimedia.org/wikipedia/commons/1/1b/Claude_Monet_-_Woman_with_a_Parasol_-_Madame_Monet_and_Her_Son_-_Google_Art_Project.jpg";
    hash = "sha256-KLayosqpRBAsFHb8tQ4E0tSRTvSuCfvXz9GAM/l1Qt8=";
  };
in

{
    home.username = "korbi";
    home.homeDirectory = "/home/korbi";
    home.stateVersion = "25.05";

    home.file."Pictures/logo.jpg".source = monetLogo;

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        fastfetch
    ];

    # Zsh
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
                "git"
                "sudo"
                "docker"
            ];
        };

        initExtra = ''
            fastfetch --logo "/home/korbi/Pictures/logo.jpg" --logo-type "kitty" --logo-width 30 --logo-height 30
        '';
    };
}
