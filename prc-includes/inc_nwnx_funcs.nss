



//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

// Used in OnModuleLoad event to auto-detect if NWNX_Funcs plugin is enabled
void PRC_Funcs_Init(object oModule);

// Checks if oObject has a local variable with the name sVarName
// iVarType specifies the type of local variable to look for (LV_TYPE_*)
// The default (iVarType = 0) disregards type and find the first local variable with the specified name
// The return value is the type of variable (LV_TYPE_*) or zero if no local variable was found
int  PRC_Funcs_GetHasLocalVariable(object oObject, string sVarName, int iVarType = 0);

// Set the racial type of oObject to iRace;
// Will not change the actual appearance of iObject
void PRC_Funcs_SetRace(object oCreature, int iRace);

// Sets the gender of oCreature to iGender (GENDER_*)
// This does NOT change the creature appearance in any way, unless a player relogs or a creature is saved and respawned
void PRC_Funcs_SetGender(object oCreature, int iGender);

// Set a creature's age
void PRC_Funcs_SetAge(object oCreature, int iAge);

// Changes oCreatures class type at iPosition(1-3)
void PRC_Funcs_SetClassByPosition(object oCreature, int iPosition, int iClass);

// Sets the class type taken at a specific level
void PRC_Funcs_SetClassByLevel(object oCreature, int iClass, int iLevel);

// Replaces one class of a creature with another
// including classes in the level statlist of the creature
void PRC_Funcs_ReplaceClass(object oCreature, int iOldClass, int iNewClass);

// Sets the type of familiar oObject can summon
// Does not allow summoning of familiars without having the necessary feat
void PRC_Funcs_SetFamiliarType(object oCreature, int iFamiliarType);

// Sets the type of animal companion oObject can summon
// Does not allow summoning of animal companians without having the necessary feat
void PRC_Funcs_SetAnimalCompanion(object oCreature, int iAnimalCompanionType);

// Returns the specialist spell school of a Wizard
int PRC_Funcs_GetWizardSpecialization(object oCreature);

// Sets the specialist spell school of a Wizard
void PRC_Funcs_SetWizardSpecialization(object oCreature, int iSpecialization);

// Returns either one of the two domains of a cleric
// iDomain_1_2 can either be 1 or 2
int PRC_Funcs_GetDomain(object oCreature, int iDomain_1_2);

// Sets either one of the two domains of a cleric to iDomain
// iDomain_1_2 can either be 1 or 2
void PRC_Funcs_SetDomain(object oCreature, int iDomain_1_2, int iDomain);

// Returns the soundsset of oCreature (row number of soundset.2da)
int PRC_Funcs_GetSoundSetID(object oCreature);

// Changes the soundsset of oCreature to iSoundSetID (row number of soundset.2da)
void PRC_Funcs_SetSoundSetID(object oCreature, int iSoundSetID);

// Sets hitpoints gained at iLevel
void PRC_Funcs_SetHitPointsByLevel(object oCreature, int iHP, int iLevel);

// Changes the hitpoints gained at iLevel by iHPMod
void PRC_Funcs_ModHitPointsByLevel(object oCreature, int iHPMod, int iLevel);

// Sets the amount of hitpoints oObject has currently to iHP
void PRC_Funcs_SetCurrentHitPoints(object oCreature, int iHP);

// Sets the amount of hitpoints oObject can maximally have to iHP
void PRC_Funcs_SetMaxHitPoints(object oCreature, int iHP);

// Changes the skill ranks for iSkill on oObject to iValue
void PRC_Funcs_SetSkill(object oCreature, int iSkill, int iValue);

// Changes the skill ranks for iSkill on oObject by iValue
void PRC_Funcs_ModSkill(object oCreature, int iSkill, int iValue);

// Changes the skill ranks for iSkill gained at iLevel on oObject to iValue
void PRC_Funcs_SetSkillByLevel(object oCreature, int iSkill, int iValue, int iLevel);

