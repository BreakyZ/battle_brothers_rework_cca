::ModReworkCca.HooksMod.hook("scripts/skills/perks/perk_close_combat_archer", function( q )
{
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local bonus = this.getContainer().getActor().getCurrentProperties().getRangedDefense() / 100;
		local range = this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile());
		local negbonus = 0

		if (_skill.isRanged())
		{	
			if (range == 2)
			{
				_properties.DamageRegularMult *= 1.0 + bonus;
				_properties.DamageArmorMult *= 1.0 + bonus;
			}
			else if (range == 3)
			{
				_properties.DamageRegularMult *= (1.0 + bonus / 3.0);
				_properties.DamageArmorMult *= 1.0 + bonus / 3.0;
			}
			else if (range >= 4)
			{
				negbonus = this.Math.max(0, 1.0 - (range * 0.05 * bonus));
				_properties.DamageRegularMult *= negbonus;
				_properties.DamageArmorMult *= negbonus;
				_properties.RangedSkill *= negbonus;
				_properties.HitChanceAdditionalWithEachTile -= 3;
			}
		}
	}
});
