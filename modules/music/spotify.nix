{ config, lib, pkgs, ... }:
let
	cfg = config.presets.music.spotify;
in
{
	config = lib.mkIf (cfg.enable) {
		home.packages = with pkgs; [
			spotify
		];
	};
}
