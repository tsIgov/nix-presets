{ lib }:
let
	createModule = path: pkgs: 
		args: 
		let
			newArgs = args // { inherit pkgs; };
			modules = lib.getNixFilesRecursively path;
		in
		{ 
			imports = if pkgs == null then modules else (builtins.map (file: import file newArgs) modules); 
		};
in
{
	inherit 
		createModule
	;
}