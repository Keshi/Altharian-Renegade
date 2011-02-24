#include "prc_feat_const"

const string BRUTAL_STRIKE_MODE_VAR = "PRC_BRUTAL_STRIKE_MODE";

int _prc_inc_hextor_BrutalStrikeFeatCount(object oPC)
{
    int nCount = 0;

    if (GetHasFeat(FEAT_BSTRIKE_12, oPC))
        nCount = 12;
    else if (GetHasFeat(FEAT_BSTRIKE_11, oPC))
        nCount = 11;
    else if (GetHasFeat(FEAT_BSTRIKE_10, oPC))
        nCount = 10;
    else if (GetHasFeat(FEAT_BSTRIKE_9, oPC))
        nCount = 9;
    else if (GetHasFeat(FEAT_BSTRIKE_8, oPC))
        nCount = 8;
    else if (GetHasFeat(FEAT_BSTRIKE_7, oPC))
        nCount = 7;
    else if (GetHasFeat(FEAT_BSTRIKE_6, oPC))
        nCount = 6;
    else if (GetHasFeat(FEAT_BSTRIKE_5, oPC))
        nCount = 5;
    else if (GetHasFeat(FEAT_BSTRIKE_4, oPC))
        nCount = 4;
    else if (GetHasFeat(FEAT_BSTRIKE_3, oPC))
        nCount = 3;
    else if (GetHasFeat(FEAT_BSTRIKE_2, oPC))
        nCount = 2;
    else if (GetHasFeat(FEAT_BSTRIKE_1, oPC))
        nCount = 1;
    else
        nCount = 0;

    return nCount;
}

void _prc_inc_hextor_ApplyBrutalStrike(object oPC, int nBonus)
{
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (!GetIsObjectValid(oWeap))
    {
        oWeap = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC);
        if (!GetIsObjectValid(oWeap))
        {
            oWeap = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC);
            if (!GetIsObjectValid(oWeap))
                oWeap = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC);
        }
    }
    int nDamageType = (!GetIsObjectValid(oWeap)) ? DAMAGE_TYPE_BLUDGEONING : GetItemDamageType(oWeap);

    effect eBrutalStrike;
    if (GetLocalInt(oPC, BRUTAL_STRIKE_MODE_VAR))
        eBrutalStrike = EffectAttackIncrease(nBonus);
    else
        eBrutalStrike = EffectDamageIncrease(nBonus, nDamageType);
    eBrutalStrike = ExtraordinaryEffect(eBrutalStrike);
    
    const int SPELL_HEXTOR_MODE = 3859; //TODO: MOVE TO include file
    PRCRemoveEffectsFromSpell(oPC, SPELL_HEXTOR_DAMAGE);
    PRCRemoveEffectsFromSpell(oPC, SPELL_HEXTOR_MODE);
    
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBrutalStrike, oPC);    
}
