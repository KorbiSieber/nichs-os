{ config, pkgs, ... }:

{
    home.username = "korbi";
    home.homeDirectory = "/home/korbi";
    home.stateVersion = "25.05";

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
            fastfetch 
        '';
    };
}
