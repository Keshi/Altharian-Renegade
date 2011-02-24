/**
 *  @file
 *
 * This file contains PRCGetCasterLevel() and all its accessory functions.
 * Functions that modify caster level go in this include. Keep out irrelevent
 * functions. If this ends up like prc_inc_spells, you get slapped.
 */

//////////////////////////////////////////////////
/* Function prototypes                          */
//////////////////////////////////////////////////

/**
 * Returns the caster level when used in spells.  You can use PRCGetCasterLevel()
 * to determine a caster level from within a true spell script.  In spell-like-
 * abilities & items, it will only return GetCasterLevel.
 *
 * @param oCaster   The creature casting the spell.
 *
 * @return          The caster level the spell was cast at.
 */
int PRCGetCasterLevel(object oCaster = OBJECT_SELF);

/**
 * To override for custom spellcasting classes. Looks for the
 * local int "PRC_CASTERCLASS_OVERRIDE" on oCaster. If set,
 * this is used as the casting class, else GetLastSpellCastClass()
 * is used.
 *
 * @param oCaster   The creature that last cast a spell
 *
 * @return          The class used to cast the spell.
 */
int PRCGetLastSpellCastClass(object oCaster = OBJECT_SELF);

/**
 * Returns if the given class is an arcane class.
 *
 * Arcane base classes are *hardcoded* into here, so new arcane
 * base classes need adding to this function.
 * Note: PrCs with their own spellbook eg. assassin count as base casters for this function
 *
 * @param oCaster   The creature to check (outsiders can have sorc caster levels)
 *
 * @return          TRUE if nClass is an arcane spellcasting class, FALSE otherwise
 */
int GetIsArcaneClass(int nClass, object oCaster = OBJECT_SELF);

/**
 * Returns if the given class is an arcane class.
 *
 * Divine base classes are *hardcoded* into here, so new divine
 * base classes need adding to this function.
 * Note: PrCs with their own spellbook eg. blackguard count as base casters for this function
 *
 * @param oCaster   The creature to check (not currently used)
 *
 * @return      TRUE if nClass is a divine spellcasting class, FALSE otherwise
 */
int GetIsDivineClass(int nClass, object oCaster = OBJECT_SELF);

/**
 * Works out the total arcane caster levels from arcane PrCs.
 *
 * Arcane prestige classes are *hardcoded* into this function, so new arcane caster
 * classes need adding to it. Rakshasa RHD count as sorc PrC levels if they also have some levels in sorc
 * note: PrCs with their own spellbook eg. assassin are not PrCs for this function
 *
 * @param oCaster   The creature to check
 *
 * @return          Number of arcane caster levels contributed by PrCs.
 */
int GetArcanePRCLevels(object oCaster);

/**
 * Works out the total divine caster levels from arcane PrCs.
 *
 * Divine prestige classes are *hardcoded* into this function, so new divine caster
 * classes need adding to it.
 * note: PrCs with their own spellbook eg. blackguard are not PrCs for this function
 *
 * @param oCaster   The creature to check
 *
 * @return          Number of divine caster levels contributed by PrCs.
 */
int GetDivinePRCLevels(object oCaster);

/**
 * Gets the position of the first arcane base class.
 *
 * @param oCaster   The creature to check
 *
 * @return          The position (1,2 or 3) of the first arcane *base* class of oCaster
 */
int GetFirstArcaneClassPosition(object oCaster = OBJECT_SELF);

/**
 * Gets the position of the first divine base class.
 *
 * @param oCaster   The creature to check
 *
 * @return          The position (1,2 or 3) of the first divine *base* class of oCaster
 */
int GetFirstDivineClassPosition(object oCaster = OBJECT_SELF);

/**
 * Gets the highest or first (by position) *base* arcane class type or,
 * if oCaster has no arcane class levels, returns CLASS_TYPE_INVALID.
 *
 * This will get rakshasa RHD 'class' if oCaster doesn't have sorc levels.
 *
 * @param oCaster   The creature to check
 *
 * @return          CLASS_TYPE_* of first base arcane class or CLASS_TYPE_INVALID
 */
int GetPrimaryArcaneClass(object oCaster = OBJECT_SELF);

/**
 * Gets the highest first (by position) *base* divine class type or,
 * if oCaster has no divine class levels, returns CLASS_TYPE_INVALID.
 *
 * @param oCaster   The creature to check
 *
 * @return          CLASS_TYPE_* of first base divine class or CLASS_TYPE_INVALID
 */
int GetPrimaryDivineClass(object oCaster = OBJECT_SELF);

/**
 * Gets the caster level adjustment from the Practiced Spellcaster feats.
 *
 * @param oCaster           The creature to check
 * @param iCastingClass     The CLASS_TYPE* that the spell was cast by.
 * @param iCastingLevels    The caster level for the spell calculated so far
 *                          ie. BEFORE Practiced Spellcaster.
 */
int PracticedSpellcasting(object oCaster, int iCastingClass, int iCastingLevels);

/**
 * Returns the spell school of the spell passed to it.
 *
 * @param iSpellId  The spell to get the school of.
 *
 * @return          The SPELL_SCHOOL_* of the spell.
 */
int GetSpellSchool(int iSpellId);

/**
 * Healing spell filter.
 *
 * Gets if the given spell is a healing spell based on a hardcoded list. New
 * healing spells need to be added to this.
 *
 * @author          GaiaWerewolf
 * @date            18 July 2005
 *
 * @param nSpellId  The spell to check
 *
 * @return          TRUE if it is a healing spell, FALSE otherwise.
 */
int GetIsHealingSpell(int nSpellId);

/**
 * Gets the contribution of the archmage's High Arcana Spell Power
 * feat to caster level.
 *
 * @param oCaster   The creature to check
 *
 * @return          caster level modifier from archmage Spell Power feats.
 */
int ArchmageSpellPower(object oCaster);

/**
 * Gets the caster level modifier to necromancy spells for the
 * True Necromancer PrC (all spellcasting levels are counted, both
 * arcane and divine).
 *
 * @param oCaster       The creature to check
 * @param iSpellID      The spell ID of the spell
 * @param sType         "ARCANE" or "DIVINE" spell
 * @param nSpellSchool  The spell school the cast spell is from
 *                      if none is specified, uses GetSpellSchool()
 *
 * @return              caster level modifier for True Necro
 */