// Changes the skill ranks for iSkill gained at iLevel on oObject by iValue
void PRC_Funcs_ModSkillByLevel(object oCreature, int iSkill, int iValue, int iLevel);

// Returns the Skill Points saved during level-up
int  PRC_Funcs_GetSavedSkillPoints(object oPC);

// Sets the Skill Points saved during level-up
void PRC_Funcs_SetSavedSkillPoints(object oPC, int iSkillPoints);

// Changes the number of saved skillpoints by iSkillPoints
void PRC_Funcs_ModSavedSkillPoints(object oPC, int iSkillPoints);

// Sets all skills of oCreature to zero
void PRC_Funcs_SetAllSkillsToZero(object oCreature);

// Sets a base ability score iAbility (ABILITY_STRENGTH, ABILITY_DEXTERITY, etc) to iValue
// The range of iValue is 3 to 255
// bAdjustCurrentHitPoints is only used when Constitution is set: if false a potential increase in hitpoints
// will only affect oCreature's maximum hit points. The missing hit points can be regained the normal way: resting,
// healing, regeneration, etc.
void PRC_Funcs_SetAbilityScore(object oCreature, int iAbility, int iValue, int bAdjustCurrentHitPoints = 1);

// Changes a base ability score iAbility (ABILITY_STRENGTH, ABILITY_DEXTERITY, etc) by iValue
void PRC_Funcs_ModAbilityScore(object oCreature, int iAbility, int iValue, int bAdjustCurrentHitPoints = 1);

// Returns the number of feats oCreature has (not including feats gained from items)
int  PRC_Funcs_GetFeatCount(object oCreature);

// Adds a feat to oObject's general featlist
// If iLevel is greater than 0 the feat is also added to the featlist for that level
void PRC_Funcs_AddFeat(object oCreature, int iFeat, int iLevel=0);

// Removes a feat from a creature
// If bRemoveFromLevel is FALSE, the feat will only be removed from the general feat list (the feat lists for each character level are ignored; 
// If bRemoveFromLevel is TRUE, the feat will be removed from the general feat list and from the feat list for the appropriate level
// If found, the feat will be removed from the general feat list whether it exists in a level feat list or not, and vice versa
int  PRC_Funcs_RemoveFeat(object oCreature, int iFeat, int bRemoveFromLevel=TRUE);

// Checks if oCreature inherently knows a feat (as opposed to a feat given from an equipped item)
// Returns FALSE if oCreature does not know the feat, TRUE if the feat is known
// The return value (if greater than 0) also denotes the position of the feat in the general feat list offset by +1
int  PRC_Funcs_GetFeatKnown(object oCreature, int iFeat);

// Retuns a delimited list of all the known feats of oCreature
// Not sure how useful this is in general but I'll be using it to enter it into mysql
// GetAllKnownFeats can fail if oCreature has too many feats (more precisely if the returned string would be longer than 2048 characters)
// Worst case scenario (all feats are above row 10000) is about 340 feats for the default delimiter
string PRC_Funcs_GetAllKnownFeats(object oCreature, string sDelimiter=",");

// Removes all feats from oCreature's general feat list (oCreature will not have any feats in game)
// If bClearLevelFeatLists is true it will remove all the feats from the level stat lists too
void PRC_Funcs_RemoveAllFeats(object oCreature, int bClearLevelFeatLists=1);

// Adds iSpell (SPELL_*) to oCreature's list of spells
// iClass is the type of class to add the spell for (CLASS_TYPE_*)
// While iSpellLevel does not seem to matter for memorizing and casting the spell (the spell will show up at the right spell level in
// the spellbook, it might potentially cause problems selecting new spells
// If iCharacterLevel is greater than zero, the spell will be added to the Spells Known list for that level
// Only works for spell casting classes that need to select which spells they want to know (Sorcerer, Wizard, Bard)
void PRC_Funcs_AddKnownSpell(object oCreature, int iClass, int iSpellLevel, int iSpell, int iCharacterLevel=0);

