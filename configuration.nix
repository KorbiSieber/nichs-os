# /etc/nixos/configuration.nix

{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in

{
    system.stateVersion = "25.05";

    imports = [
        ./hardware-configuration.nix
        (import "${home-manager}/nixos")
    ];

    # Bootloader
    boot.loader.grub.enable = true;
    boot.loader.grub.useOSProber = true;
    boot.loader.grub.device = "/dev/sda";

    # Hostname
    networking.hostName = "nichsOS";

    # Timezone
    time.timeZone = "Europe/Berlin";

    # Locale
    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
    };
    console.keyMap = "de";

    # Audio
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Networking
    networking.networkmanager.enable = true;

    # Users
    users.users.korbi = {
        isNormalUser = true;
        description = "korbi";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };

    # Zsh
    programs.zsh.enable = true;

    # Home Manager
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";
    home-manager.users.korbi = import /home/korbi/.config/nixpkgs/home.nix;

    # System-wide packages
    environment.systemPackages = with pkgs; [
        git
        vim
        curl
        wget
        firefox
    ];

    # GNOME
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.libinput.enable = true;
    services.xserver.xkb.layout = "de";
}
