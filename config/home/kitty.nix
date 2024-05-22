{ pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		kitty
	];
	
	programs.kitty.enable = true;
	programs.kitty.settings = {
		background_opacity = lib.mkForce "0.75";
		font_family = "FiraCodeNF";
		font_size = "12.0";
	};
	 
}

