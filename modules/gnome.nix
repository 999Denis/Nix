{
  pkgs,
  lib,
  config,
  ...
}: {
  	options.gnome = {
    	enable = lib.mkEnableOption "Gnome";
   };

  config = lib.mkIf config.gnome.enable {
    environment = {
      systemPackages = with pkgs; [
        morewaita-icon-theme
        qogir-icon-theme
        wl-clipboard
        ghostty
        gnomeExtensions.color-picker
      ];

      gnome.excludePackages = with pkgs; [
        gnome-console
        gnome-photos
        gnome-tour
        gnome-connections
        snapshot
        cheese
        epiphany
        geary
        evince
        totem
        yelp
        gnome-font-viewer
        gnome-shell-extensions
        gnome-maps
        gnome-music
        gnome-characters
        tali
        iagnoe
        hitori
        atomix
        gnome-contacts
        gnome-initial-setup
      ];
    };

    services.xserver = {
      desktopManager.gnome.enable = true;
    };

    programs.dconf.profiles.gdm.databases = [
      {
        settings = {
          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = true;
          };
          "org/gnome/desktop/interface" = {
            cursor-theme = "Qogir";
          };
        };
      }
    ];
  };
}
