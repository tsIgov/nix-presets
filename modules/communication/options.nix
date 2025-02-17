{ lib, ... }:
{
	options.presets.communication = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
		slack.enable = mkOption { type = bool; default = false; };
	};
}