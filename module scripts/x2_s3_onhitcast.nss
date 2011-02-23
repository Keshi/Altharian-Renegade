//::///////////////////////////////////////////////
//:: User Defined OnHitCastSpell code
//:: x2_s3_onhitcast
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This file can hold your module specific
    OnHitCastSpell definitions

    How to use:
    - Add the Item Property OnHitCastSpell: UniquePower (OnHit)
    - Add code to this spellscript (see below)

   WARNING!
   This item property can be a major performance hog when used
   extensively in a multi player module. Especially in higher
   levels, with each player having multiple attacks, having numerous
   of OnHitCastSpell items in your module this can be a problem.

   It is always a good idea to keep any code in this script as
   optimized as possible.


*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-22
//::
//:: Edited by Winterknight for the Guardian weapon systems
//:: Last edit on 1/3/2008
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "wk_tools"
//#include "X0_I0_SPELLS"
//#include "x2_inc_spellhook"
// uncomment above to use shape

void main()
{
  object oItem;        // The item casting triggering this spellscript
  object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
  object oSpellOrigin; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor

  // fill the variables
  oSpellOrigin = OBJECT_SELF;
  object oPC   = oSpellOrigin;
  oSpellTarget = GetSpellTargetObject();
  oItem        = GetSpellCastItem();
  string sTag  = GetTag(oItem);


//::////////////////////////////////////////////////////////////////////////////
//:: Begin the individual guardian sections
//:: While slightly cumbersome, because each guardian strike effect is unique
//:: it doesn't make sense to try to create subroutines or functions for the
//:: different effects.  The major variables in each guardian function are the
//:: base damage, the guardian level currently in effect, and the random crit
//:: effect roll for each hit.  The base damage and guardian level are set by
//:: the activation scripts to save work in this script, so the function must
//:: simply collect those two local integers, and perform a couple of quick
//:: calculations with them to determine if a crit is obtained, and what effect
//:: is obtained as a result of that critical.
//::////////////////////////////////////////////////////////////////////////////


//**********************  FULMINATE - SIGIL - WARRIOR  ***********************//
  if (sTag == "fulminate")
  {
    int nSigil = GetSigil(oPC);
    int iWeapThreat = 20;
    switch(nSigil)
    {
      case 1: iWeapThreat = 18; break;
      case 2: iWeapThreat = 20; break;
      case 3: iWeapThreat = 18; break;
      case 4: iWeapThreat = 18; break;
      case 5: iWeapThreat = 17; break;
      case 6: iWeapThreat = 16; break;
    }
    int nDam = GetLocalInt(oPC,"guardiandamage");
    if (!GetIsPC(oPC) & nDam > 250) nDam = 250;
    if (nDam < 100) nDam = 100;
    string sStrikeText = "Mithril Critical!";

    if (d20(1) >= iWeapThreat)
    {
      if (nSigil >= 1) sStrikeText = "Sigil Strike!";
      if (nSigil >= 6) sStrikeText = "Sainted Sigil Strike!";
      if (nSigil == 2 || nSigil >= 4)
      {
        if (d20(1)>10)
        {
          sStrikeText = "A Thunderous Strike!";
          effect eExplode = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
          if (nSigil >=6)
          {
            sStrikeText = "Vengeance of the Storm Lord!";
            eExplode = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
          }
          int nDC = 20 + (nSigil*5);
          float fDelay;

          effect eVis  = EffectVisualEffect(VFX_IMP_SONIC);
          effect eVis2 = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
          effect eVis3 = EffectVisualEffect(VFX_IMP_STUN);
          effect eDeaf = EffectDeaf();
          effect eKnock = EffectKnockdown();
          effect eStun = EffectStunned();

          location lTarget = GetLocation(oSpellTarget);
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
          object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          while (GetIsObjectValid(oTarget))
          {
            if(GetIsEnemy(oTarget, OBJECT_SELF))
            {
              fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
              if(FortitudeSave(oTarget, nDC, SAVING_THROW_TYPE_SONIC)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, RoundsToSeconds(10)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
              }
              if(WillSave(oTarget, nDC, SAVING_THROW_TYPE_SONIC)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(1)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              }
              if(ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_SONIC)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget, 6.0f));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis3, oTarget,4.0f));
              }
              effect eBlast= EffectDamage(nDam,DAMAGE_TYPE_SONIC);
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlast, oTarget));
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          } // End of While for Object Valid Target
        } // End of second check for 50% chance of Thunderous Strike on Critical.
      } // End of Thunderous Strike Contingency Loop

      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      if (GetIsPC(oPC)) SendMessageToPC(oPC,sStrikeText);
      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    } // End of loop for Critical strike
    return;
  }


