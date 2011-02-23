//::///////////////////////////////////////////////
//:: Name Things that go boom
//:: FileName xs_catapult_use
//:: Copyright (c) 2003 NWNZone.com
//:://////////////////////////////////////////////
/*
 This is the on use event for the catapults
 [Version .5a]
*/
//:://////////////////////////////////////////////
//:: Created By: Xeno
//:: Created On: 11 Aug 2003
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
effect eDark = EffectVisualEffect(VFX_DUR_DARKNESS);
effect eBoom = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
effect eFire = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
effect knockdown = EffectKnockdown();
effect dazed = EffectDazed();
effect eSmoke = EffectVisualEffect(320);
effect eDebris = EffectVisualEffect(354);
effect eDam;
float fDelay;
int nDamage;
effect eDest = EffectDeath();
object oDetinator = GetLocalObject(OBJECT_SELF, "GZ_OBJECT_ACTIVATOR");
int iRoll6 = d10(3)-7;//Very Far away. Avg b4 Reflex Save: 15-7
int iRoll5 = d10(6)-15;//Near enough. Avg b4 Reflex Save: 30-15
int iRoll4 = d10(10)-23;//Kinda close arn't ya? Avg b4 Reflex Save: 45-23
int iRoll3 = d10(20)-30;//Still gona get hurt! Avg b4 Reflex Save: 60-30
int iRoll2 = d10(30);//Too close. Avg b4 Reflex Save: 75
int iRoll1 = d10(40);//Standing Right next to it! Avg b4 Reflex Save: 90

//Produce a radius intensity damage at lLoc
//The closer you are to the lLoc, the more damage you take!
void BlastArea(location lLoc);

void Knock_Down(location lLoc)
{
 object oPC = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, TRUE, OBJECT_TYPE_CREATURE);
 while (GetIsObjectValid(oPC))
       {
        int iKnock = d10();
        //int iDazed = d10()+iKnock;
        float fKnock = IntToFloat(iKnock);
        //float fDazed = IntToFloat(iDazed);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, knockdown, oPC, fKnock);
        //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, dazed, oPC, fDazed);
        SetLocalInt(oPC, "Blast_Radius",6);
        SetIsTemporaryEnemy(oDetinator, oPC, FALSE);
        oPC = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, TRUE, OBJECT_TYPE_CREATURE);
       }
}

void Assign_Damage(location lLoc, float fRadius, int iBlastEffect)
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
          {
           if (!GetPlotFlag(oTarget))
               SetLocalInt(oTarget, "Blast_Radius", iBlastEffect);
           oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE);
          }
}

void Do_Damage(location lLoc)
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if (!GetPlotFlag(oTarget))
           {
            int iDamageApply = GetLocalInt(oTarget, "Blast_Radius");
            fDelay = GetDistanceBetweenLocations(lLoc, GetLocation(oTarget))/20;
            if  (GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
                nDamage = GetCurrentHitPoints(oTarget)+1;
            if  (GetTag(oTarget) == "XS_BOULDER")
                nDamage = GetCurrentHitPoints(oTarget)+1;
            else if (GetTag(oTarget) =="gz_obj_pkeg")
                     nDamage = d6(2); // lower chance to destroy other powerderkeg
            else if (iDamageApply==6)
                     nDamage = iRoll6;
            else if (iDamageApply==5)
                     nDamage = iRoll5;
            else if (iDamageApply==4)
                     nDamage = iRoll4;
            else if (iDamageApply==3)
                     nDamage = iRoll3;
            else if (iDamageApply==2)
                     nDamage = iRoll2;
            else if (iDamageApply==1)
                     nDamage = iRoll1;
            else nDamage = 0;

                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                if(nDamage > 0 )//& GetObjectSeen(oTarget_r6, OBJECT_SELF))
                  {
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                  }
            DeleteLocalInt(oTarget, "Blast_Radius");
           }
     oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

void BlastArea(location lLoc)
{
    //location lLoc = GetLocation(OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom, lLoc);

    DelayCommand(0.3f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eDest,lLoc));
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eDark,lLoc,0.5);
//*Has problems*//ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eSmoke,lLoc,20.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFire, lLoc);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDebris, lLoc);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDebris, lLoc);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDebris, lLoc);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDebris, lLoc);
    PlaySound("sim_explsun");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eShake, lLoc);
    //Xeno's radius intensity damage (Please give credit if you use this in other scripts.)
    //The closer you are to the source, the more damage you take!
    Knock_Down(lLoc);//Knock down everyone in area and assign max radius damage!
    Assign_Damage(lLoc, RADIUS_SIZE_GARGANTUAN, 5);//Assign damage per radius.
    Assign_Damage(lLoc, RADIUS_SIZE_HUGE, 4);//Assign damage per radius.
    Assign_Damage(lLoc, RADIUS_SIZE_LARGE, 3);//Assign damage per radius.
    Assign_Damage(lLoc, RADIUS_SIZE_MEDIUM, 2);//Assign damage per radius.
    Assign_Damage(lLoc, RADIUS_SIZE_SMALL, 1);//Assign damage per radius.
    Do_Damage(lLoc);//Now that everyones radius is assigned, do the damage that was assigned.
}
