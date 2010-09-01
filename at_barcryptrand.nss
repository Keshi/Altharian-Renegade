void main()
{

    string sDest;
    string sBase = "BarHeroCryptExit";
    string sZero = "";
    string sCrypt= GetTag(OBJECT_SELF);

    int iPort = GetLocalInt (OBJECT_SELF,"HeroCrypt");
    if (iPort == 0)
    { // this door has not been used this game
      int iGoOn=0;
        while (iGoOn==0)
         {
            int roll= Random(15)+1;
            // has it been used?
              if (GetLocalInt( GetModule(),"CryptLocked"+IntToString(roll))==0)
               {// the random destination is NOT locked, lock it
                  SetLocalInt( GetModule(),"CryptLocked"+IntToString(roll),1);
                  // Set the corresponding value for the destination crypt
                  SetLocalInt(OBJECT_SELF,"HeroCrypt",roll);
                  if (roll < 10) sZero ="0";
                  string sExit = sBase+sZero+IntToString(roll);
                  object oExit = GetObjectByTag(sExit);
                  SetLocalString(oExit,"wpEnter","WP_"+sCrypt);
                  SetLocalString(OBJECT_SELF,"wpDest", "WP_"+sExit);
                  //get out of the loop
                  iGoOn=1 ;
               }
          }
    }

    sDest = GetLocalString(OBJECT_SELF,"wpDest");
    object oJumper= GetEnteringObject();
    object oidDest = GetWaypointByTag(sDest);

           AssignCommand(oJumper,ClearAllActions());
           DelayCommand(0.1, AssignCommand(oJumper,ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oJumper),ClearAllActions());
           DelayCommand(0.1,AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oJumper),ActionJumpToObject(oidDest)));

}
