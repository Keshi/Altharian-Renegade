

/* Steps for adding a new spellbook

Prepared:
Make cls_spgn_*.2da
Make cls_spcr_*.2da
Add cls_spgn_*.2da to classes.2da
Add class entry in prc_casters.2da
Add the spellbook feat (#1999) to cls_feat_*.2da at the appropriate level
Add class to GetSpellbookTypeForClass() below
Add class to GetAbilityScoreForClass() below
Add class to bKnowsAllClassSpells() below if necessary
Add class to GetIsArcaneClass() or GetIsDivineClass() in prc_inc_castlvl as appropriate
Add class to GetCasterLevelModifier() in prc_inc_spells if necessary
Add class to MakeLookupLoopMaster() in inc_lookups
Run the assemble_spellbooks.bat file
Make the prc_* scripts in newspellbook. The filenames can be found under the spell entries for the class in spells.2da.

Spont:
Make cls_spgn_*.2da
Make cls_spkn_*.2da
Make cls_spcr_*.2da
Add cls_spkn_*.2da and cls_spgn_*.2da to classes.2da
Add class entry in prc_casters.2da
Add class to GetSpellbookTypeForClass() below
Add class to GetAbilityScoreForClass() below
Add class to bKnowsAllClassSpells() below if necessary
Add class to GetIsArcaneClass() or GetIsDivineClass() in prc_inc_castlvl as appropriate
Add class to GetCasterLevelModifier() in prc_inc_spells if necessary
Add class to MakeLookupLoopMaster() in inc_lookups
Add class to prc_amagsys_gain if(CheckMissingSpells(oPC, CLASS_TYPE_SORCERER, MinimumSpellLevel, MaximumSpellLevel))
Add class to ExecuteScript("prc_amagsys_gain", oPC) list in EvalPRCFeats in prc_inc_function
Run the assemble_spellbooks.bat file
Make the prc_* scripts in newspellbook

*/

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

int GetSpellbookTypeForClass(int nClass);
int GetAbilityScoreForClass(int nClass, object oPC);

/**
 * Determines the given character's DC-modifying ability modifier for
 * the given class' spells. Handles split-score casters.
 *
 * @param nClass The spellcasting class for whose spells to determine ability mod to DC for
 * @param oPC    The character whose abilities to examine
 * @return       The DC-modifying ability score's ability modifier value
 */
int GetDCAbilityModForClass(int nClass, object oPC);

string GetFileForClass(int nClass);
int GetSpellslotLevel(int nClass, object oPC);
int GetItemBonusSlotCount(object oPC, int nClass, int nSpellLevel);
int GetSlotCount(int nLevel, int nSpellLevel, int nAbilityScore, int nClass, object oItemPosessor = OBJECT_INVALID);
int bKnowsAllClassSpells(int nClass);
int GetSpellKnownMaxCount(int nLevel, int nSpellLevel, int nClass, object oPC);
int GetSpellKnownCurrentCount(object oPC, int nSpellLevel, int nClass);
int GetSpellUnknownCurrentCount(object oPC, int nSpellLevel, int nClass);
void AddSpellUse(object oPC, int nSpellbookID, int nClass, string sFile, string sArrayName, int nSpellbookType, object oSkin, int nFeatID, int nIPFeatID);
void RemoveSpellUse(object oPC, int nSpellID, int nClass);
// int GetSpellUses(object oPC, int nSpellID, int nClass);
int GetSpellLevel(int nSpellID, int nClass);
void SetupSpells(object oPC, int nClass);
void CheckAndRemoveFeat(object oHide, itemproperty ipFeat);
void WipeSpellbookHideFeats(object oPC);
void CheckNewSpellbooks(object oPC);
void NewSpellbookSpell(int nClass, int nMetamagic, int nSpellID);

//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

/* 	stored in "prc_inc_sb_const"
	Accessed via "prc_inc_core"	*/

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

// ** THIS ORDER IS IMPORTANT **

//#include "prc_effect_inc"			//access via prc_inc_core
//#include "inc_lookups"			//access via prc_inc_core
#include "prc_inc_core"			
#include "inc_sp_gain_mem"			//providing child access to prc_inc_core
									//Must load in this order.
								
//#include "prc_inc_castlvl"		//access via prc_inc_core
//#include "prc_inc_descrptr"		//access via prc_inc_core


//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

int GetSpellbookTypeForClass(int nClass)
{
    switch(nClass)
    {
        case CLASS_TYPE_BLACKGUARD:
        case CLASS_TYPE_VASSAL:
        case CLASS_TYPE_SOLDIER_OF_LIGHT:
        case CLASS_TYPE_KNIGHT_MIDDLECIRCLE:
        case CLASS_TYPE_KNIGHT_CHALICE:
        case CLASS_TYPE_VIGILANT:
        case CLASS_TYPE_CLERIC:
        case CLASS_TYPE_DRUID:
        case CLASS_TYPE_RANGER:
        case CLASS_TYPE_PALADIN:
        case CLASS_TYPE_ANTI_PALADIN:
        case CLASS_TYPE_OCULAR:
        case CLASS_TYPE_WIZARD:
        case CLASS_TYPE_SHADOWLORD:
        case CLASS_TYPE_ASSASSIN:
        case CLASS_TYPE_SOHEI:
        case CLASS_TYPE_SLAYER_OF_DOMIEL:
        case CLASS_TYPE_HEALER:
        case CLASS_TYPE_SHAMAN:
        case CLASS_TYPE_ARCHIVIST:
            return SPELLBOOK_TYPE_PREPARED;
        case CLASS_TYPE_SORCERER:
        case CLASS_TYPE_BARD:
        case CLASS_TYPE_SUEL_ARCHANAMACH:
        case CLASS_TYPE_FAVOURED_SOUL:
        case CLASS_TYPE_MYSTIC:
        case CLASS_TYPE_HEXBLADE:
        case CLASS_TYPE_DUSKBLADE:
        case CLASS_TYPE_WARMAGE:
        case CLASS_TYPE_DREAD_NECROMANCER:
        case CLASS_TYPE_JUSTICEWW:
        case CLASS_TYPE_WITCH:
        case CLASS_TYPE_SUBLIME_CHORD:
        case CLASS_TYPE_BEGUILER:
        case CLASS_TYPE_HARPER:
        case CLASS_TYPE_TEMPLAR:
            return SPELLBOOK_TYPE_SPONTANEOUS;
        //outsider HD count as sorc for raks
        case CLASS_TYPE_OUTSIDER: {
            /// @todo Will eventually need to add a check here to differentiate between races. Not all are sorcerers, just most
            return SPELLBOOK_TYPE_SPONTANEOUS;
        }
    }
    return SPELLBOOK_TYPE_INVALID;
}

