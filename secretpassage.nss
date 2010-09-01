//::///////////////////////////////////////////////
//:: Secret Passage that takes you to a waypoint that
//:: is stored into the Destination local string.
//:: Also brings your associates with you.
//:: secretpassage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This is based on the work of Robert Babiak's original trapdoor.

     Designed to be used with all passage types (currently "secretdoor",
     "trapdoor" and "climbingrope") in Esa Mayfield's Secret Suite.

     Place this script in the OnUse field of the object.
*/
//:://////////////////////////////////////////////
//:: Created By: Esa-Matti Mayfield
//:: Created On: August 28, 2002
//:://////////////////////////////////////////////

void SuperOnUse(object oidObject,object oidUser);

void main()
{
    // Get the object that clicks on it.
    object oidUser = GetLastUsedBy();

    // The following basically performs animations for objects like trapdoors
    // that need to be opened first before they can be climbed into.
    // other object such as doors, chests, etc... can also take advantage
    // of this animation just add additional object to the first conditional
    if (GetLocalString(OBJECT_SELF,"PassageType") == "trapdoor")
    {
        // Must be unloacked before going any further
        if (!GetLocked(OBJECT_SELF) )
        {
            // Is it currently open?
            if ( GetIsOpen(OBJECT_SELF))
            {
                // If so transfer oidUser and all his associates
                SuperOnUse(OBJECT_SELF,oidUser);
                // Once everyone has move through close the object
                PlayAnimation(ANIMATION_PLACEABLE_CLOSE);
            // If it's not open, open it...
            }else
            {
                // Open's the object before use.
                PlayAnimation(ANIMATION_PLACEABLE_OPEN);
            }
        }
    // All current object types other than trapdoor can complete the transfer
    // without having to go through the locked/open/close animations.
    } else
    {
        SuperOnUse(OBJECT_SELF,oidUser);
    }
}

// Declaring Local Function, this actually performs the transfer of the user
// and his associates to the destination.
void SuperOnUse(object oidObject,object oidUser)
{
    // Get the tag for the destination
    string sDest = GetLocalString(oidObject,"Destination");
    // Locate the destination by using it's tag
    object oidDest = GetObjectByTag(sDest);
    // Declare the actual location of the destination.
    location locDest = GetLocation(oidDest);
    // Jump the user to the destination object
    AssignCommand(oidUser,JumpToObject(oidDest,FALSE));
    SendMessageToPC(oidUser,"You enter the secret passage.");
    // Determine the users first associate
   /////kkkk object oidAssociate = GetFirstFactionMember(oidUser, FALSE );
    // While there area associates that belong to the user
    //////kkkk while ( GetIsObjectValid(oidAssociate) )
    /////kkkkk {
        // Basically jump the current associate to the location of
        // the destination


       ////kkkkk  AssignCommand(oidAssociate,JumpToLocation(locDest));
        // Determine the next associate, and loop till there are no more.
       //////kkkkk  oidAssociate = GetNextFactionMember(oidUser, FALSE );
    //////kkkkk }
}

