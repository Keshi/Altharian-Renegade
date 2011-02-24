//::///////////////////////////////////////////////
//:: prc_x2_craft
//:: Copyright (c) 2003 Bioare Corp.
//:://////////////////////////////////////////////
/*

    Central include for crafting feat and
    crafting skill system.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-05-09
//:: Last Updated On: 2003-10-14
//:://////////////////////////////////////////////


struct craft_struct
{
    int    nRow;
    string sResRef;
    int    nDC;
    int    nCost;
    string sLabel;
};

struct craft_receipe_struct
{
    int nMode;
    object oMajor;
    object oMinor;
};

struct craft_cost_struct
{
    int nGoldCost;
    int nXPCost;
    int nTimeCost;
};

const string  X2_CI_CRAFTSKILL_CONV ="x2_p_craftskills";

// Brew Potion related Constants
/* moved to be code switches

const int     X2_CI_BREWPOTION_MAXLEVEL       = 3;                      // Max Level for potions
const int     X2_CI_BREWPOTION_COSTMODIFIER   = 50;                     // gp Brew Potion XPCost Modifier

// Scribe Scroll related constants
const int     X2_CI_SCRIBESCROLL_COSTMODIFIER   = 25;                 // Scribescroll Cost Modifier

// Craft Wand related constants
const int     X2_CI_CRAFTWAND_MAXLEVEL       = 4;
const int     X2_CI_CRAFTWAND_COSTMODIFIER   = 750;
*/
const int     X2_CI_BREWPOTION_FEAT_ID       = 944; // Brew Potion feat simulation
const int     X2_CI_SCRIBESCROLL_FEAT_ID     = 945;
const int     X2_CI_CRAFTWAND_FEAT_ID        = 946;
const int     X2_CI_CRAFTROD_FEAT_ID         = 2927;
const int     X2_CI_CRAFTROD_EPIC_FEAT_ID    = 3490;
const int     X2_CI_CRAFTSTAFF_FEAT_ID       = 2928;
const int     X2_CI_CRAFTSTAFF_EPIC_FEAT_ID  = 3491;
const string  X2_CI_BREWPOTION_NEWITEM_RESREF   = "x2_it_pcpotion"; // ResRef for new potion item
const string  X2_CI_SCRIBESCROLL_NEWITEM_RESREF = "x2_it_pcscroll"; // ResRef for new scroll item
const string  X2_CI_CRAFTWAND_NEWITEM_RESREF    = "x2_it_pcwand";
//const string  X2_CI_CRAFTROD_NEWITEM_RESREF = "x2_it_pcwand";
//const string  X2_CI_CRAFTSTAFF_NEWITEM_RESREF = "x2_it_pcwand";

// 2da for the craftskills
const string X2_CI_CRAFTING_WP_2DA = "des_crft_weapon" ;
const string X2_CI_CRAFTING_AR_2DA = "des_crft_armor" ;
const string X2_CI_CRAFTING_MAT_2DA = "des_crft_mat";


// 2da for matching spells to properties
const string X2_CI_CRAFTING_SP_2DA = "des_crft_spells" ;
// Base custom token for item modification conversations (do not change unless you want to change the conversation too)
const int     X2_CI_CRAFTINGSKILL_CTOKENBASE = 13220;

// Base custom token for DC item modification conversations (do not change unless you want to change the conversation too)
const int     X2_CI_CRAFTINGSKILL_DC_CTOKENBASE = 14220;

// Base custom token for DC item modification conversations (do not change unless you want to change the conversation too)
const int     X2_CI_CRAFTINGSKILL_GP_CTOKENBASE = 14320;

// Base custom token for DC item modification conversations (do not change unless you want to change the conversation too)
const int     X2_CI_MODIFYARMOR_GP_CTOKENBASE = 14420;

//How many items per 2da row in X2_IP_CRAFTING_2DA, do not change>4 until you want to create more conversation condition scripts as well
const int     X2_CI_CRAFTING_ITEMS_PER_ROW = 5;

// name of the scroll 2da
const string  X2_CI_2DA_SCROLLS = "des_crft_scroll";

const int X2_CI_CRAFTMODE_INVALID   = 0;
const int X2_CI_CRAFTMODE_CONTAINER = 1; // no longer used, but left in for the community to reactivate
const int X2_CI_CRAFTMODE_BASE_ITEM  = 2;
const int X2_CI_CRAFTMODE_ASSEMBLE = 3;

const int X2_CI_MAGICTYPE_INVALID = 0;
const int X2_CI_MAGICTYPE_ARCANE  = 1;
const int X2_CI_MAGICTYPE_DIVINE  = 2;

const int X2_CI_MODMODE_INVALID = 0;
const int X2_CI_MODMODE_ARMOR = 1;
const int X2_CI_MODMODE_WEAPON = 2;

// Runecrafting constants
const int PRC_RUNE_BASECOST        = 0;
const int PRC_RUNE_CHARGES         = 1;
const int PRC_RUNE_PERDAY          = 2;
const int PRC_RUNE_MAXCHARGES      = 3;
const int PRC_RUNE_MAXUSESPERDAY   = 4;
// Attune Gem constants
const int PRC_GEM_BASECOST         = 5;
const int PRC_GEM_PERLEVEL         = 6;
// Craft Skull Talisman constants
const int PRC_SKULL_BASECOST       = 7;

// *  Returns TRUE if an item is a Craft Base Item
// *  to be used in spellscript that can be cast on items - i.e light
int   CIGetIsCraftFeatBaseItem( object oItem );

// *  Checks if the last spell cast was used to brew potion and will do the brewing process.
// *  Returns TRUE if the spell was indeed used to brew a potion (regardless of the actual outcome of the brewing process)
// *  Meant to be used in spellscripts only
int   CICraftCheckBrewPotion(object oSpellTarget, object oCaster, int nID = 0);

// *  Checks if the last spell cast was used to scribe a scroll and handles the scribe scroll process
// *  Returns TRUE if the spell was indeed used to scribe a scroll (regardless of the actual outcome)
// *  Meant to be used in spellscripts only
int   CICraftCheckScribeScroll(object oSpellTarget, object oCaster, int nID = 0);

// *   Create a new potion item based on the spell nSpellID  on the creator
object CICraftBrewPotion(object oCreator, int nSpellID );

// *   Create a new scroll item based on the spell nSpellID on the creator
object CICraftScribeScroll(object oCreator, int nSpellID);


// *  Checks if the caster intends to use his item creation feats and
// *  calls appropriate item creation subroutine if conditions are met (spell cast on correct item, etc).
// *  Returns TRUE if the spell was used for an item creation feat
int   CIGetSpellWasUsedForItemCreation(object oSpellTarget);

// This function checks whether Inscribe Rune is turned on
// and if so, deducts the appropriate experience and gold
// then creates the rune in the caster's inventory.
// This will also cause the spell to fail if turned on.
int InscribeRune(object oTarget = OBJECT_INVALID, object oCaster = OBJECT_INVALID, int nSpell = 0);

// This function checks whether Attune Gem is turned on
// and if so, deducts the appropriate experience and gold
// then creates the gem in the caster's inventory.
// This will also cause the spell to fail if turned on.
int AttuneGem(object oTarget = OBJECT_INVALID, object oCaster = OBJECT_INVALID, int nSpell = 0);

// Gets the Magical Artisan feat given a particular crafting feat
int GetMagicalArtisanFeat(int nCraftingFeat);

// Gets the modified gold cost taking cost reduction feats and cost
// scaling switches into account
int GetModifiedGoldCost(int nCost, object oPC, int nCraftingFeat);

// Gets the modified xp cost taking cost reduction feats and cost
// scaling switches into account
int GetModifiedXPCost(int nCost, object oPC, int nCraftingFeat);

// Gets the modified time cost taking cost reduction feats and cost
// scaling switches into account
int GetModifiedTimeCost(int nCost, object oPC, int nCraftingFeat);

// Imbue item check for warlocks, returns TRUE if a spell requirement is met
int CheckImbueItem(object oPC, int nSpell);

// Gets PnP xp cost given a gold cost and whether the item is epic
int GetPnPItemXPCost(int nCost, int bEpic);

// Returns a struct containing gold, xp and time costs given the base cost and other arguments
struct craft_cost_struct GetModifiedCostsFromBase(int nCost, object oPC, int nCraftingFeat, int bEpic);

// Additional checking for emulating spells during crafting
int CheckAlternativeCrafting(object oPC, int nSpell, struct craft_cost_struct costs);

// Returns the maximum of caster level used and other effective levels from emulating spells
int GetAlternativeCasterLevel(object oPC, int nLevel);

//////////////////////////////////////////////////
/* Include section                              */
//////////////////////////////////////////////////

//#include "prc_x2_itemprop"
//#include "x2_inc_switches"
#include "prc_inc_newip"
//#include "prc_inc_spells"
#include "inv_inc_invfunc"


//////////////////////////////////////////////////
/* Function definitions                         */
//////////////////////////////////////////////////


// *  Returns the innate level of a spell. If bDefaultZeroToOne is given
// *  Level 0 spell will be returned as level 1 spells
int   CIGetSpellInnateLevel(int nSpellID, int bDefaultZeroToOne = FALSE)
{
    int nRet = StringToInt(Get2DACache(X2_CI_CRAFTING_SP_2DA, "Level", nSpellID));
    if (nRet == 0 && bDefaultZeroToOne == TRUE) // Was missing the "bDefaultZeroToOne == TRUE" check, fixed to match specification - Ornedan
        nRet = 1;

    return nRet;
}

// * Makes oPC do a Craft check using nSkill to create the item supplied in sResRe
// * If oContainer is specified, the item will be created there.
// * Throwing weapons are created with stack sizes of 10, ammo with 20
// *  oPC       - The player crafting
// *  nSkill    - SKILL_CRAFT_WEAPON or SKILL_CRAFT_ARMOR,
// *  sResRef   - ResRef of the item to be crafted
// *  nDC       - DC to beat to succeed
// *  oContainer - if a container is specified, create item inside
object CIUseCraftItemSkill(object oPC, int nSkill, string sResRef, int nDC, object oContainer = OBJECT_INVALID);

// *  Returns TRUE if a spell is prevented from being used with one of the crafting feats
int   CIGetIsSpellRestrictedFromCraftFeat(int nSpellID, int nFeatID);

// *  Return craftitemstructdata
struct craft_struct CIGetCraftItemStructFrom2DA(string s2DA, int nRow, int nItemNo);

// *  Return the type of magic as one of the following constants
// *  const int X2_CI_MAGICTYPE_INVALID = 0;
// *  const int X2_CI_MAGICTYPE_ARCANE  = 1;
// *  const int X2_CI_MAGICTYPE_DIVINE  = 2;
// *  Parameters:
// *    nClass - CLASS_TYPE_* constant
int CI_GetClassMagicType(int nClass)
{
    if(GetIsArcaneClass(nClass))
        return X2_CI_MAGICTYPE_ARCANE;
    else if(GetIsDivineClass(nClass))
        return X2_CI_MAGICTYPE_DIVINE;

    return X2_CI_MAGICTYPE_INVALID;
}

string GetMaterialComponentTag(int nPropID)
{
    string sRet = Get2DACache("des_matcomp","comp_tag",nPropID);
    return sRet;
}


// -----------------------------------------------------------------------------
// Return true if oItem is a crafting target item
// -----------------------------------------------------------------------------
int CIGetIsCraftFeatBaseItem(object oItem)
{
    int nBt = GetBaseItemType(oItem);
    // blank scroll, empty potion, wand
    if (nBt == BASE_ITEM_BLANK_POTION ||
        nBt == BASE_ITEM_BLANK_SCROLL ||
        nBt == BASE_ITEM_BLANK_WAND ||
        nBt == BASE_ITEM_CRAFTED_ROD ||
        nBt == BASE_ITEM_CRAFTED_STAFF)
      return TRUE;
    else
      return FALSE;
}


// -----------------------------------------------------------------------------
// Georg, 2003-06-12
// Create a new playermade potion object with properties matching nSpellID and return it
// -----------------------------------------------------------------------------
object CICraftBrewPotion(object oCreator, int nSpellID )
{

    int nPropID = IPGetIPConstCastSpellFromSpellID(nSpellID);

    object oTarget;
    // * GZ 2003-09-11: If the current spell cast is not acid fog, and
    // *                returned property ID is 0, bail out to prevent
    // *                creation of acid fog items.
    if (nPropID == 0 && nSpellID != 0)
    {
        FloatingTextStrRefOnCreature(84544,oCreator);
        return OBJECT_INVALID;
    }

    /* //just a tad retarded, don't you think? other crafting feats are not similarly restricted
    //Uses per day
    int nUsesAllowed;

    if(GetHasFeat(FEAT_BREW_4PERDAY,oCreator)) nUsesAllowed = 4;

    else if(GetHasFeat(FEAT_BREW_3PERDAY, oCreator)) nUsesAllowed = 3;

    else if(GetHasFeat(FEAT_BREW_2PERDAY, oCreator)) nUsesAllowed = 2;

    else nUsesAllowed = 1;

    int nUsed = GetLocalInt(oCreator, "PRC_POTIONS_BREWED");

    if(nUsed >= nUsesAllowed)
    {
            SendMessageToPC(oCreator, "You must rest before you can brew any more potions");
            return OBJECT_INVALID;
    }
    */

    int nCasterLevel = GetAlternativeCasterLevel(oCreator, PRCGetCasterLevel(oCreator));

    if (nPropID != -1)
    {
        itemproperty ipProp = ItemPropertyCastSpell(nPropID,IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE);
        oTarget = CreateItemOnObject(X2_CI_BREWPOTION_NEWITEM_RESREF,oCreator);
        AddItemProperty(DURATION_TYPE_PERMANENT,ipProp,oTarget);
        if(GetPRCSwitch(PRC_BREW_POTION_CASTER_LEVEL))
        {
            itemproperty ipLevel = ItemPropertyCastSpellCasterLevel(nSpellID, nCasterLevel);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipLevel,oTarget);
            itemproperty ipMeta = ItemPropertyCastSpellMetamagic(nSpellID, PRCGetMetaMagicFeat());
            AddItemProperty(DURATION_TYPE_PERMANENT,ipMeta,oTarget);
            itemproperty ipDC = ItemPropertyCastSpellDC(nSpellID, PRCGetSaveDC(PRCGetSpellTargetObject(), OBJECT_SELF));
            AddItemProperty(DURATION_TYPE_PERMANENT,ipDC,oTarget);
        }

        //Increment usage
        //SetLocalInt(oCreator, "PRC_POTIONS_BREWED", nUsed++);
    }
    return oTarget;
}

