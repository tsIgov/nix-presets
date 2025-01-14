{ lib, config, pkgs, ... }:
let
	cfg = config.presets.garbageCollection;
in
{
	options = with lib; with types; {
		presets.garbageCollection = {
			enable = mkOption { type = bool; default = false; description = "Automatically run the garbage collector."; };
			schedule = mkOption { type = singleLineStr; default = "Mon 06:00"; description = "How often or when garbage collection is performed. This value must be a calendar event in the format specified by {manpage}`systemd.time(7)`."; };
			daysOld = mkOption { type = ints.positive; default = 7; description = "Delete all inactive generations older than the specified amount of days."; };
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.services.garbage-collector = {
			description = "Nix Garbage Collector";
			script = ''
				for USER_HOME in /home/*; do
					if [ -d "$USER_HOME" ]; then
						USERNAME=$(basename "$USER_HOME")
						${config.security.sudo.package}/bin/sudo -u "$USERNAME" ${pkgs.home-manager}/bin/home-manager expire-generations "-${toString cfg.daysOld} days"
					fi
				done

				${config.nix.package.out}/bin/nix-collect-garbage --delete-older-than ${toString cfg.daysOld}d
				${config.nix.package.out}/bin/nix-store --optimise
			'';
			serviceConfig.Type = "oneshot";
			startAt = cfg.schedule;
		};

		systemd.timers.garbage-collector = {
			timerConfig = {
				Persistent = true;
			};
		};
	};
}
