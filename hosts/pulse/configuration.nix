# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:
let

    timezone = "Europe/Paris";
    locale = "fr_FR.UTF-8";
    name = "Maurane";
    username = "mauw";

in{
	imports =
	[   # Include the results of the hardware scan.
		./hardware-configuration.nix

		../../config/system/pipewire.nix
		../../config/system/bluetooth.nix
		../../config/system/printing.nix
		../../config/system/dbus.nix
		../../config/system/fonts.nix
		../../config/system/opengl.nix
		../../config/system/displaymanager.nix
		../../config/system/hyprland.nix
		../../config/system/portal.nix
		../../config/system/polkit.nix
		
	];
    
	# enable flakes
	nix.package = pkgs.nixFlakes;
	nix.extraOptions = ''
		experimental-features = nix-command flakes
	'';

	# probleme avec nodjs 14 et flake
	# nixpkgs.config.permittedInsecurePackages = [ "nodejs-14.21.3" ];

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Bootloader.
	# boot.loader.grub.enable = true;
	# boot.loader.grub.device = "/dev/sda";
	# boot.loader.grub.useOSProber = true;
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Networking
	networking.hostName = "nixos";
	networking.networkmanager.enable = true;
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# timezone et locale
	time.timeZone = timezone;
	i18n.defaultLocale = locale;
	i18n.extraLocaleSettings = {
	LC_ADDRESS = locale;
	LC_MEASUREMENT = locale;
	LC_MONETARY = locale;
	LC_NAME = locale;
	LC_NUMERIC = locale;
	LC_PAPER = locale;
	LC_TELEPHONE = locale;
	LC_TIME =locale;
	};

	# User account
	users.users.${username} = {
	    isNormalUser = true;
	    description = name;
	    extraGroups = [ "networkmanager" "wheel" "input" "dialout" "audio" "video" ];
	    packages = [];
	};

	# Configure console keymap
	console.keyMap = "fr";

	# List packages installed in system profile. 
	environment.systemPackages = with pkgs; [
	vim 
	wget
	git
	curl
	htop
	btop
	home-manager
	# wpa_supplicant
	nodejs
	cargo
	
	polkit_gnome
	];

	# shell lang
	environment.shells = with pkgs; [ bash ];
	users.defaultUserShell = pkgs.bash;

	fonts.fontDir.enable = true;


	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?
}
