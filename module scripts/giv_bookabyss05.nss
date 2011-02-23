/////:://///////////////////////////////////////////////////////////////////////
/////:: Script for issuing Book of the Abyss
/////:: Written by Winterknight on 12/4/05
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetLastUsedBy();
    string sOldBook = "bookoftheabyss04";
    string sNewBook = "bookoftheabyss05";
    object oBook = GetItemPossessedBy(oPC,sOldBook);
    if (GetIsObjectValid(oBook))
        {
            DestroyObject(oBook);
            CreateItemOnObject(sNewBook,oPC,1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oPC);
        }
}
