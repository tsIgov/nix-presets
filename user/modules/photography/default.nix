{ pkgs, config, lib, ... }:
let
	cfg = config.presets.photography;
in
{
	options = {
		presets.photography = with lib; with types; {
			enable = mkOption { type = bool; default = false; };
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			gimp
			rawtherapee
		];
	};
}