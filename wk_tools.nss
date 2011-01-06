/////:://///////////////////////////////////////////////////////////////////////
/////:: Library functions for Altharia - written by Winterknight
/////:: Modified with improvements by Eowien 2/23/07
/////:: GetEffectiveLevel, GetEffectiveCasterLevel, Guardian data functions,
/////:: Various additional functions for Wand of Stats
/////:://///////////////////////////////////////////////////////////////////////
#include "prc_inc_spells"
#include "psi_inc_core"
#include "prc_class_const"

int GetEffectiveLevel (object oChar)
{
  int nXP = GetXP(oChar);
  int nECL;
  if (nXP < 820000)
      nECL = GetHitDice(oChar);
  else if (nXP >= 820000 && nXP < 4950000 )
      nECL = FloatToInt(0.5+sqrt(10.0)*sqrt(IntToFloat(250+2*nXP))/100);
  else if (nXP >= 4950000)
      nECL = 100;
  /*SendMessageToPC(oChar, "XP = "+IntToString(nXP)+" nECL = "+IntToString(nECL));*/
  return nECL;
}

string GetServerRank (object oPC)
{
  int nLevel = GetEffectiveLevel(oPC);
  string sRank;
  if (nLevel < 10) sRank = "Adventurer";
  if (nLevel > 9 & nLevel < 20) sRank = "Veteran";
  if (nLevel > 19 & nLevel < 30) sRank = "Champion";
  if (nLevel > 29 & nLevel < 40) sRank = "Hero";
  if (nLevel > 39 & nLevel < 50) sRank = "Paragon";
  if (nLevel > 49 & nLevel < 60) sRank = "Icon";
  if (nLevel > 59 & nLevel < 70) sRank = "Guardian";
  if (nLevel > 69 & nLevel < 80) sRank = "Eidolon";
  if (nLevel > 79 & nLevel < 90) sRank = "Lord";
  if (nLevel > 89 & nLevel < 100) sRank = "Legend";
  if (nLevel > 99) sRank = "Saint";
  return sRank;
}

int GetMithrilCount (object oPC)
{
  int nCount = GetCampaignInt("12Dark2","mithril",oPC);
  return nCount;
}

string GetCurrentGuildName (object oPC)
{
  string sGuild = GetCampaignString("Character","guild",oPC);
  string sPrint;
  if (sGuild == "toaa") sPrint = "Tower of Arcane Arts.";
  if (sGuild == "t12d") sPrint = "Temple of 12 Disciplines.";
  if (sGuild == "dash") sPrint = "Dashana Institute.";
  if (sGuild == "shad") sPrint = "Shadow Guild.";
  if (sGuild == "just") sPrint = "Brotherhood of Justiciars.";
  if (sGuild == "coto") sPrint = "Church of the One God.";
  if (sGuild == "ulme") sPrint = "Ulme Umarmem.";
  if (sGuild == "merc") sPrint = "Mercenary Guild.";
  if (sGuild == "drag") sPrint = "Dragon Cult.";
  return sPrint;
}

