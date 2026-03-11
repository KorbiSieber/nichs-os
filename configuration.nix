# Configuration for nix systems

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
          ./hardware-configuration.nix
        ];
    
    # Bootloader
    boot.loader.grub.enable = true;
    boot.loader.grub.useOSProber = true;    

    # HostName
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
}