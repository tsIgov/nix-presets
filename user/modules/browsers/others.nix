{ pkgs, config, lib, ...}:
let
	cfg = config.presets.browsers;
in
{
	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			tor-browser
			brave
		];
	};
}