/////////////// Mercenary Armor ////////////////////////////////////////////////
/////Written by Winterknigth for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetItemActivator();
  int nCycle = GetLocalInt(oPC,"mercbuffs");
  int iDice = GetHitDice(oPC);
  int nBonus = GetAbilityModifier(ABILITY_CONSTITUTION,oPC);
  if (nCycle <= 3)
    {
      PlaySound ("as_mg_frstmagic1");
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_SOUND_BURST),oPC);
      int nBoost = iDice*(10+nBonus/3);
      effect TempHP=EffectTemporaryHitpoints(nBoost);
      float fBoost = IntToFloat(nBoost);
      fBoost = fBoost+300.0;
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,TempHP,oPC,fBoost);
      nCycle++;
      SetLocalInt(oPC,"mercbuffs",nCycle);
    }
  else if (nCycle = 4)
    {
      PlaySound ("as_mg_frstmagic1");
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_SOUND_BURST),oPC);
      nCycle++;
      SetLocalInt(oPC,"mercbuffs",nCycle);
      SendMessageToPC(oPC,"Greediness killed the cat.  You are warned.");
    }
  else if (nCycle = 5)
    {
      PlaySound ("as_mg_frstmagic1");
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_SOUND_BURST),oPC);
      int nBoost = iDice*(-50);
      effect TempHP=EffectTemporaryHitpoints(nBoost);
      float fBoost = IntToFloat(nBoost);
      fBoost = fBoost+300.0;
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,TempHP,oPC,fBoost);
      nCycle++;
      SetLocalInt(oPC,"mercbuffs",nCycle);
      SendMessageToPC(oPC,"Have it your way.");
    }
  else if (nCycle >= 6)
    {
      PlaySound ("as_mg_frstmagic1");
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_SOUND_BURST),oPC);
      int nBoost = iDice*(-10);
      effect TempHP=EffectTemporaryHitpoints(nBoost);
      float fBoost = IntToFloat(nBoost);
      fBoost = fBoost+300.0;
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,TempHP,oPC,fBoost);
      nCycle++;
      SetLocalInt(oPC,"mercbuffs",nCycle);
      int nXP = GetXP(oPC);
      SetXP(oPC,(nXP-(nBoost*nCycle)));
    }

}
