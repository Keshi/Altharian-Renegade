//::///////////////////////////////////////////////
//:: FileName set_sigilupgrade
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/10/2006 9:07:07 AM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalString(GetPCSpeaker(), "mithtag","innerpath");
    object oItem = GetItemInSlot (INVENTORY_SLOT_ARMS, GetPCSpeaker());
    SetLocalObject(GetPCSpeaker(),"mithitem",oItem);

}
