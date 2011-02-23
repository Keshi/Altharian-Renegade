//::////////////////////////////////////////////
//:: dm_onering_main for DM One Ring
//:: Written by Winterknight for Altharia
//:: Last update 04/30/08
//::////////////////////////////////////////////


//:://////////////////////////////////////////////////////////////////:://
//::                       Encounter Function                         :://
//:://////////////////////////////////////////////////////////////////:://
void DoEncounterSpawn(location lDrop, string sVillains)
{
  string sResref;

  if (sVillains == "SkeletonRoadCrew") // Veteran - undead
  {
    sResref = "jp_minorskelly1"; // Example only
    CreateObject(OBJECT_TYPE_CREATURE,sResref,lDrop,FALSE);
    sResref = "jp_minorskelly1"; // Example only
    CreateObject(OBJECT_TYPE_CREATURE,sResref,lDrop,FALSE);
    sResref = "jp_skellypriest"; // Example only
    CreateObject(OBJECT_TYPE_CREATURE,sResref,lDrop,FALSE);
    sResref = "jp_skellymage"; // Example only
    CreateObject(OBJECT_TYPE_CREATURE,sResref,lDrop,FALSE);
  }

  if (sVillains == "WeakAssDemons") // Veteran - Outsider
  {
    sResref = "jp_minorskelly1"; // Example only
    CreateObject(OBJECT_TYPE_CREATURE,sResref,lDrop,FALSE);
    sResref = "jp_minorskelly1"; // Example only
    CreateObject(OBJECT_TYPE_CREATURE,sResref,lDrop,FALSE);
    sResref = "jp_skellypriest"; // Example only
    CreateObject(OBJECT_TYPE_CREATURE,sResref,lDrop,FALSE);
    sResref = "jp_skellymage"; // Example only
    CreateObject(OBJECT_TYPE_CREATURE,sResref,lDrop,FALSE);
  }

// Etc., Etc.
} // End DoEncounterSpawn

//:://////////////////////////////////////////////////////////////////:://
//::                    Data Gathering Functions                      :://
//:://////////////////////////////////////////////////////////////////:://

void GetAlthariaWandData(object oPC, object oDM)
{
  // This function gathers the same information as the personal data from the
  // Wand of Stats.  Includes Altharia information like rank, title, guild
  // Guardian, guardian rank, mithril and collector accounts.
} // End GetAlthariaWandData

void GetGameData(object oPC, object oDM)
{
  // This gets Game Data, like the player's CD key.  May decide to consolidate
  // this data with the HiddenData function.
  string sName = GetName(oPC);
  SendMessageToPC(oDM, "Information for "+ sName);
  string sMess = GetPCPlayerName(oPC);
  SendMessageToPC(oDM, "PC Player Name: "+ sMess);
  sMess = GetPCPublicCDKey(oPC);
  SendMessageToPC(oDM, "CD Key: "+ sMess);

} // End GetGameData

void GetHiddenData(object oPC, object oDM)
{
  // This function gathers data that isn't readily visible to the DM, painlessly.
  // Messages to DM the player's current gold count, XP, and the base value of
  // all six stats, without requiring the player to strip his gear.
  string sName = GetName(oPC);
  string sSTR = IntToString(GetAbilityScore(oPC,ABILITY_STRENGTH, TRUE));
  string sINT = IntToString(GetAbilityScore(oPC,ABILITY_INTELLIGENCE, TRUE));
  string sDEX = IntToString(GetAbilityScore(oPC,ABILITY_DEXTERITY, TRUE));
  string sWIS = IntToString(GetAbilityScore(oPC,ABILITY_WISDOM, TRUE));
  string sCON = IntToString(GetAbilityScore(oPC,ABILITY_CONSTITUTION, TRUE));
  string sCHA = IntToString(GetAbilityScore(oPC,ABILITY_CHARISMA, TRUE));

  SendMessageToPC(oDM, "Information for "+ sName);
  SendMessageToPC(oDM, "Base STR: "+ sSTR);
  SendMessageToPC(oDM, "Base DEX: "+ sDEX);
  SendMessageToPC(oDM, "Base CON: "+ sCON);
  SendMessageToPC(oDM, "Base INT: "+ sINT);
  SendMessageToPC(oDM, "Base WIS: "+ sWIS);
  SendMessageToPC(oDM, "Base CHA: "+ sCHA);

  sSTR = IntToString(GetXP(oPC));
  sCON = IntToString(GetGold(oPC));
  SendMessageToPC(oDM, "XP: "+ sSTR);
  SendMessageToPC(oDM, "Gold: "+ sCON);

} // End GetHiddenData

