int DMW_START_CUSTOM_TOKEN = 8000;

//Retrieve targetting information
object oMySpeaker = GetLastSpeaker();
object oMyTarget = GetLocalObject(oMySpeaker, "dmfi_univ_target");
location lMyLoc = GetLocalLocation(oMySpeaker, "dmfi_univ_location");

//::///////////////////////////////////////////////
//Test functions from dmw_test_inc

// checks if a nearby object is destroyable
int dmwand_isnearbydestroyable();
// Check if the target can be created with CreateObject
int dmwand_istargetcreateable();
//Check if target is a destroyable object
int dmwand_istargetdestroyable();
// checks if the wand was NOT clicked on an object
int dmwand_istargetinvalid();
// check if the target has an inventory
int dmwand_istargetinventory();
//Check if the target is not the wand's user
int dmwand_istargetnotme();
//Check if target is an NPC or monster
int dmwand_istargetnpc();
//Check if the target is a PC
int dmwand_istargetpc();
//Check if the target is a PC and not me
int dmwand_istargetpcnme();
// Check if the target is a PC or NPC
// uses the CON score currently
int dmwand_istargetpcornpc();
//Check if the target is a PC or an npc and not me
int dmwand_istargetpcornpcnme();
// Check if target is a placeable
int dmwand_istargetplaceable();

//::///////////////////////////////////////////////
//Conversation functions from dmw_conv_inc

//Build Conversation by Dopple
//Build a conversation level, adding "next" and "previous" as needed
void dmwand_BuildConversation(string sConversation, string sParams);
//Build Conversation Dialog by Dopple
//Used by BuildConversation to translate string representation of a
// dialog name to its function
int dmwand_BuildConversationDialog(int nCurrent, int nChoice, string sConversation, string sParams);

// Chose which direction something's alignment should change
int dmw_conv_ChangeAlign(int nCurrent, int nChoice, string sParams = "");
// Chose what attributes to display about a creature
int dmw_conv_DispAttribs(int nCurrent, int nChoice, string sParams = "");
// Chose what ability or skill to do a roll with
int dmw_conv_DoRoll(int nCurrent, int nChoice, string sParams = "");
// Chose what to do with an object's inventory
int dmw_conv_Inventory(int nCurrent, int nChoice, string sParams = "");
// Diaplay an item's stats, and chose what to do with that item
int dmw_conv_ItemListConv(int nCurrent, int nChoice, string sParams = "");
// List a creature's inventory
int dmw_conv_ListInventory(int nCurrent, int nChoice, string sParams = "");
// List all players
int dmw_conv_ListPlayers(int nCurrent, int nChoice, string sParams = "");
// Chose how much to modify alignment by
int dmw_conv_ModAlign(int nCurrent, int nChoice, string sParams = "");
// Chose how much to change reputation by
int dmw_conv_ModRep(int nCurrent, int nChoice, string sParams = "");
// Chose whether a roll should be public or private
int dmw_conv_Roll(int nCurrent, int nChoice, string sParams = "");
// Starting conversation, all branches lead from here
int dmw_conv_Start(int nCurrent, int nChoice, string sParams = "");
// Chose how far to advance the time of day
int dmw_conv_TimeOfDay(int nCurrent, int nChoice, string sParams = "");

//::///////////////////////////////////////////////
//dmwand functions from dmw_func_inc

//Ability Roll Funtion by Jhenne
// - nAbility: ABILITY_*
// - nSecret: TRUE if roll should not be shown to other players
void dmwand_AbilityCheck(int nAbility, int nSecret = TRUE);
//Advance time by Dopple
// -nHours: number of hours to advance time by
void dmwand_AdvanceTime(int nHours);
//Alignment by Robert Bernavich, Jhenne, Archaego
// function returns concatenated string version of objects Alignment
string dmwand_Alignment(object oEntity);
//ClassLevel by Robert Bernavich, Jhenne, Archaego
// Returns all three classes and levels in string format of Object
string dmwand_ClassLevel(object oEntity);
//Destroy item by Dopple
//Destroys item in "dmw_item" local object on speaker, then returns to
// inventory list dialog
void dmwand_DestroyItem();
//Destroy nearby by Dopple
// Destroy the first object we find nearby the target location, then
// return to starting dialog
void dmwand_DestroyNearbyTarget();
//Destroy target by Dopple, adapted from Bioware script in World Builder Guide
// destroy target object/creature, then return to starting dialog
void dmwand_DestroyTarget();
//Export Characters suggested by a great number of people
void dmwand_ExportChars();
//Follow me by Jhenne
// force creature or player to follow user
void dmwand_FollowMe();
//Follow Target by Jhenne
// force user to follow target
void dmwand_FollowTarget();
//Gender by Robert Bernavich, Jhenne, Archaego
// function returns a string value of objects gender
string dmwand_Gender(object oEntity);
//Identify item by Dopple
// toggle identified status of item in "dmw_item" local object on user,
// then return to the ItemListConv dialog
void dmwand_IdentifyItem();
//Inventory by Robert Bernavich, Jhenne, Archaego, Dopple
// Loop through the objects inventory and return a string value of entire
// inventory
string dmwand_Inventory(object oEntity);
//Item Info by Robert Bernavich, Jhenne, Archaego, and Dopple
string dmwand_ItemInfo(object oItem, int nLongForm = 0);
//Join player's party
void dmwand_JoinParty();
//Jump player by Jhenne
void dmwand_JumpPlayerHere();
//Jump to player by Jhenne
void dmwand_JumpToPlayer();
//Kick PC by Dopple and Jhenne
// Kick out the target PC
void dmwand_KickPC();
//Kill the target, forcing it to leave a corpse behind
// taken from Bioware's KillAndReplace() in the World Builder Guide
void dmwand_KillAndReplace();
//Leave target's party
void dmwand_LeaveParty();
//Map area by Dopple
// Give the target a full map of the area
void dmwand_MapArea();
//Mod One Rep by Jhenne and Dopple
// Modify the reputations of target creature and player towards each other
void dmwand_ModOneRep(string sPlayer);
//Mod Rep by Jhenne and Dopple
// Modify the reputations of target creature and all players towards each
// other
void dmwand_ModRep(string sAmt);
//Player list conversation by Dopple
// Used to return to starting dialog after selecting a player
void dmwand_PlayerListConv(string sParams);
//Race by Robert Bernavich, Jhenne, Archaego
// Returns string version of objects race
string dmwand_Race(object oEntity);
//Reload Module by Dopple
// reload the current running module
void dmwand_ReloadModule();
//Resume default by Jhenne
// make target resume waypoints if creature, stop everything if player
void dmwand_ResumeDefault();
//Shift Alignment by Jhenne and Dopple
// Shift the alignment of object
// - sAlign: law__/chaos/good_/evil
// - nShift: amount to shift by
void dmwand_ShiftAlignment(string sAlign, int nShift);
//ShowAllAttribs by Robert Bernavich, Jhenne, Archaego
// Return formatted report of player's character information
void dmwand_ShowAllAttribs();
//ShowBasicAttribs by Robert Bernavich, Jhenne, Archaego
// Return formatted report of player's basic character information
void dmwand_ShowBasicAttribs();
//ShowInventory by RRobert Bernavich, Jhenne, Archaego
// Return formatted report of player's inventory
void dmwand_ShowInventory();
//Skill Roll Funtion by Jhenne, modified by Dopple
// - nSkill: SKILL_*
// - nSecret: TRUE if roll should not be shown to other players
void dmwand_SkillCheck(int nSkill, int nSecret = TRUE);
//Swap Day/Night by Dopple
// - nDay: 1 to make it day, 0 to make it night
void dmwand_SwapDayNight(int nDay);
//Take all by Jhenne and Dopple
// Take all items from target
void dmwand_TakeAll();
//Take all equipped by Jhenne and Dopple
// Take all equipped items off of target
void dmwand_TakeAllEquipped();
//Take all unequipped by Jhenne and Dopple
// take all unequipped items from target
void dmwand_TakeAllUnequipped();
//Take Item by Jhenne and Dopple
// take dialog-selected item from target, and return to inventory list dialog
void dmwand_TakeItem();
//Item Stripper by Jhenne - remove item from target
// - oEquip: object to remove
void dmwand_takeoneitem(object oEquip);
//Toad..err..penguin the player by Dopple
// I would rather a chicken, but it seems that's not a valid polymorph type :(
void dmwand_Toad();
//TurnNearOff by Dopple, adapted from Bioware's on/off script
// Turn a placeable near the target location off
void dmwand_TurnNearOff();
//TurnNearOn by Dopple, adapted from Bioware's on/off script
// Turn a placeable near the target location on
void dmwand_TurnNearOn();
//TurnOff by Dopple, adapted from Bioware's on/off script
// Turn a placeable off
void dmwand_TurnOff(object oMyPlaceable);
//TurnOn by Dopple, adapted from Bioware's on/off script
// Turn a placeable on
void dmwand_TurnOn(object oMyPlaceable);
//TurnTargetOff by Dopple, adapted from Bioware's on/off script
// Turn target off
void dmwand_TurnTargetOff();
//TurnTargetOn by Dopple, adapted from Bioware's on/off script
// Turn target on
void dmwand_TurnTargetOn();
//UnToad..err..penguin the player by Dopple
// reverse effects of Toad
void dmwand_Untoad();

//Do Dialog Choice by Dopple
//Dialog function in dmw_dodialog_inc, performs a function or starts
// another dialog function when a dialog choice is selected
void dmwand_DoDialogChoice(int nChoice);

//Start Conversation by Dopple
// Function to start the ball rolling, in dmw_start_inc
void dmwand_StartConversation();

//DMFI: Added by hahnsoo
// Function gets the value of all items carried by oPC
int DMFI_GetNetWorth(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);
    int iValue = 0;
    while (GetIsObjectValid(oItem))
    {
        iValue = iValue + GetGoldPieceValue(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    return iValue;
}

int dmwand_isnearbydestroyable()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   int nTargetType = GetObjectType(oMyTest);
   return (GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)) && ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE)));
}

int dmwand_istargetcreateable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   return ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE));
}

int dmwand_istargetdestroyable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   if(! GetIsPC(oMyTarget))
   {
      return ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE));
   }
   return FALSE;
}

int dmwand_istargetinvalid()
{
   return !GetIsObjectValid(oMyTarget);
}

