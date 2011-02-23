/////:://///////////////////////////////////////////////////////////////////////
/////:: Main Heartbeat Script for Altharia
/////:: Includes functions for stripping buffs in the Abyss and Aurum's
/////:: Includes damage pulse function for Abyss, Dragon areas, Fire areas
/////:: Written by Winterknight From 10/16/05 thru 12/15/05
/////:: Some scripting adapted from original 12DS scripts by Kurt Hansen
/////:://///////////////////////////////////////////////////////////////////////

/////:://///////////////////////////////////////////////////////////////////////
/////:: RespawnObject - Still used by some EZ stuff that we haven't fixed yet.
/////:: Subscript called from the main heartbeat script
/////:: Written/Modified by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void RespawnObject(string sTag, int iType, location lLoc)
    {
    // ResRef must be derivable from Tag
    string sResRef = GetStringLowerCase(GetStringLeft(sTag, 16));
    CreateObject(iType, sResRef, lLoc);
    }

/////:://///////////////////////////////////////////////////////////////////////
/////:: Dragon Stripper - removes invisibility effects from players
/////:: Subscript called from the main heartbeat script
/////:: Written/Modified by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void SanctStripper(object oPC)
{
    effect eBad3 = GetFirstEffect(oPC);
    //Search for sanctuary and invisibility
    while(GetIsEffectValid(eBad3))
       {
       if ( GetEffectType(eBad3) == EFFECT_TYPE_ETHEREAL
           || GetEffectType(eBad3) == EFFECT_TYPE_INVISIBILITY )
           {
               RemoveEffect(oPC, eBad3);
           }
       eBad3 = GetNextEffect(oPC);
       }
}

/////:://///////////////////////////////////////////////////////////////////////
/////:: Abyss Stripper - removes neg protect from the characters in the abyss
/////:: Subscript called from the main heartbeat script
/////:: Written/Modified by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void AbyssStripper (object oPC)
{
    effect eVis = EffectVisualEffect(VFX_IMP_BREACH);
    effect eBad = GetFirstEffect(oPC);
    int  spellid;

    while(GetIsEffectValid(eBad))
        {
        spellid=GetEffectSpellId(eBad);
        if ( ( spellid == SPELL_NEGATIVE_ENERGY_PROTECTION)
           ||( spellid == SPELL_SHADOW_SHIELD)
           ||( spellid == SPELL_UNDEATHS_ETERNAL_FOE))
           {
           if ( GetEffectType(eBad)== EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE)
              {
                  RemoveEffect(oPC, eBad);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
              }
           }
        eBad = GetNextEffect(oPC);
        }
}

/////:://///////////////////////////////////////////////////////////////////////
/////:: Pulse Damage - Applies damage pulse to player
/////:: Subscript called from the main heartbeat script
/////:: Written/Modified by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void DamagePulse(int nPain, int nDamageType, object oPC, int nVFX)
{
    effect eZAP = EffectDamage(nPain, nDamageType, DAMAGE_POWER_NORMAL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eZAP, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(nVFX,FALSE), oPC);
}

/////:://///////////////////////////////////////////////////////////////////////
/////:: Main heartbeat - various functions by area first, server stuff follows
/////:: Written/Modified by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
    int iCount = GetLocalInt(OBJECT_SELF,"beats");
    iCount++;
    SetLocalInt(OBJECT_SELF, "beats", iCount);
    int nPain = 0;
    int nDamageType;
    int nBasePain;

    object oPC=GetFirstPC();
                                                //Used for easy coding - 5 letter left side Ezalb, Abyss, Aurum for damages.
    while (GetIsObjectValid (oPC))              //Start of the PC Loop, various functions.
       {
       int nPain = 0;
       object oArea = GetArea(oPC);
       string sArea = GetTag(oArea);
       string sLeft = GetStringLeft(sArea,5);
       int iIsInDeath=0;
       int nUpgrade = GetLocalInt(oPC,"UpgradeTimer");
       int nVirtue = GetLocalInt(oPC,"VirtueBuff");
//  This loop could be used to ensure regular updates of any local to campaign variables.
       if (iCount==100)
         {
           //int nToken = GetLocalInt(oPC,"ThanwarTokenCount");
           //SetCampaignInt("altharia","ThanwarCollector",nToken,oPC);
         }
//  Guardian Upgrade Countdown Function
       if (nUpgrade == 10)
         {
           SendMessageToPC(oPC,"1 Minute until Guardian Effect Expires.");
         }
       if (nUpgrade > 1)
         {
           nUpgrade = nUpgrade - 1;
           SetLocalInt(oPC,"UpgradeTimer",nUpgrade);
         }
       if (nUpgrade == 1)
         {
           SetLocalInt(oPC,"UpgradeTimer",0);
           DelayCommand(5.8,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BREACH), oPC));
           string sTag = GetLocalString(oPC,"actitem");
           SetLocalInt(oPC,sTag,0);
         }

//  VirtueBuff Countdown
       if (nVirtue > 1)
         {
           nVirtue = nVirtue - 1;
           SetLocalInt(oPC,"VirtueBuff",nVirtue);
         }
       if (nVirtue == 1)
         {
           SetLocalInt(oPC,"VirtueBuff",0);
         }

