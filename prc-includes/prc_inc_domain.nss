//::///////////////////////////////////////////////
//:: PRC Bonus Domains
//:: prc_inc_domain.nss
//:://////////////////////////////////////////////
//:: Handles all of the code for bonus domains.
//:://////////////////////////////////////////////
//:: Created By: Stratovarius.
//:: Created On: August 31st, 2005
//:://////////////////////////////////////////////


// Function returns the domain in the input slot.
// A person can have a maximum of 5 bonus domains.
int GetBonusDomain(object oPC, int nSlot);

// Function will add a bonus domain to the stored list on the character.
void AddBonusDomain(object oPC, int nDomain);

// Uses the slot and level to find the appropriate spell, then casts it using ActionCastSpell
// It will also decrement a spell from that level
// If the domain does not have an appropriate spell for that level, an error message appears and nothing happens
void CastDomainSpell(object oPC, int nSlot, int nLevel);

// Takes the domain and spell level and uses it to find the appropriate spell.
// Right now it uses 2da reads on the domains.2da, although it could be scripted if desired.
int GetDomainSpell(int nDomain, int nLevel, object oPC);

// Takes the spell level, and returns the radial feat for that level.
// Used in case there is no spell of the appropriate level.
int SpellLevelToFeat(int nLevel);

// Will return the domain name as a string
// This is used to tell a PC what domains he has in what slot
string GetDomainName(int nDomain);

// This is the starter function, and fires from Enter and Levelup
// It checks all of the bonus domain feats, and gives the PC the correct domains
void CheckBonusDomains(object oPC);

// Returns the spell to be burned for CastDomainSpell
int GetBurnableSpell(object oPC, int nLevel);

// Returns the Domain Power feat
int GetDomainFeat(int nDomain);

// Returns the Uses per day of the feat entered
int GetDomainFeatUsesPerDay(int nFeat, object oPC);

// This counts down the number of times a domain has been used in a day
// Returns TRUE if the domain use is valid
// Returns FALSE if the player is out of uses per day
int DecrementDomainUses(int nDomain, object oPC);

// Used to determine which domain has cast the Turn Undead spell
// Returns the domain constant
int GetTurningDomain(int nSpell);

// Checks to see if the player has a domain.
// Looks for the domain power constants since every domain has those
int GetHasDomain(object oPC, int nDomain);

// Cleans the ints that limit the domain spells to being cast 1/day
void BonusDomainRest(object oPC);

//#include "prc_inc_clsfunc"
#include "prc_alterations"
#include "prc_getbest_inc"
#include "inc_dynconv"

int GetBonusDomain(object oPC, int nSlot)
{
    string sName = "PRCBonusDomain" + IntToString(nSlot);
    // Return value in case there is nothing in the slot
    int nDomain = 0;
    nDomain = GetPersistantLocalInt(oPC, sName);

    return nDomain;
}


void AddBonusDomain(object oPC, int nDomain)
{
    if (DEBUG) FloatingTextStringOnCreature("AddBonusDomain is running.", oPC, FALSE);

    // Loop through the domain slots to see if there is an open one.
    int nSlot = 1;
    int nTest = GetBonusDomain(oPC, nSlot);
    while (nTest > 0 && 5 >= nSlot)
    {
        nSlot += 1;
        // If the test domain and the domain to be added are the same
        // shut down the function, since you don't want to add a domain twice.
        if (nTest == nDomain)
        {
            FloatingTextStringOnCreature("You already have this domain as a bonus domain.", oPC, FALSE);
            return;
        }
        nTest = GetBonusDomain(oPC, nSlot);
    }
    // If you run out of slots, display message and end function
    if (nSlot > 5)
    {
        FloatingTextStringOnCreature("You have more than 5 bonus domains, your last domain is lost.", oPC, FALSE);
        return;
    }

    // If we're here, we know we have an open slot, so we add the domain into it.
    FloatingTextStringOnCreature("You have " + GetStringByStrRef(StringToInt(Get2DACache("domains", "Name", nDomain))) + " as a bonus domain", oPC, FALSE);
    string sName = "PRCBonusDomain" + IntToString(nSlot);
    SetPersistantLocalInt(oPC, sName, nDomain);
}

