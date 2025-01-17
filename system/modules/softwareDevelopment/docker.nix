{ lib, config, ... }:
let
	cfg = config.presets.softwareDevelopment;
in
{
	options.presets.softwareDevelopment.docker = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
	};

	config = lib.mkIf (cfg.enable && cfg.docker.enable) {
		virtualisation.docker = {
			enable = true;
			rootless = {
				enable = true;
				setSocketVariable = true;
			};
		};
	};

}