int TrueNecromancy(object oCaster, int iSpellID, string sType, int nSpellSchool = -1);

/**
 * Gets the caster level modifier from the Shadow Weave feat.
 *
 * Schools of Enchantment, Illusion, and Necromancy, and spells with the darkness
 * descriptor altered by +1, Evocation or Transmutation (except spells with the
 * darkness descriptor) altered by -1.
 *
 * @param oCaster       The creature to check
 * @param iSpellID      The spell ID of the spell
 * @param nSpellSchool  The spell school the cast spell is from
 *                      if none is specified, uses GetSpellSchool()
 *
 * @return              caster level modifier for Shadow Weave feat.
 */
int ShadowWeave(object oCaster, int iSpellID, int nSpellSchool = -1);

/**
 * Handles feats that modify caster level of spells with the fire
 * descriptor.
 *
 * Currently this is Disciple of Meph's Fire Adept feat and Bloodline of Fire feat.
 *
 * @param oCaster       The creature to check
 * @param iSpellID      The spell ID of the spell
 *
 * @return              Caster level modifier for fire related feats.
 */
int FireAdept(object oCaster, int iSpellID);

/**
 * Gets the caster level modifier from the Storm Magic feat.
 *
 * Get +1 caster level if raining or snowing in area
 *
 * @param oCaster       The creature to check
 *
 * @return              Caster level modifier for Storm Magic feat.
 */
int StormMagic(object oCaster);

/**
 * Gets the caster level modifier from the Cormanthyran Moon Magic feat.
 *
 * Get +1 caster level if outdoors, at night, with no rain.
 *
 * @param oCaster       The creature to check
 *
 * @return              Caster level modifier for Cormanthyran Moon Magic feat.
 */
int CormanthyranMoonMagic(object oCaster);

/**
 * Gets the caster level modifier from various domains.
 *
 * @param oCaster       The creature to check
 * @param nSpellID      The spell ID of the spell
 * @param nSpellSchool  The spell school the cast spell is from
 *                      if none is specified, uses GetSpellSchool()
 *
 * @return              caster level modifier from domain powers
 */
int DomainPower(object oCaster, int nSpellID, int nSpellSchool = -1);

/**
 * Gets the caster level modifier from the antipaladin's Death Knell SLA.
 *
 * @param oCaster       The creature to check
 *
 * @return              caster level modifier from the Death Knell SLA
 */
int DeathKnell(object oCaster);

/**
 * Gets the caster level modifier from the Draconic Power feat.
 *
 * Feat gives +1 to caster level.
 *
 * @param oCaster       The creature to check
 *
 * @return              caster level modifier from the Draconic power feat.
 */
int DraconicPower(object oCaster = OBJECT_SELF);

/**
 * Gets the caster level modifier from Song of Arcane Power effect.
 *
 * @param oCaster       The creature to check
 *
 * @return              caster level modifier from the Draconic power feat.
 */
int SongOfArcanePower(object oCaster = OBJECT_SELF);

//////////////////////////////////////////////////
/* Include section                              */
//////////////////////////////////////////////////

//#include "prc_racial_const"
// Not needed as it has acccess via prc_inc_newip
//#include "prc_inc_nwscript" // gets inc_2da_cache, inc_debug, prc_inc_switch
#include "prc_inc_newip"
//#include "prc_inc_spells"
#include "prc_inc_descrptr"

//////////////////////////////////////////////////
/* Internal functions                           */
//////////////////////////////////////////////////

// stolen from prcsp_archmaginc.nss, modified to work in FireAdept() function
string _GetChangedElementalType(int nSpellID, object oCaster = OBJECT_SELF)
{
    string spellType = Get2DACache("spells", "ImmunityType", nSpellID);//lookup_spell_type(spell_id);
    string sType = GetLocalString(oCaster, "archmage_mastery_elements_name");

    if (sType == "") sType = spellType;

    return sType;
}

//////////////////////////////////////////////////
/* Function Definitions                         */
//////////////////////////////////////////////////

