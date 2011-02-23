//////////////////////////////////////////////////////////////////////////////
//: Check for old guardian values
//: old_guardcheck
//: Written by Winterknight for Altharia
//////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetEnteringObject();
  int nCamp = GetCampaignInt("Character","fulminate",oPC);
  if (nCamp > 0)
  {
    FloatingTextStringOnCreature("You must convert your guardian path before entering.",oPC,FALSE);
    return;
  }
  nCamp = GetCampaignInt("Character","magestaff",oPC);
  if (nCamp > 0)
  {
    FloatingTextStringOnCreature("You must convert your guardian path before entering.",oPC,FALSE);
    return;
  }
  nCamp = GetCampaignInt("Character","vesperbel",oPC);
  if (nCamp > 0)
  {
    FloatingTextStringOnCreature("You must convert your guardian path before entering.",oPC,FALSE);
    return;
  }
  nCamp = GetCampaignInt("Character","innerpath",oPC);
  if (nCamp > 0)
  {
    FloatingTextStringOnCreature("You must convert your guardian path before entering.",oPC,FALSE);
    return;
  }
  nCamp = GetCampaignInt("Character","whitegold",oPC);
  if (nCamp > 0)
  {
    FloatingTextStringOnCreature("You must convert your guardian path before entering.",oPC,FALSE);
    return;
  }
  nCamp = GetCampaignInt("Character","harmonics",oPC);
  if (nCamp > 0)
  {
    FloatingTextStringOnCreature("You must convert your guardian path before entering.",oPC,FALSE);
    return;
  }
  nCamp = GetCampaignInt("Character","stilletto",oPC);
  if (nCamp > 0)
  {
    FloatingTextStringOnCreature("You must convert your guardian path before entering.",oPC,FALSE);
    return;
  }

  object oTarget;
  location lTarget;
  oTarget = GetTransitionTarget(OBJECT_SELF);
  lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

  if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
  AssignCommand(oPC, ClearAllActions());
  DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
  oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

  int nInt;
  nInt = GetObjectType(oTarget);
  if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
  else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

}
