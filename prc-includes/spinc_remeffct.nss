///////////////////////////////////////////////////////////////////////////
//@file
//Include for spell removal checks
//
//
//void SpellRemovalCheck
//
//This function is used for the removal of effects and ending of spells that
//cannot be ended in a normal fashion.
//
///////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

void SpellRemovalCheck(object oCaster, object oTarget);


//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "prc_inc_spells"


//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

void SpellRemovalCheck(object oCaster, object oTarget)
{
	//Get Spell being cast
	int nSpellID = PRCGetSpellId();

	//Set up spell removals for individual spells
	//Remove Curse
	if(nSpellID == SPELL_REMOVE_CURSE)
	{
		//Ghoul Gauntlet
		if(GetHasSpellEffect(SPELL_GHOUL_GAUNTLET, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_GHOUL_GAUNTLET, oCaster, oTarget);
		}
		
		//Touch of Juiblex
		if(GetHasSpellEffect(SPELL_TOUCH_OF_JUIBLEX, oTarget))
		{
			int nDam = d6(3);
			effect eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL);
			
			SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
			
			PRCRemoveSpellEffects(SPELL_TOUCH_OF_JUIBLEX, oCaster, oTarget);
		}
		
		//Evil Eye
		if(GetHasSpellEffect(SPELL_EVIL_EYE, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_EVIL_EYE, oCaster, oTarget);
		}
	}

	//Remove Disease
	if(nSpellID == SPELL_REMOVE_DISEASE)
	{
		//Ghoul Gauntlet
		if(GetHasSpellEffect(SPELL_GHOUL_GAUNTLET, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_GHOUL_GAUNTLET, oCaster, oTarget);
		}
	}

	//Heal
	if(nSpellID == SPELL_HEAL)
	{
		//Ghoul Gauntlet
		if(GetHasSpellEffect(SPELL_GHOUL_GAUNTLET, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_GHOUL_GAUNTLET, oCaster, oTarget);
		}

		//Energy Ebb
		if(GetHasSpellEffect(SPELL_ENERGY_EBB, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_ENERGY_EBB, oCaster, oTarget);
		}
		
		//Touch of Juiblex
		if(GetHasSpellEffect(SPELL_TOUCH_OF_JUIBLEX, oTarget))
		{
			int nDam = d6(3);
			effect eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL);
			
			SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
			
			PRCRemoveSpellEffects(SPELL_TOUCH_OF_JUIBLEX, oCaster, oTarget);
		}

	}

	//Restoration
	if(nSpellID == SPELL_RESTORATION)
	{
		//Ghoul Gauntlet
		if(GetHasSpellEffect(SPELL_GHOUL_GAUNTLET, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_GHOUL_GAUNTLET, oCaster, oTarget);
		}

		//Energy Ebb
		if(GetHasSpellEffect(SPELL_ENERGY_EBB, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_ENERGY_EBB, oCaster, oTarget);
		}

	}

	//Greater Restoration
	if(nSpellID == SPELL_GREATER_RESTORATION)
	{
		//Ghoul Gauntlet
		if(GetHasSpellEffect(SPELL_GHOUL_GAUNTLET, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_GHOUL_GAUNTLET, oCaster, oTarget);
		}

		//Energy Ebb
		if(GetHasSpellEffect(SPELL_ENERGY_EBB, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_ENERGY_EBB, oCaster, oTarget);
		}
		
		//Touch of Juiblex
		if(GetHasSpellEffect(SPELL_TOUCH_OF_JUIBLEX, oTarget))
		{
			int nDam = d6(3);
			effect eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL);
			
			SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
			
			PRCRemoveSpellEffects(SPELL_TOUCH_OF_JUIBLEX, oCaster, oTarget);
		}

	}

	//Dispel Magic
	if(nSpellID == SPELL_DISPEL_MAGIC)
	{
		//Ghoul Gauntlet
		if(GetHasSpellEffect(SPELL_GHOUL_GAUNTLET, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_GHOUL_GAUNTLET, oCaster, oTarget);
		}
		
		//Eternity of Torture
		if(GetHasSpellEffect(SPELL_ETERNITY_OF_TORTURE, oTarget))
		{
			AssignCommand(oTarget, SetCommandable(TRUE, oTarget));
			PRCRemoveSpellEffects(SPELL_ETERNITY_OF_TORTURE, oCaster, oTarget);
		}
	}

	//Greater Dispelling
	if(nSpellID == SPELL_GREATER_DISPELLING)
	{
		//Ghoul Gauntlet
		if(GetHasSpellEffect(SPELL_GHOUL_GAUNTLET, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_GHOUL_GAUNTLET, oCaster, oTarget);
		}
		
		//Eternity of Torture
		if(GetHasSpellEffect(SPELL_ETERNITY_OF_TORTURE, oTarget))
		{
			AssignCommand(oTarget, SetCommandable(TRUE, oTarget));
			PRCRemoveSpellEffects(SPELL_ETERNITY_OF_TORTURE, oCaster, oTarget);
		}
	}

	//Mordenkainen's Disjunction
	if(nSpellID == SPELL_MORDENKAINENS_DISJUNCTION)
	{
		//Ghoul Gauntlet
		if(GetHasSpellEffect(SPELL_GHOUL_GAUNTLET, oTarget))
		{
			PRCRemoveSpellEffects(SPELL_GHOUL_GAUNTLET, oCaster, oTarget);
		}
		//Eternity of Torture
		if(GetHasSpellEffect(SPELL_ETERNITY_OF_TORTURE, oTarget))
		{
			AssignCommand(oTarget, SetCommandable(TRUE, oTarget));
			PRCRemoveSpellEffects(SPELL_ETERNITY_OF_TORTURE, oCaster, oTarget);
		}
	}

	//Limited Wish
	//Wish
	//Miracle
}

// Test main
//void main(){}
