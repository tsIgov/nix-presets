{ config, lib, pkgs, ... }:

let
	cfg = config.presets.softwareDevelopment;
in
{
	config = lib.mkIf (cfg.enable && cfg.node.enable) {
		home.packages = with pkgs; [
			nodejs_23
		];
	};
}
