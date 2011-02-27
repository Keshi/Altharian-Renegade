//::///////////////////////////////////////////////
//:: Bard Song
//:: NW_S2_BardSong
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spells applies bonuses to all of the
    bard's allies within 30ft for a set duration of
    10 rounds.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 25, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller Oct 1, 2003
/*
bugfix by Kovi 2002.07.30
- loosing temporary hp resulted in loosing the other bonuses
*/

#include "prc_inc_clsfunc"
#include "prc_inc_combat"  //for Dragonfire type getting
#include "wk_tools"
void ApplyDragonfire(int nAmount, int nDuration, object oPC, object oCaster)
{
    int nAppearanceType;
        int nDamageType = GetDragonfireDamageType(oPC);
        //find primary weapon to add to
        object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        switch(nDamageType)
        {
        case DAMAGE_TYPE_ACID: nAppearanceType = ITEM_VISUAL_ACID; break;
        case DAMAGE_TYPE_COLD: nAppearanceType = ITEM_VISUAL_COLD; break;
        case DAMAGE_TYPE_ELECTRICAL: nAppearanceType = ITEM_VISUAL_ELECTRICAL; break;
        case DAMAGE_TYPE_SONIC: nAppearanceType = ITEM_VISUAL_SONIC; break;
        case DAMAGE_TYPE_FIRE: nAppearanceType = ITEM_VISUAL_FIRE; break;
        }
        SetLocalInt(oItem, "Insp_Dam_Type", nDamageType);
    SetLocalInt(oItem, "Insp_Dam_Dice", nAmount);
    IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(nAppearanceType), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);

        //add to gloves and claws too
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
        SetLocalInt(oItem, "Insp_Dam_Type", nDamageType);
    SetLocalInt(oItem, "Insp_Dam_Dice", nAmount);
        IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC);
        SetLocalInt(oItem, "Insp_Dam_Type", nDamageType);
    SetLocalInt(oItem, "Insp_Dam_Dice", nAmount);
        IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

        //do ammo for ranged attacks
        object oAmmo = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
        SetLocalInt(oAmmo, "Insp_Dam_Type", nDamageType);
    SetLocalInt(oAmmo, "Insp_Dam_Dice", nAmount);
        IPSafeAddItemProperty(oAmmo, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

        oAmmo = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
        SetLocalInt(oAmmo, "Insp_Dam_Type", nDamageType);
    SetLocalInt(oAmmo, "Insp_Dam_Dice", nAmount);
        IPSafeAddItemProperty(oAmmo, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

        oAmmo = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
        SetLocalInt(oAmmo, "Insp_Dam_Type", nDamageType);
    SetLocalInt(oAmmo, "Insp_Dam_Dice", nAmount);
        IPSafeAddItemProperty(oAmmo, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

        //now check offhand and bite
        oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC);
        SetLocalInt(oItem, "Insp_Dam_Type", nDamageType);
    SetLocalInt(oItem, "Insp_Dam_Dice", nAmount);
        IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
        if(!GetIsShield(oItem) && oItem != OBJECT_INVALID)
        {
             SetLocalInt(oItem, "Insp_Dam_Type", nDamageType);
         SetLocalInt(oItem, "Insp_Dam_Dice", nAmount);
             IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
             IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(nAppearanceType), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }
        oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC);
        SetLocalInt(oItem, "Insp_Dam_Type", nDamageType);
    SetLocalInt(oItem, "Insp_Dam_Dice", nAmount);
        IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DRAGONFIRE, nAmount), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}

void main()
{
    if (PRCGetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }
    string sTag = GetTag(OBJECT_SELF);

    //RemoveOldSongEffects(OBJECT_SELF,GetSpellId());

    if (sTag == "x0_hen_dee" || sTag == "x2_hen_deekin")
    {
        // * Deekin has a chance of singing a doom song
        // * same effect, better tune
        if (Random(5) == 2)
        {
            // the Xp2 Deekin knows more than one doom song
            if (d3() == 1 && sTag == "x2_hen_deekin")
            {
                DelayCommand(0.0, PlaySound("vs_nx2deekM_050"));
            }
            else
            {
                DelayCommand(0.0, PlaySound("vs_nx0deekM_074"));
                DelayCommand(5.0, PlaySound("vs_nx0deekM_074"));
            }
        }
    }


    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_BARD) +
                 GetLevelByClass(CLASS_TYPE_MINSTREL_EDGE)/2 +
                 GetLevelByClass(CLASS_TYPE_DIRGESINGER) +
                 GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD) +
                 GetLevelByClass(CLASS_TYPE_VIRTUOSO);

    int nRanks = GetSkillRank(SKILL_PERFORM);
    if (GetHasFeat(FEAT_DRAGONSONG, OBJECT_SELF)) nRanks+= 2;
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nPerform = nRanks;
    int nDuration = 10; //+ nChr;
    //altharian mods
    int nBard = GetHarmonic(OBJECT_SELF);
    int nEffLevel = GetEffectiveLevel(OBJECT_SELF);
    if (nBard > 2 && nEffLevel > 40)
      {
        nLevel = nLevel * nEffLevel / 40;
      }
    if (nBard == 1 || nBard >= 3)
      {
        nDuration = nLevel;
        if (nDuration > 25) nDuration = 25;
      }
    effect eAttack;
    effect eDamage;
    effect eWill;
    effect eFort;
    effect eReflex;
    effect eHP;
    effect eAC;
    effect eSkill;

    int nAttack;
    int nDamage;
    int nWill;
    int nFort;
    int nReflex;
    int nHP;
    int nAC;
    int nSkill;

    // lingering song
    if(GetHasFeat(FEAT_LINGERING_SONG, OBJECT_SELF))
    {
        nDuration += (5 + nBard);
    }

    //Check to see if the caster has Lasting Impression and increase duration.
    if(GetHasFeat(FEAT_EPIC_LASTING_INSPIRATION, OBJECT_SELF))
    {
        nDuration *= (3);
    }

    //SpeakString("Level: " + IntToString(nLevel) + " Ranks: " + IntToString(nRanks));

