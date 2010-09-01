/////:://///////////////////////////////////////////////////////////////////////
/////:: Area check for previously mapped
/////:: Written by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
   object oPC = GetEnteringObject();
   string sArea = GetTag(OBJECT_SELF);
   int nMapped = GetCampaignInt("altharia",sArea,oPC);
   if (nMapped == 1) ExploreAreaForPlayer(OBJECT_SELF,oPC);
}