int PRCGetCasterLevel(object oCaster = OBJECT_SELF)
{
    int nAdjust = GetLocalInt(oCaster, PRC_CASTERLEVEL_ADJUSTMENT);//this is for builder use
    nAdjust += GetLocalInt(oCaster, "TrueCasterLens");

    // For when you want to assign the caster level.
    int iReturnLevel = GetLocalInt(oCaster, PRC_CASTERLEVEL_OVERRIDE);
    if (iReturnLevel)
    {
        if (DEBUG) DoDebug("PRCGetCasterLevel: found override caster level = "+IntToString(iReturnLevel)+" with adjustment = " + IntToString(nAdjust)+", original level = "+IntToString(GetCasterLevel(oCaster)));
        return iReturnLevel+nAdjust;
    }

    // if we made it here, iReturnLevel = 0;

    int iCastingClass = PRCGetLastSpellCastClass(oCaster); // might be CLASS_TYPE_INVALID
    if(iCastingClass == CLASS_TYPE_SUBLIME_CHORD)
        iCastingClass = GetPrimaryArcaneClass(oCaster);
    int iSpellId = PRCGetSpellId(oCaster);
    object oItem = PRCGetSpellCastItem(oCaster);

    // Item Spells
    // this check is unreliable because of Bioware's implementation (GetSpellCastItem returns
    // the last object from which a spell was cast, even if we are not casting from an item)
    if (GetIsObjectValid(oItem))
    {
        if (DEBUG) DoDebug("PRCGetCasterLevel: found valid item = "+GetName(oItem));
        // double check, just to make sure
        if (GetItemPossessor(oItem) == oCaster) // likely item casting
        {
            if(GetPRCSwitch(PRC_STAFF_CASTER_LEVEL)
                && ((GetBaseItemType(oItem) == BASE_ITEM_MAGICSTAFF) ||
                    (GetBaseItemType(oItem) == BASE_ITEM_CRAFTED_STAFF))
                )
            {
                iCastingClass = GetPrimaryArcaneClass(oCaster);//sets it to an arcane class
            }
            else
            {
                //code for getting new ip type
                itemproperty ipTest = GetFirstItemProperty(oItem);
                while(GetIsItemPropertyValid(ipTest))
                {
                    if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_CAST_SPELL_CASTER_LEVEL)
                    {
                        int nSubType = GetItemPropertySubType(ipTest);
                        nSubType = StringToInt(Get2DACache("iprp_spells", "SpellIndex", nSubType));
                        if(nSubType == iSpellId)
                        {
                            iReturnLevel = GetItemPropertyCostTableValue (ipTest);
                            if (DEBUG) DoDebug("PRCGetCasterLevel: caster level from item = "+IntToString(iReturnLevel));
                            break; // exit the while loop
                        }
                    }
                    ipTest = GetNextItemProperty(oItem);
                }
                // if we didn't find a caster level on the item, it must be Bioware item casting
                if (!iReturnLevel)
                {
                    iReturnLevel = GetCasterLevel(oCaster);
                    if (DEBUG) DoDebug("PRCGetCasterLevel: bioware item casting with caster level = "+IntToString(iReturnLevel));
                }
            }
        }
    }

    // no item casting, and arcane caster?
    if (!iReturnLevel && GetIsArcaneClass(iCastingClass, oCaster))
    {
        iReturnLevel = GetLevelByClass(iCastingClass, oCaster);
        if (GetPrimaryArcaneClass(oCaster) == iCastingClass)
        {
            iReturnLevel += GetArcanePRCLevels(oCaster)
                +  ArchmageSpellPower(oCaster);
        }
        if (iCastingClass == CLASS_TYPE_HEXBLADE)
            iReturnLevel = iReturnLevel / 2; // note you cannot be an archmage *and* a 1/2 base caster so this is ok
        // get spell school here as many of the following fns use it
        int nSpellSchool = GetSpellSchool(iSpellId);

        //Spell Rage ability
        if(GetHasSpellEffect(SPELL_SPELL_RAGE, oCaster) &&
        (nSpellSchool == SPELL_SCHOOL_ABJURATION ||
         nSpellSchool == SPELL_SCHOOL_CONJURATION ||
         nSpellSchool == SPELL_SCHOOL_EVOCATION ||
         nSpellSchool == SPELL_SCHOOL_NECROMANCY ||
         nSpellSchool == SPELL_SCHOOL_TRANSMUTATION))
            iReturnLevel = GetHitDice(oCaster);

        iReturnLevel += TrueNecromancy(oCaster, iSpellId, "ARCANE", nSpellSchool)
            +  ShadowWeave(oCaster, iSpellId)
            +  FireAdept(oCaster, iSpellId)
            +  StormMagic(oCaster)
            +  CormanthyranMoonMagic(oCaster)
            +  DomainPower(oCaster, iSpellId)
            +  DeathKnell(oCaster)
            +  DraconicPower(oCaster)
            +  SongOfArcanePower(oCaster);

        // Get stance level bonus for Jade Phoenix Mage
        if(GetLevelByClass(CLASS_TYPE_JADE_PHOENIX_MAGE, oCaster))
        {
            if (_GetChangedElementalType(iSpellId, oCaster) == "Fire" && GetLocalInt(oCaster, "ToB_JPM_FireB"))
                iReturnLevel += 3;
            iReturnLevel += GetLocalInt(oCaster, "ToB_JPM_MystP");
        }

        iReturnLevel += PracticedSpellcasting(oCaster, iCastingClass, iReturnLevel); //gotta be the last one
    }
    // no item casting and divine caster?
    else if(GetIsDivineClass(iCastingClass, oCaster))
    {
        iReturnLevel = GetLevelByClass(iCastingClass, oCaster);
        if (GetPrimaryDivineClass(oCaster) == iCastingClass)
            iReturnLevel += GetDivinePRCLevels(oCaster);
        if (iCastingClass == CLASS_TYPE_RANGER
            || iCastingClass == CLASS_TYPE_PALADIN
            || iCastingClass == CLASS_TYPE_ANTI_PALADIN)
            iReturnLevel = iReturnLevel / 2;
        // get spell school here as many of the following fns use it
        int nSpellSchool = GetSpellSchool(iSpellId);
        iReturnLevel += TrueNecromancy(oCaster, iSpellId, "DIVINE", nSpellSchool)
            +  ShadowWeave(oCaster, iSpellId)
            +  FireAdept(oCaster, iSpellId)
            +  StormMagic(oCaster)
            +  CormanthyranMoonMagic(oCaster)
            +  DomainPower(oCaster, iSpellId)
            +  DeathKnell(oCaster);
        iReturnLevel += PracticedSpellcasting(oCaster, iCastingClass, iReturnLevel); //gotta be the last one
    }

    //at this point it must be a SLA or similar
    if(!iReturnLevel)
    {
        iReturnLevel = GetCasterLevel(oCaster);
        if (DEBUG) DoDebug("PRCGetCasterLevel: bioware caster level = "+IntToString(iReturnLevel));
    }

    iReturnLevel += nAdjust;

    //Adds 1 to caster level
    if(GetHasSpellEffect(SPELL_VIRTUOSO_MAGICAL_MELODY, oCaster))
        iReturnLevel++;

    return iReturnLevel;
}

int PRCGetLastSpellCastClass(object oCaster = OBJECT_SELF)
{
    // note that a barbarian has a class type constant of zero. So nClass == 0 could in principle mean
    // that a barbarian cast the spell, However, barbarians cannot cast spells, so it doesn't really matter
    // beware of Barbarians with UMD, though. Also watch out for spell like abilities
    // might have to provide a fix for these (for instance: if(nClass == -1) nClass = 0;
    int nClass = GetLocalInt(oCaster, PRC_CASTERCLASS_OVERRIDE);
    if(nClass)
    {
        if(DEBUG) DoDebug("PRCGetLastSpellCastClass: found override caster class = "+IntToString(nClass)+", original class = "+IntToString(GetLastSpellCastClass()));
        return nClass;
    }
    nClass = GetLastSpellCastClass();
    //if casting class is invalid and the spell was not cast form an item it was probably cast from the new spellbook
    int NSB_Class = GetLocalInt(oCaster, "NSB_Class");
    if(nClass == CLASS_TYPE_INVALID && GetSpellCastItem() == OBJECT_INVALID && NSB_Class)
        nClass = NSB_Class;
    return nClass;
}

