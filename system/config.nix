
{ config, lib, pkgs, inputs, ... }:

{

  imports =
	[ 
		inputs.home-manager.nixosModules.default
     		./drives.nix
     		../modules/gnome.nix
    ];

  environment.systemPackages = with pkgs; 
	[
	git
    	fastfetch
    	wget
    	kitty
  	];

  users.users.denis = 
	{
		isNormalUser = true;
    		extraGroups = [ "wheel" "networkmanager" ];
  	};

  home-manager = 
	{
		extraSpecialArgs = { inherit inputs;};
      	users = 
      		{
          		"denis" = import ./home.nix;
      		};
  	};

  programs.hyprland = 
	{
		enable = true;
  		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};
	
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware = 
  	{
  		graphics.enable = true;
  		nvidia = 
  			{
  				modesetting.enable = true;
  				open = true;
  				nvidiaSettings = true;
  				package = config.boot.kernelPackages.nvidiaPackages.beta;
  			};
  	};


  boot = 
  	{
    		kernelPackages = pkgs.linuxPackages_zen;
    		kernelModules = [ "v4l2loopback" ];
    		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    		
    		kernel.sysctl = 
    			{
      				"vm.max_map_count" = 2147483642;
    			};
    		
    		tmp = 
    			{
      				useTmpfs = false;
      				tmpfsSize = "30%";
    			};
    			
    		binfmt.registrations.appimage = 
    			{
      				wrapInterpreterInShell = false;
      				interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      				recognitionType = "magic";
      				offset = 0;
      				mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      				magicOrExtension = ''\x7fELF....AI\x02'';
    			};
    			
    		plymouth.enable = true;
  	};


  services.pipewire = 
  	{
    	enable = true;
    	pulse.enable = true;
  	};


  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb.layout = "us";
  networking.networkmanager.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "Nix";
  system.stateVersion = "24.11";

}