// Removes a spell from a creature
// If bRemoveFromLevel is FALSE, the spell will only be removed from the class spell list (the spell lists for each character level are ignored; 
// If bRemoveFromLevel is TRUE, the spell will be removed from the class spell list and from the spell list for the appropriate level
// If found, the spell will be removed from the class spell list whether it exists in a level spell list or not, and vice versa
// Only works for spell casting classes that need to select which spells they want to know (Sorcerer, Wizard, Bard)
void PRC_Funcs_RemoveKnownSpell(object oCreature, int iClass, int iSpell, int bRemoveFromLevel=TRUE);

// Returns TRUE if one of oCreature's classes knows the spell iSpell at a specific spell level
// If iSpellLevel is left at the default value (-1) all of iClass's spell levels are searched for the spell and
// the return value is the spell level +1 at which the spell was found or FALSE if the spell was not found
// Only works for spell casting classes that need to select which spells they want to know (Sorcerer, Wizard, Bard)
int  PRC_Funcs_GetKnowsSpell(object oCreature, int iClass, int iSpell, int iSpellLevel=-1);

// Removes all known spells for a class
// Only works for spell casting classes that need to select which spells they want to know (Sorcerer, Wizard, Bard)
void PRC_Funcs_RemoveAllSpells(object oCreature, int iClass);

// Replaces a spell with another one.
// This will replace all occurences of iOldSpell with iNewSpell (in the ClassList as well as the LevelStatList)
void PRC_Funcs_ReplaceKnownSpell(object oCreature, int iClass, int iOldSpell, int iNewSpell);

// returns a string delimited by sDelimiter of all known spells of a given class and spell level
string PRC_Funcs_GetKnownSpells(object oCreature, int iClass, int iSpellLevel, string sDelimiter=",");

// returns the number of spells known for a given class and spell level
int PRC_Funcs_GetKnownSpellCount(object oCreature, int iClass, int iSpellLevel);

// Retuns the bonus to a saving throw for oCreature
// This is the additional bonus, usually set in the toolset for NPCs, not a bonus from items or effects
int PRC_Funcs_GetSavingThrowBonus(object oCreature, int iSavingThrow = SAVING_THROW_FORT);

// Set the saving throw bonus iSavingThrow of oObject to iValue;
void PRC_Funcs_SetSavingThrowBonus(object oCreature, int iSavingThrow, int iValue);

// Changes the saving throw bonus iSavingThrow of oObject by iValue;
void PRC_Funcs_ModSavingThrowBonus(object oCreature, int iSavingThrow, int iValue);

// Sets the base AC for a given AC type
// Effectively, this is the base AC of the item (armour or shield) worn; or the Natural AC set in the toolset for a creature; ; does not make changes to any items themselves
// Valid values for iACType are:
// AC_ARMOUR_ENCHANTMENT_BONUS (base ac of the armor worn)
// AC_SHIELD_ENCHANTMENT_BONUS (base ac of the shield worn)
// AC_NATURAL_BONUS (base ac of a creature set in the toolset)
void PRC_Funcs_SetBaseAC(object oCreature, int iValue, int iACType = AC_ARMOUR_ENCHANTMENT_BONUS);

// Returns the base AC for a given AC type
// Effectively, this is the base AC of the item (armour or shield) worn; or the Natural AC set in the toolset for a creature
// See NWNXFuncs_SetBaseAC for iACType values
int PRC_Funcs_GetBaseAC(object oCreature, int iACType = AC_ARMOUR_ENCHANTMENT_BONUS);

//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

const int LV_TYPE_INT = 1;
const int LV_TYPE_FLT = 2;
const int LV_TYPE_STR = 3;
const int LV_TYPE_OBJ = 4;
const int LV_TYPE_LOC = 5;

//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

