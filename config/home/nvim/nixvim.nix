{ pkgs, ...}:

{
    programs.nixvim = {
        enable = true;

        globals.mapleader = "<Space>";

        opts = {
            relativenumber = true;
            incsearch = true;
            tabstop = 4;
            shiftwidth = 4;
            smartindent = true;
            hlsearch = false;
            termguicolors = true;
        };

    };

}
