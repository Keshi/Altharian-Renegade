//::///////////////////////////////////////////////
//:: OnEnter script for Johan Grove
//:: Written by Winterknight 9/27/05
//:://////////////////////////////////////////////

void main()
{
    object oPC=GetEnteringObject();
    string sArea = GetTag(OBJECT_SELF);
    int nMapped = GetCampaignInt("altharia",sArea,oPC);
    if (nMapped == 1) ExploreAreaForPlayer(OBJECT_SELF,oPC);
    object oItem=GetItemPossessedBy(oPC,"pureelixir");
    object oShaftLoc=GetObjectByTag("JohanFountain",1);
    object oDestroy=GetNearestObjectByTag("ShaftofLightWhite",oShaftLoc,1);
    location lSpring = GetLocation(GetObjectByTag("JohanFountain"));
    if (GetIsPC(oPC))
       {
       if (GetIsObjectValid(oItem))
          {
          DestroyObject(oDestroy, 0.5);
          CreateObject(OBJECT_TYPE_PLACEABLE, "ShaftofLightGreen", lSpring, FALSE, "");
          }
       }

}
