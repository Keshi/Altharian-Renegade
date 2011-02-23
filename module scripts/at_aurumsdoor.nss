// Thomas Kay's
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  object oArms = GetObjectByTag("wk_startarms");
  int nGold = GetGold(oClicker);
  int nInv;
  int nChest = GetLocalInt(oArms,"enterchests");
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
      if (nXP == 1 & nGold < 800 & nChest == 0)
        {
          AssignCommand(oClicker,JumpToObject(oTarget));
        }
      else if (nXP > 0)
        {
          SendMessageToPC(oClicker,"This door is for the very inexperienced. There is nothing here you need.");
        }
      else if (nGold >= 800)
        {
          SendMessageToPC(oClicker,"This door is for the very new. Your wealth proves you do not need this aid.");
        }
    }
}
