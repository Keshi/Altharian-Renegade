//::///////////////////////////////////////////////
//:: Invocation include: Miscellaneous
//:: tob_inc_tobfunc
//::///////////////////////////////////////////////
/** @file
    Defines various functions and other stuff that
    do something related to Invocation implementation.

    Also acts as inclusion nexus for the general
    invocation includes. In other words, don't include
    them directly in your scripts, instead include this.

    @author Fox
    @date   Created - 2008.1.25
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

const int    INVOCATION_DRACONIC    = 1;
const int    INVOCATION_WARLOCK     = 2;

const int    INVOCATION_LEAST       = 2;
const int    INVOCATION_LESSER      = 4;
const int    INVOCATION_GREATER     = 6;
const int    INVOCATION_DARK        = 8;

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

/**
 * Determines from what class's invocation list the currently casted
 * invocation is cast from.
 *
 * @param oInvoker  A creature invoking at this moment
 * @return            CLASS_TYPE_* constant of the class
 */
int GetInvokingClass(object oInvoker = OBJECT_SELF);

/**
 * Determines the given creature's Invoker level. If a class is specified,
 * then returns the Invoker level for that class. Otherwise, returns
 * the Invoker level for the currently active invocation.
 *
 * @param oInvoker       The creature whose Invoker level to determine
 * @param nSpecificClass The class to determine the creature's Invoker
 *                       level in.
 * @param nUseHD         If this is set, it returns the Character Level of the calling creature.
 *                       DEFAULT: CLASS_TYPE_INVALID, which means the creature's
 *                       Invoker level in regards to an ongoing invocation
 *                       is determined instead.
 * @return               The Invoker level
 */
int GetInvokerLevel(object oInvoker, int nSpecificClass = CLASS_TYPE_INVALID, int nUseHD = FALSE);

/**
 * Determines whether a given creature uses Invocations.
 * Requires either levels in an invocation-related class or
 * natural Invocation ability based on race.
 *
 * @param oCreature Creature to test
 * @return          TRUE if the creature can use Invocations, FALSE otherwise.
 */
int GetIsInvocationUser(object oCreature);

/**
 * Determines the given creature's highest undmodified Invoker level among it's
 * invoking classes.
 *
 * @param oCreature Creature whose highest Invoker level to determine
 * @return          The highest unmodified Invoker level the creature can have
 */
int GetHighestInvokerLevel(object oCreature);

/**
 * Determines whether a given class is an invocation-related class or not.
 *
 * @param nClass CLASS_TYPE_* of the class to test
 * @return       TRUE if the class is an invocation-related class, FALSE otherwise
 */
int GetIsInvocationClass(int nClass);

/**
 * Gets the level of the invocation being currently cast.
 * WARNING: Return value is not defined when an invocation is not being cast.
 *
 * @param oInvoker    The creature currently casting an invocation
 * @return            The level of the invocation being cast
 */
int GetInvocationLevel(object oInvoker);

/**
 * Returns the name of the invocation
 *
 * @param nSpellId        SpellId of the invocation
 */
string GetInvocationName(int nSpellId);

/**
 * Calculates how many invoker levels are gained by a given creature from
 * it's levels in prestige classes.
 *
 * @param oCreature Creature to calculate added invoker levels for
 * @return          The number of invoker levels gained
 */
int GetInvocationPRCLevels(object oCaster);

/**
 * Determines which of the character's classes is their highest or first invocation
 * casting class, if any. This is the one which gains invoker level raise benefits
 * from prestige classes.
 *
 * @param oCreature Creature whose classes to test
 * @return          CLASS_TYPE_* of the first invocation casting class,
 *                  CLASS_TYPE_INVALID if the creature does not possess any.
 */
int GetPrimaryInvocationClass(object oCreature = OBJECT_SELF);

/**
 * Determines the position of a creature's first invocation casting class, if any.
 *
 * @param oCreature Creature whose classes to test
 * @return          The position of the first invocation class {1, 2, 3} or 0 if
 *                  the creature possesses no levels in invocation classes.
 */
