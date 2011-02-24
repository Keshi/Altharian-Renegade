int NSB_SpellCast()
{
    int Domain_Cast = GetLocalInt(oCaster, "Domain_Cast");
    int NSB_Class = GetLocalInt(oCaster, "NSB_Class");

    //if for some reason NSB variables were not removed and the player is not casting from new spellbook
    //remove the variables now
    if((nOrigClass != CLASS_TYPE_INVALID || oOrigItem != OBJECT_INVALID) && NSB_Class)
    {
        //clean local vars
        DeleteLocalInt(oCaster, "NSB_SpellLevel");
        DeleteLocalInt(oCaster, "NSB_Class");
        DeleteLocalInt(oCaster, "NSB_SpellbookID");
    }

//DoDebug("PRC last spell cast class = "+IntToString(nCastingClass));
//DoDebug("Primary Arcane Class = "+IntToString(GetPrimaryArcaneClass(oCaster)));
//DoDebug("Caster Level = "+IntToString(nCasterLevel));

    /*if(nDomainCast)
    {
        int nBurnSpell = GetLocalInt(oCaster, "Domain_BurnableSpell");
        int nLevel = GetLocalInt(oCaster, "Domain_Level");

        // Burn the spell off, then cast the domain spell
        // Also, because of the iprop feats not having uses per day
        // set it so they can't cast again from that level
        SetLocalInt(oCaster, "DomainCastSpell" + IntToString(nLevel), TRUE);
        if(nBurnSpell != -1)
            DecrementRemainingSpellUses(oCaster, nBurnSpell);
        else
            */

    //this shuld be executed only for new spellbook spells
    else if(nOrigClass == CLASS_TYPE_INVALID && oOrigItem == OBJECT_INVALID && NSB_Class)
    {
        int nSpellLevel = GetLocalInt(oCaster, "NSB_SpellLevel");

        if(DEBUG) DoDebug("NSB_Class = "+GetStringByStrRef(StringToInt(Get2DACache("classes", "Name", NSB_Class))));

        if(nSpellbookType == SPELLBOOK_TYPE_PREPARED)
        {
            int nSpellbookID = GetLocalInt(oCaster, "NSB_SpellbookID");
            if(DEBUG) DoDebug("NSB_SpellbookID = "+IntToString(nSpellbookID));
            int nCount = persistant_array_get_int(oCaster, "NewSpellbookMem_" + IntToString(nCastingClass), nSpellbookID);
            string sSpellName = GetStringByStrRef(StringToInt(Get2DACache("spells", "Name", nSpellID)));
            //Anti-cheat?
            if (nCount < 1)
            {
                return FALSE;
            }

            // "You have " + IntToString(nCount - 1) + " castings of " + sSpellName + " remaining"
            string sMessage   = ReplaceChars(GetStringByStrRef(16828410), "<count>",     IntToString(nCount - 1));
                   sMessage   = ReplaceChars(sMessage,                    "<spellname>", sSpellName);

            FloatingTextStringOnCreature(sMessage, oCaster, FALSE);
            // 2009-9-20: Might as well do this here since we already have the spellbook array. -N-S
            persistant_array_set_int(oCaster, "NewSpellbookMem_" + IntToString(nCastingClass), nSpellbookID, nCount - 1);
        }
        else if(nSpellbookType == SPELLBOOK_TYPE_SPONTANEOUS)
        {
            if(DEBUG) DoDebug("NSB_SpellLevel = "+IntToString(nSpellLevel));
            int nCount = persistant_array_get_int(oCaster, "NewSpellbookMem_" + IntToString(nCastingClass), nSpellLevel);
            //Anti-cheat?
            if (nCount < 1)
            {
                return FALSE;
            }

            // "You have " + IntToString(nCount - 1) + " castings of spells of level " + IntToString(nSpellLevel) + " remaining"
            string sMessage   = ReplaceChars(GetStringByStrRef(16828408), "<count>",      IntToString(nCount - 1));
                   sMessage   = ReplaceChars(sMessage,                    "<spelllevel>", IntToString(nSpellLevel));

            FloatingTextStringOnCreature(sMessage, oCaster, FALSE);
            // 2009-9-20: Might as well do this here since we already have the array data. -N-S
            persistant_array_set_int(oCaster, "NewSpellbookMem_" + IntToString(nCastingClass), nSpellLevel, nCount - 1);
        }

        // Arcane classes roll ASF if the spell has a somatic component
        if(bArcane && FindSubString(GetStringLowerCase(Get2DACache("spells", "VS", nSpellID)), "s") != -1)
        {
            int nASF = GetArcaneSpellFailure(oCaster);
            int bBattleCaster = GetHasFeat(FEAT_BATTLE_CASTER, oCaster);
            object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oCaster);
            int nAC = GetBaseAC(oArmor);
            object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCaster);
            int nShield = GetBaseItemType(oShield);

            //Classes with reduced ASF
            // Beguiler/Dread Necromancer/Hexblade/Sublime Chord can cast in light armor.
            if(nCastingClass == CLASS_TYPE_BEGUILER || nCastingClass == CLASS_TYPE_DREAD_NECROMANCER
            || nCastingClass == CLASS_TYPE_HEXBLADE || nCastingClass == CLASS_TYPE_SUBLIME_CHORD)
            {
                //armors
                switch(nAC)
                {
                    case 1: nASF -=  5; break;//light
                    case 2: nASF -= 10; break;//light
                    case 3: nASF -= 20; break;//light
                    case 4: nASF -= bBattleCaster ? 20 : 0; break;//medium;
                    case 5: nASF -= bBattleCaster ? 30 : 0; break;//medium
                    default: break;
                }
            }
            // Duskblade can cast in light/medium armour and while using small/large shield.
            else if(nCastingClass == CLASS_TYPE_DUSKBLADE)
            {
                //armors
                switch(nAC)
                {
                    case 1: nASF -=  5; break;
                    case 2: nASF -= 10; break;
                    case 3: nASF -= 20; break;
                    case 4: nASF -= (nClassLvl >= 4 || bBattleCaster) ? 20 : 0; break;
                    case 5: nASF -= (nClassLvl >= 4 || bBattleCaster) ? 30 : 0; break;
                    case 6: nASF -= (nClassLvl >= 4 && bBattleCaster) ? 40 : 0; break;
                    case 7: nASF -= (nClassLvl >= 4 && bBattleCaster) ? 40 : 0; break;
                    case 8: nASF -= (nClassLvl >= 4 && bBattleCaster) ? 45 : 0; break;
                    default: break;
                }
                //shields
                switch(nShield)
                {
                    case BASE_ITEM_SMALLSHIELD: nASF -=  5; break;
                    case BASE_ITEM_LARGESHIELD: nASF -= 15; break;
                }
            }
            // Suel Archanamach gets the Ignore Spell Failure Chance feats
            else if(nCastingClass == CLASS_TYPE_SUEL_ARCHANAMACH)
            {
                if(nClassLvl >= 10) nASF -= 20;
                else if(nClassLvl >= 7) nASF -= 15;
                else if(nClassLvl >= 4) nASF -= 10;
                else if(nClassLvl >= 1) nASF -= 5;
            }
            // Warmage can cast in light/medium armour and while using small shield.
            else if(nCastingClass == CLASS_TYPE_WARMAGE)
            {
                //armors
                switch(nAC)
                {
                    case 1: nASF -= 5; break;
                    case 2: nASF -= 10; break;
                    case 3: nASF -= 20; break;
                    case 4: nASF -= (nClassLvl >= 8 || bBattleCaster) ? 20 : 0; break;
                    case 5: nASF -= (nClassLvl >= 8 || bBattleCaster) ? 30 : 0; break;
                    case 6: nASF -= (nClassLvl >= 8 && bBattleCaster) ? 40 : 0; break;
                    case 7: nASF -= (nClassLvl >= 8 && bBattleCaster) ? 40 : 0; break;
                    case 8: nASF -= (nClassLvl >= 8 && bBattleCaster) ? 45 : 0; break;
                    default: break;
                }
                //shields
                if(nShield == BASE_ITEM_SMALLSHIELD)
                    nASF -= 5;
            }

            if(Random(100) < nASF)
            {
                int nFail = TRUE;
                // Still spell helps
                if(    nMetamagic == METAMAGIC_STILL
                    || (GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_1, oCaster) && nSpellLevel <= 3)
                    || (GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_2, oCaster) && nSpellLevel <= 6)
                    || (GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_3, oCaster) && nSpellLevel <= 9))
                {
                    nFail = FALSE;
                }
                if(nFail)
                {
                    //52946 = Spell failed due to arcane spell failure!
                    FloatingTextStrRefOnCreature(52946, oCaster, FALSE);
                    return FALSE;
                }
            }
        }

        // If the spell has a vocal component, silence and deafness can cause failure
        if(    FindSubString(GetStringLowerCase(Get2DACache("spells", "VS", nSpellID)),"v") != -1
            && (PRCGetHasEffect(EFFECT_TYPE_SILENCE, oCaster) || (PRCGetHasEffect(EFFECT_TYPE_DEAF, oCaster) && Random(100) < 20)))
        {
            int nFail = TRUE;
            //auto-silent exceptions
            if(    nMetamagic == METAMAGIC_SILENT
                || (GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_1, oCaster) && nSpellLevel <= 3)
                || (GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_2, oCaster) && nSpellLevel <= 6)
                || (GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_3, oCaster) && nSpellLevel <= 9))
            {
                nFail = FALSE;
            }
            if(nFail)
            {
                //3734 = Spell failed!
                FloatingTextStrRefOnCreature(3734, oCaster, FALSE);
                return FALSE;
            }
        }

        return TRUE;
    }
    return TRUE;
}

