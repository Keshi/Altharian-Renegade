// RJ
// added the use if a String variable  SPAWN_STR that can be stored on each mob
//
//   xxxxxxxxxxxx
//   ||||||||||||
//   ||||||||||>>>> Number used to Spawn at a random waypoint tagname+##
//   ||||||||||
//   |||||||>>>>>>> Number of minutes to Randomly vary the respawn time by
//   |||||||
//   ||||>>>>>>>>>> Base number of Min to respawn
//   ||||
//   |>>>>>>>>>>>>> Amount of Epic Xp to award if any
//   |
//   >>>>>>>>>>>>>> 0=No epic XP, 1=Epic XP <30 only 2=Epic XP for all
//
// This var is stored in the mob and should always be of length 12 and numeric
// Curently there is no checking for validity of the string so use with caution
// Make sure the amount to vary he spawn time is less than the actuall spawn time etc
//
// When using substring etc remeber that counts Start at 0
// RJ

void RespawnObject(string sTag, int iType, location lLoc)
{  // ResRef must be derivable from Tag

string sResRef = GetStringLowerCase(GetStringLeft(sTag, 16));
CreateObject(iType, sResRef, lLoc);
}


void main()
{
int iUD= GetUserDefinedEventNumber();

if (iUD == 1007)
  {
    string   sTag = GetTag(OBJECT_SELF);
    int      iType = GetObjectType(OBJECT_SELF);
    location lLoc = GetLocalLocation (OBJECT_SELF,"myhouse");
    string   sSpawn = GetLocalString(OBJECT_SELF,"SPAWN_STR");
    object   oKiller = GetLastKiller();
    object   oKilledArea = GetArea (oKiller);
    object   oPC = GetFirstFactionMember(oKiller);
    int      iXPamount  = StringToInt(GetSubString(sSpawn,1,3));

     // give epic xp if needed
     while(GetIsObjectValid(oPC))
      {
     if (((GetStringLeft(sSpawn,1) =="1") && (GetHitDice(oPC)<30 )) ||  //epic <30
          (GetStringLeft(sSpawn,1) =="2")                          )    //epic for all

        {
            if (oKilledArea == GetArea(oPC))
            { // find the maxXP and raise
                int oPCMaxXP= GetLocalInt ( oPC,"XPMax");
                SetLocalInt (oPC, "XPMax", oPCMaxXP + iXPamount);
                //tell the PC you gave him XP
                GiveXPToCreature(oPC, iXPamount);
                 SendMessageToPC(oPC, "Received Bonus XPs.");
            }
         }
            oPC = GetNextFactionMember(oKiller, TRUE);

      }
    // get delay time from postions 4-6 of sSpawn
    // convert to float
    // convert to rounds from minutes
    float fDelay = StringToFloat(GetSubString(sSpawn,4,3)) *60 ;


    // get amount to vary delay time from postions 7-9 of sSpawn
    // convert to int
    // convert to rounds from minutes
    // get random and convert to float
    int   iVary  = StringToInt(GetSubString(sSpawn,7,3)) *60 ;
    float fRandVary = IntToFloat(Random(iVary) -(iVary/2));

    // when creature spawned he found his loc   and stored it locally
    AssignCommand(GetArea(OBJECT_SELF), DelayCommand(fDelay +fRandVary, RespawnObject(sTag, iType, lLoc)));

  }
}