// -----------------------------------------------------------------------------
// Wrapper for the crafting cost calculation, returns GP required
// -----------------------------------------------------------------------------
int CIGetCraftGPCost(int nLevel, int nMod, string sCasterLevelSwitch)
{
    int nLvlRow =   IPGetIPConstCastSpellFromSpellID(PRCGetSpellId());
    int nCLevel;// = StringToInt(Get2DACache("iprp_spells","CasterLvl",nLvlRow));
    //PRC modification
    if(GetPRCSwitch(sCasterLevelSwitch))
    {
        nCLevel = PRCGetCasterLevel();
    }
    else
    {
        nCLevel = StringToInt(Get2DACache("iprp_spells","CasterLvl",nLvlRow));
    }

    // -------------------------------------------------------------------------
    // in case we don't get a valid CLevel, use spell level instead
    // -------------------------------------------------------------------------
    if (nCLevel ==0)
    {
        nCLevel = nLevel;
    }
    int nRet = nCLevel * nLevel * nMod;
    return nRet;

}

// -----------------------------------------------------------------------------
// Georg, 2003-06-12
// Create a new playermade wand object with properties matching nSpellID
// and return it
// -----------------------------------------------------------------------------
object CICraftCraftWand(object oCreator, int nSpellID )
{
    int nPropID = IPGetIPConstCastSpellFromSpellID(nSpellID);

    object oTarget;
    // * GZ 2003-09-11: If the current spell cast is not acid fog, and
    // *                returned property ID is 0, bail out to prevent
    // *                creation of acid fog items.
    if (nPropID == 0 && nSpellID != 0)
    {
        FloatingTextStrRefOnCreature(84544,oCreator);
        return OBJECT_INVALID;
    }


    //int nClass = PRCGetLastSpellCastClass();
    int nCasterLevel = GetAlternativeCasterLevel(oCreator, PRCGetCasterLevel(oCreator));

    if (nPropID != -1)
    {
        itemproperty ipProp = ItemPropertyCastSpell(nPropID,IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE);
        oTarget = CreateItemOnObject(X2_CI_CRAFTWAND_NEWITEM_RESREF,oCreator);
        AddItemProperty(DURATION_TYPE_PERMANENT,ipProp,oTarget);

        if(GetPRCSwitch(PRC_CRAFT_WAND_CASTER_LEVEL))
        {
            itemproperty ipLevel = ItemPropertyCastSpellCasterLevel(nSpellID, nCasterLevel);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipLevel,oTarget);
            itemproperty ipMeta = ItemPropertyCastSpellMetamagic(nSpellID, PRCGetMetaMagicFeat());
            AddItemProperty(DURATION_TYPE_PERMANENT,ipMeta,oTarget);
        itemproperty ipDC = ItemPropertyCastSpellDC(nSpellID, PRCGetSaveDC(PRCGetSpellTargetObject(), OBJECT_SELF));
            AddItemProperty(DURATION_TYPE_PERMANENT,ipDC,oTarget);
        }

        //int nType = CI_GetClassMagicType(nClass);
        //itemproperty ipLimit;

        /*  //this is a bit silly, really, removed in line with other crafting types
        if (nType == X2_CI_MAGICTYPE_DIVINE)
        {
             ipLimit = ItemPropertyLimitUseByClass(CLASS_TYPE_PALADIN);
             AddItemProperty(DURATION_TYPE_PERMANENT,ipLimit,oTarget);
             ipLimit = ItemPropertyLimitUseByClass(CLASS_TYPE_RANGER);
             AddItemProperty(DURATION_TYPE_PERMANENT,ipLimit,oTarget);
             ipLimit = ItemPropertyLimitUseByClass(CLASS_TYPE_DRUID);
             AddItemProperty(DURATION_TYPE_PERMANENT,ipLimit,oTarget);
             ipLimit = ItemPropertyLimitUseByClass(CLASS_TYPE_CLERIC);
             AddItemProperty(DURATION_TYPE_PERMANENT,ipLimit,oTarget);
        }
        else if (nType == X2_CI_MAGICTYPE_ARCANE)
        {
             ipLimit = ItemPropertyLimitUseByClass(CLASS_TYPE_WIZARD);
             AddItemProperty(DURATION_TYPE_PERMANENT,ipLimit,oTarget);
             ipLimit = ItemPropertyLimitUseByClass(CLASS_TYPE_SORCERER);
             AddItemProperty(DURATION_TYPE_PERMANENT,ipLimit,oTarget);
             ipLimit = ItemPropertyLimitUseByClass(CLASS_TYPE_BARD);
             AddItemProperty(DURATION_TYPE_PERMANENT,ipLimit,oTarget);
        }

        if(nClass != CLASS_TYPE_WARLOCK)
        {
            ipLimit = ItemPropertyLimitUseByClass(nClass);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipLimit,oTarget);
        }
        */

        int nCharges = nCasterLevel + d20();

        if (nCharges == 0) // stupi cheaters
        {
            nCharges = 10+d20();
        }
        // Hard core rule mode enabled
        if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES))
        {
            SetItemCharges(oTarget,50);
        }
        else
        {
            SetItemCharges(oTarget,nCharges);
        }
        // TODOL Add use restrictions there when item becomes available
    }
    return oTarget;
}

// -----------------------------------------------------------------------------
// Georg, 2003-06-12
// Create and Return a magic wand with an item property
// matching nSpellID. Charges are set to d20 + casterlevel
// capped at 50 max
// -----------------------------------------------------------------------------
object CICraftScribeScroll(object oCreator, int nSpellID)
{
    int nPropID = IPGetIPConstCastSpellFromSpellID(nSpellID);
    object oTarget;
    // Handle optional material components
    string sMat = GetMaterialComponentTag(nPropID);
    if (sMat != "")
    {
        object oMat = GetItemPossessedBy(oCreator,sMat);
        if (oMat== OBJECT_INVALID)
        {
            FloatingTextStrRefOnCreature(83374, oCreator); // Missing material component
            return OBJECT_INVALID;
        }
        else
        {
            DestroyObject (oMat);
        }
     }

    // get scroll resref from scrolls lookup 2da
    int nClass =PRCGetLastSpellCastClass ();
    string sClass = "";
    switch (nClass)
    {
       case CLASS_TYPE_WIZARD:
            sClass = "Wiz_Sorc";
            break;

       case CLASS_TYPE_SORCERER:
            sClass = "Wiz_Sorc";
            break;
       case CLASS_TYPE_CLERIC:
            sClass = "Cleric";
            break;
       case CLASS_TYPE_PALADIN:
            sClass = "Paladin";
            break;
       case CLASS_TYPE_DRUID:
            sClass = "Druid";
            break;
       case CLASS_TYPE_RANGER:
            sClass = "Ranger";
            break;
       case CLASS_TYPE_BARD:
            sClass = "Bard";
            break;
    }
    string sResRef;
    if (sClass != "")
    {
        sResRef = Get2DACache(X2_CI_2DA_SCROLLS,sClass,nSpellID);
        if (sResRef != "")
        {
            oTarget = CreateItemOnObject(sResRef,oCreator);
        }

    }
    else
    {
        sResRef = "craft_scroll";
        oTarget = CreateItemOnObject(sResRef ,oCreator);
        RemoveItemProperty(oTarget, GetFirstItemProperty(oTarget));
        itemproperty ipSpell = ItemPropertyCastSpell(nPropID, IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE);
        AddItemProperty(DURATION_TYPE_PERMANENT,ipSpell,oTarget);
    }
    if(GetPRCSwitch(PRC_SCRIBE_SCROLL_CASTER_LEVEL))
    {
        int nCasterLevel = GetAlternativeCasterLevel(oCreator, PRCGetCasterLevel(oCreator));
        itemproperty ipLevel = ItemPropertyCastSpellCasterLevel(nSpellID, nCasterLevel);
        AddItemProperty(DURATION_TYPE_PERMANENT,ipLevel,oTarget);
        itemproperty ipMeta = ItemPropertyCastSpellMetamagic(nSpellID, PRCGetMetaMagicFeat());
        AddItemProperty(DURATION_TYPE_PERMANENT,ipMeta,oTarget);
        itemproperty ipDC = ItemPropertyCastSpellDC(nSpellID, PRCGetSaveDC(PRCGetSpellTargetObject(), OBJECT_SELF));
        AddItemProperty(DURATION_TYPE_PERMANENT,ipDC,oTarget);
    }

    if (oTarget == OBJECT_INVALID)
    {
       WriteTimestampedLogEntry("prc_x2_craft::CICraftScribeScroll failed - Resref: " + sResRef + " Class: " + sClass + "(" +IntToString(nClass) +") " + " SpellID " + IntToString (nSpellID));
    }
    return oTarget;
}

// -----------------------------------------------------------------------------
// Returns TRUE if the player used the last spell to brew a potion
// -----------------------------------------------------------------------------
int CICraftCheckBrewPotion(object oSpellTarget, object oCaster, int nID = 0)
{

    if(nID == 0) nID = PRCGetSpellId();

    object oSpellTarget = PRCGetSpellTargetObject();
    object oCaster      = OBJECT_SELF;
    int    nLevel       = CIGetSpellInnateLevel(nID,TRUE);
    if(GetPRCSwitch(PRC_BREW_POTION_CASTER_LEVEL))
    {
        int nMetaMagic = PRCGetMetaMagicFeat();
        switch(nMetaMagic)
        {
            case METAMAGIC_EMPOWER:
                nLevel += 2;
                break;
            case METAMAGIC_EXTEND:
                nLevel += 1;
                break;
            case METAMAGIC_MAXIMIZE:
                nLevel += 3;
                break;
/*            case METAMAGIC_QUICKEN:
                nLevel += 1;
                break;
            case METAMAGIC_SILENT:
                nLevel += 5;
                break;
            case METAMAGIC_STILL:
                nLevel += 6;
                break;
These dont work as IPs since they are hardcoded */
        }
    }

    // -------------------------------------------------------------------------
    // check if brew potion feat is there
    // -------------------------------------------------------------------------
    if (GetHasFeat(X2_CI_BREWPOTION_FEAT_ID, oCaster) != TRUE)
    {
      FloatingTextStrRefOnCreature(40487, oCaster); // Item Creation Failed - Don't know how to create that type of item
      return TRUE;
    }

    // -------------------------------------------------------------------------
    // check if spell is below maxlevel for brew potions
    // -------------------------------------------------------------------------
    int nPotionMaxLevel = GetPRCSwitch(X2_CI_BREWPOTION_MAXLEVEL);
    if(nPotionMaxLevel == 0)
        nPotionMaxLevel = 3;

    //Master Alchemist

    if(GetHasFeat(FEAT_BREW_POTION_9TH, oCaster)) nPotionMaxLevel = 9;
    else if(GetHasFeat(FEAT_BREW_POTION_8TH, oCaster)) nPotionMaxLevel = 8;
    else if(GetHasFeat(FEAT_BREW_POTION_7TH, oCaster)) nPotionMaxLevel = 7;
    else if(GetHasFeat(FEAT_BREW_POTION_6TH, oCaster)) nPotionMaxLevel = 6;
    else if(GetHasFeat(FEAT_BREW_POTION_5TH, oCaster)) nPotionMaxLevel = 5;
    else if(GetHasFeat(FEAT_BREW_POTION_4TH, oCaster)) nPotionMaxLevel = 4;

    if (nLevel > nPotionMaxLevel)
    {
        FloatingTextStrRefOnCreature(76416, oCaster);
        return TRUE;
    }

    // -------------------------------------------------------------------------
    // Check if the spell is allowed to be used with Brew Potions
    // -------------------------------------------------------------------------
    if (CIGetIsSpellRestrictedFromCraftFeat(nID, X2_CI_BREWPOTION_FEAT_ID))
    {
        FloatingTextStrRefOnCreature(83450, oCaster);
        return TRUE;
    }

    // -------------------------------------------------------------------------
    // XP/GP Cost Calculation
    // -------------------------------------------------------------------------
    int nCostModifier = GetPRCSwitch(X2_CI_BREWPOTION_COSTMODIFIER);
    if(nCostModifier == 0)
        nCostModifier = 50;
    int nCost = CIGetCraftGPCost(nLevel, nCostModifier, PRC_BREW_POTION_CASTER_LEVEL);

    struct craft_cost_struct costs = GetModifiedCostsFromBase(nCost, oCaster, FEAT_BREW_POTION, FALSE);

    // -------------------------------------------------------------------------
    // Does Player have enough gold?
    // -------------------------------------------------------------------------
    //if (GetGold(oCaster) < nGoldCost)
    if(!GetHasGPToSpend(oCaster, costs.nGoldCost))
    {
        FloatingTextStrRefOnCreature(3786, oCaster); // Item Creation Failed - not enough gold!
        return TRUE;
    }

    int nHD = GetHitDice(oCaster);
    int nMinXPForLevel = ((nHD * (nHD - 1)) / 2) * 1000;
    int nNewXP = GetXP(oCaster) - costs.nXPCost;


    // -------------------------------------------------------------------------
    // check for sufficient XP to cast spell
    // -------------------------------------------------------------------------
    //if (nMinXPForLevel > nNewXP || nNewXP == 0 )
    if (!GetHasXPToSpend(oCaster, costs.nXPCost))
    {
        FloatingTextStrRefOnCreature(3785, oCaster); // Item Creation Failed - Not enough XP
        return TRUE;
    }

    //check spell emulation
    if(!CheckAlternativeCrafting(oCaster, nID, costs))
    {
        FloatingTextStringOnCreature("*Crafting failed!*", oCaster, FALSE);
        return TRUE;
    }

    // -------------------------------------------------------------------------
    // Here we brew the new potion
    // -------------------------------------------------------------------------
    object oPotion = CICraftBrewPotion(oCaster, nID);

    // -------------------------------------------------------------------------
    // Verify Results
    // -------------------------------------------------------------------------
    if (GetIsObjectValid(oPotion))
    {
        //TakeGoldFromCreature(nGoldCost, oCaster, TRUE);
        //SetXP(oCaster, nNewXP);
        SpendXP(oCaster, costs.nXPCost);
        SpendGP(oCaster, costs.nGoldCost);
        DestroyObject (oSpellTarget);
        FloatingTextStrRefOnCreature(8502, oCaster); // Item Creation successful

        //advance time here
        if(!costs.nTimeCost) costs.nTimeCost = 1;
        AdvanceTimeForPlayer(oCaster, RoundsToSeconds(costs.nTimeCost));
        string sName;
        sName = Get2DACache("spells", "Name", nID);
        sName = "Potion of "+GetStringByStrRef(StringToInt(sName));
        SetName(oPotion, sName);
        return TRUE;
     }
     else
     {
         FloatingTextStrRefOnCreature(76417, oCaster); // Item Creation Failed
        return TRUE;
     }

}



