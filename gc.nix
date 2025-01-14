{ pkgs, config, lib, ... }:

let
  cfg = config.aether.system.garbage-collection;
in
{
	options = with lib; with types; {
		aether.system.garbage-collection = {
			automatic = mkOption { type = bool;	description = "Automatically run the garbage collector."; };
			schedule = mkOption { type = singleLineStr; description = "How often or when garbage collection is performed. This value must be a calendar event in the format specified by {manpage}`systemd.time(7)`."; };
			days-old = mkOption { type = ints.positive; description = "Delete all inactive generations older than the specified amount of days."; 	};
		};
	};

	config = {
		systemd.services.system-gc = lib.mkIf cfg.automatic {
			description = "Nix Garbage Collector";
			script = ''
				${config.nix.package.out}/bin/nix-collect-garbage --delete-older-than ${toString cfg.days-old}d
				${config.nix.package.out}/bin/nix-store --optimise
			'';
			serviceConfig.Type = "oneshot";
			startAt = cfg.schedule;
		};

		systemd.timers.system-gc = lib.mkIf cfg.automatic {
			timerConfig = {
				Persistent = true;
			};
		};



		systemd.user.services.user-gc = lib.mkIf cfg.automatic {
			description = "Garbage collector for home manager generations.";
			script = ''
				${pkgs.home-manager}/bin/home-manager expire-generations "-${toString cfg.days-old} days"
			'';
			serviceConfig.Type = "oneshot";
			startAt = cfg.schedule;
		};

		systemd.user.timers.user-gc = lib.mkIf cfg.automatic {
			timerConfig = {
				Persistent = true;
			};
		};
	};
}