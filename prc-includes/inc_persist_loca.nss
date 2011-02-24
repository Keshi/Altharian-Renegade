//::///////////////////////////////////////////////
//:: Persistant local variables include
//:: inc_persist_loca
//:://////////////////////////////////////////////
/** @file
    A set of functions for storing local variables
    on a token item stored in the creature's skin.
    Since local variables on items within containers
    are not stripped during serialization, these
    variables persist across module changes and
    server resets.

    These functions work on NPCs in addition to PCs,
    but the persitence is mostly useless for them,
    since NPCs are usually not serialized in a way
    that would remove normal locals from them, if
    they are serialized at all.
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

//////////////////////////////////////////////////
/* Function prototypes                          */
//////////////////////////////////////////////////

/**
 * Gets the token item inside the given creature's hide, on which the persistant
 * variables are stored on.
 * If a token does not exist already, one is created.
 * WARNING: If called on a non-creature object, returns the object itself.
 *
 * @param oPC The creature whose storage token to get
 * @param bAMS - TRUE will return special token for alternate magic system buckup info
 * @return    The creature's storage token
 *
 * GetNSBToken - special token for New Spellbook System information
 */
object GetHideToken(object oPC, int bAMS = FALSE);

/**
 * Set a local string variable on the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @param sValue The value to set the string local to
 */
void SetPersistantLocalString(object oPC, string sName, string sValue);

/**
 * Set a local integer variable on the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @param nValue The value to set the integer local to
 */
void SetPersistantLocalInt(object oPC, string sName, int nValue);

/**
 * Set a local float variable on the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @param nValue The value to set the float local to
 */
void SetPersistantLocalFloat(object oPC, string sName, float fValue);

/**
 * Set a local location variable on the creature's storage token.
 *
 * CAUTION! See note in SetPersistantLocalObject(). Location also contains an
 * object reference, though it will only break across changes to the module,
 * not across server resets.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @param nValue The value to set the location local to
 */
void SetPersistantLocalLocation(object oPC, string sName, location lValue);

/**
 * Set a local object variable on the creature's storage token.
 *
 * CAUTION! Object references are likely (and in some cases, certain) to break
 * when transferring across modules or upon server reset. This means that
 * persistantly stored local objects may not refer to the same object after such
 * a change, if they refer to a valid object at all.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @param nValue The value to set the object local to
 */
void SetPersistantLocalObject(object oPC, string sName, object oValue);

/**
 * Get a local string variable from the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @return       The string local specified. On error, returns ""
 */
string GetPersistantLocalString(object oPC, string sName);

/**
 * Get a local integer variable from the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @return       The integer local specified. On error, returns 0
 */
int GetPersistantLocalInt(object oPC, string sName);

/**
 * Get a local float variable from the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @return       The float local specified. On error, returns 0.0
 */
float GetPersistantLocalFloat(object oPC, string sName);

/**
 * Get a local location variable from the creature's storage token.
 *
 * CAUTION! See note in SetPersistantLocalLocation()
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @return       The location local specified. Return value on error is unknown
 */
location GetPersistantLocalLocation(object oPC, string sName);

/**
 * Get a local object variable from the creature's storage token.
 *
 * CAUTION! See note in SetPersistantLocalObject()
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 * @return       The object local specified. On error, returns OBJECT_INVALID
 */
object GetPersistantLocalObject(object oPC, string sName);

/**
 * Delete a local string variable on the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 */
void DeletePersistantLocalString(object oPC, string sName);

/**
 * Delete a local integer variable on the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 */
void DeletePersistantLocalInt(object oPC, string sName);

/**
 * Delete a local float variable on the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 */
void DeletePersistantLocalFloat(object oPC, string sName);

/**
 * Delete a local location variable on the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 */
void DeletePersistantLocalLocation(object oPC, string sName);

/**
 * Delete a local object variable on the creature's storage token.
 *
 * @param oPC    The creature whose local variables to manipulate
 * @param sName  The name of the local variable to manipulate
 */
void DeletePersistantLocalObject(object oPC, string sName);