void CastDomainSpell(object oPC, int nSlot, int nLevel)
{
    if (DEBUG) DoDebug("CastDomainSpell has fired");
    // Mystics are not limited to how many domain spells they can cast in a day.
    if (GetLocalInt(oPC, "DomainCastSpell" + IntToString(nLevel)) && PRCGetLastSpellCastClass() != CLASS_TYPE_MYSTIC) //Already cast a spell of this level?
    {
        FloatingTextStringOnCreature("You have already cast your domain spell for level " + IntToString(nLevel), oPC, FALSE);
        return;
    }

    int nDomain = GetBonusDomain(oPC, nSlot);
    int nSpell = GetDomainSpell(nDomain, nLevel, oPC);

    if (DEBUG) DoDebug("GetDomainSpell returned " + IntToString(nSpell));
    // If there is no spell for that level, you cant cast it.
    if (nSpell == -1 && DEBUG)
    {
        FloatingTextStringOnCreature("GetDomainSpell returned an invalid spell", oPC, FALSE);
        return;
    }

    // Check to see if you can burn a spell of that slot or if the person has already
    // cast all of their level X spells for the day
    int nBurnSpell = GetBurnableSpell(oPC, nLevel);

// test CCox421
    ActionDoCommand(SetLocalInt(oPC, "Domain_Level", nLevel));

    if (nBurnSpell != -1)
    {
        ActionDoCommand(SetLocalInt(oPC, "Domain_BurnableSpell", nBurnSpell));
        SetLocalInt(oPC, "DomainCastSpell" + IntToString(nLevel), TRUE);
        DecrementRemainingSpellUses(oPC, nBurnSpell);
        // Special check for subradial spells
        if (StringToInt(Get2DACache("spells", "SubRadSpell1", nSpell)) > 0)
        {
            ActionDoCommand(SetLocalInt(oPC, "DomainOrigSpell", nSpell));
            ActionDoCommand(StartDynamicConversation("prc_domain_conv", oPC, DYNCONV_EXIT_NOT_ALLOWED, FALSE, TRUE, oPC));
        }
        else
            ActionCastSpell(nSpell);
        return;
    }


// Case of other Divine Casting

// Detection of Spontaneous Divine Casting with remaining slots

    int nCount=-1;
    int nClass = GetClassByPosition(1, oPC);

    if (GetIsDivineClass(nClass, oPC) && (GetSpellbookTypeForClass(nClass)==SPELLBOOK_TYPE_SPONTANEOUS))
    {
        nCount=persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nLevel);
    }

    if (nCount<1)
    {
        nClass = GetClassByPosition(2, oPC);
        if (GetIsDivineClass(nClass, oPC) && (GetSpellbookTypeForClass(nClass)==SPELLBOOK_TYPE_SPONTANEOUS))
        {
            nCount=persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nLevel);
        }
    }

    if (nCount<1)
    {
        nClass = GetClassByPosition(3, oPC);
        if (GetIsDivineClass(nClass, oPC) && (GetSpellbookTypeForClass(nClass)==SPELLBOOK_TYPE_SPONTANEOUS))
        {
            nCount=persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nLevel);
        }
    }

    if (nCount>=1)
    {
    // Burn the spell off, then cast the domain spell
    // Also, because of the iprop feats not having uses per day
    // set it so they can't cast again from that level
    SetLocalInt(oPC, "DomainCastSpell" + IntToString(nLevel), TRUE);
    persistant_array_set_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nLevel, nCount - 1);
    if (DEBUG) DoDebug("Spontaneous slot lost by class" + IntToString(nClass));
    ActionCastSpell(nSpell);
    return;
    }


