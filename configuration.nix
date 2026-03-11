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
}