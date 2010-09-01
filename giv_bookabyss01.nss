/////:://///////////////////////////////////////////////////////////////////////
/////:: Script for issuing Book of the Abyss
/////:: Written by Winterknight on 12/4/05
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetLastOpenedBy();
    string sOldBook = "bookoftheabyss01";
    string sNewBook = "bookoftheabyss02";
    object oBook = GetItemPossessedBy(oPC,sOldBook);
    if (GetIsObjectValid(oBook))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oPC);
            DestroyObject(oBook,0.75);
            CreateItemOnObject(sNewBook,oPC,1);
        }
}
