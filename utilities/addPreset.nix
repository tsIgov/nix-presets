 path: pkgs: 
{ aether, ... }@args: 
{ 
	imports = 
		if pkgs == null then 
			aether.lib.moduleUtils.listModulesRecursively path
		else 
			[ (aether.lib.moduleUtils.createRecursiveModuleWithOverrides path { inherit pkgs;}) ];
}