int GetFirstInvocationClassPosition(object oCreature = OBJECT_SELF);

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "inv_invoc_const"
//#include "prc_alterations"
#include "inv_inc_invknown"
#include "inv_inc_invoke"
#include "prc_add_spell_dc"

//////////////////////////////////////////////////
/*             Internal functions               */
//////////////////////////////////////////////////


//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

int GetInvokingClass(object oInvoker = OBJECT_SELF)
{
    return GetLocalInt(oInvoker, PRC_INVOKING_CLASS) - 1;
}

int GetInvokerLevel(object oInvoker, int nSpecificClass = CLASS_TYPE_INVALID, int nUseHD = FALSE)
{
    int nLevel;
    int nTotalHD = GetHitDice(oInvoker);
    int nAdjust = GetLocalInt(oInvoker, PRC_CASTERLEVEL_ADJUSTMENT);
    
    nLevel = GetLevelByClass(GetPrimaryInvocationClass(oInvoker), oInvoker);
    // If this is set, return the user's HD
    if (nUseHD) return GetHitDice(oInvoker);

    // The function user needs to know the character's Invoker level in a specific class
    // instead of whatever the character last cast an invocation as
    if(nSpecificClass != CLASS_TYPE_INVALID)
    {
        if(GetIsInvocationClass(nSpecificClass))
        {
            int nClassLevel = GetLevelByClass(nSpecificClass, oInvoker);
            if(DEBUG) DoDebug("Invoker Class Level is: " + IntToString(nClassLevel));
            if (nClassLevel > 0)
            {
                // Invoker level is class level + any arcane spellcasting or invoking levels in any PRCs
                nLevel = nClassLevel + GetInvocationPRCLevels(oInvoker);
            }
        }
        // A character with no Invoker levels can't use Invocations
        else
            return 0;
    }

    // Item Spells
    if(GetItemPossessor(GetSpellCastItem()) == oInvoker)
    {
        if(DEBUG) SendMessageToPC(oInvoker, "Item casting at level " + IntToString(GetCasterLevel(oInvoker)));

        return GetCasterLevel(oInvoker) + nAdjust;
    }

    // For when you want to assign the caster level.
    else if(GetLocalInt(oInvoker, PRC_CASTERLEVEL_OVERRIDE) != 0)
    {
        if(DEBUG) SendMessageToPC(oInvoker, "Forced-level Invoking at level " + IntToString(GetCasterLevel(oInvoker)));

        DelayCommand(1.0, DeleteLocalInt(oInvoker, PRC_CASTERLEVEL_OVERRIDE));
        nLevel = GetLocalInt(oInvoker, PRC_CASTERLEVEL_OVERRIDE);
    }

    // If everything else fails, use the character's first class position
    if(nLevel == 0)
    {
        if(DEBUG)             DoDebug("Failed to get Invoker level for creature " + DebugObject2Str(oInvoker) + ", using first class slot");
        else WriteTimestampedLogEntry("Failed to get Invoker level for creature " + DebugObject2Str(oInvoker) + ", using first class slot");

        nLevel = GetLevelByPosition(1, oInvoker);
    }

    nLevel += nAdjust;

    // This spam is technically no longer necessary once the Invoker level getting mechanism has been confirmed to work
    //if(DEBUG) FloatingTextStringOnCreature("Invoker Level: " + IntToString(nLevel), oInvoker, FALSE);

    return nLevel;
}

int GetIsInvocationUser(object oCreature)
{
    return !!(GetLevelByClass(CLASS_TYPE_DRAGONFIRE_ADEPT, oCreature) ||
              GetLevelByClass(CLASS_TYPE_WARLOCK, oCreature)
             );
}

