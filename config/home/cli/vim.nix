{ pkgs, ... }:

{
	programs.vim = {
		enable = true;
		settings = {
			copyindent = true;
			shiftwidth = 4;
			tabstop = 4;
			relativenumber = true;
		};
	};
		
}
