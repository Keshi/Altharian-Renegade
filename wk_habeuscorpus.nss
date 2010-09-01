#include "wk_lootsystem"

void BodyFade(object oHostBody, object oBlood)
{
  object oBones;
  location lLoc = GetLocation(oHostBody);
  SetPlotFlag(oHostBody, FALSE);
  AssignCommand(oHostBody, SetIsDestroyable(TRUE,FALSE,FALSE));
  if ((GetRacialType(oHostBody) != RACIAL_TYPE_CONSTRUCT) &&
      (GetRacialType(oHostBody) != RACIAL_TYPE_ELEMENTAL)&&
      (GetRacialType(oHostBody) != RACIAL_TYPE_DRAGON)&&
      (GetRacialType(oHostBody) != RACIAL_TYPE_ANIMAL))

     {
      oBones = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bones", lLoc, FALSE);
      LootClear(oHostBody);
     }
  DestroyObject(oBlood);
  if (GetIsDead(oHostBody))DestroyObject(oHostBody, 0.2f);
 }

void main()
{
 float lsDelay  = 240.0;                      // Corpse & loot fade delay
 object oHostBody = OBJECT_SELF;              // Get the Dead Creature Object
 object oPC = GetLastKiller();                // For debugging purposes only
 object oBlood;
 object oSaveBlood;
 location lLoc = GetLocation(oHostBody);

 if ((GetRacialType(oHostBody) != RACIAL_TYPE_UNDEAD) &&
     (GetRacialType(oHostBody) != RACIAL_TYPE_CONSTRUCT) &&
     (GetRacialType(oHostBody) != RACIAL_TYPE_ELEMENTAL)&&
     (GetRacialType(oHostBody) != RACIAL_TYPE_DRAGON))
    {
     oBlood = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bloodstain", lLoc, FALSE);
    }
 DelayCommand(lsDelay, BodyFade(oHostBody, oBlood));

 //Create the lootbag
 object oLootCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, "wk_bodysack", lLoc, FALSE); //Spawn our lootable object
 //SendMessageToPC(oPC,"This is where I should be spawning the drop.");
 //if (oLootCorpse != OBJECT_INVALID) SendMessageToPC(oPC,"oLootCorpse is a valid object.");
 //else  SendMessageToPC(oPC,"oLootCorpse is an invalid object.");
 SetLocalObject(oLootCorpse, "oHostBody", oHostBody); //Set Local for deletion later if needed
 SetLocalObject(oLootCorpse, "oBlood", oBlood);
 NameSack(oLootCorpse);
 DelayCommand(0.1, wk_droploot(oHostBody, oLootCorpse));
 DelayCommand(lsDelay, LootClear(oLootCorpse));
 return;
}