int GetHighestInvokerLevel(object oCreature)
{
    return max(max(GetClassByPosition(1, oCreature) != CLASS_TYPE_INVALID ? GetInvokerLevel(oCreature, GetClassByPosition(1, oCreature)) : 0,
                   GetClassByPosition(2, oCreature) != CLASS_TYPE_INVALID ? GetInvokerLevel(oCreature, GetClassByPosition(2, oCreature)) : 0
                   ),
               GetClassByPosition(3, oCreature) != CLASS_TYPE_INVALID ? GetInvokerLevel(oCreature, GetClassByPosition(3, oCreature)) : 0
               );
}

int GetIsInvocationClass(int nClass)
{
    return (nClass == CLASS_TYPE_DRAGONFIRE_ADEPT ||
            nClass == CLASS_TYPE_WARLOCK 
            );
}

int GetInvocationLevel(object oInvoker)
{
    return GetLocalInt(oInvoker, PRC_INVOCATION_LEVEL);
}

string GetInvocationName(int nSpellId)
{
        return GetStringByStrRef(StringToInt(Get2DACache("spells", "Name", nSpellId)));
}

int GetInvocationPRCLevels(object oCaster)
{
    int nLevel = 0;
    
    //_some_ arcane spellcasting levels boost invocations
    if (GetLocalInt(oCaster, "INV_Caster") == 2)
    	nLevel += (GetLevelByClass(CLASS_TYPE_ACOLYTE,              oCaster) + 1) / 2
    	       +  (GetLevelByClass(CLASS_TYPE_DISCIPLE_OF_ASMODEUS, oCaster) + 1) / 2
    	       +   GetLevelByClass(CLASS_TYPE_ENLIGHTENEDFIST,      oCaster)
    	       +   GetLevelByClass(CLASS_TYPE_MAESTER,              oCaster);

    return nLevel;
}

