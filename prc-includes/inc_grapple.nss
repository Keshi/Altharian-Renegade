//::///////////////////////////////////////////////
//:: Name       inc_grapple
//:: FileName   inc_grapple
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an include for grapple related functions and stuff
*/
//:://////////////////////////////////////////////
//:: Created By: Primogenitor
//:: Created On: 09/04/2006
//:://////////////////////////////////////////////

#include "prc_inc_combat"
#include "prc_inc_sp_tch"

int GetGrappleSizeMod(int nSize)
{
    switch(nSize)
    {
        case CREATURE_SIZE_FINE:            return -16;
        case CREATURE_SIZE_DIMINUTIVE:      return -12;
        case CREATURE_SIZE_TINY:            return -8;
        case CREATURE_SIZE_SMALL:           return -4;
        case CREATURE_SIZE_MEDIUM:          return  0;
        case CREATURE_SIZE_LARGE:           return  4;
        case CREATURE_SIZE_HUGE:            return  8;
        case CREATURE_SIZE_GARGANTUAN:      return  12;
        case CREATURE_SIZE_COLOSSAL:        return  16;
    }
    return 0;
}

int GetGrappleMod(object oTarget)
{
    int nGrapple;
    if(!GetIsObjectValid(oTarget))
        return 0;
    nGrapple += GetBaseAttackBonus(oTarget);

    int nSize = PRCGetCreatureSize(oTarget);
    //Powerful Build bonus
    if(GetHasFeat(FEAT_RACE_POWERFUL_BUILD, oTarget))
        nSize++;
    //Make sure it doesn't overflow
    if(nSize > CREATURE_SIZE_COLOSSAL) nSize = CREATURE_SIZE_COLOSSAL;


    nGrapple += GetGrappleSizeMod(nSize);
    nGrapple += GetAbilityModifier(ABILITY_STRENGTH, oTarget);
    //drunken masters drunken embrace
    if(GetHasFeat(FEAT_PRESTIGE_DRUNKEN_EMBRACE, oTarget))
        nGrapple += 4;

    return nGrapple;
}

int DoGrappleCheck(object oAttacker, object oDefender, 
    int nAttackerMod = 0, int nDefenderMod = 0, 
    string sAttackerName = "", string sDefenderName = "")
{
    //cant grapple incorporeal or ethereal things
    if((GetIsEthereal(oDefender) && !GetIsEthereal(oAttacker)) 
        || GetIsIncorporeal(oDefender))
        return FALSE;

    int nResult;
    int nDefenderGrapple = nDefenderMod;
    int nDefenderRoll = d20();
    nDefenderGrapple += GetGrappleMod(oDefender);
    nDefenderGrapple += nDefenderRoll;
    int nAttackerGrapple = nAttackerMod;
    int nAttackerRoll = d20();
    nAttackerGrapple += GetGrappleMod(oAttacker);
    nAttackerGrapple += nAttackerRoll;
    //defender has benefit
    if(nAttackerGrapple > nDefenderGrapple)
        nResult = TRUE;

    string sMessage;
    if(GetIsPC(oAttacker)) sMessage += PRC_TEXT_LIGHT_BLUE;
    else                   sMessage += PRC_TEXT_LIGHT_PURPLE;
    if(GetIsObjectValid(oAttacker))
        sMessage += GetName(oAttacker);
    else
        sMessage += sAttackerName;
    sMessage += PRC_TEXT_ORANGE;
    sMessage += " grapples ";
    if(GetIsObjectValid(oDefender))
        sMessage += GetName(oDefender);
    else
        sMessage += sDefenderName;
    sMessage += " : ";

    if(nResult)
        sMessage += "*hit*";
    else
        sMessage += "*miss*";

    sMessage += " : ("+IntToString(nAttackerRoll)+" + "+IntToString(nAttackerGrapple-nAttackerRoll)+" = "+IntToString(nAttackerGrapple);
    sMessage += " vs "+IntToString(nDefenderRoll)+" + "+IntToString(nDefenderGrapple-nDefenderRoll)+" = "+IntToString(nDefenderGrapple)+")";
    SendMessageToPC(oAttacker, sMessage);
    SendMessageToPC(oDefender, sMessage);
    return nResult;
}

int GetIsGrappled(object oTarget)
{
    int nGrappled;
    return nGrappled;
}

int GetIsGrappledByObject(object oTarget, object oGrappler)
{
    int nGrappled;
    return nGrappled;
}

void SetIsGrappledByObject(object oTarget, object oGrappler)
{

    SetLocalInt(oTarget, "GrappledBy_"+ObjectToString(OBJECT_SELF),
        GetLocalInt(oTarget, "GrappledBy_"+ObjectToString(OBJECT_SELF))+1);
    DelayCommand(6.1,
        SetLocalInt(oTarget, "GrappledBy_"+ObjectToString(OBJECT_SELF),
            GetLocalInt(oTarget, "GrappledBy_"+ObjectToString(OBJECT_SELF))-1));
}

// Rather than PnP grappling where you can do various things
// while grappling, both targets are immobilised. 
// If a player uses their grapple feat on a target they are already
// grappling, then they will use grapple special attacks (constrict, swallow etc).
void StartGrapple(object oAttacker, object oDefender, 
    int nAttackerMod = 0, int nDefenderMod = 0, 
    string sAttackerName = "", string sDefenderName = "")
{
    //cant grapple incorporeal or ethereal things
    if((GetIsEthereal(oDefender) && !GetIsEthereal(oAttacker))
        || GetIsIncorporeal(oDefender))
        return;

    if(GetIsGrappledByObject(oDefender, oAttacker))
    {
        //special stuff code
        return;
    }
    //initiate grapple
    //provoke attack of opportunity
    effect eInvalid;
    PerformAttack(oDefender, oAttacker, eInvalid);
    int nAoO = GetLocalInt(oDefender, "PRCCombat_StruckByAttack");
    //grapple only works if it missed
    if(!nAoO)
    {
        //touch attack
        //bypass if oAttacker is not valid
        if(!GetIsObjectValid(oAttacker)
            || PRCDoMeleeTouchAttack(oDefender, TRUE, oAttacker))
        {
            //grapple check
            if(DoGrappleCheck(oAttacker, oDefender, 
                nAttackerMod, nDefenderMod, 
                sAttackerName, sDefenderName))
            {
                //now grappled
                //create the effect
                effect eHold = EffectCutsceneImmobilize();
                effect eEntangle = EffectVisualEffect(VFX_DUR_SPELLTURNING_R);
                effect eLink = EffectLinkEffects(eHold, eEntangle);
                //apply the effect
                SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oAttacker, 6.0);
                SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oDefender, 6.0);
                //run the pseudoHB
            }
        }
    }
}