{ config, lib, pkgs, ... }:
let 
	cfg = config.presets.nvidia;
	driverName = if cfg.drivers == "nouveau" then "nouveau" else "nvidia";
	openDriver = (cfg.drivers == "nvidia");
in
{
	options.presets.nvidia = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
		drivers = mkOption { type = enum [ "nvidia" "nvidia-proprietary" "nouveau" "disabled" ]; default = "nvidia"; };
		prime = {
			enable = mkOption { type = bool; default = false; };
			type = mkOption { type = enum [ "offload" "sync" "reverseSync" ]; default = "offload"; };
		};
	};

	config = lib.mkIf (cfg.enable) {
		boot.blacklistedKernelModules = lib.mkIf (cfg.drivers == "disabled") 
			[ "nvidia" "nvidiafb" "nvidia-drm" "nvidia-uvm" "nvidia-modeset" "nouveau" ];

		hardware.nvidia = lib.mkIf (cfg.drivers == "nvidia" || cfg.drivers == "nvidia-proprietary") {
			modesetting.enable = true;
			powerManagement.enable = true;
			powerManagement.finegrained = false;
			open = openDriver;
			nvidiaSettings = true;

			prime = lib.mkIf (cfg.prime.enable) (
				let
					script = builtins.readFile ./getGraphicsControllers.sh;
					controllersJSON = pkgs.runCommand "getGraphicsControllers" { nativeBuildInputs = [ pkgs.pciutils ]; } script;
					controllers = builtins.fromJSON (builtins.readFile controllersJSON);
				in
				{
					intelBusId = controllers.intel;
					nvidiaBusId = controllers.nvidia;
					amdgpuBusId = controllers.amd;

					offload = lib.mkIf (cfg.prime.type == "offload") {
						enable = true;
						enableOffloadCmd = true;
					};

					sync.enable = lib.mkIf (cfg.prime.type == "sync") true;
					reverseSync.enable = lib.mkIf (cfg.prime.type == "reverseSync") true;
				}
			);
		};

		services.xserver.videoDrivers =  lib.mkIf (cfg.drivers != "disabled" ) [ driverName ];
		boot.kernelParams = lib.mkIf (cfg.drivers == "nouveau") [ "nouveau.modeset=1" ];
	};
}