// -----------------------------------------------------------------------------
// Returns TRUE if the player used the last spell to create a scroll
// -----------------------------------------------------------------------------
int CICraftCheckScribeScroll(object oSpellTarget, object oCaster, int nID = 0)
{
    if(nID == 0) nID = PRCGetSpellId();

    // -------------------------------------------------------------------------
    // check if scribe scroll feat is there
    // -------------------------------------------------------------------------
    if (GetHasFeat(X2_CI_SCRIBESCROLL_FEAT_ID, oCaster) != TRUE)
    {
      FloatingTextStrRefOnCreature(40487, oCaster); // Item Creation Failed - Don't know how to create that type of item
      return TRUE;
    }

    // -------------------------------------------------------------------------
    // Check if the spell is allowed to be used with Scribe Scroll
    // -------------------------------------------------------------------------
    if (CIGetIsSpellRestrictedFromCraftFeat(nID, X2_CI_SCRIBESCROLL_FEAT_ID))
    {
        FloatingTextStrRefOnCreature(83451, oCaster); // can not be used with this feat
        return TRUE;
    }

    // -------------------------------------------------------------------------
    // XP/GP Cost Calculation
    // -------------------------------------------------------------------------
    int  nLevel    = CIGetSpellInnateLevel(nID,TRUE);
    int nCostModifier = GetPRCSwitch(X2_CI_SCRIBESCROLL_COSTMODIFIER);
    if(nCostModifier == 0)
        nCostModifier = 25;
    int nCost = CIGetCraftGPCost(nLevel, nCostModifier, PRC_SCRIBE_SCROLL_CASTER_LEVEL);

    struct craft_cost_struct costs = GetModifiedCostsFromBase(nCost, oCaster, FEAT_SCRIBE_SCROLL, FALSE);

    if(GetPRCSwitch(PRC_SCRIBE_SCROLL_CASTER_LEVEL))
    {
        int nMetaMagic = PRCGetMetaMagicFeat();
        switch(nMetaMagic)
        {
            case METAMAGIC_EMPOWER:
                nLevel += 2;
                break;
            case METAMAGIC_EXTEND:
                nLevel += 1;
                break;
            case METAMAGIC_MAXIMIZE:
                nLevel += 3;
                break;
/*            case METAMAGIC_QUICKEN:
                nLevel += 1;
                break;
            case METAMAGIC_SILENT:
                nLevel += 5;
                break;
            case METAMAGIC_STILL:
                nLevel += 6;
                break;
These dont work as IPs since they are hardcoded */
        }
    }

    // -------------------------------------------------------------------------
    // Does Player have enough gold?
    // -------------------------------------------------------------------------
    if(!GetHasGPToSpend(oCaster, costs.nGoldCost))
    {
        FloatingTextStrRefOnCreature(3786, oCaster); // Item Creation Failed - not enough gold!
        return TRUE;
    }

    int nHD = GetHitDice(oCaster);
    int nMinXPForLevel = ((nHD * (nHD - 1)) / 2) * 1000;
    int nNewXP = GetXP(oCaster) - costs.nXPCost;

    // -------------------------------------------------------------------------
    // check for sufficient XP to cast spell
    // -------------------------------------------------------------------------
    //if (nMinXPForLevel > nNewXP || nNewXP == 0 )
    if (!GetHasXPToSpend(oCaster, costs.nXPCost))
    {
         FloatingTextStrRefOnCreature(3785, oCaster); // Item Creation Failed - Not enough XP
         return TRUE;
    }

    //check spell emulation
    if(!CheckAlternativeCrafting(oCaster, nID, costs))
    {
        FloatingTextStringOnCreature("*Crafting failed!*", oCaster, FALSE);
        return TRUE;
    }

    // -------------------------------------------------------------------------
    // Here we scribe the scroll
    // -------------------------------------------------------------------------
    object oScroll = CICraftScribeScroll(oCaster, nID);

    // -------------------------------------------------------------------------
    // Verify Results
    // -------------------------------------------------------------------------
    if (GetIsObjectValid(oScroll))
    {
        //----------------------------------------------------------------------
        // Some scrollsare ar not identified ... fix that here
        //----------------------------------------------------------------------
        SetIdentified(oScroll,TRUE);
        ActionPlayAnimation (ANIMATION_FIREFORGET_READ,1.0);
        SpendXP(oCaster, costs.nXPCost);
        SpendGP(oCaster, costs.nGoldCost);
        DestroyObject (oSpellTarget);
        FloatingTextStrRefOnCreature(8502, oCaster); // Item Creation successful

        //advance time here
        if(!costs.nTimeCost) costs.nTimeCost = 1;
        AdvanceTimeForPlayer(oCaster, RoundsToSeconds(costs.nTimeCost));
        return TRUE;
     }
     else
     {
        FloatingTextStrRefOnCreature(76417, oCaster); // Item Creation Failed
        return TRUE;
     }

    return FALSE;
}


// -----------------------------------------------------------------------------
// Returns TRUE if the player used the last spell to craft a wand
// -----------------------------------------------------------------------------
int CICraftCheckCraftWand(object oSpellTarget, object oCaster, int nID = 0)
{

    if(nID == 0) nID = PRCGetSpellId();

    // -------------------------------------------------------------------------
    // check if craft wand feat is there
    // -------------------------------------------------------------------------
    if (GetHasFeat(X2_CI_CRAFTWAND_FEAT_ID, oCaster) != TRUE)
    {
      FloatingTextStrRefOnCreature(40487, oCaster); // Item Creation Failed - Don't know how to create that type of item
      return TRUE; // tried item creation but do not know how to do it
    }

    // -------------------------------------------------------------------------
    // Check if the spell is allowed to be used with Craft Wand
    // -------------------------------------------------------------------------
    if (CIGetIsSpellRestrictedFromCraftFeat(nID, X2_CI_CRAFTWAND_FEAT_ID))
    {
        FloatingTextStrRefOnCreature(83452, oCaster); // can not be used with this feat
        return TRUE;
    }

    int nLevel = CIGetSpellInnateLevel(nID,TRUE);
    if(GetPRCSwitch(PRC_CRAFT_WAND_CASTER_LEVEL))
    {
        int nMetaMagic = PRCGetMetaMagicFeat();
        switch(nMetaMagic)
        {
            case METAMAGIC_EMPOWER:
                nLevel += 2;
                break;
            case METAMAGIC_EXTEND:
                nLevel += 1;
                break;
            case METAMAGIC_MAXIMIZE:
                nLevel += 3;
                break;
/*            case METAMAGIC_QUICKEN:
                nLevel += 1;
                break;
            case METAMAGIC_SILENT:
                nLevel += 5;
                break;
            case METAMAGIC_STILL:
                nLevel += 6;
                break;
These dont work as IPs since they are hardcoded */
        }
    }

    // -------------------------------------------------------------------------
    // check if spell is below maxlevel for craft want
    // -------------------------------------------------------------------------
    int nMaxLevel = GetPRCSwitch(X2_CI_CRAFTWAND_MAXLEVEL);
    if(nMaxLevel == 0)
        nMaxLevel = 4;
    if (nLevel > nMaxLevel)
    {
        FloatingTextStrRefOnCreature(83623, oCaster);
        return TRUE;
    }

    // -------------------------------------------------------------------------
    // XP/GP Cost Calculation
    // -------------------------------------------------------------------------
    int nCostMod = GetPRCSwitch(X2_CI_CRAFTWAND_COSTMODIFIER);
    if(nCostMod == 0)
        nCostMod = 750;
    int nCost = CIGetCraftGPCost(nLevel, nCostMod, PRC_CRAFT_WAND_CASTER_LEVEL);

    struct craft_cost_struct costs = GetModifiedCostsFromBase(nCost, oCaster, FEAT_CRAFT_WAND, FALSE);

    // -------------------------------------------------------------------------
    // Does Player have enough gold?
    // -------------------------------------------------------------------------
    if(!GetHasGPToSpend(oCaster, costs.nGoldCost))
    {
        FloatingTextStrRefOnCreature(3786, oCaster); // Item Creation Failed - not enough gold!
        return TRUE;
    }

    // more calculations on XP cost
    int nHD = GetHitDice(oCaster);
    int nMinXPForLevel = ((nHD * (nHD - 1)) / 2) * 1000;
    int nNewXP = GetXP(oCaster) - costs.nXPCost;

    // -------------------------------------------------------------------------
    // check for sufficient XP to cast spell
    // -------------------------------------------------------------------------
    if (!GetHasXPToSpend(oCaster, costs.nXPCost))
    {
         FloatingTextStrRefOnCreature(3785, oCaster); // Item Creation Failed - Not enough XP
         return TRUE;
    }

    //check spell emulation
    if(!CheckAlternativeCrafting(oCaster, nID, costs))
    {
        FloatingTextStringOnCreature("*Crafting failed!*", oCaster, FALSE);
        return TRUE;
    }

    // -------------------------------------------------------------------------
    // Here we craft the wand
    // -------------------------------------------------------------------------
    object oWand = CICraftCraftWand(oCaster, nID);

    // -------------------------------------------------------------------------
    // Verify Results
    // -------------------------------------------------------------------------
    if (GetIsObjectValid(oWand))
    {
        SpendXP(oCaster, costs.nXPCost);
        SpendGP(oCaster, costs.nGoldCost);
        DestroyObject (oSpellTarget);
        FloatingTextStrRefOnCreature(8502, oCaster); // Item Creation successful

        //advance time here
        if(!costs.nTimeCost) costs.nTimeCost = 1;
        AdvanceTimeForPlayer(oCaster, RoundsToSeconds(costs.nTimeCost));
        string sName;
        sName = Get2DACache("spells", "Name", nID);
        sName = "Wand of "+GetStringByStrRef(StringToInt(sName));
        SetName(oWand, sName);
        return TRUE;
     }
     else
     {
        FloatingTextStrRefOnCreature(76417, oCaster); // Item Creation Failed
        return TRUE;
     }

    return FALSE;
}

