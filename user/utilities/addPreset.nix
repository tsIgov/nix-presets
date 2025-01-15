 path: pkgs: 
{lib, ...}@args: 
{ 
	imports = 
		if pkgs == null then 
			lib.moduleUtils.listModulesRecursively path
		else 
			[ (lib.moduleUtils.createRecursiveModuleWithOverrides path { inherit pkgs;}) ];
}