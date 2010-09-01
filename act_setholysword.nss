//::///////////////////////////////////////////////
//:: FileName act_setmagestaff
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/10/2006 8:43:47 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    int nTimer = GetLocalInt(oPC,"UpgradeTimer");
    if (nTimer > 0)
      {
        string sCheck = GetLocalString(oPC,"actitem");
        SetLocalString(oPC,"actcheck",sCheck);
      }
    SetLocalString(GetPCSpeaker(), "actitem", "holysword");

}
