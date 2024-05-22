{ config, pkgs, ... }:
let
	name = "maura-nenni";
	email = "mme_x.w@tuta.io";

in{
	home.packages = [ pkgs.git ];
	programs.git.enable = true;
	programs.git.userName = name;
	programs.git.userEmail = email;
	programs.git.extraConfig = {
	};
}
