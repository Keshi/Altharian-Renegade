/////:://///////////////////////////////////////////////////////////////////////
/////:: Module Load script, set campaign variables.
/////:: Written by Winterknight 10/29/05
/////:://///////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"



 void EvalRestart(object oModule)
{
int reset = GetLocalInt(oModule,"RESTART");
object shouter = GetObjectByTag("shout_guy"); //change this to your NPC's TAG
object oPC;
 switch(reset)
 {
 case 0:
 AssignCommand(shouter,SpeakString("Server Reset!!!",TALKVOLUME_SHOUT));
 oPC = GetFirstPC();
  while(GetIsObjectValid(oPC))
  {
  ExportSingleCharacter(oPC);
  ExportAllCharacters();
  SetLocalString(oPC,"NWNX!FUNCTIONS!BOOTPCWITHMESSAGE","53244");
  oPC = GetNextPC();
  }

 DelayCommand(3.0,SetLocalString(oModule,"NWNX!RESETPLUGIN!SHUTDOWN","1"));
 break;
 case 120:
 AssignCommand(shouter,SpeakString("Server will restart in 2 hours!",TALKVOLUME_SHOUT));
 break;
 case 60:
 AssignCommand(shouter,SpeakString("Server will restart in 1 hour!",TALKVOLUME_SHOUT));
 break;
 case 30:
 AssignCommand(shouter,SpeakString("Server will restart in 30 minutes!",TALKVOLUME_SHOUT));
 break;
 case 10:
 case 2:
 AssignCommand(shouter,SpeakString("Server will restart in " + IntToString(reset) + " minutes!",TALKVOLUME_SHOUT));
 break;
 case 1:
 AssignCommand(shouter,SpeakString("Server will restart in 1 minute!",TALKVOLUME_SHOUT));
 break;
 }

SetLocalInt(oModule,"RESTART",reset-1);
DelayCommand(60.0,EvalRestart(oModule));
}



 void main()
{         SetCampaignInt("Altharia","clock",0);
    int nRand = d6(1);
    string sTag = "WP_refractedlight"+IntToString(nRand);
    location lSpawn = GetLocation(GetWaypointByTag(sTag));
    CreateObject(OBJECT_TYPE_PLACEABLE,"refractedlight",lSpawn,FALSE);
    SetModuleSwitch(MODULE_SWITCH_NO_RANDOM_MONSTER_LOOT,TRUE);
object oModule = GetModule();
int reset = GetLocalInt(oModule,"RESTART");
 if(!reset)
 {
 SetLocalInt(oModule,"RESTART",600);
 }
DelayCommand(60.0,EvalRestart(oModule));
}