void GetEquippedTags(object oPC, object oDM)
{
  // This function works like the tagchecker in the RRL, provides tags of all
  // currently equipped items.
} // End GetEquippedTags

//:://////////////////////////////////////////////////////////////////:://
//::                   Action on Player Functions                     :://
//:://////////////////////////////////////////////////////////////////:://

void CalcStatCost(object oPC, object oDM, int nStat)
{
  // This function will send message list to the DM, telling him the cost
  // to increase the given stat to any value up to 40.  Thus, if the current
  // Stat was at 35, it would report the cost in gold, wishes, greater wishes
  // and ultimate wishes to raise the stat to 36, 37, 38, 39, and 40.  The
  // purpose of this function is to take the math out of the DM's hands, so
  // each potential new value has the total cost reported for it.
  // Abbreviations: GP, W, GW, UW will be reported in the string.  Gold costs
  // will always be in multiples of 1 million, so those will be xM, where x
  // is the millions of gold.  5 million gold would be GP-5M.
  // A common line might read: GP-10M, W-25, GW-5, UW-5 (to raise from 10 to 40).


} // End CalcStatCost

void TakeStatRaiseCost(object oPC, object oDM, int nStat, int nRaise)
{
  // This function will automatically calculate and take from the player the amount of gold,
  // wishes, GW's and UW's to raise a chosen stat from its current value to a new value.
  // To keep things simple, this function only raises by 10, but can be done multiple times.
  // This is used in conjunction with DM raise, and will not raise the stat.
  // Will tell the DM what was taken from the player.  Gold and wishes are destroyed.
  // Will return an error message if the player does not have sufficient resources.
  // Two-step function: calculate the cost and check for availability, and then do it or send error.


} // End TakeStatRaiseCost

void ChangePlayerGuild (object oPC, string sGuild)
{
  // This function will set the selected toon's guild to a new string value.
  // This will make the change regardless of availability, or eligibility.
  // If the guild has restrictions, there is no guarantee that the systems for the
  // guild will work for the toon, if they do not meet the eligibility requirements.


} // End ChangePlayerGuild

void ChangeGuardian (object oPC, string sGuardian, int nPower)
{
  // This function will set the selected toon's guardian to a new string value, and
  // will set their level of ability to the selected integer value.  This will
  // make the change regardless of availability, or eligibility.  The activation will
  // still check for eligibility, so this DM action will be wasted if the player is not
  // set up for the chosen guardian path.  It will not provide a mithrilized weapon.


} // End ChangePlayerGuild

void AdjustMithrilCount (object oPC, int nMithril, int nUpDown)
{
  // This function will adjust the selected toon's mithril count by a preset amount
  // up or down.  DM's must be careful to choose increase or decrease from their menu
  // to avoid screwing or inadvertantly benefitting players.


} // End AdjustMithrilCount

void AdjustCollectorCount (object oPC, int nMithril, int nUpDown)
{
  // This function will adjust the selected toon's collector count by a preset amount
  // up or down.  DM's must be careful to choose increase or decrease from their menu
  // to avoid screwing or inadvertantly benefitting players.


} // End AdjustCollectorCount

void GiveWishesEasy (object oPC, string sCreate, int nCount)
{
  // This function will create a number of wishes in the inventory of the selected toon.


} // End GiveWishesEasy

