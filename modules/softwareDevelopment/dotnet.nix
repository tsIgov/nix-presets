{ config, lib, pkgs, ... }:

let
	cfg = config.presets.softwareDevelopment;

	packages_8_0 = 
		if cfg.dotnet."8_0".enable then 
			with pkgs.dotnetCorePackages; [
				sdk_8_0
				runtime_8_0
				aspnetcore_8_0
			]
		else 
			[ ];

	packages_9_0 = 
		if cfg.dotnet."9_0".enable then 
			with pkgs.dotnetCorePackages; [
				sdk_9_0
				runtime_9_0
				aspnetcore_9_0
			]
		else 
			[ ];

	dotnet-full = with pkgs.dotnetCorePackages; combinePackages (packages_8_0 ++ packages_9_0);
in
{
	config = lib.mkIf (cfg.enable && cfg.dotnet.enable) {

		home.packages = [
			dotnet-full
		];

		systemd.user.sessionVariables = {
			DOTNET_ROOT = "${dotnet-full}/share/dotnet";
		};

		home.sessionPath = [
			"${dotnet-full}/share/dotnet"
		];

	};
}