void PRC_Funcs_Init(object oModule)
{
    int iTest = PRC_Funcs_GetHasLocalVariable(oModule, "PRC_VERSION") ? TRUE : FALSE;
    SetLocalInt(oModule, "PRC_NWNX_FUNCS", iTest);
}

int PRC_Funcs_GetHasLocalVariable(object oObject, string sVarName, int iVarType = 0)
{
    SetLocalString(oObject, "NWNX!FUNCS!GETHASLOCALVARIABLE", sVarName+ " " +IntToString(iVarType));
    int iRet = StringToInt(GetLocalString(oObject, "NWNX!FUNCS!GETHASLOCALVARIABLE"));
    DeleteLocalString(oObject, "NWNX!FUNCS!GETHASLOCALVARIABLE");
    return iRet;
}

void PRC_Funcs_SetRace(object oCreature, int iRace)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETRACE", IntToString(iRace));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETRACE");
}

void PRC_Funcs_SetGender(object oCreature, int iGender)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETGENDER", IntToString(iGender));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETGENDER");
}

void PRC_Funcs_SetAge(object oCreature, int iAge)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETAGE", IntToString(iAge));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETAGE");
}

void PRC_Funcs_SetClassByPosition(object oCreature, int iPosition, int iClass)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETCLASSBYPOSITION", IntToString(iPosition)+" "+IntToString(iClass));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETCLASSBYPOSITION");
}

void PRC_Funcs_SetClassByLevel(object oCreature, int iClass, int iLevel)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETCLASSBYLEVEL", IntToString(iClass)+" "+IntToString(iLevel));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETCLASSBYLEVEL");
}

void PRC_Funcs_ReplaceClass(object oCreature, int iOldClass, int iNewClass)
{
    SetLocalString(oCreature, "NWNX!FUNCS!REPLACECLASS", IntToString(iOldClass)+" "+IntToString(iNewClass));
    DeleteLocalString(oCreature, "NWNX!FUNCS!REPLACECLASS");
}

void PRC_Funcs_SetFamiliarType(object oCreature, int iFamiliarType)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETFAMILIARTYPE", IntToString(iFamiliarType));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETFAMILIARTYPE");
}

void PRC_Funcs_SetAnimalCompanion(object oCreature, int iAnimalCompanionType)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETCOMPANIONTYPE", IntToString(iAnimalCompanionType));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETCOMPANIONTYPE");
}

int PRC_Funcs_GetWizardSpecialization(object oCreature)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETWIZARDSPECIALIZATION", "-");
    int iRet = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETWIZARDSPECIALIZATION"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETWIZARDSPECIALIZATION");
    return iRet;
}

void PRC_Funcs_SetWizardSpecialization(object oCreature, int iSpecialization)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETWIZARDSPECIALIZATION", IntToString(iSpecialization));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETWIZARDSPECIALIZATION");
}

int PRC_Funcs_GetDomain(object oCreature, int iDomain_1_2)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETDOMAIN", IntToString(iDomain_1_2));
    int iRet = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETDOMAIN"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETDOMAIN");
    return iRet;
}

void PRC_Funcs_SetDomain(object oCreature, int iDomain_1_2, int iDomain)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETDOMAIN", IntToString(iDomain_1_2)+" "+IntToString(iDomain));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETDOMAIN");
}

int PRC_Funcs_GetSoundSetID(object oCreature)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETSOUNDSETID", "-");
    int ret = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETSOUNDSETID"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETSOUNDSETID");
    return ret;
}

void PRC_Funcs_SetSoundSetID(object oCreature, int iSoundSetID)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETSOUNDSETID", IntToString(iSoundSetID));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETSOUNDSETID");
}

void PRC_Funcs_SetHitPointsByLevel(object oCreature, int iHP, int iLevel)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETHITPOINTSBYLEVEL", IntToString(iHP)+" "+IntToString(iLevel)+" 0");
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETHITPOINTSBYLEVEL");
}

