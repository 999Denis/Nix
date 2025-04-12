
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./drives.nix
      inputs.home-manager.nixosModules.default
    ];

  home-manager = {
      extraSpecialArgs = { inherit inputs;};
      users = {
          "denis" = import ./home.nix;
      };
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nix";


  networking.networkmanager.enable = true;


  time.timeZone = "Europe/Rome";


  i18n.defaultLocale = "en_US.UTF-8";


  services.xserver.enable = true;


  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


  services.xserver.xkb.layout = "us";


  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  users.users.denis = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };


  programs.firefox.enable = true;


  nixpkgs.config.allowUnfree = true;


  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
  	graphics.enable = true;
  	nvidia = {
  		modesetting.enable = true;
  		open = true;
  		nvidiaSettings = true;
  		package = config.boot.kernelPackages.nvidiaPackages.beta;
  	};
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 

  system.stateVersion = "24.11";

}