int dmwand_istargetinventory()
{
   return (GetIsObjectValid(oMyTarget) && GetHasInventory(oMyTarget));
}

int dmwand_istargetnotme()
{
   return (GetIsObjectValid(oMyTarget) && (oMySpeaker != oMyTarget));
}

int dmwand_istargetnpc()
{
   return (dmwand_istargetpcornpc() && (! GetIsPC(oMyTarget)));
}

int dmwand_istargetpc()
{
   return (GetIsObjectValid(oMyTarget) && GetIsPC(oMyTarget));
}

int dmwand_istargetpcnme()
{
   return (GetIsObjectValid(oMyTarget) && GetIsPC(oMyTarget) && (oMySpeaker != oMyTarget));
}

int dmwand_istargetpcornpc()
{
   return (GetIsObjectValid(oMyTarget) && GetAbilityScore(oMyTarget, ABILITY_CONSTITUTION));
}

int dmwand_istargetpcornpcnme()
{
   return (dmwand_istargetpcornpc() && (oMySpeaker != oMyTarget));
}

int dmwand_istargetplaceable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   return (nTargetType == OBJECT_TYPE_PLACEABLE);
}

//::///////////////////////////////////////////////
//:: File: dmw_func_inc
//::
//:: Useful functions for the DM's Helper
//:://////////////////////////////////////////////

void dmwand_AbilityCheck(int nAbility, int nSecret = TRUE)
{
   int nRoll=d20();
   int nRank=GetAbilityModifier (nAbility, oMyTarget);
   int nResult=nRoll+nRank;
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nRank);
   string sResult=IntToString(nResult);
   string sAbility;

   switch(nAbility)
   {
      case ABILITY_CHARISMA:
         sAbility = "Charisma"; break;
      case ABILITY_CONSTITUTION:
         sAbility = "Constitution"; break;
      case ABILITY_DEXTERITY:
         sAbility = "Dexterity"; break;
      case ABILITY_INTELLIGENCE:
         sAbility = "Intelligence"; break;
      case ABILITY_STRENGTH:
         sAbility = "Strength"; break;
      case ABILITY_WISDOM:
         sAbility = "Wisdom"; break;
   }

   SendMessageToPC(oMySpeaker, GetName(oMyTarget)+"'s "+sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult);

   if (!nSecret)
   {
      AssignCommand( oMyTarget, SpeakString(sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));
   }
}

void dmwand_AdvanceTime(int nHours)
{
   int nCurrentHour = GetTimeHour();
   int nCurrentMinute = GetTimeMinute();
   int nCurrentSecond = GetTimeSecond();
   int nCurrentMilli = GetTimeMillisecond();

   nCurrentHour += nHours;
   SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);
   dmwand_BuildConversation("TimeOfDay", "");
}

string dmwand_Alignment(object oEntity)
{
   string sReturnString;

   switch (GetAlignmentLawChaos(oEntity))
   {
      case ALIGNMENT_LAWFUL:   sReturnString = "Lawful "; break;
      case ALIGNMENT_NEUTRAL: sReturnString = "Neutral "; break;
      case ALIGNMENT_CHAOTIC:   sReturnString = "Chaotic ";  break;
   }

   switch (GetAlignmentGoodEvil(oEntity))
   {
      case ALIGNMENT_GOOD:   sReturnString = sReturnString + "Good"; break;
      case ALIGNMENT_NEUTRAL: sReturnString = sReturnString +  "Neutral"; break;
      case ALIGNMENT_EVIL:   sReturnString = sReturnString +  "Evil";  break;
   }

   if (sReturnString == "Neutral Neutral"){sReturnString = "True Neutral";}

   return sReturnString;
}

string dmwand_ClassLevel(object oEntity)
{
   string sReturnString;
   string sClass;
   string sClassOne;
   string sClassTwo;
   string sClassThree;
   int nLevelOne;
   int nLevelTwo;
   int nLevelThree;
   int iIndex;

   // Loop through all three classes and pull out info
   for(iIndex == 1;iIndex < 4;iIndex++)
   {
      switch (GetClassByPosition(iIndex,oEntity))
      {
         case CLASS_TYPE_ABERRATION: sClass ="Aberration";break;
         case CLASS_TYPE_ANIMAL:     sClass ="Animal"; break;
         case CLASS_TYPE_BARBARIAN:  sClass ="Barbarian";break;
         case CLASS_TYPE_BARD:         sClass ="Bard"; break;
         case CLASS_TYPE_BEAST:        sClass ="Beast"; break;
         case CLASS_TYPE_CLERIC:       sClass ="Cleric"; break;
         case CLASS_TYPE_COMMONER:     sClass ="Commoner";break;
         case CLASS_TYPE_CONSTRUCT:    sClass ="Construct"; break;
         case CLASS_TYPE_DRAGON:       sClass ="Dragon"; break;
         case CLASS_TYPE_DRUID:        sClass ="Druid";break;
         case CLASS_TYPE_ELEMENTAL:    sClass ="Elemental"; break;
         case CLASS_TYPE_FEY:          sClass ="Fey";break;
         case CLASS_TYPE_FIGHTER:      sClass ="Fighter";  break;
         case CLASS_TYPE_GIANT:        sClass ="Giant";  break;
         case CLASS_TYPE_HUMANOID:     sClass ="Humanoid"; break;
         case CLASS_TYPE_INVALID:      sClass ="";break;
         case CLASS_TYPE_MAGICAL_BEAST:sClass ="Magical Beast"; break;
         case CLASS_TYPE_MONK:         sClass ="Monk";   break;
         case CLASS_TYPE_OUTSIDER:     sClass ="Outsider"; break;
         case CLASS_TYPE_MONSTROUS:    sClass ="Monstrous"; break;
         case CLASS_TYPE_PALADIN:      sClass ="Paladin";break;
         case CLASS_TYPE_RANGER:       sClass ="Ranger";break;
         case CLASS_TYPE_ROGUE:        sClass ="Rogue";break;
         case CLASS_TYPE_SHAPECHANGER: sClass ="Shapechanger";break;
         case CLASS_TYPE_SORCERER:     sClass ="Sorcerer";break;
         case CLASS_TYPE_UNDEAD:       sClass ="Undead";break;
         case CLASS_TYPE_VERMIN:       sClass ="Vermin"; break;
         case CLASS_TYPE_WIZARD:       sClass ="Wizard"; break;
      }

      // Now depending on which iteration we just went through
      // assign it to the proper class
      switch (iIndex)
      {
         case 1: sClassOne =   sClass;  break;
         case 2: sClassTwo =   sClass;  break;
         case 3: sClassThree = sClass;  break;
      }
   };

   // Now get all three class levels.  Wil be 0 if does class pos
   //does not exists
   nLevelOne =   GetLevelByPosition(1,oEntity);
   nLevelTwo =   GetLevelByPosition(2,oEntity);
   nLevelThree = GetLevelByPosition(3,oEntity);

   //Start building return string
   sReturnString = sClassOne + "(" + IntToString(nLevelOne) + ")" ;

   //If second class exists append to return string
   if(nLevelTwo > 0)
   {
      sReturnString =sReturnString + "/" + sClassTwo + "(" + IntToString(nLevelTwo) + ")";
   }

   //If third class exists append to return string
   if(nLevelThree > 0)
   {
      sReturnString =sReturnString + "/" + sClassThree + "(" + IntToString(nLevelThree) + ")";
   }

   return sReturnString;
}

void dmwand_DestroyItem()
{

   object oItem = GetLocalObject(oMySpeaker, "dmw_item");

   if(GetIsObjectValid(oItem))
   {
      DestroyObject(oItem);
   }
   dmwand_BuildConversation("ListInventory", "");
}

void dmwand_DestroyNearbyTarget()
{
   effect eDestroy = EffectVisualEffect(VFX_IMP_SUNSTRIKE);

   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      DestroyObject(oMyTest);
      ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDestroy, lMyLoc);
   }
   dmwand_BuildConversation("Start", "");
}

void dmwand_DestroyTarget()
{
   effect eDestroy = EffectVisualEffect(VFX_IMP_SUNSTRIKE);

   // Added by Scrotok, to make it compatible with Keron Blackfeld's corpse script
   if ((GetTag(oMyTarget) == "invis_corpse_obj") || (GetTag(oMyTarget) == "loot_bones_obj"))
    {
       if (GetTag(oMyTarget) == "loot_bones_obj")
        {
           SetLocalInt(oMyTarget, "nDestroyedByDMsHelper", TRUE);
        }
       effect eDestroy = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
       ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDestroy, lMyLoc);
       ExecuteScript("_kb_corpse_death", oMyTarget);
       dmwand_BuildConversation("Start", "");
       return;
    }

   DestroyObject(oMyTarget);
   ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDestroy, lMyLoc);
   dmwand_BuildConversation("Start", "");
}

void dmwand_ExportChars()
{
   ExportAllCharacters();
}

void dmwand_FollowMe()
{
   AssignCommand ( oMyTarget, ActionForceFollowObject( oMySpeaker));
}

void dmwand_FollowTarget()
{
      AssignCommand ( oMySpeaker, ActionForceFollowObject(oMyTarget));
}

string dmwand_Gender(object oEntity)
{
   switch (GetGender(oEntity))
   {
      case GENDER_MALE:   return "Male"; break;
      case GENDER_FEMALE: return "Female"; break;
      case GENDER_BOTH:   return "Both";  break;
      case GENDER_NONE:   return "None";  break;
      case GENDER_OTHER:  return "Other";  break;
   }

   return "Weirdo";
}

void dmwand_IdentifyItem()
{
   object oItem = GetLocalObject(oMySpeaker, "dmw_item");

   if(GetIsObjectValid(oItem))
   {
      SetIdentified(oItem, (GetIdentified(oItem)?FALSE:TRUE));
   }
   dmwand_BuildConversation("ItemListConv", "");
}

