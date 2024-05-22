{ pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
            # nix lang
            bbenoist.nix
            # nix-shell support
            arrterian.nix-env-selector
            # python
            ms-python.python
            # C/C++
            ms-vscode.cpptools

            # color theme
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
        ];

        keybindings = [
            {
                key = "ctrl+q";
                command = "editor.action.commentLine";
                when = "editorTextFocus && !editorReadonly";
            }
            {
                key = "ctrl+s";
                command = "workbench.action.files.saveFiles";
            }
        ];
    };
}

