 {pkgs, ... }:

{
	# configure x11
  	services.xserver = {
		enable = true;
    	layout = "fr";
    	xkbVariant = "";
		excludePackages = [ pkgs.xterm ];
 	};
}