string dmwand_Inventory(object oEntity)
{

   string sBaseType;
   string sReturnString;

   object oItem = GetFirstItemInInventory(oEntity);

   while(oItem != OBJECT_INVALID)
   {
      sReturnString = sReturnString + "\n" + dmwand_ItemInfo(oItem, 0);
      oItem = GetNextItemInInventory(oEntity);
   };

   sReturnString = sReturnString + "\nEquipped:\n";
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget))){ sReturnString = sReturnString + "Arms: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget))){ sReturnString = sReturnString + "Belt: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget))){ sReturnString = sReturnString + "Boots: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget))){ sReturnString = sReturnString + "Chest: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget))){ sReturnString = sReturnString + "Cloak: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget))){ sReturnString = sReturnString + "Head: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget))){ sReturnString = sReturnString + "Left Hand: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget))){ sReturnString = sReturnString + "Left Ring: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget))){ sReturnString = sReturnString + "Neck: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget))){ sReturnString = sReturnString + "Right Hand: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget))){ sReturnString = sReturnString + "Right Ring: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget))){ sReturnString = sReturnString + "Arrows: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget))){ sReturnString = sReturnString + "Bolts: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget))){ sReturnString = sReturnString + "Bullets: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oMyTarget))){ sReturnString = sReturnString + "Creature Armor: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oMyTarget))){ sReturnString = sReturnString + "Creature Bite: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oMyTarget))){ sReturnString = sReturnString + "Creature Left: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oMyTarget),0) + "\n"; }
   if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oMyTarget))){ sReturnString = sReturnString + "Creature Right: " + dmwand_ItemInfo(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oMyTarget),0) + "\n"; }

   return sReturnString;
}

string dmwand_ItemInfo(object oItem, int nLongForm = 0)
{
   string sReturnString = "";
   string sBaseType = "";
   string sStacked = "";
   string sIdentified = "";
   string sGPValue = "";
   string sACValue = "";
   string sProperties = "";

   switch(GetBaseItemType(oItem))
   {
      case BASE_ITEM_AMULET: sBaseType ="Amulet";break;
      case BASE_ITEM_ARMOR: sBaseType ="Armor";break;
      case BASE_ITEM_ARROW: sBaseType ="Arrow";break;
      case BASE_ITEM_BASTARDSWORD: sBaseType ="Bastard Sword";break;
      case BASE_ITEM_BATTLEAXE: sBaseType ="Battle Axe";break;
      case BASE_ITEM_BELT: sBaseType ="Belt";break;
      case BASE_ITEM_BOLT : sBaseType ="Bolt";break;
      case BASE_ITEM_BOOK: sBaseType ="Book";break;
      case BASE_ITEM_BOOTS: sBaseType ="Boots";break;
      case BASE_ITEM_BRACER: sBaseType ="Bracer";break;
      case BASE_ITEM_BULLET: sBaseType ="Bullet";break;
      case BASE_ITEM_CBLUDGWEAPON: sBaseType ="Bludgeoning Weap.";break;
      case BASE_ITEM_CLOAK: sBaseType ="Cloak";break;
      case BASE_ITEM_CLUB: sBaseType ="Club";break;
      case BASE_ITEM_CPIERCWEAPON: sBaseType ="Pierceing Weap.";break;
      case BASE_ITEM_CREATUREITEM: sBaseType ="Creature Item";break;
      case BASE_ITEM_CSLASHWEAPON: sBaseType ="Slash Weap.";break;
      case BASE_ITEM_CSLSHPRCWEAP: sBaseType ="Slash/Pierce Weap.";break;
      case BASE_ITEM_DAGGER: sBaseType ="Dagger";break;
      case BASE_ITEM_DART: sBaseType ="Dart";break;
      case BASE_ITEM_DIREMACE: sBaseType ="Mace";break;
      case BASE_ITEM_DOUBLEAXE: sBaseType ="Double Axe";break;
      case BASE_ITEM_GEM: sBaseType ="Gem";break;
      case BASE_ITEM_GLOVES: sBaseType ="Gloves";break;
      case BASE_ITEM_GOLD: sBaseType ="Gold";break;
      case BASE_ITEM_GREATAXE: sBaseType ="Great Axe";break;
      case BASE_ITEM_GREATSWORD: sBaseType ="Great Sword";break;
      case BASE_ITEM_HALBERD: sBaseType ="Halberd";break;
      case BASE_ITEM_HANDAXE: sBaseType ="Hand Axe";break;
      case BASE_ITEM_HEALERSKIT: sBaseType ="Healers Kit";break;
      case BASE_ITEM_HEAVYCROSSBOW: sBaseType ="Heavy Xbow";break;
      case BASE_ITEM_HEAVYFLAIL: sBaseType ="Heavy Flail";break;
      case BASE_ITEM_HELMET: sBaseType ="Helmet";break;
      case BASE_ITEM_INVALID: sBaseType ="";break;
      case BASE_ITEM_KAMA: sBaseType ="Kama";break;
      case BASE_ITEM_KATANA: sBaseType ="Katana";break;
      case BASE_ITEM_KEY: sBaseType ="Key";break;
      case BASE_ITEM_KUKRI: sBaseType ="Kukri";break;
      case BASE_ITEM_LARGEBOX: sBaseType ="Large Box";break;
      case BASE_ITEM_LARGESHIELD: sBaseType ="Large Shield";break;
      case BASE_ITEM_LIGHTCROSSBOW: sBaseType ="Light Xbow";break;
      case BASE_ITEM_LIGHTFLAIL: sBaseType ="Light Flail";break;
      case BASE_ITEM_LIGHTHAMMER: sBaseType ="Light Hammer";break;
      case BASE_ITEM_LIGHTMACE: sBaseType ="Light Mace";break;
      case BASE_ITEM_LONGBOW: sBaseType ="Long Bow";break;
      case BASE_ITEM_LONGSWORD: sBaseType ="Long Sword";break;
      case BASE_ITEM_MAGICROD: sBaseType ="Magic Rod";break;
      case BASE_ITEM_MAGICSTAFF: sBaseType ="Magic Staff";break;
      case BASE_ITEM_MAGICWAND: sBaseType ="Magic Wand";break;
      case BASE_ITEM_MISCLARGE: sBaseType ="Misc. Large";break;
      case BASE_ITEM_MISCMEDIUM: sBaseType ="Misc. Medium";break;
      case BASE_ITEM_MISCSMALL: sBaseType ="Misc. Small";break;
      case BASE_ITEM_MISCTALL: sBaseType ="Misc. Small";break;
      case BASE_ITEM_MISCTHIN: sBaseType ="Misc. Thin";break;
      case BASE_ITEM_MISCWIDE: sBaseType ="Misc. Wide";break;
      case BASE_ITEM_MORNINGSTAR: sBaseType ="Morningstar";break;
      case BASE_ITEM_POTIONS: sBaseType ="Potion";break;
      case BASE_ITEM_QUARTERSTAFF: sBaseType ="Quarterstaff";break;
      case BASE_ITEM_RAPIER: sBaseType ="Rapier";break;
      case BASE_ITEM_RING: sBaseType ="Ring";break;
      case BASE_ITEM_SCIMITAR: sBaseType ="Scimitar";break;
      case BASE_ITEM_SCROLL: sBaseType ="Scroll";break;
      case BASE_ITEM_SCYTHE: sBaseType ="Scythe";break;
      case BASE_ITEM_SHORTBOW: sBaseType ="Shortbow";break;
      case BASE_ITEM_SHORTSPEAR: sBaseType ="Short Spear";break;
      case BASE_ITEM_SHORTSWORD: sBaseType ="Short Sword";break;
      case BASE_ITEM_SHURIKEN: sBaseType ="Shuriken";break;
      case BASE_ITEM_SICKLE: sBaseType ="Sickle";break;
      case BASE_ITEM_SLING: sBaseType ="Sling";break;
      case BASE_ITEM_SMALLSHIELD: sBaseType ="Small Shield";break;
      case BASE_ITEM_SPELLSCROLL: sBaseType ="Spell Scroll";break;
      case BASE_ITEM_THIEVESTOOLS: sBaseType ="Thieves Tools";break;
      case BASE_ITEM_THROWINGAXE: sBaseType ="Throwing Axe";break;
      case BASE_ITEM_TORCH: sBaseType ="Torch";break;
      case BASE_ITEM_TOWERSHIELD: sBaseType ="Tower Shield";break;
      case BASE_ITEM_TRAPKIT: sBaseType ="Trap Kit";break;
      case BASE_ITEM_TWOBLADEDSWORD: sBaseType ="2 Bladed Sword";break;
      case BASE_ITEM_WARHAMMER: sBaseType ="Warhammer";break;
   }

   if (sBaseType != "Gold")
   {
      // If more than one item (stacked)
      if (GetNumStackedItems(oItem) > 1 )
      {
         sStacked = "(" + IntToString(GetNumStackedItems(oItem)) + ") ";
      }
      else
      {
         // Build remainder of output string
         sStacked = "";
      }
   }

   if(nLongForm)
   {
      sIdentified = "Identified: " + ((GetIdentified(oItem))?"Yes":"No");
      sGPValue = "Gold Piece Value: " + IntToString(GetGoldPieceValue(oItem));
      int nACValue = GetItemACValue(oItem);
      if(nACValue) { sACValue = "AC: " + IntToString(nACValue); }

      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ABILITY_BONUS)) { sProperties = sProperties + "Ability Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS)) { sProperties = sProperties + "AC Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)) { sProperties = sProperties + "AC Bonus vs. Alignment Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)) { sProperties = sProperties + "AC Bonus vs. Damage Type\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)) { sProperties = sProperties + "AC Bonus vs. Racial Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT)) { sProperties = sProperties + "AC Bonus vs. Alignment\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS)) { sProperties = sProperties + "Attack Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)) { sProperties = sProperties + "Attack Bonus vs. Alignment Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)) { sProperties = sProperties + "Attack Bonusvs. Racial Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)) { sProperties = sProperties + "Attack Bonus vs. Alignment\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)) { sProperties = sProperties + "Weight Reduction\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_BONUS_FEAT)) { sProperties = sProperties + "Bonus Feat\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)) { sProperties = sProperties + "Bonus Spell Slot\n"; }
 ///     if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_BOOMERANG)) { sProperties = sProperties + "Boomerang\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_CAST_SPELL)) { sProperties = sProperties + "Cast Spell\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS)) { sProperties = sProperties + "Damage Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)) { sProperties = sProperties + "Damage Bonus vs. Alignment Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)) { sProperties = sProperties + "Damage Bonus vs. Racial Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT)) { sProperties = sProperties + "Damage Bonus vs. Alignment\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_REDUCTION)) { sProperties = sProperties + "Damage Reduction\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_RESISTANCE)) { sProperties = sProperties + "Damage Resistance\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_VULNERABILITY)) { sProperties = sProperties + "Damage Vulnerability\n"; }
 //     if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DANCING)) { sProperties = sProperties + "Dancing\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DARKVISION)) { sProperties = sProperties + "Darkvision\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_ABILITY_SCORE)) { sProperties = sProperties + "Decreased Ability\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_AC)) { sProperties = sProperties + "Decreased AC\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER)) { sProperties = sProperties + "Decreased Attack Modifier\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_DAMAGE)) { sProperties = sProperties + "Decreased Damage\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER)) { sProperties = sProperties + "Decreased Enhancement Modifier\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_SAVING_THROWS)) { sProperties = sProperties + "Decreased Saving Throws\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC)) { sProperties = sProperties + "Decreased Specific Saving Throw\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)) { sProperties = sProperties + "Decreased Skill Modifier\n"; }
 //     if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_DOUBLE_STACK)) { sProperties = sProperties + "Double Stack\n"; }
