//::///////////////////////////////////////////////
//:: This script is placed into the OnHeartBeat of
//:: the Hidden Passage Trigger.  Tis contains the
//:: search code and passage creation code.
//:: detectsecret
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This is based on the work of Robert Babiak's original detectsecret.

     Designed to be used with all passage types (currently "secretdoor",
     "trapdoor" and "climbingrope") in Esa Mayfield's Secret Suite.

     Place this script in the OnHeartBeat field of the trigger.

     This script is controlled by the properties of the Hidden Passage Trigger

     *Tag: Type into the tag a unique identifier (example: passage_to_treasure)

           -If creating a two-way passage the matching trigger must have the
           "DST_" prefix (example: DST_passage_to_treasure).

           -If the passage is stone or set in stone to invoke the benefits of
           the Stone Cunning feat both source and destination tags must have
           the "_STONE" suffix (example: passage_to_treasure_STONE, and
           DST_passage_to_treasure_STONE).

     *Hit Points:
        Accepts values 1 to 3 for setting passage type
        1) Secret Door (default)
        2) Trap Door
        3) Climbing Rope (for climbing out of trap door)

     *Fortitue Saving Throw:
        Sets the reset timer in seconds.  Once everyone leaves the search
        radius the reset timer begins. After the reset timer expires the
        passage will reset and disappear.

     *Reflex Saving Throw:
        Sets the search radius in meters(game meters). To find the passage
        the searcher must be in this radius.

     *Will Saving Throw:
         Sets the Difficulty Challenge (DC) for discovering the passage.

*/
//:://////////////////////////////////////////////
//:: Created By: Esa-Matti Mayfield
//:: Created On: August 28, 2002
//:://////////////////////////////////////////////


// Declaring Local Functions
/************************************************/

// This function returns a string "passagetype" (secretdoor, trapdoor, or
// climbingrope) depending on the value passed to it
// int nPassageType = an interger value 1 to 3 (else defaults to 1)
string secretsuite_GetPassageType(int nPassageType);

// Parses the trigger tag to determine if the passage will be set in stone,
// giving dwarves the Stone Cunning bonus.  To take advantage of this place
// "_STONE" at the end of both the source and the destination trigger's tag.
int secretsuite_GetIsStone(string sTag);

// This is basically a bogus function added as a placeholder for the official
// GetDetectMode() when BioWare releases it.  Once you have received the
// official. Currently it returns 1 -- So you are always in detect mode.
// int GetDetectMode(object oidNearestCreature);

// Goes through each of the three Class slots and checks to see if any of them
// is a rogue. returns 1 if the object is a rogue and 0 if not.
int secretsuite_GetClassIsRogue(object oidNearestCreature);

// If the object is a Dwarf and the passage is stone (or in stone) returns 1
// if the object is not a Dwarf returns 0
// if the object is a Dwarf and the passage is not stone (or in stone)
// returns -1
int secretsuite_SetDwarfStone(object oidNearestCreature,int nIsStone);

// Check against the rules to see if object can legally detect the trap.
// if the DC is less than or equal to 20 then anyone can attempt to detect
// if it's greater than 20 then only a rogue can attempt to detect unless
// the passage is in stone in which case a Dwarf can also attempt as if he
// were a Rogue.
int secretsuite_SetCanDetect(int nDifficulty,int nClassIsRogue,int nDwarfStone);

// Once it is determined that the passage has been detected this routine
// creates the passage and makes it appear so that it can be used.
void secretsuite_CreateSecretPassage(object oidBestSearcher,string sPassageType,
                                     object oidTrigger,string sTag);

// After the reset timer has expired destroys (or hides) the passage.
void secretsuite_DestroySecretPassage(float fResetTimer,object oidTrigger,
                                      string sTag);

