{ pkgs, ... }:

{
	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Inconsolata" ]; })
		powerline
		inconsolata
		iosevka
		font-awesome
		ubuntu_font_family
		terminus_font
	];
}

