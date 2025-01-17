{ config, lib, pkgs, ... }:
let
	cfg = config.presets.digitalBrain;
in
{
	options.presets.digitalBrain.syncthing = with lib; with types; {
		certPath = mkOption { type = singleLineStr; };
		keyPath = mkOption { type = singleLineStr; };
		port = mkOption { type = port; default = 8384; };
	};

	config = lib.mkIf cfg.enable {
		services.syncthing = {
			enable = true;
			package = pkgs.syncthing;
			cert = cfg.syncthing.certPath;
			key = cfg.syncthing.keyPath;
			guiAddress = "127.0.0.1:${toString cfg.syncthing.port}";
			overrideDevices = true;
			overrideFolders = true;
			settings = {
				devices = {
					phone = {
						autoAcceptFolders = true;
						id = "2FXGDWQ-KA760UY-IYYNRDK-JVYG2VM-04T45JJ-NDDBWEA-YNJDBPD-LNPNAAP";
						name = "Pixel 6";
					};
				};
				folders = {
					digital-brain = {
						enable = true;
						id = "rr581-ecaao";
						label = "digital-brain";
						devices = [ "phone" ];
						copyOwnershipFromParent = false;
						path = "~/digital-brain";
						type = "sendreceive";
					};
				};
				options = {
					urAccepted = -1;
					relaysEnabled = true;
					localAnnounceEnabled = false;
				};
			};
		};
	};
}
