//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT6
//:: Default OnDamaged handler
/*
    If already fighting then ignore, else determine
    combat round
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

#include "nw_i0_generic"

void main()
{
    if(GetFleeToExit()) {
        // We're supposed to run away, do nothing
    } else if (GetSpawnInCondition(NW_FLAG_SET_WARNINGS)) {
        // don't do anything?
    } else {
        object oDamager = GetLastDamager();
        if (!GetIsObjectValid(oDamager)) {
            // don't do anything, we don't have a valid damager
        } else if (!GetIsFighting(OBJECT_SELF)) {
            // If we're not fighting, determine combat round
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL)) {
                DetermineSpecialBehavior(oDamager);
            } else {
                if(!GetObjectSeen(oDamager)
                   && GetArea(OBJECT_SELF) == GetArea(oDamager)) {
                    // We don't see our attacker, go find them
                    ActionMoveToLocation(GetLocation(oDamager), TRUE);
                    ActionDoCommand(DetermineCombatRound());
                } else {
                    DetermineCombatRound();
                }
            }
        } else {
            // We are fighting already -- consider switching if we've been
            // attacked by a more powerful enemy
            object oTarget = GetAttackTarget();
            if (!GetIsObjectValid(oTarget))
                oTarget = GetAttemptedAttackTarget();
            if (!GetIsObjectValid(oTarget))
                oTarget = GetAttemptedSpellTarget();

            // If our target isn't valid
            // or our damager has just dealt us 25% or more
            //    of our hp in damager
            // or our damager is more than 2HD more powerful than our target
            // switch to attack the damager.
            if (!GetIsObjectValid(oTarget)
                || (
                    oTarget != oDamager
                    &&  (
                         GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4)
                         || (GetHitDice(oDamager) - 2) > GetHitDice(oTarget)
                         )
                    )
                )
            {
                // Switch targets
                DetermineCombatRound(oDamager);
            }
        }
    }

    // Send the user-defined event signal
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DAMAGED));
    }
   object oDamager2 = GetLastDamager();
  int iOuch=   GetTotalDamageDealt() ;
 // SpeakString (IntToString (iOuch));


   int nDamage=iOuch*2;
   object oTarget=oDamager2;

///////////////////////insert demon item check here
             int NegImmunity=100;


           object oCloak=GetItemInSlot( INVENTORY_SLOT_CLOAK,oTarget);
           if (GetTag (oCloak)== "demonshaircloa") NegImmunity= NegImmunity-10;

           oCloak=GetItemInSlot( INVENTORY_SLOT_NECK,oTarget);
           if (GetTag(oCloak)=="talismanofde1" ||
               GetTag(oCloak)=="talismanofde2" ||
               GetTag(oCloak)=="talismanofde3" ||
               GetTag(oCloak)=="talismanofde4" ||
               GetTag(oCloak)=="talismanofde5"
              )

          {
          NegImmunity= NegImmunity-10;
         }

           oCloak=GetItemInSlot( INVENTORY_SLOT_BELT,oTarget);
          if (GetTag(oCloak)=="twentysevenint")
            {
            NegImmunity= NegImmunity-20;
            }


          oCloak=GetItemInSlot( INVENTORY_SLOT_CHEST,oTarget);
           if (GetTag(oCloak)=="leafarmor12" ||
               GetTag(oCloak)=="barkarmor003" ||
               GetTag(oCloak)=="twigarmor12" ||
               GetTag(oCloak)=="woodenarmor12"
              )

          {
          NegImmunity= NegImmunity-10;
         }
         nDamage=(nDamage* NegImmunity)/100  ;
////////////////////////insert demon item check here

           iOuch=nDamage;





          //Set the damage effect
   effect  eDam = EffectDamage(iOuch, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);

            if(iOuch> 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oDamager2));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oDamager2));
              }

}