//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "prc_inc_skin"


//////////////////////////////////////////////////
/* Function defintions                          */
//////////////////////////////////////////////////

object GetHideToken(object oPC, int bAMS = FALSE)
{
    string sCache = bAMS ? "PRC_AMSTokenCache" : "PRC_HideTokenCache";
    string sTag = bAMS ? "AMS_Token" : "HideToken";

    // Creatureness check - non-creatures don't get persistent storage from here
    if(!(GetObjectType(oPC) == OBJECT_TYPE_CREATURE))
        return oPC; // Just return a reference to the object itself

    object oHide = GetPCSkin(oPC);
    object oToken = GetLocalObject(oPC, sCache);

    if(!GetIsObjectValid(oToken))
    {
        object oTest = GetFirstItemInInventory(oHide);
        while(GetIsObjectValid(oTest))
        {
            if(GetTag(oTest) == sTag)
            {
                oToken = oTest;
                break;//exit while loop
            }
            oTest = GetNextItemInInventory(oHide);
        }
        if(!GetIsObjectValid(oToken))
        {
            oToken = GetItemPossessedBy(oPC, sTag);

            // Move the token to hide's inventory
            if(GetIsObjectValid(oToken))
                AssignCommand(oHide, ActionTakeItem(oToken, oPC)); // Does this work? - Ornedan
            else
            {
                //oToken = CreateItemOnObject("hidetoken", oPC);
                //AssignCommand(oHide, ActionTakeItem(oToken, oPC));
                oToken = CreateItemOnObject("hidetoken", oHide, 1, sTag);
            }
        }

        AssignCommand(oToken, SetIsDestroyable(FALSE));
        // Cache the token so that there needn't be multiple loops over an inventory
        SetLocalObject(oPC, sCache, oToken);
        //- If the cache reference is found to break under any conditions, uncomment this.
        //looks like logging off then back on without the server rebooting breaks it
        //I guess because the token gets a new ID, but the local still points to the old one
        //Ive changed it to delete the local in OnClientEnter. Primogenitor
        //DelayCommand(1.0f, DeleteLocalObject(oPC, "PRC_HideTokenCache"));
    }
    return oToken;
}

void SetPersistantLocalString(object oPC, string sName, string sValue)
{
    object oToken = GetHideToken(oPC);
    SetLocalString(oToken, sName, sValue);
}

void SetPersistantLocalInt(object oPC, string sName, int nValue)
{
    object oToken = GetHideToken(oPC);
    SetLocalInt(oToken, sName, nValue);
}

void SetPersistantLocalFloat(object oPC, string sName, float fValue)
{
    object oToken = GetHideToken(oPC);
    SetLocalFloat(oToken, sName, fValue);
}

void SetPersistantLocalLocation(object oPC, string sName, location lValue)
{
    object oToken = GetHideToken(oPC);
    SetLocalLocation(oToken, sName, lValue);
}

void SetPersistantLocalObject(object oPC, string sName, object oValue)
{
    object oToken = GetHideToken(oPC);
    SetLocalObject(oToken, sName, oValue);
}

string GetPersistantLocalString(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    return GetLocalString(oToken, sName);
}

int GetPersistantLocalInt(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    return GetLocalInt(oToken, sName);
}

float GetPersistantLocalFloat(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    return GetLocalFloat(oToken, sName);
}

location GetPersistantLocalLocation(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    return GetLocalLocation(oToken, sName);
}

object GetPersistantLocalObject(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    return GetLocalObject(oToken, sName);
}

void DeletePersistantLocalString(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    DeleteLocalString(oToken, sName);
}

void DeletePersistantLocalInt(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    DeleteLocalInt(oToken, sName);
}

void DeletePersistantLocalFloat(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    DeleteLocalFloat(oToken, sName);
}

void DeletePersistantLocalLocation(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    DeleteLocalLocation(oToken, sName);
}

void DeletePersistantLocalObject(object oPC, string sName)
{
    object oToken = GetHideToken(oPC);
    DeleteLocalObject(oToken, sName);
}

// Test main
