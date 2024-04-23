foreach (throwing_weapon in [
	"items/weapons/throwing_axe",
	"items/weapons/throwing_spear",
	"items/weapons/javelin",
	"items/weapons/greenskins/goblin_spiked_balls"	
])
{
	::ModReworkCca.HooksMod.hook(throwing_weapon, function( q )
	{	
		q.getAdditionalRange = @( __original ) function( _actor )
		{
			return _actor.getCurrentProperties().isCloseCombatArcher ? -1 : 0;
		}
	});
}
