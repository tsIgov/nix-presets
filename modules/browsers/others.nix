{ pkgs, ...}:
{
	home.packages = with pkgs; [
		tor-browser
		brave
	];
}