int GetAbilityScoreForClass(int nClass, object oPC)
{
    switch(nClass)
    {
        case CLASS_TYPE_BLACKGUARD:
        case CLASS_TYPE_VASSAL:
        case CLASS_TYPE_SOLDIER_OF_LIGHT:
        case CLASS_TYPE_KNIGHT_MIDDLECIRCLE:
        case CLASS_TYPE_KNIGHT_CHALICE:
        case CLASS_TYPE_VIGILANT:
        case CLASS_TYPE_CLERIC:
        case CLASS_TYPE_DRUID:
        case CLASS_TYPE_RANGER:
        case CLASS_TYPE_PALADIN:
        case CLASS_TYPE_PSYWAR:
        case CLASS_TYPE_ANTI_PALADIN:
        case CLASS_TYPE_OCULAR:
        case CLASS_TYPE_FIST_OF_ZUOKEN:
        case CLASS_TYPE_WARMIND:
        case CLASS_TYPE_SOHEI:
        case CLASS_TYPE_SLAYER_OF_DOMIEL:
        case CLASS_TYPE_HEALER:
        case CLASS_TYPE_SHAMAN:
        case CLASS_TYPE_MYSTIC:
        case CLASS_TYPE_JUSTICEWW:
        case CLASS_TYPE_WITCH:
            return GetAbilityScore(oPC, ABILITY_WISDOM);
        case CLASS_TYPE_WIZARD:
        case CLASS_TYPE_PSION:
        case CLASS_TYPE_ASSASSIN:
        case CLASS_TYPE_SHADOWLORD:
        case CLASS_TYPE_DUSKBLADE:
        case CLASS_TYPE_ARCHIVIST:
        case CLASS_TYPE_BEGUILER:
            return GetAbilityScore(oPC, ABILITY_INTELLIGENCE);
        case CLASS_TYPE_SORCERER:
        case CLASS_TYPE_BARD:
        case CLASS_TYPE_WILDER:
        case CLASS_TYPE_SUEL_ARCHANAMACH:
        case CLASS_TYPE_FAVOURED_SOUL:
        case CLASS_TYPE_HEXBLADE:
        case CLASS_TYPE_DREAD_NECROMANCER:
        case CLASS_TYPE_WARMAGE:
        case CLASS_TYPE_SUBLIME_CHORD:
        case CLASS_TYPE_HARPER:
        case CLASS_TYPE_TEMPLAR:
            return GetAbilityScore(oPC, ABILITY_CHARISMA);
        //outsider HD count as sorc for raks
        case CLASS_TYPE_OUTSIDER: {
            /// @todo Will eventually need to add a check here to differentiate between races. Not all are sorcerers, just most
            return GetAbilityScore(oPC, ABILITY_CHARISMA);
        }
    }
    return GetAbilityScore(oPC, ABILITY_CHARISMA);    //default for SLAs?
}

int GetDCAbilityModForClass(int nClass, object oPC)
{
    switch(nClass)
    {
        // Split ability casters
        case CLASS_TYPE_FAVOURED_SOUL:
            return GetAbilityModifier(ABILITY_WISDOM, oPC);
        case CLASS_TYPE_HEALER:
            return GetAbilityModifier(ABILITY_CHARISMA, oPC);

        // Everyone else
        default:
            return (GetAbilityScoreForClass(nClass, oPC) - 10) / 2;
    }

    return 0;
}

string GetFileForClass(int nClass)
{
    string sFile = Get2DACache("classes", "FeatsTable", nClass);
    sFile = "cls_spell" + GetStringRight(sFile, GetStringLength(sFile) - 8); // Hardcoded the cls_ part. It's not as if any class uses some other prefix - Ornedan, 20061231
    //if(DEBUG) DoDebug("GetFileForClass(" + IntToString(nClass) + ") = " + sFile);
    return sFile;
}

int GetSpellslotLevel(int nClass, object oPC)
{
    //int nLevel = GetCasterLvl(nClass, oPC);
    //if(DEBUG) DoDebug("GetSpellslotLevel(" + IntToString(nClass) + ", " + GetName(oPC) + ") = " + IntToString(nLevel));
    int nLevel = GetLevelByClass(nClass, oPC);
    int nArcSpellslotLevel;
    int nDivSpellslotLevel;
    int i;
    for(i = 1; i <= 3; i++)
    {
        int nTempClass = GetClassByPosition(i, oPC);
        //spellcasting prc
        int nArcSpellMod = StringToInt(Get2DACache("classes", "ArcSpellLvlMod", nTempClass));
        int nDivSpellMod = StringToInt(Get2DACache("classes", "DivSpellLvlMod", nTempClass));
        if(nArcSpellMod == 1)
            nArcSpellslotLevel += GetLevelByClass(nTempClass, oPC);
        else if(nArcSpellMod > 1)
            nArcSpellslotLevel += (GetLevelByClass(nTempClass, oPC) + 1) / nArcSpellMod;
        if(nDivSpellMod == 1)
            nDivSpellslotLevel += GetLevelByClass(nTempClass, oPC);
        else if(nDivSpellMod > 1)
            nDivSpellslotLevel += (GetLevelByClass(nTempClass, oPC) + 1) / nDivSpellMod;
    }
    if(GetPrimaryArcaneClass(oPC) == nClass)
        nLevel += nArcSpellslotLevel;
    if(GetPrimaryDivineClass(oPC) == nClass)
        nLevel += nDivSpellslotLevel;
    if(DEBUG) DoDebug("GetSpellslotLevel(" + IntToString(nClass) + ", " + GetName(oPC) + ") = " + IntToString(nLevel));
    return nLevel;
}


