//::///////////////////////////////////////////////
//:: Mighty Rage
//:: X2_S2_MghtyRage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Str and Con of the Barbarian increases,
    Will Save are +2, AC -2.
    Greater Rage starts at level 15.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: May 16, 2003
//:://////////////////////////////////////////////
#include "x2_i0_spells"
#include "inc_addragebonus"
void main()
{
    if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
    {
        //Declare major variables
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        int nBonus = 8;
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        //Determine the duration by getting the con modifier after being modified
        int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION) + nBonus;
        effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nBonus);
        effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nBonus);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, 4);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        effect eLink = EffectLinkEffects(eCon, eStr);
        eLink = EffectLinkEffects(eLink, eSave);
        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        //Make effect extraordinary
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE); //Change to the Rage VFX

        if (nCon > 0)
        {
        // Added by Rusty J to also "fix" mighty rage
        // 2004-01-18 mr_bumpkin: determine the ability scores before adding bonuses, so the values
        // can be read in by the GiveExtraRageBonuses() function below.
        int StrBeforeBonuses = GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH);
        int ConBeforeBonuses = GetAbilityScore(OBJECT_SELF,ABILITY_CONSTITUTION);

            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;

        // Added by Rusty J to also "fix" mighty rage
        // 2004-01-18 mr_bumpkin: Adds special bonuses to those barbarians who are restricted by the
        // +12 attribute bonus cap, to make up for them. :)

        // The delay is because you have to delay the command if you want the function to be able
        // to determine what the ability scores become after adding the bonuses to them.
		
		// 2010-09-08, Carson: Modified for PRC compatibility
		int DamType = GetDamageTypeOfWeapon(INVENTORY_SLOT_RIGHTHAND);
		DelayCommand(0.1, GiveExtraRageBonuses(nCon,StrBeforeBonuses , ConBeforeBonuses, nBonus, nBonus, 4, DamType, OBJECT_SELF));


                    // 2003-07-08, Georg: Rage Epic Feat Handling
                CheckAndApplyEpicRageFeats(nCon);
        }
    }
}
