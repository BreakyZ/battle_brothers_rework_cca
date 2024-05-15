foreach (throwing_weapon in [
	"throwing_axe",
	"throwing_spear",
	"javelin",
	"greenskins/goblin_spiked_balls"
])
{
	::ModReworkRangedCombat.HooksMod.hook("scripts/items/weapons/" + throwing_weapon, function( q )
	{
		q.getAdditionalRange = @( __original ) function( _actor )
		{
			return _actor.getCurrentProperties().isCloseCombatArcher ? -1 : 0;
		}
	});
}