int GetIsArcaneClass(int nClass, object oCaster = OBJECT_SELF)
{
    return (nClass==CLASS_TYPE_WIZARD ||
            nClass==CLASS_TYPE_SORCERER ||
            nClass==CLASS_TYPE_BARD ||
            nClass==CLASS_TYPE_ASSASSIN ||
            nClass==CLASS_TYPE_SUEL_ARCHANAMACH ||
            nClass==CLASS_TYPE_SHADOWLORD ||
            nClass==CLASS_TYPE_HEXBLADE ||
            nClass==CLASS_TYPE_DUSKBLADE ||
            nClass==CLASS_TYPE_WARMAGE ||
            nClass==CLASS_TYPE_DREAD_NECROMANCER ||
            nClass==CLASS_TYPE_WITCH ||
            nClass==CLASS_TYPE_BEGUILER ||
            nClass==CLASS_TYPE_HARPER ||
            nClass==CLASS_TYPE_SUBLIME_CHORD ||
            (nClass==CLASS_TYPE_OUTSIDER
                && GetRacialType(oCaster)==RACIAL_TYPE_RAKSHASA
                && !GetLevelByClass(CLASS_TYPE_SORCERER)) ||
            (nClass==CLASS_TYPE_ABERRATION
                && GetRacialType(oCaster)==RACIAL_TYPE_DRIDER
                && !GetLevelByClass(CLASS_TYPE_SORCERER)) ||
            (nClass==CLASS_TYPE_DRAGON
                && GetRacialType(oCaster)==RACIAL_TYPE_BOZAK
                && !GetLevelByClass(CLASS_TYPE_SORCERER))
            );
}

int GetIsDivineClass(int nClass, object oCaster = OBJECT_SELF)
{
    return (nClass==CLASS_TYPE_ANTI_PALADIN ||
            nClass==CLASS_TYPE_ARCHIVIST ||
            nClass==CLASS_TYPE_BLACKGUARD ||
            nClass==CLASS_TYPE_CLERIC ||
            nClass==CLASS_TYPE_DRUID ||
            nClass==CLASS_TYPE_FAVOURED_SOUL ||
            nClass==CLASS_TYPE_HEALER ||
            nClass==CLASS_TYPE_JUSTICEWW ||
            nClass==CLASS_TYPE_KNIGHT_CHALICE ||
            nClass==CLASS_TYPE_KNIGHT_MIDDLECIRCLE ||
            nClass==CLASS_TYPE_MYSTIC ||
            nClass==CLASS_TYPE_OCULAR ||
            nClass==CLASS_TYPE_PALADIN ||
            nClass==CLASS_TYPE_RANGER ||
            nClass==CLASS_TYPE_SHAMAN ||
            nClass==CLASS_TYPE_SLAYER_OF_DOMIEL ||
            nClass==CLASS_TYPE_SOHEI ||
            nClass==CLASS_TYPE_SOLDIER_OF_LIGHT ||
            nClass==CLASS_TYPE_VASSAL ||
            nClass==CLASS_TYPE_VIGILANT);
}

int GetArcanePRCLevels(object oCaster)
{
   int nArcane;
   int nOozeMLevel  = GetLevelByClass(CLASS_TYPE_OOZEMASTER, oCaster);
   int nFirstClass  = GetClassByPosition(1, oCaster);
   int nSecondClass = GetClassByPosition(2, oCaster);
   int nThirdClass  = GetClassByPosition(3, oCaster);

   nArcane += GetLevelByClass(CLASS_TYPE_ALIENIST,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_ARCHMAGE,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_ARCTRICK,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_CEREBREMANCER,   oCaster)
           +  GetLevelByClass(CLASS_TYPE_DIABOLIST,       oCaster)
           +  GetLevelByClass(CLASS_TYPE_DRAGONHEART_MAGE, oCaster)
           +  GetLevelByClass(CLASS_TYPE_ELDRITCH_KNIGHT, oCaster)
           +  GetLevelByClass(CLASS_TYPE_ES_ACID,         oCaster)
           +  GetLevelByClass(CLASS_TYPE_ES_COLD,         oCaster)
           +  GetLevelByClass(CLASS_TYPE_ES_ELEC,         oCaster)
           +  GetLevelByClass(CLASS_TYPE_ES_FIRE,         oCaster)
           +  GetLevelByClass(CLASS_TYPE_HARPERMAGE,      oCaster)
           +  GetLevelByClass(CLASS_TYPE_JADE_PHOENIX_MAGE, oCaster)
           +  GetLevelByClass(CLASS_TYPE_MAGEKILLER,      oCaster)
           +  GetLevelByClass(CLASS_TYPE_MASTER_HARPER,   oCaster)
           +  GetLevelByClass(CLASS_TYPE_MYSTIC_THEURGE,  oCaster)
           +  GetLevelByClass(CLASS_TYPE_TRUENECRO,       oCaster)
           +  GetLevelByClass(CLASS_TYPE_RED_WIZARD,      oCaster)
           +  GetLevelByClass(CLASS_TYPE_SHADOW_ADEPT,    oCaster)
           +  GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD,   oCaster)
           +  GetLevelByClass(CLASS_TYPE_VIRTUOSO,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_WAR_WIZARD_OF_CORMYR, oCaster)

           +  (GetLevelByClass(CLASS_TYPE_BLADESINGER,        oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_BONDED_SUMMONNER,   oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_PALEMASTER,         oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_HATHRAN,            oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_SPELLSWORD,         oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_THRALL_OF_GRAZZT_A, oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_TALON_OF_TIAMAT,    oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_RAGE_MAGE,          oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_JUDICATOR, oCaster) + 1) / 3;

    //The following changes are to prevent a mage/invoker from gaining bonus caster levels in both base classes.

    if(GetLocalInt(oCaster, "INV_Caster") == 1 ||
            (!GetLevelByClass(CLASS_TYPE_WARLOCK, oCaster) && !GetLevelByClass(CLASS_TYPE_DRAGONFIRE_ADEPT, oCaster)))
        nArcane += (GetLevelByClass(CLASS_TYPE_ACOLYTE,              oCaster) + 1) / 2
                +  (GetLevelByClass(CLASS_TYPE_DISCIPLE_OF_ASMODEUS, oCaster) + 1) / 2
                +   GetLevelByClass(CLASS_TYPE_ENLIGHTENEDFIST,      oCaster)
                +   GetLevelByClass(CLASS_TYPE_MAESTER,              oCaster);


    /* oozemaster levels count towards arcane caster level if:
     *
     * first class slot is arcane OR
     * first class slot is NOT divine AND second class slot is arcane OR
     * first AND second class slot is NOT divine AND 3rd class slot is arcane
     */
   if (nOozeMLevel)
   {
       if (GetIsArcaneClass(nFirstClass, oCaster)
           || (!GetIsDivineClass(nFirstClass, oCaster)
                && GetIsArcaneClass(nSecondClass, oCaster))
           || (!GetIsDivineClass(nFirstClass, oCaster)
                && !GetIsDivineClass(nSecondClass, oCaster)
                && GetIsArcaneClass(nThirdClass, oCaster)))
           nArcane += nOozeMLevel / 2;
   }
    //Rakshasa include outsider HD as sorc
    //if they have sorcerer levels, then it counts as a prestige class
    //otherwise its used instead of sorc levels
    if(GetLevelByClass(CLASS_TYPE_SORCERER, oCaster)
        && GetRacialType(oCaster) == RACIAL_TYPE_RAKSHASA)
        nArcane += GetLevelByClass(CLASS_TYPE_OUTSIDER);

    //Driders include aberration HD as sorc
    //if they have sorcerer levels, then it counts as a prestige class
    //otherwise its used instead of sorc levels
    if(GetLevelByClass(CLASS_TYPE_SORCERER, oCaster)
        && GetRacialType(oCaster) == RACIAL_TYPE_DRIDER)
        nArcane += GetLevelByClass(CLASS_TYPE_ABERRATION);

    //Bozaks include dragon HD as sorc
    //if they have sorcerer levels, then it counts as a prestige class
    //otherwise its used instead of sorc levels
    if(GetLevelByClass(CLASS_TYPE_SORCERER, oCaster)
        && GetRacialType(oCaster) == RACIAL_TYPE_BOZAK)
        nArcane += GetLevelByClass(CLASS_TYPE_DRAGON);

   return nArcane;
}