int GetItemBonusSlotCount(object oPC, int nClass, int nSpellLevel)
{
    // Value maintained by CheckPRCLimitations()
    return GetLocalInt(oPC, "PRC_IPRPBonSpellSlots_" + IntToString(nClass) + "_" + IntToString(nSpellLevel));
}

int GetSlotCount(int nLevel, int nSpellLevel, int nAbilityScore, int nClass, object oItemPosessor = OBJECT_INVALID)
{
    // Ability score limit rule: Must have casting ability score of at least 10 + spel level to be able to cast spells of that level at all
    if(nAbilityScore < nSpellLevel + 10)
        return 0;
    int nSlots;
    string sFile;
    /*// Bioware casters use their classes.2da-specified tables
    if(    nClass == CLASS_TYPE_WIZARD
        || nClass == CLASS_TYPE_SORCERER
        || nClass == CLASS_TYPE_BARD
        || nClass == CLASS_TYPE_CLERIC
        || nClass == CLASS_TYPE_DRUID
        || nClass == CLASS_TYPE_PALADIN
        || nClass == CLASS_TYPE_RANGER)
    {*/
        sFile = Get2DACache("classes", "SpellGainTable", nClass);
    /*}
    // New spellbook casters use the cls_spbk_* tables
    else
    {
        sFile = Get2DACache("classes", "FeatsTable", nClass);
        sFile = "cls_spbk" + GetStringRight(sFile, GetStringLength(sFile) - 8); // Hardcoded the cls_ part. It's not as if any class uses some other prefix - Ornedan, 20061231
    }*/

    string sSlots = Get2DACache(sFile, "SpellLevel" + IntToString(nSpellLevel), nLevel - 1);
    if(sSlots == "")
    {
        nSlots = -1;
        //if(DEBUG) DoDebug("GetSlotCount: Problem getting slot numbers for " + IntToString(nSpellLevel) + " " + IntToString(nLevel) + " " + sFile);
    }
    else
        nSlots = StringToInt(sSlots);
    if(nSlots == -1)
        return 0;

    // Add spell slots from items
    if(GetIsObjectValid(oItemPosessor))
        nSlots += GetItemBonusSlotCount(oItemPosessor, nClass, nSpellLevel);

    // Add spell slots from high ability score. Level 0 spells are exempt
    if(nSpellLevel == 0)
        return nSlots;
    else
    {
        int nAbilityMod = nClass == CLASS_TYPE_ARCHIVIST ? GetAbilityModifier(ABILITY_WISDOM, oItemPosessor) : (nAbilityScore - 10) / 2;
        if(nAbilityMod >= nSpellLevel) // Need an ability modifier at least equal to the spell level to gain bonus slots
            nSlots += ((nAbilityMod - nSpellLevel) / 4) + 1;
        return nSlots;
    }
}

//if the class doesn't learn all available spells on level-up add it here
int bKnowsAllClassSpells(int nClass)
{
    switch(nClass)
    {
        case CLASS_TYPE_ARCHIVIST:
        //case CLASS_TYPE_ASSASSIN:
        case CLASS_TYPE_BARD:
        case CLASS_TYPE_DUSKBLADE:
        case CLASS_TYPE_FAVOURED_SOUL:
        case CLASS_TYPE_HEXBLADE:
        case CLASS_TYPE_JUSTICEWW:
        case CLASS_TYPE_MYSTIC:
        case CLASS_TYPE_SORCERER:
        case CLASS_TYPE_SUBLIME_CHORD:
        case CLASS_TYPE_SUEL_ARCHANAMACH:
        case CLASS_TYPE_WITCH:
        //case CLASS_TYPE_WIZARD:
            return FALSE;

        // Everyone else
        default:
            return TRUE;
    }
    return TRUE;
}

int GetSpellKnownMaxCount(int nLevel, int nSpellLevel, int nClass, object oPC)
{
    // If the character doesn't have any spell slots available on for this level, it can't know any spells of that level either
    /// @todo Check rules. There might be cases where this doesn't hold
    if(!GetSlotCount(nLevel, nSpellLevel, GetAbilityScoreForClass(nClass, oPC), nClass))
        return 0;
    int nKnown;
    string sFile;
    // Bioware casters use their classes.2da-specified tables
    /*if(    nClass == CLASS_TYPE_WIZARD
        || nClass == CLASS_TYPE_SORCERER
        || nClass == CLASS_TYPE_BARD
        || nClass == CLASS_TYPE_CLERIC
        || nClass == CLASS_TYPE_DRUID
        || nClass == CLASS_TYPE_PALADIN
        || nClass == CLASS_TYPE_RANGER)
    {*/
        sFile = Get2DACache("classes", "SpellKnownTable", nClass);
    /*}
    else
    {
        sFile = Get2DACache("classes", "FeatsTable", nClass);
        sFile = "cls_spkn" + GetStringRight(sFile, GetStringLength(sFile) - 8); // Hardcoded the cls_ part. It's not as if any class uses some other prefix - Ornedan, 20061231
    }*/

    string sKnown = Get2DACache(sFile, "SpellLevel" + IntToString(nSpellLevel), nLevel - 1);
    if(DEBUG) DoDebug("GetSpellKnownMaxCount(" + IntToString(nLevel) + ", " + IntToString(nSpellLevel) + ", " + IntToString(nClass) + ", " + GetName(oPC) + ") = " + sKnown);
    if(sKnown == "")
    {
        nKnown = -1;
        //if(DEBUG) DoDebug("GetSpellKnownMaxCount: Problem getting known numbers for " + IntToString(nSpellLevel) + " " + IntToString(nLevel) + " " + sFile);
    }
    else
        nKnown = StringToInt(sKnown);
    if(nKnown == -1)
        return 0;

    // Bard and Sorcerer only have new spellbook spells known if they have taken prestige classes that increase spellcasting
    if(nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_BARD)
    {
        if((GetLevelByClass(nClass) == nLevel) //no PrC
          && !(GetHasFeat(FEAT_DRACONIC_GRACE, oPC) || GetHasFeat(FEAT_DRACONIC_BREATH, oPC))) //no Draconic feats that apply
            return 0;
    }
    return nKnown;
}