//      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCED_CONTAINER_BONUS_SLOTS)) { sProperties = sProperties + "Enhanced Container Bonus Slots\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT)) { sProperties = sProperties + "Enhanced Container Reduced Weight\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS)) { sProperties = sProperties + "Enhancement Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)) { sProperties = sProperties + "Enhancement Bonus vs. Alignment Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)) { sProperties = sProperties + "Enhancement Bonus vs. Racial Group\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)) { sProperties = sProperties + "Enhancement Bonus vs. Alignment\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)) { sProperties = sProperties + "Extra Melee Damage Type\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)) { sProperties = sProperties + "Extra Ranged Damage Type\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_FREEDOM_OF_MOVEMENT)) { sProperties = sProperties + "Freedom of Movement\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_HASTE)) { sProperties = sProperties + "Haste\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_HOLY_AVENGER)) { sProperties = sProperties + "Holy Avenger\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)) { sProperties = sProperties + "Immunity Damage Type\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)) { sProperties = sProperties + "Immunity Miscellaneous\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)) { sProperties = sProperties + "Immunity Specific Spell\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)) { sProperties = sProperties + "Immunity Spell School\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)) { sProperties = sProperties + "Immunity Spell Level\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMPROVED_EVASION)) { sProperties = sProperties + "Improved Evasion\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_KEEN)) { sProperties = sProperties + "Keen\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_LIGHT)) { sProperties = sProperties + "Light\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_MASSIVE_CRITICALS)) { sProperties = sProperties + "Massive Criticals\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_MIGHTY)) { sProperties = sProperties + "Mighty\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_MIND_BLANK)) { sProperties = sProperties + "Mind Blank\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_MONSTER_DAMAGE)) { sProperties = sProperties + "Monster Damage\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_NO_DAMAGE)) { sProperties = sProperties + "No Damage\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ON_HIT_PROPERTIES)) { sProperties = sProperties + "On Hit\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_ON_MONSTER_HIT)) { sProperties = sProperties + "On Monster Hit\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_POISON)) { sProperties = sProperties + "Poison\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION)) { sProperties = sProperties + "Regeneration\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION_VAMPIRIC)) { sProperties = sProperties + "Vampiric Regeneration\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_SAVING_THROW_BONUS)) { sProperties = sProperties + "Saving Throw Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)) { sProperties = sProperties + "Specific Saving Throw Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_SKILL_BONUS)) { sProperties = sProperties + "Skill Bonus\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_SPELL_RESISTANCE)) { sProperties = sProperties + "Spell Resistance\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_THIEVES_TOOLS)) { sProperties = sProperties + "Thieves Tools\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_TRAP)) { sProperties = sProperties + "Trap\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_TRUE_SEEING)) { sProperties = sProperties + "True Seeing\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_TURN_RESISTANCE)) { sProperties = sProperties + "Turn Resistance\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_UNLIMITED_AMMUNITION)) { sProperties = sProperties + "Unlimited Ammo\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP)) { sProperties = sProperties + "Alignment Group Use Limitation\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_CLASS)) { sProperties = sProperties + "Class Use Limitation\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE)) { sProperties = sProperties + "Racial Use Limitation\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT)) { sProperties = sProperties + "Alignment Use Limitation\n"; }
      if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_USE_LIMITATION_TILESET)) { sProperties = sProperties + "Tileset Use Limitation\n"; }
 //     if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_VORPAL)) { sProperties = sProperties + "Vorpal\n"; }
 //     if(GetItemHasItemProperty(oItem, ITEM_PROPERTY_WOUNDING)) { sProperties = sProperties + "Wounding\n"; }
      if(sProperties != "") { sProperties = "Properties:\n" + sProperties; }

      sReturnString = sStacked + GetName(oItem) + "\n" +
                      "-------------------------------------------\n" +
                      sBaseType + "\n" +
                      sIdentified + "\n" +
                      ((nACValue)?sACValue + "\n":"") +
                      sProperties;
   }
   else
   {
      sReturnString = sStacked + GetName(oItem) + " (" + sBaseType + ")";
   }
   return sReturnString;
}

void dmwand_JoinParty()
{
   AssignCommand(oMySpeaker, AddToParty( oMySpeaker, GetFactionLeader(oMyTarget)));
}

void dmwand_JumpPlayerHere()
{
   location lJumpLoc = GetLocation(oMySpeaker);
   AssignCommand(oMyTarget, ClearAllActions());
   AssignCommand(oMyTarget, ActionJumpToLocation(lJumpLoc));
}

//Added by hahnsoo, jumps a party to the DM
void dmwand_JumpPartyHere()
{
   location lJumpLoc = GetLocation(oMySpeaker);
    object oParty = GetFirstFactionMember(oMyTarget);
    while (GetIsObjectValid(oParty))
    {
        AssignCommand(oParty, ClearAllActions());
        AssignCommand(oParty, ActionJumpToLocation(lJumpLoc));
        oParty = GetNextFactionMember(oMyTarget);
    }
}


void dmwand_JumpToPlayer()
{
   location lJumpLoc = GetLocation(oMyTarget);
   AssignCommand(oMySpeaker, ActionJumpToLocation(lJumpLoc));
}

void dmwand_KickPC()
{
   // Create a lightning strike, thunder, scorch mark, and random small
   // lightnings at target's location
   AssignCommand( oMySpeaker, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), lMyLoc));
   AssignCommand ( oMySpeaker, PlaySound ("as_wt_thundercl3"));
   object oScorch = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_weathmark", lMyLoc, FALSE);
   object oTargetArea = GetArea(oMySpeaker);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 5; nCount++)
   {
      nXPos = Random(10) - 5;
      nYPos = Random(10) - 5;

      vector vNewVector = GetPositionFromLocation(lMyLoc);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lNewLoc = Location(oTargetArea, vNewVector, 0.0);
      AssignCommand( oMySpeaker, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S), lNewLoc));
   }
   DelayCommand ( 20.0, DestroyObject ( oScorch));

   // Kick the target out of the game
   BootPC(oMyTarget);
}

void dmwand_KillAndReplace()
{
   SetPlotFlag(oMyTarget, FALSE);
   AssignCommand(oMyTarget, SetIsDestroyable(FALSE, FALSE));
   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMyTarget));
}

void dmwand_LeaveParty()
{
   RemoveFromParty(oMySpeaker);
}

void dmwand_MapArea()
{
   object omyarea = GetArea(oMySpeaker);
   ExploreAreaForPlayer(omyarea, oMyTarget);
}

void dmwand_ModOneRep(string sPlayer)
{
   string sAmt = GetLocalString(oMySpeaker, "dmw_repamt");
   int nAmt = StringToInt(sAmt);
   object oPlayer = GetLocalObject(oMySpeaker, "dmw_playercache" + sPlayer);

   AdjustReputation(oPlayer, oMyTarget, nAmt);
   AdjustReputation(oMyTarget, oPlayer, nAmt);
}

void dmwand_ModRep(string sAmt)
{
   SetLocalString(oMySpeaker, "dmw_repamt", sAmt);
   string sAllOrOne = GetLocalString(oMySpeaker, "dmw_repargs");
   if(TestStringAgainstPattern(sAllOrOne, "one"))
   {
      dmwand_BuildConversation("ListPlayers", "func_ModOneRep");
      return;
   }
   int nAmt = StringToInt(sAmt);

   object oPlayer = GetFirstPC();
   while(GetIsObjectValid(oPlayer))
   {
      AdjustReputation(oPlayer, oMyTarget, nAmt);
      AdjustReputation(oMyTarget, oPlayer, nAmt);
      oPlayer = GetNextPC();
   }
}

void dmwand_PlayerListConv(string sParams)
{
   int nPlayer = StringToInt(sParams);
   int nCache;
   int nCount;

   object oPlayer = GetLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nPlayer));
   oMyTarget = oPlayer;
   SetLocalObject(oMySpeaker, "dmfi_univ_target", oMyTarget);

   //Go back to the first conversation level
   dmwand_BuildConversation("Start", "");
}

string dmwand_Race(object oEntity)
{
   switch (GetRacialType(oEntity))
   {
      case RACIAL_TYPE_ALL:   return "All"; break;
      case RACIAL_TYPE_ANIMAL:   return "Animal"; break;
      case RACIAL_TYPE_BEAST:   return "Beast"; break;
      case RACIAL_TYPE_CONSTRUCT:   return "Construct"; break;
      case RACIAL_TYPE_DRAGON:   return "Dragon"; break;
      case RACIAL_TYPE_DWARF:   return "Dwarf"; break;
      case RACIAL_TYPE_ELEMENTAL:   return "Elemental"; break;
      case RACIAL_TYPE_ELF:   return "Elf"; break;
      case RACIAL_TYPE_FEY:   return "Fey"; break;
      case RACIAL_TYPE_GIANT:   return "Giant"; break;
      case RACIAL_TYPE_GNOME:   return "Gnome"; break;
      case RACIAL_TYPE_HALFELF:   return "Half Elf"; break;
      case RACIAL_TYPE_HALFLING:   return "Halfling"; break;
      case RACIAL_TYPE_HALFORC:   return "Half Orc"; break;
      case RACIAL_TYPE_HUMAN:   return "Human"; break;
      case RACIAL_TYPE_HUMANOID_GOBLINOID:   return "Goblinoid"; break;
      case RACIAL_TYPE_HUMANOID_MONSTROUS:   return "Monstrous"; break;
      case RACIAL_TYPE_HUMANOID_ORC:   return "Orc"; break;
      case RACIAL_TYPE_HUMANOID_REPTILIAN:   return "Reptillian"; break;
//      case RACIAL_TYPE_INVALID:   return "Unknown"; break;
      case RACIAL_TYPE_MAGICAL_BEAST:   return "Magical Beast"; break;
      case RACIAL_TYPE_OUTSIDER:   return "Outsider"; break;
      case RACIAL_TYPE_SHAPECHANGER:   return "Shapechanger"; break;
      case RACIAL_TYPE_UNDEAD:   return "Undead"; break;
      case RACIAL_TYPE_VERMIN:   return "Vermin"; break;
   }

   return "Unknown";
}

