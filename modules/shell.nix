{ inputs, config, pkgs, ... }:

{
    # Fish
    home.file.".config/fish/functions/fish_greeting.fish".text = '''';
	home.packages = [ pkgs.eza ];
	programs.fish = {
		enable = true;
		shellAliases = {
			nixr = "sudo nixos-rebuild switch --flake ~/Nix#system --impure";
			nixc = "sudo micro ~/Nix/system/config.nix";
			nixe = "sudo nix-collect-garbage -d && sudo nixos-rebuild switch --flake ~/Nix#system";
			homec = "sudo micro ~/Nix/system/home.nix";
			flakec = "sudo micro ~/Nix/flake.nix";
			flakeu = "cd ~/Nix && sudo nix flake update";
			ls = "eza --icons";
		};
	};


	# Starship
	programs.starship.enable = true;
	home.file.".config/starship.toml".text = ''
# Don't print a new line at the start of the prompt
add_newline = false
# Pipes ╰─ ╭─
# Powerline symbols                                     
# Wedges 🭧🭒 🭣🭧🭓
# Random noise 🬖🬥🬔🬗

# format = """
# $cmd_duration$username$hostname $directory $git_branch
# $character
# """
format = """
$cmd_duration$directory $git_branch
$character
"""

# Replace the "❯" symbol in the prompt with "➜"
[character]                            # The name of the module we are configuring is "character"
success_symbol = "[• ](bold fg:white) "
error_symbol = "[• 󰅙](bold fg:red) "

# Disable the package module, hiding it from the prompt completely
[package]
disabled = true

[git_branch]
style = "bg: blue"
symbol = "󰘬"
truncation_length = 4
truncation_symbol = ""
format = "• [](bold fg:cyan)[$symbol $branch(:$remote_branch)](fg:black bg:cyan)[ ](bold fg:cyan)"

[git_commit]
commit_hash_length = 4
tag_symbol = " "

[git_state]
format = '[\($state( $progress_current of $progress_total)\)]($style) '
cherry_pick = "[🍒 PICKING](bold red)"

[git_status]
conflicted = " 🏳 "
ahead = " 🏎💨 "
behind = " 😰 "
diverged = " 😵 "
untracked = " 🤷 ‍"
stashed = " 📦 "
modified = " 📝 "
staged = '[++\($count\)](green)'
renamed = " ✍️ "
deleted = " 🗑 "

[hostname]
ssh_only = false
format =  "[•$hostname](bg:cyan bold fg:black)[](bold fg:cyan )"
trim_at = ".companyname.com"
disabled = false

[line_break]
disabled = false

[memory_usage]
disabled = true
threshold = -1
symbol = " "
style = "bold dimmed green"

[time]
disabled = true
format = '🕙[\[ $time \]]($style) '
time_format = "%T"

[username]
style_user = "bold bg:cyan fg:black"
style_root = "red bold"
format = "[](bold fg:cyan)[$user]($style)"
disabled = false
show_always = true

[directory]
home_symbol = "  "
read_only = "  "
style = "bg:cyan fg:black"
truncation_length = 6
truncation_symbol = "••/"
format = '[](bold fg:cyan)[$path ]($style)[](bold fg:cyan)'


[directory.substitutions]
"Desktop" = "  "
"Documents" = "  "
"Downloads" = "  "
"Music" = " 󰎈 "
"Pictures" = "  "
"Videos" = "  "

[cmd_duration]
min_time = 0
format = '[](bold fg:blue)[ $duration](bold bg:blue fg:black)[](bold fg:blue) •• '
	'';
}
