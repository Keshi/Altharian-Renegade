void main()
{
    object oPlayer = GetLastPlayerDied();
    CreateItemOnObject("death", oPlayer, 1);

    if (!GetIsObjectValid(oPlayer))
        return;
    int ATArmor=0;
    object oArmor=GetItemInSlot(INVENTORY_SLOT_CHEST,oPlayer);
    if( GetTag(oArmor)=="leafarmor2") ATArmor=1;
    if( GetTag(oArmor)=="twigarmor2") ATArmor=1;
    if( GetTag(oArmor)=="barkarmor2") ATArmor=1;
    if( GetTag(oArmor)=="woodenarmor2") ATArmor=1;
     if( GetTag(oArmor)=="leafarmor2") ATArmor=1;
    if( GetTag(oArmor)=="twigarmor2") ATArmor=1;
    if( GetTag(oArmor)=="barkarmor2") ATArmor=1;
    if( GetTag(oArmor)=="woodenarmor2") ATArmor=1;
    if( GetTag(oArmor)=="leafarmor12") ATArmor=1;
    if( GetTag(oArmor)=="twigarmor12") ATArmor=1;
    if( GetTag(oArmor)=="barkarmor003") ATArmor=1;
    if( GetTag(oArmor)=="woodenarmor12") ATArmor=1;








    if (ATArmor==1)






    SetLocalInt(oPlayer, "BLEED_STATUS", 0);
    AssignCommand(oPlayer, ClearAllActions());
    string msg = "If you choose to respawn, you will reappear at your respawn location " +
        "and lose 100 XP per level and gold.";

    int iIsHC=GetLocalInt(oPlayer ,"IsHC");
    if (iIsHC==1)
        {
          msg = "If you choose to respawn as a Hard Core player, you will reappear at your respawn location " +
        "and lose 1000 XP per level and gold.";
            //100/lev if HC, 50/lev if armor  every time
            int nXP = GetXP(oPlayer);
           int  nPenalty = 100 * GetHitDice(oPlayer);
            if (ATArmor==1)  nPenalty = 50 * GetHitDice(oPlayer);
            int nNewXP = nXP - nPenalty;
            SetXP(oPlayer, nNewXP);
            int iCurrentXP=GetXP(oPlayer);
            SetLocalInt(oPlayer,"OldXP",iCurrentXP);


        }

    if (ATArmor==1)
        {
          msg = "You are wearing Armor from the Apothecary Tree. If you  " +
        "choose to respawn you will appear at the Apothecary Tree with a loss of 50 XP/level "+
        " if you are not Hard Corps. Hard Corps players will loose 400 XP/level and 5% gold";

        }

   DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, TRUE, TRUE, 0, msg));




}