void BootDaMuthaFucka(object oPC)
{
  // Create a lightning strike, thunder, scorch mark, and random small
  // lightnings at target's location
  // Stolen from the DMFI Wand
  location lBootLoc = GetLocation(oPC);
  AssignCommand( oPC, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), lBootLoc));
  AssignCommand ( oPC, PlaySound ("as_wt_thundercl3"));
  object oScorch = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_weathmark", lBootLoc, FALSE);
  object oTargetArea = GetArea(oPC);
  int nXPos, nYPos, nCount;
  for(nCount = 0; nCount < 5; nCount++)
  {
    nXPos = Random(10) - 5;
    nYPos = Random(10) - 5;

    vector vNewVector = GetPositionFromLocation(lBootLoc);
    vNewVector.x += nXPos;
    vNewVector.y += nYPos;
    location lNewLoc = Location(oTargetArea, vNewVector, 0.0);
    AssignCommand( oPC, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S), lNewLoc));
  }
  DelayCommand ( 20.0, DestroyObject ( oScorch));

  // Kick the target out of the game
  BootPC(oPC);
} // End BootDaMuthaFucka

void PolyWannaMorph(object oPC, int nShape)
{
  // This function will polymorph the PC into a variety of shapes.  No longer are
  // DM's bound to the ubiquitous penguin form!  Long live variety!
  // Effect lasts for 2 minutes, then fades.

  effect ePenguin = EffectPolymorph(nShape);
  effect eParalyze = EffectParalyze();
  AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePenguin, oPC, 120.0));
  AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, oPC, 10.0));
} // End PolyWannaMorph





