{ pkgs, config, lib, ...}:
let
	cfg = config.presets.browsers.tor;
in
{
	options.presets.browsers.tor = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			tor-browser
		];
	};
}