int CICraftCheckCraftStaff(object oSpellTarget, object oCaster, int nSpellID = 0)
{

    if(nSpellID == 0) nSpellID = PRCGetSpellId();
    int nCasterLevel = GetAlternativeCasterLevel(oCaster, PRCGetCasterLevel(oCaster));
    int bSuccess = TRUE;
    int nCount = 0;
    itemproperty ip = GetFirstItemProperty(oSpellTarget);
    while(GetIsItemPropertyValid(ip))
    {
        if(GetItemPropertyType(ip) == ITEM_PROPERTY_CAST_SPELL)
            nCount++;
        ip = GetNextItemProperty(oSpellTarget);
    }
    if(nCount >= 8)
    {
        FloatingTextStringOnCreature("* Failure  - Too many castspell itemproperties *", oCaster);
        return TRUE;
    }
    if(!GetHasFeat(X2_CI_CRAFTSTAFF_FEAT_ID, oCaster))
    {
        FloatingTextStrRefOnCreature(40487, oCaster); // Item Creation Failed - Don't know how to create that type of item
        return TRUE; // tried item creation but do not know how to do it
    }
    int nMetaMagic = PRCGetMetaMagicFeat();
    if(nMetaMagic && !GetHasFeat(X2_CI_CRAFTSTAFF_EPIC_FEAT_ID, oCaster))
    {
        FloatingTextStringOnCreature("* Failure  - You must be able to craft epic staffs to apply metamagic *", oCaster);
        return TRUE; // tried item creation but do not know how to do it
    }
    if(CIGetIsSpellRestrictedFromCraftFeat(nSpellID, X2_CI_CRAFTSTAFF_FEAT_ID))
    {
        FloatingTextStrRefOnCreature(16829169, oCaster); // can not be used with this feat
        return TRUE;
    }
    int nLevel = CIGetSpellInnateLevel(nSpellID,TRUE);
    if(GetPRCSwitch(PRC_CRAFT_STAFF_CASTER_LEVEL))
    {
        switch(nMetaMagic)
        {
            case METAMAGIC_EMPOWER:
                nLevel += 2;
                break;
            case METAMAGIC_EXTEND:
                nLevel += 1;
                break;
            case METAMAGIC_MAXIMIZE:
                nLevel += 3;
                break;
/*            case METAMAGIC_QUICKEN:
                nLevel += 1;
                break;
            case METAMAGIC_SILENT:
                nLevel += 5;
                break;
            case METAMAGIC_STILL:
                nLevel += 6;
                break;
These dont work as IPs since they are hardcoded */
        }
    }
    int nCostMod = GetPRCSwitch(X2_CI_CRAFTSTAFF_COSTMODIFIER);
    if(!nCostMod) nCostMod = 750;
    int nLvlRow = IPGetIPConstCastSpellFromSpellID(nSpellID);
    int nCLevel = StringToInt(Get2DACache("iprp_spells","CasterLvl",nLvlRow));
    int nCost = CIGetCraftGPCost(nLevel, nCostMod, PRC_CRAFT_STAFF_CASTER_LEVEL);

    //discount for second or 3+ spells
    if(nCount+1 == 2)
        nCost = (nCost*3)/4;
    else if(nCount+1 >= 3)
        nCost = nCost/2;

    //takes epic xp costs into account
    struct craft_cost_struct costs = GetModifiedCostsFromBase(nCost, oCaster, FEAT_CRAFT_STAFF, (nMetaMagic > 0));

    if(costs.nGoldCost < 1) costs.nXPCost = 1;
    if(costs.nXPCost < 1) costs.nXPCost = 1;
    //if(GetGold(oCaster) < nGoldCost)  //  enough gold?
    if (!GetHasGPToSpend(oCaster, costs.nGoldCost))
    {
        FloatingTextStrRefOnCreature(3786, oCaster); // Item Creation Failed - not enough gold!
        return TRUE;
    }
    int nHD = GetHitDice(oCaster);
    int nMinXPForLevel = (nHD * (nHD - 1)) * 500;
    int nNewXP = GetXP(oCaster) - costs.nXPCost;
    //if (nMinXPForLevel > nNewXP || nNewXP == 0 )
    if (!GetHasXPToSpend(oCaster, costs.nXPCost))
    {
         FloatingTextStrRefOnCreature(3785, oCaster); // Item Creation Failed - Not enough XP
         return TRUE;
    }
    //check spell emulation
    if(!CheckAlternativeCrafting(oCaster, nSpellID, costs))
    {
        FloatingTextStringOnCreature("*Crafting failed!*", oCaster, FALSE);
        return TRUE;
    }
    int nPropID = IPGetIPConstCastSpellFromSpellID(nSpellID);
    if (nPropID == 0 && nSpellID != 0)
    {
        FloatingTextStrRefOnCreature(84544,oCaster);
        return TRUE;
    }
    if (nPropID != -1)
    {
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(nPropID,IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE),oSpellTarget);

        if(GetPRCSwitch(PRC_CRAFT_STAFF_CASTER_LEVEL))
        {
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpellCasterLevel(nSpellID, nCasterLevel),oSpellTarget);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpellMetamagic(nSpellID, PRCGetMetaMagicFeat()),oSpellTarget);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpellDC(nSpellID, PRCGetSaveDC(PRCGetSpellTargetObject(), OBJECT_SELF)),oSpellTarget);
        }
    }
    else
        bSuccess = FALSE;

    if(bSuccess)
    {
        //TakeGoldFromCreature(nGoldCost, oCaster, TRUE);
        //SetXP(oCaster, nNewXP);
        SpendXP(oCaster, costs.nXPCost);
        SpendGP(oCaster, costs.nGoldCost);
        //DestroyObject (oSpellTarget);
        FloatingTextStrRefOnCreature(8502, oCaster); // Item Creation successful

        //advance time here
        if(!costs.nTimeCost) costs.nTimeCost = 1;
        AdvanceTimeForPlayer(oCaster, RoundsToSeconds(costs.nTimeCost));
        string sName;
        sName = GetName(oCaster)+"'s Magic Staff";
        //sName = Get2DACache("spells", "Name", nID);
        //sName = "Wand of "+GetStringByStrRef(StringToInt(sName));
        SetName(oSpellTarget, sName);
        return TRUE;
    }
    else
    {
        FloatingTextStrRefOnCreature(76417, oCaster); // Item Creation Failed
        return TRUE;
    }
    return TRUE;
}
int CICraftCheckCraftRod(object oSpellTarget, object oCaster, int nSpellID = 0)
{

    if(nSpellID == 0) nSpellID = PRCGetSpellId();
    int bSuccess = TRUE;
    int nCount = 0;
    itemproperty ip = GetFirstItemProperty(oSpellTarget);
    while(GetIsItemPropertyValid(ip))
    {
        if(GetItemPropertyType(ip) == ITEM_PROPERTY_CAST_SPELL)
            nCount++;
        ip = GetNextItemProperty(oSpellTarget);
    }
    if(nCount >= 8)
    {
        FloatingTextStringOnCreature("* Failure  - Too many castspell itemproperties *", oCaster);
        return TRUE;
    }
    if(!GetHasFeat(X2_CI_CRAFTROD_FEAT_ID, oCaster))
    {
        FloatingTextStrRefOnCreature(40487, oCaster); // Item Creation Failed - Don't know how to create that type of item
        return TRUE; // tried item creation but do not know how to do it
    }
    int nMetaMagic = PRCGetMetaMagicFeat();
    if(nMetaMagic && !GetHasFeat(X2_CI_CRAFTROD_EPIC_FEAT_ID, oCaster))
    {
        FloatingTextStringOnCreature("* Failure  - You must be able to craft epic rods to apply metamagic *", oCaster);
        return TRUE; // tried item creation but do not know how to do it
    }
    if(CIGetIsSpellRestrictedFromCraftFeat(nSpellID, X2_CI_CRAFTROD_FEAT_ID))
    {
        FloatingTextStrRefOnCreature(16829169, oCaster); // can not be used with this feat
        return TRUE;
    }
    int nLevel = CIGetSpellInnateLevel(nSpellID,TRUE);
    if(GetPRCSwitch(PRC_CRAFT_STAFF_CASTER_LEVEL))
    {
        switch(nMetaMagic)
        {
            case METAMAGIC_EMPOWER:
                nLevel += 2;
                break;
            case METAMAGIC_EXTEND:
                nLevel += 1;
                break;
            case METAMAGIC_MAXIMIZE:
                nLevel += 3;
                break;
/*            case METAMAGIC_QUICKEN:
                nLevel += 1;
                break;
            case METAMAGIC_SILENT:
                nLevel += 5;
                break;
            case METAMAGIC_STILL:
                nLevel += 6;
                break;
These dont work as IPs since they are hardcoded */
        }
    }
    int nCostMod = GetPRCSwitch(X2_CI_CRAFTROD_COSTMODIFIER);
    if(!nCostMod) nCostMod = 750;
    int nLvlRow = IPGetIPConstCastSpellFromSpellID(nSpellID);
    int nCLevel = StringToInt(Get2DACache("iprp_spells","CasterLvl",nLvlRow));
    int nCost = CIGetCraftGPCost(nLevel, nCostMod, PRC_CRAFT_ROD_CASTER_LEVEL);

    //discount for second or 3+ spells
    if(nCount+1 == 2)
        nCost = (nCost*3)/4;
    else if(nCount+1 >= 3)
        nCost = nCost/2;

    //takes epic xp costs into account
    struct craft_cost_struct costs = GetModifiedCostsFromBase(nCost, oCaster, FEAT_CRAFT_ROD, (nMetaMagic > 0));

    if(costs.nGoldCost < 1) costs.nXPCost = 1;
    if(costs.nXPCost < 1) costs.nXPCost = 1;
    //if(GetGold(oCaster) < nGoldCost)  //  enough gold?
    if (!GetHasGPToSpend(oCaster, costs.nGoldCost))
    {
        FloatingTextStrRefOnCreature(3786, oCaster); // Item Creation Failed - not enough gold!
        return TRUE;
    }
    int nHD = GetHitDice(oCaster);
    int nMinXPForLevel = (nHD * (nHD - 1)) * 500;
    int nNewXP = GetXP(oCaster) - costs.nXPCost;
    //if (nMinXPForLevel > nNewXP || nNewXP == 0 )
    if (!GetHasXPToSpend(oCaster, costs.nXPCost))
    {
         FloatingTextStrRefOnCreature(3785, oCaster); // Item Creation Failed - Not enough XP
         return TRUE;
    }
    //check spell emulation
    if(!CheckAlternativeCrafting(oCaster, nSpellID, costs))
    {
        FloatingTextStringOnCreature("*Crafting failed!*", oCaster, FALSE);
        return TRUE;
    }
    int nPropID = IPGetIPConstCastSpellFromSpellID(nSpellID);
    if (nPropID == 0 && nSpellID != 0)
    {
        FloatingTextStrRefOnCreature(84544,oCaster);
        return TRUE;
    }
    if (nPropID != -1)
    {
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(nPropID,IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE),oSpellTarget);

        if(GetPRCSwitch(PRC_CRAFT_STAFF_CASTER_LEVEL))
        {
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpellMetamagic(nSpellID, PRCGetMetaMagicFeat()),oSpellTarget);
        }
    }
    else
        bSuccess = FALSE;

    if(bSuccess)
    {
        //TakeGoldFromCreature(nGoldCost, oCaster, TRUE);
        //SetXP(oCaster, nNewXP);
        SpendXP(oCaster, costs.nXPCost);
        SpendGP(oCaster, costs.nGoldCost);
        //DestroyObject (oSpellTarget);
        FloatingTextStrRefOnCreature(8502, oCaster); // Item Creation successful

        //advance time here
        if(!costs.nTimeCost) costs.nTimeCost = 1;
        AdvanceTimeForPlayer(oCaster, RoundsToSeconds(costs.nTimeCost));
        string sName;
        sName = GetName(oCaster)+"'s Magic Rod";
        //sName = Get2DACache("spells", "Name", nID);
        //sName = "Wand of "+GetStringByStrRef(StringToInt(sName));
        SetName(oSpellTarget, sName);
        return TRUE;
    }
    else
    {
        FloatingTextStrRefOnCreature(76417, oCaster); // Item Creation Failed
        return TRUE;
    }
    return TRUE;
}

int InscribeRune(object oTarget = OBJECT_INVALID, object oCaster = OBJECT_INVALID, int nSpell = 0)
{
    if(!GetIsObjectValid(oCaster)) oCaster = OBJECT_SELF;
    // Get the item used to cast the spell
    object oItem = GetSpellCastItem();
    if (GetResRef(oItem) == "prc_rune_1")
    {
        string sName = GetName(GetItemPossessor(oItem));
        if (DEBUG) FloatingTextStringOnCreature(sName + " has just cast a rune spell", oCaster, FALSE);

        if(DEBUG) DoDebug("Checking for One Use runes");
        // This check is used to clear up the one use runes
        itemproperty ip = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ip))
    {
            if(GetItemPropertyType(ip) == ITEM_PROPERTY_CAST_SPELL)
            {
                if(DEBUG) DoDebug("Rune can cast spells");
                if (GetItemPropertyCostTableValue(ip) == 5) // Only one use runes have 2 charges per use
                {
                    if(DEBUG) DoDebug("Rune has 2 charges a use, marking it a one use rune");
                    // Give it enough time for the spell to finish casting
                    DestroyObject(oItem, 1.0);
                    if(DEBUG) DoDebug("Rune destroyed.");
                }
            }

    ip = GetNextItemProperty(oItem);
        }
    }

    // If Inscribing is turned off, the spell functions as normal
    if(!GetLocalInt(oCaster, "InscribeRune")) return TRUE;

    // No point being in here if you don't have runes.
    if(!GetHasFeat(FEAT_INSCRIBE_RUNE, oCaster))
    {
        FloatingTextStrRefOnCreature(40487, oCaster); // Item Creation Failed - Don't know how to create that type of item
        return TRUE; // tried item creation but do not know how to do it
    }

        // No point scribing runes from items, and its not allowed.
        if (oItem != OBJECT_INVALID)
        {
            FloatingTextStringOnCreature("You cannot scribe a rune from an item.", oCaster, FALSE);
            return TRUE;
        }

    if(!GetIsObjectValid(oTarget)) oTarget = PRCGetSpellTargetObject();
    int nCaster = GetAlternativeCasterLevel(oCaster, PRCGetCasterLevel(oCaster));
    int nDC = PRCGetSaveDC(oTarget, oCaster);
    if(!nSpell) nSpell = PRCGetSpellId();
    int nSpellLevel = 0;
    int nClass = GetLevelByClass(CLASS_TYPE_RUNECASTER, oCaster);

    // This accounts for the fact that there is no bonus to runecraft at level 10
    // Also adjusts it to fit the epic progression, which starts at 13
    if (nClass >= 10) nClass -= 3;
    // Bonus to Runecrafting checks from the Runecaster class
    int nRuneCraft = (nClass + 2)/3;
    // Runecraft local int that counts uses/charges
    int nCount = GetLocalInt(oCaster, "RuneCounter");

    int nLastClass = PRCGetLastSpellCastClass();
    if (nLastClass == CLASS_TYPE_CLERIC) nSpellLevel = StringToInt(lookup_spell_cleric_level(nSpell));
    else if (nLastClass == CLASS_TYPE_DRUID) nSpellLevel = StringToInt(lookup_spell_druid_level(nSpell));
    else if (nLastClass == CLASS_TYPE_WIZARD || nLastClass == CLASS_TYPE_SORCERER) nSpellLevel = StringToInt(lookup_spell_level(nSpell));
    // If none of these work, check the innate level of the spell
    if (nSpellLevel == 0) nSpellLevel = StringToInt(lookup_spell_innate(nSpell));
    // Minimum level.
    if (nSpellLevel == 0) nSpellLevel = 1;

    // This will be modified with Runecaster code later.
    int nCharges = 1;
    if (GetLocalInt(oCaster, "RuneCharges")) nCharges = nCount;
    if (GetLocalInt(oCaster, "RuneUsesPerDay"))
    {
        // 5 is the max uses per day
        if (nCount > 5) nCount = 5;
        int nMaxUses = StringToInt(Get2DACache("prc_rune_craft", "Cost", PRC_RUNE_MAXUSESPERDAY));
        if (nCount > nMaxUses) nCount = nMaxUses;
        nCharges = nCount;
    }
    // Can't have no charges
    if (nCharges == 0) nCharges = 1;
    int nMaxCharges = StringToInt(Get2DACache("prc_rune_craft", "Cost", PRC_RUNE_MAXCHARGES));
    if (nCount > nMaxCharges) nCharges = nMaxCharges;

    FloatingTextStringOnCreature("Spell Level: " + IntToString(nSpellLevel), OBJECT_SELF, FALSE);
    FloatingTextStringOnCreature("Caster Level: " + IntToString(nCaster), OBJECT_SELF, FALSE);
    FloatingTextStringOnCreature("Number of Charges: " + IntToString(nCharges), OBJECT_SELF, FALSE);

    // Gold cost multipler, varies depending on the ability used to craft
    int nMultiplier = StringToInt(Get2DACache("prc_rune_craft", "Cost", PRC_RUNE_BASECOST));
    if (nClass > 0) nMultiplier /= 2;
    if (GetLocalInt(oCaster, "RuneCharges")) nMultiplier = StringToInt(Get2DACache("prc_rune_craft", "Cost", PRC_RUNE_CHARGES));
    if (GetLocalInt(oCaster, "RuneUsesPerDay")) nMultiplier = StringToInt(Get2DACache("prc_rune_craft", "Cost", PRC_RUNE_PERDAY));

    // Cost of the rune in gold and XP
    int nCost = nSpellLevel * nCaster * nCharges * nMultiplier;

    struct craft_cost_struct costs = GetModifiedCostsFromBase(nCost, oCaster, FEAT_INSCRIBE_RUNE, FALSE);

    FloatingTextStringOnCreature("Gold Cost: " + IntToString(costs.nGoldCost), OBJECT_SELF, FALSE);
    FloatingTextStringOnCreature("XP Cost: " + IntToString(costs.nXPCost), OBJECT_SELF, FALSE);

    // See if the caster has enough gold and XP to scribe a rune, and that he passes the skill check.
    int nHD = GetHitDice(oCaster);
    int nMinXPForLevel = ((nHD * (nHD - 1)) / 2) * 1000;
    int nNewXP = GetXP(oCaster) - costs.nXPCost;
    int nGold = GetGold(oCaster);
    int nNewGold = nGold - costs.nGoldCost;
    int nCheck = FALSE;
    // Does the PC have Maximize Rune turned on?
    int nMaximize = 0;
    if (GetLocalInt(oCaster, "MaximizeRune")) nMaximize = 5;
    // The check does not use GetIsSkillSuccessful so it doesn't show on the PC
    if ((GetSkillRank(SKILL_CRAFT_ARMOR, oCaster) + d20() + nRuneCraft) >= (20 + nSpellLevel + nMaximize)) nCheck = TRUE;


    if (!GetHasGPToSpend(oCaster, costs.nGoldCost))
    {
        FloatingTextStringOnCreature("You do not have enough gold to scribe this rune.", oCaster, FALSE);
        // Since they don't have enough, the spell casts normally
        return TRUE;
    }
    if (!GetHasXPToSpend(oCaster, costs.nXPCost) )
    {
        FloatingTextStringOnCreature("You do not have enough experience to scribe this rune.", oCaster, FALSE);
        // Since they don't have enough, the spell casts normally
        return TRUE;
    }
    if (!nCheck)
    {
        FloatingTextStringOnCreature("You have failed the craft check to scribe this rune.", oCaster, FALSE);
        // Since they don't have enough, the spell casts normally
        return TRUE;
    }

    // Steal all the code from craft wand.
    // The reason craft wand is used is because it is possible to create runes with charges using the Runecaster class.
    int nPropID = IPGetIPConstCastSpellFromSpellID(nSpell);

    // * GZ 2003-09-11: If the current spell cast is not acid fog, and
    // *                returned property ID is 0, bail out to prevent
    // *                creation of acid fog items.
    if (nPropID == 0 && nSpell != 0)
    {
        FloatingTextStrRefOnCreature(84544,oCaster);
        return TRUE;
    }

    //check spell emulation
    if(!CheckAlternativeCrafting(oCaster, nSpell, costs))
    {
        FloatingTextStringOnCreature("*Crafting failed!*", oCaster, FALSE);
        return TRUE;
    }

    // Since we know they can now pay for it, create the rune stone
    object oRune = CreateItemOnObject("prc_rune_1", oCaster);

    if (nPropID != -1)
    {
        // This part is always done
        int nRuneChant = 0;
        // If they have this active, the bonuses are already added, so skip
        // If they don't, add the bonuses down below
        if(!GetHasSpellEffect(SPELL_RUNE_CHANT))
        {
            if (nClass >= 30)        nRuneChant = 10;
            else if (nClass >= 27)   nRuneChant = 9;
            else if (nClass >= 24)   nRuneChant = 8;
            else if (nClass >= 21)   nRuneChant = 7;
            else if (nClass >= 18)   nRuneChant = 6;
            else if (nClass >= 15)   nRuneChant = 5;
            else if (nClass >= 12)   nRuneChant = 4;
            else if (nClass >= 9)    nRuneChant = 3;
            else if (nClass >= 5)    nRuneChant = 2;
            else if (nClass >= 2)    nRuneChant = 1;
        }
        itemproperty ipLevel = ItemPropertyCastSpellCasterLevel(nSpell, PRCGetCasterLevel());
        AddItemProperty(DURATION_TYPE_PERMANENT,ipLevel,oRune);
        itemproperty ipMeta = ItemPropertyCastSpellMetamagic(nSpell, PRCGetMetaMagicFeat());
        AddItemProperty(DURATION_TYPE_PERMANENT,ipMeta,oRune);
        itemproperty ipDC = ItemPropertyCastSpellDC(nSpell, PRCGetSaveDC(PRCGetSpellTargetObject(), OBJECT_SELF) + nRuneChant);
        AddItemProperty(DURATION_TYPE_PERMANENT,ipDC,oRune);
        // If Maximize Rune is turned on and we pass the check, add the Maximize IProp
        if (GetLocalInt(oCaster, "MaximizeRune"))
        {
            itemproperty ipMax = ItemPropertyCastSpellMetamagic(nSpell, METAMAGIC_MAXIMIZE);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipMax,oRune);
        }

        // If its uses per day instead of charges, we do some different stuff here
        if (GetLocalInt(oCaster, "RuneUsesPerDay"))
        {
            int nIPUses;
            if (nCount == 1) nIPUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
            else if (nCount == 2) nIPUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
            else if (nCount == 3) nIPUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
            else if (nCount == 4) nIPUses = IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
            // Caps out at 5 per day
            else if (nCount >= 5) nIPUses = IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY;

            itemproperty ipProp = ItemPropertyCastSpell(nPropID,nIPUses);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipProp,oRune);
        }
        else if (nCharges == 1) // This is to handle one use runes so the spellhooking works
        {
            itemproperty ipProp = ItemPropertyCastSpell(nPropID,IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipProp,oRune);
            // This is done so the item exists when it is used for the game to read data off of
        nCharges = 3;
        }
        else // Do the normal charges
        {
            itemproperty ipProp = ItemPropertyCastSpell(nPropID,IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipProp,oRune);
        }
        SetItemCharges(oRune,nCharges);
        SetXP(oCaster,nNewXP);
        TakeGoldFromCreature(costs.nGoldCost, oCaster, TRUE);

        //advance time here
        if(!costs.nTimeCost) costs.nTimeCost = 1;
        AdvanceTimeForPlayer(oCaster, RoundsToSeconds(costs.nTimeCost));
        string sName;
        sName = Get2DACache("spells", "Name", nSpell);
        sName = "Rune of "+GetStringByStrRef(StringToInt(sName));
        if(GetLocalInt(oCaster, "MaximizeRune"))
            sName = "Maximized "+sName;
        SetName(oRune, sName);
    }

    // If we have made it this far, they have crafted the rune and the spell has been used up, so it returns false.
    return FALSE;
}