//*********************  INNERPATH - DISCIPLINE - MONK  **********************//
  if (sTag == "innerpath")
  {
    int nMonk = GetInnerPath(oPC);
    int iWeapThreat = 19;
    switch(nMonk)
    {
      case 1: iWeapThreat = 17; break;
      case 2: iWeapThreat = 19; break;
      case 3: iWeapThreat = 17; break;
      case 4: iWeapThreat = 17; break;
      case 5: iWeapThreat = 16; break;
      case 6: iWeapThreat = 15; break;
    }
    int nDam = GetLocalInt(oPC,"guardiandamage");
    if (!GetIsPC(oPC) & nDam > 250) nDam = 250;
    if (nDam < 100) nDam = 100;

    string sStrikeText = "Open Hand Critical!";
    if (d20(1) >= iWeapThreat)
    {
      if (nMonk >= 1) sStrikeText = "Thousand Palms Strike!";
      if (nMonk >= 6) sStrikeText = "Sainted Palm Strike!";
      if (nMonk == 2 || nMonk >= 4)
      {
        if (d20(1)>10)
        {
          sStrikeText = "Storm Strike!";
          if (nMonk >= 6) sStrikeText = "Eye of the Storm Strike!";
          int nDC = 20 + (nMonk*5);
          float fDelay;
          effect eExplode = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);
          effect eVis  = EffectVisualEffect(VFX_IMP_SONIC);
          effect eVis2 = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
          effect eVis3 = EffectVisualEffect(VFX_IMP_STUN);
          effect eDeaf = EffectDeaf();
          effect eKnock = EffectKnockdown();
          effect eStun = EffectStunned();

          location lTarget = GetLocation(oSpellTarget);
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
          object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          while (GetIsObjectValid(oTarget))
          {
            if(GetIsEnemy(oTarget, OBJECT_SELF))
            {
              fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
              if(FortitudeSave(oTarget, nDC, SAVING_THROW_TYPE_SONIC)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, RoundsToSeconds(10)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
              }
              if(WillSave(oTarget, nDC, SAVING_THROW_TYPE_SONIC)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(1)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              }
              if(ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_SONIC)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget, 6.0f));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis3, oTarget,4.0f));
              }
              effect eBlast= EffectDamage(nDam,DAMAGE_TYPE_SONIC);
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlast, oTarget));
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          } // End of While for Object Valid Target
        } // End of second check for 50% chance of Thunderous Strike on Critical.
      } // End of Thunderous Strike

      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      SendMessageToPC(oPC,sStrikeText);

      if (nMonk <1) nDam = nDam/2;
      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    }// End of loop for Critical strike
    return;
  }


//*********************  STILLETTO - TECHNIQUE - ROGUE  **********************//
  if (sTag == "stilletto")
  {
    int nTech = GetTechnique(oPC);
    int iWeapThreat = 20;
    int nLegend = 0;
    switch(nTech)
    {
      case 1: iWeapThreat = 18; break;
      case 2: iWeapThreat = 19; break;
      case 3: iWeapThreat = 18; break;
      case 4: iWeapThreat = 18; break;
      case 5: iWeapThreat = 17; nLegend = 1; break;
      case 6: iWeapThreat = 16; nLegend = 2; break;
    }
    int nDam = GetLocalInt(oPC,"guardiandamage");
    if (!GetIsPC(oPC) & nDam > 200) nDam = 200;
    if (nDam < 50) nDam = 50;
    string sStrikeText = "Stilletto Critical!";
    string sStrikeText2;
    if (d20(1) >= iWeapThreat)
    {
      int nCritcheck = d20(1);
      if (nTech >= 1) sStrikeText = "Technical Strike!";
      if (nTech >= 6) sStrikeText = "Sainted Technical Strike!";
      if (nTech == 2 || nTech >= 4)
      {
        if (nCritcheck >5 & nCritcheck <16)
        {
          sStrikeText = "Wave of Darkness!";
          if (nTech >= 6) sStrikeText = "Reign of Utter Darkness!";
          int nDC = 20 + (nTech*5);
          float fDelay;
          effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_ODD);
          effect eVis  = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
          effect eVis2 = EffectVisualEffect(VFX_IMP_BREACH);
          effect eVis3 = EffectVisualEffect(VFX_IMP_STUN);
          effect eCurse = EffectCurse(nTech,nTech,nTech,nTech,nTech,nTech);
          effect eKnock = EffectKnockdown();
          effect eStun = EffectStunned();

          location lTarget = GetLocation(oSpellTarget);
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
          object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          while (GetIsObjectValid(oTarget))
          {
            if(GetIsEnemy(oTarget, OBJECT_SELF))
            {
              fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
              if(FortitudeSave(oTarget, nDC, SAVING_THROW_TYPE_DIVINE)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCurse, oTarget, RoundsToSeconds(10)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
              }
              if(WillSave(oTarget, nDC, SAVING_THROW_TYPE_DIVINE)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(1)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              }
              if(ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_DIVINE)<1)
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget, 6.0f));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis3, oTarget,4.0f));
              }
              effect eBlast= EffectDamage(nDam,DAMAGE_TYPE_MAGICAL);
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlast, oTarget));
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          } // End of While for Object Valid Target
        } // End of second check for 50% chance of Wave attack.
      } // End of Wave attack
      if (nTech >= 3 & nCritcheck >=(19-nLegend))
      {
        sStrikeText = "Death's Cold Hand!";
        if (nTech >= 6) sStrikeText = "Hand of Death's Master!";
        int nDC = 20 + (nTech*5);
        int nDam2 = GetCurrentHitPoints(oSpellTarget);
        if (nDam2 > 1000) nDam2 = 1000;
        if(FortitudeSave(oSpellTarget, nDC, SAVING_THROW_TYPE_DIVINE)>1)
        {
          nDam2 = nDam2/4;
          sStrikeText2 = " - Saved for reduced damage";
        }
        effect eKill= EffectDamage(nDam2, DAMAGE_TYPE_MAGICAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oSpellTarget);
      }// End of Death's Cold Hand
      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      if (sStrikeText2 != "") sStrikeText = sStrikeText + sStrikeText2;
      SendMessageToPC(oPC,sStrikeText);

      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    }// End of loop for Critical strike
    return;
  }


