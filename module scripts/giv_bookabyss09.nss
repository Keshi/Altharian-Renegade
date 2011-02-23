/////:://///////////////////////////////////////////////////////////////////////
/////:: Script for issuing Book of the Abyss
/////:: Written by Winterknight on 12/4/05
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetLastUsedBy();
    string sOldBook = "bookoftheabyss08";
    string sNewBook = "bookoftheabyss09";
    object oBook = GetItemPossessedBy(oPC,sOldBook);
    if (GetIsObjectValid(oBook))
        {
            DestroyObject(oBook,0.75);
            CreateItemOnObject(sNewBook,oPC,1);
        }
}
