////////////////////////////////////////////////////////////////////////////
// alth_inc_aa.nss
// 
// added: Jan 6 2011
// added by: Carson Lee
// notes: Arcane Archer related functions.  Use with PRC dependency set.
////////////////////////////////////////////////////////////////////////////


// copied from x0_i0_spells to remove dependency
int ArcaneArcherDamageDoneByBow(int bCrit = FALSE, object oUser = OBJECT_SELF)
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    int nDamage;
    int bSpec = FALSE;
    int bEpicSpecialization = FALSE;

    if (GetIsObjectValid(oItem) == TRUE)
    {
        if (GetBaseItemType(oItem) == BASE_ITEM_LONGBOW )
        {
            nDamage = d8();
            if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LONGBOW,oUser))
            {
              bSpec = TRUE;
            }
            if (GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_LONGBOW,oUser))
            {
              bEpicSpecialization = TRUE;
            }
        }
        else
        if (GetBaseItemType(oItem) == BASE_ITEM_SHORTBOW)
        {
            nDamage = d6();
            if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORTBOW,oUser))
            {
              bSpec = TRUE;
            }
            if (GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_SHORTBOW,oUser))
            {
              bEpicSpecialization = TRUE;
            }
        }
        else
            return 0;
    }
    else
    {
            return 0;
    }

    // add strength bonus
    int nStrength = GetAbilityModifier(ABILITY_STRENGTH,oUser);
    nDamage += nStrength;

    if (bSpec == TRUE)
    {
        nDamage +=2;
    }
    if ( bEpicSpecialization == TRUE )
    {
        nDamage +=4;
    }
    if (bCrit == TRUE)
    {
         nDamage *=3;
    }

    return nDamage;
}
