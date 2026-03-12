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

    # ~/.config/nixpkgs/p10k.zsh
    home.file.".p10k.zsh".source = /home/korbi/.config/nixpkgs/p10k.zsh;

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
    fastfetch
    zsh-powerlevel10k
    ];

    # Zsh
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            code = "codium";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [
                "git"
                "sudo"
                "docker"
            ];
        };

        initExtra = ''
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

            fastfetch --logo "$HOME/Pictures/logo.jpg" --logo-type kitty --logo-width 45
        '';
    };

    # Kitty
    programs.kitty = {
        enable = true;
        font = {
            name = "JetBrains Mono";
            size = 13;
        };
        theme = "Adapta Nokto Maia";

        settings = {
            confirm_os_window_close = 0;
            cursor_shape = "beam";
            window_padding_width = 8;
            enable_audio_bell = false;
        };

        extraConfig = ''
            background_opacity 0.92
            dynamic_background_opacity yes
            background_blur 16
        '';
    };

    # Vscodium
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

        profiles.default.extensions = with pkgs.vscode-extensions; [
            ms-python.python
            charliermarsh.ruff
            mhutchie.git-graph
            waderyan.gitblame
            ms-toolsai.jupyter
        ];

        profiles.default.userSettings = {
            "editor.fontFamily" = "JetBrains Mono";
            "editor.formatOnSave" = true;
            "files.autoSave" = "afterDelay";
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
        };
    };
}