int GetPrimaryInvocationClass(object oCreature = OBJECT_SELF)
{
    int nClass;

    if(GetPRCSwitch(PRC_CASTERLEVEL_FIRST_CLASS_RULE))
    {
        int nInvocationPos = GetFirstInvocationClassPosition(oCreature);
        if (!nInvocationPos) return CLASS_TYPE_INVALID; // no invoking class

        nClass = GetClassByPosition(nInvocationPos, oCreature);
    }
    else
    {
        int nClassLvl;
        int nClass1, nClass2, nClass3;
        int nClass1Lvl, nClass2Lvl, nClass3Lvl;

        nClass1 = GetClassByPosition(1, oCreature);
        nClass2 = GetClassByPosition(2, oCreature);
        nClass3 = GetClassByPosition(3, oCreature);
        if(GetIsInvocationClass(nClass1)) nClass1Lvl = GetLevelByClass(nClass1, oCreature);
        if(GetIsInvocationClass(nClass2)) nClass2Lvl = GetLevelByClass(nClass2, oCreature);
        if(GetIsInvocationClass(nClass3)) nClass3Lvl = GetLevelByClass(nClass3, oCreature);

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

int GetFirstInvocationClassPosition(object oCreature = OBJECT_SELF)
{
    if (GetIsInvocationClass(GetClassByPosition(1, oCreature)))
        return 1;
    if (GetIsInvocationClass(GetClassByPosition(2, oCreature)))
        return 2;
    if (GetIsInvocationClass(GetClassByPosition(3, oCreature)))
        return 3;

    return 0;
}

int GetInvocationSaveDC(object oTarget, object oCaster, int nSpellID = -1)
{
    object oItem = GetSpellCastItem();
    if(nSpellID == -1)
        nSpellID = PRCGetSpellId();
    //10+spelllevel+stat(cha default)
    int nDC = 10;
    nDC += StringToInt(Get2DACache("Spells", "Innate", nSpellID));
    nDC += GetAbilityModifier(ABILITY_CHARISMA, oCaster);
    // For when you want to assign the caster DC
    //this does not take feat/race/class into account, it is an absolute override
    if (GetLocalInt(oCaster, PRC_DC_TOTAL_OVERRIDE) != 0)
    {
        nDC = GetLocalInt(oCaster, PRC_DC_TOTAL_OVERRIDE);
        DoDebug("Forced-DC PRC_DC_TOTAL_OVERRIDE casting at DC " + IntToString(nDC));
    }
    // For when you want to assign the caster DC
    //this does take feat/race/class into account, it only overrides the baseDC
    else if (GetLocalInt(oCaster, PRC_DC_BASE_OVERRIDE) != 0)
    {
        nDC = GetLocalInt(oCaster, PRC_DC_BASE_OVERRIDE);
        if(nDC == -1)
        {
            nDC = 10;
            nDC += StringToInt(Get2DACache("Spells", "Innate", nSpellID));
            nDC += GetAbilityModifier(ABILITY_CHARISMA, oCaster);
        }

        if(DEBUG) DoDebug("Forced Base-DC casting at DC " + IntToString(nDC));
        nDC += GetChangesToSaveDC(oTarget, oCaster, nSpellID);
    }
    else if(GetIsObjectValid(oItem)
        && !(GetBaseItemType(oItem) == BASE_ITEM_MAGICSTAFF
                && GetPRCSwitch(PRC_STAFF_CASTER_LEVEL)))
    {
        //code for getting new ip type
        itemproperty ipTest = GetFirstItemProperty(oItem);
        while(GetIsItemPropertyValid(ipTest))
        {
            if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_CAST_SPELL_DC)
            {
                int nSubType = GetItemPropertySubType(ipTest);
                nSubType = StringToInt(Get2DACache("iprp_spells", "SpellIndex", nSubType));
                if(nSubType == nSpellID)
                {
                    nDC = GetItemPropertyCostTableValue (ipTest);
                    break;//end while
                }
            }
            ipTest = GetNextItemProperty(oItem);
        }
    }
    else
        nDC += GetChangesToSaveDC(oTarget, oCaster, nSpellID);
    return nDC;
}

void ClearInvocationLocalVars(object oPC)
{

    //Invocations
    if (DEBUG) DoDebug("Clearing invocation flags");
    DeleteLocalInt(oPC, "ChillingFogLock");
    //Endure Exposure wearing off
    array_delete(oPC, "BreathProtected");
    DeleteLocalInt(oPC, "DragonWard");

    //cleaning targets of Endure exposure cast by resting caster
    if (array_exists(oPC, "BreathProtectTargets"))
    {
        if(DEBUG) DoDebug("Checking for casts of Endure Exposure");
        int nBPTIndex = 0;
        int bCasterDone = FALSE;
        int bTargetDone = FALSE;
        object oBreathTarget;
        while(!bCasterDone)
        {
                oBreathTarget = array_get_object(oPC, "BreathProtectTargets", nBPTIndex);
                if(DEBUG) DoDebug("Possible target: " + GetName(oBreathTarget) + " - " + ObjectToString(oBreathTarget));
		if(oBreathTarget != OBJECT_INVALID)
	    	{
                      //replace caster with target... always immune to own breath, so good way to erase caster from array without deleting whole array
		      int nBPIndex = 0;			      

                      while(!bTargetDone)
                      {
			      if(DEBUG) DoDebug("Checking " + GetName(oBreathTarget));
			      //if it matches, remove and end
			      if(array_get_object(oBreathTarget, "BreathProtected", nBPIndex) == oPC)
			      {
				        array_set_object(oBreathTarget, "BreathProtected", nBPIndex, oBreathTarget);
                                        bTargetDone = TRUE;
                                        if(DEBUG) DoDebug("Found caster, clearing.");
			      }
			      //if it is not end of array, keep going
			      else if(array_get_object(oBreathTarget, "BreathProtected", nBPTIndex) != OBJECT_INVALID)
			      {
				       nBPIndex++;
			      }  
                              else
                                       bTargetDone = TRUE;

                      }

		      nBPTIndex++;
                      bTargetDone = FALSE;

		}
		else
                {
		      array_delete(oPC, "BreathProtectTargets");
                      bCasterDone = TRUE;
                }
     	}
    }
}

// Test main
//void main(){}