int AttuneGem(object oTarget = OBJECT_INVALID, object oCaster = OBJECT_INVALID, int nSpell = 0)
{
    if(!GetIsObjectValid(oCaster)) oCaster = OBJECT_SELF;
    // Get the item used to cast the spell
    object oItem = GetSpellCastItem();
    if (GetTag(oItem) == "prc_attunegem")
    {
        string sName = GetName(GetItemPossessor(oItem));
        if (DEBUG) FloatingTextStringOnCreature(sName + " has just cast a gem spell", oCaster, FALSE);

        if(DEBUG) DoDebug("Checking for One Use Gems");
        // This check is used to clear up the one use Gems
        itemproperty ip = GetFirstItemProperty(oItem);
        while(GetIsItemPropertyValid(ip))
        {
            if(GetItemPropertyType(ip) == ITEM_PROPERTY_CAST_SPELL)
            {
                if(DEBUG) DoDebug("Gem can cast spells");
                if (GetItemPropertyCostTableValue(ip) == 5) // Only one use Gems have 2 charges per use
                {
                    if(DEBUG) DoDebug("Gem has 2 charges a use, marking it a one use Gem");
                    // Give it enough time for the spell to finish casting
                    DestroyObject(oItem, 1.0);
                    if(DEBUG) DoDebug("Gem destroyed.");
                }
            }

        ip = GetNextItemProperty(oItem);
        }
    }

    // If Inscribing is turned off, the spell functions as normal
    if(!GetLocalInt(oCaster, "AttuneGem")) return TRUE;

    // No point being in here if you don't have Gems.
    if(!GetHasFeat(FEAT_ATTUNE_GEM, oCaster))
    {
        FloatingTextStrRefOnCreature(40487, oCaster); // Item Creation Failed - Don't know how to create that type of item
        return TRUE; // tried item creation but do not know how to do it
    }

        // No point scribing Gems from items, and its not allowed.
        if (oItem != OBJECT_INVALID)
        {
            FloatingTextStringOnCreature("You cannot scribe a Gem from an item.", oCaster, FALSE);
            return TRUE;
        }
    // oTarget here should be the gem. If it's not, fail.
    if(!GetIsObjectValid(oTarget)) oTarget = PRCGetSpellTargetObject();
    // Only accepts bioware gems
    if (GetStringLeft(GetResRef(oTarget), 5) == "it_gem")
    {
        FloatingTextStringOnCreature("Spell target is not a valid gem.", oCaster, FALSE);
        // And out we go
        return TRUE;
    }

    int nCaster = GetAlternativeCasterLevel(oCaster, PRCGetCasterLevel(oCaster));
    int nDC = PRCGetSaveDC(oTarget, oCaster);
    if(!nSpell) nSpell = PRCGetSpellId();
    int nSpellLevel;

    if (PRCGetLastSpellCastClass() == CLASS_TYPE_CLERIC) nSpellLevel = StringToInt(lookup_spell_cleric_level(nSpell));
    else if (PRCGetLastSpellCastClass() == CLASS_TYPE_DRUID) nSpellLevel = StringToInt(lookup_spell_druid_level(nSpell));
    else if (PRCGetLastSpellCastClass() == CLASS_TYPE_WIZARD || PRCGetLastSpellCastClass() == CLASS_TYPE_SORCERER) nSpellLevel = StringToInt(lookup_spell_level(nSpell));
    // If none of these work, check the innate level of the spell
    if (nSpellLevel == 0) nSpellLevel = StringToInt(lookup_spell_innate(nSpell));
    // Minimum level.
    if (nSpellLevel == 0) nSpellLevel = 1;

    int nCharges = 1;

    FloatingTextStringOnCreature("Spell Level: " + IntToString(nSpellLevel), OBJECT_SELF, FALSE);
    FloatingTextStringOnCreature("Caster Level: " + IntToString(nCaster), OBJECT_SELF, FALSE);
    FloatingTextStringOnCreature("Number of Charges: " + IntToString(nCharges), OBJECT_SELF, FALSE);

    // Gold cost multipler, varies depending on the ability used to craft
    int nMultiplier = StringToInt(Get2DACache("prc_rune_craft", "Cost", PRC_GEM_BASECOST));

    // Cost of the Gem in gold and XP
    int nCost = nSpellLevel * nCaster * nMultiplier;

    struct craft_cost_struct costs = GetModifiedCostsFromBase(nCost, oCaster, FEAT_ATTUNE_GEM, FALSE);

    FloatingTextStringOnCreature("Gold Cost: " + IntToString(costs.nGoldCost), OBJECT_SELF, FALSE);
    FloatingTextStringOnCreature("XP Cost: " + IntToString(costs.nXPCost), OBJECT_SELF, FALSE);

    // See if the caster has enough gold and XP to scribe a Gem, and that he passes the skill check.
    int nHD = GetHitDice(oCaster);
    int nMinXPForLevel = ((nHD * (nHD - 1)) / 2) * 1000;
    int nNewXP = GetXP(oCaster) - costs.nXPCost;
    int nGold = GetGold(oCaster);
    int nNewGold = nGold - costs.nGoldCost;
    int nCheck = FALSE;

    if (!GetHasGPToSpend(oCaster, costs.nGoldCost))
    {
        FloatingTextStringOnCreature("You do not have enough gold to scribe this Gem.", oCaster, FALSE);
        // Since they don't have enough, the spell casts normally
        return TRUE;
    }
    if (!GetHasXPToSpend(oCaster, costs.nXPCost) )
    {
        FloatingTextStringOnCreature("You do not have enough experience to scribe this Gem.", oCaster, FALSE);
        // Since they don't have enough, the spell casts normally
        return TRUE;
    }

    // Is the gem worth enough?
    int nGemGold = GetGoldPieceValue(oTarget);
    int nGemLevel = nGemGold / StringToInt(Get2DACache("prc_rune_craft", "Cost", PRC_GEM_PERLEVEL));
    if (nGemLevel > 9) nGemLevel = 9;
    if (nSpellLevel > nGemLevel)
    {
        FloatingTextStringOnCreature("Gem is not high enough level for this spell", oCaster, FALSE);
        // The spell casts normally
        return TRUE;
    }

    // Steal all the code from craft wand.
    int nPropID = IPGetIPConstCastSpellFromSpellID(nSpell);

    // * GZ 2003-09-11: If the current spell cast is not acid fog, and
    // *                returned property ID is 0, bail out to prevent
    // *                creation of acid fog items.
    if (nPropID == 0 && nSpell != 0)
    {
        FloatingTextStrRefOnCreature(84544,oCaster);
        return TRUE;
    }

    //check spell emulation
    if(!CheckAlternativeCrafting(oCaster, nSpell, costs))
    {
        FloatingTextStringOnCreature("*Crafting failed!*", oCaster, FALSE);
        return TRUE;
    }

    if (nPropID != -1)
    {
        itemproperty ipLevel = ItemPropertyCastSpellCasterLevel(nSpell, PRCGetCasterLevel());
        AddItemProperty(DURATION_TYPE_PERMANENT,ipLevel,oTarget);
        itemproperty ipMeta = ItemPropertyCastSpellMetamagic(nSpell, PRCGetMetaMagicFeat());
        AddItemProperty(DURATION_TYPE_PERMANENT,ipMeta,oTarget);
        itemproperty ipDC = ItemPropertyCastSpellDC(nSpell, PRCGetSaveDC(PRCGetSpellTargetObject(), OBJECT_SELF));
        AddItemProperty(DURATION_TYPE_PERMANENT,ipDC,oTarget);

        if (nCharges == 1) // This is to handle one use Gems so the spellhooking works
        {
            itemproperty ipProp = ItemPropertyCastSpell(nPropID,IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipProp,oTarget);
            // This is done so the item exists when it is used for the game to read data off of
            nCharges = 3;
        }

        SetItemCharges(oTarget, nCharges);
        SetXP(oCaster, nNewXP);
        TakeGoldFromCreature(costs.nGoldCost, oCaster, TRUE);

        string sName;
        sName = Get2DACache("spells", "Name", nSpell);
        sName = "Gem of "+GetStringByStrRef(StringToInt(sName));
        SetName(oTarget, sName);

        // This is done to allow the item to be set properly, and then alter the tag
        CopyObject(oTarget, GetLocation(oCaster), oCaster, "prc_attunegem");
        DestroyObject(oTarget, 0.1);
    }

    // If we have made it this far, they have crafted the Gem and the spell has been used up, so it returns false.
    return FALSE;
}