int GetSpellKnownCurrentCount(object oPC, int nSpellLevel, int nClass)
{
    // Check short-term cache
    string sClassNum = IntToString(nClass);
    if(GetLocalInt(oPC, "GetSKCCCache_" + IntToString(nSpellLevel) + "_" + sClassNum))
        return GetLocalInt(oPC, "GetSKCCCache_" + IntToString(nSpellLevel) + "_" + sClassNum) - 1;

    // Loop over all spells known and count the number of spells of each level known
    int i;
    int nKnown;
    int nKnown0, nKnown1, nKnown2, nKnown3, nKnown4;
    int nKnown5, nKnown6, nKnown7, nKnown8, nKnown9;
    string sFile = GetFileForClass(nClass);
    for(i = 0; i < persistant_array_get_size(oPC, "Spellbook" + sClassNum); i++)
    {
        int nNewSpellbookID = persistant_array_get_int(oPC, "Spellbook" + sClassNum, i);
        int nLevel = StringToInt(Get2DACache(sFile, "Level", nNewSpellbookID));
        switch(nLevel)
        {
            case 0: nKnown0++; break; case 1: nKnown1++; break;
            case 2: nKnown2++; break; case 3: nKnown3++; break;
            case 4: nKnown4++; break; case 5: nKnown5++; break;
            case 6: nKnown6++; break; case 7: nKnown7++; break;
            case 8: nKnown8++; break; case 9: nKnown9++; break;
        }
    }

    // Pick the level requested for returning
    switch(nSpellLevel)
    {
        case 0: nKnown = nKnown0; break; case 1: nKnown = nKnown1; break;
        case 2: nKnown = nKnown2; break; case 3: nKnown = nKnown3; break;
        case 4: nKnown = nKnown4; break; case 5: nKnown = nKnown5; break;
        case 6: nKnown = nKnown6; break; case 7: nKnown = nKnown7; break;
        case 8: nKnown = nKnown8; break; case 9: nKnown = nKnown9; break;
    }
    if(DEBUG) DoDebug("GetSpellKnownCurrentCount(" + GetName(oPC) + ", " + IntToString(nSpellLevel) + ", " + sClassNum + ") = " + IntToString(nKnown));

    // Cache the values for 1 second
    SetLocalInt(oPC, "GetSKCCCache_0_" + sClassNum, nKnown0 + 1);
    SetLocalInt(oPC, "GetSKCCCache_1_" + sClassNum, nKnown1 + 1);
    SetLocalInt(oPC, "GetSKCCCache_2_" + sClassNum, nKnown2 + 1);
    SetLocalInt(oPC, "GetSKCCCache_3_" + sClassNum, nKnown3 + 1);
    SetLocalInt(oPC, "GetSKCCCache_4_" + sClassNum, nKnown4 + 1);
    SetLocalInt(oPC, "GetSKCCCache_5_" + sClassNum, nKnown5 + 1);
    SetLocalInt(oPC, "GetSKCCCache_6_" + sClassNum, nKnown6 + 1);
    SetLocalInt(oPC, "GetSKCCCache_7_" + sClassNum, nKnown7 + 1);
    SetLocalInt(oPC, "GetSKCCCache_8_" + sClassNum, nKnown8 + 1);
    SetLocalInt(oPC, "GetSKCCCache_9_" + sClassNum, nKnown9 + 1);
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_0_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_1_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_2_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_3_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_4_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_5_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_6_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_7_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_8_" + sClassNum));
    DelayCommand(1.0, DeleteLocalInt(oPC, "GetSKCCCache_9_" + sClassNum));

    return nKnown;
}

int GetSpellUnknownCurrentCount(object oPC, int nSpellLevel, int nClass)
{
    // Get the lookup token created by MakeSpellbookLevelLoop()
    string sTag = "SpellLvl_" + IntToString(nClass) + "_Level_" + IntToString(nSpellLevel);
    object oCache = GetObjectByTag(sTag);
    if(!GetIsObjectValid(oCache))
    {
        if(DEBUG) DoDebug("GetSpellUnknownCurrentCount: " + sTag + " is not valid");
        return 0;
    }
    // Read the total number of spells on the given level and determine how many are already known
    int nTotal = array_get_size(oCache, "Lkup");
    int nKnown = GetSpellKnownCurrentCount(oPC, nSpellLevel, nClass);
    int nUnknown = nTotal - nKnown;

    if(DEBUG) DoDebug("GetSpellUnknownCurrentCount(" + GetName(oPC) + ", " + IntToString(nSpellLevel) + ", " + IntToString(nClass) + ") = " + IntToString(nUnknown));
    return nUnknown;
}

