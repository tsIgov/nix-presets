 path: pkgs: 
{lib, ...}@args: 
let
	newArgs = args // { inherit pkgs; };
	modules = lib.fileUtils.getNixFilesRecursively path;
in
{ 
	imports = if pkgs == null then modules else (builtins.map (file: import file newArgs) modules); 
}