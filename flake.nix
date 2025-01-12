{
	description = "Personal NixOS presets";

	inputs = {
		lib.url = "github:nixos/nixpkgs/nixos-unstable";
		browsers.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = inputs:
	let
		system = "x86_64-linux";
		importArguments = { inherit system; config.allowUnfree = true; };

		lib = import ./utilities/lib.nix { nixpkgs = inputs.lib; };
		internalUtils = import ./utilities/internal.nix { inherit lib; };

		browsers-pkgs = import inputs.browsers importArguments;
	in
	{
		inherit lib;

		userModules = {
			browsers = internalUtils.createModule ./modules/browsers browsers-pkgs;
		} ;
	};
}
