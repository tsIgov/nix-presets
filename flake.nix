{
	description = "Personal NixOS presets";

	inputs = {
		browsers.url = "github:nixos/nixpkgs/nixos-unstable";
		communication.url = "github:nixos/nixpkgs/nixos-unstable";
		photography.url = "github:nixos/nixpkgs/nixos-unstable";
		digitalBrain.url = "github:nixos/nixpkgs/nixos-unstable";
		music.url = "github:nixos/nixpkgs/nixos-unstable";
		softwareDevelopment.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = inputs:
	let
		system = "x86_64-linux";
		importArguments = { inherit system; config.allowUnfree = true; };
		addPreset = import ./utilities/addPreset.nix;

		browsers-pkgs = import inputs.browsers importArguments;
		communication-pkgs = import inputs.communication importArguments;
		photography-pkgs = import inputs.photography importArguments;
		digitalBrain-pkgs = import inputs.digitalBrain importArguments;
		music-pkgs = import inputs.music importArguments;
		softwareDevelopment-pkgs = import inputs.softwareDevelopment importArguments;
	in
	{
		module = {
			imports = [ 
				(addPreset ./modules/browsers browsers-pkgs)
				(addPreset ./modules/communication communication-pkgs)
				(addPreset ./modules/digitalBrain digitalBrain-pkgs)
				(addPreset ./modules/photography photography-pkgs)
				(addPreset ./modules/music music-pkgs)
				(addPreset ./modules/softwareDevelopment softwareDevelopment-pkgs)
			];
		};
	};
}