int MaterialComponents()
{
  // Always need to return something
  int nReturn = TRUE;
  int nSwitch = GetPRCSwitch(PRC_MATERIAL_COMPONENTS);
  // 0 is off
  if(nSwitch == 0 || GetHasFeat(FEAT_IGNORE_MATERIALS, oCaster) || nCastingClass == CLASS_TYPE_RUNESCARRED)
  {
    return nReturn;
  }
  else
  {
    // Does not affect NPCs, DMs, SLAs or spells cast from items
    if (nSwitch > 0 && GetIsPC(oCaster) && oOrigItem == OBJECT_INVALID && !GetIsDM(oCaster) && !GetIsDMPossessed(oCaster) && !GetLocalInt(oCaster, "SpellIsSLA"))
    {
      // Set the return value to false
      nReturn = FALSE;

      // Set test variables
      int nComponents = TRUE;
      int nCost = TRUE;

      string sSpell  = GetStringByStrRef(StringToInt(Get2DACache("spells", "Name", nSpell)));

      // Components and Names
      string sComp1 = "";
      string sCompName1 = "";
      string sComp2 = "";
      string sCompName2 = "";
      string sComp3 = "";
      string sCompName3 = "";
      string sComp4 = "";
      string sCompName4 = "";

      // These are set to false if the spell has a component
      int nHasComp1 = TRUE;
      int nHasComp2 = TRUE;
      int nHasComp3 = TRUE;
      int nHasComp4 = TRUE;

      // Component Objects to destroy
      object oComp1;
      object oComp2;
      object oComp3;
      object oComp4;

      //check if caster has spell component pouch
      object oPouch = GetItemPossessedBy(oCaster,"prc_spellpouch");

      // Look for the spell Id
      int i = 0;
      int nGold = 0;
      int nBreak = FALSE;

      while(!nBreak && Get2DACache("materialcomp", "SpellId", i) != "") //until we hit a nonexistant line, or get told to stop
      {
          if(StringToInt(Get2DACache("materialcomp", "SpellId", i)) == nSpell) // If we find the right spell, read out the values.
          {
            // If the line isn't blank, record the uti
            string sTemp = Get2DACache("materialcomp", "Component1", i);
            if (sTemp != "")
            {
              sComp1 = sTemp;
              nHasComp1 = FALSE;
              sCompName1 = Get2DACache("materialcomp", "CompName1", i);
            }
            sTemp = Get2DACache("materialcomp", "Component2", i);
            if (sTemp != "")
            {
              sComp2 = sTemp;
              nHasComp2 = FALSE;
              sCompName2 = Get2DACache("materialcomp", "CompName2", i);
            }
            sTemp = Get2DACache("materialcomp", "Component3", i);
            if (sTemp != "")
            {
              sComp3 = sTemp;
              nHasComp3 = FALSE;
              sCompName3 = Get2DACache("materialcomp", "CompName3", i);
            }
            sTemp = Get2DACache("materialcomp", "Component4", i);
            if (sTemp != "")
            {
              sComp4 = sTemp;
              nHasComp4 = FALSE;
              sCompName4 = Get2DACache("materialcomp", "CompName4", i);
            }
            sTemp = Get2DACache("materialcomp", "Cost", i);
            if (sTemp != "")
            {
              nGold = StringToInt(sTemp);
            }
            // Found the spell, run away
            nBreak = TRUE;
          }
          i++; //go to next line
      }//loop end

        if (nSwitch == 1 || nSwitch == 3)
        {
          nComponents = FALSE;

          if(nGold < 1 && (GetHasFeat(FEAT_ESCHEW_MATERIALS, oCaster) || GetIsObjectValid(oPouch)))
          {
              nComponents = TRUE;
          }
          else
          {
              // Look for items in players inventory
              oComp1 = GetItemPossessedBy(oCaster, sComp1);
              if(GetIsObjectValid(oComp1))
                  nHasComp1 = TRUE;
              else if(sComp1 != "")
                  FloatingTextStringOnCreature("Material component missing: " + sCompName1, oCaster, FALSE);

              oComp2 = GetItemPossessedBy(oCaster, sComp2);
              if(GetIsObjectValid(oComp2))
                  nHasComp2 = TRUE;
              else if(sComp2 != "")
                  FloatingTextStringOnCreature("Material component missing: " + sCompName2, oCaster, FALSE);

              oComp3 = GetItemPossessedBy(oCaster, sComp3);
              if(GetIsObjectValid(oComp3))
                  nHasComp3 = TRUE;
              else if(sComp3 != "")
                  FloatingTextStringOnCreature("Material component missing: " + sCompName3, oCaster, FALSE);

              oComp4 = GetItemPossessedBy(oCaster, sComp4);
              if(GetIsObjectValid(oComp4))
                  nHasComp4 = TRUE;
              else if(sComp4 != "")
                  FloatingTextStringOnCreature("Material component missing: " + sCompName4, oCaster, FALSE);
          }

          if (nHasComp1 && nHasComp2 && nHasComp3 && nHasComp4)
              nComponents = TRUE;
          else
              FloatingTextStringOnCreature("You do not have the appropriate material components to cast " + sSpell, oCaster, FALSE);
        }
        if (nSwitch == 2 || nSwitch == 3)
        {
          nCost = FALSE;

          int nHasGold = GetGold(oCaster);

          // Now check to see if they have enough gold
          if (nHasGold >= nGold)
              nCost = TRUE;
          else
              FloatingTextStringOnCreature("You do not have enough gold to cast " + sSpell, oCaster, FALSE);
        }

     // Checked for the spell components, now the final test.
     if(nComponents && nCost)
     {
         // We've got all the components
         nReturn = TRUE;

         if (nSwitch == 1 || nSwitch == 3)
         {
            int nStack = 0;

            // Component 1
            nStack = GetNumStackedItems(oComp1);

            if (nStack > 1)
              DelayCommand(0.6, SetItemStackSize (oComp1, --nStack));
            else
              DelayCommand(0.6, DestroyObject(oComp1));

            // Component 2
            nStack = GetNumStackedItems(oComp2);

            if (nStack > 1)
              DelayCommand(0.6, SetItemStackSize (oComp2, --nStack));
            else
              DelayCommand(0.6, DestroyObject(oComp2));

            // Component 3
            nStack = GetNumStackedItems(oComp3);

            if (nStack > 1)
              DelayCommand(0.6, SetItemStackSize (oComp3, --nStack));
            else
              DelayCommand(0.6, DestroyObject(oComp3));

            // Component 4
            nStack = GetNumStackedItems(oComp4);

            if (nStack > 1)
              DelayCommand(0.6, SetItemStackSize (oComp4, --nStack));
            else
              DelayCommand(0.6, DestroyObject(oComp4));
         }
         if (nSwitch == 2 || nSwitch == 3)
         {
            TakeGoldFromCreature(nGold, oCaster, TRUE);
         }
     }
    }
  }
  // return our value
  return nReturn;
}

