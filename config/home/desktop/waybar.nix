{ pkgs, lib, ... }:

{
	programs.waybar = {
		enable = true;
		package = pkgs.waybar ;
		
		settings = [{
			layer =  "top"; # Waybar at top layer
    		position =  "top"; # Waybar position (top|bottom|left|right)
    		height =  50; # Waybar height (to be removed for auto height)
    		spacing =  5; # Gaps between modules (4px)
    		margin-bottom = -11;
    
			# Choose the order of the modules
			modules-left =  ["hyprland/workspaces"];
    		modules-right =  [ "battery" "temperature" "network" "bluetooth" "pulseaudio" "clock" "custom/exit" ];
    		modules-center =  ["custom/dynamic_pill"];
    

			# Modules configuration

    		# custom modules ########
			"custom/dynamic_pill" = {
				return-type = "json";
				exec = "bash ~/.dotfiles/config/home/desktop/scripts/start_dyn";
				escape = true;
			};

			"custom/ss" = {
				format = "{}";
				exec = "bash ~/.dotfiles/config/home/desktop/scripts/expand ss-icon";
				on-click = "bash ~/.dotfiles/config/home/desktop/scripts/screenshot_full";
			};
			
			"custom/cycle_wall" = {
				format = "{}";
				exec = "bash ~/.dotfiles/config/home/desktop/scripts/expand wall";
				on-click = "bash ~/.dotfiles/config/home/desktop/scripts/expand cycle";
			};
			
			"custom/expand" = {
				on-click = "bash ~/.dotfiles/config/home/desktop/scripts/expand_toolbar";
				format = "{}";
				exec = "bash ~/.dotfiles/config/home/desktop/scripts/expand arrow-icon";
			};

			"custom/exit" = {
				tooltip = false;
		        format = "";
          		on-click = "sleep 0.1 && wlogout";
    		};

			
			"keyboard-state" = {
				numlock = true;
				capslock = true;
				format = "{name} {icon}";
				format-icons = {
					locked = "";
					unlocked = "";
				};
			};

			"hyprland/workspaces" = {
				format = "{icon}";
				format-active = " {icon} ";
				on-click = "activate";
			};

			"sway/mode" = {
				format = "<span style=\"italic\">{}</span>";
			};

			"mpd" = {
				format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
				format-disconnected = "Disconnected ";
				format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
				unknown-tag = "N/A";
				interval = 2;
				consume-icons = {
					on = " ";
				};
				random-icons = {
					off = "<span color=\"#f53c3c\"></span> ";
					on = " ";
				};
				repeat-icons = {
					on = " ";
				};
				single-icons = {
					on = "1 ";
				};
				state-icons = {
					paused = "";
					playing = "";
				};
				tooltip-format = "MPD (connected)";
				tooltip-format-disconnected = "MPD (disconnected)";
			};
			
			"idle_inhibitor" = {
				format = "{icon}";
				format-icons = {
					activated = "";
					deactivated = "";
				};
			};

			"tray" = {
				spacing = 10;
			};

			"clock" = {
				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
				interval = 60;
				format = "{:%H:%M}";
				max-length = 25;
			};

			"cpu" = {
				interval = 1;
				format = "{icon0} {icon1} {icon2} {icon3}";
				format-icons = ["▁"  "▂"  "▃"  "▄"  "▅"  "▆"  "▇"  "█"];
			};

			"memory" = {
				format = "{}% ";
			};

			"temperature" = {
				critical-threshold = 80;
				format-critical = "{temperatureC}°C";
				format = "";
			};

			"bluetooth" = {
				tooltip = false;
				format = "";
				format-off = "󰂲";
				on-click = "blueman-manager";
			};

			"backlight" = {
				format = "{percent}% {icon}";
				format-icons = [""  ""  ""  ""  ""  ""  ""  ""  ""];
			};

			"battery" = {
				states = {
					warning = 30;
					critical = 15;
				};
				format = "{icon}";
				format-charging = "󰂄";
				format-plugged = "󱘖";
				format-icons = [
					"󰁺"
					"󰁻"
					"󰁼"
					"󰁽"
					"󰁾"
					"󰁿"
					"󰂀"
					"󰂁"
					"󰂂"
					"󰁹"
			  	];
				on-click = "";
				tooltip = true;
				tooltip-format = "{capacity}%";
			};

			"battery#bat2" = {
				bat = "BAT2";
			};

			"network" = {
        		format-icons = [
        			"󰤯"
		            "󰤟"
        		    "󰤢"
		            "󰤥"
		            "󰤨"
        		];
	        	format-ethernet = " {bandwidthDownOctets}";
        		format-wifi = "{icon} {signalStrength}%";
        		format-disconnected = "󰤮";
        		tooltip = false;
				on-click = "kitty --hold nmtui";
    		};
	

			"pulseaudio" = {
	        	format = "{icon} {volume}% {format_source}";
        		format-bluetooth = "{volume}% {icon} {format_source}";
        		format-bluetooth-muted = " {icon} {format_source}";
        		format-muted = " {format_source}";
        		format-source = " {volume}%";
        		format-source-muted = "";
        		format-icons = {
        			headphone = "";
        			hands-free = "";
        			headset = "";
        			phone = "";
        			portable = "";
        			car = "";
        			default = [
            			""
            			""
            			""
        			];
        		};
        		on-click = "sleep 0.1 && pavucontrol";
    		};
	

			"custom/media" = {
				format = "{icon} {}";
				return-type = "json";
				max-length = 40;
				format-icons = {
					spotify = "";
					default = "🎜";
				};
				escape = true;
				exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
				# "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" # Filter player based on name
			};
		}];

		style = lib.concatStrings [''
			* {
    			font-family: FiraCode , Noto Sans,FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    			font-size: 13px;
			}

			#clock,
			#battery,
			#cpu,
			#memory,
			#disk,
			#temperature,
			#backlight,
			#bluetooth,
			#network,
			#pulseaudio,
			#custom-media,
			#tray,
			#mode,
			#idle_inhibitor,
			#custom-expand,
			#custom-cycle_wall,
			#custom-ss,
			#custom-dynamic_pill,
			#custom-exit,
			#mpd {
				padding: 0 10px;
				border-radius: 15px;
				background: #11111b;
				color: #b4befe;
				box-shadow: rgba(0, 0, 0, 0.116) 2px 2px 5px 2px;
				margin-top: 10px;
				margin-bottom: 10px;
				margin-right: 10px;
			}

			window#waybar {
				background-color: transparent;
			}

			#custom-dynamic_pill label {
				color: #11111b;
				font-weight: bold;
			}

			#custom-dynamic_pill.paused label {
				color: 	#89b4fa ;
				font-weight: bolder; 
			}

			#workspaces button label{
				color: 	#89b4fa ;
				font-weight: bolder;
			}

			#workspaces button.active label{
				color: #11111b;
				font-weight: bolder;
			}

			#workspaces{
				background-color: transparent;
				margin-top: 10px;
				margin-bottom: 10px;
				margin-right: 10px;
				margin-left: 25px;
			}
			#workspaces button{
				box-shadow: rgba(0, 0, 0, 0.116) 2px 2px 5px 2px;
				background-color: #11111b ;
				border-radius: 15px;
				margin-right: 10px;
				padding: 10px;
				padding-top: 4px;
				padding-bottom: 2px;
				font-weight: bolder;
				color: 	#89b4fa ;
				transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
			}

			#workspaces button.active{
				padding-right: 20px;
				box-shadow: rgba(0, 0, 0, 0.288) 2px 2px 5px 2px;
				padding-left: 20px;
				padding-bottom: 3px;
				background: rgb(203,166,247);
				background: radial-gradient(circle, rgba(203,166,247,1) 0%, rgba(193,168,247,1) 12%, rgba(249,226,175,1) 19%, rgba(189,169,247,1) 20%, rgba(182,171,247,1) 24%, rgba(198,255,194,1) 36%, rgba(177,172,247,1) 37%, rgba(170,173,248,1) 48%, rgba(255,255,255,1) 52%, rgba(166,174,248,1) 52%, rgba(160,175,248,1) 59%, rgba(148,226,213,1) 66%, rgba(155,176,248,1) 67%, rgba(152,177,248,1) 68%, rgba(205,214,244,1) 77%, rgba(148,178,249,1) 78%, rgba(144,179,250,1) 82%, rgba(180,190,254,1) 83%, rgba(141,179,250,1) 90%, rgba(137,180,250,1) 100%); 
				background-size: 400% 400%;
				animation: gradient_f 20s ease-in-out infinite;
				transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
			}

			@keyframes gradient {
				0% {
					background-position: 0% 50%;
				}
				50% {
					background-position: 100% 30%;
				}
				100% {
					background-position: 0% 50%;
				}
			}

			@keyframes gradient_f {
				0% {
					background-position: 0% 200%;
				}
				50% {
					background-position: 200% 0%;
				}
				100% {
					background-position: 400% 200%;
				}
			}

			@keyframes gradient_f_nh {
				0% {
					background-position: 0% 200%;
				}
				100% {
					background-position: 200% 200%;
				}
			}



			#custom-dynamic_pill.low{
				background: rgb(148,226,213);
				background: linear-gradient(52deg, rgba(148,226,213,1) 0%, rgba(137,220,235,1) 19%, rgba(116,199,236,1) 43%, rgba(137,180,250,1) 56%, rgba(180,190,254,1) 80%, rgba(186,187,241,1) 100%); 
				background-size: 300% 300%;
				text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
				animation: gradient 15s ease infinite;
				font-weight: bolder;
				color: #fff;
			}
			#custom-dynamic_pill.normal{
				background: rgb(148,226,213);
				background: radial-gradient(circle, rgba(148,226,213,1) 0%, rgba(156,227,191,1) 21%, rgba(249,226,175,1) 34%, rgba(158,227,186,1) 35%, rgba(163,227,169,1) 59%, rgba(148,226,213,1) 74%, rgba(164,227,167,1) 74%, rgba(166,227,161,1) 100%); 
				background-size: 400% 400%;
				animation: gradient_f 4s ease infinite;
				text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
				font-weight: bolder;
				color: #fff;
			}
			#custom-dynamic_pill.critical{
				background: rgb(235,160,172);
				background: linear-gradient(52deg, rgba(235,160,172,1) 0%, rgba(243,139,168,1) 30%, rgba(231,130,132,1) 48%, rgba(250,179,135,1) 77%, rgba(249,226,175,1) 100%); 
				background-size: 300% 300%;
				animation: gradient 15s cubic-bezier(.55,-0.68,.48,1.68) infinite;
				text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
				font-weight: bolder;
				color: #fff;
			}

			#custom-dynamic_pill.playing{
				background: rgb(137,180,250);
				background: radial-gradient(circle, rgba(137,180,250,120) 0%, rgba(142,179,250,120) 6%, rgba(148,226,213,1) 14%, rgba(147,178,250,1) 14%, rgba(155,176,249,1) 18%, rgba(245,194,231,1) 28%, rgba(158,175,249,1) 28%, rgba(181,170,248,1) 58%, rgba(205,214,244,1) 69%, rgba(186,169,248,1) 69%, rgba(195,167,247,1) 72%, rgba(137,220,235,1) 73%, rgba(198,167,247,1) 78%, rgba(203,166,247,1) 100%); 
				background-size: 400% 400%;
				animation: gradient_f 9s cubic-bezier(.72,.39,.21,1) infinite;
				text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
				font-weight: bold;
				color: #fff ;
			}

			#custom-dynamic_pill.paused{
				background: #11111b ;
				font-weight: bolder;
				color: #b4befe;
			}

			#custom-ss{
				background: #11111b;
				color: #89b4fa;
				font-weight:  bolder;
				padding: 5px;
				padding-left: 20px;
				padding-right: 20px;
				border-radius: 15px;
			}


			#custom-cycle_wall{
				background: rgb(245,194,231);
				background: linear-gradient(45deg, rgba(245,194,231,1) 0%, rgba(203,166,247,1) 0%, rgba(243,139,168,1) 13%, rgba(235,160,172,1) 26%, rgba(250,179,135,1) 34%, rgba(249,226,175,1) 49%, rgba(166,227,161,1) 65%, rgba(148,226,213,1) 77%, rgba(137,220,235,1) 82%, rgba(116,199,236,1) 88%, rgba(137,180,250,1) 95%); 
				color: #fff;
				background-size: 500% 500%;
				animation: gradient 7s linear infinite;
				font-weight:  bolder;
				border-radius: 15px;
			}

			#clock label{
				color: #11111b;
				font-weight:  bolder;
			}

			#clock {
				background: rgb(205,214,244);
				background: linear-gradient(118deg, rgba(205,214,244,1) 5%, rgba(243,139,168,1) 5%, rgba(243,139,168,1) 20%, rgba(205,214,244,1) 20%, rgba(205,214,244,1) 40%, rgba(243,139,168,1) 40%, rgba(243,139,168,1) 60%, rgba(205,214,244,1) 60%, rgba(205,214,244,1) 80%, rgba(243,139,168,1) 80%, rgba(243,139,168,1) 95%, rgba(205,214,244,1) 95%); 

				background-size: 200% 300%;

				animation: gradient_f_nh 4s linear infinite;
				margin-right: 25px;
				color: #fff ;
				text-shadow: 0 0 5px rgba(0, 0, 0, 0.377);
				
				font-size: 15px;
				padding-top: 5px;
				padding-right: 21px;
				font-weight: bolder;
				padding-left: 20px;
			}

			#battery.charging, #battery.plugged {
				background-color: #94e2d5 ;
			}

			#battery {
				background-color: #11111b;
				color:#a6e3a1;
				font-weight: bolder;
				font-size: 20px;
				padding-left: 15px;
				padding-right: 15px;
			}

			@keyframes blink {
				to {
					background-color: #f9e2af;
					color:#96804e;
				}
			}



			#battery.critical:not(.charging) {
				background-color:  #f38ba8;
				color:#bf5673;
				animation-name: blink;
				animation-duration: 0.5s;
				animation-timing-function: linear;
				animation-iteration-count: infinite;
				animation-direction: alternate;
			}

			#cpu label{
				color:#89dceb;
			}

			#cpu {
				background: rgb(30,30,46);
				background: radial-gradient(circle, rgba(30,30,46,1) 30%, rgba(17,17,27,1) 100%); 
				color: 	#89b4fa;
			}

			#memory {
				background-color: #cba6f7;
				color: 	#9a75c7;
				font-weight: bolder;
			}

			#disk {
				color: #964B00;
			}

			#backlight {
				color: #90b1b1;
			}

			#network{
				color:#000;
			}

			#bluetooth{
				background-color:#90b1b1;
				color: #fff;
			}

			#network.disabled{
				background-color: #90b1b1;
			}

			#network.disconnected{
				background: rgb(243,139,168);
				background: linear-gradient(45deg, rgba(243,139,168,1) 0%, rgba(250,179,135,1) 100%); 
				color: #fff;
				font-weight: bolder;
				padding-top: 3px;
				padding-right: 11px;
			}

			#network.linked, #network.wifi{
				background-color: #a6e3a1 ;
			}

			#network.ethernet{
				background-color:#f9e2af ;
			}

			#pulseaudio {
				background-color:  	#fab387;
				color: #bf7d54;
				font-weight: bolder;
			}

			#pulseaudio.muted {
				background-color: #90b1b1;
			}

			#custom-media {
				color: #66cc99;
			}

			#custom-media.custom-spotify {
				background-color: #66cc99;
			}

			#custom-media.custom-vlc {
				background-color: #ffa000;
			}

			#temperature {
				background-color: #f9e2af;
				color:#96804e;
			}

			#temperature.critical {
				background-color: #f38ba8 ;
				color:#bf5673;
			}

			#tray {
				background-color: #2980b9;
			}

			#tray > .passive {
				-gtk-icon-effect: dim;
			}

			#tray > .needs-attention {
				-gtk-icon-effect: highlight;
				background-color: #eb4d4b;
			}

			#custom-exit {
          		background-color: #eb4d4b;
          		color: #fff;
				padding-right: 10px;
        	}

		''];
	};
}


