//::////////////////////////////////////////////////
//:: Sunbeam
//:: s_Sunbeam.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: All creatures in the beam are struck blind and suffer 4d6 points of damage. (A successful
//:: Reflex save negates the blindness and reduces the damage by half.) Creatures to whom sunlight
//:: is harmful or unnatural suffer double damage.
//::
//:: Undead creatures caught within the ray are dealt 1d6 points of damage per caster level
//:: (maximum 20d6), or half damage if a Reflex save is successful. In addition, the ray results in
//:: the total destruction of undead creatures specifically affected by sunlight if they fail their saves.
//:://////////////////////////////////////////////
//:: Created By: Keith Soleski
//:: Created On: Feb 22, 2001
//:://////////////////////////////////////////////
//:: Last Modified By: Keith Soleski, On: March 21, 2001
//:: VFX Pass By: Preston W, On: June 25, 2001

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "wk_tools"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eStrike = EffectVisualEffect(VFX_FNF_SUNBEAM);
    effect eDam;
    effect eBlind = EffectBlindness();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eBlind, eDur);

    int nCasterLevel= GetCasterLevel(OBJECT_SELF);
    int nDice = 6;
    int nDruid = GetWhiteGold(OBJECT_SELF);
    if (nDruid >= 3)
      {
        nCasterLevel = GetEffectiveCasterLevel(OBJECT_SELF);
      }
    if (nDruid == 1 || nDruid == 4)
      {
        nDice = 10;
      }

    int nSpellCraft=GetSkillRank(SKILL_SPELLCRAFT, OBJECT_SELF);
    int nSpellBonus=nSpellCraft/5;
    int nDamage;
    int nModLevel = nCasterLevel + nSpellBonus;
    int nOrgDam;
    int nMax;
    float fDelay;
    int nBlindLength = 3;
    // This where the previous restriction on caster level went - no limit on Altharia.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
    //Get the first target in the spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget))
    {
        // Make a faction check
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = GetRandomDelay(1.0, 2.0);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBEAM));
            //Make an SR check
            if ( ! MyResistSpell(OBJECT_SELF, oTarget, 1.0))
            {
                //Check if the target is an undead
                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {
                    //Roll damage and save
                    nDamage = (Random(nDice) + 1)*nModLevel + 6*nModLevel;    // Modified damage - WK
                    nMax = nDice + 6;
                }
                else
                {
                    //Roll damage and save
                    nDamage = (Random(nDice) + 1)*nModLevel + 2*nModLevel;    // Modified damage - WK
                    nOrgDam = nDamage;
                    nMax = 2+nDice;
                    //Get the adjusted damage due to Reflex Save, Evasion or Improved Evasion
                }

                //Do metamagic checks
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = nMax * nModLevel; // Modified damage - WK
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
/////////////////EZs increased damage
/*    int isScim=0;
    if (GetHitDice(OBJECT_SELF)>20 && GetIsPC(OBJECT_SELF))
        {
            object oRight= GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
            if (GetTag(oRight)=="naturalists21" ||GetTag(oRight)=="naturalists30"|| GetTag(oRight)=="naturalists40" ||GetTag(oRight)=="naturalists45" )
                {
                int iA=GetLevelByClass(CLASS_TYPE_BARD, OBJECT_SELF);
                int iB=GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF);
                int iC=GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF);
                int iD=GetLevelByClass(CLASS_TYPE_WIZARD, OBJECT_SELF);
                int iE=GetLevelByClass(CLASS_TYPE_SORCERER, OBJECT_SELF);
                int iF=GetLevelByClass(CLASS_TYPE_PALEMASTER, OBJECT_SELF);
                int iG=GetLevelByClass(CLASS_TYPE_HARPER, OBJECT_SELF);

                int iCasterLevel= iA+iB+iC+iD+iE+iF+iG;
                if (iCasterLevel < 6)iCasterLevel=5;

                int iSpellCraft=GetSkillRank(SKILL_SPELLCRAFT, OBJECT_SELF);
                int iNaturesEmpathy=GetSkillRank(SKILL_ANIMAL_EMPATHY, OBJECT_SELF);
                isScim=1;
                nDamage= d10(iCasterLevel ) + 2*iSpellCraft + iNaturesEmpathy;
                }
        }*/
///// End of special damage for scimitar

                //Check that a reflex save was made.
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, 1.0) == 0)
                {
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nBlindLength)));
                    //nDamage = GetReflexAdjustedDamage(nDamage, oTarget, 0, SAVING_THROW_TYPE_DIVINE);

                }
                else //// more EZ code  reflex halves the damage if in epic with scim
                {
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, 0, SAVING_THROW_TYPE_DIVINE);
                }


               //Set damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                if(nDamage > 0)
                {
                    //Apply the damage effect and VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                }
            }
        }
        //Get the next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    }
}
