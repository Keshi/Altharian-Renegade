#include "inc_utility"

//:: Created by Mr. Bumpkin
//:: Include for all rages
//:: This function gets called right after the attribute bonuses are
//:: Applied.

// Applies all the bonus damage, to hit, and temporary hp to barbarians who would go over their
// +12 attribute caps by raging.
void GiveExtraRageBonuses(int nDuration, int nStrBeforeRaging, int nConBeforeRaging, int strBonus, int conBonus, int nSave, int nDamageBonusType, object oRager = OBJECT_SELF);

// Returns the damage type of the weapon held in nInventorySlot by oCreature.   If they aren't
// holding a weapon, or the weapon they're holding is a x-bow, sling, shuriken, or dart, it returns
// either the damage type of slashing or bludgeoning, depending on whether they have a prc creature
// slashing weapon or not.  It's bludgeoning if they don't have a prc creature slashing weapon.
int GetDamageTypeOfWeapon(int nInventorySlot, object oCreature = OBJECT_SELF);

// * Hub function for the epic barbarian feats that upgrade rage. Call from
// * the end of the barbarian rage spellscript
void PRCEpicRageFeats(int nRounds);

// * Checks the character for the thundering rage feat and will apply temporary massive critical
// * to the worn weapons
// * called by PRCEpicRageFeats(
void PRCThunderingRage(int nRounds);

// * Checks and runs Rerrifying Rage feat
// * called by PRCEpicRageFeats(
void PRCTerrifyingRage(int nRounds);