void dmwand_ReloadModule()
{
   string sModuleName = GetModuleName();
//   SendMessageToPC(oMySpeaker,"CRASHES MODULE-DISABLED");
   StartNewModule(sModuleName);
}

void dmwand_ResumeDefault()
{
   if(GetIsPC(oMyTarget))
   {
      AssignCommand ( oMyTarget, ClearAllActions());
   }
   else
   {
      ExecuteScript ( "nw_c2_default9", oMyTarget);
   }
}

void dmwand_ShiftAlignment(string sAlign, int nShift)
{
   if(TestStringAgainstPattern(sAlign, "law__"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_LAWFUL, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "chaos"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_CHAOTIC, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "good_"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_GOOD, nShift);
      return;
   }
   if(TestStringAgainstPattern(sAlign, "evil_"))
   {
      AdjustAlignment (oMyTarget, ALIGNMENT_EVIL, nShift);
      return;
   }
}

void dmwand_ShowAllAttribs()
{
   string sSTR = IntToString(GetAbilityScore(oMyTarget,ABILITY_STRENGTH));
   string sINT = IntToString(GetAbilityScore(oMyTarget,ABILITY_INTELLIGENCE));
   string sDEX = IntToString(GetAbilityScore(oMyTarget,ABILITY_DEXTERITY));
   string sWIS = IntToString(GetAbilityScore(oMyTarget,ABILITY_WISDOM));
   string sCON = IntToString(GetAbilityScore(oMyTarget,ABILITY_CONSTITUTION));
   string sCHA = IntToString(GetAbilityScore(oMyTarget,ABILITY_CHARISMA));
   string sReport = "\n-------------------------------------------" +
                    "\nReported: " + IntToString(GetTimeHour()) + ":" + IntToString(GetTimeMinute()) +
                    "\nPlayer Name: " + GetPCPlayerName(oMyTarget) +
                    "PubCDKey: " + GetPCPublicCDKey(oMyTarget) +
                    "\nChar Name:   " + GetName(oMyTarget) +
                    "\n-------------------------------------------" +
                    "\nRace:    " + dmwand_Race(oMyTarget) +
                    "\nClass:    " + dmwand_ClassLevel(oMyTarget) +
                    "\nXP:     " + IntToString(GetXP(oMyTarget)) +
                    "\nGender: " + dmwand_Gender(oMyTarget) +
                    "\nAlign:    " + dmwand_Alignment(oMyTarget) +
                    "\nDeity:  " + GetDeity(oMyTarget) +
                    "\n" +
                    "\nSTR:  " + sSTR +
                    "\nINT:   " + sINT +
                    "\nWIS:  " + sWIS +
                    "\nDEX:  " + sDEX +
                    "\nCON: " + sCON +
                    "\nCHA:  " + sCHA +
                    "\n" +
                    "\nHP:  " + IntToString(GetCurrentHitPoints(oMyTarget)) +
                    " of " + IntToString(GetMaxHitPoints(oMyTarget)) +
                    "\nAC:  " + IntToString(GetAC(oMyTarget)) +
                    "\n\nGold:  " + IntToString(GetGold(oMyTarget)) +
                    "\n\nNet Worth:  " + IntToString(DMFI_GetNetWorth(oMyTarget) + GetGold(oMyTarget)) +
                    "\nInventory:\n  " + dmwand_Inventory(oMyTarget) +
                    "\n-------------------------------------------";

   SetLocalString(oMySpeaker, "dmw_dialog0", sReport);
}

void dmwand_ShowBasicAttribs()
{
   string sSTR = IntToString(GetAbilityScore(oMyTarget,ABILITY_STRENGTH));
   string sINT = IntToString(GetAbilityScore(oMyTarget,ABILITY_INTELLIGENCE));
   string sDEX = IntToString(GetAbilityScore(oMyTarget,ABILITY_DEXTERITY));
   string sWIS = IntToString(GetAbilityScore(oMyTarget,ABILITY_WISDOM));
   string sCON = IntToString(GetAbilityScore(oMyTarget,ABILITY_CONSTITUTION));
   string sCHA = IntToString(GetAbilityScore(oMyTarget,ABILITY_CHARISMA));
   string sReport = "\n-------------------------------------------" +
                    "\nPlayer Name: " + GetPCPlayerName(oMyTarget) +
                    "\nChar Name:   " + GetName(oMyTarget) +
                    "\n-------------------------------------------" +
                    "\nRace:    " + dmwand_Race(oMyTarget) +
                    "\nClass:    " + dmwand_ClassLevel(oMyTarget) +
                    "\nXP:     " + IntToString(GetXP(oMyTarget)) +
                    "\nGender: " + dmwand_Gender(oMyTarget) +
                    "\nAlign:    " + dmwand_Alignment(oMyTarget) +
                    "\nDeity:  " + GetDeity(oMyTarget) +
                    "\n" +
                    "\nSTR:  " + sSTR +
                    "\nINT:   " + sINT +
                    "\nWIS:  " + sWIS +
                    "\nDEX:  " + sDEX +
                    "\nCON: " + sCON +
                    "\nCHA:  " + sCHA +
                    "\n" +
                    "\nHP:  " + IntToString(GetCurrentHitPoints(oMyTarget)) +
                    " of " + IntToString(GetMaxHitPoints(oMyTarget)) +
                    "\nAC:  " + IntToString(GetAC(oMyTarget)) +
                    "\n\nGold:  " + IntToString(GetGold(oMyTarget)) +
                    "\n\nNet Worth:  " + IntToString(DMFI_GetNetWorth(oMyTarget) + GetGold(oMyTarget)) +
                    "\n-------------------------------------------";
   SetLocalString(oMySpeaker, "dmw_dialog0", sReport);
}

void dmwand_ShowInventory()
{
   string sReport = "\n-------------------------------------------" +
                    "\nPlayer Name: " + GetPCPlayerName(oMyTarget) +
                    "\nChar Name:   " + GetName(oMyTarget) +
                    "\n-------------------------------------------" +
                    "\nInventory:\n  " + dmwand_Inventory(oMyTarget) +
                    "\n-------------------------------------------";
   SetLocalString(oMySpeaker, "dmw_dialog0", sReport);
}

void dmwand_SkillCheck(int nSkill, int nSecret = TRUE)
{
   int nRoll=d20();
   int nRank=GetSkillRank (nSkill, oMyTarget);
   int nResult=nRoll+nRank;
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nRank);
   string sResult=IntToString(nResult);
   string sSkill;

   switch(nSkill)
   {
      case SKILL_ANIMAL_EMPATHY:
         sSkill = "Animal Empathy"; break;
      case SKILL_CONCENTRATION:
         sSkill = "Concentration"; break;
      case SKILL_DISABLE_TRAP:
         sSkill = "Disable Trap"; break;
      case SKILL_DISCIPLINE:
         sSkill = "Discipline"; break;
      case SKILL_HEAL:
         sSkill = "Heal"; break;
      case SKILL_HIDE:
         sSkill = "Hide"; break;
      case SKILL_LISTEN:
         sSkill = "Listen"; break;
      case SKILL_LORE:
         sSkill = "Lore"; break;
      case SKILL_MOVE_SILENTLY:
         sSkill = "Move Silently"; break;
      case SKILL_OPEN_LOCK:
         sSkill = "Open Lock"; break;
      case SKILL_PARRY:
         sSkill = "Parry"; break;
      case SKILL_PERFORM:
         sSkill = "Perform"; break;
      case SKILL_PERSUADE:
         sSkill = "Persuade"; break;
      case SKILL_PICK_POCKET:
         sSkill = "Pick Pocket"; break;
      case SKILL_SEARCH:
         sSkill = "Search"; break;
      case SKILL_SET_TRAP:
         sSkill = "Set Trap"; break;
      case SKILL_SPELLCRAFT:
         sSkill = "Spellcraft"; break;
      case SKILL_SPOT:
         sSkill = "Spot"; break;
      case SKILL_TAUNT:
         sSkill = "Taunt"; break;
      case SKILL_USE_MAGIC_DEVICE:
         sSkill = "Use Magic Device"; break;
   }
   SendMessageToPC(oMySpeaker, GetName(oMyTarget)+"'s "+sSkill+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult);

   if (!nSecret)
   {
      AssignCommand( oMyTarget, SpeakString(sSkill+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult));
   }
}

void dmwand_SwapDayNight(int nDay)
{
   int nCurrentHour;
   int nCurrentMinute = GetTimeMinute();
   int nCurrentSecond = GetTimeSecond();
   int nCurrentMilli = GetTimeMillisecond();

   nCurrentHour = ((nDay == 1)?7:19);

   SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);
   dmwand_BuildConversation("TimeOfDay", "");
}

void dmwand_TakeAll()
{
   dmwand_TakeAllEquipped();
   dmwand_TakeAllUnequipped();
}

void dmwand_TakeAllEquipped()
{
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget));
   dmwand_takeoneitem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget));
}

void dmwand_TakeAllUnequipped()
{
   object oEquip = GetFirstItemInInventory(oMyTarget);
   while(GetIsObjectValid(oEquip))
   {
      dmwand_takeoneitem(oEquip);
      oEquip = GetNextItemInInventory(oMyTarget);
   }
}

void dmwand_TakeItem()
{
   object oItem = GetLocalObject(oMySpeaker, "dmw_item");

   dmwand_takeoneitem(oItem);
   dmwand_BuildConversation("ListInventory", "");
}

void dmwand_takeoneitem(object oEquip)
{
   if (GetIsObjectValid(oEquip) != 0)
   {
      AssignCommand(oMySpeaker, ActionTakeItem(oEquip, oMyTarget));
   }
}