// MAIN:
/************************************************/
void main()
{
    // Gather information about the trigger. And declare a couple variables
    int nCanDetect = 0;
    int nDwarfStone = 0;
    // Passage Type
    string sPassageType = secretsuite_GetPassageType(GetMaxHitPoints
                                                     (OBJECT_SELF));
    // Reset Timer
    float fResetTimer = IntToFloat(GetFortitudeSavingThrow(OBJECT_SELF));
    // You get the picture...
    float fSearchDist = IntToFloat(GetReflexSavingThrow(OBJECT_SELF));
    int nDifficulty   = GetWillSavingThrow(OBJECT_SELF);
    // Get the Tag of the trigger
    string sTag = GetTag( OBJECT_SELF);
    // This little bit determines based on the suffix(or lack thereof) of the
    // Tag if the passage is set in stone or not
    int nIsStone = 0;
    if (GetStringRight(sTag,6) == "_STONE")
    {
        nIsStone = 1;
    }
    // Checks to see if the passage has already been discovered
    int nDone = GetLocalInt( OBJECT_SELF, "D_"+sTag);
    // The stuff to find searcher.
    int nBestSkill = -50;
    object oidBestSearcher = OBJECT_INVALID;
    int nCount = 1;
    // Determines the nearest Player Character object
    object oidNearestCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                                   PLAYER_CHAR_IS_PC);
    // The following while loop executes while the passage hasn't been
    // discovered yet and the nearest creature is not invalid.
    while ((nDone == 0                          ) &&
           (oidNearestCreature != OBJECT_INVALID)
          )
    {
        // Polls to see if the nearest character is in detect mode or not
        int nDetectMode = GetDetectMode(oidNearestCreature);
        // Gets the distance between the trigger and the nearest creature
        float fDist = GetDistanceBetween( OBJECT_SELF, oidNearestCreature );
        // Sets the bit that describes whether the searcher is a dwarf, or not
        // and whether the passage is set in stone or not.
        // 0=not a dwarf, -1=dwarf but not in stone, 1=dwarf and in stone
        nDwarfStone = secretsuite_SetDwarfStone(oidNearestCreature,nIsStone);
        // Proceed to gather information about the nearest character is he is
        // within the search radius and detect mode is turned on.
        if ((fDist <= fSearchDist ) &&
            ((nDetectMode == 1     ) || (nDwarfStone == 1))
           )

        {

            int nRacialAdjustment = 0;
            // Finds out if he's a rogue
            int nClassIsRogue = secretsuite_GetClassIsRogue(oidNearestCreature);
            // Basically if it's a dwarf and it's not in stone he gets a -2
            // penalty to counter BioWare's blunder which gives him Stone
            // Cunning bonus to SkillRank no matter what.
            if (nDwarfStone == -1)
            {
                nRacialAdjustment = -2;
            }
            else nRacialAdjustment = 0;
            // Retrieve the current SkillRank and apply the Racial Adjustment
            int nSkill = (nRacialAdjustment + GetSkillRank(SKILL_SEARCH,
                                                           oidNearestCreature));
            // Next check the searcher against the rules to see if he even has a
            // chance to discover.
            nCanDetect = secretsuite_SetCanDetect(nDifficulty,nClassIsRogue,
                                                  nDwarfStone);
            // At this point the searchers skill is matched against the current
            // best skill, if he beats it he becomes the best searcher and his
            // skill becomes the best skill
            if (nSkill > nBestSkill)
            {
                nBestSkill = nSkill;
                oidBestSearcher = oidNearestCreature;
            }
        }
        // this keeps the while loop going as long as there are searcher in
        // the radius
        nCount = nCount +1;
        // moves to the next creature to test if they should be the
        // best searcher
        oidNearestCreature = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR,
                                        PLAYER_CHAR_IS_PC,  OBJECT_SELF,nCount);
    }
    // Ok we now are ready to make a check.  If the trap still hasn't been
    // detected the best searcher is is a valid object, and he can detect this
    // passage according to the rules.  Let's do a search check!!!
    if ((nDone == 0                       ) &&
        (GetIsObjectValid(oidBestSearcher)) &&
        (nCanDetect == 1                  )
       )
    {
        // Assigns the dice roll 1d20 to nMod
        int nMod = d20();
        // The following sends a hint to the searcher if they score whithin 2
        // points of the DC...  A customized message for a Dwarf utilizing
        // Stone Cunning is present
        if (((nBestSkill+nMod >= nDifficulty-2) &&
             (nBestSkill+nMod <= nDifficulty  )) &&
            (nDwarfStone == 1                  )
           )
        {
            SendMessageToPC(oidBestSearcher,
            "There is something curious about the surrounding groundwork...");
        } else if (((nBestSkill+nMod >= nDifficulty-2) &&
                    (nBestSkill+nMod <= nDifficulty  )) &&
                   (nDwarfStone != 1                  )
           )
        {
            SendMessageToPC(oidBestSearcher,
            "There is something curious about the surrounding area...");
        }
        // If the dice roll plus the adjusted skill is greater than the
        // difficulty then you discover the passage.
        if (nBestSkill+nMod > nDifficulty)
        {
            if (nDwarfStone == 1)
            {
                SendMessageToPC(oidBestSearcher,
                "After examining the surrounding stonework,");
            }
            // This routine takes you through the discovery process.
            secretsuite_CreateSecretPassage(oidBestSearcher,sPassageType,
            OBJECT_SELF,sTag);
        }
    }
    // If the passage has infact been discovered, the following lies in wait to
    // begin the reset timer and re-hide the passage (destroy it) so thay it
    // must be detected again.
    if ( nDone == 1 )
    {
        // Determines the distance of the nearest creature
        float fDist = GetDistanceBetween( OBJECT_SELF, oidNearestCreature );
        // If no one is in the search radius execute the reset routine
        if ( fDist > fSearchDist )
        {
            // This routine counts down per reset timer and then destroys the
            // passage so that it has to be re-detected
            secretsuite_DestroySecretPassage(fResetTimer,OBJECT_SELF,sTag);
        }
    }
}

