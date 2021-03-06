string sDeny;
/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this script OnUsed

int CheckForBook (object oPC)
{
  int nCheck = 0;
  if (GetItemPossessedBy(oPC, "bookoftheabyss01")!= OBJECT_INVALID) nCheck++;
  if (GetItemPossessedBy(oPC, "bookoftheabyss02")!= OBJECT_INVALID) nCheck++;
  if (GetItemPossessedBy(oPC, "bookoftheabyss03")!= OBJECT_INVALID) nCheck++;
  if (GetItemPossessedBy(oPC, "bookoftheabyss04")!= OBJECT_INVALID) nCheck++;
  if (GetItemPossessedBy(oPC, "bookoftheabyss05")!= OBJECT_INVALID) nCheck++;
  if (GetItemPossessedBy(oPC, "bookoftheabyss06")!= OBJECT_INVALID) nCheck++;
  if (GetItemPossessedBy(oPC, "bookoftheabyss07")!= OBJECT_INVALID) nCheck++;
  if (GetItemPossessedBy(oPC, "bookoftheabyss08")!= OBJECT_INVALID) nCheck++;
  if (GetItemPossessedBy(oPC, "bookoftheabyss09")!= OBJECT_INVALID) nCheck++;
  return nCheck;
}

void main()
{
  object oPC = GetPlaceableLastClickedBy();// Changed from GetLastUsedBy.
  if (!GetIsPC(oPC)) return;
  int nBook = CheckForBook(oPC);
  if (nBook == 0)
  {
    sDeny="You must have a Guardians Seal to use this portal.";
    SendMessageToPC(oPC, sDeny);
    return;
  }

  object oTarget;
  location lTarget;
  oTarget = GetWaypointByTag("WP_NODE_abyss");
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

