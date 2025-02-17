{ config, lib, pkgs, ... }:

let
	cfg = config.presets.softwareDevelopment;
in
{
	config = lib.mkIf cfg.enable {
		programs.git = {
			enable = true;
			package = pkgs.git;
			userName  = cfg.git.username;
			userEmail = cfg.git.email;
		};
	};
}