int GetDivinePRCLevels(object oCaster)
{
   int nDivine;
   int nOozeMLevel = GetLevelByClass(CLASS_TYPE_OOZEMASTER, oCaster);
   int nFirstClass = GetClassByPosition(1, oCaster);
   int nSecondClass = GetClassByPosition(2, oCaster);
   int nThirdClass = GetClassByPosition(3, oCaster);

   // This section accounts for full progression classes
   nDivine += GetLevelByClass(CLASS_TYPE_DIVESA,            oCaster)
           +  GetLevelByClass(CLASS_TYPE_DIVESC,            oCaster)
           +  GetLevelByClass(CLASS_TYPE_DIVESE,            oCaster)
           +  GetLevelByClass(CLASS_TYPE_DIVESF,            oCaster)
           +  GetLevelByClass(CLASS_TYPE_FISTRAZIEL,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_HEARTWARDER,       oCaster)
           +  GetLevelByClass(CLASS_TYPE_HIEROPHANT,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_HOSPITALER,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_MASTER_OF_SHROUDS, oCaster)
           +  GetLevelByClass(CLASS_TYPE_MYSTIC_THEURGE,    oCaster)
           +  GetLevelByClass(CLASS_TYPE_STORMLORD,         oCaster)
           +  GetLevelByClass(CLASS_TYPE_MASTER_HARPER_DIV, oCaster)
           +  GetLevelByClass(CLASS_TYPE_PSYCHIC_THEURGE,   oCaster)
           +  GetLevelByClass(CLASS_TYPE_ALAGHAR,           oCaster)
           +  GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC,      oCaster)
           +  GetLevelByClass(CLASS_TYPE_BLIGHTLORD,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_CONTEMPLATIVE,     oCaster)
           +  GetLevelByClass(CLASS_TYPE_RUBY_VINDICATOR,   oCaster)
           +  GetLevelByClass(CLASS_TYPE_RUNECASTER,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_SWIFT_WING,        oCaster)
           +  GetLevelByClass(CLASS_TYPE_MORNINGLORD,       oCaster)
           +  GetLevelByClass(CLASS_TYPE_FAVORED_MILIL,     oCaster)

           +  (GetLevelByClass(CLASS_TYPE_OLLAM,                 oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_BRIMSTONE_SPEAKER,     oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_TEMPUS,                oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_HATHRAN,               oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_BFZ,                   oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_ORCUS,                 oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_SHINING_BLADE,         oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_WARPRIEST,             oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_THRALL_OF_GRAZZT_D,    oCaster) + 1) / 2
           +  (GetLevelByClass(CLASS_TYPE_MIGHTY_CONTENDER_KORD, oCaster) + 1) / 2

           +  (GetLevelByClass(CLASS_TYPE_JUDICATOR, oCaster) + 1) / 3;

   if (!GetHasFeat(FEAT_SF_CODE, oCaster))
   {
       nDivine   += GetLevelByClass(CLASS_TYPE_SACREDFIST, oCaster);
   }

   if (nOozeMLevel)
   {
       if (GetIsDivineClass(nFirstClass, oCaster)
           || (!GetIsArcaneClass(nFirstClass, oCaster)
                && GetIsDivineClass(nSecondClass, oCaster))
           || (!GetIsArcaneClass(nFirstClass, oCaster)
                && !GetIsArcaneClass(nSecondClass, oCaster)
                && GetIsDivineClass(nThirdClass, oCaster)))
           nDivine += nOozeMLevel / 2;
   }

   return nDivine;
}

int GetFirstArcaneClassPosition(object oCaster = OBJECT_SELF)
{
    if (GetIsArcaneClass(GetClassByPosition(1, oCaster), oCaster))
        return 1;
    if (GetIsArcaneClass(GetClassByPosition(2, oCaster), oCaster))
        return 2;
    if (GetIsArcaneClass(GetClassByPosition(3, oCaster), oCaster))
        return 3;

    return 0;
}

int GetFirstDivineClassPosition(object oCaster = OBJECT_SELF)
{
    if (GetIsDivineClass(GetClassByPosition(1, oCaster), oCaster))
        return 1;
    if (GetIsDivineClass(GetClassByPosition(2, oCaster), oCaster))
        return 2;
    if (GetIsDivineClass(GetClassByPosition(3, oCaster), oCaster))
        return 3;

    return 0;
}