int RedWizRestrictedSchool()
{
    int iRedWizard = GetLevelByClass(CLASS_TYPE_RED_WIZARD, oCaster);

    // No need for wasting CPU on non-Red Wizards
    if(iRedWizard > 0)
    {
        int iRWRes1;
        int iRWRes2;

        // Potion drinking is not restricted
        if(oOrigItem != OBJECT_INVALID &&
           (GetBaseItemType(oOrigItem) == BASE_ITEM_ENCHANTED_POTION ||
            GetBaseItemType(oOrigItem) == BASE_ITEM_POTIONS
           ))
            return TRUE;

        // Determine forbidden schools
        if      (GetHasFeat(FEAT_RW_RES_ABJ, oCaster)) iRWRes1 = SPELL_SCHOOL_ABJURATION;
        else if (GetHasFeat(FEAT_RW_RES_CON, oCaster)) iRWRes1 = SPELL_SCHOOL_CONJURATION;
        else if (GetHasFeat(FEAT_RW_RES_DIV, oCaster)) iRWRes1 = SPELL_SCHOOL_DIVINATION;
        else if (GetHasFeat(FEAT_RW_RES_ENC, oCaster)) iRWRes1 = SPELL_SCHOOL_ENCHANTMENT;
        else if (GetHasFeat(FEAT_RW_RES_EVO, oCaster)) iRWRes1 = SPELL_SCHOOL_EVOCATION;
        else if (GetHasFeat(FEAT_RW_RES_ILL, oCaster)) iRWRes1 = SPELL_SCHOOL_ILLUSION;
        else if (GetHasFeat(FEAT_RW_RES_NEC, oCaster)) iRWRes1 = SPELL_SCHOOL_NECROMANCY;
        else if (GetHasFeat(FEAT_RW_RES_TRS, oCaster)) iRWRes1 = SPELL_SCHOOL_TRANSMUTATION;

        if      (GetHasFeat(FEAT_RW_RES_TRS, oCaster)) iRWRes2 = SPELL_SCHOOL_TRANSMUTATION;
        else if (GetHasFeat(FEAT_RW_RES_NEC, oCaster)) iRWRes2 = SPELL_SCHOOL_NECROMANCY;
        else if (GetHasFeat(FEAT_RW_RES_ILL, oCaster)) iRWRes2 = SPELL_SCHOOL_ILLUSION;
        else if (GetHasFeat(FEAT_RW_RES_EVO, oCaster)) iRWRes2 = SPELL_SCHOOL_EVOCATION;
        else if (GetHasFeat(FEAT_RW_RES_ENC, oCaster)) iRWRes2 = SPELL_SCHOOL_ENCHANTMENT;
        else if (GetHasFeat(FEAT_RW_RES_DIV, oCaster)) iRWRes2 = SPELL_SCHOOL_DIVINATION;
        else if (GetHasFeat(FEAT_RW_RES_CON, oCaster)) iRWRes2 = SPELL_SCHOOL_CONJURATION;
        else if (GetHasFeat(FEAT_RW_RES_ABJ, oCaster)) iRWRes2 = SPELL_SCHOOL_ABJURATION;

        // Compare the spell's school versus the restricted schools
        if(nSchool == iRWRes1 || nSchool == iRWRes2)
        {
            FloatingTextStrRefOnCreature(16822359, oCaster, FALSE); // "You cannot cast spells of your prohibited schools. Spell terminated."
            return FALSE;
        }
        // Other arcane casters cannot benefit from red wizard bonuses
        if(bArcane && nCastingClass != CLASS_TYPE_WIZARD)
        {
            FloatingTextStringOnCreature("You have attempted to illegaly merge another arcane caster with a Red Wizard. All spellcasting will now fail.", oCaster, FALSE);
            return FALSE;
        }
    }

    return TRUE;
}