// Detection of Prepared Divine Casting with remaining slots

    int nSpellbookID;
    int nUses;
    int nSpellLevel;
    string sArrayName;
    string sFile;
    string sSpellLevel;

    nClass = GetClassByPosition(1, oPC);
    if (GetIsDivineClass(nClass, oPC) && (GetSpellbookTypeForClass(nClass)==SPELLBOOK_TYPE_PREPARED))
    {
       sFile = GetFileForClass(nClass);
       sArrayName = "NewSpellbookMem_"+IntToString(nClass);
       //sanity test
       if(!persistant_array_exists(oPC, sArrayName))
       {
           DoDebug("ERROR: AddSpellUse: " + sArrayName + " array does not exist, creating");
           persistant_array_create(oPC, sArrayName);
       }
       nSpellbookID=1;
       nUses = 0;
       nSpellLevel = 0;
       string sSpellID = "*";

       while((nUses<1)&&(sSpellID!=""))
       {
          sSpellID = Get2DACache(sFile, "SpellID", nSpellbookID);
          sSpellLevel = Get2DACache(sFile, "Level", nSpellbookID);
          if (sSpellLevel != "")
          {
             nSpellLevel = StringToInt(sSpellLevel);
          }
          if(nSpellLevel==nLevel)
          {
             nUses = persistant_array_get_int(oPC, sArrayName, nSpellbookID);
          }
          nSpellbookID++;
       }
    }

    if(nUses <1)
    {
      nClass = GetClassByPosition(2, oPC);
      if (GetIsDivineClass(nClass, oPC) && (GetSpellbookTypeForClass(nClass)==SPELLBOOK_TYPE_PREPARED))
      {
         sFile = GetFileForClass(nClass);
         sArrayName = "NewSpellbookMem_"+IntToString(nClass);
         //sanity test
         if(!persistant_array_exists(oPC, sArrayName))
         {
             DoDebug("ERROR: AddSpellUse: " + sArrayName + " array does not exist, creating");
             persistant_array_create(oPC, sArrayName);
         }
         nSpellbookID=1;
         nUses = 0;
         nSpellLevel = 0;
         string sSpellID = "*";

         while((nUses<1)&&(sSpellID!=""))
         {
            sSpellID = Get2DACache(sFile, "SpellID", nSpellbookID);
            sSpellLevel = Get2DACache(sFile, "Level", nSpellbookID);
            if (sSpellLevel != "")
            {
               nSpellLevel = StringToInt(sSpellLevel);
            }
            if(nSpellLevel==nLevel)
            {
               nUses = persistant_array_get_int(oPC, sArrayName, nSpellbookID);
            }
            nSpellbookID++;
         }
      }
    }

    if(nUses <1)
    {
      nClass = GetClassByPosition(3, oPC);
      if (GetIsDivineClass(nClass, oPC) && (GetSpellbookTypeForClass(nClass)==SPELLBOOK_TYPE_PREPARED))
      {
         sFile = GetFileForClass(nClass);
         sArrayName = "NewSpellbookMem_"+IntToString(nClass);
         //sanity test
         if(!persistant_array_exists(oPC, sArrayName))
         {
             DoDebug("ERROR: AddSpellUse: " + sArrayName + " array does not exist, creating");
             persistant_array_create(oPC, sArrayName);
         }
         nSpellbookID=1;
         nUses = 0;
         nSpellLevel = 0;
         string sSpellID = "*";

         while((nUses<1)&&(sSpellID!=""))
         {
            sSpellID = Get2DACache(sFile, "SpellID", nSpellbookID);
            sSpellLevel = Get2DACache(sFile, "Level", nSpellbookID);
            if (sSpellLevel != "")
            {
               nSpellLevel = StringToInt(sSpellLevel);
            }
            if(nSpellLevel==nLevel)
            {
               nUses = persistant_array_get_int(oPC, sArrayName, nSpellbookID);
            }
            nSpellbookID++;
         }
      }
    }

    if(nUses>=1)
    {
     if (DEBUG) DoDebug("Prepared slot lost by class" + IntToString(nClass));
     // Burn the spell off, then cast the domain spell
     // Also, because of the iprop feats not having uses per day
     // set it so they can't cast again from that level
    persistant_array_set_int(oPC, sArrayName, nSpellbookID, nUses-1);
     SetLocalInt(oPC, "DomainCastSpell" + IntToString(nLevel), TRUE);
     ActionCastSpell(nSpell, GetLevelByTypeDivine(oPC));
     return;
    }

    //No spell left to burn? Tell the player that.
    FloatingTextStringOnCreature("You have no spells left to trade for a domain spell.", oPC, FALSE);
    return;

// End of test CCox421
}

int GetDomainSpell(int nDomain, int nLevel, object oPC)
{
    // The -1 on nDomains is to adjust from a base 1 to a base 0 system.
    string sSpell = Get2DACache("domains", "Level_" + IntToString(nLevel), (nDomain - 1));
    if (DEBUG) FloatingTextStringOnCreature("Domain Spell: " + sSpell, oPC, FALSE);
    if (DEBUG) FloatingTextStringOnCreature("GetDomainSpell has fired", oPC, FALSE);
    int nSpell = -1;
    if (sSpell == "")
    {
        FloatingTextStringOnCreature("You do not have a domain spell of that level.", oPC, FALSE);
        int nFeat = SpellLevelToFeat(nLevel);
        IncrementRemainingFeatUses(oPC, nFeat);
    }
    else
    {
        nSpell = StringToInt(sSpell);
    }

    return nSpell;
}

