{ lib, ... }:
{
	options.presets.browsers = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
	};
}