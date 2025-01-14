{
	description = "Personal NixOS presets";

	inputs = {
		lib.url = "github:nixos/nixpkgs/nixos-unstable";

		browsers.url = "github:nixos/nixpkgs/nixos-unstable";
		photography.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = inputs:
	let
		system = "x86_64-linux";
		importArguments = { inherit system; config.allowUnfree = true; };

		lib = import ./utilities/lib.nix { nixpkgs = inputs.lib; };
		internalUtils = import ./utilities/internal.nix { inherit lib; };

		browsers-pkgs = import inputs.browsers importArguments;
		photography-pkgs = import inputs.browsers importArguments;
	in
	{
		inherit lib;

		module = {
			imports = [ 
				(internalUtils.createModule ./modules/browsers browsers-pkgs)
				(internalUtils.createModule ./modules/photography photography-pkgs)
			];
		};
	};
}
