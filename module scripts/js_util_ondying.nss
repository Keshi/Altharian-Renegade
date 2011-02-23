void main()
{
    object oPlayer = GetLastPlayerDying();
    if (!GetIsObjectValid(oPlayer))
        return;

    int iCurrentHP = GetCurrentHitPoints(oPlayer);

    if (iCurrentHP > 0) // not dying - why are we here?
        return;

    int MaxNeg=-10 ;
   // int iIsHC=GetLocalInt(oPlayer ,"IsHC");
   // if (iIsHC==1)
      //  {
     //    MaxNeg=MaxNeg-GetHitDice(oPlayer);

      //  }



    if (iCurrentHP <= MaxNeg)  // already dead
    {
        effect eDeath = EffectDeath(FALSE, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPlayer);
        return;
    }

    SetLocalInt(oPlayer, "BLEED_STATUS", 2);    // status bleeding
    AssignCommand(oPlayer, ClearAllActions());
    SetLocalInt(oPlayer, "LAST_HP", iCurrentHP);
    effect ePara = EffectParalyze();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oPlayer, 6.0);
    DelayCommand(6.0, ExecuteScript("js_util_bleed", oPlayer));
}