int GetSneaky (object oPC)
{
  //int nAss = GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC);
  //int nBlack = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);
  //int nRogue = GetLevelByClass(CLASS_TYPE_ROGUE, oPC);
  int nSneakyButNoSA= GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC);
  int nSA = GetTotalSneakAttackDice(oPC);
  
  // require 8d6 sneak attack, or equivalent other sneaky class levels
  // compare against 21
  return (1 + FloatToInt(nSA * 2.5) + nSneakyButNoSA);
	//int nTotal = nAss + nBlack + nRogue + nShadow;
  //return nTotal;
}
int GetBardRelatedLevels (object oPC)
{
	return 	 GetLevelByClass(CLASS_TYPE_BARD, oPC)
			+GetLevelByClass(CLASS_TYPE_DIRGESINGER, oPC)
			+GetLevelByClass(CLASS_TYPE_HARPER, oPC)
			+GetLevelByClass(CLASS_TYPE_MINSTREL_EDGE, oPC)
			+GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD, oPC)
			+GetLevelByClass(CLASS_TYPE_VIRTUOSO, oPC);
}
int GetIsEligible (object oPC, string sUpgrade)
{
  int nArch = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPC);
  int nAss = GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC);
  int nBarb = GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC);
  int nBard = GetLevelByClass(CLASS_TYPE_BARD, oPC);
  int nBlack = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);
  int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oPC);
  int nCoT = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC);
  int nRDD = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, oPC);
  int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
  int nDwarf = GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER, oPC);
  int nFighter = GetLevelByClass(CLASS_TYPE_FIGHTER, oPC);
  int nHarp = GetLevelByClass(CLASS_TYPE_HARPER, oPC);
  int nMonk = GetLevelByClass(CLASS_TYPE_MONK, oPC);
  int nPally = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
  int nPaleM = GetLevelByClass(CLASS_TYPE_PALEMASTER, oPC);
  int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oPC);
  int nRogue = GetLevelByClass(CLASS_TYPE_ROGUE, oPC);
  int nShadow = GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC);
  int nShift = GetLevelByClass(CLASS_TYPE_SHIFTER, oPC);
  int nSorc = GetLevelByClass(CLASS_TYPE_SORCERER, oPC);
  int nWeaps = GetLevelByClass(CLASS_TYPE_WEAPON_MASTER, oPC);
  int nWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oPC);

  int bEligible = FALSE;
  int nLevel;

  if (sUpgrade == "psicrystal")
  {
	int class = GetPrimaryPsionicClass(oPC);
	if (class == CLASS_TYPE_INVALID)
		nLevel=0;
	else
	{
		nLevel = GetLevelByClass(class, oPC);
		nLevel += GetPsionicPRCLevels(oPC);
		nLevel += GetLocalInt(oPC, PRC_CASTERLEVEL_ADJUSTMENT); // is this variable even used for non-debug characters?
		nLevel += PracticedManifesting(oPC, class, nLevel); // must be calculated from final manifesting level
		
	}
  }  
  //if (sUpgrade == "magestaff") nLevel = nSorc + nWizard + nPaleM;
  if (sUpgrade == "magestaff") nLevel = GetPrCAdjustedCasterLevelByType(TYPE_ARCANE, oPC);	
  //if (sUpgrade == "vesperbel") nLevel = nCleric + nPally + nCoT;
  if (sUpgrade == "vesperbel" 
   || sUpgrade == "holysword"
   || sUpgrade == "whitegold") nLevel = GetPrCAdjustedCasterLevelByType(TYPE_DIVINE, oPC);
  //if (sUpgrade == "holysword") nLevel = nCleric + nPally + nCoT;
  //if (sUpgrade == "whitegold") nLevel = nDruid + nRanger + nShift;
  //if (sUpgrade == "harmonics") nLevel = nBard + nRDD + nHarp;
  if (sUpgrade == "harmonics")
	nLevel = GetBardRelatedLevels(oPC);
  //if (sUpgrade == "fulminate") nLevel = nFighter + nBarb + nBlack + nCoT + nDwarf + nMonk + nPally + nRanger + nWeaps;
  if (sUpgrade == "fulminate") nLevel = GetEffectiveLevel(oPC);
  //if (sUpgrade == "stilletto") nLevel = nRogue + nAss + nShadow + nWeaps + nBlack + nRanger;
  if (sUpgrade == "stilletto") nLevel = GetSneaky(oPC);
  // must have at least one level of monk.  what other unarmed specialist classes should qualify?
  if (sUpgrade == "innerpath") 
	nLevel = nMonk? GetEffectiveLevel(oPC):0;
  //if (sUpgrade == "archerbow") nLevel = nFighter + nBarb + nBlack + nCoT + nDwarf + nMonk + nPally + nRanger + nWeaps + nCleric + nBard + nDruid + nSorc + nWizard + nPaleM + nRogue + nAss + nShadow + nRDD + nHarp + nArch + nShift;
  if (sUpgrade == "archerbow") nLevel = GetEffectiveLevel(oPC);

  if (nLevel >= 21) bEligible = TRUE;
  if (sUpgrade == "holysword" && nPally < 5) bEligible = FALSE;
  if (sUpgrade == "whitegold" && nDruid < 1 && nRanger <1) bEligible = FALSE;


  return bEligible;
}
#include "inc_2dacache"

