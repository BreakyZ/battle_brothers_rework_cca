::ModReworkCca.HooksMod.hook("scripts/skills/perks/perk_close_combat_archer", function( q )
{
	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
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
			else if (range > 4)
			{
				negbonus = this.Math.max(0, 1.0 - (range * 0.05 * bonus));
				_properties.DamageRegularMult *= negbonus;
				_properties.DamageArmorMult *= negbonus;
				_properties.RangedSkill *= negbonus;
				_properties.HitChanceAdditionalWithEachTile -= 3;
			}
		}
	}

	q.onUpdate = @( __original ) function ( _properties )
	{
		_properties.isCloseCombatArcher = true;
	}

	q.getTooltip = @( __original ) function ( )
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor()
		local bonus = this.getContainer().getActor().getCurrentProperties().getRangedDefense()
		local isThrowing = false
		
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases your damage done at a range of 2 by [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color]."
		});
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases your damage done at a range of 3 by [color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.floor(bonus / 3.0) + "%[/color]."
		});

		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
		{
			foreach (throwing_weapon in [
				"weapon.throwing_axe",
				"weapon.throwing_spear",
				"weapon.javelin",
				"weapon.goblin_spiked_balls"	
			])
			{
				if (actor.getMainhandItem().getID() == throwing_weapon)
				{
					isThrowing = true
				}
			}
			if (isThrowing)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "Reduces your maximum range by [color=" + this.Const.UI.Color.NegativeValue + "]1[/color]."
				});
			}
			else
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "Decreases your damage done by [color=" + this.Const.UI.Color.NegativeValue + "]5%[/color] of [color=" + this.Const.UI.Color.NegativeValue + "]" + bonus + "[/color] per distance traveled for shots at range 5 and above."
				});
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "Hit chance will be also reduced by [color=" + this.Const.UI.Color.NegativeValue + "]3[/color] per distance traveled."
				});
			}
		}

		return tooltip;
	}
});
