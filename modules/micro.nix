{ inputs, config, pkgs, ... }:

{

	home.packages = [ pkgs.micro ];
	home.file.".config/micro/settings.json".text = ''

	{
	    "colorscheme": "twilight"
	}
	
	'';
	
}
