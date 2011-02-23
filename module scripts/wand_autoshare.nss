/////::///////////////////////////////////////////
/////:: LootShare Solo Script
/////:: Written by Winterknight for Altharia 5/21/07
/////::///////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  location lPC = GetLocation(oPC);
  int nVar = Random(400) + 100;
  effect eVis = EffectVisualEffect(VFX_FNF_WORD);
  object oPartner = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lPC, TRUE);
  while (GetIsObjectValid(oPartner))
  {
    if (GetIsPC(oPartner))
    {
      int nLock = GetLocalInt(oPartner,"LootLock");
      if (nLock != 1) SetLocalInt(oPartner,"LootShare",nVar);
    }
    oPartner = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lPC, TRUE);
  }
  SetLocalInt(oPC,"LootShare",nVar);
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,lPC,0.0);
}