int EShamConc()
{
    int bInShambler    = GetLocalInt(oCaster, "PRC_IsInEctoplasmicShambler");
    int bJarringSong   = GetHasSpellEffect(SPELL_VIRTUOSO_JARRING_SONG, oCaster);
    int bReturn        = TRUE;
    if(bInShambler || bJarringSong)
    {
        bReturn = GetIsSkillSuccessful(oCaster, SKILL_CONCENTRATION, (15 + nSpellLevel));
        if(!bReturn)
        {
            if(bInShambler)
                FloatingTextStrRefOnCreature(16824061, oCaster, FALSE); // "Ectoplasmic Shambler has disrupted your concentration."
            else if(bJarringSong)
                FloatingTextStringOnCreature("Jarring Song has disrupted your concentration.", oCaster, FALSE);
        }
    }

    return bReturn;
}

int NullPsionicsField()
{
    int nCaster = GetLocalInt(oCaster, "NullPsionicsField");
    int nTarget = GetLocalInt(oSpellTarget, "NullPsionicsField");
    int nTest = TRUE;

    // If either of them have it, the spell fizzles.
    if (nCaster || nTarget)
    {
         nTest = FALSE;
    }
    return nTest;
}

int WardOfPeace()
{
    int nReturn = TRUE;
    if (GetLocalInt(oCaster, "TrueWardOfPeace") && bHarmful)
    {
        nReturn = FALSE;
    }

    return nReturn;
}

