{ config, lib, pkgs, ... }:
let
	cfg = config.presets.digitalBrain;
in
{
	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			(obsidian.override { commandLineArgs = "--use-angle=vulkan"; })
		];
	};
}