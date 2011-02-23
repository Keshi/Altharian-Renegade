//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/24/2003 12:13:44 AM
//:://////////////////////////////////////////////
void main()
{
 if(!GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), "whiteherb")) )
 {
    // and give him the key
        CreateItemOnObject("whiteherb", GetPCSpeaker(), 1);
 }


}
