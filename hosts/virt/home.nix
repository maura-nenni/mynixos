{ inputs, config, pkgs, ... }:
let
    username = "mau";

in{
    imports = [
        inputs.nixvim.homeManagerModules.nixvim
        inputs.hyprland.homeManagerModules.default

        ../../config/home/cli
        ../../config/home/nvim/nixvim.nix
		../../config/home/kitty.nix
		../../config/home/vscodium.nix
		
        ../../config/home/desktop/hyprland.nix
  	];

  	# Let Home Manager install and manage itself.
  	programs.home-manager.enable = true;

	# Home Manager needs a bit of information about you and the paths it should
  	# manage.
  	home.username = username;
  	home.homeDirectory = "/home/" + username;

  	# This value determines the Home Manager release that your configuration is
  	# compatible with. This helps avoid breakage when a new Home Manager release
  	# introduces backwards incompatible changes.
  	#
  	# You should not change this value, even if you update Home Manager. If you do
  	# want to update the value, then make sure to first check the Home Manager
  	# release notes.
  	home.stateVersion = "23.11"; # Please read the comment before changing.

	# paquets pour le user
  	home.packages = with pkgs; [
        # bureautique
		libreoffice-fresh
        obsidian

        # music
        spotify
		
        # media
        vlc
		mpv
		ffmpeg
        
        # browser
        firefox
        google-chrome
        
        # C/C++
        gcc
        gnumake
        cmake
        autoconf
        automake
        libtool
        
        # python
        python3Full
        pystring
        micromamba
		
        # cli utils
        killall
		timer
		gnugrep
		fd
		ripgrep
		rsync
		unzip
		pandoc
		hwinfo
		tree
		htop
  	];

	news.display = "silent";
}
