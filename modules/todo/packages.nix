{pkgs, ...}: {
  imports = [
    ./packages1.nix
    ./blocks1.nix
    ./nx-switch1.nix
  ];

  packages = with pkgs; {
    linux = [
      (mpv.override {scripts = [mpvScripts.mpris];})
      nodejs
      go
      rustc
      cargo
	
      vscode
      curl
      openvpn
      obsidian

	  firefox
	  chromium

	  warp-terminal
	  linux-wifi-hotspot # --> wihotspot
    ];
    cli = [
      bat
      eza
      fd
      ripgrep
      fzf
      lazydocker
      lazygit
	  gh
	  
	  cmatrix
	  neofetch
    ];
  };
}
