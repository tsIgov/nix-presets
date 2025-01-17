{ pkgs, lib, config, ... }:
let
	cfg = config.presets.softwareDevelopment;
in
{
	options.presets.softwareDevelopment = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
	};

	config = lib.mkIf cfg.enable {
		# Allows dynamic linking
		programs.nix-ld.enable = true;
	};

}