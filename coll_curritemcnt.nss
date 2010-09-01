/////::////////////////////////////////////////////////////////////////////////
/////:: Count the items, set the variable
/////::
/////::////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"
void main()
{
  object oPC = GetPCSpeaker();
  string sItem = GetLocalString(oPC,"CurrentItem");
  int nCount = GetNumItems(oPC,sItem);
  SetLocalInt (oPC,"CurrentItemCount",nCount);
}