void AddSpellUse(object oPC, int nSpellbookID, int nClass, string sFile, string sArrayName, int nSpellbookType, object oSkin, int nFeatID, int nIPFeatID)
{
    /*
    string sFile = GetFileForClass(nClass);
    string sArrayName = "NewSpellbookMem_"+IntToString(nClass);
    int nSpellbookType = GetSpellbookTypeForClass(nClass);
    object oSkin = GetPCSkin(oPC);
    int nFeatID = StringToInt(Get2DACache(sFile, "FeatID", nSpellbookID));
    //add the feat only if they dont already have it
    int nIPFeatID = StringToInt(Get2DACache(sFile, "IPFeatID", nSpellbookID));
    */

    // Add the spell use feats and set a marker local that tells for CheckAndRemoveFeat() to skip removing this feat
    string sIPFeatID = IntToString(nIPFeatID);
    SetLocalInt(oSkin, "NewSpellbookTemp_" + sIPFeatID, TRUE);
    if(!GetHasFeat(nFeatID, oPC))
    {
        AddItemProperty(DURATION_TYPE_PERMANENT, PRCItemPropertyBonusFeat(nIPFeatID), oSkin);
    }
    // Increase the current number of uses
    if(nSpellbookType == SPELLBOOK_TYPE_PREPARED)
    {
        //sanity test
        if(!persistant_array_exists(oPC, sArrayName))
        {
            if(DEBUG) DoDebug("ERROR: AddSpellUse: " + sArrayName + " array does not exist, creating");
            persistant_array_create(oPC, sArrayName);
        }
        int nUses = persistant_array_get_int(oPC, sArrayName, nSpellbookID);
        nUses++;
        persistant_array_set_int(oPC, sArrayName, nSpellbookID, nUses);
        if(DEBUG) DoDebug("AddSpellUse: " + sArrayName + "[" + IntToString(nSpellbookID) + "] = " + IntToString(persistant_array_get_int(oPC, sArrayName, nSpellbookID)));
    }
    else if(nSpellbookType == SPELLBOOK_TYPE_SPONTANEOUS)
    {
        //sanity test
        if(!persistant_array_exists(oPC, sArrayName))
        {
            if(DEBUG) DoDebug("ERROR: AddSpellUse: " + sArrayName + " array does not exist, creating");
            persistant_array_create(oPC, sArrayName);
        }
        /*int nSpellLevel = StringToInt(Get2DACache(sFile, "Level", nSpellbookID));
        int nCount = persistant_array_get_int(oPC, sArrayName, nSpellLevel);
        if(nCount < 1)
        {
            int nLevel = GetSpellslotLevel(nClass, oPC);
            int nAbility = GetAbilityScoreForClass(nClass, oPC);
            nCount = GetSlotCount(nLevel, nSpellLevel, nAbility, nClass, oPC);
            persistant_array_set_int(oPC, sArrayName, nSpellLevel, nCount);
        }*/
        if(DEBUG) DoDebug("AddSpellUse() called on spontaneous spellbook. nIPFeatID = " + sIPFeatID);
    }
}

void RemoveSpellUse(object oPC, int nSpellID, int nClass)
{
    string sFile = GetFileForClass(nClass);
    int nSpellbookID = SpellToSpellbookID(nSpellID);
    if(nSpellbookID == -1)
    {
        if(DEBUG) DoDebug("ERROR: RemoveSpellUse: Unable to resolve spell to spellbookID: " + IntToString(nSpellID) + " in file " + sFile);
        return;
    }
    if(!persistant_array_exists(oPC, "NewSpellbookMem_"+IntToString(nClass)))
    {
        if(DEBUG) DoDebug("RemoveSpellUse: NewSpellbookMem_" + IntToString(nClass) + " does not exist, creating.");
        persistant_array_create(oPC, "NewSpellbookMem_"+IntToString(nClass));
    }

    // Reduce the remaining uses of the given spell by 1 (except never reduce uses below 0).
    // Spontaneous spellbooks reduce the number of spells of the spell's level remaining
    int nSpellbookType = GetSpellbookTypeForClass(nClass);
    if(nSpellbookType == SPELLBOOK_TYPE_PREPARED)
    {
        int nCount = persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellbookID);
        if(nCount > 0)
            persistant_array_set_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellbookID, nCount - 1);
    }
    else if(nSpellbookType == SPELLBOOK_TYPE_SPONTANEOUS)
    {
        int nSpellLevel = StringToInt(Get2DACache(sFile, "Level", nSpellbookID));
        int nCount = persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellLevel);
        if(nCount > 0)
            persistant_array_set_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellLevel, nCount - 1);
    }
}

int GetSpellLevel(int nSpellID, int nClass)
{
    string sFile = GetFileForClass(nClass);
    int nSpellbookID = SpellToSpellbookID(nSpellID);
    if(nSpellbookID == -1)
    {
        if(DEBUG) DoDebug("ERROR: GetSpellLevel: Unable to resolve spell to spellbookID: "+IntToString(nSpellID)+" "+sFile);
        return -1;
    }

    // check if this spell actually belong to this class
    if (nSpellID != StringToInt(Get2DACache(sFile, "SpellID", nSpellbookID)))
        return -1;

    // get spell level
    int nSpellLevel = -1;
    string sSpellLevel = Get2DACache(sFile, "Level", nSpellbookID);

    if (sSpellLevel != "")
        nSpellLevel = StringToInt(sSpellLevel);

    return nSpellLevel;
}

//called inside for loop in SetupSpells(), delayed to prevent TMI
void SpontaneousSpellSetupLoop(object oPC, int nClass, string sFile, object oSkin, int i)
{
    //int nMetaFeat;
    //int j;
    int nSpellbookID = persistant_array_get_int(oPC, "Spellbook" + IntToString(nClass), i);
    string sIPFeatID = Get2DACache(sFile, "IPFeatID", nSpellbookID);
    int nIPFeatID = StringToInt(sIPFeatID);
    int nFeatID = StringToInt(Get2DACache(sFile, "FeatID", nSpellbookID));
    //int nRealSpellID = StringToInt(Get2DACache(sFile, "RealSpellID", nSpellbookID));
    SetLocalInt(oSkin, "NewSpellbookTemp_" + sIPFeatID, TRUE);

    if(!GetHasFeat(nFeatID, oPC))
        AddItemProperty(DURATION_TYPE_PERMANENT, PRCItemPropertyBonusFeat(nIPFeatID), oSkin);

    //metamagic
    /*for(j = nSpellbookID + 1; j <= nSpellbookID + RealSpellToSpellbookIDCount(nClass, nRealSpellID); j++)
    {
        nMetaFeat = StringToInt(Get2DACache(sFile, "ReqFeat", j));
        // See if the PC has the metafeat required by this variant of the spell
        if(nMetaFeat == 0 || !GetHasFeat(nMetaFeat, oPC))
            continue;
        sIPFeatID = Get2DACache(sFile, "IPFeatID", j);
        nIPFeatID = StringToInt(sIPFeatID);
        nFeatID = StringToInt(Get2DACache(sFile, "FeatID", j));
        SetLocalInt(oSkin, "NewSpellbookTemp_" + sIPFeatID, TRUE);

        if(!GetHasFeat(nFeatID, oPC))   //more delay to minimise freezing
            DelayCommand(0.02 * IntToFloat(i), AddItemProperty(DURATION_TYPE_PERMANENT, PRCItemPropertyBonusFeat(nIPFeatID), oSkin));
    }*/
}

