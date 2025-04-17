{ config, pkgs, inputs, ... }:

{
  home.username = "denis";
  home.homeDirectory = "/home/denis";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
	discord
	inputs.zen-browser.packages."${system}".default
  ];


  programs.home-manager.enable = true;

  
  nixpkgs.config.allowUnfree = true;


  systemd.user.startServices = "sd-switch";


  home.sessionVariables = {
    EDITOR = "micro";
    BROWSER = "firefox";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

}