void dmwand_Toad()
{
   effect ePenguin = EffectPolymorph(POLYMORPH_TYPE_PENGUIN);
   effect eParalyze = EffectParalyze();
   SendMessageToPC(oMySpeaker, "Penguin?  Don't you mean toad?");

   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenguin, oMyTarget));
   AssignCommand(oMyTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oMyTarget));
   SetLocalInt(oMyTarget, "toaded", 1);
}

void dmwand_TurnNearOff()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      dmwand_TurnOff(oMyTest);
   }
}

void dmwand_TurnNearOn()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   while(GetIsObjectValid(oMyTest) && GetIsPC(oMyTest))
   {
      object oMyTest = GetNextObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   }

   if(GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)))
   {
      dmwand_TurnOn(oMyTest);
   }
}

void dmwand_TurnOff(object oMyPlaceable)
{
   AssignCommand(oMyPlaceable, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
   DelayCommand(0.4,SetPlaceableIllumination(oMyPlaceable, FALSE));
   DelayCommand(0.5,RecomputeStaticLighting(GetArea(oMyPlaceable)));
}

void dmwand_TurnOn(object oMyPlaceable)
{
   AssignCommand(oMyPlaceable, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
   DelayCommand(0.4,SetPlaceableIllumination(oMyPlaceable, TRUE));
   DelayCommand(0.5,RecomputeStaticLighting(GetArea(oMyPlaceable)));
}

void dmwand_TurnTargetOff()
{
   dmwand_TurnOff(oMyTarget);
}

void dmwand_TurnTargetOn()
{
   dmwand_TurnOn(oMyTarget);
}

void dmwand_Untoad()
{
   effect eMyEffect = GetFirstEffect(oMyTarget);
   while(GetIsEffectValid(eMyEffect))
   {
      if(GetEffectType(eMyEffect) == EFFECT_TYPE_POLYMORPH ||
         GetEffectType(eMyEffect) == EFFECT_TYPE_PARALYZE)
      {
         RemoveEffect(oMyTarget, eMyEffect);
      }
      eMyEffect = GetNextEffect(oMyTarget);
   }
}

//::///////////////////////////////////////////////
//:: File: dmw_conv_inc
//::
//:: Conversation functions for the DM's Helper
//:://////////////////////////////////////////////

int dmwand_BuildConversationDialog(int nCurrent, int nChoice, string sConversation, string sParams)
{
   if(TestStringAgainstPattern(sConversation, "ChangeAlign"))
   {
      return dmw_conv_ChangeAlign(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "DispAttribs"))
   {
      return dmw_conv_DispAttribs(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "DoRoll"))
   {
      return dmw_conv_DoRoll(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "Inventory"))
   {
      return dmw_conv_Inventory(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ItemListConv"))
   {
      return dmw_conv_ItemListConv(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ListInventory"))
   {
      return dmw_conv_ListInventory(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ListPlayers"))
   {
      return dmw_conv_ListPlayers(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ModAlign"))
   {
      return dmw_conv_ModAlign(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ModRep"))
   {
      return dmw_conv_ModRep(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "Roll"))
   {
      return dmw_conv_Roll(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "Start"))
   {
      return dmw_conv_Start(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "TimeOfDay"))
   {
      return dmw_conv_TimeOfDay(nCurrent, nChoice, sParams);
   }
   return FALSE;
}

void dmwand_BuildConversation(string sConversation, string sParams)
{
   int nLast;
   int nTemp;
   int nChoice = 1;
   int nCurrent = 1;
   int nMatch;

   if(TestStringAgainstPattern(sParams, "prev"))
   {
      //Get the number choice to start with
      nCurrent = GetLocalInt(oMySpeaker, "dmw_dialogprev");

      //Since we're going to the previous page, there will be a next
      SetLocalString(oMySpeaker, "dmw_dialog9", "Next ->");
      SetLocalString(oMySpeaker, "dmw_function9", "conv_" + sConversation);
      SetLocalString(oMySpeaker, "dmw_params9", "next");
      SetLocalInt(oMySpeaker, "dmw_dialognext", nCurrent);

      nChoice = 8;
      for(;nChoice >= 0; nChoice--)
      {
         int nTemp1 = nCurrent;
         int nTemp2 = nCurrent;
         nMatch = nTemp2;
         while((nCurrent == nMatch) && (nTemp2 > 0))
         {
            nTemp2--;
            nMatch = dmwand_BuildConversationDialog(nTemp2, nChoice, sConversation, sParams);
         }

         if(nTemp2 <= 0)
         {
            //we went back too far for some reason, so make this choice blank
            SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), "");
            SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), "");
            SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), "");
         }
         nLast = nTemp;
         nTemp = nTemp1;
         nTemp1 = nMatch;
         nCurrent = nMatch;
      }

      if(nMatch > 0)
      {
         SetLocalString(oMySpeaker, "dmw_dialog1", "<- previous");
         SetLocalString(oMySpeaker, "dmw_function1", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params1", "prev");
         SetLocalInt(oMySpeaker, "dmw_dialogprev", nLast);
      }

      //fill the NPC's dialog spot
      //(saved for last because the build process tromps on it)
      dmwand_BuildConversationDialog(0, 0, sConversation, sParams);
   }
   else
   {
      //fill the NPC's dialog spot
      dmwand_BuildConversationDialog(0, 0, sConversation, sParams);

      //No parameters specified, start at the top of the conversation
      if(sParams == "")
      {
         nChoice = 1;
         nCurrent = 1;
      }

      //A "next->" choice was selected
      if(TestStringAgainstPattern(sParams, "next"))
      {
         //get the number choice to start with
         nCurrent = GetLocalInt(oMySpeaker, "dmw_dialognext");

         //set this as the number for the "previous" choice to use
         SetLocalInt(oMySpeaker, "dmw_dialogprev", nCurrent);

         //Set the first dialog choice to be "previous"
         nChoice = 2;
         SetLocalString(oMySpeaker, "dmw_dialog1", "<- Previous");
         SetLocalString(oMySpeaker, "dmw_function1", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params1", "prev");
      }

      //Loop through to build the dialog list
      for(;nChoice <= 10; nChoice++)
      {
         nMatch = dmwand_BuildConversationDialog(nCurrent, nChoice, sConversation, sParams);
         //nLast will be the value of the choice before the last one
         nLast = nTemp;
         nTemp = nMatch;
         if(nMatch > 0) { nCurrent = nMatch; }
         if(nMatch == 0) { nLast = 0; }
         nCurrent++;
      }

      //If there were enough choices to fill 10 spots, make spot 9 a "next"
      if(nLast > 0)
      {
         SetLocalString(oMySpeaker, "dmw_dialog9", "Next ->");
         SetLocalString(oMySpeaker, "dmw_function9", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params9", "next");
         SetLocalInt(oMySpeaker, "dmw_dialognext", nLast);
      }
   }
}

//:://////////////////////////////////////////////
//:: Dialog functions, in alpha order
//:://////////////////////////////////////////////
//Dialog functions (in general) use the following structure:
/*
int dmw_conv_FunctName(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   //Build the current dialog entry
   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Text to display in the top section.";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         if(TestToDisplayOption())
         {
            nCurrent = 1;
            sText =       "Option text.";
            sCall =       "callthis";
            sCallParams = "passthis";
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   //Set the local variables for this dialog entry
   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   //Let the caller know which choice matched
   return nCurrent;
}
*/
int dmw_conv_ChangeAlign(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Which direction would you like to change?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Law.";
         sCall =       "conv_ModAlign";
         sCallParams = "law__";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Chaos.";
         sCall =       "conv_ModAlign";
         sCallParams = "chaos";
         break;
      case 3:
         nCurrent = 3;
         sText =       "Good.";
         sCall =       "conv_ModAlign";
         sCallParams = "good_";
         break;
      case 4:
         nCurrent = 4;
         sText =       "Evil.";
         sCall =       "conv_ModAlign";
         sCallParams = "evil_";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_DispAttribs(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "What attributes would you like to see?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Everything.";
         sCall =       "func_ShowAllAttribs";
         sCallParams = "";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Basic Character.";
         sCall =       "func_ShowBasicAttribs";
         sCallParams = "";
         break;
      case 3:
         nCurrent = 3;
         sText =       "Display inventory.";
         sCall =       "func_ShowInventory";
         sCallParams = "";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_DoRoll(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   if((! TestStringAgainstPattern(sParams, "next")) && (! TestStringAgainstPattern(sParams, "prev")))
   {
      SetLocalString(oMySpeaker, "dmw_rollargs", sParams);
   }

   string sArgs = GetLocalString(oMySpeaker, "dmw_rollargs");
   string sStatOrSkill = GetStringLeft(sArgs, 7);
   string sPrivate = GetStringRight(sArgs, 1);

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Which ability?";
         }
         else
         {
            sText =       "Which skill?";
         }
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Strength.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_STRENGTH);
            break;
         }
      case 2:
         nCurrent = 2;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Constitution.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_CONSTITUTION);
            break;
         }
      case 3:
         nCurrent = 3;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Dexterity.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_DEXTERITY);
            break;
         }
      case 4:
         nCurrent = 4;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Intelligence.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_INTELLIGENCE);
            break;
         }
      case 5:
         nCurrent = 5;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Wisdom.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_WISDOM);
            break;
         }
      case 6:
         nCurrent = 6;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Charisma.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_CHARISMA);
            break;
         }
      case 7:
         nCurrent = 7;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Animal Empathy.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_ANIMAL_EMPATHY);
            break;
         }
      case 8:
         nCurrent = 8;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Concentration.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_CONCENTRATION);
            break;
         }
      case 9:
         nCurrent = 9;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Disable Trap.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_DISABLE_TRAP);
            break;
         }
      case 10:
         nCurrent = 10;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Discipline.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_DISCIPLINE);
            break;
         }
      case 11:
         nCurrent = 11;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Heal.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_HEAL);
            break;
         }
      case 12:
         nCurrent = 12;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Hide.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_HIDE);
            break;
         }
      case 13:
         nCurrent = 13;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Listen.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_LISTEN);
            break;
         }
      case 14:
         nCurrent = 14;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Lore.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_LORE);
            break;
         }
      case 15:
         nCurrent = 15;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Move Silently.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_MOVE_SILENTLY);
            break;
         }
      case 16:
         nCurrent = 16;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Open Lock.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_OPEN_LOCK);
            break;
         }
      case 17:
         nCurrent = 17;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Parry.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_PARRY);
            break;
         }
      case 18:
         nCurrent = 18;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Perform.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_PERFORM);
            break;
         }
      case 19:
         nCurrent = 19;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Persuade.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_PERSUADE);
            break;
         }
      case 20:
         nCurrent = 20;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Pick Pocket.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_PICK_POCKET);
            break;
         }
      case 21:
         nCurrent = 21;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Search.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_SEARCH);
            break;
         }
      case 22:
         nCurrent = 22;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Set Trap.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_SET_TRAP);
            break;
         }
      case 23:
         nCurrent = 23;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Spellcraft.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_SPELLCRAFT);
            break;
         }
      case 24:
         nCurrent = 24;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Spot.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_SPOT);
            break;
         }
      case 25:
         nCurrent = 25;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Taunt.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_TAUNT);
            break;
         }
      case 26:
         nCurrent = 26;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Use Magic Device.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_USE_MAGIC_DEVICE);
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_Inventory(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "What would you like to do with this object's inventory?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Work with individual items.";
         sCall =       "conv_ListInventory";
         sCallParams = "";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Take all items.";
         sCall =       "func_TakeAll";
         sCallParams = "";
         break;
      case 3:
         nCurrent = 3;
         sText =       "Take all equipped items.";
         sCall =       "func_TakeAllEquipped";
         sCallParams = "";
         break;
      case 4:
         nCurrent = 4;
         sText =       "Take all unequipped items.";
         sCall =       "func_TakeAllUnequipped";
         sCallParams = "";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ItemListConv(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";
   int nCache;
   int nCount;
   object oItem;

   if((sParams != "") && (! TestStringAgainstPattern(sParams, "next")) && (! TestStringAgainstPattern(sParams, "prev")))
   {
      //We've been given an item to work with, save that item!
      oItem = GetLocalObject(oMySpeaker, "dmw_itemcache" + sParams);
      SetLocalObject(oMySpeaker, "dmw_item", oItem);
   }
   else
   {
      oItem = GetLocalObject(oMySpeaker, "dmw_item");
   }

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       dmwand_ItemInfo(oItem, 1);
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Take this item.";
         sCall =       "func_TakeItem";
         sCallParams = "";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Destroy this item.";
         sCall =       "func_DestroyItem";
         sCallParams = "";
         break;
      case 3:
         nCurrent = 3;
         if(! GetIdentified(oItem))
         {
            sText =       "Set this item as identified.";
            sCall =       "func_IdentifyItem";
            sCallParams = "";
            break;
         }
      case 4:
         nCurrent = 4;
         if(GetIdentified(oItem))
         {
            sText =       "Set this item as unidentified.";
            sCall =       "func_IdentifyItem";
            sCallParams = "";
            break;
         }
      case 5:
         nCurrent = 5;
         sText =       "Go back to the inventory list.";
         sCall =       "conv_ListInventory";
         sCallParams = "";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ListInventory(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";
   object oItem;
   int nCache;

   if(sParams == "")
   {
      //This is the first time running this function, so cache the objects
      // of all items... we don't want our list swapping itself around every
      // time you change a page
      int nCount = 1;
      oItem = GetFirstItemInInventory(oMyTarget);
      while(GetIsObjectValid(oItem))
      {
         SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount), oItem);
         oItem = GetNextItemInInventory(oMyTarget);
         nCount++;
      }

      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CARMOUR, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oMyTarget));

      nCount--;
      SetLocalInt(oMySpeaker, "dmw_itemcache", nCount);
   }

   nCache = GetLocalInt(oMySpeaker, "dmw_itemcache");

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "What item would you like to see?";
         sCall =       "";
         sCallParams = "";
         break;
      default:
         //Find the next item in the cache that is valid
         oItem = GetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCurrent));
         while((! GetIsObjectValid(oItem)) && (nCurrent <= nCache))
         {
            nCurrent++;
            oItem = GetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCurrent));
         }

         if(nCurrent > nCache)
         {
            //We've run out of cache, any other spots in this list should be
            //skipped
            nCurrent = 0;
            sText =       "";
            sCall =       "";
            sCallParams = "";
         }
         else
         {
            //We found an item, set up the list entry
            sText =       dmwand_ItemInfo(oItem, 0);
            sCall =       "conv_ItemListConv";
            sCallParams = IntToString(nCurrent);
         }
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ListPlayers(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";
   object oPlayer;
   int nCache;

   if((! TestStringAgainstPattern(sParams, "next")) && (! TestStringAgainstPattern(sParams, "prev")))
   {
      //This is the first time running this function, so cache the objects
      // of all players... we don't want our list swapping itself around every
      // time you change a page
      SetLocalString(oMySpeaker, "dmw_playerfunc", sParams);
      int nCount = 1;
      oPlayer = GetFirstPC();
      while(GetIsObjectValid(oPlayer))
      {
         SetLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCount), oPlayer);
         oPlayer = GetNextPC();
         nCount++;
      }
      nCount--;
      SetLocalInt(oMySpeaker, "dmw_playercache", nCount);
   }

   string sFunc = GetLocalString(oMySpeaker, "dmw_playerfunc");
   nCache = GetLocalInt(oMySpeaker, "dmw_playercache");

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Who would you like to work on?";
         sCall =       "";
         sCallParams = "";
         break;
      default:
         //Find the next player in the cache who is valid
         oPlayer = GetLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCurrent));
         while((! GetIsObjectValid(oPlayer)) && (nCurrent <= nCache))
         {
            nCurrent++;
            oPlayer = GetLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCurrent));
         }

         if(nCurrent > nCache)
         {
            //We've run out of cache, any other spots in this list should be
            //skipped
            nCurrent = 0;
            sText =       "";
            sCall =       "";
            sCallParams = "";
         }
         else
         {
            //We found a player, set up the list entry
            sText =       GetName(oPlayer) + " (" + GetPCPlayerName(oPlayer) + ")";
            sCall =       sFunc;
            sCallParams = IntToString(nCurrent);
         }
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ModAlign(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Change by how much?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "1 point.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "1";
         break;
      case 2:
         nCurrent = 2;
         sText =       "5 points.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "5";
         break;
      case 3:
         nCurrent = 3;
         sText =       "10 points.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "10";
         break;
      case 4:
         nCurrent = 4;
         sText =       "20 points.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "20";
         break;
      case 5:
         nCurrent = 5;
         sText =       "50 points.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "50";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ModRep(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";
   string sOneOrAll;

   if((! TestStringAgainstPattern(sParams, "next")) && (! TestStringAgainstPattern(sParams, "prev")))
   {
      SetLocalString(oMySpeaker, "dmw_repargs", sParams);
   }
   sOneOrAll = GetLocalString(oMySpeaker, "dmw_repargs");

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Change reputation by how much?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Plus 70";
         sCall =       "func_ModRep";
         sCallParams = "+70";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Plus 30";
         sCall =       "func_ModRep";
         sCallParams = "+30";
         break;
      case 3:
         nCurrent = 3;
         sText =       "Plus 10";
         sCall =       "func_ModRep";
         sCallParams = "+10";
         break;
      case 4:
         nCurrent = 4;
         sText =       "Plus 5";
         sCall =       "func_ModRep";
         sCallParams = "+05";
         break;
      case 5:
         nCurrent = 5;
         sText =       "Minus 5";
         sCall =       "func_ModRep";
         sCallParams = "-05";
         break;
      case 6:
         nCurrent = 6;
         sText =       "Minus 10";
         sCall =       "func_ModRep";
         sCallParams = "-10";
         break;
      case 7:
         nCurrent = 7;
         sText =       "Minus 30";
         sCall =       "func_ModRep";
         sCallParams = "-30";
         break;
      case 8:
         nCurrent = 8;
         sText =       "Minus 70";
         sCall =       "func_ModRep";
         sCallParams = "-70";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_Roll(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Should This Roll be Public or Private?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Public";
         sCall =       "conv_DoRoll";
         sCallParams = sParams + "0";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Private";
         sCall =       "conv_DoRoll";
         sCallParams = sParams + "1";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_Start(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Hello there, DM.  What can I do for you?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Display this creature's attributes.";
            sCall =       "conv_DispAttribs";
            sCallParams = "";
            break;
         }
      case 2:
         nCurrent = 2;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Change this creature's alignment.";
            sCall =       "conv_ChangeAlign";
            sCallParams = "";
            break;
         }
      case 3:
         nCurrent = 3;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Map area out for this player.";
            sCall =       "func_MapArea";
            sCallParams = "";
            break;
         }
      case 4:
         nCurrent = 4;
         if(dmwand_istargetinventory())
         {
            sText =       "Work with this object's inventory.";
            sCall =       "conv_Inventory";
            sCallParams = "";
            break;
         }
     case 5:
         nCurrent = 5;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Follow this creature.";
            sCall =       "func_FollowTarget";
            sCallParams = "";
            break;
         }
      case 6:
         nCurrent = 6;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Make this creature follow me.";
            sCall =       "func_FollowMe";
            sCallParams = "";
            break;
         }
      case 7:
         nCurrent = 7;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Make this creature go about its business.";
            sCall =       "func_ResumeDefault";
            sCallParams = "";
            break;
         }
      case 8:
         nCurrent = 8;
         if(dmwand_istargetpcnme())
         {
            sText =       "Penguin this player.";
            sCall =       "func_Toad";
            sCallParams = "";
            break;
         }
      case 9:
         nCurrent = 9;
         if(dmwand_istargetpcnme())
         {
            sText =       "Unpenguin this player.";
            sCall =       "func_Untoad";
            sCallParams = "";
            break;
         }
      case 10:
         nCurrent = 10;
         if(dmwand_istargetpcnme())
         {
            sText =       "Boot this player.";
            sCall =       "func_KickPC";
            sCallParams = "";
            break;
         }
      case 11:
         nCurrent = 11;
         if(dmwand_istargetnpc())
         {
            sText =       "Kill this, leaving a corpse.";
            sCall =       "func_KillAndReplace";
            sCallParams = "";
            break;
         }
      case 12:
         nCurrent = 12;
         if(dmwand_istargetinvalid())
         {
            sText =       "List all players...";
            sCall =       "conv_ListPlayers";
            sCallParams = "func_PlayerListConv";
            break;
         }
      case 13:
         nCurrent = 13;
         if(dmwand_istargetinvalid())
         {
            sText =       "Advance the current time of day.";
            sCall =       "conv_TimeOfDay";
            sCallParams = "";
            break;
         }
      case 14:
         nCurrent = 14;
         if(dmwand_istargetinvalid())
         {
            sText =       "Reload the current running module.";
            sCall =       "func_ReloadModule";
            sCallParams = "";
            break;
         }
      case 15:
         nCurrent = 15;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Roll a skill check.";
            sCall =       "conv_Roll";
            sCallParams = "skill__";
            break;
         }
      case 16:
         nCurrent = 16;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Roll an ability check.";
            sCall =       "conv_Roll";
            sCallParams = "ability";
            break;
         }
      case 17:
         nCurrent = 17;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Destroy this object.";
            sCall =       "func_DestroyTarget";
            sCallParams = "";
            break;
         }
      case 18:
         nCurrent = 18;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Destroy an object near this spot.";
            sCall =       "func_DestroyNearbyTarget";
            sCallParams = "";
            break;
         }
      case 19:
         nCurrent = 19;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Turn this object on.";
            sCall =       "func_TurnTargetOn";
            sCallParams = "";
            break;
         }
      case 20:
         nCurrent = 20;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Turn this object off.";
            sCall =       "func_TurnTargetOff";
            sCallParams = "";
            break;
         }
      case 21:
         nCurrent = 21;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Turn on an object near this spot.";
            sCall =       "func_TurnNearOn";
            sCallParams = "";
            break;
         }
      case 22:
         nCurrent = 22;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Turn off an object near this spot.";
            sCall =       "func_TurnNearOff";
            sCallParams = "";
            break;
         }
      case 23:
         nCurrent = 23;
         if(dmwand_istargetnpc())
         {
            sText =       "Change a player's reputation with this creature's faction.";
            sCall =       "conv_ModRep";
            sCallParams = "one";
            break;
         }
      case 24:
         nCurrent = 24;
         if(dmwand_istargetnpc())
         {
            sText =       "Change all player reputations with this creature's faction.";
            sCall =       "conv_ModRep";
            sCallParams = "all";
            break;
         }
      case 25:
         nCurrent = 25;
         if(dmwand_istargetinvalid())
         {
            sText =       "Export all characters.";
            sCall =       "func_ExportChars";
            sCallParams = "";
            break;
         }
      case 26:
         nCurrent = 26;
         if(dmwand_istargetpcnme())
         {
            sText =       "Join this player's party.";
            sCall =       "func_JoinParty";
            sCallParams = "";
            break;
         }
      case 27:
         nCurrent = 27;
         if(dmwand_istargetinvalid())
         {
            sText =       "Remove me from my current party.";
            sCall =       "func_LeaveParty";
            sCallParams = "";
            break;
         }
      case 28:
         nCurrent = 28;
         if(dmwand_istargetpcnme())
         {
            sText =       "Jump this player to my location.";
            sCall =       "func_JumpPlayerHere";
            sCallParams = "";
            break;
         }
      case 29:
         nCurrent = 29;
         if(dmwand_istargetpcnme())
         {
            sText =       "Jump me to this player's location.";
            sCall =       "func_JumpToPlayer";
            sCallParams = "";
            break;
         }
      case 30:
         nCurrent = 30;
         if(dmwand_istargetpcnme())
         {
            sText =       "Jump this player's party to my location.";
            sCall =       "func_JumpPartyHere";
            sCallParams = "";
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_TimeOfDay(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "How far would you like to advance the time?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "1 hour.";
         sCall =       "func_AdvanceTime";
         sCallParams = "1";
         break;
      case 2:
         nCurrent = 2;
         sText =       "3 hours.";
         sCall =       "func_AdvanceTime";
         sCallParams = "3";
         break;
      case 3:
         nCurrent = 3;
         sText =       "7 hours.";
         sCall =       "func_AdvanceTime";
         sCallParams = "7";
         break;
      case 4:
         nCurrent = 4;
         if((GetTimeHour() > 6) && (GetTimeHour() < 18))
         {
            sText =       "Make it nighttime.";
            sCall =       "func_SwapDayNight";
            sCallParams = "0";
            break;
         }
      case 5:
         nCurrent = 5;
         if((GetTimeHour() < 6) || (GetTimeHour() > 18))
         {
            sText =       "Make it daytime.";
            sCall =       "func_SwapDayNight";
            sCallParams = "1";
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

void dmwand_DoDialogChoice(int nChoice)
{
   string sCallFunction = GetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice));
   string sCallParams = GetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice));
   string sNav = "";

   string sStart = GetStringLeft(sCallFunction, 5);
   int nLen = GetStringLength(sCallFunction) - 5;
   string sCall = GetSubString(sCallFunction, 5, nLen);

   if(TestStringAgainstPattern("conv_", sStart))
   {
      dmwand_BuildConversation(sCall, sCallParams);
   }
   else
   {
      if(TestStringAgainstPattern("ShowAllAttribs", sCall))
      {
         dmwand_ShowAllAttribs();
         return;
      }
      if(TestStringAgainstPattern("ShowBasicAttribs", sCall))
      {
         dmwand_ShowBasicAttribs();
         return;
      }
      if(TestStringAgainstPattern("ShowInventory", sCall))
      {
         dmwand_ShowInventory();
         return;
      }
      if(TestStringAgainstPattern("PlayerListConv", sCall))
      {
         dmwand_PlayerListConv(sCallParams);
         return;
      }
      if(TestStringAgainstPattern("ShiftAlignment", sCall))
      {
         string sDir = GetStringLeft(sCallParams, 5);
         int nLen = GetStringLength(sCallParams) - 5;
         string sAmt = GetSubString(sCallParams, 5, nLen);
         dmwand_ShiftAlignment(sDir, StringToInt(sAmt));
         return;
      }
      if(TestStringAgainstPattern("MapArea", sCall))
      {
         dmwand_MapArea();
         return;
      }
      if(TestStringAgainstPattern("FollowTarget", sCall))
      {
         dmwand_FollowTarget();
         return;
      }
      if(TestStringAgainstPattern("FollowMe", sCall))
      {
         dmwand_FollowMe();
         return;
      }
      if(TestStringAgainstPattern("ResumeDefault", sCall))
      {
         dmwand_ResumeDefault();
         return;
      }
      if(TestStringAgainstPattern("Toad", sCall))
      {
         dmwand_Toad();
         return;
      }
      if(TestStringAgainstPattern("Untoad", sCall))
      {
         dmwand_Untoad();
         return;
      }
      if(TestStringAgainstPattern("KickPC", sCall))
      {
         dmwand_KickPC();
         return;
      }
      if(TestStringAgainstPattern("IdentifyItem", sCall))
      {
         dmwand_IdentifyItem();
         return;
      }
      if(TestStringAgainstPattern("DestroyItem", sCall))
      {
         dmwand_DestroyItem();
         return;
      }
      if(TestStringAgainstPattern("TakeItem", sCall))
      {
         dmwand_TakeItem();
         return;
      }
      if(TestStringAgainstPattern("KillAndReplace", sCall))
      {
         dmwand_KillAndReplace();
         return;
      }
      if(TestStringAgainstPattern("SwapDayNight", sCall))
      {
         dmwand_SwapDayNight(StringToInt(sCallParams));
         return;
      }
      if(TestStringAgainstPattern("AdvanceTime", sCall))
      {
         dmwand_AdvanceTime(StringToInt(sCallParams));
         return;
      }
      if(TestStringAgainstPattern("ReloadModule", sCall))
      {
         dmwand_ReloadModule();
         return;
      }
      if(TestStringAgainstPattern("TakeAll", sCall))
      {
         dmwand_TakeAll();
         return;
      }
      if(TestStringAgainstPattern("TakeAllEquipped", sCall))
      {
         dmwand_TakeAllEquipped();
         return;
      }
      if(TestStringAgainstPattern("TakeAllUnequipped", sCall))
      {
         dmwand_TakeAllUnequipped();
         return;
      }
      if(TestStringAgainstPattern("AbilityCheck", sCall))
      {
         int nPrivate = StringToInt(GetStringLeft(sCallParams, 1));
         int nLen = GetStringLength(sCallParams) - 1;
         int nAbility = StringToInt(GetSubString(sCallParams, 1, nLen));
         dmwand_AbilityCheck(nAbility, nPrivate);
         return;
      }
      if(TestStringAgainstPattern("SkillCheck", sCall))
      {
         int nPrivate = StringToInt(GetStringLeft(sCallParams, 1));
         int nLen = GetStringLength(sCallParams) - 1;
         int nSkill = StringToInt(GetSubString(sCallParams, 1, nLen));
         dmwand_SkillCheck(nSkill, nPrivate);
         return;
      }
      if(TestStringAgainstPattern("DestroyTarget", sCall))
      {
         dmwand_DestroyTarget();
         return;
      }
      if(TestStringAgainstPattern("DestroyNearbyTarget", sCall))
      {
         dmwand_DestroyNearbyTarget();
         return;
      }
      if(TestStringAgainstPattern("TurnTargetOn", sCall))
      {
         dmwand_TurnTargetOn();
         return;
      }
      if(TestStringAgainstPattern("TurnTargetOff", sCall))
      {
         dmwand_TurnTargetOff();
         return;
      }
      if(TestStringAgainstPattern("TurnNearOff", sCall))
      {
         dmwand_TurnNearOff();
         return;
      }
      if(TestStringAgainstPattern("TurnNearOn", sCall))
      {
         dmwand_TurnNearOn();
         return;
      }
      if(TestStringAgainstPattern("ModRep", sCall))
      {
         dmwand_ModRep(sCallParams);
         return;
      }
      if(TestStringAgainstPattern("ModOneRep", sCall))
      {
         dmwand_ModOneRep(sCallParams);
         return;
      }
      if(TestStringAgainstPattern("ExportChars", sCall))
      {
         dmwand_ExportChars();
         return;
      }
      if(TestStringAgainstPattern("JoinParty", sCall))
      {
         dmwand_JoinParty();
         return;
      }
      if(TestStringAgainstPattern("LeaveParty", sCall))
      {
         dmwand_LeaveParty();
         return;
      }
      if(TestStringAgainstPattern("JumpPlayerHere", sCall))
      {
         dmwand_JumpPlayerHere();
         return;
      }
      if(TestStringAgainstPattern("JumpToPlayer", sCall))
      {
         dmwand_JumpToPlayer();
         return;
      }
      if(TestStringAgainstPattern("JumpPartyHere", sCall))
      {
         dmwand_JumpPartyHere();
         return;
      }
   }
}
