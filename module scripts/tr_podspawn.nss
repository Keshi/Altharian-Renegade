//::////////////////////////////////////////////
//:: Pod spawn - Thanar Rivar
//:: Written by Winterknight for Altharia
//:: Last update 04/18/08
//::////////////////////////////////////////////

void DoHammerTime (object oPC)
{
  effect eDam = EffectDamage(500,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_NORMAL);
  effect eVis = EffectVisualEffect(487);   // not sure of the vfx
  location lPC = GetLocation(oPC);
  DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC));
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,lPC);
}

void DoSpawnBane (object oPC)
{
  location lSpawn = GetLocation(OBJECT_SELF);
  object oSpawn = CreateObject(OBJECT_TYPE_CREATURE,"pc_blastdemon",lSpawn,FALSE);
  AssignCommand(oSpawn, ActionAttack(oPC));
}

void main()
{
  object oPC = GetLastUsedBy();
  if (GetIsPC(oPC))
  {
    int nCheck = GetLocalInt(OBJECT_SELF,"pod_almighty");
    if (nCheck == 1)
    {
      object oOldBook = GetItemPossessedBy(oPC,"bookoftheabyss02");
      if (oOldBook != OBJECT_INVALID)
      {
        CreateItemOnObject("bookoftheabyss03",oPC,1);
        DestroyObject(oOldBook,0.2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oPC);
      }
      else SendMessageToPC(oPC,"You have already upgraded your book.");
    }
    if (nCheck == 0)
    {
      nCheck = d2();
      if (nCheck == 1) DoHammerTime(oPC);
      if (nCheck == 2) DoSpawnBane(oPC);
    }
  }
}

