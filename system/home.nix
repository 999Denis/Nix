{ config, pkgs, inputs, ... }:

{
  home.username = "denis";
  home.homeDirectory = "/home/denis";
  home.stateVersion = "24.11";


  imports =
  	[
  	];

  	
  home.packages = with pkgs; 
  	[
		discord
		firefox
		rofi
		gedit
		nautilus
  	];

  programs.home-manager.enable = true;

  
  nixpkgs.config.allowUnfree = true;


  systemd.user.startServices = "sd-switch";


  home.sessionVariables = {
    EDITOR = "gedit";
    BROWSER = "firefox";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

}
