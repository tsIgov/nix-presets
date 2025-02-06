{ pkgs, config, lib, ...}:
let
	cfg = config.presets.browsers.brave;
in
{
	options.presets.browsers.brave = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			(brave.override { commandLineArgs = "--use-angle=vulkan"; })
		];
	};
}