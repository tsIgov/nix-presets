{ config, lib, pkgs, ... }:
let 
	cfg = config.presets.nvidia;
	driverName = if cfg.drivers == "nouveau" then "nouveau" else "nvidia";
	openDriver = (cfg.drivers == "nvidiaOpen");
in
{
	options.presets.nvidia = with lib; with types; {
		drivers = mkOption { type = enum [ "nvidiaOpen" "nvidia" "nouveau" "disabled" null ]; default = null; };
		prime = mkOption { type = enum [ "offload" "sync" "reverseSync" "disabled"]; default = "disabled"; };
	};

	config = lib.mkIf (cfg.drivers != null) {
		boot.blacklistedKernelModules = lib.mkIf (cfg.drivers == "disabled") 
			[ "nvidia" "nvidiafb" "nvidia-drm" "nvidia-uvm" "nvidia-modeset" "nouveau" ];

		hardware.nvidia = lib.mkIf (cfg.drivers == "nvidia" || cfg.drivers == "nvidiaOpen") {
			modesetting.enable = true;
			powerManagement.enable = true;
			powerManagement.finegrained = false;
			open = openDriver;
			nvidiaSettings = true;

			prime = lib.mkIf (cfg.prime != "disabled") (
				let
					script = builtins.readFile ./getGraphicsControllers.sh;
					controllersJSON = pkgs.runCommand "getGraphicsControllers" { nativeBuildInputs = [ pkgs.pciutils ]; } script;
					controllers = builtins.fromJSON (builtins.readFile controllersJSON);
				in
				{
					intelBusId = controllers.intel;
					nvidiaBusId = controllers.nvidia;
					amdgpuBusId = controllers.amd;

					offload = lib.mkIf (cfg.prime == "offload") {
						enable = true;
						enableOffloadCmd = true;
					};

					sync.enable = lib.mkIf (cfg.prime == "sync") true;
					reverseSync.enable = lib.mkIf (cfg.prime == "reverseSync") true;
				}
			);
		};

		services.xserver.videoDrivers =  lib.mkIf (cfg.drivers != "disabled" ) [ driverName ];
		boot.kernelParams = lib.mkIf (cfg.drivers == "nouveau") [ "nouveau.modeset=1" ];
	};
}