//::///////////////////////////////////////////////
//:: Name x2_def_attacked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Physically attacked script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    object oPC = GetLastAttacker(OBJECT_SELF);
    if (GetIsPC(oPC))
      {
        int nCount = GetLocalInt(oPC,"npcviolator");
        nCount++;
        if (nCount > 4)
          {
            // Kill them
            effect eDead = EffectDeath(FALSE,TRUE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDead, oPC,2.6);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(487), oPC);
            SetLocalInt(oPC,"npcviolator",0);
          }
        else
          {
            SetLocalInt(oPC,"npcviolator",nCount);
          }
      }

    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------

    ExecuteScript("nw_c2_default5", OBJECT_SELF);
}