int DuskbladeArcaneChanneling()
{
    int nReturn = TRUE;
    if(GetLocalInt(oCaster, "DuskbladeChannelActive"))
    {
        // Don't channel from objects
        if(oOrigItem != OBJECT_INVALID)
            return TRUE;

        //dont cast
        nReturn = FALSE;
        int nClass = GetLevelByClass(CLASS_TYPE_DUSKBLADE, oCaster);
        effect eNone;
        //channeling active
        //find the item
        object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCaster);
        if(!GetIsObjectValid(oItem)) oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oCaster);
        if(!GetIsObjectValid(oItem)) oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oCaster);
        if(!GetIsObjectValid(oItem)) oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oCaster);
        if(GetIsObjectValid(oItem)
            && (Get2DACache("spells", "Range", nSpellID) == "T")
            && IPGetIsMeleeWeapon(oItem)
            && GetIsEnemy(oSpellTarget)
            && !GetLocalInt(oItem, "X2_L_NUMTRIGGERS"))
        {
            //valid spell, store
            //this uses similar things to the spellsequencer/spellsword/arcanearcher stuff
            effect eVisual = EffectVisualEffect(VFX_IMP_BREACH);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, OBJECT_SELF);
            FloatingTextStringOnCreature("Duskblade Channel spell stored", OBJECT_SELF);
            //NOTE: I add +1 to the SpellId to spell 0 can be used to trap failure
            int nSID = nSpellID+1;
            int i;
            int nMax = 1;
            int nVal = 1;
            float fDelay = 60.0;
            if(nClass >= 13)
            {
                nMax = 5;
                nVal = 2;
            }
            for(i=1; i<=nMax; i++)
            {
                SetLocalInt(oItem, "X2_L_SPELLTRIGGER" + IntToString(i)  , nSID);
                SetLocalInt(oItem, "X2_L_SPELLTRIGGER_L" + IntToString(i), nClassLvl);
                SetLocalInt(oItem, "X2_L_SPELLTRIGGER_M" + IntToString(i), nMetamagic);
                SetLocalInt(oItem, "X2_L_SPELLTRIGGER_D" + IntToString(i), nDC);
            }
            SetLocalInt(oItem, "X2_L_NUMTRIGGERS", nMax);

            itemproperty ipTest = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER, 1);
            IPSafeAddItemProperty(oItem ,ipTest, fDelay);

            for (i = 1; i <= nMax; i++)
            {
                DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_SPELLTRIGGER" + IntToString(i)));
                DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_SPELLTRIGGER_L" + IntToString(i)));
                DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_SPELLTRIGGER_M" + IntToString(i)));
                DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_SPELLTRIGGER_D" + IntToString(i)));
            }
            DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_NUMTRIGGERS"));
            //mark it as discharging
            SetLocalInt(oItem, "DuskbladeChannelDischarge", nVal);
            DelayCommand(fDelay, DeleteLocalInt(oItem, "DuskbladeChannelDischarge"));
            //make attack
            ClearAllActions();
            if (nClass >= 13) PerformAttackRound(oSpellTarget, oCaster, eNone, 0.0, 0, 0, 0, FALSE, "Arcane Channelling Hit", "Arcane Channelling Miss");
            else if (nClass >= 13) PerformAttack(oSpellTarget, oCaster, eNone, 0.0, 0, 0, 0, "Arcane Channelling Hit", "Arcane Channelling Miss");
            FloatingTextStringOnCreature("Duskblade Channeling Deactivated", oCaster, FALSE);
            DeleteLocalInt(oCaster, "DuskbladeChannelActive");
        }
    }
    return nReturn;
}

