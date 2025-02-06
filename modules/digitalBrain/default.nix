{ lib, ... }:
{
	options.presets.digitalBrain = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
	};
}