int GetPrimaryArcaneClass(object oCaster = OBJECT_SELF)
{
    int nClass;

    if(GetPRCSwitch(PRC_CASTERLEVEL_FIRST_CLASS_RULE))
    {
        int iArcanePos = GetFirstArcaneClassPosition(oCaster);
        if (!iArcanePos) return CLASS_TYPE_INVALID; // no arcane casting class

        nClass = GetClassByPosition(iArcanePos, oCaster);
    }
    else
    {
        int nClassLvl;
        int nClass1, nClass2, nClass3;
        int nClass1Lvl, nClass2Lvl, nClass3Lvl;

        nClass1 = GetClassByPosition(1, oCaster);
        nClass2 = GetClassByPosition(2, oCaster);
        nClass3 = GetClassByPosition(3, oCaster);
        if(GetIsArcaneClass(nClass1, oCaster) && nClass1 != CLASS_TYPE_SUBLIME_CHORD) nClass1Lvl = GetLevelByClass(nClass1, oCaster);
        if(GetIsArcaneClass(nClass2, oCaster) && nClass2 != CLASS_TYPE_SUBLIME_CHORD) nClass2Lvl = GetLevelByClass(nClass2, oCaster);
        if(GetIsArcaneClass(nClass3, oCaster) && nClass3 != CLASS_TYPE_SUBLIME_CHORD) nClass3Lvl = GetLevelByClass(nClass3, oCaster);

        nClass = nClass1;
        nClassLvl = nClass1Lvl;
        if(nClass2Lvl > nClassLvl)
        {
            nClass = nClass2;
            nClassLvl = nClass2Lvl;
        }
        if(nClass3Lvl > nClassLvl)
        {
            nClass = nClass3;
            nClassLvl = nClass3Lvl;
        }
        if(nClassLvl == 0)
            nClass = CLASS_TYPE_INVALID;
    }

    //raks cast as sorcs
    if(nClass == CLASS_TYPE_OUTSIDER
        && GetRacialType(oCaster) == RACIAL_TYPE_RAKSHASA
        && !GetLevelByClass(CLASS_TYPE_SORCERER))
        nClass = CLASS_TYPE_SORCERER;
    //driders cast as sorcs
    if(nClass == CLASS_TYPE_ABERRATION
        && GetRacialType(oCaster) == RACIAL_TYPE_DRIDER
        && !GetLevelByClass(CLASS_TYPE_SORCERER))
        nClass = CLASS_TYPE_SORCERER;
    //dragons cast as sorcs
    if(nClass == CLASS_TYPE_DRAGON
        && GetRacialType(oCaster) == RACIAL_TYPE_BOZAK
        && !GetLevelByClass(CLASS_TYPE_SORCERER))
        nClass = CLASS_TYPE_SORCERER;

    return nClass;
}

int GetPrimaryDivineClass(object oCaster = OBJECT_SELF)
{
    int nClass;

    if(GetPRCSwitch(PRC_CASTERLEVEL_FIRST_CLASS_RULE))
    {
        int iDivinePos = GetFirstDivineClassPosition(oCaster);
        if (!iDivinePos) return CLASS_TYPE_INVALID; // no Divine casting class

        nClass = GetClassByPosition(iDivinePos, oCaster);
    }
    else
    {
        int nClassLvl;
        int nClass1, nClass2, nClass3;
        int nClass1Lvl, nClass2Lvl, nClass3Lvl;

        nClass1 = GetClassByPosition(1, oCaster);
        nClass2 = GetClassByPosition(2, oCaster);
        nClass3 = GetClassByPosition(3, oCaster);
        if(GetIsDivineClass(nClass1, oCaster)) nClass1Lvl = GetLevelByClass(nClass1, oCaster);
        if(GetIsDivineClass(nClass2, oCaster)) nClass2Lvl = GetLevelByClass(nClass2, oCaster);
        if(GetIsDivineClass(nClass3, oCaster)) nClass3Lvl = GetLevelByClass(nClass3, oCaster);

        nClass = nClass1;
        nClassLvl = nClass1Lvl;
        if(nClass2Lvl > nClassLvl)
        {
            nClass = nClass2;
            nClassLvl = nClass2Lvl;
        }
        if(nClass3Lvl > nClassLvl)
        {
            nClass = nClass3;
            nClassLvl = nClass3Lvl;
        }
        if(nClassLvl == 0)
            nClass = CLASS_TYPE_INVALID;
    }

    return nClass;
}

