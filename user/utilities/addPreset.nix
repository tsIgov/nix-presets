 path: pkgs: 
{ aetherLib, ... }@args: 
{ 
	imports = 
		if pkgs == null then 
			aetherLib.moduleUtils.listModulesRecursively path
		else 
			[ (aetherLib.moduleUtils.createRecursiveModuleWithOverrides path { inherit pkgs;}) ];
}