// Creates a score based on bab of classes, even into epic.
// No difference between 20fi/20wi and 20wi/20fi
int GetAttackProgressionScore(object oPC)
{
	int score =0;
	int i=1;
	for (i=1;i<=3;i++)
	{
		int class = GetClassByPosition(i, oPC);
		if (class == CLASS_TYPE_INVALID) break;
		string progression = Get2DACache("classes", "AttackBonusTable", class);
		int level = GetLevelByPosition(i, oPC);
		if (progression == "CLS_ATK_1")
			score = score + level;
		else if (progression == "CLS_ATK_2")
			score = score + level - 1 - (level-1)/4;
		else if (progression == "CLS_ATK_3")
			score = score + level/2;
		//else if (progression == "CLS_ATK_4") // do nothing, 0 progression
	}
	SendMessageToPC(oPC, "Your attack progression score is: "+IntToString(score)+".");
	return score;
}
int GetHolySwordLevel(object oPC)
{
	return GetPrCAdjustedCasterLevelByType(TYPE_DIVINE, oPC);
}

int GetStrikeLevel (object oPC, string sUpgrade)
{
  int nAss = GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC);
  int nBarb = GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC);
  int nBlack = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);
  int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oPC);
  int nCoT = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC);
  int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
  int nDwarf = GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER, oPC);
  int nFighter = GetLevelByClass(CLASS_TYPE_FIGHTER, oPC);
  int nMonk = GetLevelByClass(CLASS_TYPE_MONK, oPC);
  int nPally = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
  int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oPC);
  int nRogue = GetLevelByClass(CLASS_TYPE_ROGUE, oPC);
  int nShadow = GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC);
  int nShift = GetLevelByClass(CLASS_TYPE_SHIFTER, oPC);
  int nWeaps = GetLevelByClass(CLASS_TYPE_WEAPON_MASTER, oPC);

  int nLevel = GetHitDice(oPC);

  if (sUpgrade == "holysword") nLevel = nCleric + nPally + nCoT;
  //if (sUpgrade == "fulminate") nLevel = nFighter + nBarb + nBlack + nCoT + nDwarf + nMonk + nPally + nRanger + nWeaps;
  if (sUpgrade == "fulminate") nLevel = GetAttackProgressionScore(oPC);
  //if (sUpgrade == "stilletto") nLevel = nRogue + nAss + nShadow + nWeaps + nBlack + nRanger;
  if (sUpgrade == "stilletto") nLevel = GetSneaky(oPC);
  if (sUpgrade == "innerpath") nLevel = nMonk;
  if (sUpgrade == "whitegold") nLevel = nRanger + nDruid + nShift;

  return nLevel;
}

