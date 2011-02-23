
void runAgain(object oPlayer)
{
    SetLocalInt(oPlayer, "LAST_HP", GetCurrentHitPoints(oPlayer));
    effect eParalyze = EffectParalyze();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, oPlayer, 6.0);
    DelayCommand(6.0, ExecuteScript("js_util_bleed", oPlayer));
}

void main()
{
    object oPlayer = OBJECT_SELF;
    if (!GetIsObjectValid(oPlayer))
        return;

     int MaxNeg=-10 ;
   // int iIsHC=GetLocalInt(oPlayer ,"IsHC");
  //  if (iIsHC==1)
    //    {
   //      MaxNeg=MaxNeg-GetHitDice(oPlayer);

     //   }


    int iCurrentHitPoints = GetCurrentHitPoints(oPlayer);
    int iLastHitPoints = GetLocalInt(oPlayer, "LAST_HP");

    if (iCurrentHitPoints <= MaxNeg)   // player is dead
    {
        SendMessageToPC(oPlayer, "You have bled to death.");
        effect eDeath = EffectDeath(FALSE, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPlayer);
        SetLocalInt(oPlayer, "BLEED_STATUS", 3); // status dead
        AssignCommand(oPlayer, ClearAllActions());
        return;
    }

    if (iCurrentHitPoints >= 1) // player is alive & conscious
    {
        SetLocalInt(oPlayer, "BLEED_STATUS", 0);    // status alive
        SendMessageToPC(oPlayer, "You have regained consciousness.");
        return;
    }

    if (GetLocalInt(oPlayer, "BLEED_STATUS") == 1)  // status stable
    {
        if (d4() == 1) //25% heal roll
        {
            effect eHeal = EffectHeal(1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPlayer);
            SendMessageToPC(oPlayer, "You heal 1 hit point.");
        }
        if (GetCurrentHitPoints(oPlayer) >= 1) // player is alive & conscious
        {
            SetLocalInt(oPlayer, "BLEED_STATUS", 0);    // status alive
            SendMessageToPC(oPlayer, "You have regained consciousness.");
            return;
        }
        AssignCommand(oPlayer, ClearAllActions());
        runAgain(oPlayer);
        return;
    }

    if (iCurrentHitPoints > iLastHitPoints || (d4() == 1)) // someone healed player
    {                                                       // or 10% stabilize roll
        SetLocalInt(oPlayer, "BLEED_STATUS", 1);  // status stable
        SendMessageToPC(oPlayer, "You have stabilized.");
        AssignCommand(oPlayer, ClearAllActions());
        runAgain(oPlayer);
        return;
    }

    if (GetLocalInt(oPlayer, "BLEED_STATUS") != 2)  // status bleeding
        return;

    effect eDamage = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPlayer);
    string msg = "You are bleeding to death! " + IntToString(GetCurrentHitPoints(oPlayer));
    SendMessageToPC(oPlayer, msg);
    AssignCommand(oPlayer, ClearAllActions());
    int which = d6();
    switch (which)
    {
        case 1:
            PlayVoiceChat (VOICE_CHAT_PAIN1, oPlayer);
            break;
        case 2:
            PlayVoiceChat (VOICE_CHAT_PAIN2, oPlayer);
            break;
        case 3:
          PlayVoiceChat (VOICE_CHAT_PAIN3, oPlayer);
          break;
        case 4:
            PlayVoiceChat (VOICE_CHAT_HEALME, oPlayer);
            break;
        case 5:
            PlayVoiceChat (VOICE_CHAT_NEARDEATH, oPlayer);
            break;
        case 6:
            PlayVoiceChat (VOICE_CHAT_HELP, oPlayer);
            break;
    }

    if (GetCurrentHitPoints(oPlayer) <= MaxNeg)   // player is dead
    {
        SendMessageToPC(oPlayer, "You have bled to death.");
        effect eDeath = EffectDeath(FALSE, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPlayer);
        SetLocalInt(oPlayer, "BLEED_STATUS", 3); // status dead
        AssignCommand(oPlayer, ClearAllActions());
        return;
    }

    runAgain(oPlayer);
}
