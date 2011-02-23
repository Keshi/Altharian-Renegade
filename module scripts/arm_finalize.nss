/////:://///////////////////////////////////////////////////////////////////////
/////:: GuildArmor finalize script- vfx, and set new variable states.
/////:: Written by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetLocalObject(oPC, "MODIFY_ITEM");
  int nChar = GetCampaignInt("Character","guildarmor",oPC);
  if (!GetIsObjectValid(oItem)) return;
  int nCost = GetLocalInt(oPC,"guild_cost");
  int nSpell = GetLocalInt(oPC,"guild_spellslot");
  if (nSpell > 0)
    {
      nSpell = nSpell + GetCampaignInt("Character","guildspells",oPC);
      SetCampaignInt("Character","guildspells",nSpell,oPC);
    }
  nSpell = GetLocalInt(oPC,"guild_ability");
  if (nSpell == 1) SetCampaignInt("Character","guildability",1,oPC);

// Last things: vis effect, set permanent variables.
  SetCampaignInt("Character","guildarmor",(nChar + nCost),oPC);

  effect eTel1 = EffectVisualEffect(VFX_IMP_HEALING_X, FALSE);
  object oArea = GetArea(oPC);
  location lTrig1 = GetLocation(oPC);

  DelayCommand(0.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel1,lTrig1,0.0));
  RecomputeStaticLighting(oArea);
}
