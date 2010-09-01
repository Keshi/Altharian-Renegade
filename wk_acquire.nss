
#include "nw_i0_plotwizard"
void main()
{

    object oItem = GetModuleItemAcquired();
    object oPC;
    object oArea;
    string sItem ;
    string sAreaTag;
    int iTest;
    int  IsPlot;
    int GPValue;

    if( GetIsObjectValid(oItem) == FALSE)  return ;

    // Merchants will destroy items they purchase.
    if (GetObjectType(GetItemPossessor(oItem)) == OBJECT_TYPE_STORE) DestroyObject(oItem, 0.1f);
    oPC = GetItemPossessor(oItem);
    if ( GetIsPC(oPC) == FALSE || GetIsDM(oPC)== TRUE) return ;
//    if ( GetLocalInt(oPC,"ACQUIRE") == 0 ) return ;
    oArea=GetArea(oItem);
    if( GetIsObjectValid(oArea) == FALSE) oArea=GetArea(oPC);

      // If area is still false, it's the PC zoning into module.
    if( GetIsObjectValid(oArea) == FALSE) return ;

}
