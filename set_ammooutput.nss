/////::///////////////////////////////////////////////
/////:: forge_custtokens script - set custom tokens for forge conversation
/////:: Written by Winterknight on 2/17/06
/////:: This script also is used to set up the basics for the forge.
/////:: this script as necessary to change the basic type of forge.
/////:://////////////////////////////////////////////


void main()
{

/*    if (sForgeLeft == "Cobble") {sTypes = "Belts and Boots"; nType = 1;}
    if (sForgeLeft == "Armour") {sTypes = "Armor, Helms and Shields"; nType = 2;}
    if (sForgeLeft == "Weapon") {sTypes = "Melee Weapons and Gloves"; nType = 3;}
    if (sForgeLeft == "Tailor") {sTypes = "Cloaks"; nType = 4;}
    if (sForgeLeft == "Jewele") {sTypes = "Rings and Amulets"; nType = 5;}
    if (sForgeLeft == "Bowyer") {sTypes = "Bows and Crossbows"; nType = 6;}
    if (sForgeLeft == "Fletch") {sTypes = "Thrown Weapons and Ammunition"; nType = 7;}
    if (sForgeLeft == "Common") {sTypes = "Common Items (not equipped)"; nType = 8;}*/

    SetLocalInt(OBJECT_SELF, "ItemType", 7);

}