// Local Functions Defined
/************************************************/

// Determines passage type (secretdoor, trapdoor, or climbingrope)
string secretsuite_GetPassageType(int nPassageType)
{
    // value 2 = "trapdoor"
    if (nPassageType == 2)
    {
        return "trapdoor";
    }
    // value 3 = "climbingrope"
    else if (nPassageType == 3)
    {
        return "climbingrope";
    }
    // value 1 and the default value = "secretdoor"
    else return "secretdoor";
}/*---------------------------------------------*/



// Determines if the secret passage is set in stone or not based on the last 6
// characters of the tag
int secretsuite_GetIsStone(string sTag)
{
    // Checks the Tag to see if it contains the suffix "_STONE"
    if (GetStringRight(sTag,6) == "_STONE")
    {
        return 1;
    }
    else return 0;
}/*---------------------------------------------*/



// Is the character in detect mode or not...  This one will be replaced by
// BioWare's internal function this is just vicarious so I can code.
// int GetDetectMode(object oidNearestCreature)
// {
// return 1;
// }/*---------------------------------------------*/



// Check if nearest creature is a rogue
int secretsuite_GetClassIsRogue(object oidNearestCreature)
{
    // Since NWN allows you to be up to 3 different classes each class slot
    // must be examined to determine if a character is a rogue or not
    int nClassCount = 1;
    // This is the value that will be returned
    int nFlag = 0;
    // Step through each class slot and test it for Rogue
    while (nClassCount <=3 )
    {
        // Is this slot a Rogue?
        if (GetClassByPosition(nClassCount,oidNearestCreature) ==
            CLASS_TYPE_ROGUE)
        {
            // If so set the flag to 1
            nFlag = 1;
        }
        // next class slot please
        nClassCount++;
    }
    return nFlag;
}/*---------------------------------------------*/