//Altharian modifications, I saved the original script in remark at end of this
    if(nPerform >= 85 && nLevel >= 41)
    {
        nAttack = nLevel/7 + nBard + 1;
        nDamage = nPerform + nLevel;
        nWill = (nLevel/10) + nBard + 1;
        nFort = (nLevel/10) + nBard + 1;
        nReflex = (nLevel/10) + nBard + 2;
        nHP = nPerform * (3 + nBard);
        nAC = (nPerform + nLevel)/20 + 6 + nBard;
        nSkill = nLevel / 2;
        if (nSkill > 30) nSkill = 30;
    }
    else if(nPerform >= nLevel && nLevel >= 25 && nBard >= 1)
    {
        nAttack = nLevel/8 + 1;
        nDamage = nPerform;
        nWill = (nLevel/12) + 1;
        nFort = (nLevel/12) + 1;
        nReflex = (nLevel/12) + 2;
        nHP = nPerform * 3;
        nAC = nPerform/15 + 6;
        nSkill = nLevel / 3 * 2;
        if (nSkill > 25) nSkill = 25;
    }
    else if(nPerform >= nLevel && nLevel >= 21)
    {
        nAttack = nLevel/10 + 1;
        nDamage = nPerform;
        nWill = (nLevel/15) + 1;
        nFort = (nLevel/15) + 1;
        nReflex = (nLevel/15) + 2;
        nHP = nPerform * 2;
        nAC = nLevel/15 + 6;
        nSkill = nLevel/2;
        if (nSkill > 25) nSkill = 25;
    }
    else if (nLevel >= 1)
    {
   // Was 2,3,3,2,2,46,6,18
        nAttack = nLevel/12 + 1;
        nDamage = nLevel;
        nWill = (nLevel/20) + 1;
        nFort = (nLevel/20) + 1;
        nReflex = (nLevel/20) + 2;
        nHP = nLevel * 2;
        nAC = nLevel/4;
        nSkill = nLevel/2;
    }
 //end altharian mod
 /*    if(nPerform >= 100 && nLevel >= 30)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 48;
        nAC = 7;
        nSkill = 19;
    }
    else if(nPerform >= 95 && nLevel >= 29)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 46;
        nAC = 6;
        nSkill = 18;
    }
    else if(nPerform >= 90 && nLevel >= 28)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 44;
        nAC = 6;
        nSkill = 17;
    }
    else if(nPerform >= 85 && nLevel >= 27)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 42;
        nAC = 6;
        nSkill = 16;
    }
    else if(nPerform >= 80 && nLevel >= 26)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 40;
        nAC = 6;
        nSkill = 15;
    }
    else if(nPerform >= 75 && nLevel >= 25)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 38;
        nAC = 6;
        nSkill = 14;
    }
    else if(nPerform >= 70 && nLevel >= 24)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 36;
        nAC = 5;
        nSkill = 13;
    }
    else if(nPerform >= 65 && nLevel >= 23)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 34;
        nAC = 5;
        nSkill = 12;
    }
    else if(nPerform >= 60 && nLevel >= 22)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 32;
        nAC = 5;
        nSkill = 11;
    }
    else if(nPerform >= 55 && nLevel >= 21)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 30;
        nAC = 5;
        nSkill = 9;
    }
    else if(nPerform >= 50 && nLevel >= 20)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 28;
        nAC = 5;
        nSkill = 8;
    }
    else if(nPerform >= 45 && nLevel >= 19)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 26;
        nAC = 5;
        nSkill = 7;
    }
    else if(nPerform >= 40 && nLevel >= 18)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 24;
        nAC = 5;
        nSkill = 6;
    }
    else if(nPerform >= 35 && nLevel >= 17)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 22;
        nAC = 5;
        nSkill = 5;
    }
    else if(nPerform >= 30 && nLevel >= 16)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 20;
        nAC = 5;
        nSkill = 4;
    }
    else if(nPerform >= 24 && nLevel >= 15)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 2;
        nFort = 2;
        nReflex = 2;
        nHP = 16;
        nAC = 4;
        nSkill = 3;
    }
    else if(nPerform >= 21 && nLevel >= 14)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 16;
        nAC = 3;
        nSkill = 2;
    }
    else if(nPerform >= 18 && nLevel >= 11)
    {
        nAttack = 2;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 8;
        nAC = 2;
        nSkill = 2;
    }
    else if(nPerform >= 15 && nLevel >= 8)
    {
        nAttack = 2;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 8;
        nAC = 0;
        nSkill = 1;
    }
    else if(nPerform >= 12 && nLevel >= 6)
    {
        nAttack = 1;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 0;
        nAC = 0;
        nSkill = 1;
    }
    else if(nPerform >= 9 && nLevel >= 3)
    {
        nAttack = 1;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 0;
        nHP = 0;
        nAC = 0;
        nSkill = 0;
    }
    else if(nPerform >= 6 && nLevel >= 2)
    {
        nAttack = 1;
        nDamage = 1;
        nWill = 1;
        nFort = 0;
        nReflex = 0;
        nHP = 0;
        nAC = 0;
        nSkill = 0;
    }
    else if(nPerform >= 3 && nLevel >= 1)
    {
        nAttack = 1;
        nDamage = 1;
        nWill = 0;
        nFort = 0;
        nReflex = 0;
        nHP = 0;
        nAC = 0;
        nSkill = 0;
    }
*/
    effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);
    effect eLink;

    eAttack = EffectAttackIncrease(nAttack);
    eDamage = EffectDamageIncrease(nDamage, DAMAGE_TYPE_MAGICAL);


    if(GetLocalInt(OBJECT_SELF, "DragonFireInspOn"))
    {
        eLink = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    }
    else
    {
         effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
         eLink = EffectLinkEffects(eAttack, eDamage);
         eLink = EffectLinkEffects(eLink, eDur);
    }

    if(nWill > 0)
    {
        eWill = EffectSavingThrowIncrease(SAVING_THROW_WILL, nWill);
        eLink = EffectLinkEffects(eLink, eWill);
    }
    if(nFort > 0)
    {
        eFort = EffectSavingThrowIncrease(SAVING_THROW_FORT, nFort);
        eLink = EffectLinkEffects(eLink, eFort);
    }
    if(nReflex > 0)
    {
        eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nReflex);
        eLink = EffectLinkEffects(eLink, eReflex);
    }
    if(nHP > 0)
    {
        //SpeakString("HP Bonus " + IntToString(nHP));
        eHP = EffectTemporaryHitpoints(nHP);
//        eLink = EffectLinkEffects(eLink, eHP);
    }
    if(nAC > 0)
    {
        eAC = EffectACIncrease(nAC, AC_DODGE_BONUS);
        eLink = EffectLinkEffects(eLink, eAC);
    }
    if(nSkill > 0)
    {
        eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nSkill);
        eLink = EffectLinkEffects(eLink, eSkill);
    }

    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

    eHP = ExtraordinaryEffect(eHP);
    eLink = ExtraordinaryEffect(eLink);

    int nRace;

    while(GetIsObjectValid(oTarget))
    {
             // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
             if (!PRCGetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !PRCGetHasEffect(EFFECT_TYPE_DEAF,oTarget))
             {
                RemoveSongEffects(GetSpellId(),OBJECT_SELF,oTarget);
                nRace = MyPRCGetRacialType(oTarget);

                // Undead and Constructs are immune to mind effecting abilities.
                // A bard with requiem can effect undead
                if ((nRace == RACIAL_TYPE_UNDEAD && GetHasFeat(FEAT_REQUIEM, OBJECT_SELF)) || (nRace != RACIAL_TYPE_UNDEAD && nRace != RACIAL_TYPE_CONSTRUCT) || GetRacialType(oTarget) == RACIAL_TYPE_WARFORGED)
                {
                    // Even with requiem, they have half duration
                    if (nRace == RACIAL_TYPE_UNDEAD) nDuration /= 2;

                    if(oTarget == OBJECT_SELF)
                    {
                        effect eLinkBard = EffectLinkEffects(eLink, eVis);
                        eLinkBard = ExtraordinaryEffect(eLinkBard);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinkBard, oTarget, RoundsToSeconds(nDuration));
                        //StoreSongRecipient(oTarget, OBJECT_SELF, GetSpellId(), nDuration);
                        if (nHP > 0)
                        {
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
                        }
                        if(GetLocalInt(OBJECT_SELF, "DragonFireInspOn"))
                        {
                            ApplyDragonfire(nAttack, nDuration, OBJECT_SELF, OBJECT_SELF);
                        }
                    }
                    else if(GetIsFriend(oTarget))
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                        //StoreSongRecipient(oTarget, OBJECT_SELF, GetSpellId(), nDuration);
                        if (nHP > 0)
                        {
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
                        }
                        if(GetLocalInt(OBJECT_SELF, "DragonFireInspOn"))
                        {
                            ApplyDragonfire(nAttack, nDuration, oTarget, OBJECT_SELF);
                        }
                    }
                }
            }
        oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
