


int StartingConditional()
{
   object oPC=GetPCSpeaker();
   object oItem = GetLocalObject(oPC,"MODIFY_ITEM");
   string sTag = GetTag(oItem);
   string sCheck = GetStringRight(sTag,3);
   if (sCheck == "hvy") return TRUE;

   return FALSE;

}
