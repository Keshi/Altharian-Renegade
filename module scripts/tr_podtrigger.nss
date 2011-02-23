//::////////////////////////////////////////////
//:: Pod trigger - Thanar Rivar (on enter of trigger)
//:: Written by Winterknight for Altharia
//:: Last update 04/18/08
//::////////////////////////////////////////////

void main()
{
  object oPC = GetEnteringObject();
  if (GetIsPC(oPC))
  {
    int nCheck = GetLocalInt(OBJECT_SELF,"triggered");
    if (nCheck != 0) return;  // if the trigger has been activated
                              // in the last 5 minutes, it will
                              // break the loop, and leave things as is.

    int nPod = Random(7)+1;   // number of pods
    string sTag = "bookpod_"+IntToString(nPod);
    SetLocalInt(GetNearestObjectByTag(sTag),"pod_almighty",1);
    SetLocalInt(OBJECT_SELF,"triggered",1);
    DelayCommand(300.0, SetLocalInt(OBJECT_SELF,"triggered",0));
  }
}

