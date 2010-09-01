//:: Include for all rages
//:: This function gets called right after the attribute bonuses are
//:: Applied.

void GiveExtraRageBonuses(int nDuration, int nStrBeforeRaging, int nConBeforeRaging, int nBonus, int nSave, object oRager = OBJECT_SELF);

void GiveExtraRageBonuses(int nDuration, int nStrBeforeRaging, int nConBeforeRaging, int nBonus, int nSave, object oRager = OBJECT_SELF)
{
float nDelayed = 0.1;

int nStrSinceRaging = GetAbilityScore(oRager, ABILITY_STRENGTH);
int nConSinceRaging = GetAbilityScore(oRager, ABILITY_CONSTITUTION);


int nStrAdded = nStrSinceRaging -  nStrBeforeRaging;
// The amount that was added to the str
int nStrWeWouldAdd = nBonus - nStrAdded;
// The amount we would have to theorhetically add if we wanted to give them the full bonus.
effect eDamage;
effect eToHit;

//   RJ addition to help out just a but more and ad bonuses for the barb helm


int nXDamage = 0 ;      // bonus for helm
int nXCon    = 0;

int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);


object oHelm=GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
if( GetTag(oHelm)=="helmofnorthernfury")
   {
         if (nLevel < 41)
           {
            nXDamage =  26;   // max  +20 Mighty rage
            nXCon    =  6;
           }
         if (nLevel < 40)
           {
             nXDamage =  21;   // max  +15
             nXCon    =  4;
           }
         if (nLevel < 35)
            {
              nXDamage = 16 ;   // max  +10
              nXCon    =  2;
            }
         if (nLevel < 30)
           {
             nXDamage = 15 ;   // max at + 9   < 30
             nXCon    = 1;
           }
     }
//RJ

if(nStrAdded < nBonus)
{
    if((nStrSinceRaging/2) * 2 != nStrSinceRaging)
    // determine if their current Str right now is odd
    {
        if((nStrWeWouldAdd/2) * 2 != nStrWeWouldAdd)
        // determine if the amount we would theorhetically have to add is odd.
        // If so, then we're adding 2 odd numbers together to get an even.  Add one to the bonuses
        {
        //::::: in this event we  add nStrWeWouldAdd/2 + 1
        int nAmountToAdd = nStrWeWouldAdd/2 + 1;
        eDamage = EffectDamageIncrease(nStrWeWouldAdd/2 + 1 + nXDamage, DAMAGE_TYPE_MAGICAL);
        eToHit = EffectAttackIncrease(nStrWeWouldAdd/2 +1);
        }
        else
        {
        //::::: in this event we add nStrWeWouldAdd/2
        eDamage = EffectDamageIncrease(nStrWeWouldAdd/2 + nXDamage, DAMAGE_TYPE_MAGICAL);
        eToHit = EffectAttackIncrease(nStrWeWouldAdd/2);
        }
     }
     else
     {
     //::::: in this event we add nStrWeWouldAdd/2
     eDamage = EffectDamageIncrease(nStrWeWouldAdd/2 + nXDamage,DAMAGE_TYPE_MAGICAL);
     eToHit = EffectAttackIncrease(nStrWeWouldAdd/2);
     }

effect eLink2 = ExtraordinaryEffect(EffectLinkEffects(eDamage, eToHit));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oRager, RoundsToSeconds(nDuration +nXCon) - nDelayed);
// Applies the damage and toHit effects.  I couldn't help myself, so I made the damage type be fire.

}
// If nStrAdded >= nStrBonus, then no need to add any special bonuses. :)



int nConAdded = nConSinceRaging -  nConBeforeRaging;
// The amount that was added to the Con
int nConWeWouldAdd = nBonus - nConAdded;
// The amount we would have to theorhetically add if we wanted to give them the full bonus.


if(nConAdded < nBonus)
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

        eHitPoints = EffectTemporaryHitpoints((nConWeWouldAdd/2 +1 +nXCon) * nCharacterLevel);
        eHPRemoved = EffectDamage(((nConWeWouldAdd/2 +1) * nCharacterLevel), DAMAGE_TYPE_MAGICAL);
        // We have to remove the temporary HP at the end of the rage via a damage effect, hehe.
        // The damage type will be magical, something to keep in mind of magical resistances exist
        // on your module. :)   If that's a problem, change the damage type.


        }
        else
        {
        //::::: in this event we add nConWeWouldAdd/2

        eHitPoints = EffectTemporaryHitpoints((nConWeWouldAdd/2 +nXCon) * nCharacterLevel);
        eHPRemoved = EffectDamage(((nConWeWouldAdd/2) * nCharacterLevel), DAMAGE_TYPE_MAGICAL);
        // We have to remove the temporary HP at the end of the rage via a damage effect, hehe.
        // The damage type will be magical, something to keep in mind of magical resistances exist
        // on your module. :)   If that's a problem, change the damage type.


        }
     }
     else
     {
     //::::: in this event we add nConWeWouldAdd/2

     eHitPoints = EffectTemporaryHitpoints((nConWeWouldAdd/2 +nXCon) * nCharacterLevel);
     eHPRemoved = EffectDamage(((nConWeWouldAdd/2) * nCharacterLevel), DAMAGE_TYPE_MAGICAL);
     // We have to remove the temporary HP at the end of the rage via a damage effect, hehe.
     // The damage type will be magical, something to keep in mind of magical resistances exist
     // on your module. :)   If that's a problem, change the damage type.

     }

eHitPoints = ExtraordinaryEffect(eHitPoints);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHitPoints, oRager, RoundsToSeconds(nDuration +nXCon)- nDelayed);


//::: Had to ditch applying the damage effect, cause it would apply it even if they rested during their
//::: rage, and the resting was what ended it.   Pretty Ironic.
//::: If you reactivate it, make sure to have the temporary HP effect last longer than the delay on the damage effect. 8j

//DelayCommand(RoundsToSeconds(nDuration) - nDelayed, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHPRemoved, oRager));
// This is really how the temporary hp are going to get removed.   I just didn't want to take any chances,
// so I gave the temporary hp a temporary duration.

}

// If nConAdded >= nConBonus, then no need to add any special bonuses. :)



}// End of the whole function.



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
