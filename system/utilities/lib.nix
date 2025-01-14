{ nixpkgs }:
let
	lib = nixpkgs.lib;
	getNixFilesRecursively = path: builtins.filter (n: lib.strings.hasSuffix ".nix" (toString n)) (lib.filesystem.listFilesRecursive path);
in
{
	inherit 
		getNixFilesRecursively
	;
}