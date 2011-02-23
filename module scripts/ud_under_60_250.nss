

void main()
{

    int iUD= GetUserDefinedEventNumber();

    if (iUD == 1007)
      {
       object oKiller = GetLastKiller();
       object oKilledArea = GetArea (oKiller);
       object oPC = GetFirstFactionMember(oKiller);

       while(GetIsObjectValid(oPC))
         {
          if (oKilledArea == GetArea(oPC))
            {
             // find the maxXP
             int oPCMaxXP= GetLocalInt ( oPC,"XPMax");

             // raise it by 100
             SetLocalInt (oPC, "XPMax", oPCMaxXP+250);
             GiveXPToCreature(oPC, 250);
             SendMessageToPC(oPC, "Received Bonus XPs.");
            }
          oPC = GetNextFactionMember(oKiller, TRUE);
         }
      }

}