// Set's the bit that defines the relationship between the passage, if it's set
// in stone and the detector.
// it returns one of 3 values,
//  0 = It's not stone and the detector is not a dwarf
//  1 = It is stone and the detector is a dwarf
// -1 = It's not stone and the detector is a dwarf
int secretsuite_SetDwarfStone(object oidNearestCreature,int nIsStone)
{
    // This value will be returned
    int nFlag  = 0;
    // If the nearest character is a Dwarf and the passage is set in stone
    // then set the flag to 1
    if ((GetRacialType(oidNearestCreature) == RACIAL_TYPE_DWARF) &&
        (nIsStone == 1                                         )
       )
    {
        nFlag = 1;
    }
    // else, if the nearest creature is a Dwarf and the passage is not set in
    // stone then the flag is set to -1
    else if ((GetRacialType(oidNearestCreature) == RACIAL_TYPE_DWARF) &&
             (nIsStone == 0                                         )
            )
    {
        nFlag = -1;
    }
    // Other wise return the default value which is 0
    return nFlag;
}/*---------------------------------------------*/



// Checks the rules to find out if this searcher even has a chance to detect
// the passage
int secretsuite_SetCanDetect(int nDifficulty,int nClassIsRogue,int nDwarfStone)
{
    // This value will be returned
    int nFlag = 0;
    // is the DC less than or equal to 20, or the class is a rogue, or
    // the race is dwarf and the passage is set in stone.
    if ((nDifficulty <= 20 ) ||
        (nClassIsRogue == 1) ||
        (nDwarfStone == 1  )
       )
    {
        // if so return the value of 1
        nFlag = 1;
    }
    return nFlag;
}/*---------------------------------------------*/



// Once it is determined that the passage has been detected this routine
// creates the passage and makes it appear so that it can be used.
void secretsuite_CreateSecretPassage(object oidBestSearcher,string sPassageType,
     object oidTrigger,string sTag)
{
    // Find out the triggers location
    location locLoc = GetLocation (oidTrigger);
    // create object based on the passage type and location of the trigger
    object oidObject = CreateObject(OBJECT_TYPE_PLACEABLE,sPassageType,
                       locLoc,TRUE);
    // Stores the passage type into to passage object itself
    SetLocalString(oidObject,"PassageType",sPassageType);
    // notify the searcher that he is successful
    SendMessageToPC(oidBestSearcher, "You have discovered a secret passage...");
    // the next to statements fix the orientation of the passage to
    // the orientation of the trigger
    float fFace = GetFacing(oidTrigger);
    AssignCommand (oidObject, SetFacing(fFace) );
    // Determine if this is the destination trigger
    if (GetSubString(sTag, 0, 4) == "DST_")
    {
        // It is the destination, remove the first 4 characters of the tag to
        // figure out the return trigger
        SetLocalString( oidObject, "Destination" , GetSubString(sTag, 4, 30));
    }
    // else, assume it is the source trigger and add "DST_" to the tag to
    // figure out the destination trigger
    else SetLocalString( oidObject, "Destination" , "DST_"+sTag );
    // Mark this passage as discovered
    SetLocalInt(oidTrigger, "D_"+sTag,1);
    // make this object indestructable
    SetPlotFlag(oidObject,1);
    // assigns this newly created object to the trigger that created it
    SetLocalObject(oidTrigger, "Object", oidObject);
}/*---------------------------------------------*/



// After the reset timer has expired destroys (or hides) the passage.
void secretsuite_DestroySecretPassage(float fResetTimer,object oidTrigger,
     string sTag)
{
    // set's the object to destroy as being the object that this trigger created
    object oidObject= GetLocalObject(oidTrigger, "Object");
    // if this object is not invalid destroy it
    if (oidObject != OBJECT_INVALID)
    {
        // make this object destructable
        SetPlotFlag( oidObject,0);
        // destroy the object ins fResetTimer seconds
        DestroyObject( oidObject,fResetTimer);
        // Mark this object as hidden again
        SetLocalInt(oidTrigger,"D_"+sTag,0);
    }
}/*---------------------------------------------*/