int SpellLevelToFeat(int nLevel)
{
    int nFeat;
    if (nLevel == 1)      nFeat = FEAT_CAST_DOMAIN_LEVEL_ONE;
    else if (nLevel == 2) nFeat = FEAT_CAST_DOMAIN_LEVEL_TWO;
    else if (nLevel == 3) nFeat = FEAT_CAST_DOMAIN_LEVEL_THREE;
    else if (nLevel == 4) nFeat = FEAT_CAST_DOMAIN_LEVEL_FOUR;
    else if (nLevel == 5) nFeat = FEAT_CAST_DOMAIN_LEVEL_FIVE;
    else if (nLevel == 6) nFeat = FEAT_CAST_DOMAIN_LEVEL_SIX;
    else if (nLevel == 7) nFeat = FEAT_CAST_DOMAIN_LEVEL_SEVEN;
    else if (nLevel == 8) nFeat = FEAT_CAST_DOMAIN_LEVEL_EIGHT;
    else if (nLevel == 9) nFeat = FEAT_CAST_DOMAIN_LEVEL_NINE;

    return nFeat;
}

string GetDomainName(int nDomain)
{
    string sName;
    // Check that the domain slot is not empty
    if(nDomain != 0)
    {
        sName = Get2DACache("domains", "Name", (nDomain - 1));
        sName = GetStringByStrRef(StringToInt(sName));
    }
    else
        sName = GetStringByStrRef(6497); // "Empty Slot"

    return sName;
}

void CheckBonusDomains(object oPC)
{

    int nSlot = 1;
    int nBonusDomain = GetBonusDomain(oPC, nSlot);
    while (5 >= nSlot)
    {
        int nDomainFeat = GetDomainFeat(nBonusDomain);
        if(!GetHasFeat(nDomainFeat, oPC)) SetPersistantLocalInt(oPC, "PRCBonusDomain" + IntToString(nSlot), 0);
        //SendMessageToPC(oPC, "PRCBonusDomain"+IntToString(nSlot)" = "+IntToString(nBonusDomain));
        //SendMessageToPC(oPC, "PRCBonusDomain"+IntToString(nSlot)" feat = "+IntToString(GetDomainFeat(nDomainFeat)));
        nSlot += 1;
        nBonusDomain = GetBonusDomain(oPC, nSlot);
    }

    if (GetHasFeat(FEAT_BONUS_DOMAIN_AIR,           oPC)) AddBonusDomain(oPC, DOMAIN_AIR);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_ANIMAL,        oPC)) AddBonusDomain(oPC, DOMAIN_ANIMAL);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_DEATH,         oPC)) AddBonusDomain(oPC, DOMAIN_DEATH);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_DESTRUCTION,   oPC)) AddBonusDomain(oPC, DOMAIN_DESTRUCTION);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_EARTH,         oPC)) AddBonusDomain(oPC, DOMAIN_EARTH);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_EVIL,          oPC)) AddBonusDomain(oPC, DOMAIN_EVIL);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_FIRE,          oPC)) AddBonusDomain(oPC, DOMAIN_FIRE);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_GOOD,          oPC)) AddBonusDomain(oPC, DOMAIN_GOOD);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_HEALING,       oPC)) AddBonusDomain(oPC, DOMAIN_HEALING);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_KNOWLEDGE,     oPC)) AddBonusDomain(oPC, DOMAIN_KNOWLEDGE);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_MAGIC,         oPC)) AddBonusDomain(oPC, DOMAIN_MAGIC);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_PLANT,         oPC)) AddBonusDomain(oPC, DOMAIN_PLANT);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_PROTECTION,    oPC)) AddBonusDomain(oPC, DOMAIN_PROTECTION);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_STRENGTH,      oPC)) AddBonusDomain(oPC, DOMAIN_STRENGTH);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_SUN,           oPC)) AddBonusDomain(oPC, DOMAIN_SUN);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_TRAVEL,        oPC)) AddBonusDomain(oPC, DOMAIN_TRAVEL);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_TRICKERY,      oPC)) AddBonusDomain(oPC, DOMAIN_TRICKERY);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_WAR,           oPC)) AddBonusDomain(oPC, DOMAIN_WAR);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_WATER,         oPC)) AddBonusDomain(oPC, DOMAIN_WATER);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_DARKNESS,      oPC)) AddBonusDomain(oPC, DOMAIN_DARKNESS);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_STORM,         oPC)) AddBonusDomain(oPC, DOMAIN_STORM);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_METAL,         oPC)) AddBonusDomain(oPC, DOMAIN_METAL);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_PORTAL,        oPC)) AddBonusDomain(oPC, DOMAIN_PORTAL);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_FORCE,         oPC)) AddBonusDomain(oPC, DOMAIN_FORCE);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_SLIME,         oPC)) AddBonusDomain(oPC, DOMAIN_SLIME);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_TYRANNY,       oPC)) AddBonusDomain(oPC, DOMAIN_TYRANNY);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_DOMINATION,    oPC)) AddBonusDomain(oPC, DOMAIN_DOMINATION);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_SPIDER,        oPC)) AddBonusDomain(oPC, DOMAIN_SPIDER);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_UNDEATH,       oPC)) AddBonusDomain(oPC, DOMAIN_UNDEATH);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_TIME,          oPC)) AddBonusDomain(oPC, DOMAIN_TIME);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_DWARF,         oPC)) AddBonusDomain(oPC, DOMAIN_DWARF);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_CHARM,         oPC)) AddBonusDomain(oPC, DOMAIN_CHARM);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_ELF,           oPC)) AddBonusDomain(oPC, DOMAIN_ELF);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_FAMILY,        oPC)) AddBonusDomain(oPC, DOMAIN_FAMILY);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_FATE,          oPC)) AddBonusDomain(oPC, DOMAIN_FATE);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_GNOME,         oPC)) AddBonusDomain(oPC, DOMAIN_GNOME);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_ILLUSION,      oPC)) AddBonusDomain(oPC, DOMAIN_ILLUSION);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_HATRED,        oPC)) AddBonusDomain(oPC, DOMAIN_HATRED);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_HALFLING,      oPC)) AddBonusDomain(oPC, DOMAIN_HALFLING);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_NOBILITY,      oPC)) AddBonusDomain(oPC, DOMAIN_NOBILITY);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_OCEAN,         oPC)) AddBonusDomain(oPC, DOMAIN_OCEAN);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_ORC,           oPC)) AddBonusDomain(oPC, DOMAIN_ORC);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_RENEWAL,       oPC)) AddBonusDomain(oPC, DOMAIN_RENEWAL);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_RETRIBUTION,   oPC)) AddBonusDomain(oPC, DOMAIN_RETRIBUTION);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_RUNE,          oPC)) AddBonusDomain(oPC, DOMAIN_RUNE);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_SPELLS,        oPC)) AddBonusDomain(oPC, DOMAIN_SPELLS);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_SCALEYKIND,    oPC)) AddBonusDomain(oPC, DOMAIN_SCALEYKIND);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_BLIGHTBRINGER, oPC)) AddBonusDomain(oPC, DOMAIN_BLIGHTBRINGER);
    if (GetHasFeat(FEAT_BONUS_DOMAIN_DRAGON,        oPC)) AddBonusDomain(oPC, DOMAIN_DRAGON);

    if (DEBUG) FloatingTextStringOnCreature("Check Bonus Domains is running", oPC, FALSE);
}