string GetClassName (int nClass)
{
  string sName;
  if (nClass == CLASS_TYPE_SORCERER) sName = "Sorcerer";
  if (nClass == CLASS_TYPE_FIGHTER) sName = "Fighter";
  if (nClass == CLASS_TYPE_ROGUE) sName = "Rogue";
  if (nClass == CLASS_TYPE_WIZARD) sName = "Wizard";
  if (nClass == CLASS_TYPE_DRUID) sName = "Druid";
  if (nClass == CLASS_TYPE_CLERIC) sName = "Cleric";
  if (nClass == CLASS_TYPE_RANGER) sName = "Ranger";
  if (nClass == CLASS_TYPE_PALADIN) sName = "Paladin";
  if (nClass == CLASS_TYPE_BARD) sName = "Bard";
  if (nClass == CLASS_TYPE_BARBARIAN) sName = "Barbarian";
  if (nClass == CLASS_TYPE_WEAPON_MASTER) sName = "Weapon Master";
  if (nClass == CLASS_TYPE_DWARVENDEFENDER) sName = "Dwarven Defender";
  if (nClass == CLASS_TYPE_DRAGONDISCIPLE) sName = "Dragon Disciple";
  if (nClass == CLASS_TYPE_ARCANE_ARCHER) sName = "Arcane Archer";
  if (nClass == CLASS_TYPE_PALE_MASTER) sName = "Pale Master";
  if (nClass == CLASS_TYPE_HARPER) sName = "Harper Scout";
  if (nClass == CLASS_TYPE_SHADOWDANCER) sName = "Shadow Dancer";
  if (nClass == CLASS_TYPE_ASSASSIN) sName = "Assassin";
  if (nClass == CLASS_TYPE_SHIFTER) sName = "Shifter";
  if (nClass == CLASS_TYPE_DIVINECHAMPION) sName = "Divine Champion";
  if (nClass == CLASS_TYPE_BLACKGUARD) sName = "Blackguard";
  if (nClass == CLASS_TYPE_MONK) sName = "Monk";
  return sName;
}

int GetEffectiveCasterLevel (object oCaster)
{
  int nCasterLevel = GetCasterLevel(oCaster);
  int nXP = GetXP(oCaster);
  int nRatio = nCasterLevel;
  if (nXP >= 820000)
    {
      int nHD = GetEffectiveLevel(oCaster);
      nRatio = nCasterLevel * nHD / 40;
    }
  return nRatio;
}

int GetEffectiveClassLevel (object oPC, int nClass)
{
  int nClassLevel = GetLevelByClass(nClass, oPC);
  int nXP = GetXP(oPC);
  int nRatio = nClassLevel;
  if (nXP >= 820000)
    {
      int nHD = GetEffectiveLevel(oPC);
      nRatio = nClassLevel * nHD / 40;
    }
  return nRatio;
}

int GetMageStaff (object oMage)
{
  int nStaff = GetLocalInt(oMage,"magestaff");
  if (nStaff > 4) nStaff = 4;
  return nStaff;
}

int GetSigil (object oWarrior)
{
  int nSigil = GetLocalInt(oWarrior,"fulminate");
  return nSigil;
}

int GetArchery (object oArcher)
{
  int nArch = GetLocalInt(oArcher,"archerbow");
  return nArch;
}

int GetInnerPath (object oMonk)
{
  int nMonk = GetLocalInt(oMonk,"innerpath");
  return nMonk;
}

int GetVesper (object oPriest)
{
  int nVesper = GetLocalInt(oPriest,"vesperbel");
  int nSword = GetLocalInt(oPriest,"holysword");
  if (nSword > nVesper) nVesper = nSword;
  if (nVesper > 4) nVesper = 4;
  return nVesper;
}

int GetTechnique (object oRogue)
{
  int nTech = GetLocalInt(oRogue,"stilletto");
  return nTech;
}

int GetWhiteGold (object oDruid)
{
  int nWhite = GetLocalInt(oDruid,"whitegold");
  if (nWhite > 4) nWhite = 4;
  return nWhite;
}

int GetHarmonic (object oBard)
{
  int nHarmonic = GetLocalInt(oBard,"harmonics");
  if (nHarmonic > 4) nHarmonic = 4;
  return nHarmonic;
}


//copied from nw_i0_spells.nss to remove depency, for compiling with prc
void RemoveEffectsFromSpell(object oTarget, int SpellID)
{
  effect eLook = GetFirstEffect(oTarget);
  while (GetIsEffectValid(eLook)) {
    if (GetEffectSpellId(eLook) == SpellID)
      RemoveEffect(oTarget, eLook);
    eLook = GetNextEffect(oTarget);
  }
}
// This is for compiling testing if the function changes.
// void main(){}
