{ pkgs, lib, inputs, ... }:

{
	imports = [
		./waybar.nix
		./wofi.nix
		./dunst.nix
		./wlogout.nix
		./hyprlock.nix
	];

	home.packages = with pkgs; [
		wl-clipboard
		wl-clip-persist
		clipman
		networkmanagerapplet
		gnome.nautilus
		socat
		waybar-mpris
		swww
		libcanberra-gtk3
		];

    wayland.windowManager.hyprland = {
        enable = true;

		xwayland.enable = true;

		systemd.enable = true;


        plugins = [
            #inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
			#inputs.hycov.packages."${pkgs.system}".hycov
        ];

        settings = {
			general = {
				sensitivity = 1.0;
				gaps_in = 8;
				gaps_out = 15;
				border_size = 3;
    			
				apply_sens_to_raw = 0; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)

				"col.active_border" = "rgba(cba6f7ff) rgba(89b4faff) rgba(94e2d5ff) 10deg";
    			"col.inactive_border" = "0xff45475a";
    			"col.nogroup_border" = "0xff89dceb";
    			"col.nogroup_border_active" = "0xfff9e2af";
			};
			
			input = {
				kb_layout = "fr";

				follow_mouse = 1;

				numlock_by_default = true;

				touchpad = {
					natural_scroll = "yes";
				};
			};

			monitor = [
				"eDP-1,preferred,auto-right,1"
			 	"HDMI-A-1,preferred,auto-left,1"
			];


			env = [
				#"GDK_BACKEND,wayland,x11,*"
				#"QT_QPA_PLATFORM,wayland;xcb"
				#"SDL_VIDEODRIVER,wayland"
				#"CLUTTER_BACKEND,wayland"
				#"NIXOS_OZONE_WL, 1"

				#"QT_AUTO_SCREEN_SCALE_FACTOR,1"
				#"QT_QPA_PLATFORM,wayland;xcb"
				#"QT_WAYLAND_DISABLE_WINDODECORATION,1"
				#"QT_QPA_PLATFORMTHEME,qt5ct"

				"XDG_CURRENT_DESKTOP, Hyprland"
				"XDG_SESSION_DESKTOP, Hyprland"
				"XDG_SESSION_TYPE, wayland"

				"export GTK_THEME=Tokyonight-Dark"
			];

			decoration = {
				drop_shadow = "true";
    			shadow_range = 100;
    			shadow_render_power = 5;
    			"col.shadow" = "0x33000000";
    			"col.shadow_inactive" = "0x22000000";
    			rounding = 15;
			};

			animations = {
				enabled = 1;
				bezier = "overshot,0.13,0.99,0.29,1.1";
    			animation = [
					"windows,1,4,overshot,slide"
    				"border,1,10,default"
    				"fade,1,10,default"
    				"workspaces,1,6,overshot,slidevert"
				];
			};

			dwindle = {
				pseudotile = 1;
				force_split = 0;
			};

			gestures = {
				workspace_swipe = "yes";
				workspace_swipe_fingers = 4;
			};
			
			# exec-once = "$HOME/.dotfiles/config/home/desktop/autostart";
			exec-once = [
				# run polkit
				"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &"

				# notification daemon
				"dunst &"

				# bar waybar
				"waybar"
				"$HOME/.dotfiles/config/home/desktop/scripts/dynamic &"

				# wallpaper
				"bash $HOME/.dotfiles/config/home/desktop/scripts/wall $HOME/.dotfiles/themes/wallpapers/bushes.jpg &"

				# others
				"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"

				# favorit apps
				"[workspace 1 silent] firefox"
				"[workspace 2 silent] kitty"
				"[workspace 3 silent] spotify"
				"[workspace 4 silent] obsidian"

				# move workspace to monitor
				"bash $HOME/.dotfiles/config/home/desktop/handle_monitor_connect.sh"

				# bluetooth and network
				"nm-applet --indicator & disown"
				"blueman-applet"

				# clipboard manager
				# "wl-paste -p -t text --watch clipman store -P --histpath=~/.local/share/clipman-primary.json"
				"wl-paste -t text --watch clipman store --no-persist"
			];

			windowrule = [
				"move center,title:^(fly_is_kitty)$"
				"size 800 500,title:^(fly_is_kitty)$"
				"animation slide,title:^(all_is_kitty)$"
				"float,title:^(all_is_kitty)$"
				"tile,title:^(kitty)$"
				"float,title:^(fly_is_kitty)$"
				"float,title:^(clock_is_kitty)$"
				"size 418 234,title:^(clock_is_kitty)$"
			];

			plugin = {
				#hycov = {
				#	overview_gappo = 60; #gaps width from screen
                #    overview_gappi = 24; #gaps width from clients
                #	hotarea_size = 10; #hotarea size in bottom left,10x10
                #	enable_hotarea = 1; # enable mouse cursor hotarea
                #};
			};

			bindm = [
				"SUPER,mouse:272,movewindow"
				"ALT,mouse:272,resizewindow"
			];
			
			bind = [
				"SUPER,t,exec,kitty --start-as=fullscreen -o 'font_size=25' --title all_is_kitty"
				"SUPER,RETURN,exec,kitty --title fly_is_kitty"
				"ALT,RETURN,exec,kitty --single-instance"
				",Print,exec,~/Images/screenshot"
				"SUPER,Q,killactive,"
				"SUPER,M,exit,"
				"SUPER,E,exec,nautilus"
				"SUPER,S,togglefloating,"
				"SUPER,space,exec,wofi --show drun -o DP-3"
				"SUPER,P,pseudo,"
				"SUPER, F, fullscreen, 0"
				"SUPER, Z, fullscreen, 1"
				
				#"ALT, tab, hycov:toggleoverview"
				#"ALT, left, hycov:movefocus, l"
				#"ALT, right, hycov:movefocus, r"
				#"ALT, up, hycov:movefocus, u"
				#"ALT, down, hycov:movefocus, d"

				"SUPER,L,exec,~/.dotfiles/config/home/desktop/scripts/lock"

				"SUPER,left,movefocus,l"
				"SUPER,right,movefocus,r"
				"SUPER,up,movefocus,u"
				"SUPER,down,movefocus,d"

				"SUPER,ampersand,workspace,1"
				"SUPER,eacute,workspace,2"
				"SUPER,quotedbl,workspace,3"
				"SUPER,apostrophe,workspace,4"
				"SUPER,parenleft,workspace,5"
				"SUPER,minus,workspace,6"
				"SUPER,egrave,workspace,7"
				"SUPER,underscore,workspace,8"
				"SUPER,ccedilla,workspace,9"
				"SUPER,agrave,workspace,10"

				"ALT,ampersand,movetoworkspace,1"
				"ALT,eacute,movetoworkspace,2"
				"ALT,quotedbl,movetoworkspace,3"
				"ALT,apostrophe,movetoworkspace,4"
				"ALT,parenleft,movetoworkspace,5"
				"ALT,minus,movetoworkspace,6"
				"ALT,egrave,movetoworkspace,7"
				"ALT,underscore,movetoworkspace,8"
				"ALT,ccedilla,movetoworkspace,9"
				"ALT,agrave,movetoworkspace,10"

				"SUPER,mouse_down,workspace,e+1"
				"SUPER,mouse_up,workspace,e-1"

				"SUPER,g,togglegroup"
				"SUPER,tab,changegroupactive"

				# ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
				", XF86AudioMute, exec, bash $ĤOME/.dotfiles/config/home/desktop/scripts/volume.sh mute"

				"SUPER, V, exec, clipman pick -t wofi"

				"CTRL,ampersand,exec,kitty --title fly_is_kitty --hold cava"
				"CTRL,eacute,exec,code-insiders"
				"CTRL,quotedbl,exec,kitty --single-instance --hold donut.c"
				"CTRL,apostrophe,exec,kitty --title clock_is_kitty --hold tty-clock -C5"
			];

			binde = [
				", XF86AudioRaiseVolume, exec, bash $HOME/.dotfiles/config/home/desktop/scripts/volume.sh up"
				", XF86AudioLowerVolume, exec, bash $HOME/.dotfiles/config/home/desktop/scripts/volume.sh down"

				# ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
				# ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
				", XF86MonBrightnessDown, exec, brightnessctl set 5%- "
				", XF86MonBrightnessUp, exec, brightnessctl set 5%+ "
			];

        };
    };
}