int CraftSkullTalisman(object oTarget = OBJECT_INVALID, object oCaster = OBJECT_INVALID, int nSpell = 0)
{
    if(!GetIsObjectValid(oCaster)) oCaster = OBJECT_SELF;
    // Get the item used to cast the spell
    object oItem = GetSpellCastItem();
    if (GetTag(oItem) == "prc_skulltalis")
    {
        string sName = GetName(GetItemPossessor(oItem));
        if (DEBUG) FloatingTextStringOnCreature(sName + " has just cast a skull talisman spell", oCaster, FALSE);

        if (DEBUG) DoDebug("Checking for One Use Skulls");
        // This check is used to clear up the one use SkullTalismans
        itemproperty ip = GetFirstItemProperty(oItem);
        while(GetIsItemPropertyValid(ip))
        {
            if(GetItemPropertyType(ip) == ITEM_PROPERTY_CAST_SPELL)
            {
                if (DEBUG) DoDebug("Skull Talisman can cast spells");
                if (GetItemPropertyCostTableValue(ip) == 5) // Only one use Skull Talismans have 2 charges per use
                {
                    if(DEBUG) DoDebug("Skull Talisman has 2 charges a use, marking it a one use Skull Talisman");
                    // Give it enough time for the spell to finish casting
                    DestroyObject(oItem, 1.0);
                    if(DEBUG) DoDebug("Skull Talisman destroyed.");
                }
            }

        ip = GetNextItemProperty(oItem);
        }
    }

    // If Inscribing is turned off, the spell functions as normal
    if(!GetLocalInt(oCaster, "CraftSkullTalisman")) return TRUE;

    // No point being in here if you don't have SkullTalismans.
    if(!GetHasFeat(FEAT_CRAFT_SKULL_TALISMAN, oCaster))
    {
        FloatingTextStrRefOnCreature(40487, oCaster); // Item Creation Failed - Don't know how to create that type of item
        return TRUE; // tried item creation but do not know how to do it
    }

        // No point scribing SkullTalismans from items, and its not allowed.
        if (oItem != OBJECT_INVALID)
        {
            FloatingTextStringOnCreature("You cannot scribe a Skull Talisman from an item.", oCaster, FALSE);
            return TRUE;
        }
    // oTarget here should be the Caster.
    if(!GetIsObjectValid(oTarget)) oTarget = PRCGetSpellTargetObject();

    int nCaster = GetAlternativeCasterLevel(oCaster, PRCGetCasterLevel(oCaster));
    int nDC = PRCGetSaveDC(oTarget, oCaster);
    if(!nSpell) nSpell = PRCGetSpellId();
    int nSpellLevel;

    if (PRCGetLastSpellCastClass() == CLASS_TYPE_CLERIC) nSpellLevel = StringToInt(lookup_spell_cleric_level(nSpell));
    else if (PRCGetLastSpellCastClass() == CLASS_TYPE_DRUID) nSpellLevel = StringToInt(lookup_spell_druid_level(nSpell));
    else if (PRCGetLastSpellCastClass() == CLASS_TYPE_WIZARD || PRCGetLastSpellCastClass() == CLASS_TYPE_SORCERER) nSpellLevel = StringToInt(lookup_spell_level(nSpell));
    // If none of these work, check the innate level of the spell
    if (nSpellLevel == 0) nSpellLevel = StringToInt(lookup_spell_innate(nSpell));
    // Minimum level.
    if (nSpellLevel == 0) nSpellLevel = 1;

    int nCharges = 1;

    FloatingTextStringOnCreature("Spell Level: " + IntToString(nSpellLevel), OBJECT_SELF, FALSE);
    FloatingTextStringOnCreature("Caster Level: " + IntToString(nCaster), OBJECT_SELF, FALSE);

    // Gold cost multipler, varies depending on the ability used to craft
    int nMultiplier = StringToInt(Get2DACache("prc_rune_craft", "Cost", PRC_SKULL_BASECOST));

    // Cost of the Skull Talisman in gold and XP
    int nCost = nSpellLevel * nCaster * nMultiplier;

    struct craft_cost_struct costs = GetModifiedCostsFromBase(nCost, oCaster, FEAT_CRAFT_SKULL_TALISMAN, FALSE);

    FloatingTextStringOnCreature("Gold Cost: " + IntToString(costs.nGoldCost), OBJECT_SELF, FALSE);
    FloatingTextStringOnCreature("XP Cost: " + IntToString(costs.nXPCost), OBJECT_SELF, FALSE);

    // See if the caster has enough gold and XP to scribe a Skull Talisman, and that he passes the skill check.
    int nHD = GetHitDice(oCaster);
    int nMinXPForLevel = ((nHD * (nHD - 1)) / 2) * 1000;
    int nNewXP = GetXP(oCaster) - costs.nXPCost;
    int nGold = GetGold(oCaster);
    int nNewGold = nGold - costs.nGoldCost;
    int nCheck = FALSE;

    if (!GetHasGPToSpend(oCaster, costs.nGoldCost))
    {
        FloatingTextStringOnCreature("You do not have enough gold to scribe this SkullTalisman.", oCaster, FALSE);
        // Since they don't have enough, the spell casts normally
        return TRUE;
    }
    if (!GetHasXPToSpend(oCaster, costs.nXPCost) )
    {
        FloatingTextStringOnCreature("You do not have enough experience to scribe this SkullTalisman.", oCaster, FALSE);
        // Since they don't have enough, the spell casts normally
        return TRUE;
    }

    // Create the item to have all the effects applied to
    oTarget = CreateItemOnObject("prc_skulltalis", oCaster, 1);

    // Steal all the code from craft wand.
    int nPropID = IPGetIPConstCastSpellFromSpellID(nSpell);

    // * GZ 2003-09-11: If the current spell cast is not acid fog, and
    // *                returned property ID is 0, bail out to prevent
    // *                creation of acid fog items.
    if (nPropID == 0 && nSpell != 0)
    {
        FloatingTextStrRefOnCreature(84544,oCaster);
        return TRUE;
    }

    //check spell emulation
    if(!CheckAlternativeCrafting(oCaster, nSpell, costs))
    {
        FloatingTextStringOnCreature("*Crafting failed!*", oCaster, FALSE);
        return TRUE;
    }

    if (nPropID != -1)
    {
        itemproperty ipLevel = ItemPropertyCastSpellCasterLevel(nSpell, PRCGetCasterLevel());
        AddItemProperty(DURATION_TYPE_PERMANENT,ipLevel,oTarget);
        itemproperty ipMeta = ItemPropertyCastSpellMetamagic(nSpell, PRCGetMetaMagicFeat());
        AddItemProperty(DURATION_TYPE_PERMANENT,ipMeta,oTarget);
        itemproperty ipDC = ItemPropertyCastSpellDC(nSpell, PRCGetSaveDC(PRCGetSpellTargetObject(), OBJECT_SELF));
        AddItemProperty(DURATION_TYPE_PERMANENT,ipDC,oTarget);

        if (nCharges == 1) // This is to handle one use Skull Talismans so the spellhooking works
        {
            itemproperty ipProp = ItemPropertyCastSpell(nPropID,IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipProp,oTarget);
            // This is done so the item exists when it is used for the game to read data off of
            nCharges = 3;
        }

        SetItemCharges(oTarget, nCharges);
        SetXP(oCaster, nNewXP);
        TakeGoldFromCreature(costs.nGoldCost, oCaster, TRUE);

        string sName;
        sName = Get2DACache("spells", "Name", nSpell);
        sName = "Skull Talisman of "+ GetStringByStrRef(StringToInt(sName));
        SetName(oTarget, sName);

        // This is done to allow the item to be set properly, and then alter the tag
        CopyObject(oTarget, GetLocation(oCaster), oCaster, "prc_skulltalis");
        DestroyObject(oTarget, 0.1);
    }

    // If we have made it this far, they have crafted the Skull Talisman and the spell has been used up, so it returns false.
    return FALSE;
}


// -----------------------------------------------------------------------------
// Georg, July 2003
// Checks if the caster intends to use his item creation feats and
// calls appropriate item creation subroutine if conditions are met
// (spell cast on correct item, etc).
// Returns TRUE if the spell was used for an item creation feat
// -----------------------------------------------------------------------------
int CIGetSpellWasUsedForItemCreation(object oSpellTarget)
{
    object oCaster = OBJECT_SELF;

    // -------------------------------------------------------------------------
    // Spell cast on crafting base item (blank scroll, etc) ?
    // -------------------------------------------------------------------------
    if (!CIGetIsCraftFeatBaseItem(oSpellTarget))
    {
       return FALSE; // not blank scroll baseitem
    }
    else
    {
        // ---------------------------------------------------------------------
        // Check Item Creation Feats were disabled through x2_inc_switches
        // ---------------------------------------------------------------------
        if (GetModuleSwitchValue(MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS) == TRUE)
        {
            FloatingTextStrRefOnCreature(83612, oCaster); // * Item creation feats are not enabled in this module *
            return FALSE;
        }
        if (GetLocalInt(GetArea(oCaster), PRC_AREA_DISABLE_CRAFTING))
        {
            FloatingTextStrRefOnCreature(16832014, oCaster); // * Item creation feats are not enabled in this area *
            return FALSE;
        }

        // ---------------------------------------------------------------------
        // Ensure that item creation does not work one item was cast on another
        // ---------------------------------------------------------------------
        if (GetSpellCastItem() != OBJECT_INVALID)
        {
            FloatingTextStrRefOnCreature(83373, oCaster); // can not use one item to enchant another
            return TRUE;
        }

        // ---------------------------------------------------------------------
        // Ok, what kind of feat the user wants to use by examining the base itm
        // ---------------------------------------------------------------------
        int nBt = GetBaseItemType(oSpellTarget);
        int nRet = FALSE;
        switch (nBt)
        {
                case BASE_ITEM_BLANK_POTION :
                            // -------------------------------------------------
                            // Brew Potion
                            // -------------------------------------------------
                           nRet = CICraftCheckBrewPotion(oSpellTarget,oCaster);
                           break;


                case BASE_ITEM_BLANK_SCROLL :
                            // -------------------------------------------------
                            // Scribe Scroll
                            // -------------------------------------------------
                           nRet = CICraftCheckScribeScroll(oSpellTarget,oCaster);
                           break;


                case BASE_ITEM_BLANK_WAND :
                            // -------------------------------------------------
                            // Craft Wand
                            // -------------------------------------------------
                           nRet = CICraftCheckCraftWand(oSpellTarget,oCaster);
                           break;

                case BASE_ITEM_CRAFTED_ROD :
                            // -------------------------------------------------
                            // Craft Rod
                            // -------------------------------------------------
                           nRet = CICraftCheckCraftRod(oSpellTarget,oCaster);
                           break;

                case BASE_ITEM_CRAFTED_STAFF :
                            // -------------------------------------------------
                            // Craft Staff
                            // -------------------------------------------------
                           nRet = CICraftCheckCraftStaff(oSpellTarget,oCaster);
                           break;

                // you could add more crafting basetypes here....
        }

        return nRet;

    }

}

// -----------------------------------------------------------------------------
// Makes oPC do a Craft check using nSkill to create the item supplied in sResRe
// If oContainer is specified, the item will be created there.
// Throwing weapons are created with stack sizes of 10, ammo with 20
// -----------------------------------------------------------------------------
object CIUseCraftItemSkill(object oPC, int nSkill, string sResRef, int nDC, object oContainer = OBJECT_INVALID)
{
    int bSuccess = GetIsSkillSuccessful(oPC, nSkill, nDC);
    object oNew;
    if (bSuccess)
    {
        // actual item creation
        // if a crafting container was specified, create inside
        int bFix;
        if (oContainer == OBJECT_INVALID)
        {
            //------------------------------------------------------------------
            // We create the item in the work container to get rid of the
            // stackable item problems that happen when we create the item
            // directly on the player
            //------------------------------------------------------------------
            oNew =CreateItemOnObject(sResRef,IPGetIPWorkContainer(oPC));
            bFix = TRUE;
        }
        else
        {
            oNew =CreateItemOnObject(sResRef,oContainer);
        }

        int nBase = GetBaseItemType(oNew);
        if (nBase ==  BASE_ITEM_BOLT || nBase ==  BASE_ITEM_ARROW || nBase ==  BASE_ITEM_BULLET)
        {
            SetItemStackSize(oNew, 20);
        }
        else if (nBase ==  BASE_ITEM_THROWINGAXE || nBase ==  BASE_ITEM_SHURIKEN || nBase ==  BASE_ITEM_DART)
        {
            SetItemStackSize(oNew, 10);
        }

        //----------------------------------------------------------------------
        // Get around the whole stackable item mess...
        //----------------------------------------------------------------------
        if (bFix)
        {
            object oRet = CopyObject(oNew,GetLocation(oPC),oPC);
            DestroyObject(oNew);
            oNew = oRet;
        }


    }
    else
    {
        oNew = OBJECT_INVALID;
    }

    return oNew;
}


// -----------------------------------------------------------------------------
// georg, 2003-06-13 (
// Craft an item. This is only to be called from the crafting conversation
// spawned by x2_s2_crafting!!!
// -----------------------------------------------------------------------------
int CIDoCraftItemFromConversation(int nNumber)
{
  string    sNumber     = IntToString(nNumber);
  object    oPC         = GetPCSpeaker();
  //object    oMaterial   = GetLocalObject(oPC,"X2_CI_CRAFT_MATERIAL");
  object    oMajor       = GetLocalObject(oPC,"X2_CI_CRAFT_MAJOR");
  object    oMinor       = GetLocalObject(oPC,"X2_CI_CRAFT_MINOR");
  int       nSkill      =  GetLocalInt(oPC,"X2_CI_CRAFT_SKILL");
  int       nMode       =  GetLocalInt(oPC,"X2_CI_CRAFT_MODE");
  string    sResult;
  string    s2DA;
  int       nDC;


    DeleteLocalObject(oPC,"X2_CI_CRAFT_MAJOR");
    DeleteLocalObject(oPC,"X2_CI_CRAFT_MINOR");

    if (!GetIsObjectValid(oMajor))
    {
          FloatingTextStrRefOnCreature(83374,oPC);    //"Invalid target"
          DeleteLocalInt(oPC,"X2_CRAFT_SUCCESS");
          return FALSE;
    }
    else
    {
          if (GetItemPossessor(oMajor) != oPC)
          {
               FloatingTextStrRefOnCreature(83354,oPC);     //"Invalid target"
               DeleteLocalInt(oPC,"X2_CRAFT_SUCCESS");
               return FALSE;
          }
    }

    // If we are in container mode,
    if (nMode == X2_CI_CRAFTMODE_CONTAINER)
    {
        if (!GetIsObjectValid(oMinor))
        {
              FloatingTextStrRefOnCreature(83374,oPC);    //"Invalid target"
              DeleteLocalInt(oPC,"X2_CRAFT_SUCCESS");
              return FALSE;
        }
        else if (GetItemPossessor(oMinor) != oPC)
         {
              FloatingTextStrRefOnCreature(83354,oPC);   //"Invalid target"
              DeleteLocalInt(oPC,"X2_CRAFT_SUCCESS");
              return FALSE;
         }
   }


  if (nSkill == 26) // craft weapon
  {
        s2DA = X2_CI_CRAFTING_WP_2DA;
  }
  else if (nSkill == 25)
  {
        s2DA = X2_CI_CRAFTING_AR_2DA;
  }

  int nRow = GetLocalInt(oPC,"X2_CI_CRAFT_RESULTROW");
  struct craft_struct stItem =  CIGetCraftItemStructFrom2DA(s2DA,nRow,nNumber);
  object oContainer = OBJECT_INVALID;

  // ---------------------------------------------------------------------------
  // We once used a crafting container, but found it too complicated. Code is still
  // left in here for the community
  // ---------------------------------------------------------------------------
  if (nMode == X2_CI_CRAFTMODE_CONTAINER)
  {
        oContainer = GetItemPossessedBy(oPC,"x2_it_craftcont");
  }

  // Do the crafting...
  object oRet = CIUseCraftItemSkill( oPC, nSkill, stItem.sResRef, stItem.nDC, oContainer) ;

  // * If you made an item, it should always be identified;
  SetIdentified(oRet,TRUE);

  if (GetIsObjectValid(oRet))
  {
      // -----------------------------------------------------------------------
      // Copy all item properties from the major object on the resulting item
      // Through we problably won't use this, its a neat thing to have for the
      // community
      // to enable magic item creation from the crafting system
      // -----------------------------------------------------------------------
       //if (GetGold(oPC)<stItem.nCost)
       if (!GetHasGPToSpend(oPC, stItem.nCost))
       {
          DeleteLocalInt(oPC,"X2_CRAFT_SUCCESS");
          FloatingTextStrRefOnCreature(86675,oPC);
          DestroyObject(oRet);
          return FALSE;
       }
       else
       {
          //TakeGoldFromCreature(stItem.nCost, oPC,TRUE);
          SpendGP(oPC, stItem.nCost);
          IPCopyItemProperties(oMajor,oRet);
        }
      // set success variable for conversation
      SetLocalInt(oPC,"X2_CRAFT_SUCCESS",TRUE);
  }
  else
  {
      //TakeGoldFromCreature(stItem.nCost / 4, oPC,TRUE);
      SpendGP(oPC, stItem.nCost/4);
      // make sure there is no success
      DeleteLocalInt(oPC,"X2_CRAFT_SUCCESS");
  }

  // Destroy first material component
  DestroyObject (oMajor);

  // if we are running in a container, destroy the second material component as well
  if (nMode == X2_CI_CRAFTMODE_CONTAINER || nMode == X2_CI_CRAFTMODE_ASSEMBLE)
  {
      DestroyObject (oMinor);
  }
  int nRet = (oRet != OBJECT_INVALID);
  return nRet;
}

