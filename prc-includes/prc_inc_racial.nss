// Useful includes for dealing with races.

//function prototypes
//use this to get class/race adjusted racial type back to one of the bioware bases
//includes shifter changed forms
int MyPRCGetRacialType(object oCreature);

// DoRacialSLA() moved to prc_inc_core as it is used by other spell-like scripts, not just race specific


#include "prc_class_const"
#include "prc_feat_const"
#include "prc_racial_const"

int MyPRCGetRacialType(object oCreature)
{
    // Shadow Sun Ninja - Ballance of Light and Dark
    if(GetLocalInt(oCreature, "SSN_BALANCE_LD"))
        return RACIAL_TYPE_UNDEAD;
    // Class-based racial type changes
    if (GetLevelByClass(CLASS_TYPE_LICH,oCreature) >= 4)
        return RACIAL_TYPE_UNDEAD;
    if (GetLevelByClass(CLASS_TYPE_MONK,oCreature) >= 20)
        return RACIAL_TYPE_OUTSIDER;
    if (GetLevelByClass(CLASS_TYPE_CONTEMPLATIVE,oCreature) >= 10)
        return RACIAL_TYPE_OUTSIDER;
    if (GetLevelByClass(CLASS_TYPE_ACOLYTE,oCreature) >= 10)
        return RACIAL_TYPE_OUTSIDER;
    if (GetLevelByClass(CLASS_TYPE_OOZEMASTER,oCreature) >= 10)
        return RACIAL_TYPE_OOZE;
    if (GetLevelByClass(CLASS_TYPE_ES_FIRE,oCreature) >= 10)
        return RACIAL_TYPE_ELEMENTAL;
    if (GetLevelByClass(CLASS_TYPE_ES_COLD,oCreature) >= 10)
        return RACIAL_TYPE_ELEMENTAL;
    if (GetLevelByClass(CLASS_TYPE_ES_ELEC,oCreature) >= 10)
        return RACIAL_TYPE_ELEMENTAL;
    if (GetLevelByClass(CLASS_TYPE_ES_ACID,oCreature) >= 10)
        return RACIAL_TYPE_ELEMENTAL;
    if (GetLevelByClass(CLASS_TYPE_DIVESF,oCreature) >= 10)
        return RACIAL_TYPE_ELEMENTAL;
    if (GetLevelByClass(CLASS_TYPE_DIVESC,oCreature) >= 10)
        return RACIAL_TYPE_ELEMENTAL;
    if (GetLevelByClass(CLASS_TYPE_DIVESE,oCreature) >= 10)
        return RACIAL_TYPE_ELEMENTAL;
    if (GetLevelByClass(CLASS_TYPE_DIVESA,oCreature) >= 10)
        return RACIAL_TYPE_ELEMENTAL;
    if (GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oCreature) >= 10)
        return RACIAL_TYPE_DRAGON;
    if (GetLevelByClass(CLASS_TYPE_WEREWOLF,oCreature) >= 10)
        return RACIAL_TYPE_SHAPECHANGER;
    if (GetLevelByClass(CLASS_TYPE_HEARTWARDER,oCreature) >= 10)
        return RACIAL_TYPE_FEY;

    // PRC Shifting Polymorph -caused racial type override. Stored with offset +1 to differentiate value 0 from non-existence
    int nShiftingOverrideRace = GetLocalInt(oCreature, "PRC_ShiftingOverride_Race");
    if(nShiftingOverrideRace)
        return nShiftingOverrideRace - 1;

    // Race pack racial type feats
    if(GetHasFeat(FEAT_OUTSIDER, oCreature))
        return RACIAL_TYPE_OUTSIDER;
    if(GetHasFeat(FEAT_UNDEAD_HD, oCreature))
        return RACIAL_TYPE_UNDEAD;
    if(GetHasFeat(FEAT_ELEMENTAL, oCreature))
        return RACIAL_TYPE_ELEMENTAL;
    if(GetHasFeat(FEAT_LIVING_CONSTRUCT, oCreature))
        return RACIAL_TYPE_CONSTRUCT;
    if(GetHasFeat(FEAT_PLANT, oCreature))
        return RACIAL_TYPE_PLANT;
    if(GetHasFeat(FEAT_ABERRATION, oCreature))
        return RACIAL_TYPE_ABERRATION;
    if(GetHasFeat(FEAT_DRAGON, oCreature))
        return RACIAL_TYPE_DRAGON;
    if(GetHasFeat(FEAT_SHAPECHANGER, oCreature))
        return RACIAL_TYPE_SHAPECHANGER;
    if(GetHasFeat(FEAT_GIANT, oCreature))
        return RACIAL_TYPE_GIANT;
    if(GetHasFeat(FEAT_FEY, oCreature))
        return RACIAL_TYPE_FEY;
    if(GetHasFeat(FEAT_MONSTEROUS, oCreature))
        return RACIAL_TYPE_HUMANOID_MONSTROUS;
    if(GetHasFeat(FEAT_BEAST, oCreature))
        return RACIAL_TYPE_BEAST;
    if(GetHasFeat(FEAT_DWARVEN, oCreature))
        return RACIAL_TYPE_DWARF;
    if(GetHasFeat(FEAT_ELVEN, oCreature))
        return RACIAL_TYPE_ELF;
    if(GetHasFeat(FEAT_GNOMISH, oCreature))
        return RACIAL_TYPE_GNOME;
    if(GetHasFeat(FEAT_HALFLING, oCreature))
        return RACIAL_TYPE_HALFLING;
    if(GetHasFeat(FEAT_ORCISH, oCreature))
        return RACIAL_TYPE_HUMANOID_ORC;
    if(GetHasFeat(FEAT_HUMAN, oCreature))
        return RACIAL_TYPE_HUMAN;
    if(GetHasFeat(FEAT_GOBLINOID, oCreature))
        return RACIAL_TYPE_HUMANOID_GOBLINOID;
    if(GetHasFeat(FEAT_REPTILIAN, oCreature))
        return RACIAL_TYPE_HUMANOID_REPTILIAN;
    if(GetHasFeat(FEAT_VERMIN, oCreature))
        return RACIAL_TYPE_VERMIN;

    return GetRacialType(oCreature);
}