void SetupSpells(object oPC, int nClass)
{
    string sFile = GetFileForClass(nClass);
    string sClass = IntToString(nClass);
    string sArrayName = "NewSpellbookMem_" + sClass;
    object oSkin = GetPCSkin(oPC);
    int nLevel = GetSpellslotLevel(nClass, oPC);
    int nAbility = GetAbilityScoreForClass(nClass, oPC);
    int nSpellbookType = GetSpellbookTypeForClass(nClass);

    // For spontaneous spellbooks, set up an array that tells how many spells of each level they can cast
    // And add casting feats for each spell known to the caster's hide

    if(nSpellbookType == SPELLBOOK_TYPE_SPONTANEOUS)
    {
        // Spell slots
        int nSpellLevel, nSlots;
        for(nSpellLevel = 0; nSpellLevel <= 9; nSpellLevel++)
        {
            nSlots = GetSlotCount(nLevel, nSpellLevel, nAbility, nClass, oPC);
            persistant_array_set_int(oPC, sArrayName, nSpellLevel, nSlots);
        }

        int i;
        for(i = 0; i < persistant_array_get_size(oPC, "Spellbook" + sClass); i++)
        {   //adding feats
            DelayCommand(0.01 * IntToFloat(i), SpontaneousSpellSetupLoop(oPC, nClass, sFile, oSkin, i));
        }
    }// end if - Spontaneous spellbook

    // For prepared spellbooks, add spell uses and use feats according to spells memorised list
    else if(nSpellbookType == SPELLBOOK_TYPE_PREPARED && !GetIsBioSpellCastClass(nClass))
    {
        int nSpellLevel, nSlot, nSlots, nSpellbookID;
        string sArrayName2;
        for(nSpellLevel = 0; nSpellLevel <= 9; nSpellLevel++)
        {
            nSlots = GetSlotCount(nLevel, nSpellLevel, nAbility, nClass, oPC);
            nSlot;
            for(nSlot = 0; nSlot < nSlots; nSlot++)
            {
                //done when spells are added to it
                sArrayName2 = "Spellbook" + IntToString(nSpellLevel) + "_" + sClass; // Minor optimisation: cache the array name string for multiple uses
                if(!persistant_array_exists(oPC, sArrayName2))
                    persistant_array_create(oPC, sArrayName2);
                nSpellbookID = persistant_array_get_int(oPC, sArrayName2, nSlot);
                if(nSpellbookID != 0)
                {
                    AddSpellUse(oPC, nSpellbookID, nClass, sFile, sArrayName, nSpellbookType, oSkin,
                        StringToInt(Get2DACache(sFile, "FeatID", nSpellbookID)),
                        StringToInt(Get2DACache(sFile, "IPFeatID", nSpellbookID))
                        );
                }
            }
        }
    }
}

void CheckAndRemoveFeat(object oHide, itemproperty ipFeat)
{
    int nSubType = GetItemPropertySubType(ipFeat);
    if(!GetLocalInt(oHide, "NewSpellbookTemp_" + IntToString(nSubType)))
    {
        RemoveItemProperty(oHide, ipFeat);
        DeleteLocalInt(oHide, "NewSpellbookTemp_" + IntToString(nSubType));
        if(DEBUG) DoDebug("CheckAndRemoveFeat: DeleteLocalInt(oHide, NewSpellbookTemp_" + IntToString(nSubType) + ");");
        if(DEBUG) DoDebug("CheckAndRemoveFeat: Removing item property");
    }
    else
    {
        DeleteLocalInt(oHide, "NewSpellbookTemp_" + IntToString(nSubType));
        if(DEBUG) DoDebug("CheckAndRemoveFeat: DeleteLocalInt(oHide, NewSpellbookTemp_" + IntToString(nSubType) + ");");
    }
}

void WipeSpellbookHideFeats(object oPC)
{
    object oHide = GetPCSkin(oPC);
    itemproperty ipTest = GetFirstItemProperty(oHide);
    while(GetIsItemPropertyValid(ipTest))
    {
        if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_BONUS_FEAT &&
              ((GetItemPropertySubType(ipTest) > SPELLBOOK_IPRP_FEATS_START && GetItemPropertySubType(ipTest) < SPELLBOOK_IPRP_FEATS_END) ||
               (GetItemPropertySubType(ipTest) > SPELLBOOK_IPRP_FEATS_START2 && GetItemPropertySubType(ipTest) < SPELLBOOK_IPRP_FEATS_END2))
          )
        {
            DelayCommand(1.0f, CheckAndRemoveFeat(oHide, ipTest));
        }
        ipTest = GetNextItemProperty(oHide);
    }
}

void CheckNewSpellbooks(object oPC)
{
    WipeSpellbookHideFeats(oPC);
    int i;
    for(i = 1; i <= 3; i++)
    {
        int nClass = GetClassByPosition(i, oPC);
        int nLevel = GetLevelByClass(nClass, oPC);

        if(DEBUG) DoDebug("CheckNewSpellbooks\n"
                        + "nClass = " + IntToString(nClass) + "\n"
                        + "nLevel = " + IntToString(nLevel) + "\n"
                          );
        //if bard/sorc newspellbook is disabled after selecting
        //remove those from radial
        if(   (GetPRCSwitch(PRC_BARD_DISALLOW_NEWSPELLBOOK) && nClass == CLASS_TYPE_BARD)
            ||(GetPRCSwitch(PRC_SORC_DISALLOW_NEWSPELLBOOK) && nClass == CLASS_TYPE_SORCERER))
        {
            //do nothing
        }
        else if(nLevel)
        {
            //raks cast as sorcs
            if(nClass == CLASS_TYPE_OUTSIDER
                && !GetLevelByClass(CLASS_TYPE_SORCERER, oPC)
                && GetRacialType(oPC) == RACIAL_TYPE_RAKSHASA)
                nClass = CLASS_TYPE_SORCERER;
            //remove persistant locals used to track when all spells cast
            string sArrayName = "NewSpellbookMem_"+IntToString(nClass);
            if(persistant_array_exists(oPC, sArrayName))
            {
                persistant_array_delete(oPC, sArrayName);
                persistant_array_create(oPC, sArrayName);
            }
            //delay it so wipespellbookhidefeats has time to start to run
            //but before the deletes actually happen
            DelayCommand(0.1, SetupSpells(oPC, nClass));
        }
    }
}