void PRC_Funcs_ModHitPointsByLevel(object oCreature, int iHPMod, int iLevel)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETHITPOINTSBYLEVEL", IntToString(iHPMod)+" "+IntToString(iLevel)+" 1");
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETHITPOINTSBYLEVEL");
}

void NWNXFuncs_SetCurrentHitPoints(object oCreature, int iHP)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETCURRENTHITPOINTS", IntToString(iHP));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETCURRENTHITPOINTS");
}

void NWNXFuncs_SetMaxHitPoints(object oCreature, int iHP)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETMAXHITPOINTS", IntToString(iHP));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETMAXHITPOINTS");
}

void PRC_Funcs_SetSkill(object oCreature, int iSkill, int iValue)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETSKILL", IntToString(iSkill)+" "+IntToString(iValue)+" 0");
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETSKILL");
}

void PRC_Funcs_ModSkill(object oCreature, int iSkill, int iValue)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETSKILL", IntToString(iSkill)+" "+IntToString(iValue)+" 1");
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETSKILL");
}

void PRC_Funcs_SetSkillByLevel(object oCreature, int iSkill, int iValue, int iLevel)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETSKILLBYLEVEL", IntToString(iSkill)+" "+IntToString(iValue)+" "+IntToString(iLevel)+" 0");
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETSKILLBYLEVEL");
}

void PRC_Funcs_ModSkillByLevel(object oCreature, int iSkill, int iValue, int iLevel)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETSKILLBYLEVEL", IntToString(iSkill)+" "+IntToString(iValue)+" "+IntToString(iLevel)+" 1");
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETSKILLBYLEVEL");
}

int PRC_Funcs_GetSavedSkillPoints(object oPC)
{
    SetLocalString(oPC, "NWNX!FUNCS!GETSAVEDSKILLPOINTS", "-");
    int iRet = StringToInt(GetLocalString(oPC, "NWNX!FUNCS!GETSAVEDSKILLPOINTS"));
    DeleteLocalString(oPC, "NWNX!FUNCS!GETSAVEDSKILLPOINTS");
    return iRet;
}

void PRC_Funcs_SetSavedSkillPoints(object oPC, int iSkillPoints)
{
    SetLocalString(oPC, "NWNX!FUNCS!SETSAVEDSKILLPOINTS", IntToString(iSkillPoints)+" 0");
    DeleteLocalString(oPC, "NWNX!FUNCS!SETSAVEDSKILLPOINTS");
}

void PRC_Funcs_ModSavedSkillPoints(object oPC, int iSkillPoints)
{
    SetLocalString(oPC, "NWNX!FUNCS!SETSAVEDSKILLPOINTS", IntToString(iSkillPoints)+" 1");
    DeleteLocalString(oPC, "NWNX!FUNCS!SETSAVEDSKILLPOINTS");
}

void PRC_Funcs_SetAllSkillsToZero(object oCreature)
{
    SetLocalString(oCreature, "NWNX!FUNCS!ZEROALLSKILLS", "-");
    DeleteLocalString(oCreature, "NWNX!FUNCS!ZEROALLSKILLS");
}

void PRC_Funcs_SetAbilityScore(object oCreature, int iAbility, int iValue, int bAdjustCurrentHitPoints)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETABILITYSCORE", IntToString(iAbility)+" "+IntToString(iValue)+ " 0"+ " "+IntToString(bAdjustCurrentHitPoints));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETABILITYSCORE");
}

void PRC_Funcs_ModAbilityScore(object oCreature, int iAbility, int iValue, int bAdjustCurrentHitPoints = 1)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETABILITYSCORE", IntToString(iAbility)+" "+IntToString(iValue)+" 1"+ " "+IntToString(bAdjustCurrentHitPoints));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETABILITYSCORE");
}

int PRC_Funcs_GetFeatCount(object oCreature)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETFEATCOUNT", "     ");
    int iRet = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETFEATCOUNT"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETFEATCOUNT");
    return iRet;
}

