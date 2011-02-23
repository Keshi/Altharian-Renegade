/////:://///////////////////////////////////////////////////////////////////////
/////:: Script for issuing Book of the Abyss
/////:: Written by Winterknight on 12/4/05
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetLastUsedBy();
    string sOldBook = "bookoftheabyss03";
    string sNewBook = "bookoftheabyss04";
    object oBook = GetItemPossessedBy(oPC,sOldBook);
    if (GetIsObjectValid(oBook))
        {
            DestroyObject(oBook);
            CreateItemOnObject(sNewBook,oPC,1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oPC);
        }
}
