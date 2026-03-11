# Configuration for nix systems

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
          ./hardware-configuration.nix
        ];
}