// Applies all the bonus damage, to hit, and temporary hp to barbarians who would go over their
// +12 attribute caps by raging.
void GiveExtraRageBonuses(int nDuration, int nStrBeforeRaging, int nConBeforeRaging, int strBonus, int conBonus, int nSave, int nDamageBonusType, object oRager = OBJECT_SELF)
{
    float nDelayed = 0.1;

    int nStrSinceRaging = GetAbilityScore(oRager, ABILITY_STRENGTH);
    int nConSinceRaging = GetAbilityScore(oRager, ABILITY_CONSTITUTION);


    int nStrAdded = nStrSinceRaging -  nStrBeforeRaging;
    // The amount that was added to the str
    int nStrWeWouldAdd = strBonus - nStrAdded;
    // The amount we would have to theorhetically add if we wanted to give them the full bonus.
    effect eDamage;
    effect eToHit;

    if(nStrAdded < strBonus)
    {
        //int nDamageBonusType = GetDamageTypeOfWeapon(INVENTORY_SLOT_RIGHTHAND, oRager);

        if((nStrSinceRaging/2) * 2 != nStrSinceRaging)
        // determine if their current Str right now is odd
        {
            if((nStrWeWouldAdd/2) * 2 != nStrWeWouldAdd)
            // determine if the amount we would theorhetically have to add is odd.
            // If so, then we're adding 2 odd numbers together to get an even.  Add one to the bonuses
            {
            //::::: in this event we  add nStrWeWouldAdd/2 + 1
            //int nAmountToAdd = nStrWeWouldAdd/2 + 1;

            eDamage = EffectDamageIncrease(nStrWeWouldAdd/2 + 1, nDamageBonusType);
            eToHit = EffectAttackIncrease(nStrWeWouldAdd/2 +1);
            }
            else
            {
            //::::: in this event we add nStrWeWouldAdd/2
            eDamage = EffectDamageIncrease(nStrWeWouldAdd/2, nDamageBonusType);
            eToHit = EffectAttackIncrease(nStrWeWouldAdd/2);
            }
         }
         else
         {
             //::::: in this event we add nStrWeWouldAdd/2
             eDamage = EffectDamageIncrease(nStrWeWouldAdd/2, nDamageBonusType);
             eToHit = EffectAttackIncrease(nStrWeWouldAdd/2);
         }

        effect eLink2 = ExtraordinaryEffect(EffectLinkEffects(eDamage, eToHit));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oRager, RoundsToSeconds(nDuration) - nDelayed);
        // Applies the damage and toHit effects.  I couldn't help myself, so I made the damage type be fire.

        }
        // If nStrAdded >= nStrBonus, then no need to add any special bonuses. :)

        int nConAdded = nConSinceRaging -  nConBeforeRaging;
        // The amount that was added to the Con
        int nConWeWouldAdd = conBonus - nConAdded;
        // The amount we would have to theorhetically add if we wanted to give them the full bonus.


        if(nConAdded < conBonus)
        {
        effect eHitPoints;
        effect eHPRemoved;

        int nCharacterLevel =  GetHitDice(oRager);

            if((nConSinceRaging/2) * 2 != nConSinceRaging)
            // determine if their current Con right now is odd
            {
                if((nConWeWouldAdd/2) * 2 != nConWeWouldAdd)
                // determine if the amount we would theorhetically have to add is odd.
                // If so, then we're adding 2 odd numbers together to get an even.  Add one to the bonuses
                {
                //::::: in this event we  add nConWeWouldAdd/2 + 1

                eHitPoints = EffectTemporaryHitpoints((nConWeWouldAdd/2 +1) * nCharacterLevel);
                eHPRemoved = EffectDamage(((nConWeWouldAdd/2 +1) * nCharacterLevel), DAMAGE_TYPE_MAGICAL);
                // We have to remove the temporary HP at the end of the rage via a damage effect, hehe.
                // The damage type will be magical, something to keep in mind of magical resistances exist
                // on your module. :)   If that's a problem, change the damage type.


                }
                else
                {
                //::::: in this event we add nConWeWouldAdd/2

                eHitPoints = EffectTemporaryHitpoints((nConWeWouldAdd/2) * nCharacterLevel);
                eHPRemoved = EffectDamage(((nConWeWouldAdd/2) * nCharacterLevel), DAMAGE_TYPE_MAGICAL);
                // We have to remove the temporary HP at the end of the rage via a damage effect, hehe.
                // The damage type will be magical, something to keep in mind of magical resistances exist
                // on your module. :)   If that's a problem, change the damage type.


                }
             }
             else
             {
             //::::: in this event we add nConWeWouldAdd/2

             eHitPoints = EffectTemporaryHitpoints((nConWeWouldAdd/2) * nCharacterLevel);
             eHPRemoved = EffectDamage(((nConWeWouldAdd/2) * nCharacterLevel), DAMAGE_TYPE_MAGICAL);
             // We have to remove the temporary HP at the end of the rage via a damage effect, hehe.
             // The damage type will be magical, something to keep in mind of magical resistances exist
             // on your module. :)   If that's a problem, change the damage type.

             }

        eHitPoints = ExtraordinaryEffect(eHitPoints);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHitPoints, oRager, RoundsToSeconds(nDuration)- nDelayed);


        //::: Had to ditch applying the damage effect, cause it would apply it even if they rested during their
        //::: rage, and the resting was what ended it.   Pretty Ironic.
        //::: If you reactivate it, make sure to have the temporary HP effect last longer than the delay on the damage effect. 8j

        //DelayCommand(RoundsToSeconds(nDuration) - nDelayed, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHPRemoved, oRager));
        // This is really how the temporary hp are going to get removed.   I just didn't want to take any chances,
        // so I gave the temporary hp a temporary duration.

    }

// If nConAdded >= nConBonus, then no need to add any special bonuses. :)



}// End of the whole function.


// Returns the damage type of the weapon held in nInventorySlot by oCreature.   If they aren't
// holding a weapon, or the weapon they're holding is a x-bow, sling, shuriken, or dart, it returns
// either the damage type of slashing or bludgeoning, depending on whether they have a prc creature
// slashing weapon or not.  It's bludgeoning if they don't have a prc creature slashing weapon.