void DraconicFeatsOnSpell()
{
    //ensure the spell is arcane
    if(!bArcane)
        return;

    ///////Draconic Vigor////
    if(GetHasFeat(FEAT_DRACONIC_VIGOR, oCaster))
    {
            effect eHeal = EffectHeal(nSpellLevel);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCaster);
    }

    ///////Draconic Armor////
    if(GetHasFeat(FEAT_DRACONIC_ARMOR, oCaster))
    {
            effect eDamRed = EffectDamageReduction(nSpellLevel, DAMAGE_POWER_PLUS_ONE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamRed, oCaster, 6.0f);
    }

    ///////Draconic Persuasion////
    if(GetHasFeat(FEAT_DRACONIC_PERSUADE, oCaster))
    {
           int nBonus = FloatToInt(1.5f * IntToFloat(nSpellLevel));
            effect eCha = EffectSkillIncrease(SKILL_BLUFF, nBonus);
            effect eCha2 = EffectSkillIncrease(SKILL_PERFORM, nBonus);
            effect eCha3 = EffectSkillIncrease(SKILL_INTIMIDATE, nBonus);
            effect eLink = EffectLinkEffects(eCha, eCha2);
            eLink = EffectLinkEffects(eLink, eCha3);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCaster, 6.0f);
    }

    ///////Draconic Presence////
    if(GetHasFeat(FEAT_DRACONIC_PRESENCE, oCaster))
    {
       //set up checks
        object oScare;
        int bCreaturesLeft = TRUE;
        int nNextCreature = 1;

        //set up fear effects
        effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
        effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
        effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

        effect eShaken = EffectShaken();

        effect eLink = EffectLinkEffects(eDur, eDur2);
               eLink = EffectLinkEffects(eLink, eShaken);

        int nHD = GetHitDice(oCaster);
        int nSaveDC = 10 + nSpellLevel + GetAbilityModifier(ABILITY_CHARISMA, oCaster);
        int nDuration = 6 * nSpellLevel;

        //cycle through creatures within the AoE
        while(bCreaturesLeft == TRUE)
        {
            oScare = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oCaster, nNextCreature,
                CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
            if(oScare == OBJECT_INVALID) bCreaturesLeft = FALSE;
            if (oScare != oCaster && GetDistanceToObject(oScare) < FeetToMeters(15.0))
            {
               //dragons are immune, so make sure it's not a dragon
               if(MyPRCGetRacialType(oScare)!= RACIAL_TYPE_DRAGON)
               {
                   //Fire cast spell at event for the specified target
                    SignalEvent(oScare, EventSpellCastAt(oCaster, SPELLABILITY_AURA_FEAR));
                    //Make a saving throw check
                    if(!PRCMySavingThrow(SAVING_THROW_WILL, oScare, nSaveDC, SAVING_THROW_TYPE_FEAR) && !GetIsImmune(oScare, IMMUNITY_TYPE_FEAR) && !GetIsImmune(oScare, IMMUNITY_TYPE_MIND_SPELLS))
                    {
                        //Apply the VFX impact and effects
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oScare, RoundsToSeconds(nDuration));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oScare);
                    }//end will save processing
                } //end dragon check
                nNextCreature++;
            }//end target check
            //if no more creatures within range, end it
            else
                bCreaturesLeft = FALSE;
        }//end while
    }

    ///////Draconic Claw////
    if(GetHasFeat(FEAT_DRACONIC_CLAW, oCaster))
    {
        //get the proper sized claw
        string sResRef = "prc_claw_1d6m_";
        sResRef += GetAffixForSize(PRCGetCreatureSize(oCaster));
        object oClaw = GetObjectByTag(sResRef);

        // Clawswipes only work on powers manifested by the Diamond Dragon, not by items he uses.
        if (oOrigItem != OBJECT_INVALID)
        {
            FloatingTextStringOnCreature("You do not gain clawswipes from Items.", OBJECT_SELF, FALSE);
            return;
        }

        effect eInvalid;

        if(TakeSwiftAction(oCaster))
        {
            //grab the closest enemy to swipe at
            oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, oCaster, 1,
                CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
            if (oTarget != oCaster && GetDistanceToObject(oTarget) < FeetToMeters(15.0))
            {
               PerformAttack(oTarget, oCaster, eInvalid, 0.0, 0, 0, DAMAGE_TYPE_SLASHING, "*Clawswipe Hit*", "*Clawswipe Missed*", FALSE, oClaw);
           }
       }
    }
}

void DazzlingIllusion()
{
    int nFeat = GetHasFeat(FEAT_DAZZLING_ILLUSION, oCaster);

    // No need for wasting CPU on non-Dazzles
    if(nFeat > 0)
    {
        if (nSchool == SPELL_SCHOOL_ILLUSION)
        {
                effect eLink = EffectLinkEffects(EffectAttackDecrease(1), EffectSkillDecrease(SKILL_SEARCH, 1));
                       eLink = EffectLinkEffects(eLink, EffectSkillDecrease(SKILL_SPOT, 1));
                       eLink = EffectLinkEffects(eLink, EffectVisualEffect(VFX_IMP_PWBLIND));
                object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, FeetToMeters(30.0), GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);
                //Cycle through the targets within the spell shape until an invalid object is captured.
                while (GetIsObjectValid(oTarget))
                {
                        if (!GetIsFriend(oTarget, oCaster) && !PRCGetHasEffect(EFFECT_TYPE_BLINDNESS, oTarget))
                        {
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 6.0);
                        }
                        //Select the next target within the spell shape.
                        oTarget = MyNextObjectInShape(SHAPE_SPHERE, FeetToMeters(30.0), GetLocation(oCaster), TRUE, OBJECT_TYPE_CREATURE);
                }
        }
    }
}

void EnergyAbjuration()
{
    int nFeat = GetHasFeat(FEAT_ENERGY_ABJURATION, oCaster);

    // No need for wasting CPU on non-Abjures
    if(nFeat > 0)
    {
        if (nSchool == SPELL_SCHOOL_ABJURATION)
        {
                int nAmount = (1 + nSpellLevel) * 5;

                effect eCold = EffectDamageResistance(DAMAGE_TYPE_COLD, nAmount, nAmount);
                effect eFire = EffectDamageResistance(DAMAGE_TYPE_FIRE, nAmount, nAmount);
                effect eAcid = EffectDamageResistance(DAMAGE_TYPE_ACID, nAmount, nAmount);
                effect eSonic = EffectDamageResistance(DAMAGE_TYPE_SONIC, nAmount, nAmount);
                effect eElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, nAmount, nAmount);
                effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);
                effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
                effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

                //Link Effects
                effect eLink = EffectLinkEffects(eCold, eFire);
                eLink = EffectLinkEffects(eLink, eAcid);
                eLink = EffectLinkEffects(eLink, eSonic);
                eLink = EffectLinkEffects(eLink, eElec);
                eLink = EffectLinkEffects(eLink, eDur);
                eLink = EffectLinkEffects(eLink, eDur2);

                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oCaster);
        }
    }
}

void InsightfulDivination()
{
    int nFeat = GetHasFeat(FEAT_INSIGHTFUL_DIVINATION, oCaster);

    // No need for wasting CPU on non-Abjures
    if(nFeat > 0)
    {
        if (nSchool == SPELL_SCHOOL_DIVINATION)
        {
                int nAmount = 1 + nSpellLevel;

                SetLocalInt(oCaster, "InsightfulDivination", nAmount);
        }
    }
}

