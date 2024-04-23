foreach (throw_skill in [
	"throw_axe",
	"throw_balls",
	"throw_spear_skill",
	"throw_javelin"	
])
{
	::ModReworkCca.HooksMod.hook("scripts/skills/actives/" + throw_skill, function( q )
	{	
		q.m.IsSerialized = false
		q.onAfterUpdate = @(__original) function( _properties )
		{
			__original( _properties )
			this.m.MaxRange = this.m.Item.getRangeMax() - (_properties.isCloseCombatArcher ? 1 : 0);
		}
	});
}