// -----------------------------------------------------------------------------
// Retrieve craft information on a certain item
// -----------------------------------------------------------------------------
struct craft_struct CIGetCraftItemStructFrom2DA(string s2DA, int nRow, int nItemNo)
{
   struct craft_struct stRet;
   string sNumber = IntToString(nItemNo);

   stRet.nRow    =  nRow;
   string sLabel = Get2DACache(s2DA,"Label"+ sNumber, nRow);
   if (sLabel == "")
   {
      return stRet;  // empty, no need to read further
   }
   int nStrRef = StringToInt(sLabel);
   if (nStrRef != 0)  // Handle bioware StrRefs
   {
      sLabel = GetStringByStrRef(nStrRef);
   }
   stRet.sLabel  = sLabel;
   stRet.nDC     =  StringToInt(Get2DACache(s2DA,"DC"+ sNumber, nRow));
   stRet.nCost   =  StringToInt(Get2DACache(s2DA,"CostGP"+ sNumber, nRow));
   stRet.sResRef =  Get2DACache(s2DA,"ResRef"+ sNumber, nRow);

   return stRet;
}

// -----------------------------------------------------------------------------
// Return the cost
// -----------------------------------------------------------------------------
int CIGetItemPartModificationCost(object oOldItem, int nPart)
{
    int nRet = StringToInt(Get2DACache(X2_IP_ARMORPARTS_2DA,"CraftCost",nPart));
    nRet = (GetGoldPieceValue(oOldItem) / 100 * nRet);

    // minimum cost for modification is 1 gp
    if (nRet == 0)
    {
        nRet =1;
    }
    return nRet;
}

// -----------------------------------------------------------------------------
// Return the DC for modifying a certain armor part on oOldItem
// -----------------------------------------------------------------------------
int CIGetItemPartModificationDC(object oOldItem, int nPart)
{
    int nRet = StringToInt(Get2DACache(X2_IP_ARMORPARTS_2DA,"CraftDC",nPart));
    // minimum cost for modification is 1 gp
    return nRet;
}

// -----------------------------------------------------------------------------
// returns the dc
// dc to modify oOlditem to look like oNewItem
// -----------------------------------------------------------------------------
int CIGetArmorModificationCost(object oOldItem, object oNewItem)
{
   int nTotal = 0;
   int nPart;
   for (nPart = 0; nPart<ITEM_APPR_ARMOR_NUM_MODELS; nPart++)
   {

        if (GetItemAppearance(oOldItem,ITEM_APPR_TYPE_ARMOR_MODEL, nPart) !=GetItemAppearance(oNewItem,ITEM_APPR_TYPE_ARMOR_MODEL, nPart))
        {
            nTotal+= CIGetItemPartModificationCost(oOldItem,nPart);
        }
   }

   // Modification Cost should not exceed value of old item +1 GP
   if (nTotal > GetGoldPieceValue(oOldItem))
   {
        nTotal = GetGoldPieceValue(oOldItem)+1;
   }
   return nTotal;
}

// -----------------------------------------------------------------------------
// returns the cost in gold piece that it would
// cost to modify oOlditem to look like oNewItem
// -----------------------------------------------------------------------------
int CIGetArmorModificationDC(object oOldItem, object oNewItem)
{
   int nTotal = 0;
   int nPart;
   int nDC =0;
   for (nPart = 0; nPart<ITEM_APPR_ARMOR_NUM_MODELS; nPart++)
   {

        if (GetItemAppearance(oOldItem,ITEM_APPR_TYPE_ARMOR_MODEL, nPart) !=GetItemAppearance(oNewItem,ITEM_APPR_TYPE_ARMOR_MODEL, nPart))
        {
            nDC = CIGetItemPartModificationDC(oOldItem,nPart);
            if (nDC>nTotal)
            {
                nTotal = nDC;
            }
        }
   }

   nTotal = GetItemACValue(oOldItem) + nTotal + 5;

   return nTotal;
}

// -----------------------------------------------------------------------------
// returns TRUE if the spell matching nSpellID is prevented from being used
// with the CraftFeat matching nFeatID
// This is controlled in des_crft_spells.2da
// -----------------------------------------------------------------------------
int CIGetIsSpellRestrictedFromCraftFeat(int nSpellID, int nFeatID)
{
    string sCol;
    switch(nFeatID)
    {
        case X2_CI_BREWPOTION_FEAT_ID: sCol = "NoPotion"; break;
        case X2_CI_SCRIBESCROLL_FEAT_ID: sCol = "NoScroll"; break;
        case X2_CI_CRAFTWAND_FEAT_ID:
        case X2_CI_CRAFTROD_FEAT_ID:
        case X2_CI_CRAFTSTAFF_FEAT_ID: sCol = "NoWand"; break;
    }
    return !!StringToInt(Get2DACache(X2_CI_CRAFTING_SP_2DA,sCol,nSpellID));
}

// -----------------------------------------------------------------------------
// Retrieve the row in des_crft_bmat too look up receipe
// -----------------------------------------------------------------------------
int CIGetCraftingReceipeRow(int nMode, object oMajor, object oMinor, int nSkill)
{
    if (nMode == X2_CI_CRAFTMODE_CONTAINER || nMode == X2_CI_CRAFTMODE_ASSEMBLE )
    {
        int nMinorId = StringToInt(Get2DACache("des_crft_amat",GetTag(oMinor),1));
        int nMajorId = StringToInt(Get2DACache("des_crft_bmat",GetTag(oMajor),nMinorId));
        return nMajorId;
    }
    else if (nMode == X2_CI_CRAFTMODE_BASE_ITEM)
    {
       int nLookUpRow;
       string sTag = GetTag(oMajor);
       switch (nSkill)
       {
            case 26: nLookUpRow =1 ; break;
            case 25: nLookUpRow= 2 ; break;
       }
       int nRet = StringToInt(Get2DACache(X2_CI_CRAFTING_MAT_2DA,sTag,nLookUpRow));
       return nRet;
    }
    else
    {
        return 0; // error
    }
}

// -----------------------------------------------------------------------------
// used to set all variable required for the crafting conversation
// (Used materials, number of choises, 2da row, skill and mode)
// -----------------------------------------------------------------------------
void CISetupCraftingConversation(object oPC, int nNumber, int nSkill, int nReceipe, object oMajor, object oMinor, int nMode)
{

  SetLocalObject(oPC,"X2_CI_CRAFT_MAJOR",oMajor);
  if (nMode == X2_CI_CRAFTMODE_CONTAINER ||  nMode == X2_CI_CRAFTMODE_ASSEMBLE )
  {
      SetLocalObject(oPC,"X2_CI_CRAFT_MINOR", oMinor);
  }
  SetLocalInt(oPC,"X2_CI_CRAFT_NOOFITEMS",nNumber);    // number of crafting choises for this material
  SetLocalInt(oPC,"X2_CI_CRAFT_SKILL",nSkill);          // skill used (craft armor or craft waeapon)
  SetLocalInt(oPC,"X2_CI_CRAFT_RESULTROW",nReceipe);    // number of crafting choises for this material
  SetLocalInt(oPC,"X2_CI_CRAFT_MODE",nMode);
}

// -----------------------------------------------------------------------------
// oItem - The item used for crafting
// -----------------------------------------------------------------------------
struct craft_receipe_struct CIGetCraftingModeFromTarget(object oPC,object oTarget, object oItem = OBJECT_INVALID)
{
  struct craft_receipe_struct stStruct;


  if (GetBaseItemType(oItem) == 112 ) // small
  {
       stStruct.oMajor = oItem;
       stStruct.nMode = X2_CI_CRAFTMODE_BASE_ITEM;
       return stStruct;
  }

  if (!GetIsObjectValid(oTarget))
  {
     stStruct.nMode = X2_CI_CRAFTMODE_INVALID;
     return stStruct;
  }


  // A small craftitem was used on a large one
  if (GetBaseItemType(oItem) == 110 ) // small
  {
        if (GetBaseItemType(oTarget) == 109)  // large
        {
            stStruct.nMode = X2_CI_CRAFTMODE_ASSEMBLE; // Mode is ASSEMBLE
            stStruct.oMajor = oTarget;
            stStruct.oMinor = oItem;
            return stStruct;
        }
        else
        {
            FloatingTextStrRefOnCreature(84201,oPC);
        }

  }

  // -----------------------------------------------------------------------------
  // *** CONTAINER IS NO LONGER USED IN OFFICIAL CAMPAIGN
  //     BUT CODE LEFT IN FOR COMMUNITY.
  //     THE FOLLOWING CONDITION IS NEVER TRUE FOR THE OC (no crafting container)
  //     To reactivate, create a container with tag x2_it_craftcont
  int bCraftCont = (GetTag(oTarget) == "x2_it_craftcont");


  if (bCraftCont == TRUE)
  {
    // First item in container is baseitem  .. mode = baseitem
    if ( GetBaseItemType(GetFirstItemInInventory(oTarget)) == 112)
    {
        stStruct.nMode = X2_CI_CRAFTMODE_BASE_ITEM;
        stStruct.oMajor = GetFirstItemInInventory(oTarget);
        return stStruct;
    }
    else
    {
        object oTest = GetFirstItemInInventory(oTarget);
        int nCount =1;
        int bMajor = FALSE;
        int bMinor = FALSE;
        // No item in inventory ... mode = fail
        if (!GetIsObjectValid(oTest))
        {
            FloatingTextStrRefOnCreature(84200,oPC);
            stStruct.nMode = X2_CI_CRAFTMODE_INVALID;
            return stStruct;
        }
        else
        {
            while (GetIsObjectValid(oTest) && nCount <3)
            {
                if (GetBaseItemType(oTest) == 109)
                {
                    stStruct.oMajor = oTest;
                    bMajor = TRUE;
                }
                else if (GetBaseItemType(oTest) == 110)
                {
                    stStruct.oMinor = oTest;
                    bMinor = TRUE;
                }
                else if ( GetBaseItemType(oTest) == 112)
                {
                    stStruct.nMode = X2_CI_CRAFTMODE_BASE_ITEM;
                    stStruct.oMajor = oTest;
                    return stStruct;
                }
                oTest = GetNextItemInInventory(oTarget);
                if (GetIsObjectValid(oTest))
                {
                    nCount ++;
                }
            }

            if (nCount >2)
            {
                FloatingTextStrRefOnCreature(84356,oPC);
                stStruct.nMode = X2_CI_CRAFTMODE_INVALID;
                return stStruct;
            }
            else if (nCount <2)
            {
                FloatingTextStrRefOnCreature(84356,oPC);
                stStruct.nMode = X2_CI_CRAFTMODE_INVALID;
                return stStruct;
            }

            if (bMajor && bMinor)
            {
                stStruct.nMode =  X2_CI_CRAFTMODE_CONTAINER;
                return stStruct;
            }
            else
            {
                FloatingTextStrRefOnCreature(84356,oPC);
                //FloatingTextStringOnCreature("Temp: Wrong combination of items in the crafting container",oPC);
                stStruct.nMode = X2_CI_CRAFTMODE_INVALID;
                return stStruct;
            }

        }
    }
  }
  else
  {
    // not a container but a baseitem
    if (GetBaseItemType(oTarget) == 112)
    {
       stStruct.nMode = X2_CI_CRAFTMODE_BASE_ITEM;
       stStruct.oMajor = oTarget;
       return stStruct;

    }
    else
    {
          if (GetBaseItemType(oTarget) == 109 || GetBaseItemType(oTarget) == 110)
          {
              FloatingTextStrRefOnCreature(84357,oPC);
              stStruct.nMode = X2_CI_CRAFTMODE_INVALID;
              return stStruct;
          }
          else
          {
              FloatingTextStrRefOnCreature(84357,oPC);
              // not a valid item
              stStruct.nMode = X2_CI_CRAFTMODE_INVALID;
              return stStruct;

          }
    }
  }
}

// -----------------------------------------------------------------------------
//                 *** Crafting Conversation Functions ***
// -----------------------------------------------------------------------------
int CIGetInModWeaponOrArmorConv(object oPC)
{
    return GetLocalInt(oPC,"X2_L_CRAFT_MODIFY_CONVERSATION");
}


void CISetCurrentModMode(object oPC, int nMode)
{
    if (nMode == X2_CI_MODMODE_INVALID)
    {
        DeleteLocalInt(oPC,"X2_L_CRAFT_MODIFY_MODE");
    }
    else
    {
        SetLocalInt(oPC,"X2_L_CRAFT_MODIFY_MODE",nMode);
    }
}

int CIGetCurrentModMode(object oPC)
{
  return GetLocalInt(oPC,"X2_L_CRAFT_MODIFY_MODE");
}


object CIGetCurrentModBackup(object oPC)
{
    return GetLocalObject(GetPCSpeaker(),"X2_O_CRAFT_MODIFY_BACKUP");
}

object CIGetCurrentModItem(object oPC)
{
    return GetLocalObject(GetPCSpeaker(),"X2_O_CRAFT_MODIFY_ITEM");
}


void CISetCurrentModBackup(object oPC, object oBackup)
{
    SetLocalObject(GetPCSpeaker(),"X2_O_CRAFT_MODIFY_BACKUP",oBackup);
}

void CISetCurrentModItem(object oPC, object oItem)
{
    SetLocalObject(GetPCSpeaker(),"X2_O_CRAFT_MODIFY_ITEM",oItem);
}


