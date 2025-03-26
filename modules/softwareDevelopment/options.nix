{ lib, ... }:
{
	options.presets.softwareDevelopment = with lib; with types; {
		enable = mkOption { type = bool; default = false; };
		git = {
			username = mkOption { type = singleLineStr; };
			email = mkOption { type = singleLineStr; };
		};
		dotnet = {
			enable = mkOption { type = bool; default = false; };
			"8_0".enable = mkOption { type = bool; default = false; };
			"9_0".enable = mkOption { type = bool; default = false; };
		};
		node = {
			enable = mkOption { type = bool; default = false; };
		};
	};
}