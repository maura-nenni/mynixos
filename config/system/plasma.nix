{ ... }:

{

	imports = [
		./x11.nix
		./pipewire.nix
		./dbus.nix
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
