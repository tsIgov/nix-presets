{ lib, ... }:
{
	options.presets.communication = with lib; with types; {
		slack.enable = mkOption { type = bool; default = false; };
	};
}