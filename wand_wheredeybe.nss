/////Wand - Where da peeps?
/////Written by Winterknight for Altharia

void main()
{
  object oUser = GetPCSpeaker();
  object oPC = GetFirstPC();
  string sArea;
  string sName;
  object oArea;
  while (GetIsObjectValid(oPC))
    {
      oArea = GetArea(oPC);
      sArea = GetName(oArea,FALSE);
      sName = GetName(oPC);
      if (!GetIsDM(oPC))
        {
          SendMessageToPC(oUser,sName+" is in "+sArea);
        }
      oPC = GetNextPC();
    }

}