// -----------------------------------------------------------------------------
// * This does multiple things:
//   -  store the part currently modified
//   -  setup the custom token for the conversation
//   -  zoom the camera to that part
// -----------------------------------------------------------------------------
void CISetCurrentModPart(object oPC, int nPart, int nStrRef)
{
    SetLocalInt(oPC,"X2_TAILOR_CURRENT_PART",nPart);

    if (CIGetCurrentModMode(oPC) == X2_CI_MODMODE_ARMOR)
    {

        // * Make the camera float near the PC
        float fFacing  = GetFacing(oPC) + 180.0;

        if (nPart == ITEM_APPR_ARMOR_MODEL_LSHOULDER || nPart == ITEM_APPR_ARMOR_MODEL_LFOREARM ||
            nPart == ITEM_APPR_ARMOR_MODEL_LHAND || nPart == ITEM_APPR_ARMOR_MODEL_LBICEP)
        {
            fFacing += 80.0;
        }

        if (nPart == ITEM_APPR_ARMOR_MODEL_RSHOULDER || nPart == ITEM_APPR_ARMOR_MODEL_RFOREARM ||
            nPart == ITEM_APPR_ARMOR_MODEL_RHAND || nPart == ITEM_APPR_ARMOR_MODEL_RBICEP)
        {
            fFacing -= 80.0;
        }

        float fPitch = 75.0;
        if (fFacing > 359.0)
        {
            fFacing -=359.0;
        }

        float  fDistance = 3.5f;
        if (nPart == ITEM_APPR_ARMOR_MODEL_PELVIS || nPart == ITEM_APPR_ARMOR_MODEL_BELT )
        {
            fDistance = 2.0f;
        }

        if (nPart == ITEM_APPR_ARMOR_MODEL_LSHOULDER || nPart == ITEM_APPR_ARMOR_MODEL_RSHOULDER )
        {
            fPitch = 50.0f;
            fDistance = 3.0f;
        }
        else  if (nPart == ITEM_APPR_ARMOR_MODEL_LFOREARM || nPart == ITEM_APPR_ARMOR_MODEL_LHAND)
        {
            fDistance = 2.0f;
            fPitch = 60.0f;
        }
        else if (nPart == ITEM_APPR_ARMOR_MODEL_NECK)
        {
            fPitch = 90.0f;
        }
        else if (nPart == ITEM_APPR_ARMOR_MODEL_RFOOT || nPart == ITEM_APPR_ARMOR_MODEL_LFOOT  )
        {
            fDistance = 3.5f;
            fPitch = 47.0f;
        }
         else if (nPart == ITEM_APPR_ARMOR_MODEL_LTHIGH || nPart == ITEM_APPR_ARMOR_MODEL_RTHIGH )
        {
            fDistance = 2.5f;
            fPitch = 65.0f;
        }
        else if (        nPart == ITEM_APPR_ARMOR_MODEL_RSHIN || nPart == ITEM_APPR_ARMOR_MODEL_LSHIN    )
        {
            fDistance = 3.5f;
            fPitch = 95.0f;
        }

        if (GetRacialType(oPC)  == RACIAL_TYPE_HALFORC)
        {
            fDistance += 1.0f;
        }

        SetCameraFacing(fFacing, fDistance, fPitch,CAMERA_TRANSITION_TYPE_VERY_FAST) ;
    }

    int nCost = GetLocalInt(oPC,"X2_TAILOR_CURRENT_COST");
    int nDC = GetLocalInt(oPC,"X2_TAILOR_CURRENT_DC");

    SetCustomToken(X2_CI_MODIFYARMOR_GP_CTOKENBASE,IntToString(nCost));
    SetCustomToken(X2_CI_MODIFYARMOR_GP_CTOKENBASE+1,IntToString(nDC));


    SetCustomToken(XP_IP_ITEMMODCONVERSATION_CTOKENBASE,GetStringByStrRef(nStrRef));
}

int CIGetCurrentModPart(object oPC)
{
    return GetLocalInt(oPC,"X2_TAILOR_CURRENT_PART");
}


void CISetDefaultModItemCamera(object oPC)
{
    float fDistance = 3.5f;
    float fPitch =  75.0f;
    float fFacing;

    if (CIGetCurrentModMode(oPC) == X2_CI_MODMODE_ARMOR)
    {
        fFacing  = GetFacing(oPC) + 180.0;
        if (fFacing > 359.0)
        {
            fFacing -=359.0;
        }
    }
    else if (CIGetCurrentModMode(oPC) == X2_CI_MODMODE_WEAPON)
    {
        fFacing  = GetFacing(oPC) + 180.0;
        fFacing -= 90.0;
        if (fFacing > 359.0)
        {
            fFacing -=359.0;
        }
    }

    SetCameraFacing(fFacing, fDistance, fPitch,CAMERA_TRANSITION_TYPE_VERY_FAST) ;
}

void CIUpdateModItemCostDC(object oPC, int nDC, int nCost)
{
        SetLocalInt(oPC,"X2_TAILOR_CURRENT_COST", nCost);
        SetLocalInt(oPC,"X2_TAILOR_CURRENT_DC",nDC);
        SetCustomToken(X2_CI_MODIFYARMOR_GP_CTOKENBASE,IntToString(nCost));
        SetCustomToken(X2_CI_MODIFYARMOR_GP_CTOKENBASE+1,IntToString(nDC));
}


// dc to modify oOlditem to look like oNewItem
int CIGetWeaponModificationCost(object oOldItem, object oNewItem)
{
   int nTotal = 0;
   int nPart;
   for (nPart = 0; nPart<=2; nPart++)
   {
        if (GetItemAppearance(oOldItem,ITEM_APPR_TYPE_WEAPON_MODEL, nPart) !=GetItemAppearance(oNewItem,ITEM_APPR_TYPE_WEAPON_MODEL, nPart))
        {
            nTotal+= (GetGoldPieceValue(oOldItem)/4)+1;
        }
   }

   // Modification Cost should not exceed value of old item +1 GP
   if (nTotal > GetGoldPieceValue(oOldItem))
   {
        nTotal = GetGoldPieceValue(oOldItem)+1;
   }
   return nTotal;
}

int GetMagicalArtisanFeat(int nCraftingFeat)
{
    int nReturn = 0;
    switch(nCraftingFeat)
    {
        case FEAT_BREW_POTION:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_BREW_POTION;
            break;
        }
        case FEAT_SCRIBE_SCROLL:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_SCRIBE_SCROLL;
            break;
        }
        case FEAT_INSCRIBE_RUNE:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_INSCRIBE_RUNE;
            break;
        }
        case FEAT_ATTUNE_GEM:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_ATTUNE_GEM;
            break;
        }
        case FEAT_CRAFT_ARMS_ARMOR:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_CRAFT_MAGIC_ARMS;
            break;
        }
        case FEAT_CRAFT_ROD:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_CRAFT_ROD;
            break;
        }
        case FEAT_CRAFT_STAFF:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_CRAFT_STAFF;
            break;
        }
        case FEAT_CRAFT_WAND:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_CRAFT_WAND;
            break;
        }
        case FEAT_CRAFT_WONDROUS:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_CRAFT_WONDROUS;
            break;
        }
        case FEAT_FORGE_RING:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_FORGE_RING;
            break;
        }
        case FEAT_CRAFT_SKULL_TALISMAN:
        {
            nReturn = FEAT_MAGICAL_ARTISAN_CRAFT_SKULL_TALISMAN;
            break;
        }
        default:
        {
            if(DEBUG) DoDebug("GetMagicalArtisanFeat: invalid crafting feat");
            break;
        }
    }
    return nReturn;
}

int GetPnPItemXPCost(int nCost, int bEpic)
{
    int nXP = nCost / 25;
    if(bEpic) nXP = (nCost / 100) + 10000;
    return nXP;
}

int GetCraftingTime(int nCost)
{
    int nTemp = nCost / 1000;
    if(nCost % 1000) nTemp++;
    float fDelay;
    switch(GetPRCSwitch(PRC_CRAFTING_TIME_SCALE))
    {
        case 0: fDelay = HoursToSeconds(nTemp); break;          //1 hour/1000gp, default
        case 1: fDelay = 0.0; break;                            //off, no delay
        case 2: fDelay = RoundsToSeconds(nTemp); break;         //1 round/1000gp
        case 3: fDelay = TurnsToSeconds(nTemp); break;          //1 turn/1000gp
        case 4: fDelay = HoursToSeconds(nTemp); break;          //1 hour/1000gp
        case 5: fDelay = 24 * HoursToSeconds(nTemp); break;     //1 day/1000gp
    }
    int nMultiplyer = GetPRCSwitch(PRC_CRAFT_TIMER_MULTIPLIER);
    if(nMultiplyer)
        fDelay *= (IntToFloat(nMultiplyer) / 100.0);
    return FloatToInt(fDelay / 6);
}

int GetModifiedGoldCost(int nCost, object oPC, int nCraftingFeat)
{
    if(nCost == 0)
        return nCost;
    float fCost = IntToFloat(nCost);
    if(GetHasFeat(FEAT_EXTRAORDINARY_ARTISAN_I        , oPC)) fCost *= 0.75;
    if(GetHasFeat(FEAT_EXTRAORDINARY_ARTISAN_II       , oPC)) fCost *= 0.75;
    if(GetHasFeat(FEAT_EXTRAORDINARY_ARTISAN_III      , oPC)) fCost *= 0.75;
    if(GetHasFeat(GetMagicalArtisanFeat(nCraftingFeat), oPC)) fCost *= 0.75;
    int nScale = GetPRCSwitch(PRC_CRAFTING_COST_SCALE);
    if(nScale > 0)
    {   //you're not getting away with negative values that easily :P
        fCost = fCost * IntToFloat(nScale) / 100.0;
    }
    return FloatToInt(fCost);
}

int GetModifiedXPCost(int nCost, object oPC, int nCraftingFeat)
{
    if(nCost == 0)
        return nCost;
    float fCost = IntToFloat(nCost);
    if(GetHasFeat(FEAT_LEGENDARY_ARTISAN_I            , oPC)) fCost *= 0.75;
    if(GetHasFeat(FEAT_LEGENDARY_ARTISAN_II           , oPC)) fCost *= 0.75;
    if(GetHasFeat(FEAT_LEGENDARY_ARTISAN_III          , oPC)) fCost *= 0.75;
    if(GetHasFeat(GetMagicalArtisanFeat(nCraftingFeat), oPC)) fCost *= 0.75;
    int nScale = GetPRCSwitch(PRC_CRAFTING_COST_SCALE);
    if(nScale > 0)
    {   //you're not getting away with negative values that easily :P
        fCost = fCost * IntToFloat(nScale) / 100.0;
    }
    return FloatToInt(fCost);
}

int GetModifiedTimeCost(int nCost, object oPC, int nCraftingFeat)
{
    if(nCost == 0)
        return nCost;
    float fCost = IntToFloat(nCost);
    if(GetLevelByClass(CLASS_TYPE_MAESTER, oPC)) fCost /= 2;
    if(GetHasFeat(FEAT_EXCEPTIONAL_ARTISAN_I          , oPC)) fCost *= 0.75;
    if(GetHasFeat(FEAT_EXCEPTIONAL_ARTISAN_II         , oPC)) fCost *= 0.75;
    if(GetHasFeat(FEAT_EXCEPTIONAL_ARTISAN_III        , oPC)) fCost *= 0.75;
    if(GetHasFeat(GetMagicalArtisanFeat(nCraftingFeat), oPC)) fCost *= 0.75;
    if(nCraftingFeat == FEAT_BREW_POTION)
    {   //master alchemist stuff here
                if(GetHasFeat(FEAT_BREW_4PERDAY       , oPC)) fCost /= 4;
        else    if(GetHasFeat(FEAT_BREW_3PERDAY       , oPC)) fCost /= 3;
        else    if(GetHasFeat(FEAT_BREW_2PERDAY       , oPC)) fCost /= 2;
    }
    int nScale = GetPRCSwitch(PRC_CRAFTING_COST_SCALE);
    if(nScale > 0)
    {   //you're not getting away with negative values that easily :P
        fCost = fCost * IntToFloat(nScale) / 100.0;
    }
    return FloatToInt(fCost);
}

struct craft_cost_struct GetModifiedCostsFromBase(int nCost, object oPC, int nCraftingFeat, int bEpic)
{
    struct craft_cost_struct costs;

    costs.nGoldCost = GetModifiedGoldCost(nCost / 2, oPC, nCraftingFeat);
    costs.nXPCost = GetModifiedXPCost(GetPnPItemXPCost(nCost, bEpic), oPC, nCraftingFeat);
    costs.nTimeCost = GetModifiedTimeCost(GetCraftingTime(nCost), oPC, nCraftingFeat);

    return costs;
}

//Checks crafting prereqs for warlocks
int CheckImbueItem(object oPC, int nSpell)
{
    if(!GetHasFeat(FEAT_IMBUE_ITEM, oPC)) return FALSE;
    int nImbueDC;
    int bArcane = TRUE;
    int nLevel;
    int nArcaneSpellLevel;
    int nDivineSpellLevel;
    string sTemp;

    sTemp = Get2DACache("spells", "Wiz_Sorc", nSpell);
    if(sTemp == "")
    {
        sTemp = Get2DACache("spells", "Bard", nSpell);
        if(sTemp == "")
        {
            bArcane = FALSE;    //now checking the divine classes
            sTemp = Get2DACache("spells", "Cleric", nSpell);
            if(sTemp == "")
            {
                sTemp = Get2DACache("spells", "Druid", nSpell);
                if(sTemp == "")
                {
                    sTemp = Get2DACache("spells", "Paladin", nSpell);
                    if(sTemp == "")
                    {
                        sTemp = Get2DACache("spells", "Ranger", nSpell);
                        if(sTemp == "")
                        {
                            if(DEBUG) DoDebug("CheckImbueItem: ERROR - spell is neither arcane nor divine");
                            return FALSE;
                        }
                    }
                }
            }
        }
    }
    //warlocks with deceive item get to take 10
    return GetPRCIsSkillSuccessful(oPC, SKILL_USE_MAGIC_DEVICE, StringToInt(sTemp) + (bArcane ? 15 : 25), GetHasFeat(FEAT_DECEIVE_ITEM, oPC) ? 10 : -1);
}

// checks alternative crafting, eg. warlock, artificer
int CheckAlternativeCrafting(object oPC, int nSpell, struct craft_cost_struct costs)
{
    //nSpell1 = (PRCGetHasSpell(nTemp, oPC)) ? -1 : StringToInt(Get2DACache("spells", "Innate", nTemp)) + 20;
    //if(nSpell1 == -1)   nSpell1     = (GetPRCIsSkillSuccessful(oPC, SKILL_USE_MAGIC_DEVICE, nSpell1, bTake10)) ? -1 : nSpell1;

    int bChecked = FALSE;
    int bSuccess = FALSE;
    int i;
    int bTake10 = GetHasFeat(FEAT_SKILL_MASTERY_ARTIFICER, oPC) ? 10 : -1;

    //artificer crafting check
    if(!bSuccess && GetLocalInt(oPC, "ArtificerCrafting"))
    {
        bChecked = TRUE;
        //bSuccess = CheckImbueItem(oPC, nSpell);
        for(i = 0; i < costs.nTimeCost; i++)
        {
            bSuccess = GetPRCIsSkillSuccessful(oPC, SKILL_USE_MAGIC_DEVICE, StringToInt(Get2DACache("spells", "Innate", nSpell)) + 20, bTake10);
            if(bSuccess)
                break;
        }
    }
    //warlock crafting check
    if(!bSuccess && GetLocalInt(oPC, "UsingImbueItem"))
    {
        bChecked = TRUE;
        bSuccess = CheckImbueItem(oPC, nSpell);
    }


    if(!bChecked)
        return TRUE;    //we never checked because we had the actual spell, so successful
    else
        return bSuccess;
}

int GetAlternativeCasterLevel(object oPC, int nLevel)
{
    if(GetLocalInt(oPC, "UsingImbueItem"))
    {
       nLevel = max(GetInvokerLevel(oPC, CLASS_TYPE_WARLOCK), nLevel);
    }
    if(GetLocalInt(oPC, "ArtificerCrafting"))
    {
       nLevel = max(GetLevelByClass(CLASS_TYPE_ARTIFICER, oPC), nLevel);
    }
    return nLevel;
}


// Test main
//void main(){}
