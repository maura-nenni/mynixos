{
	description = "Maurane commence nixos";


	inputs = 
	{
        # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};

        tuxedo-nixos = {
            url = "github:blitz/tuxedo-nixos";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};


	
    outputs = inputs@{ self, ... }:	
		
		let
			system = "x86_64-linux";

			# configure pkgs
			pkgs = import inputs.nixpkgs {
				system = system;
				config = {
					allowUnfree = true;
					allowUnfreePredicate = (_: true);
				};
			};
			
			# configure lib
			lib = inputs.nixpkgs.lib;

			# configure home-manager
			home-manager = inputs.home-manager;


		in 
		{
			nixosConfigurations = {
				virt = lib.nixosSystem {
					system = system;
					modules = [ 
						./hosts/virt/configuration.nix
					];
					specialArgs = {
						inherit pkgs;
						inherit inputs;
					};
				};
				pulse = lib.nixosSystem {
					system = system;
					modules = [ 
						./hosts/pulse/configuration.nix

                        inputs.tuxedo-nixos.nixosModules.default
                        {	 
		                #	hardware.tuxedo-control-center.enable = true;
		                    hardware.tuxedo-keyboard.enable = true;
		                }
					];
					specialArgs = {
						inherit pkgs;
						inherit inputs;
					};
				};
                
			};

			homeConfigurations = {
				mau_virt = home-manager.lib.homeManagerConfiguration{
					inherit pkgs;
					modules = [ 
						./hosts/virt/home.nix
					];
					extraSpecialArgs = {
						inherit inputs;
					};
				};
				mau_pulse = home-manager.lib.homeManagerConfiguration{
					inherit pkgs;
					modules = [ 
						./hosts/pulse/home.nix
					];
					extraSpecialArgs = {
						inherit inputs;
					};
				};
			};
		};
}
