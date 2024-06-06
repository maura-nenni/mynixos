{ pkgs, lib, ... }:

{
	networking.firewall = {
		enable = false;
		allowedTCPPorts = [ 80 443 38773 ];
		allowedUDPPorts = [ 80 443 38773 ];
		allowedUDPPortRanges = [
			{ from = 4000; to = 4007; }
			{ from = 8000; to = 8010; }
		];
	};
}