//********************  HOLYSWORD - VESPERBEL - PALADIN  *********************//
  if (sTag == "holysword")
  {
    int nVesper = GetVesper(oPC);
    if (nVesper < 1) return;
    int iWeapThreat = 20;
    switch(nVesper)
    {
      case 1: iWeapThreat = 18; break;
      case 2: iWeapThreat = 19; break;
      case 3: iWeapThreat = 18; break;
      case 4: iWeapThreat = 18; break;
      case 5: iWeapThreat = 17; break;
      case 6: iWeapThreat = 16; break;
    }
    int nDam = GetLocalInt(oPC,"guardiandamage");
    if (!GetIsPC(oPC) & nDam > 200) nDam = 200;
    if (nDam < 100) nDam = 100;

    string sStrikeText = "Blessed Critical!";
    if (d20(1) >= iWeapThreat)
    {
      if (nVesper >= 1) sStrikeText = "Holy Strike!";
      if (nVesper >= 6) sStrikeText = "Sainted Avatar's Strike!";
      if (nVesper == 2 || nVesper >= 4)
      {
        if (d20(1)>10)
        {
          sStrikeText = "Hand of Jehon!";
          effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_MIND);
          if (nVesper >=6)
          {
            sStrikeText = "His Avatar's Righteous Wrath!";
            eExplode = EffectVisualEffect(VFX_IMP_PULSE_HOLY_SILENT);
          }
          int nDC = 20 + (nVesper*5);
          int nType;
          float fDelay;

          location lTarget = GetLocation(oSpellTarget);
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
          object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          while (GetIsObjectValid(oTarget))
          {
            if(GetIsEnemy(oTarget, OBJECT_SELF))
            {
              fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
              nType = GetRacialType(oTarget);
              int nDam2 = nDam;

              if (nType == RACIAL_TYPE_UNDEAD)
              {
                nDam2 = nDam * 2;
                effect eVis = EffectVisualEffect(VFX_IMP_HARM, FALSE);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              }
              if (nType == RACIAL_TYPE_OUTSIDER)
              {
                nDam2 = nDam * 2;
                effect eVis = EffectVisualEffect(VFX_IMP_HARM, FALSE);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              }

              effect eBlast = EffectDamage(nDam2, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlast, oTarget));
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          } // End of While for Object Valid Target
        } // End of second check for 50% chance of Thunderous Strike on Critical.
      } // End of Thunderous Strike

      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      SendMessageToPC(oPC,sStrikeText);

      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    }// End of loop for Critical strike
    return;
  }

