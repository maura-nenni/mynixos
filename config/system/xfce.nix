{ ... }:

{

	imports = [
		./x11.nix
		];
  

  	# Enable the XFCE Desktop Environment.
  	services.xserver = {
		displayManager.lightdm = {
			enable = true;
		};
		desktopManager.xfce = {
			enable = true;
		};
	};
}
