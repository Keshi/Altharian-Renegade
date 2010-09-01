// Part of Mine Forman Convo in Viisperfjorg- Altharian Adventures
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "mc_golemhead");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

CreateItemOnObject("mithrilnugget", oPC);

}