//********************  ARCHERBOW - ARROWSHOT - ANYONE   *********************//
  if (sTag == "arrowshot")
  {
    int nArch = GetArchery(oPC);
    if (nArch < 1) return;
    int iWeapThreat = 20;
    switch(nArch)
    {
      case 1: iWeapThreat = 18; break;
      case 2: iWeapThreat = 19; break;
      case 3: iWeapThreat = 18; break;
      case 4: iWeapThreat = 18; break;
      case 5: iWeapThreat = 17; break;
      case 6: iWeapThreat = 16; break;
    }
    int nDam = GetLocalInt(oPC,"guardiandamage");
    if (!GetIsPC(oPC) & nDam > 200) nDam = 200;
    if (nDam < 100) nDam = 100;

    string sStrikeText = "Piercing Strike!";
    if (d20(1) >= iWeapThreat)
    {
      if (nArch >= 1) sStrikeText = "Targeted Strike!";
      if (nArch >= 6) sStrikeText = "Sainted Piercing Strike!";
      if (nArch == 2 || nArch >= 4)
      {
        if (d20(1)>10)
        {
          sStrikeText = "From the Master's Hand!";
          effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_MIND);
          if (nArch >=6)
          {
            sStrikeText = "Missile of Righteousness";
            eExplode = EffectVisualEffect(VFX_IMP_PULSE_HOLY_SILENT);
          }
          int nDC = 20 + (nArch*5);
          int nCritter;
          float fDelay;

          location lTarget = GetLocation(oSpellTarget);
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
          object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          while (GetIsObjectValid(oTarget))
          {
            if(GetIsEnemy(oTarget, OBJECT_SELF))
            {
              fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
              nCritter = GetRacialType(oTarget);
              int nDam2 = nDam;
              if (nCritter == RACIAL_TYPE_UNDEAD || nCritter == RACIAL_TYPE_OUTSIDER)
              {
                nDam2 = nDam * 3/2;
                effect eVis = EffectVisualEffect(VFX_IMP_HARM, FALSE);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              }
              effect eBlast = EffectDamage(nDam2, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlast, oTarget));
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
          } // End of While for Object Valid Target
        } // End of second check for 50% chance of Thunderous Strike on Critical.
      } // End of Thunderous Strike

      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      SendMessageToPC(oPC,sStrikeText);

      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    }// End of loop for Critical strike
    return;
  }


//*********************  WHITEGOLD - WILDMAGIC - DRUID  **********************//
  if (sTag == "whitegold")
  {
    int nBeast = GetWhiteGold(oPC);
    if (nBeast < 1) return;
    int iWeapThreat = 20;
    switch(nBeast)
    {
      case 1: iWeapThreat = 19; break;
      case 2: iWeapThreat = 20; break;
      case 3: iWeapThreat = 19; break;
      case 4: iWeapThreat = 19; break;
      case 5: iWeapThreat = 18; break;
      case 6: iWeapThreat = 17; break;
    }

    if (d20(1) >= iWeapThreat)
    {
      int nDam = GetLocalInt(oPC,"guardiandamage");
      if (!GetIsPC(oPC) & nDam > 250) nDam = 250;
      if (nDam < 100) nDam = 100;
      string sStrikeText = "Bestial Critical!";
      if (nBeast >= 1) sStrikeText = "Wild Magic Strike!";
      if (nBeast >= 6) sStrikeText = "Sainted Wild Strike!";

      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      if (GetIsPC(oPC)) SendMessageToPC(oPC,sStrikeText);
      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    } // End of loop for Critical strike
    return;
  }


//********************  NON-COMBATANT MITHRIL CRITICALS  *********************//
  if (sTag == "magestaff")
  {
    int nMage = GetMageStaff(oPC);
    if (nMage < 1) return;
    int iWeapThreat = 20;
    if (d20(1) >= iWeapThreat)
    {
      int nDam = GetLocalInt(oPC,"guardiandamage");
      if (!GetIsPC(oPC) & nDam > 250) nDam = 250;
      if (nDam < 50) nDam = 50;
      string sStrikeText = "Mithril Critical!";

      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      if (GetIsPC(oPC)) SendMessageToPC(oPC,sStrikeText);
      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    }
    return;
  }

  if (sTag == "vesperbel")
  {
    int nVesp = GetVesper(oPC);
    if (nVesp < 1) return;
    int iWeapThreat = 20;
    if (d20(1) >= iWeapThreat)
    {
      int nDam = GetLocalInt(oPC,"guardiandamage");
      if (!GetIsPC(oPC) & nDam > 250) nDam = 250;
      if (nDam < 50) nDam = 50;
      string sStrikeText = "Mithril Critical!";

      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      if (GetIsPC(oPC)) SendMessageToPC(oPC,sStrikeText);
      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    }
    return;
  }

  if (sTag == "harmonics")
  {
    int nBard = GetHarmonic(oPC);
    if (nBard < 1) return;
    int iWeapThreat = 20;
    if (d20(1) >= iWeapThreat)
    {
      int nDam = GetLocalInt(oPC,"guardiandamage");
      if (!GetIsPC(oPC) & nDam > 250) nDam = 250;
      if (nDam < 50) nDam = 50;
      string sStrikeText = "Mithril Critical!";

      FloatingTextStringOnCreature(sStrikeText, oSpellOrigin);
      if (GetIsPC(oPC)) SendMessageToPC(oPC,sStrikeText);
      effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSpellTarget);
    }
    return;
  }



}
