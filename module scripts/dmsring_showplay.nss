// This function cycles through all PCs and counts how many there are
 void main()
{
   //int nPCs = 0;
   object oPC = GetFirstPC();
   object oDM= GetLastUsedBy() ;
   SendMessageToPC (oDM,
    "==>Name: " + GetName(oPC)+
    " =Area: "+ GetName(GetArea(oPC))+
    " =Secrets: " + IntToString(GetLocalInt(oPC,"secrets")));


   while (GetIsObjectValid(oPC) == TRUE)
   {
      //nPCs = nPCs+1; // nPCs++;
      SendMessageToPC (oDM,
    "==>Name: " + GetName(oPC)+
    " =Area: "+ GetName(GetArea(oPC))+
    " =Secrets: " + IntToString(GetLocalInt(oPC,"secrets")));
      oPC = GetNextPC();
   }
}







  /*

void main()
{
  object  oPlayer =GetFirstPC();

  object oDM= GetLastUsedBy() ;

  SendMessageToPC (oDM,
    "==>Name: " + GetName(oPlayer)+
    " =Area: "+ GetName(GetArea(oPlayer))+
    " =Secrets: " + IntToString(GetLocalInt(oPlayer,"secrets")));

    object oPlayer2= GetNextPC();


  while (GetIsObjectValid (oPlayer2));
         {
         /// show players and stats to the DM

   SendMessageToPC (oDM,
    "==>Name: " + GetName(oPlayer2)+
    " =Area: "+ GetName(GetArea(oPlayer2))+
    " =Secrets: " + IntToString(GetLocalInt(oPlayer2,"secrets")));
  oPlayer2= GetNextPC();
        }///  loop through PCs

}


  // object  oFiretarget=GetFirstPC();
      //     oFiretarget= GetNextPC();
       //    while (   GetIsObjectValid (oFiretarget))
          //      {
         //       oFiretarget= GetNextPC();
           //     }///  loop through PCs
*/
