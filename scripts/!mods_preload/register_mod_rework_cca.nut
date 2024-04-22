::ModReworkCca <- {
	ID = "mod_rework_cca",
	Name = "Mod Rework Close Combat Archer",
	Version = "1.0.0"
};

::ModReworkCca.HooksMod <- ::Hooks.register(::ModReworkCca.ID, ::ModReworkCca.Version, ::ModReworkCca.Name);


// add which mods are needed to run this mod
::ModReworkCca.HooksMod.require("mod_msu >= 1.2.6", "mod_modern_hooks");

// like above you can add as many parameters to determine the queue order of the mod before adding the parameter to run the callback function. 
::ModReworkCca.HooksMod.queue(">mod_msu", ">mod_legends", ">mod_sellswords", function()
{
	// define mod class of this mod
	::ModReworkCca.Mod <- ::MSU.Class.Mod(::ModReworkCca.ID, ::ModReworkCca.Version, ::ModReworkCca.Name);

	// load hook files
	::include("rework_cca_hooks/load.nut");
}, ::Hooks.QueueBucket.Normal);