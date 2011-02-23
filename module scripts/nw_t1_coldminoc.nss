//::///////////////////////////////////////////////
//:: Minor Frost Trap
//:: NW_T1_ColdMinC
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Strikes the entering object with a blast of
    cold for 2d4 damage. Fortitude save to avoid
    being paralyzed for 1 round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 16th , 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    object oTarget = GetEnteringObject();
    effect eDam = EffectDamage(d4(2), DAMAGE_TYPE_COLD);
    effect eParal = EffectParalyze();
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eFreeze = EffectVisualEffect(VFX_DUR_BLUR);
    effect eLink = EffectLinkEffects(eParal, eFreeze);
    int fortsave=12;
    int rounds=1;

    ////  be sure to qualify this to see if creator is using spyders trap system
         // Make sure the PC speaker has these items in their inventory
    object oCreator=  GetTrapCreator(OBJECT_SELF);
    if (GetItemPossessedBy(oCreator, "widowsmark")!=OBJECT_INVALID)
    {

    int iRogue=GetLevelByClass( CLASS_TYPE_ASSASSIN,oCreator)+
               GetLevelByClass( CLASS_TYPE_ROGUE,oCreator) +
               GetLevelByClass( CLASS_TYPE_SHADOWDANCER,oCreator);

    int iSettrap=GetSkillRank(SKILL_SET_TRAP,oCreator);
    int iDam=   iRogue+iSettrap;
    fortsave=iRogue;
    SpeakString (GetName (oCreator)+"'s trap",TALKVOLUME_TALK);
    // has timestop
    if (GetItemPossessedBy(oCreator, "NW_IT_SPARSCR911")!=OBJECT_INVALID) rounds=rounds*2 ;
    // has medusa eye
    if (GetItemPossessedBy(oCreator, "medusaeye")!=OBJECT_INVALID) fortsave=iRogue  *2 ;
    // has powercore
    if (GetItemPossessedBy(oCreator, "is_sandblue003")!=OBJECT_INVALID) iDam=iDam*2 ;

    SendMessageToPC(oCreator,"Trap activated. Damage:"+IntToString(iDam)
                              +" DC:"+IntToString (fortsave)
                              +" rounds:"+IntToString (rounds) );



    eDam = EffectDamage(iDam, DAMAGE_TYPE_POSITIVE);
     }
  //time stop NW_IT_SPARSCR911
  // medusaeye
  // is_sandblue003

  /////////////////////////////////////////////////real script
    if(!MySavingThrow(SAVING_THROW_FORT,oTarget, fortsave, SAVING_THROW_TYPE_TRAP))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(rounds));
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);




}


