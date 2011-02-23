/////:://///////////////////////////////////////////////////////////////////////
/////:: Script for upgrading the champion's melee weapons to hero versions.
/////:: Written by Winterknight on 10/7/05
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
     object oPC = GetPCSpeaker();
     object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
     string sWeapTag = GetTag(oWeap);
     int nTagLength = GetStringLength(sWeapTag);
     int nTypeLength = (nTagLength -8);
     string sType = GetSubString(sWeapTag, 4, nTypeLength);
     string sLeftTag = GetStringLeft(sWeapTag,4);
     string sRightTag = GetStringRight(sWeapTag,3);

     if(GetIsObjectValid(oWeap))
         {
         if(sLeftTag=="ith_")
             {
             if(sRightTag=="002")
                 {
                 location lPC = GetLocation(oPC);
                 string sHeroWeap = "ith_"+sType+"_003";
                 DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), lPC));
                 DestroyObject(oWeap, 0.5);
                 CreateItemOnObject(sHeroWeap,oPC,1);
                 TakeGoldFromCreature(5000000,oPC,TRUE);
                 }
             }
         }

}