int PracticedSpellcasting(object oCaster, int iCastingClass, int iCastingLevels)
{
    int nFeat;
    int iAdjustment = GetHitDice(oCaster) - iCastingLevels;
    if (iAdjustment > 4) iAdjustment = 4;
    if (iAdjustment < 0) iAdjustment = 0;

    switch(iCastingClass)
    {
        case CLASS_TYPE_BARD:                nFeat = FEAT_PRACTICED_SPELLCASTER_BARD;                break;
        case CLASS_TYPE_SORCERER:            nFeat = FEAT_PRACTICED_SPELLCASTER_SORCERER;            break;
        case CLASS_TYPE_WIZARD:              nFeat = FEAT_PRACTICED_SPELLCASTER_WIZARD;              break;
        case CLASS_TYPE_CLERIC:              nFeat = FEAT_PRACTICED_SPELLCASTER_CLERIC;              break;
        case CLASS_TYPE_DRUID:               nFeat = FEAT_PRACTICED_SPELLCASTER_DRUID;               break;
        case CLASS_TYPE_PALADIN:             nFeat = FEAT_PRACTICED_SPELLCASTER_PALADIN;             break;
        case CLASS_TYPE_RANGER:              nFeat = FEAT_PRACTICED_SPELLCASTER_RANGER;              break;
        case CLASS_TYPE_ASSASSIN:            nFeat = FEAT_PRACTICED_SPELLCASTER_ASSASSIN;            break;
        case CLASS_TYPE_BLACKGUARD:          nFeat = FEAT_PRACTICED_SPELLCASTER_BLACKGUARD;          break;
        case CLASS_TYPE_OCULAR:              nFeat = FEAT_PRACTICED_SPELLCASTER_OCULAR;              break;
        case CLASS_TYPE_HEXBLADE:            nFeat = FEAT_PRACTICED_SPELLCASTER_HEXBLADE;            break;
        case CLASS_TYPE_DUSKBLADE:           nFeat = FEAT_PRACTICED_SPELLCASTER_DUSKBLADE;           break;
        case CLASS_TYPE_HEALER:              nFeat = FEAT_PRACTICED_SPELLCASTER_HEALER;              break;
        case CLASS_TYPE_KNIGHT_CHALICE:      nFeat = FEAT_PRACTICED_SPELLCASTER_KNIGHT_CHALICE;      break;
        case CLASS_TYPE_VIGILANT:            nFeat = FEAT_PRACTICED_SPELLCASTER_VIGILANT;            break;
        case CLASS_TYPE_VASSAL:              nFeat = FEAT_PRACTICED_SPELLCASTER_VASSAL;              break;
        case CLASS_TYPE_ANTI_PALADIN:        nFeat = FEAT_PRACTICED_SPELLCASTER_ANTI_PALADIN;        break;
        case CLASS_TYPE_SOLDIER_OF_LIGHT:    nFeat = FEAT_PRACTICED_SPELLCASTER_SOLDIER_OF_LIGHT;    break;
        case CLASS_TYPE_SHADOWLORD:          nFeat = FEAT_PRACTICED_SPELLCASTER_SHADOWLORD;          break;
        case CLASS_TYPE_JUSTICEWW:           nFeat = FEAT_PRACTICED_SPELLCASTER_JUSTICEWW;           break;
        case CLASS_TYPE_KNIGHT_MIDDLECIRCLE: nFeat = FEAT_PRACTICED_SPELLCASTER_KNIGHT_MIDDLECIRCLE; break;
        case CLASS_TYPE_SHAMAN:              nFeat = FEAT_PRACTICED_SPELLCASTER_SHAMAN;              break;
        case CLASS_TYPE_SLAYER_OF_DOMIEL:    nFeat = FEAT_PRACTICED_SPELLCASTER_SLAYER_OF_DOMIEL;    break;
        case CLASS_TYPE_SUEL_ARCHANAMACH:    nFeat = FEAT_PRACTICED_SPELLCASTER_SUEL_ARCHANAMACH;    break;
        case CLASS_TYPE_FAVOURED_SOUL:       nFeat = FEAT_PRACTICED_SPELLCASTER_FAVOURED_SOUL;       break;
        case CLASS_TYPE_SOHEI:               nFeat = FEAT_PRACTICED_SPELLCASTER_SOHEI;               break;
        case CLASS_TYPE_MYSTIC:              nFeat = FEAT_PRACTICED_SPELLCASTER_MYSTIC;              break;
        case CLASS_TYPE_WARMAGE:             nFeat = FEAT_PRACTICED_SPELLCASTER_WARMAGE;             break;
        case CLASS_TYPE_DREAD_NECROMANCER:   nFeat = FEAT_PRACTICED_SPELLCASTER_DREAD_NECROMANCER;   break;
        case CLASS_TYPE_WITCH:               nFeat = FEAT_PRACTICED_SPELLCASTER_WITCH;               break;
        case CLASS_TYPE_ARCHIVIST:           nFeat = FEAT_PRACTICED_SPELLCASTER_ARCHIVIST;           break;
        case CLASS_TYPE_BEGUILER:            nFeat = FEAT_PRACTICED_SPELLCASTER_BEGUILER;            break;
        case CLASS_TYPE_SHUGENJA:            nFeat = FEAT_PRACTICED_SPELLCASTER_SHUGENJA;            break;
        case CLASS_TYPE_HARPER:              nFeat = FEAT_PRACTICED_SPELLCASTER_HARPER;              break;
        default: return 0;
    }

    if(GetHasFeat(nFeat, oCaster))
        return iAdjustment;

    return 0;
}

int GetSpellSchool(int iSpellId)
{
    string sSpellSchool = Get2DACache("spells", "School", iSpellId);//lookup_spell_school(iSpellId);
    int iSpellSchool;

    if (sSpellSchool == "A") iSpellSchool = SPELL_SCHOOL_ABJURATION;
    else if (sSpellSchool == "C") iSpellSchool = SPELL_SCHOOL_CONJURATION;
    else if (sSpellSchool == "D") iSpellSchool = SPELL_SCHOOL_DIVINATION;
    else if (sSpellSchool == "E") iSpellSchool = SPELL_SCHOOL_ENCHANTMENT;
    else if (sSpellSchool == "V") iSpellSchool = SPELL_SCHOOL_EVOCATION;
    else if (sSpellSchool == "I") iSpellSchool = SPELL_SCHOOL_ILLUSION;
    else if (sSpellSchool == "N") iSpellSchool = SPELL_SCHOOL_NECROMANCY;
    else if (sSpellSchool == "T") iSpellSchool = SPELL_SCHOOL_TRANSMUTATION;
    else iSpellSchool = SPELL_SCHOOL_GENERAL;

    return iSpellSchool;
}

int GetIsHealingSpell(int nSpellId)
{
    if (  nSpellId == SPELL_CURE_CRITICAL_WOUNDS
       || nSpellId == SPELL_CURE_LIGHT_WOUNDS
       || nSpellId == SPELL_CURE_MINOR_WOUNDS
       || nSpellId == SPELL_CURE_MODERATE_WOUNDS
       || nSpellId == SPELL_CURE_SERIOUS_WOUNDS
       || nSpellId == SPELL_GREATER_RESTORATION
       || nSpellId == SPELL_HEAL
       || nSpellId == SPELL_HEALING_CIRCLE
       || nSpellId == SPELL_MASS_HEAL
       || nSpellId == SPELL_MONSTROUS_REGENERATION
       || nSpellId == SPELL_REGENERATE
       //End of stock NWN spells
       || nSpellId == SPELL_CORRUPTER_CURE_LIGHT_WOUNDS
       || nSpellId == SPELL_CORRUPTER_CURE_MODERATE_WOUNDS
       || nSpellId == SPELL_CORRUPTER_CURE_SERIOUS_WOUNDS
       || nSpellId == SPELL_MASS_CURE_LIGHT
       || nSpellId == SPELL_MASS_CURE_MODERATE
       || nSpellId == SPELL_MASS_CURE_SERIOUS
       || nSpellId == SPELL_MASS_CURE_CRITICAL
       || nSpellId == SPELL_PANACEA
       )
        return TRUE;

    return FALSE;
}