int GetBurnableSpell(object oPC, int nLevel)
{
    int nBurnableSpell = -1;

    if (nLevel == 1)      nBurnableSpell = GetBestL1Spell(oPC, nBurnableSpell);
    else if (nLevel == 2) nBurnableSpell = GetBestL2Spell(oPC, nBurnableSpell);
    else if (nLevel == 3) nBurnableSpell = GetBestL3Spell(oPC, nBurnableSpell);
    else if (nLevel == 4) nBurnableSpell = GetBestL4Spell(oPC, nBurnableSpell);
    else if (nLevel == 5) nBurnableSpell = GetBestL5Spell(oPC, nBurnableSpell);
    else if (nLevel == 6) nBurnableSpell = GetBestL6Spell(oPC, nBurnableSpell);
    else if (nLevel == 7) nBurnableSpell = GetBestL7Spell(oPC, nBurnableSpell);
    else if (nLevel == 8) nBurnableSpell = GetBestL8Spell(oPC, nBurnableSpell);
    else if (nLevel == 9) nBurnableSpell = GetBestL9Spell(oPC, nBurnableSpell);

    return nBurnableSpell;
}

int GetDomainFeat(int nDomain)
{
    // The -1 on nDomain is to adjust from a base 1 to a base 0 system.
    // Returns the domain power feat
    return StringToInt(Get2DACache("domains", "GrantedFeat", nDomain - 1));
}

