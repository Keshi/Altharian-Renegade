//::///////////////////////////////////////////////
//:: FileName at_givepoestone
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/11/2005 11:37:16 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    CreateItemOnObject("truestoneelderki", oPC, 1);
    object oDest = GetItemPossessedBy(oPC,"nodestone_elderkind");
    if (oDest != OBJECT_INVALID) DestroyObject (oDest,0.2);

}
