
{ config, lib, pkgs, inputs, ... }:

{

  networking.hostName = "Nix";
  system.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb.layout = "us";
  

  users.users.denis = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  

  home-manager = {
      extraSpecialArgs = { inherit inputs;};
      users = {
          "denis" = import ./home.nix;
      };
  };


  imports =
    [ 
        inputs.home-manager.nixosModules.default
      ./drives.nix
    ];


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


  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  networking.networkmanager.enable = true;


  services.xserver.enable = true;


  #programs.hyprland = {
  #	enable = true;
  #  package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #  portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  #};


  environment.systemPackages = with pkgs; [
    git
    micro
    neofetch
    fastfetch
    wget
  ];


  
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