//  Begin the stripper and pulse checks
       if (sLeft == "Riftt") // This section covers the Aurums areas, variable damage types.
           {
               int nAurums = 1;
               if (nAurums==1 && (iCount % 5) ==0)   // Applies damage every 30 seconds in the Aurum areas.  Pansies.
                   {
                       string sFactor = GetSubString(sArea,5,2);
                       int nFactor = StringToInt(sFactor);
                       nBasePain = 10;
                       nPain = nBasePain * nFactor;
                       if (GetCurrentHitPoints(oPC)> 3000 ) { nPain = nPain + d2(1)*1000 ;}

                       int nRandom = Random(4);
                       if (nRandom==1) {nDamageType = DAMAGE_TYPE_FIRE;}
                       if (nRandom==2) {nDamageType = DAMAGE_TYPE_ELECTRICAL;}
                       if (nRandom==3) {nDamageType = DAMAGE_TYPE_COLD;}
                       if (nRandom==0) {nDamageType = DAMAGE_TYPE_ACID;}

                       int nVFX = VFX_IMP_FLAME_S;
                       SanctStripper(oPC);
                       DamagePulse(nPain,nDamageType,oPC,nVFX);
                   }
           }

       if (sLeft == "Abyss"||
           sLeft == "Abys_"||
           sLeft == "abyss")   // This covers all the areas of the Abyss.  Neg strip and damage pulse.
           {
               string sFactor = GetSubString(sArea,5,2);
               int nStripDelay = 10;
               int nFactor = StringToInt(sFactor);
               nBasePain = 5;
               nPain = nBasePain * nFactor;
               int nVFX = VFX_IMP_NEGATIVE_ENERGY;
               if (sFactor == "44")
                   {
                       nPain = GetMaxHitPoints(oPC)/20; // will double with fire
                       nDamageType = DAMAGE_TYPE_FIRE;
                       DamagePulse(nPain,nDamageType,oPC,nVFX);
                   }
               if (sFactor == "55")
                   {
                       nPain = GetMaxHitPoints(oPC)/10;
                   }
               if (sFactor == "66")
                   {
                       nPain = GetMaxHitPoints(oPC)/10; // will double with fire
                       nStripDelay = 5;
                       nDamageType = DAMAGE_TYPE_FIRE;
                       DamagePulse(nPain,nDamageType,oPC,nVFX);
                   }
               if (sFactor == "77")
                   {
                       nPain = GetMaxHitPoints(oPC)/5;
                       nStripDelay = 5;
                   }
               if (sFactor == "88")
                   {
                       nPain = GetMaxHitPoints(oPC)/6; // will double with fire
                       nStripDelay = 3;
                       nDamageType = DAMAGE_TYPE_FIRE;
                       DamagePulse(nPain,nDamageType,oPC,nVFX);
                   }
               if (sFactor == "99")
                   {
                       nPain = GetMaxHitPoints(oPC)/3;
                       nStripDelay = 3;
                   }
               if (sFactor != "00")     // If in an area that has negative damage
                   {
                       nDamageType = DAMAGE_TYPE_NEGATIVE;
                       DamagePulse(nPain,nDamageType,oPC,nVFX);
                   }


               if (iCount % (nStripDelay) == 0)
                   {
                       AbyssStripper(oPC);
                       SanctStripper(oPC);
                   }   // Varies by area
           }

       if (sLeft == "Flame"||
           sLeft == "3ppf_")   // This covers all areas where you want Fire damage, variable duration.
           {
               string sFactor = GetSubString(sArea,5,2);     // Area Tag must be "Phyre12_3xxxxxxx" format.
               int nFactor = StringToInt(sFactor);           // The first two numbers after the Phyre are the
               string sDelayPulse = GetSubString(sArea,8,1); // multiplier for the base damage (5).  The digit
               int nDelayPulse = StringToInt(sDelayPulse);   // immediately following the underscore is the delay
               if ((iCount % nDelayPulse) == 0)              // in heartbeats for the damage pulse to hit.  If you
                   {                                         // want the damage to be every heartbeat, make it a 1.
                       nBasePain = 5;                        // If you want it every 2 rounds, make it a 2.
                       nPain = nBasePain * nFactor;          // Note: damage multiplier is a two-digit number. Use
                       nDamageType = DAMAGE_TYPE_FIRE;       // 0 in the first slot if the multiplier is less than 10.
               if (sFactor == "55")                          // Giants
                   {
                       nPain = GetMaxHitPoints(oPC)/10;
                   }
               if (sFactor == "77")                          // Big Red and Process
                   {
                       nPain = GetMaxHitPoints(oPC)/5;
                   }
                       int nVFX = VFX_IMP_FLAME_S;
                       DamagePulse(nPain,nDamageType,oPC,nVFX);
                   }
           }

       if (sLeft == "Storm" ||
           sLeft == "3pps_")   // This covers all areas where you want electrical damage, variable duration.
           {
               string sFactor = GetSubString(sArea,5,2);     // Area Tag must be "Storm12_3xxxxxxx" format.
               int nFactor = StringToInt(sFactor);           // The first two numbers after the Phyre are the
               string sDelayPulse = GetSubString(sArea,8,1); // multiplier for the base damage (5).  The digit
               int nDelayPulse = StringToInt(sDelayPulse);   // immediately following the underscore is the delay
               if ((iCount % nDelayPulse) == 0)              // in heartbeats for the damage pulse to hit.  If you
                   {                                         // want the damage to be every heartbeat, make it a 1.
                       nBasePain = 5;                        // If you want it every 2 rounds, make it a 2.
                       nPain = nBasePain * nFactor;          // Note: damage multiplier is a two-digit number. Use
                       nDamageType = DAMAGE_TYPE_ELECTRICAL; // 0 in the first slot if the multiplier is less than 10.
               if (sFactor == "55")                          // Giants
                   {
                       nPain = GetMaxHitPoints(oPC)/10;
                   }
               if (sFactor == "77")                          // Strom's hold
                   {
                       nPain = GetMaxHitPoints(oPC)/5;
                   }
                       int nVFX = VFX_IMP_LIGHTNING_S;
                       DamagePulse(nPain,nDamageType,oPC,nVFX);
                   }
           }

       if (sLeft == "Freze" ||
           sLeft == "3ppc_")   // This covers all the areas of the Frozen North.  Cold damage.
           {
               string sFactor = GetSubString(sArea,5,2);     // Area Tag must be "Freze12_3xxxxxxx" format.
               int nFactor = StringToInt(sFactor);           // The first two numbers after the Freze are the
               string sDelayPulse = GetSubString(sArea,8,1); // multiplier for the base damage (5).  The digit
               int nDelayPulse = StringToInt(sDelayPulse);   // immediately following the underscore is the delay
               if ((iCount % nDelayPulse) == 0)              // in heartbeats for the damage pulse to hit.  If you
                   {                                         // want the damage to be every heartbeat, make it a 1.
                       nBasePain = 5;                        // If you want it every 2 rounds, make it a 2.
                       nPain = nBasePain * nFactor;          // Note: damage multiplier is a two-digit number. Use
                       nDamageType = DAMAGE_TYPE_COLD;       // 0 in the first slot if the multiplier is less than 10.
                       int nVFX = VFX_IMP_FROST_S;
                       DamagePulse(nPain,nDamageType,oPC,nVFX);
                   }
           }

       if (sLeft == "Magic")   // This covers all the areas with generic magical damage.
           {
               string sFactor = GetSubString(sArea,5,2);            // Area Tag must be "Magic12_3xxxxxxx" format.
               int nMagicDelay = GetLocalInt(oArea,"magicdelay");   // See Phyre above for formatting notes.
               int nFactor = StringToInt(sFactor);                  // Generic to allow multiple uses.
               string sDelayPulse = GetSubString(sArea,8,1);
               int nDelayPulse = StringToInt(sDelayPulse);
               if (nMagicDelay == 0)                                // Magic Delay integer is in heartbeats.
                   {                                                // Uses a local integer on the area to allow
                       if ((iCount % nDelayPulse) == 0)             // the use of devices that can stop damage pulses
                           {                                        // for a given period of time, within that area.
                               nBasePain = 5;                       // Example would be the obelisk in Carnelian.
                               nPain = nBasePain * nFactor;
                               nDamageType = DAMAGE_TYPE_MAGICAL;
                               int nVFX = VFX_IMP_FLAME_S;
                               DamagePulse(nPain,nDamageType,oPC,nVFX);
                           }
                   }
               if (nMagicDelay > 0)
                   {
                       nMagicDelay = nMagicDelay - 1;
                       SetLocalInt(oArea,"magicdelay",nMagicDelay);
                   }
           }