int GetDomainFeatUsesPerDay(int nFeat, object oPC)
{
    int nUses = StringToInt(Get2DACache("feat", "USESPERDAY", nFeat));
    // These are the domains that have ability based uses per day
    if (nUses == 33)
    {
        // The Strength domain, which uses Strength when the Cleric has Kord levels
        // Without Kord levels, its 1 use per day
        if(nFeat == FEAT_STRENGTH_DOMAIN_POWER)
        {
            nUses = 1;
            if (GetLevelByClass(CLASS_TYPE_MIGHTY_CONTENDER_KORD, oPC) > 0) nUses = GetAbilityModifier(ABILITY_STRENGTH, oPC);
            // Catching exceptions
            if (nUses < 1) nUses = 1;
        }
        if(nFeat == FEAT_SUN_DOMAIN_POWER)
        {
            if(!GetHasTurnUndead(oPC) && GetLevelByClass(CLASS_TYPE_MYSTIC, oPC))
            {
                nUses = GetHasFeat(FEAT_EXTRA_TURNING, oPC) ? 7 : 3;
                nUses += GetAbilityModifier(ABILITY_CHARISMA, oPC);
            }
            else
                nUses = 1;
        }

        // All other ones so far are the Charisma based turning domains
        nUses = 3 + GetAbilityModifier(ABILITY_CHARISMA, oPC);
    }

    return nUses;
}

int DecrementDomainUses(int nDomain, object oPC)
{
    int nReturn = TRUE;
    int nUses = GetLocalInt(oPC, "BonusDomainUsesPerDay" + GetDomainName(nDomain));
    // If there is still a valid use left, remove it
    if (nUses >= 1) SetLocalInt(oPC, "BonusDomainUsesPerDay" + GetDomainName(nDomain), (nUses - 1));
    // Tell the player how many uses he has left
    else // He has no more uses for the day
    {
        nReturn = FALSE;
    }

    FloatingTextStringOnCreature("You have " + IntToString(nUses - 1) + " uses per day left of the " + GetDomainName(nDomain) + " power.", oPC, FALSE);

    return nReturn;
}

int GetTurningDomain(int nSpell)
{
    int nDomain;
    if (nSpell == SPELL_TURN_REPTILE) nDomain = DOMAIN_SCALEYKIND;
    else if (nSpell == SPELL_TURN_OOZE) nDomain = DOMAIN_SLIME;
    else if (nSpell == SPELL_TURN_SPIDER) nDomain = DOMAIN_SPIDER;
    else if (nSpell == SPELL_TURN_PLANT) nDomain = DOMAIN_PLANT;
    else if (nSpell == SPELL_TURN_AIR) nDomain = DOMAIN_AIR;
    else if (nSpell == SPELL_TURN_EARTH) nDomain = DOMAIN_EARTH;
    else if (nSpell == SPELL_TURN_FIRE) nDomain = DOMAIN_FIRE;
    else if (nSpell == SPELL_TURN_WATER) nDomain = DOMAIN_WATER;
    else if (nSpell == SPELL_TURN_BLIGHTSPAWNED) nDomain = DOMAIN_BLIGHTBRINGER;

    return nDomain;
}

int GetHasDomain(object oPC, int nDomain)
{
    // Get the domain power feat for the appropriate domain
    int nFeat = GetDomainFeat(nDomain);
    // If they have the feat, return true
    if (GetHasFeat(nFeat, oPC)) return TRUE;

    return FALSE;
}

void BonusDomainRest(object oPC)
{
    // Bonus Domain ints that limit you to casting 1/day per level
    int i;
    for (i = 1; i < 10; i++)
    {
        DeleteLocalInt(oPC, "DomainCastSpell" + IntToString(i));
    }

    // This is code to stop you from using the Domain per day abilities more than you should be able to
    int i2;
    // Highest domain constant is 59
    for (i2 = 1; i2 < 60; i2++)
    {
        // This is to ensure they only get the ints set for the domains they do have
        if (GetHasDomain(oPC, i2))
        {
            // Store the number of uses a day here
            SetLocalInt(oPC, "BonusDomainUsesPerDay" + GetDomainName(i2), GetDomainFeatUsesPerDay(GetDomainFeat(i2), oPC));
        }
    }
}

int DomainGetCasterLevel(object oPC)
{
    int nLevel = GetLevelByClass(CLASS_TYPE_CLERIC, oPC)
               + GetLevelByClass(CLASS_TYPE_MYSTIC, oPC)
               + GetLevelByClass(CLASS_TYPE_SHAMAN, oPC)
               + GetLevelByClass(CLASS_TYPE_TEMPLAR, oPC);

    return nLevel;
}