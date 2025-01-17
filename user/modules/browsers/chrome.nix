{ pkgs, config, lib, ...}:
let
	cfg = config.presets.browsers.chrome;
in
{
	options.presets.browsers.chrome = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
      		(google-chrome.override { commandLineArgs = "--use-angle=vulkan"; })
		];
	};
}