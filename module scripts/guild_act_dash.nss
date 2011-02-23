/////////////// Mercenary Armor ////////////////////////////////////////////////
/////Written by Winterknigth for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oUser = GetItemActivator();
  int iDice = GetHitDice(oUser);
       effect eEffect;
       int iCount = iDice/5;
       eEffect = EffectAttackIncrease(2*iCount);
       effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oUser, 120.0f+ IntToFloat(iCount*30));
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oUser);
       eEffect = EffectTemporaryHitpoints((iCount*40));
       eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oUser, 120.0f+ IntToFloat(iCount*30));
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oUser);
       eEffect = EffectRegenerate((iDice / 2), 2.0);
       eVis = EffectVisualEffect(VFX_FNF_SUMMONDRAGON);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oUser, 120.0f+ IntToFloat(iCount*30));
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oUser);
       eEffect = EffectSkillIncrease(SKILL_CONCENTRATION, (iCount*2));
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oUser, 120.0f+ IntToFloat(iCount*30));
       eEffect = EffectSkillIncrease(SKILL_SPELLCRAFT, (iCount*2));
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oUser, 120.0f+ IntToFloat(iCount*30));

}