void TougheningTransmutation()
{
    int nFeat = GetHasFeat(FEAT_TOUGHENING_TRANSMUTATION, oCaster);

    // No need for wasting CPU on non-Abjures
    if(nFeat > 0)
    {
        if (nSchool == SPELL_SCHOOL_TRANSMUTATION)
        {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageReduction(5, DAMAGE_POWER_PLUS_ONE), oCaster, 6.0);
        }
    }
}

void CloudyConjuration()
{
    int nFeat = GetHasFeat(FEAT_CLOUDY_CONJURATION, oCaster);

    // No need for wasting CPU on non-Abjures
    if(nFeat > 0)
    {
        if (nSchool == SPELL_SCHOOL_CONJURATION)
        {
                ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectAreaOfEffect(VFX_MOB_CLOUDY_CONJURATION), PRCGetSpellTargetLocation(), 6.0);
        }
    }
}

int BardSorcPrCCheck()
{
    //no need to check further if new spellbooks are disabled
    if(GetPRCSwitch(PRC_SORC_DISALLOW_NEWSPELLBOOK))
        return TRUE;
    //check its a sorc spell
    if(nCastingClass == CLASS_TYPE_SORCERER)
    {
        //check they have sorc levels
        if(!nClassLvl)
            return TRUE;
        //check if they are casting via new spellbook
        if(GetLocalInt(oCaster, "NSB_Class") == CLASS_TYPE_SORCERER)
            return TRUE;
        //check they have arcane PrC or Draconic Arcane Grace/Breath
        if(!(GetArcanePRCLevels(oCaster) - GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD))
          && !(GetHasFeat(FEAT_DRACONIC_GRACE, oCaster) || GetHasFeat(FEAT_DRACONIC_BREATH, oCaster)))
            return TRUE;
        //check they have sorc in first arcane slot
        //if(GetPrimaryArcaneClass() != CLASS_TYPE_SORCERER)
        if(GetPrCAdjustedCasterLevelByType(TYPE_ARCANE, oCaster, TRUE) != GetPrCAdjustedCasterLevel(CLASS_TYPE_SORCERER, oCaster, TRUE))
            return TRUE;

        //at this point, they must be using the bioware spellbook
        //from a class that adds to sorc
        FloatingTextStringOnCreature("You must use the new spellbook on the class radial.", oCaster, FALSE);
        return FALSE;
    }

    //check its a bard spell
    if(nCastingClass == CLASS_TYPE_BARD)
    {
        //check they have bard levels
        if(!nClassLvl)
            return TRUE;
        //check if they are casting via new spellbook
        if(GetLocalInt(oCaster, "NSB_Class") == CLASS_TYPE_BARD)
            return TRUE;
        //check they have arcane PrC or Draconic Arcane Grace/Breath
        if(!(GetArcanePRCLevels(oCaster) - GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD))
          && !(GetHasFeat(FEAT_DRACONIC_GRACE, oCaster) || GetHasFeat(FEAT_DRACONIC_BREATH, oCaster)))
            return TRUE;
        //check they have bard in first arcane slot
        //if(GetPrimaryArcaneClass() != CLASS_TYPE_BARD)
        if(GetPrCAdjustedCasterLevelByType(TYPE_ARCANE, oCaster, TRUE) != GetPrCAdjustedCasterLevel(CLASS_TYPE_BARD, oCaster, TRUE))
            return TRUE;

        //at this point, they must be using the bioware spellbook
        //from a class that adds to bard
        FloatingTextStringOnCreature("You must use the new spellbook on the class radial.", oCaster, FALSE);
        return FALSE;
    }

    return TRUE;
}


int KOTCHeavenDevotion(object oTarget)
{
    int iKOTC = GetLevelByClass(CLASS_TYPE_KNIGHT_CHALICE, oTarget);
    int nTest = TRUE;

    if (iKOTC >= 5)
    {
        if (MyPRCGetRacialType(oCaster) == RACIAL_TYPE_OUTSIDER)
        {
            if (GetAlignmentGoodEvil(oCaster) == ALIGNMENT_EVIL)
            {
                if (nSchool == SPELL_SCHOOL_ENCHANTMENT)
                {
                    nTest = FALSE;
                }
            }
        }
    }
    return nTest;
}

void CombatMedicHealingKicker()
{
    if (!GetIsOfSubschool(nSpellID, SUBSCHOOL_HEALING)) //If the spell that was just cast isn't healing, stop now
        return;

    int nMedicLvl = GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC, oCaster);
    //Three if/elseif statements. They check which of the healing kickers we use.
    //If no Healing Kicker localints are set, this if block should be ignored.
    if (GetLocalInt(OBJECT_SELF, "Heal_Kicker1") && oSpellTarget != oCaster)
    {
        /* Sanctuary effect, with special DC and 1 round duration
         * Script stuff taken from the spell by the same name
         */
        int nDC = 15 + nMedicLvl + GetAbilityModifier(ABILITY_WISDOM, oCaster);

        effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
        effect eSanc = EffectSanctuary(nDC);
        effect eLink = EffectLinkEffects(eVis, eSanc);

        //Apply the Sanctuary VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oSpellTarget, 6.0);

        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_1);
        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_2);
        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_3);
    }
    else if (GetLocalInt(oCaster, "Heal_Kicker2") && oSpellTarget != oCaster)
    {
        /* Reflex save increase, 1 round duration
         */
        effect eSpeed = EffectVisualEffect(VFX_IMP_HASTE);
        effect eRefs = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nMedicLvl);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpeed, oSpellTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRefs, oSpellTarget, 6.0);

        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_1);
        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_2);
        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_3);
    }
    else if (GetLocalInt(oCaster, "Heal_Kicker3") && oSpellTarget != oCaster)
    {
        /* Aid effect, with special HP bonus and 1 minute duration
         * Script stuff taken from the spell by the same name
         */
        int nBonus = 8 + nMedicLvl;

        effect eAttack = EffectAttackIncrease(1);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);
        effect eLink = EffectLinkEffects(eAttack, eSave);

        effect eHP = EffectTemporaryHitpoints(nBonus);

        effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);

        //Apply the Aid VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oSpellTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oSpellTarget, 60.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oSpellTarget, 60.0);

        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_1);
        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_2);
        DecrementRemainingFeatUses(oCaster, FEAT_HEALING_KICKER_3);
    }
}

