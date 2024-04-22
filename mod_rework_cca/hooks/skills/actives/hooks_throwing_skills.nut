foreach (throw_skill in [
	"throw_axe",
	"throw_balls",
	"throw_javelin",
	"throw_spear_skill"	
])
{
	::ModReworkCca.HooksMod.hook("scripts/skills/actives/" + throw_skill, function( q )
	{	
		q.m.IsSerialized = false
		// q.create = @(__original) function( )
		// {
		// 	__original()
		// }
		q.onAfterUpdate = @(__original) function( _properties  )
		{
			::logInfo(this.m.IsSerialized)
			__original( _properties )
			this.m.MaxRange = this.m.Item.getRangeMax() - (_properties.isCloseCombatArcher ? 1 : 0);
		}
	});
}
