foreach (throw_skill in [
	"throw_axe",
	"throw_balls",
	"throw_javelin",
	"throw_spear_skill"	
])
{
	::ModReworkCca.HooksMod.hook("scripts/skills/actives/" + throw_skill, function( q )
	{
		q.onAfterUpdate = @(__original) function( _properties  )
		{
			onAfterUpdate( _properties )
			this.m.MaxRange = this.m.Item.getRangeMax() - (_properties.hasPerk("perk.close_combat_archer") ? 1 : 0);
		}
	});
}