int GetDamageTypeOfWeapon(int nInventorySlot, object oCreature = OBJECT_SELF)
{
  object oRager = oCreature;

  object oCurrentWeapon = GetItemInSlot(nInventorySlot, oRager);

// 2da lookup to see what kind of damage it deals, then find the equivalent constant

  int iWeaponType = GetBaseItemType(oCurrentWeapon);
  int iDamageType = StringToInt(Get2DACache("baseitems","WeaponType",iWeaponType));
  switch(iDamageType)
  {
     case 1: return DAMAGE_TYPE_PIERCING; break;
     case 2: return DAMAGE_TYPE_BLUDGEONING; break;
     case 3: return DAMAGE_TYPE_SLASHING; break;
     case 4: return DAMAGE_TYPE_SLASHING; break; // slashing & piercing... slashing bonus.
  }

// If none of the above types got a hit, we must assume the character is unarmed.

  if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oRager)) == BASE_ITEM_CSLSHPRCWEAP|| GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oRager)) == BASE_ITEM_CSLSHPRCWEAP || GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oRager)) == BASE_ITEM_CSLSHPRCWEAP)
  {
     return DAMAGE_TYPE_SLASHING;
  }
  // If they're unarmed and have no creature weapons from a prc, we must assume they are just using their fists.
  return DAMAGE_TYPE_BLUDGEONING;

}

// function I typed out to add duration to the rage, only to realize happily that there is no need.
// the normal rage function calculates duration as being what it naturally should be, even if there
// were no +12 bonus cap. :)
/*
            if(nBonusDuration)
            {
            effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nBonus);
            effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nBonus);
            effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave);
            effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

            effect eLink = EffectLinkEffects(eCon, eStr);
            eLink = EffectLinkEffects(eLink, eSave);
            eLink = EffectLinkEffects(eLink, eAC);
            eLink = EffectLinkEffects(eLink, eDur);
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));
            //Make effect extraordinary
            eLink = ExtraordinaryEffect(eLink);
            DelayCommand(RoundsToSeconds(nDuration, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oRager, RoundsToSeconds(nBonusDuration)));
            }
*/

//------------------------------------------------------------------------------
// GZ, 2003-07-09
// Hub function for the epic barbarian feats that upgrade rage. Call from
// the end of the barbarian rage spellscript
//------------------------------------------------------------------------------
void PRCEpicRageFeats(int nRounds)
{
    PRCThunderingRage(nRounds);
    PRCTerrifyingRage(nRounds);
}

//------------------------------------------------------------------------------
// GZ, 2003-07-09
// If the character calling this function from a spellscript has the thundering
// rage feat, his weapons are upgraded to deafen and cause 2d6 points of massive
// criticals
//------------------------------------------------------------------------------
void PRCThunderingRage(int nRounds)
{
    if (GetHasFeat(988, OBJECT_SELF))
    {
        object oWeapon =  GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);

        if (GetIsObjectValid(oWeapon))
        {
           IPSafeAddItemProperty(oWeapon, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d6), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
           IPSafeAddItemProperty(oWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_SONIC), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
           IPSafeAddItemProperty(oWeapon, ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }

        oWeapon =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND);

        if (GetIsObjectValid(oWeapon) )
        {
           IPSafeAddItemProperty(oWeapon, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d6), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
           IPSafeAddItemProperty(oWeapon,ItemPropertyVisualEffect(ITEM_VISUAL_SONIC), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }


     }
}

//------------------------------------------------------------------------------
// GZ, 2003-07-09
// If the character calling this function from a spellscript has the terrifying
// rage feat, he gets an aura of fear for the specified duration
// The saving throw against this fear is a check opposed to the character's
// intimidation skill
//------------------------------------------------------------------------------
void PRCTerrifyingRage(int nRounds)
{
    if (GetHasFeat(989, OBJECT_SELF))
    {
        effect eAOE = EffectAreaOfEffect(AOE_MOB_FEAR,"x2_s2_terrage_A", "","");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAOE,OBJECT_SELF,RoundsToSeconds(nRounds));
    }
}