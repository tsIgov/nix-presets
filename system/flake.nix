{
	description = "Personal NixOS presets";

	outputs = inputs:
	let
		addPreset = import ./utilities/addPreset.nix;
	in
	{
		module = {
			imports = [
				(addPreset ./modules/garbageCollection null)
				(addPreset ./modules/nvidia null)
			];
		};
	};
}
