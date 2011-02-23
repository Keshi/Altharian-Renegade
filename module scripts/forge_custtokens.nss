/////::///////////////////////////////////////////////
/////:: forge_custtokens script - set custom tokens for forge conversation
/////:: Written by Winterknight on 2/17/06
/////:: This script also is used to set up the basics for the forge.
/////:: this script as necessary to change the basic type of forge.
/////:://////////////////////////////////////////////


void main()
{
    object oForge = GetNearestObjectByTag("forge_custom",OBJECT_SELF,1);
    SetCustomToken(101,GetName(oForge));    // Name of Forge
    SetLocalString(OBJECT_SELF, "ForgeName", GetName(oForge));

    string sTypes;
    int nType;
    string sForgeLeft = GetStringLeft(GetName(oForge),6);
    if (sForgeLeft == "Cobble") {sTypes = "Belts and Boots"; nType = 1;}
    if (sForgeLeft == "Armour") {sTypes = "Armor, Helms and Shields"; nType = 2;}
    if (sForgeLeft == "Weapon") {sTypes = "Melee Weapons and Gloves"; nType = 3;}
    if (sForgeLeft == "Tailor") {sTypes = "Cloaks"; nType = 4;}
    if (sForgeLeft == "Jewele") {sTypes = "Rings and Amulets"; nType = 5;}
    if (sForgeLeft == "Bowyer") {sTypes = "Bows and Crossbows"; nType = 6;}
    if (sForgeLeft == "Fletch") {sTypes = "Thrown Weapons and Ammunition"; nType = 7;}
    if (sForgeLeft == "Common") {sTypes = "Common Items (not equipped)"; nType = 8;}
    SetCustomToken(102,sTypes);             // Type of item that will work here.
    SetLocalInt(OBJECT_SELF, "ItemType", nType);
    SetLocalInt(OBJECT_SELF, "ItemCost", 0);


}
