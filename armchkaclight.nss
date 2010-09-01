


int StartingConditional()
{
   object oPC=GetPCSpeaker();
   object oItem = GetLocalObject(oPC,"MODIFY_ITEM");
   string sTag = GetTag(oItem);
   string sCheck = GetStringRight(sTag,3);
   if (sCheck == "lyt") return TRUE;
   // debug
   else SendMessageToPC(oPC,"Your Armor type is: "+sCheck);

   return FALSE;

}