void PRC_Funcs_AddFeat(object oCreature, int iFeat, int iLevel=0)
{
    if (!iLevel)
    {
        SetLocalString(oCreature, "NWNX!FUNCS!ADDFEAT", IntToString(iFeat));
        DeleteLocalString(oCreature, "NWNX!FUNCS!ADDFEAT");
    }
    else if(iLevel > 0)
    {
        SetLocalString(oCreature, "NWNX!FUNCS!ADDFEATATLEVEL", IntToString(iLevel)+" "+IntToString(iFeat));
        DeleteLocalString(oCreature, "NWNX!FUNCS!ADDFEATATLEVEL");
    }
}

int PRC_Funcs_RemoveFeat(object oCreature, int iFeat, int bRemoveFromLevel=TRUE)
{
    SetLocalString(oCreature, "NWNX!FUNCS!REMOVEFEAT", IntToString(iFeat)+" "+IntToString(bRemoveFromLevel));
    int iRet = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!REMOVEFEAT"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!REMOVEFEAT");
    return iRet;
}

int PRC_Funcs_GetFeatKnown(object oCreature, int iFeat)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETFEATKNOWN", IntToString(iFeat));
    int iRet = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETFEATKNOWN"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETFEATKNOWN");
    return iRet;
}

string PRC_Funcs_GetAllKnownFeats(object oCreature, string sDelimiter=",")
{
    // reserve enough space for the return string
    // spacer = 256 bytes
    string sSpacer;
    int iCount = PRC_Funcs_GetFeatCount(oCreature);
    iCount = (iCount*5+(iCount-1)*GetStringLength(sDelimiter))+1;
    iCount = iCount / 256 +1;
    for (iCount; iCount>0; iCount--)
    {
        sSpacer += "                                                                                                                                                                                                                                                                ";
    }
    SetLocalString(oCreature, "NWNX!FUNCS!GETALLKNOWNFEATS", sDelimiter+GetStringLeft(sSpacer, GetStringLength(sSpacer)-GetStringLength(sDelimiter)));
    string sRet = GetLocalString(oCreature, "NWNX!FUNCS!GETALLKNOWNFEATS");
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETALLKNOWNFEATS");
    return sRet;
}

void PRC_Funcs_RemoveAllFeats(object oCreature, int bClearLevelFeatLists=1)
{
    SetLocalString(oCreature, "NWNX!FUNCS!CLEARFEATLIST", IntToString(bClearLevelFeatLists));
    DeleteLocalString(oCreature, "NWNX!FUNCS!CLEARFEATLIST");
}

void PRC_Funcs_AddKnownSpell(object oCreature, int iClass, int iSpellLevel, int iSpell, int iCharacterLevel=0)
{
    SetLocalString(oCreature, "NWNX!FUNCS!ADDKNOWNSPELL", IntToString(iClass)+" "+IntToString(iSpellLevel)+" "+IntToString(iSpell)+" "+IntToString(iCharacterLevel));
    DeleteLocalString(oCreature, "NWNX!FUNCS!ADDKNOWNSPELL");
}

void PRC_Funcs_RemoveKnownSpell(object oCreature, int iClass, int iSpell, int bRemoveFromLevel=TRUE)
{
    SetLocalString(oCreature, "NWNX!FUNCS!REMOVEKNOWNSPELL", IntToString(iClass)+" "+IntToString(iSpell)+" "+IntToString(bRemoveFromLevel));
    DeleteLocalString(oCreature, "NWNX!FUNCS!REMOVEKNOWNSPELL");
}

int PRC_Funcs_GetKnowsSpell(object oCreature, int iClass, int iSpell, int iSpellLevel=-1)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETKNOWSSPELL", IntToString(iClass)+" "+IntToString(iSpell)+" "+IntToString(iSpellLevel));
    int iRet = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETKNOWSSPELL"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETKNOWSSPELL");
    return iRet;
}

