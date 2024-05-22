{ config, pkgs, userSettings,  ... }:

{
	imports = [
	];
    
    home.packages = with pkgs; [
        gnome.nautilus
    ];
	
    home.sessionVariables = {
		EDITOR = userSettings.editor;
		TERM = userSettings.term;
		BROWSER = userSettings.browser;
		SPAWNEDITOR = "exec " + userSettings.term + " -e " + userSettings.editor;
		DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
		DEFAULT_TERM = "${pkgs.kitty}/bin/kitty";
  	};
}