// Performs the attack portion of the battlecast ability for the havoc mage
void Battlecast()
{
    // If battlecast is turned off, exit
    if(!GetLocalInt(oCaster, "HavocMageBattlecast")) return;
    object oTarget = oSpellTarget;

    // Battlecast only works on spells cast by the Havoc Mage, not by items he uses.
    if (oOrigItem != OBJECT_INVALID)
    {
        FloatingTextStringOnCreature("You do not gain Battlecast from Items.", OBJECT_SELF, FALSE);
        return;
    }

    //if its not being cast on a hostile target or its at a location
    //get the nearest living seen hostile insead
    if(!spellsIsTarget(oSpellTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster)
        || !GetIsObjectValid(oSpellTarget))
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oCaster, 1,
            CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
            CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }
    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    int nLevel = GetLevelByClass(CLASS_TYPE_HAVOC_MAGE, oCaster);

    // Don't want to smack allies upside the head when casting a spell.
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster)
        && oTarget != oCaster
        && GetDistanceToObject(oTarget) < FeetToMeters(15.0))
    {
        // Make sure the levels are right for both the caster and the spells.
        // Level 8 spells and under at level 5
        if (nLevel == 5 && 8 >= nSpellLevel) PerformAttack(oTarget, oCaster, eVis, 0.0, 0, 0, 0, "*Battlecast Hit*", "*Battlecast Missed*");
        // Level 4 spells and under at level 3
        else if (nLevel >= 3 && 4 >= nSpellLevel) PerformAttack(oTarget, oCaster, eVis, 0.0, 0, 0, 0, "*Battlecast Hit*", "*Battlecast Missed*");
        // Level 2 spells and under at level 1
        else if (nLevel >= 1 && 2 >= nSpellLevel) PerformAttack(oTarget, oCaster, eVis, 0.0, 0, 0, 0, "*Battlecast Hit*", "*Battlecast Missed*");
    }
}

//Archmage and Heirophant SLA slection/storage setting
int ClassSLAStore()
{
    int nSLAID = GetLocalInt(OBJECT_SELF, "PRC_SLA_Store");
    if(nSLAID)
    {
        string sSLAID = IntToString(nSLAID);
        FloatingTextStringOnCreature("SLA "+sSLAID+" stored", OBJECT_SELF);
        SetPersistantLocalInt(OBJECT_SELF, "PRC_SLA_SpellID_"+sSLAID, nSpellID+1);
        SetPersistantLocalInt(OBJECT_SELF, "PRC_SLA_Class_"+sSLAID, nCastingClass);
        SetPersistantLocalInt(OBJECT_SELF, "PRC_SLA_Meta_"+sSLAID, nMetamagic);

        int nSLALevel = nSpellLevel;

        if(nMetamagic & METAMAGIC_QUICKEN)  nSLALevel += 4;
        if(nMetamagic & METAMAGIC_STILL)    nSLALevel += 1;
        if(nMetamagic & METAMAGIC_SILENT)   nSLALevel += 1;
        if(nMetamagic & METAMAGIC_MAXIMIZE) nSLALevel += 3;
        if(nMetamagic & METAMAGIC_EMPOWER)  nSLALevel += 2;
        if(nMetamagic & METAMAGIC_EXTEND)   nSLALevel += 1;

        int nUses = 1;
        switch(nSLALevel)
        {
            default:
            case 9:
            case 8: nUses = 1; break;
            case 7:
            case 6: nUses = 2; break;
            case 5:
            case 4: nUses = 3; break;
            case 3:
            case 2: nUses = 4; break;
            case 1:
            case 0: nUses = 5; break;
        }
        SetPersistantLocalInt(OBJECT_SELF, "PRC_SLA_Uses_"+sSLAID, nUses);
        DeleteLocalInt(OBJECT_SELF, "PRC_SLA_Store");
        return FALSE;
    }
    return TRUE;
}

int Scrying()
{
    // Scrying blocks all powers except for a few special case ones.
    int nScry    = GetLocalInt(oCaster, "ScrySpellId");
    // If its an empty local int
    if (nScry == 0) return TRUE;

    if (nScry == SPELL_GREATER_SCRYING)
    {
        if (nSpellID == SPELL_DETECT_EVIL || nSpellID == SPELL_DETECT_GOOD ||
            nSpellID == SPELL_DETECT_LAW || nSpellID == SPELL_DETECT_CHAOS)
                return TRUE;
    }
    if (nScry == POWER_CLAIRTANGENT_HAND)
    {
        if (nSpellID == POWER_FARHAND)
                return TRUE;
    }

    return FALSE;
}

int GrappleConc()
{
        if (GetGrapple(oCaster))
        {
                return GetIsSkillSuccessful(oCaster, SKILL_CONCENTRATION, (20 + nSpellLevel));
        }
        return TRUE;
}
