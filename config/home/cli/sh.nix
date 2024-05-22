{ pkgs, ... }:

let
	
	myAliases = {
		ll = "ls -alF";
		la = "ls -A";
		c = "clear";
		".." = "cd .. && pwd";
		"..." = "cd .. && cd .. && pwd";
		"...." = "cd .. && cd .. && cd .. && pwd";
		
		# git aliases
		g = "git";
		st = "git status";
		com = "git commit -m";
		all = "git add .";
	};

in
{
	programs.bash = {
		enable = true;
		enableCompletion = true;
		shellAliases = myAliases;
        historyControl = [ "ignoredups" "erasedups" ];
        historySize = 1000;
        historyFileSize = 2000;
        bashrcExtra = ''
          # append to the history file, don't overwrite it
          shopt -s histappend

          # check the window size after each command and, if necessary,
          # update the values of LINES and COLUMNS.
          shopt -s checkwinsize

          # autocompletion depuis l'historique
          if [ -t 1 ]; then
              bind '"\e[A": history-search-backward'
              bind '"\e[B": history-search-forward'
          fi

      '';
          
	};
}
