//::///////////////////////////////////////////////
//:: Legend Lore
//:: NW_S0_Lore.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the caster a boost to Lore skill of 10
    plus 1 / 2 caster levels.  Lasts for 1 Turn per
    caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////
//:: 2003-10-29: GZ: Corrected spell target object
//::             so potions work wit henchmen now

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oUser = OBJECT_SELF;
    if (!GetIsPC(oUser)) oUser = GetItemPossessor(oUser);
    int nLevel = GetCasterLevel(oUser);

    //Make sure the spell has not already been applied
    if(!GetHasSpellEffect(SPELL_IDENTIFY, oUser) || !GetHasSpellEffect(SPELL_LEGEND_LORE, oUser)) //Use Legend Lore constant later
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oUser, EventSpellCastAt(oUser, SPELL_IDENTIFY, FALSE));

// Modified spell code by Winterknight
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_HOWL_MIND),oUser);
      int iLore = GetSkillRank (SKILL_LORE,oUser) + 10 + 50;
      object oInv =GetFirstItemInInventory (oUser);
      while (GetIsObjectValid(oInv))
        {
         if (!GetIdentified(oInv))
           {
           int iRoll = Random(100)+1;
           if (iRoll< iLore ) SetIdentified(oInv,TRUE);
           }
         oInv=  GetNextItemInInventory(oUser);
        }
    }
}