void PRC_Funcs_RemoveAllSpells(object oCreature, int iClass)
{
    SetLocalString(oCreature, "NWNX!FUNCS!REMOVEALLSPELLS", IntToString(iClass));
    DeleteLocalString(oCreature, "NWNX!FUNCS!REMOVEALLSPELLS");
}

void PRC_Funcs_ReplaceKnownSpell(object oCreature, int iClass, int iOldSpell, int iNewSpell)
{
    SetLocalString(oCreature, "NWNX!FUNCS!REPLACEKNOWNSPELL", IntToString(iClass)+" "+IntToString(iOldSpell)+" "+IntToString(iNewSpell));
    DeleteLocalString(oCreature, "NWNX!FUNCS!REPLACEKNOWNSPELL");
}

string PRC_Funcs_GetKnownSpells(object oCreature, int iClass, int iSpellLevel, string sDelimiter=",")
{
    if (GetStringLength(sDelimiter) > 9) return "-1";
    // reserve enough space for the return string
    // spacer = 256 bytes
    string sSpacer;
    int iCount = PRC_Funcs_GetKnownSpellCount(oCreature, iClass, iSpellLevel);
    iCount = (iCount*5+(iCount-1)*GetStringLength(sDelimiter))+1;
    iCount = iCount / 256 +1;
    for (iCount; iCount>0; iCount--)
    {
        sSpacer += "                                                                                                                                                                                                                                                                ";
    }
    SetLocalString(oCreature, "NWNX!FUNCS!GETKNOWNSPELLS", IntToString(iClass)+" "+IntToString(iSpellLevel)+" "+sDelimiter+" "+sSpacer);
    string sRet = GetLocalString(oCreature, "NWNX!FUNCS!GETKNOWNSPELLS");
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETKNOWNSPELLS");
    return sRet;
}

int PRC_Funcs_GetKnownSpellCount(object oCreature, int iClass, int iSpellLevel)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETKNOWNSPELLCOUNT", IntToString(iClass)+ " " +IntToString(iSpellLevel));
    int iRet = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETKNOWNSPELLCOUNT"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETKNOWNSPELLCOUNT");
    return iRet;
}

int PRC_Funcs_GetSavingThrowBonus(object oCreature, int iSavingThrow = SAVING_THROW_FORT)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETSAVINGTHROWBONUS", IntToString(iSavingThrow));
    int ret = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETSAVINGTHROWBONUS"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETSAVINGTHROWBONUS");
    return ret;
}

void PRC_Funcs_SetSavingThrowBonus(object oCreature, int iSavingThrow, int iValue)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETSAVINGTHROWBONUS", IntToString(iSavingThrow)+" "+IntToString(iValue)+" 0");
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETSAVINGTHROWBONUS");
}

void PRC_Funcs_ModSavingThrowBonus(object oCreature, int iSavingThrow, int iValue)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETSAVINGTHROWBONUS", IntToString(iSavingThrow)+" "+IntToString(iValue)+" 1");
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETSAVINGTHROWBONUS");
}

void PRC_Funcs_SetBaseAC(object oCreature, int iValue, int iACType = AC_ARMOUR_ENCHANTMENT_BONUS)
{
    SetLocalString(oCreature, "NWNX!FUNCS!SETBASEAC", IntToString(iValue)+" "+IntToString(iACType));
    DeleteLocalString(oCreature, "NWNX!FUNCS!SETBASEAC");
}

int PRC_Funcs_GetBaseAC(object oCreature, int iACType = AC_ARMOUR_ENCHANTMENT_BONUS)
{
    SetLocalString(oCreature, "NWNX!FUNCS!GETBASEAC", IntToString(iACType));
    int iRet = StringToInt(GetLocalString(oCreature, "NWNX!FUNCS!GETBASEAC"));
    DeleteLocalString(oCreature, "NWNX!FUNCS!GETBASEAC");
    return iRet;
}