//NewSpellbookSpell() helper functions
int bTargetingAllowed(int nSpellID);
void CheckPrepSlots(object oPC, int nClass, int nSpellbookID, int nSpellID, int nSpellSlotLevel, int nMetamagic, int bIsAction);
void CheckSpontSlots(object oPC, int nClass, int nSpellbookID, int nSpellID, int nSpellSlotLevel, int nMetamagic, int bIsAction);
void DoCleanUp(object oPC, int nMetamagic);

void NewSpellbookSpell(int nClass, int nMetamagic, int nSpellID)
{
    object oPC = OBJECT_SELF;
    if(nSpellID == -1)
        nSpellID = 0;

    //Check the target first
    if(!bTargetingAllowed(nSpellID))
        return;

    //get the spellbook ID
    string sFile = GetFileForClass(nClass);
    int nFakeSpellID = PRCGetSpellId();
    //if its a subradial spell, get the master
    int nMasterFakeSpellID;
    nMasterFakeSpellID = StringToInt(Get2DACache("spells", "Master", nFakeSpellID));
    if(!nMasterFakeSpellID)
        nMasterFakeSpellID = nFakeSpellID;

    int nSpellbookID = SpellToSpellbookID(nMasterFakeSpellID);

    // Paranoia - It should not be possible to get here without having the spells available array existing
    if(!persistant_array_exists(oPC, "NewSpellbookMem_" + IntToString(nClass)))
    {
        if(DEBUG) DoDebug("ERROR: NewSpellbookSpell: NewSpellbookMem_" + IntToString(nClass) + " array does not exist");
        persistant_array_create(oPC, "NewSpellbookMem_" + IntToString(nClass));
    }

    // Make sure the caster has uses of this spell remaining
    int nSpellbookType = GetSpellbookTypeForClass(nClass);
    int nSpellLevel = StringToInt(Get2DACache(sFile, "Level", nSpellbookID));
    // 2009-9-20: Add metamagic feat abilities. -N-S
    int nSpellSlotLevel = nSpellLevel;
    if(nSpellbookType == SPELLBOOK_TYPE_PREPARED)
    {
        CheckPrepSlots(oPC, nClass, nSpellbookID, nSpellID, nSpellSlotLevel, nMetamagic, FALSE);
        if(GetLocalInt(oPC, "NSB_Cast"))
        {
            ActionDoCommand(CheckPrepSlots(oPC, nClass, nSpellbookID, nSpellID, nSpellSlotLevel, nMetamagic, TRUE));
        }
        else
            return;
    }
    else if(nSpellbookType == SPELLBOOK_TYPE_SPONTANEOUS)
    {
        nMetamagic = GetLocalInt(oPC, "MetamagicFeatAdjust");

        //Need to check if metamagic can be applied to a spell
        int nMetaTest;
        int nMetaType = HexToInt(Get2DACache("spells", "MetaMagic", nSpellID));
        /*
        # 0x01 = 1 = Empower
        # 0x02 = 2 = Extend
        # 0x04 = 4 = Maximize
        # 0x08 = 8 = Quicken
        # 0x10 = 16 = Silent
        # 0x20 = 32 = Still
        */
        switch(nMetamagic)
        {
            case METAMAGIC_NONE: nMetaTest = 1; break; //no need to change anything
            case METAMAGIC_EMPOWER: nMetaTest = nMetaType & 1; break;
            case METAMAGIC_EXTEND: nMetaTest = nMetaType & 2; break;
            case METAMAGIC_MAXIMIZE: nMetaTest = nMetaType & 4; break;
            case METAMAGIC_QUICKEN: nMetaTest = nMetaType & 8; break;
            case METAMAGIC_SILENT: nMetaTest = nMetaType & 16; break;
            case METAMAGIC_STILL: nMetaTest = nMetaType & 32; break;
        }

        if(!nMetaTest)//can't use selected metamagic with this spell
        {
            nMetamagic = METAMAGIC_NONE;
            ActionDoCommand(SendMessageToPC(oPC, "You can't use "+GetStringByStrRef(StringToInt(Get2DACache("spells", "Name", nSpellID)))+"with selected metamagic."));
        }
        else//now test the spell level
        {
            nSpellSlotLevel += GetMetaMagicSpellLevelAdjustment(nMetamagic);
            if (nSpellSlotLevel > 9)
            {
                nMetamagic = METAMAGIC_NONE;
                ActionDoCommand(SendMessageToPC(oPC, "Modified spell level is to high! Casting spell without metamagic"));
                nSpellSlotLevel = nSpellLevel;
            }
            else if(GetLocalInt(oPC, "PRC_metamagic_state") == 1)
            {
                SetLocalInt(oPC, "MetamagicFeatAdjust", 0);
            }
        }

        CheckSpontSlots(oPC, nClass, nSpellbookID, nSpellID, nSpellSlotLevel, nMetamagic, FALSE);
        if(GetLocalInt(oPC, "NSB_Cast"))
        {
            ActionDoCommand(CheckSpontSlots(oPC, nClass, nSpellbookID, nSpellID, nSpellSlotLevel, nMetamagic, TRUE));
        }
        else
            return;
    }

    // Calculate DC. 10 + spell level on the casting class's list + DC increasing ability mod
    int nDC = 10 + nSpellLevel + GetDCAbilityModForClass(nClass, oPC);

    //remove any old effects
    //seems cheat-casting breaks hardcoded removal
    //and cant remove effects because I dont know all the targets!

    // This does the Duskblade's Quick Cast
    if (/*nClass == CLASS_TYPE_DUSKBLADE && */GetLocalInt(oPC, "DBQuickCast"))
        nMetamagic |= METAMAGIC_QUICKEN;

    int nCastDur = StringToInt(Get2DACache("spells", "ConjTime", nSpellID)) + StringToInt(Get2DACache("spells", "CastTime", nSpellID));

    //Handle quicken metamagic
    if((nMetamagic & METAMAGIC_QUICKEN))
    {
        //Adding Auto-Quicken III for one round - deleted after casting is finished.
        object oSkin = GetPCSkin(oPC);
        itemproperty ipAutoQuicken = ItemPropertyBonusFeat(IP_CONST_NSB_AUTO_QUICKEN);
        ActionDoCommand(AddItemProperty(DURATION_TYPE_TEMPORARY, ipAutoQuicken, oSkin, nCastDur/1000.0f));
    }
    else if(nClass == CLASS_TYPE_HEALER &&
       GetHasFeat(FEAT_EFFORTLESS_HEALING, oPC) &&
       GetIsOfSubschool(nSpellID, SUBSCHOOL_HEALING))
    {
        object oSkin = GetPCSkin(oPC);
        itemproperty ipImpCombatCast = ItemPropertyBonusFeat(IP_CONST_NSB_IMP_COMBAT_CAST);
        ActionDoCommand(AddItemProperty(DURATION_TYPE_TEMPORARY, ipImpCombatCast, oSkin, nCastDur/1000.0f));
    }
    //cast the spell
    //dont need to override level, the spellscript will calculate it
    //class is read from "NSB_Class"
    ActionCastSpell(nSpellID, 0, nDC, 0, nMetamagic, CLASS_TYPE_INVALID, 0, 0, OBJECT_INVALID, FALSE);

    //Clean up
    ActionDoCommand(DoCleanUp(oPC, nMetamagic));
}

