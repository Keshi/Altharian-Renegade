#include "wk_tools"

void main()
{
   object oPC = GetFirstPC();

     while (GetIsObjectValid(oPC))                                      //Every 10 minutes
           {
              string sShout = GetServerRank(oPC)+": "+GetName(oPC);
              if (!GetIsDM(oPC))
                  {
                    AssignCommand(GetModule(),ActionSpeakString (sShout,TALKVOLUME_SHOUT));
                  }
              sShout="";
              oPC = GetNextPC();
           }
   SetLocalInt(GetObjectByTag("AltharClock"),"rankshout",1);
   DelayCommand(600.0,SetLocalInt(GetObjectByTag("AltharClock"),"rankshout",0));

}
