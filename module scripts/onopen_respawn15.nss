
 void RespawnObject(string sTag, int iType, location lLoc) {
// ResRef must be derivable from Tag
string sResRef = GetStringLowerCase(GetStringLeft(sTag, 16));
object oChest=  GetObjectByTag(sTag)  ;
///kill the inventory
object oInvent;
        oInvent=GetFirstItemInInventory(oChest);
        while (GetIsObjectValid(oInvent))
            {
             DestroyObject(oInvent);
             oInvent=GetNextItemInInventory(oChest);
        }

DestroyObject(oChest);
CreateObject(iType, sResRef, lLoc);
SetLocalInt (oChest,"spawning",0);
}











void main()
{

int IsGoingToSpawn=GetLocalInt (OBJECT_SELF,"spawning");
string sTag = GetTag(OBJECT_SELF);
int iType = GetObjectType(OBJECT_SELF);
location lLoc = GetLocation (OBJECT_SELF);
float fDelay = 900.0;


if   (IsGoingToSpawn==0)
{
 SetLocalInt (OBJECT_SELF,"spawning",1);
AssignCommand(GetArea(OBJECT_SELF), DelayCommand(fDelay, RespawnObject(sTag, iType, lLoc)));
}
}