int bTargetingAllowed(int nSpellID)
{
    object oTarget = PRCGetSpellTargetObject();
    int nTargetType = HexToInt(Get2DACache("spells", "TargetType", nSpellID));
    int nCaster     = nTargetType &  1;
    int nCreature   = nTargetType &  2;

    //test targetting self
    if(oTarget == OBJECT_SELF)
    {
        if(!nCaster)
        {
            if(DEBUG) DoDebug("bTargetingAllowed: You cannot target yourself.");
            return FALSE;
        }
    }
    //test targetting others
    else if(GetIsObjectValid(oTarget))
    {
        if(GetObjectType(oTarget) ==OBJECT_TYPE_CREATURE)
        {
            if(!nCreature)
            {
                if(DEBUG) DoDebug("bTargetingAllowed: You cannot target creatures.");
                return FALSE;
            }
        }
    }
    return TRUE;
}

void CheckPrepSlots(object oPC, int nClass, int nSpellbookID, int nSpellID, int nSpellSlotLevel, int nMetamagic, int bIsAction)
{
    DeleteLocalInt(oPC, "NSB_Cast");
    int nCount = persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellbookID);
    if(DEBUG) DoDebug("NewSpellbookSpell: NewSpellbookMem_" + IntToString(nClass) + "[" + IntToString(nSpellbookID) + "] = " + IntToString(nCount));
    if(nCount < 1)
    {
        string sSpellName = GetStringByStrRef(StringToInt(Get2DACache("spells", "Name", nSpellID)));
        // "You have no castings of " + sSpellName + " remaining"
        string sMessage   = ReplaceChars(GetStringByStrRef(16828411), "<spellname>", sSpellName);

        FloatingTextStringOnCreature(sMessage, oPC, FALSE);
        if(bIsAction)
            ClearAllActions();
    }
    else
    {
        SetLocalInt(oPC, "NSB_Cast", 1);
        if(bIsAction)
        {
            SetLocalInt(oPC, "NSB_Class", nClass);
            SetLocalInt(oPC, "NSB_SpellbookID", nSpellbookID);
        }
    }
}

void CheckSpontSlots(object oPC, int nClass, int nSpellbookID, int nSpellID, int nSpellSlotLevel, int nMetamagic, int bIsAction)
{
    DeleteLocalInt(oPC, "NSB_Cast");
    int nCount = persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellSlotLevel);
    //int nCount = persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellLevel);
    if(DEBUG) DoDebug("NewSpellbookSpell: NewSpellbookMem_" + IntToString(nClass) + "[" + IntToString(nSpellbookID) + "] = " + IntToString(nCount));
    if(nCount < 1)
    {
        // "You have no castings of spells of level " + IntToString(nSpellLevel) + " remaining"
        string sMessage   = ReplaceChars(GetStringByStrRef(16828409), "<spelllevel>", IntToString(nSpellSlotLevel));

        FloatingTextStringOnCreature(sMessage, oPC, FALSE);
        if(bIsAction)
            ClearAllActions();
    }
    else
    {
        SetLocalInt(oPC, "NSB_Cast", 1);
        if(bIsAction)
        {
            SetLocalInt(oPC, "NSB_Class", nClass);
            SetLocalInt(oPC, "NSB_SpellLevel", nSpellSlotLevel);
        }
    }
}

void DoCleanUp(object oPC, int nMetamagic)
{
    if((nMetamagic & METAMAGIC_QUICKEN))
    {
        object oSkin = GetPCSkin(oPC);
        itemproperty ipAutoQuicken = ItemPropertyBonusFeat(IP_CONST_NSB_AUTO_QUICKEN);
        RemoveItemProperty(oSkin, ipAutoQuicken);
    }
    DeleteLocalInt(oPC, "NSB_Class");
    DeleteLocalInt(oPC, "NSB_SpellLevel");
    DeleteLocalInt(oPC, "NSB_SpellbookID");
}