void main()
{ // Start Main
  object oDM = GetPCSpeaker();
  string sFunct = GetLocalString(oDM,"dm_funct_string");
  int nChoice = GetLocalInt(oDM,"dm_funct_int");
  location lSpawn = GetLocalLocation(oDM,"lSpawn");
  object oTarget = GetLocalObject(oDM,"PCTarget");

//:://////////////////////////////////////////////////////////////////:://
//::  Encounter selections.  Will appear at location of ring target,  :://
//::  or behind target if target is a PC.                             :://
//:://////////////////////////////////////////////////////////////////:://

      // Monster Veteran Choices - Level 10
  if (sFunct == "monster_veteran")
  {
    switch (nChoice)
    {
      case 1:{DoEncounterSpawn(lSpawn,"SkeletonRoadCrew");}break;
      case 2:{     }break;
      case 3:{     }break;
      case 4:{     }break;
      case 5:{     }break;
      case 6:{     }break;
      case 7:{     }break;
      case 8:{     }break;
      default:{SendMessageToPC(oDM,"Encounter Failed, invalid group selection.");}break;
    }
  }
      // Monster Champion Choices - Level 20
  if (sFunct == "monster_champion")
  {
    switch (nChoice)
    {
      case 1:{     }break;
      case 2:{     }break;
      case 3:{     }break;
      case 4:{     }break;
      case 5:{     }break;
      case 6:{     }break;
      case 7:{     }break;
      case 8:{     }break;
      default:{SendMessageToPC(oDM,"Encounter Failed, invalid group selection.");}break;
    }
  }
      // Monster Hero Choices - Level 30
  if (sFunct == "monster_hero")
  {
    switch (nChoice)
    {
      case 1:{     }break;
      case 2:{     }break;
      case 3:{     }break;
      case 4:{     }break;
      case 5:{     }break;
      case 6:{     }break;
      case 7:{     }break;
      case 8:{     }break;
      default:{SendMessageToPC(oDM,"Encounter Failed, invalid group selection.");}break;
    }
  }
      // Monster Paragon Choices - Level 40
  if (sFunct == "monster_paragon")
  {
    switch (nChoice)
    {
      case 1:{     }break;
      case 2:{     }break;
      case 3:{     }break;
      case 4:{     }break;
      case 5:{     }break;
      case 6:{     }break;
      case 7:{     }break;
      case 8:{     }break;
      default:{SendMessageToPC(oDM,"Encounter Failed, invalid group selection.");}break;
    }
  }
      // Monster Eidolon Choices - Level 70+
  if (sFunct == "monster_eidolon")
  {
    switch (nChoice)
    {
      case 1:{     }break;
      case 2:{     }break;
      case 3:{     }break;
      case 4:{     }break;
      case 5:{     }break;
      case 6:{     }break;
      case 7:{     }break;
      case 8:{     }break;
      default:{SendMessageToPC(oDM,"Encounter Failed, invalid group selection.");}break;
    }
  }

//:://////////////////////////////////////////////////////////////////:://
//::  Player function selections.  Must select a PC as a target for   :://
//::  these options to appear in the DM ring conversation.            :://
//:://////////////////////////////////////////////////////////////////:://

      // Player data section, no real actions take place in these.
  if (sFunct == "player_info")
  {
    switch (nChoice)
    {
      case 1:{GetAlthariaWandData(oTarget, oDM);}break;
      case 2:{GetGameData(oTarget, oDM);}break;  // CD Key etc.,
      case 3:{GetHiddenData(oTarget, oDM);}break; // XP, gold, six base stats
      case 4:{GetEquippedTags(oTarget, oDM);}break; // Tags of equipped items
      default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Player Stat Calc section. Int is the stat.
  if (sFunct == "stat_calc_cost")
  {
    switch (nChoice)
    {
      case 1:{ CalcStatCost(oTarget, oDM, ABILITY_CHARISMA);}break;
      case 2:{ CalcStatCost(oTarget, oDM, ABILITY_CONSTITUTION);}break;
      case 3:{ CalcStatCost(oTarget, oDM, ABILITY_DEXTERITY);}break;
      case 4:{ CalcStatCost(oTarget, oDM, ABILITY_INTELLIGENCE);}break;
      case 5:{ CalcStatCost(oTarget, oDM, ABILITY_STRENGTH);}break;
      case 6:{ CalcStatCost(oTarget, oDM, ABILITY_WISDOM);}break;
      default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Player Take Stat Cost section. Int is the stat. Second Int is stat increase amount.
  if (sFunct == "take_stat_cost")
  {
    int nIncrease = GetLocalInt(oDM,"stat_raise");
    switch (nChoice)
    {
      case 1:{ TakeStatRaiseCost (oTarget, oDM, ABILITY_CHARISMA, nIncrease);}break;
      case 2:{ TakeStatRaiseCost (oTarget, oDM, ABILITY_CONSTITUTION, nIncrease);}break;
      case 3:{ TakeStatRaiseCost (oTarget, oDM, ABILITY_DEXTERITY, nIncrease);}break;
      case 4:{ TakeStatRaiseCost (oTarget, oDM, ABILITY_INTELLIGENCE, nIncrease);}break;
      case 5:{ TakeStatRaiseCost (oTarget, oDM, ABILITY_STRENGTH, nIncrease);}break;
      case 6:{ TakeStatRaiseCost (oTarget, oDM, ABILITY_WISDOM, nIncrease);}break;
      default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Player Change Guild Function.  Int is the guild, used to convert to string.
  if (sFunct == "guild_change")
  {
    switch (nChoice)
    {
      case 1:{ ChangePlayerGuild (oTarget, "t12d");}break;
      case 2:{ ChangePlayerGuild (oTarget, "toaa");}break;
      case 3:{ ChangePlayerGuild (oTarget, "ulme");}break;
      case 4:{ ChangePlayerGuild (oTarget, "merc");}break;
      case 5:{ ChangePlayerGuild (oTarget, "shad");}break;
      case 6:{ ChangePlayerGuild (oTarget, "drag");}break;
      case 7:{ ChangePlayerGuild (oTarget, "dash");}break;
      case 8:{ ChangePlayerGuild (oTarget, "just");}break;
      case 9:{ ChangePlayerGuild (oTarget, "coto");}break;
     default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Player Change Guardian Function. Int is the new guardian path. Second Int is new guardian level.
  if (sFunct == "guardian_change")
  {
    int nLevel = GetLocalInt(oDM,"stat_raise");
    switch (nChoice)
    {
      case 1:{ ChangeGuardian (oTarget, "fulminate", nLevel);}break;
      case 2:{ ChangeGuardian (oTarget, "innerpath", nLevel);}break;
      case 3:{ ChangeGuardian (oTarget, "vesperbel", nLevel);}break;
      case 4:{ ChangeGuardian (oTarget, "whitegold", nLevel);}break;
      case 5:{ ChangeGuardian (oTarget, "stilletto", nLevel);}break;
      case 6:{ ChangeGuardian (oTarget, "magestaff", nLevel);}break;
      case 7:{ ChangeGuardian (oTarget, "harmonics", nLevel);}break;
      case 8:{ ChangeGuardian (oTarget, "archerbow", nLevel);}break;
      case 9:{ ChangeGuardian (oTarget, "berserker", nLevel);}break;
      default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Player Change Mithril Function. Int is the pre-set increment. Second Int is increase or decrease.
  if (sFunct == "mithril_change")
  {
    int nLevel = GetLocalInt(oDM,"stat_raise");
    switch (nChoice)
    {
      case 1:{ AdjustMithrilCount (oTarget, 25, nLevel);}break;
      case 2:{ AdjustMithrilCount (oTarget, 50, nLevel);}break;
      case 3:{ AdjustMithrilCount (oTarget, 100, nLevel);}break;
      case 4:{ AdjustMithrilCount (oTarget, 300, nLevel);}break;
      case 5:{ AdjustMithrilCount (oTarget, 500, nLevel);}break;
      case 6:{ AdjustMithrilCount (oTarget, 1000, nLevel);}break;
      case 7:{ AdjustMithrilCount (oTarget, 2000, nLevel);}break;
      case 8:{ AdjustMithrilCount (oTarget, 5000, nLevel);}break;
      default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Player Change Collector Function. Int is the pre-set increment. Second Int is increase or decrease.
  if (sFunct == "collector_change")
  {
    int nLevel = GetLocalInt(oDM,"stat_raise");
    switch (nChoice)
    {
      case 1:{ AdjustCollectorCount (oTarget, 25, nLevel);}break;
      case 2:{ AdjustCollectorCount (oTarget, 50, nLevel);}break;
      case 3:{ AdjustCollectorCount (oTarget, 100, nLevel);}break;
      case 4:{ AdjustCollectorCount (oTarget, 300, nLevel);}break;
      case 5:{ AdjustCollectorCount (oTarget, 500, nLevel);}break;
      case 6:{ AdjustCollectorCount (oTarget, 1000, nLevel);}break;
      case 7:{ AdjustCollectorCount (oTarget, 2000, nLevel);}break;
      case 8:{ AdjustCollectorCount (oTarget, 5000, nLevel);}break;
      default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Player Give Wishes Function. Int is the Type of wish. Second Int is number of wishes to give.
  if (sFunct == "wish_giver")
  {
    int nLevel = GetLocalInt(oDM,"stat_raise");
    switch (nChoice)
    {
      case 1:{ GiveWishesEasy (oTarget, "wish", nLevel);}break;
      case 2:{ GiveWishesEasy (oTarget, "wish001", nLevel);}break;
      case 3:{ GiveWishesEasy (oTarget, "ultimatewish", nLevel);}break;
      default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Player Give Jehonian Blessings Function. Int is the Tier of Jehonian blessing to give.
  if (sFunct == "jehon_blessing")
  {
    //GiveJehonBlessing (oTarget, nChoice);
  }

      // Player Polymorph Function. Int is the appearance choice.
  if (sFunct == "polymorph_player")
  {
    switch (nChoice)
    {
      case 1:{ PolyWannaMorph (oTarget, POLYMORPH_TYPE_BADGER);}break;
      case 2:{ PolyWannaMorph (oTarget, POLYMORPH_TYPE_CHICKEN);}break;
      case 3:{ PolyWannaMorph (oTarget, POLYMORPH_TYPE_COW);}break;
      case 4:{ PolyWannaMorph (oTarget, POLYMORPH_TYPE_PIXIE);}break;
      case 5:{ PolyWannaMorph (oTarget, POLYMORPH_TYPE_PENGUIN);}break;
      default:{SendMessageToPC(oDM,"Action Failed, invalid selection.");}break;
    }
  }

      // Boot Player Function. Should work just like current version. See current script.
  if (sFunct == "boot_player")
  {
    BootDaMuthaFucka (oTarget);
  }

      // DM Relevel Toon Function. Should work just like current version. See current script.
  if (sFunct == "relevel_toon")
  {
    int TargetsXP = GetXP(oTarget);
    SetXP(oTarget, 0);
    SetXP(oTarget, TargetsXP);
    SetCampaignInt("leveler","classcount",1,oTarget);
    effect FX = EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, FX, oTarget);
  }

      // DM Reload Mod Function. Should work just like current version. See current script.
  if (sFunct == "module_reload")
  {
    string sMod = GetModuleName();
    StartNewModule(sMod);
  }



} // End Main
