//::///////////////////////////////////////////////
//:: Generic On Pressed Respawn Button
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// * June 1: moved RestoreEffects into plot include
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   November
//:://////////////////////////////////////////////
#include "nw_i0_plot"

// * Applies an XP and GP penalty
// * to the player respawning
void ApplyPenalty(object oDead)
{

    int nXP = GetXP(oDead);
    int pLVL=0;
    // Respawn penalty set to 10*Lvl
    int nPenalty = 10 * GetHitDice(oDead);

     // If under 6th level, zero xp penalty on respawn

    if (GetHitDice(oDead) <= 5)
      nPenalty = 0;
     else
      nPenalty == 10*GetHitDice(oDead);


    int nHD = GetHitDice(oDead);
    // * You can not lose a level by respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;


    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);


    ////  now on to gold to take
   int nGoldToTake =    FloatToInt(0.00050 * GetGold(oDead));

    // a cap of 5000gp taken from you
    if (nGoldToTake > 5000)
    {
        nGoldToTake = 5000;
    }

    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));

}


int SearchString(string sSearch, string sBigString)
{
int iSlen=GetStringLength(sSearch);
int iB=GetStringLength(sBigString);
int i;
int length;
string s;

if ( iB < iSlen ) return FALSE;

length=(iB-iSlen);
for ( i= 0;i<=length ;i++) {
    s=GetSubString(  sBigString,i,iSlen);
    if ( s == sSearch ) return TRUE;
}
return FALSE;
}


void main()
{


    location lLoc  ;
    object oPlayer = GetLastRespawnButtonPresser();
    if (!GetIsObjectValid(oPlayer))
        return;

        /////////////  destroy the Death token
        object oItemToTake;
        oItemToTake = GetItemPossessedBy(oPlayer, "death");
        if(GetIsObjectValid(oItemToTake) != 0)
        {
        DestroyObject(oItemToTake);
        }


    effect eRes = EffectResurrection();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRes, oPlayer);

    effect eHeal = EffectHeal(GetMaxHitPoints(oPlayer));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPlayer);

    RemoveEffects(oPlayer);

    SetLocalInt(oPlayer, "BLEED_STATUS", 0);


    // Penalty: JB code here

     //* Return PC to temple
         AssignCommand(oPlayer, ClearAllActions());
          lLoc = GetLocation(GetWaypointByTag("WP_TempleRespawn"));

          AssignCommand(oPlayer,JumpToLocation(lLoc));

          ApplyPenalty(oPlayer);


}