int ArchmageSpellPower(object oCaster)
{
    int nLevelBonus = 0;

    if (GetHasFeat(FEAT_SPELL_POWER_I,oCaster))
    {
        nLevelBonus += 1;
     if (GetHasFeat(FEAT_SPELL_POWER_V,oCaster))
         nLevelBonus += 4;
     else if (GetHasFeat(FEAT_SPELL_POWER_IV,oCaster))
         nLevelBonus += 3;
     else if (GetHasFeat(FEAT_SPELL_POWER_III,oCaster))
         nLevelBonus += 2;
        else if (GetHasFeat(FEAT_SPELL_POWER_II,oCaster))
         nLevelBonus += 1;
    }
    return nLevelBonus;
}

int TrueNecromancy(object oCaster, int iSpellID, string sType, int nSpellSchool = -1)
{
    int iTNLevel = GetLevelByClass(CLASS_TYPE_TRUENECRO, oCaster);
    if (!iTNLevel)
        return 0;
    if (nSpellSchool == -1)
        nSpellSchool = GetSpellSchool(iSpellID);
    if (nSpellSchool != SPELL_SCHOOL_NECROMANCY)
        return 0;

    //character can have only 3 classes, so one is TN, one arcane and the other divine.
    if (sType == "ARCANE")
        return GetLevelByClass(GetClassByPosition(GetFirstDivineClassPosition(), oCaster)); // TN and arcane levels already added.

    if (sType == "DIVINE")
        return GetLevelByClass(GetClassByPosition(GetFirstArcaneClassPosition(), oCaster))
                + iTNLevel;

    return 0;
}

int ShadowWeave(object oCaster, int iSpellID, int nSpellSchool = -1)
{
   if (!GetHasFeat(FEAT_SHADOWWEAVE,oCaster)) return 0;

   if (nSpellSchool == -1)
       nSpellSchool = GetSpellSchool(iSpellID);

   // Bonus for spells of Enhancement, Necromancy and Illusion schools and spells with Darkness descriptor
   if (nSpellSchool == SPELL_SCHOOL_ENCHANTMENT ||
       nSpellSchool == SPELL_SCHOOL_NECROMANCY  ||
       nSpellSchool == SPELL_SCHOOL_ILLUSION    ||
       iSpellID == SPELL_DARKNESS               ||
       iSpellID == SPELLABILITY_AS_DARKNESS     ||
       iSpellID == 688                          || // Drider darkness
       iSpellID == SHADOWLORD_DARKNESS)
   {
       return 1;
   }
   // Penalty to spells of Evocation and Transmutation schools, except for those with Darkness descriptor
   else if (nSpellSchool == SPELL_SCHOOL_EVOCATION     ||
            nSpellSchool == SPELL_SCHOOL_TRANSMUTATION)
   {
       return -1;
   }

   return 0;
}

int FireAdept(object oCaster, int iSpellID)
{
        int nBoost = 0;

    if (GetHasFeat(FEAT_FIRE_ADEPT, oCaster) && _GetChangedElementalType(iSpellID, oCaster) == "Fire")
        nBoost += 1;

    if (GetHasFeat(FEAT_BLOODLINE_OF_FIRE, oCaster) && _GetChangedElementalType(iSpellID, oCaster) == "Fire")
        nBoost += 2;

        return nBoost;
}

int StormMagic(object oCaster)
{
    if (!GetHasFeat(FEAT_STORMMAGIC,oCaster)) return 0;

    object oArea = GetArea(oCaster);

    if (GetWeather(oArea) == WEATHER_RAIN || GetWeather(oArea) == WEATHER_SNOW)
    {
        return 1;
    }
    return 0;
}

int CormanthyranMoonMagic(object oCaster)
{
    if (!GetHasFeat(FEAT_CORMANTHYRAN_MOON_MAGIC, oCaster)) return 0;

    object oArea = GetArea(oCaster);

    // The moon must be visible. Thus, outdoors, at night, with no rain.
    if (GetWeather(oArea) != WEATHER_RAIN && GetWeather(oArea) != WEATHER_SNOW &&
        GetIsNight() && !GetIsAreaInterior(oArea))
    {
        return 2;
    }
    return 0;
}

int DomainPower(object oCaster, int nSpellID, int nSpellSchool = -1)
{
    int nBonus = 0;
    if (nSpellSchool == -1)
       nSpellSchool = GetSpellSchool(nSpellID);

    // Boosts Caster level with the Illusion school by 1
    if (nSpellSchool == SPELL_SCHOOL_ILLUSION && GetHasFeat(FEAT_DOMAIN_POWER_GNOME, oCaster))
    {
        nBonus += 1;
    }

    // Boosts Caster level with the Illusion school by 1
    if (nSpellSchool == SPELL_SCHOOL_ILLUSION && GetHasFeat(FEAT_DOMAIN_POWER_ILLUSION, oCaster))
    {
        nBonus += 1;
    }

    // Boosts Caster level with healing spells
    if (GetIsOfSubschool(nSpellID, SUBSCHOOL_HEALING) && GetHasFeat(FEAT_HEALING_DOMAIN_POWER, oCaster))
    {
        nBonus += 1;
    }

    // Boosts Caster level with the Divination school by 1
    if (nSpellSchool == SPELL_SCHOOL_DIVINATION && GetHasFeat(FEAT_KNOWLEDGE_DOMAIN_POWER, oCaster))
    {
        nBonus += 1;
    }

    // Boosts Caster level with evil spells by 1
    if (GetHasDescriptor(nSpellID, DESCRIPTOR_EVIL) && GetHasFeat(FEAT_EVIL_DOMAIN_POWER, oCaster))
    {
        nBonus += 1;
    }

    // Boosts Caster level with good spells by 1
    if (GetHasDescriptor(nSpellID, DESCRIPTOR_GOOD) && GetHasFeat(FEAT_GOOD_DOMAIN_POWER, oCaster))
    {
        nBonus += 1;
    }

    return nBonus;
}

int DeathKnell(object oCaster)
{
    if (!GetLocalInt(oCaster, "DeathKnell")) return 0;
    // If you do have the int, return a +1 bonus to caster level
    return 1;
}

int DraconicPower(object oCaster = OBJECT_SELF)
{
    if (GetHasFeat(FEAT_DRACONIC_POWER, oCaster))
        return 1;
    else
        return 0;
}

int SongOfArcanePower(object oCaster = OBJECT_SELF)
{
    int nBonus = GetLocalInt(oCaster, "SongOfArcanePower");
    DeleteLocalInt(oCaster, "SongOfArcanePower");
    if(nBonus > 0)
        return nBonus;
    else
        return 0;
}
