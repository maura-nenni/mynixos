{ pkgs, config, ... }:

{
	services = {
		xserver = {
			enable = true;
			excludePackages = [ pkgs.xterm ];
			xkb.layout = "fr";
		};
		
		libinput.enable = true;
		displayManager.sddm = {
			enable = true;
			wayland.enable = true;
			theme = "tokyo-night-sddm";
		};
	};


  environment.systemPackages = [
    (pkgs.libsForQt5.callPackage ./sddm-tokyo-night.nix {})
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
