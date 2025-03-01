{ lib, ... }:
{
	options.presets.music = with lib; with types; {
		spotify.enable = mkOption { type = bool; default = false; };
	};
}