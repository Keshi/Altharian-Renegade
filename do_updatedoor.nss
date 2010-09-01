// Door Gate script
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);

  int nGold = GetGold(oClicker);
  int nInv;
  object oItem = GetFirstItemInInventory(oClicker);
  while (GetIsObjectValid(oItem))
    {
      nInv = GetGoldPieceValue(oItem);
      nGold = nGold + nInv;
      oItem = GetNextItemInInventory(oClicker);
    }
  int nXP = GetXP(oClicker);
  if (GetIsPC(oClicker))
    {
      if (nXP > 15000)
        {
          AssignCommand(oClicker,JumpToObject(oTarget));
        }
      else if (nXP < 15000)
        {
          SendMessageToPC(oClicker,"This door is for veterans needing updates. There is nothing here you need.");
        }
    }
}
