//::///////////////////////////////////////////////
//:: Cone: Mindflayer Mind Blast
//:: x2_m1_mindblast
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Anyone caught in the cone must make a
    Will save (DC 17) or be stunned for 3d4 rounds
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: Dec 5/02
//:://////////////////////////////////////////////

#include "x2_i0_spells"

void main()
{
   int nSaveDC = 10 +(GetHitDice(OBJECT_SELF)/2) +  GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    ////Red's code to increase DC
    if (GetTag(OBJECT_SELF)=="pc_BlastDemon") nSaveDC = 60;
    if (GetTag(OBJECT_SELF)=="boom_1n_GBlastDem") nSaveDC = 70;
    if (GetTag(OBJECT_SELF)=="boom_2n_GBlastDem2") nSaveDC = 80;


   object oTarget = GetSpellTargetObject();
   DoMindBlast(nSaveDC, d4(1), 15.0f);
}