/////:://///////////////////////////////////////////////////////////////////////
/////:: This section starts the PC non-damage or area specific checks.  Includes server shouts.
/////:: Written/modified by Winterknight
/////:://///////////////////////////////////////////////////////////////////////

       if (GetCurrentHitPoints(oPC)>0)                            // If character is not dead, and the character
           {                                                      // has a death token on him, this will remove it.
              object oDeath = GetItemPossessedBy(oPC, "death");
              if (GetIsObjectValid(oDeath))
                 {
                    DestroyObject(oDeath);
                 }
           }

       oPC = GetNextPC();
       }   // End of the PC specific Loop

   if (iCount==100)
       {
           int nRunTime = GetCampaignInt("Altharia","clock");
           nRunTime = nRunTime + 10;
           if ((nRunTime % 60) == 0)
           {
             SpeakString ("Visit our forums at www.altharia.net for all the latest news and discussions on the world of Altharia.");
           }
           SetCampaignInt("Altharia","clock",nRunTime);
           string sRunTime = IntToString(nRunTime);

           iCount=0;
           SetLocalInt(OBJECT_SELF, "beats", iCount);
           ExportAllCharacters();
           SpeakString ("Characters saved.",TALKVOLUME_SHOUT);
           SpeakString ("Server has been running for " + sRunTime + " minutes.",TALKVOLUME_SHOUT);
       }
}
