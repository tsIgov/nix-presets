{ config, lib, pkgs, ... }:

let
	cfg = config.presets.softwareDevelopment;
in
{
	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			(vscode.override { commandLineArgs = "--password-store=\"gnome-libsecret\" --use-angle=vulkan"; }).fhs
		];
	};
}
