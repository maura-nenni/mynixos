{ pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		historyLimit = 10000;
		terminal = "tmux-256color";
		plugins = with pkgs;
		[
			tmuxPlugins.vim-tmux-navigator
			tmuxPlugins.sensible
			{
				plugin = tmuxPlugins.catppuccin;
				extraConfig = ''
					set -g @catppuccin_flavour 'frappe'
					set -g @catppuccin_window_tabs_enabled on
					set -g @catppuccin_date_time "%H:%M"
				'';
			}

			tmuxPlugins.yank

			{
				plugin = tmuxPlugins.resurrect;
				
				# pour restaurer les sessions nvim
				extraConfig = ''
					set -g @resurrect-strategy-nvim 'session'
					set -g @resurrect-processes 'nvim'
				'';
			}
		];

		extraConfig = ''
			set -ga terminal-overrides ",xterm-termite:Tc"
			# remplace prefice par <C-r>+<Spc>
			unbind C-b
			set -g prefix C-Space
			bind C-Space send-prefix

			# autorise la souris
			set -g mouse on
			setw -g mouse on

			# pour copier du texte entre les panes avec le vi copy-mode-vi
			# prefix+[ : entre en mode sélection
			# v : commence le surlignage
			# y : copie le surlignage
			# p : copie dans n'importe quel pane(+ vim)
			set-window-option -g mode-keys vi

			bind-key -T copy-mode-vi v send-keys -X begin-selection
			bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
			bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

			# Vim style pane selection
			bind h select-pane -L
			bind j select-pane -D 
			bind k select-pane -U
			bind l select-pane -R

		'';
	};	
}
