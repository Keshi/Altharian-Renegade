//::///////////////////////////////////////////////
//:: Spell Hook Include File
//:: x2_inc_spellhook
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    This file acts as a hub for all code that
    is hooked into the nwn spellscripts'

    If you want to implement material components
    into spells or add restrictions to certain
    spells, this is the place to do it.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-06-04
//:: Updated On: 2003-10-25
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified Date: January 15th-16th, 2008
//:://////////////////////////////////////////////
/*
    Modified to insure no shapeshifting spells are castable upon
    mounted targets.  This prevents problems that can occur due
    to dismounting after shape shifting, or other issues that can
    occur due to preserved appearances getting out of synch.

    This can additional check can be disabled by setting the variable
    X3_NO_SHAPESHIFT_SPELL_CHECK to 1 on the module object.  If this
    variable is set then this script will function as it did prior to
    this modification.

*/

const int X2_EVENT_CONCENTRATION_BROKEN = 12400;

// Removes spell use for new spellbook system, and calculates spell fail
// chance from ASF or silence effects.
int NSB_SpellCast();

// This function checks for material components or gold
// See switch PRC_MATERIAL_COMPONENTS
int MaterialComponents();

// This function checks for the Red Wizard's restricted
// spell school and prevents him from casting the spells
// that he is banned from casting.
int RedWizRestrictedSchool();

// This function checks whether the Combat Medic's Healing Kicker
// feats are active, and if so imbues the spell target with additional
// beneficial effects.
void CombatMedicHealingKicker();

// This prevents casting spells into or out of a Null Psionics Field
int NullPsionicsField();

// Utterance. Prevents the casting of hostile spells by the target
int WardOfPeace();

// Duskblade channeling. While channeling, stops non-touch spells
// from working
int DuskbladeArcaneChanneling();

// Handles the "When spell is cast do this" effects from the Draconic
// series of feats
void DraconicFeatsOnSpell();

// Bard / Sorc PrC handling
// returns FALSE if it is a bard or a sorcerer spell from a character
// with an arcane PrC via bioware spellcasting rather than via PrC spellcasting
int BardSorcPrCCheck();

// Scrying Spells/Powers
// Returns false if Scrying except for a few specialized spells.
int Scrying();

// Grappling
// Rolls a Concentration check to cast a spell while grappling.
int GrappleConc();

// Dazzling Illusion feat
// Dazzles enemies within radius
void DazzlingIllusion();

// Use Magic Device Check.
// Returns TRUE if the Spell is allowed to be cast, either because the
// character is allowed to cast it or he has won the required UMD check
// Only active on spell scroll
int X2UseMagicDeviceCheck();


// check if the spell is prohibited from being cast on items
// returns FALSE if the spell was cast on an item but is prevented
// from being cast there by its corresponding entry in des_crft_spells
// oItem - pass PRCGetSpellTargetObject in here
int X2CastOnItemWasAllowed(object oItem);

// Sequencer Item Property Handling
// Returns TRUE (and charges the sequencer item) if the spell
// ... was cast on an item AND
// ... the item has the sequencer property
// ... the spell was non hostile
// ... the spell was not cast from an item
// in any other case, FALSE is returned an the normal spellscript will be run
// oItem - pass PRCGetSpellTargetObject in here
int X2GetSpellCastOnSequencerItem(object oTargetItem);

int X2RunUserDefinedSpellScript();

// Similar to SetModuleOverrideSpellscript but only applies to the user
// of this spell. Basically tells the class to run this script when the
// spell starts.
void PRCSetUserSpecificSpellScript(string sScript);

// Similar to SetModuleOverrideSpellscriptFinished but only applies to the
// user of this spell. This prevents the spell from continuing on if the
// ability dictates it.
void PRCSetUserSpecificSpellScriptFinished();

// By setting user-defined spellscripts to the player only, we
// avoid the nasty mess of spellhooking the entire module for one player's
// activities.  This function is mostly only useful inside this include.
int PRCRunUserSpecificSpellScript();

// Useful functions for PRCRunUserSpecificSpellScript but not useful in spell
// scripts.
string PRCGetUserSpecificSpellScript();
int PRCGetUserSpecificSpellScriptFinished();

//#include "prc_x2_itemprop" - Inherited from prc_x2_craft
//#include "prc_alterations"
#include "prc_x2_craft"
//#include "x3_inc_horse"
#include "prc_inc_spells"
//#include "prc_inc_combat"
//#include "inc_utility"
#include "prc_inc_itmrstr"
//#include "inc_newspellbook"
//#include "prc_sp_func"
//#include "psi_inc_manifest"
#include "prc_inc_combmove"
#include "pnp_shft_main"
#include "inc_dynconv"

int DruidSpontSummon()
{
    object oPC = OBJECT_SELF;
    int nCastingClass = GetLastSpellCastClass();
    if(nCastingClass != CLASS_TYPE_DRUID)
        return TRUE;

    if(GetLocalInt(oPC, "PRC_SpontSummon"))
    {
        DeleteLocalInt(oPC, "PRC_SpontSummon");
        int nSpellID = GetSpellId();
        int nMetamagic = GetMetaMagicFeat();
        int nSpellLevel = PRCGetSpellLevelForClass(nSpellID, CLASS_TYPE_DRUID);
        nSpellLevel += GetMetaMagicSpellLevelAdjustment(nMetamagic);
        int nSummonSpell;
        switch(nSpellLevel)
        {
            case 0: return TRUE;
            case 1: nSummonSpell = SPELL_SUMMON_CREATURE_I; break;
            case 2: nSummonSpell = SPELL_SUMMON_CREATURE_II; break;
            case 3: nSummonSpell = SPELL_SUMMON_CREATURE_III; break;
            case 4: nSummonSpell = SPELL_SUMMON_CREATURE_IV; break;
            case 5: nSummonSpell = SPELL_SUMMON_CREATURE_V; break;
            case 6: nSummonSpell = SPELL_SUMMON_CREATURE_VI; break;
            case 7: nSummonSpell = SPELL_SUMMON_CREATURE_VII; break;
            case 8: nSummonSpell = SPELL_SUMMON_CREATURE_VIII; break;
            case 9: nSummonSpell = SPELL_SUMMON_CREATURE_IX; break;
        }

        //subradial spells
        if (nSummonSpell == SPELL_SUMMON_CREATURE_VII
         || nSummonSpell == SPELL_SUMMON_CREATURE_VIII
         || nSummonSpell == SPELL_SUMMON_CREATURE_IX)
        {
            SetLocalInt(oPC, "DomainOrigSpell", nSummonSpell);
            SetLocalInt(oPC, "DomainCastLevel", nSpellLevel);
            SetLocalInt(oPC, "DomainCastClass", CLASS_TYPE_DRUID);
            StartDynamicConversation("prc_domain_conv", oPC, DYNCONV_EXIT_NOT_ALLOWED, FALSE, TRUE, oPC);
        }
        else
            ActionCastSpell(nSummonSpell, 0, 0, 0, METAMAGIC_NONE, CLASS_TYPE_DRUID);

        //Don't cast original spell
        return FALSE;
    }

    return TRUE;
}

int NSB_SpellCast()
{
    object oPC = OBJECT_SELF;
    int Domain_Cast = GetLocalInt(oPC, "Domain_Cast");
    int NSB_Class = GetLocalInt(oPC, "NSB_Class");

    //if for some reason NSB variables were not removed and the player is not casting from new spellbook
    //remove the variables now
    if((GetLastSpellCastClass() != CLASS_TYPE_INVALID || GetSpellCastItem() != OBJECT_INVALID) && NSB_Class)
    {
        //clean local vars
        DeleteLocalInt(oPC, "NSB_SpellLevel");
        DeleteLocalInt(oPC, "NSB_Class");
        DeleteLocalInt(oPC, "NSB_SpellbookID");
    }

//DoDebug("PRC last spell cast class = "+IntToString(PRCGetLastSpellCastClass()));
//DoDebug("Primary Arcane Class = "+IntToString(GetPrimaryArcaneClass(oPC)));
//DoDebug("Caster Level = "+IntToString(PRCGetCasterLevel(oPC)));

    /*if(nDomainCast)
    {
        int nBurnSpell = GetLocalInt(oPC, "Domain_BurnableSpell");
        int nLevel = GetLocalInt(oPC, "Domain_Level");

        // Burn the spell off, then cast the domain spell
        // Also, because of the iprop feats not having uses per day
        // set it so they can't cast again from that level
        SetLocalInt(oPC, "DomainCastSpell" + IntToString(nLevel), TRUE);
        if(nBurnSpell != -1)
            DecrementRemainingSpellUses(oPC, nBurnSpell);
        else
            */

    //this shuld be executed only for new spellbook spells
    else if(GetLastSpellCastClass() == CLASS_TYPE_INVALID && GetSpellCastItem() == OBJECT_INVALID && NSB_Class)
    {
        int nClass = PRCGetLastSpellCastClass();
        int nSpellID = PRCGetSpellId();
        int nSpellbookType = GetSpellbookTypeForClass(nClass);
        int nSpellLevel = GetLocalInt(oPC, "NSB_SpellLevel");
        int nMetamagic = PRCGetMetaMagicFeat(oPC, FALSE);

        if(DEBUG) DoDebug("NSB_Class = "+GetStringByStrRef(StringToInt(Get2DACache("classes", "Name", NSB_Class))));

        if(nSpellbookType == SPELLBOOK_TYPE_PREPARED)
        {
            int nSpellbookID = GetLocalInt(oPC, "NSB_SpellbookID");
            if(DEBUG) DoDebug("NSB_SpellbookID = "+IntToString(nSpellbookID));
            int nCount = persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellbookID);
            string sSpellName = GetStringByStrRef(StringToInt(Get2DACache("spells", "Name", nSpellID)));
            //Anti-cheat?
            if (nCount < 1)
            {
                return FALSE;
            }

            // "You have " + IntToString(nCount - 1) + " castings of " + sSpellName + " remaining"
            string sMessage   = ReplaceChars(GetStringByStrRef(16828410), "<count>",     IntToString(nCount - 1));
                   sMessage   = ReplaceChars(sMessage,                    "<spellname>", sSpellName);

            FloatingTextStringOnCreature(sMessage, oPC, FALSE);
            // 2009-9-20: Might as well do this here since we already have the spellbook array. -N-S
            persistant_array_set_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellbookID, nCount - 1);
        }
        else if(nSpellbookType == SPELLBOOK_TYPE_SPONTANEOUS)
        {
            if(DEBUG) DoDebug("NSB_SpellLevel = "+IntToString(nSpellLevel));
            int nCount = persistant_array_get_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellLevel);
            //Anti-cheat?
            if (nCount < 1)
            {
                return FALSE;
            }

            // "You have " + IntToString(nCount - 1) + " castings of spells of level " + IntToString(nSpellLevel) + " remaining"
            string sMessage   = ReplaceChars(GetStringByStrRef(16828408), "<count>",      IntToString(nCount - 1));
                   sMessage   = ReplaceChars(sMessage,                    "<spelllevel>", IntToString(nSpellLevel));

            FloatingTextStringOnCreature(sMessage, oPC, FALSE);
            // 2009-9-20: Might as well do this here since we already have the array data. -N-S
            persistant_array_set_int(oPC, "NewSpellbookMem_" + IntToString(nClass), nSpellLevel, nCount - 1);
        }

        // Arcane classes roll ASF if the spell has a somatic component
        if(GetIsArcaneClass(nClass)
            && FindSubString(GetStringLowerCase(Get2DACache("spells", "VS", nSpellID)), "s") != -1)
        {
            int nASF = GetArcaneSpellFailure(oPC);

            //Classes with reduced ASF
            // Beguiler/Dread Necromancer/Hexblade/Sublime Chord can cast in light armor.
            if(nClass == CLASS_TYPE_BEGUILER || nClass == CLASS_TYPE_DREAD_NECROMANCER
            || nClass == CLASS_TYPE_HEXBLADE || nClass == CLASS_TYPE_SUBLIME_CHORD)
            {
                object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
                int nAC = GetBaseAC(oArmor);
                //armors
                switch(nAC)
                {
                    case 1: nASF -=  5; break;//light
                    case 2: nASF -= 10; break;//light
                    case 3: nASF -= 20; break;//light
                    case 4: nASF -= GetHasFeat(FEAT_BATTLE_CASTER, oPC) ? 20 : 0; break;//medium;
                    case 5: nASF -= GetHasFeat(FEAT_BATTLE_CASTER, oPC) ? 30 : 0; break;//medium
                    default: break;
                }
            }
            // Duskblade can cast in light/medium armour and while using small/large shield.
            else if(nClass == CLASS_TYPE_DUSKBLADE)
            {
                int nLvl = GetLevelByClass(CLASS_TYPE_DUSKBLADE, oPC);
                object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
                object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
                int nShield = GetBaseItemType(oShield);
                int nAC = GetBaseAC(oArmor);
                //armors
                switch(nAC)
                {
                    case 1: nASF -=  5; break;
                    case 2: nASF -= 10; break;
                    case 3: nASF -= 20; break;
                    case 4: nASF -= (nLvl >= 4 || GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 20 : 0; break;
                    case 5: nASF -= (nLvl >= 4 || GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 30 : 0; break;
                    case 6: nASF -= (nLvl >= 4 && GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 40 : 0; break;
                    case 7: nASF -= (nLvl >= 4 && GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 40 : 0; break;
                    case 8: nASF -= (nLvl >= 4 && GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 45 : 0; break;
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
            else if(nClass == CLASS_TYPE_SUEL_ARCHANAMACH)
            {
                int nLvl = GetLevelByClass(CLASS_TYPE_SUEL_ARCHANAMACH, oPC);

                if(nLvl >= 10) nASF -= 20;
                else if(nLvl >= 7) nASF -= 15;
                else if(nLvl >= 4) nASF -= 10;
                else if(nLvl >= 1) nASF -= 5;
            }
            // Warmage can cast in light/medium armour and while using small shield.
            else if(nClass == CLASS_TYPE_WARMAGE)
            {
                int nLvl = GetLevelByClass(CLASS_TYPE_WARMAGE, oPC);
                object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
                object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
                int nAC = GetBaseAC(oArmor);
                //armors
                switch(nAC)
                {
                    case 1: nASF -= 5; break;
                    case 2: nASF -= 10; break;
                    case 3: nASF -= 20; break;
                    case 4: nASF -= (nLvl >= 8 || GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 20 : 0; break;
                    case 5: nASF -= (nLvl >= 8 || GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 30 : 0; break;
                    case 6: nASF -= (nLvl >= 8 && GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 40 : 0; break;
                    case 7: nASF -= (nLvl >= 8 && GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 40 : 0; break;
                    case 8: nASF -= (nLvl >= 8 && GetHasFeat(FEAT_BATTLE_CASTER, oPC)) ? 45 : 0; break;
                    default: break;
                }
                //shields
                if(GetBaseItemType(oShield) == BASE_ITEM_SMALLSHIELD)
                    nASF -= 5;
            }

            if(Random(100) < nASF)
            {
                int nFail = TRUE;
                // Still spell helps
                if(    nMetamagic == METAMAGIC_STILL
                    || (GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_1, oPC) && nSpellLevel <= 3)
                    || (GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_2, oPC) && nSpellLevel <= 6)
                    || (GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_3, oPC) && nSpellLevel <= 9))
                {
                    nFail = FALSE;
                }
                if(nFail)
                {
                    //52946 = Spell failed due to arcane spell failure!
                    FloatingTextStrRefOnCreature(52946, oPC, FALSE);
                    return FALSE;
                }
            }
        }

        // If the spell has a vocal component, silence and deafness can cause failure
        if(    FindSubString(GetStringLowerCase(Get2DACache("spells", "VS", nSpellID)),"v") != -1
            && (PRCGetHasEffect(EFFECT_TYPE_SILENCE, oPC) || (PRCGetHasEffect(EFFECT_TYPE_DEAF, oPC) && Random(100) < 20)))
        {
            int nFail = TRUE;
            //auto-silent exceptions
            if(    nMetamagic == METAMAGIC_SILENT
                || (GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_1, oPC) && nSpellLevel <= 3)
                || (GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_2, oPC) && nSpellLevel <= 6)
                || (GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_3, oPC) && nSpellLevel <= 9))
            {
                nFail = FALSE;
            }
            if(nFail)
            {
                //3734 = Spell failed!
                FloatingTextStrRefOnCreature(3734, oPC, FALSE);
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
  object oCaster = OBJECT_SELF;
  int nSwitch = GetPRCSwitch(PRC_MATERIAL_COMPONENTS);
  int nCastingClass = PRCGetLastSpellCastClass();
  // 0 is off
  if(nSwitch == 0 || GetHasFeat(FEAT_IGNORE_MATERIALS, oCaster) || nCastingClass == CLASS_TYPE_RUNESCARRED)
  {
    return nReturn;
  }
  else
  {
    // Does not affect NPCs, DMs, SLAs or spells cast from items
    if (nSwitch > 0 && GetIsPC(oCaster) && GetSpellCastItem() == OBJECT_INVALID && !GetIsDM(oCaster) && !GetIsDMPossessed(oCaster) && !GetLocalInt(oCaster, "SpellIsSLA"))
    {
      // Set the return value to false
      nReturn = FALSE;

      // Set test variables
      int nComponents = TRUE;
      int nCost = TRUE;


      int nSpell = PRCGetSpellId();
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
    object oCaster = OBJECT_SELF;
    int iRedWizard = GetLevelByClass(CLASS_TYPE_RED_WIZARD, oCaster);

    // No need for wasting CPU on non-Red Wizards
    if(iRedWizard > 0)
    {
        object oItem   = GetSpellCastItem();
        int nSpell     = PRCGetSpellId();
        int iSchool    = GetSpellSchool(nSpell);
        int iRWRes1;
        int iRWRes2;

        // Potion drinking is not restricted
        if(oItem != OBJECT_INVALID &&
           (GetBaseItemType(oItem) == BASE_ITEM_ENCHANTED_POTION ||
            GetBaseItemType(oItem) == BASE_ITEM_POTIONS
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
        if(iSchool == iRWRes1 || iSchool == iRWRes2)
        {
            FloatingTextStrRefOnCreature(16822359, oCaster, FALSE); // "You cannot cast spells of your prohibited schools. Spell terminated."
            return FALSE;
        }
        // Other arcane casters cannot benefit from red wizard bonuses
        int nClassTest = PRCGetLastSpellCastClass();
        if(GetIsArcaneClass(nClassTest) && nClassTest != CLASS_TYPE_WIZARD)
        {
            FloatingTextStringOnCreature("You have attempted to illegaly merge another arcane caster with a Red Wizard. All spellcasting will now fail.", oCaster, FALSE);
            return FALSE;
        }
    }

    return TRUE;
}

int EShamConc()
{
    object oCaster     = OBJECT_SELF;
    int bInShambler    = GetLocalInt(oCaster, "PRC_IsInEctoplasmicShambler");
    int bJarringSong   = GetHasSpellEffect(SPELL_VIRTUOSO_JARRING_SONG, oCaster);
    int bReturn        = TRUE;
    if(bInShambler || bJarringSong)
    {
        string nSpellLevel = lookup_spell_level(PRCGetSpellId());

        bReturn = GetIsSkillSuccessful(oCaster, SKILL_CONCENTRATION, (15 + StringToInt(nSpellLevel)));
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
    int nCaster = GetLocalInt(OBJECT_SELF, "NullPsionicsField");
    int nTarget = GetLocalInt(PRCGetSpellTargetObject(), "NullPsionicsField");
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
    object oCaster = OBJECT_SELF;
    int nReturn = TRUE;
    if (GetLocalInt(oCaster, "TrueWardOfPeace") && GetLastSpellHarmful())
    {
        nReturn = FALSE;
    }

    return nReturn;
}

int DuskbladeArcaneChanneling()
{
    int nReturn = TRUE;
    object oPC = OBJECT_SELF;
    if(GetLocalInt(oPC, "DuskbladeChannelActive"))
    {
        object oItem   = GetSpellCastItem();

        // Don't channel from objects
        if(oItem != OBJECT_INVALID)
            return TRUE;

        //dont cast
        nReturn = FALSE;
        int nSpell = PRCGetSpellId();
        int nClass = GetLevelByClass(CLASS_TYPE_DUSKBLADE, oPC);
        effect eNone;
        //channeling active
        //find the item
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        if(!GetIsObjectValid(oItem)) oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC);
        if(!GetIsObjectValid(oItem)) oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC);
        if(!GetIsObjectValid(oItem)) oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC);
        if(GetIsObjectValid(oItem)
            && (Get2DACache("spells", "Range", nSpell) == "T")
            && IPGetIsMeleeWeapon(oItem)
            && GetIsEnemy(PRCGetSpellTargetObject())
            && !GetLocalInt(oItem, "X2_L_NUMCHANNELTRIGGERS"))
        {
            //valid spell, store
            //this uses similar things to the spellsequencer/spellsword/arcanearcher stuff
            effect eVisual = EffectVisualEffect(VFX_IMP_BREACH);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, OBJECT_SELF);
            FloatingTextStringOnCreature("Duskblade Channel spell stored", OBJECT_SELF);
            //NOTE: I add +1 to the SpellId to spell 0 can be used to trap failure
            int nSID = PRCGetSpellId()+1;
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
                SetLocalInt(oItem, "X2_L_CHANNELTRIGGER" + IntToString(i)  , nSID);
                SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_L" + IntToString(i), PRCGetCasterLevel(OBJECT_SELF));
                SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_M" + IntToString(i), PRCGetMetaMagicFeat());
                SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_D" + IntToString(i), PRCGetSaveDC(PRCGetSpellTargetObject(), OBJECT_SELF));
            }
            SetLocalInt(oItem, "X2_L_NUMCHANNELTRIGGERS", nMax);

            itemproperty ipTest = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER, 1);
            IPSafeAddItemProperty(oItem ,ipTest, fDelay);

            for (i = 1; i <= nMax; i++)
            {
                DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_CHANNELTRIGGER" + IntToString(i)));
                DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_CHANNELTRIGGER_L" + IntToString(i)));
                DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_CHANNELTRIGGER_M" + IntToString(i)));
                DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_CHANNELTRIGGER_D" + IntToString(i)));
            }
            DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_NUMCHANNELTRIGGERS"));
            //mark it as discharging
            SetLocalInt(oItem, "DuskbladeChannelDischarge", nVal);
            DelayCommand(fDelay, DeleteLocalInt(oItem, "DuskbladeChannelDischarge"));
            //make attack
            ClearAllActions();
            if (nClass >= 13) PerformAttackRound(PRCGetSpellTargetObject(), oPC, eNone, 0.0, 0, 0, 0, FALSE, "Arcane Channelling Hit", "Arcane Channelling Miss");
            else if (nClass >= 13) PerformAttack(PRCGetSpellTargetObject(), oPC, eNone, 0.0, 0, 0, 0, "Arcane Channelling Hit", "Arcane Channelling Miss");
            FloatingTextStringOnCreature("Duskblade Channeling Deactivated", oPC, FALSE);
            DeleteLocalInt(oPC, "DuskbladeChannelActive");
        }
    }
    return nReturn;

}

void DraconicFeatsOnSpell()
{
    object oPC = OBJECT_SELF;

    //ensure the spell is arcane
    if(!GetIsArcaneClass(PRCGetLastSpellCastClass(), oPC))
        return;

    int nSpellLevel = PRCGetSpellLevel(oPC, PRCGetSpellId());

    ///////Draconic Vigor////
    if(GetHasFeat(FEAT_DRACONIC_VIGOR, oPC))
    {
            effect eHeal = EffectHeal(nSpellLevel);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);

    }

    ///////Draconic Armor////
    if(GetHasFeat(FEAT_DRACONIC_ARMOR, oPC))
    {
            effect eDamRed = EffectDamageReduction(nSpellLevel, DAMAGE_POWER_PLUS_ONE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamRed, oPC, 6.0f);

    }

    ///////Draconic Persuasion////
    if(GetHasFeat(FEAT_DRACONIC_PERSUADE, oPC))
    {
           int nBonus = FloatToInt(1.5f * IntToFloat(nSpellLevel));
            effect eCha = EffectSkillIncrease(SKILL_BLUFF, nBonus);
            effect eCha2 = EffectSkillIncrease(SKILL_PERFORM, nBonus);
            effect eCha3 = EffectSkillIncrease(SKILL_INTIMIDATE, nBonus);
            effect eLink = EffectLinkEffects(eCha, eCha2);
            eLink = EffectLinkEffects(eLink, eCha3);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 6.0f);

    }

    ///////Draconic Presence////
    if(GetHasFeat(FEAT_DRACONIC_PRESENCE, oPC))
    {
       //set up checks
        object oScare;
        int bCreaturesLeft = TRUE;
        int nNextCreature = 1;

        //set up fear effects
        effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
        effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
        effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

        effect eAttackD = EffectAttackDecrease(2);
        effect eDmgD = EffectDamageDecrease(2,DAMAGE_TYPE_BLUDGEONING|DAMAGE_TYPE_PIERCING|DAMAGE_TYPE_SLASHING);
        effect SaveD = EffectSavingThrowDecrease(SAVING_THROW_ALL,2);

        effect eLink = EffectLinkEffects(eDmgD, eDur2);
               eLink = EffectLinkEffects(eLink, eAttackD);
               eLink = EffectLinkEffects(eLink, SaveD);

        int nHD = GetHitDice(oPC);
        int nDC = 10 + nSpellLevel + GetAbilityModifier(ABILITY_CHARISMA, oPC);
        int nDuration = 6 * nSpellLevel;

        //cycle through creatures within the AoE
        while(bCreaturesLeft == TRUE)
        {

            oScare = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC, nNextCreature,
                CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
            if(oScare == OBJECT_INVALID) bCreaturesLeft = FALSE;
            if (oScare != oPC && GetDistanceToObject(oScare) < FeetToMeters(15.0))
            {
               //dragons are immune, so make sure it's not a dragon
               if(MyPRCGetRacialType(oScare)!= RACIAL_TYPE_DRAGON)
               {
                   //Fire cast spell at event for the specified target
                    SignalEvent(oScare, EventSpellCastAt(oPC, SPELLABILITY_AURA_FEAR));
                    //Make a saving throw check
                    if(!PRCMySavingThrow(SAVING_THROW_WILL, oScare, nDC, SAVING_THROW_TYPE_FEAR) && !GetIsImmune(oScare, IMMUNITY_TYPE_FEAR) && !GetIsImmune(oScare, IMMUNITY_TYPE_MIND_SPELLS))
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
    if(GetHasFeat(FEAT_DRACONIC_CLAW, oPC))
    {
        object oTarget = PRCGetSpellTargetObject();

        // Get the item used to cast the spell
        object oItem = GetSpellCastItem();

        //get the proper sized claw
        string sResRef = "prc_claw_1d6m_";
        sResRef += GetAffixForSize(PRCGetCreatureSize(oPC));
        object oClaw = GetObjectByTag(sResRef);

        // Clawswipes only work on powers manifested by the Diamond Dragon, not by items he uses.
        if (oItem != OBJECT_INVALID)
        {
            FloatingTextStringOnCreature("You do not gain clawswipes from Items.", OBJECT_SELF, FALSE);
            return;
        }

        effect eInvalid;

        if(TakeSwiftAction(oPC))
        {
            //grab the closest enemy to swipe at
            oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, oPC, 1,
                CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
            if (oTarget != oPC && GetDistanceToObject(oTarget) < FeetToMeters(15.0))
            {
               PerformAttack(oTarget, oPC, eInvalid, 0.0, 0, 0, DAMAGE_TYPE_SLASHING, "*Clawswipe Hit*", "*Clawswipe Missed*", FALSE, oClaw);
           }
       }
    }

}

void DazzlingIllusion()
{
    object oCaster = OBJECT_SELF;
    int nFeat = GetHasFeat(FEAT_DAZZLING_ILLUSION, oCaster);

    // No need for wasting CPU on non-Dazzles
    if(nFeat > 0)
    {
        int nSpell     = PRCGetSpellId();
        int iSchool    = GetSpellSchool(nSpell);
        
        if (iSchool == SPELL_SCHOOL_ILLUSION)
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
    object oCaster = OBJECT_SELF;
    int nFeat = GetHasFeat(FEAT_ENERGY_ABJURATION, oCaster);

    // No need for wasting CPU on non-Abjures
    if(nFeat > 0)
    {
        int nSpell     = PRCGetSpellId();
        int iSchool    = GetSpellSchool(nSpell);

        if (iSchool == SPELL_SCHOOL_ABJURATION)
        {     
                int nAmount = (1 + PRCGetSpellLevel(oCaster, nSpell)) * 5;

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
    object oCaster = OBJECT_SELF;
    int nFeat = GetHasFeat(FEAT_INSIGHTFUL_DIVINATION, oCaster);

    // No need for wasting CPU on non-Abjures
    if(nFeat > 0)
    {
        int nSpell     = PRCGetSpellId();
        int iSchool    = GetSpellSchool(nSpell);

        if (iSchool == SPELL_SCHOOL_DIVINATION)
        {
                int nAmount = 1 + PRCGetSpellLevel(oCaster, nSpell);

                SetLocalInt(oCaster, "InsightfulDivination", nAmount);
        }
    }
}

void TougheningTransmutation()
{
    object oCaster = OBJECT_SELF;
    int nFeat = GetHasFeat(FEAT_TOUGHENING_TRANSMUTATION, oCaster);

    // No need for wasting CPU on non-Abjures
    if(nFeat > 0)
    {
        int nSpell     = PRCGetSpellId();
        int iSchool    = GetSpellSchool(nSpell);

        if (iSchool == SPELL_SCHOOL_TRANSMUTATION)
        {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageReduction(5, DAMAGE_POWER_PLUS_ONE), oCaster, 6.0);
        }
    }
}

void CloudyConjuration()
{
    object oCaster = OBJECT_SELF;
    int nFeat = GetHasFeat(FEAT_CLOUDY_CONJURATION, oCaster);

    // No need for wasting CPU on non-Abjures
    if(nFeat > 0)
    {
        int nSpell     = PRCGetSpellId();
        int iSchool    = GetSpellSchool(nSpell);

        if (iSchool == SPELL_SCHOOL_CONJURATION)
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
    if(PRCGetLastSpellCastClass() == CLASS_TYPE_SORCERER)
    {
        //check they have sorc levels
        if(!GetLevelByClass(CLASS_TYPE_SORCERER))
            return TRUE;
        //check if they are casting via new spellbook
        if(GetLocalInt(OBJECT_SELF, "NSB_Class") == CLASS_TYPE_SORCERER)
            return TRUE;
        //check they have arcane PrC or Draconic Arcane Grace/Breath
        if(!(GetArcanePRCLevels(OBJECT_SELF) - GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD))
          && !(GetHasFeat(FEAT_DRACONIC_GRACE, OBJECT_SELF) || GetHasFeat(FEAT_DRACONIC_BREATH, OBJECT_SELF)))
            return TRUE;
        //check they have sorc in first arcane slot
        //if(GetPrimaryArcaneClass() != CLASS_TYPE_SORCERER)
        if(GetPrCAdjustedCasterLevelByType(TYPE_ARCANE, OBJECT_SELF, TRUE) != GetPrCAdjustedCasterLevel(CLASS_TYPE_SORCERER, OBJECT_SELF, TRUE))
            return TRUE;

        //at this point, they must be using the bioware spellbook
        //from a class that adds to sorc
        FloatingTextStringOnCreature("You must use the new spellbook on the class radial.", OBJECT_SELF, FALSE);
        return FALSE;
    }

    //check its a bard spell
    if(PRCGetLastSpellCastClass() == CLASS_TYPE_BARD)
    {
        //check they have bard levels
        if(!GetLevelByClass(CLASS_TYPE_BARD))
            return TRUE;
        //check if they are casting via new spellbook
        if(GetLocalInt(OBJECT_SELF, "NSB_Class") == CLASS_TYPE_BARD)
            return TRUE;
        //check they have arcane PrC or Draconic Arcane Grace/Breath
        if(!(GetArcanePRCLevels(OBJECT_SELF) - GetLevelByClass(CLASS_TYPE_SUBLIME_CHORD))
          && !(GetHasFeat(FEAT_DRACONIC_GRACE, OBJECT_SELF) || GetHasFeat(FEAT_DRACONIC_BREATH, OBJECT_SELF)))
            return TRUE;
        //check they have bard in first arcane slot
        //if(GetPrimaryArcaneClass() != CLASS_TYPE_BARD)
        if(GetPrCAdjustedCasterLevelByType(TYPE_ARCANE, OBJECT_SELF, TRUE) != GetPrCAdjustedCasterLevel(CLASS_TYPE_BARD, OBJECT_SELF, TRUE))
            return TRUE;

        //at this point, they must be using the bioware spellbook
        //from a class that adds to bard
        FloatingTextStringOnCreature("You must use the new spellbook on the class radial.", OBJECT_SELF, FALSE);
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
        if (MyPRCGetRacialType(OBJECT_SELF) == RACIAL_TYPE_OUTSIDER)
        {
            if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL)
            {
                if (GetSpellSchool(GetSpellId()) == SPELL_SCHOOL_ENCHANTMENT)
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
    int nSpellId = PRCGetSpellId();
    if (!GetIsHealingSpell(nSpellId)) //If the spell that was just cast isn't healing, stop now
        return;

    object oTarget = PRCGetSpellTargetObject();

    //Three if/elseif statements. They check which of the healing kickers we use.
    //If no Healing Kicker localints are set, this if block should be ignored.
    if (GetLocalInt(OBJECT_SELF, "Heal_Kicker1") && oTarget != OBJECT_SELF)
    {
        /* Sanctuary effect, with special DC and 1 round duration
         * Script stuff taken from the spell by the same name
         */
        int nDC = 15 + GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC, OBJECT_SELF) + GetAbilityModifier(ABILITY_WISDOM, OBJECT_SELF);

        effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
        effect eSanc = EffectSanctuary(nDC);
        effect eLink = EffectLinkEffects(eVis, eSanc);

        //Apply the Sanctuary VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 6.0);

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_1);
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_2);
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_3);
    }
    else if (GetLocalInt(OBJECT_SELF, "Heal_Kicker2") && oTarget != OBJECT_SELF)
    {
        /* Reflex save increase, 1 round duration
         */
        int nRefs = GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC, OBJECT_SELF);

        effect eSpeed = EffectVisualEffect(VFX_IMP_HASTE);
        effect eRefs = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nRefs);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpeed, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRefs, oTarget, 6.0);

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_1);
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_2);
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_3);
    }
    else if (GetLocalInt(OBJECT_SELF, "Heal_Kicker3") && oTarget != OBJECT_SELF)
    {
        /* Aid effect, with special HP bonus and 1 minute duration
         * Script stuff taken from the spell by the same name
         */
        int nBonus = 8 + GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC, OBJECT_SELF);

        effect eAttack = EffectAttackIncrease(1);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);
        effect eLink = EffectLinkEffects(eAttack, eSave);

        effect eHP = EffectTemporaryHitpoints(nBonus);

        effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);

        //Apply the Aid VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 60.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, 60.0);

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_1);
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_2);
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_HEALING_KICKER_3);
    }

}


// Performs the attack portion of the battlecast ability for the havoc mage
void Battlecast()
{
    object oPC = OBJECT_SELF;
    // If battlecast is turned off, exit
    if(!GetLocalInt(oPC, "HavocMageBattlecast")) return;
    object oTarget = PRCGetSpellTargetObject();

    // Get the item used to cast the spell
    object oItem = GetSpellCastItem();

    // Battlecast only works on spells cast by the Havoc Mage, not by items he uses.
    if (oItem != OBJECT_INVALID)
    {
        FloatingTextStringOnCreature("You do not gain Battlecast from Items.", OBJECT_SELF, FALSE);
        return;
    }

    //if its not being cast on a hostile target or its at a location
    //get the nearest living seen hostile insead
    if(!spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oPC)
        || !GetIsObjectValid(oTarget))
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC, 1,
            CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
            CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }
    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    int nLevel = GetLevelByClass(CLASS_TYPE_HAVOC_MAGE, oPC);
    string sSpellLevel = lookup_spell_level(PRCGetSpellId());
    int nSpellLevel = StringToInt(sSpellLevel);

    // Don't want to smack allies upside the head when casting a spell.
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oPC)
        && oTarget != oPC
        && GetDistanceToObject(oTarget) < FeetToMeters(15.0))
    {
        // Make sure the levels are right for both the caster and the spells.
        // Level 8 spells and under at level 5
        if (nLevel == 5 && 8 >= nSpellLevel) PerformAttack(oTarget, oPC, eVis, 0.0, 0, 0, 0, "*Battlecast Hit*", "*Battlecast Missed*");
        // Level 4 spells and under at level 3
        else if (nLevel >= 3 && 4 >= nSpellLevel) PerformAttack(oTarget, oPC, eVis, 0.0, 0, 0, 0, "*Battlecast Hit*", "*Battlecast Missed*");
        // Level 2 spells and under at level 1
        else if (nLevel >= 1 && 2 >= nSpellLevel) PerformAttack(oTarget, oPC, eVis, 0.0, 0, 0, 0, "*Battlecast Hit*", "*Battlecast Missed*");
    }
}


//Archmage and Heirophant SLA slection/storage setting
int ClassSLAStore()
{
    int nSLAID = GetLocalInt(OBJECT_SELF, "PRC_SLA_Store");
    if(nSLAID)
    {
        FloatingTextStringOnCreature("SLA "+IntToString(nSLAID)+" stored", OBJECT_SELF);
        int nMetamagic = PRCGetMetaMagicFeat();
        int nSpellID = PRCGetSpellId();
        SetPersistantLocalInt(OBJECT_SELF, "PRC_SLA_SpellID_"+IntToString(nSLAID), nSpellID+1);
        SetPersistantLocalInt(OBJECT_SELF, "PRC_SLA_Class_"+IntToString(nSLAID), PRCGetLastSpellCastClass());
        SetPersistantLocalInt(OBJECT_SELF, "PRC_SLA_Meta_"+IntToString(nSLAID), nMetamagic);
        int nSpellLevel, nSpellClass;
            if(nSpellClass == CLASS_TYPE_BARD)
                nSpellLevel = StringToInt(Get2DACache("Spells", "Bard", nSpellID));
            else if(nSpellClass == CLASS_TYPE_CLERIC)
                nSpellLevel = StringToInt(Get2DACache("Spells", "Cleric", nSpellID));
            else if(nSpellClass == CLASS_TYPE_DRUID)
                nSpellLevel = StringToInt(Get2DACache("Spells", "Druid", nSpellID));
            else if(nSpellClass == CLASS_TYPE_RANGER)
                nSpellLevel = StringToInt(Get2DACache("Spells", "Ranger", nSpellID));
            else if(nSpellClass == CLASS_TYPE_PALADIN)
                nSpellLevel = StringToInt(Get2DACache("Spells", "Paladin", nSpellID));
            else if(nSpellClass == CLASS_TYPE_WIZARD
                || nSpellClass == CLASS_TYPE_SORCERER)
                nSpellLevel = StringToInt(Get2DACache("Spells", "Wiz_Sorc", nSpellID));
            else
            nSpellLevel = StringToInt(Get2DACache("Spells", "Innate", nSpellID));

            if (nMetamagic & METAMAGIC_QUICKEN)     nSpellLevel += 4;
            if (nMetamagic & METAMAGIC_STILL)       nSpellLevel += 1;
            if (nMetamagic & METAMAGIC_SILENT)      nSpellLevel += 1;
            if (nMetamagic & METAMAGIC_MAXIMIZE)    nSpellLevel += 3;
            if (nMetamagic & METAMAGIC_EMPOWER)     nSpellLevel += 2;
            if (nMetamagic & METAMAGIC_EXTEND)      nSpellLevel += 1;

        int nUses = 1;
        switch(nSpellLevel)
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
        SetPersistantLocalInt(OBJECT_SELF, "PRC_SLA_Uses_"+IntToString(nSLAID), nUses);
        DeleteLocalInt(OBJECT_SELF, "PRC_SLA_Store");
        return FALSE;
    }
    return TRUE;
}

int Scrying()
{
    // Scrying blocks all powers except for a few special case ones.
    object oPC = OBJECT_SELF;
    int nSpellId = PRCGetSpellId();
    int nScry    = GetLocalInt(oPC, "ScrySpellId");
    // If its an empty local int
    if (nScry == 0) return TRUE;

    if (nScry == SPELL_GREATER_SCRYING)
    {
        if (nSpellId == SPELL_DETECT_EVIL || nSpellId == SPELL_DETECT_GOOD ||
            nSpellId == SPELL_DETECT_LAW || nSpellId == SPELL_DETECT_CHAOS)
                return TRUE;
    }
    if (nScry == POWER_CLAIRTANGENT_HAND)
    {
        if (nSpellId == POWER_FARHAND)
                return TRUE;
    }

    return FALSE;
}

int GrappleConc()
{
        object oPC = OBJECT_SELF;
        if (GetGrapple(oPC))
        {
                string nSpellLevel = lookup_spell_level(PRCGetSpellId());
                return GetIsSkillSuccessful(oPC, SKILL_CONCENTRATION, (20 + StringToInt(nSpellLevel)));
        }
        return TRUE;
}

int X2UseMagicDeviceCheck()
{
    int nRet = ExecuteScriptAndReturnInt("x2_pc_umdcheck",OBJECT_SELF);
    return nRet;
}

//------------------------------------------------------------------------------
// GZ: This is a filter I added to prevent spells from firing their original spell
// script when they were cast on items and do not have special coding for that
// case. If you add spells that can be cast on items you need to put them into
// des_crft_spells.2da
//------------------------------------------------------------------------------
int X2CastOnItemWasAllowed(object oItem)
{
    int bAllow = (Get2DACache(X2_CI_CRAFTING_SP_2DA,"CastOnItems",PRCGetSpellId()) == "1");
    if (!bAllow)
    {
        FloatingTextStrRefOnCreature(83453, OBJECT_SELF); // not cast spell on item
    }
    return bAllow;

}

//------------------------------------------------------------------------------
// Execute a user overridden spell script.
//------------------------------------------------------------------------------
int X2RunUserDefinedSpellScript()
{
    // See x2_inc_switches for details on this code
    string sScript =  GetModuleOverrideSpellscript();
    if (sScript != "")
    {
        ExecuteScript(sScript,OBJECT_SELF);
        if (GetModuleOverrideSpellScriptFinished() == TRUE)
        {
            return FALSE;
        }
    }
    return TRUE;
}

//------------------------------------------------------------------------------
// Set the user-specific spell script
//------------------------------------------------------------------------------
void PRCSetUserSpecificSpellScript(string sScript)
{
    SetLocalString(OBJECT_SELF, "PRC_OVERRIDE_SPELLSCRIPT", sScript);
}

//------------------------------------------------------------------------------
// Get the user-specific spell script
//------------------------------------------------------------------------------
string PRCGetUserSpecificSpellScript()
{
    return GetLocalString(OBJECT_SELF, "PRC_OVERRIDE_SPELLSCRIPT");
}

//------------------------------------------------------------------------------
// Finish the spell, if necessary
//------------------------------------------------------------------------------
void PRCSetUserSpecificSpellScriptFinished()
{
    SetLocalInt(OBJECT_SELF, "PRC_OVERRIDE_SPELLSCRIPT_DONE", TRUE);
}

//------------------------------------------------------------------------------
// Figure out if we should finish the spell.
//------------------------------------------------------------------------------
int PRCGetUserSpecificSpellScriptFinished()
{
    int iRet = GetLocalInt(OBJECT_SELF, "PRC_OVERRIDE_SPELLSCRIPT_DONE");
    DeleteLocalInt(OBJECT_SELF, "PRC_OVERRIDE_SPELLSCRIPT_DONE");
    return iRet;
}

//------------------------------------------------------------------------------
// Run a user-specific spell script for classes that use spellhooking.
//------------------------------------------------------------------------------
int PRCRunUserSpecificSpellScript()
{
    string sScript = PRCGetUserSpecificSpellScript();
    if (sScript != "")
    {
        ExecuteScript(sScript,OBJECT_SELF);
        if (PRCGetUserSpecificSpellScriptFinished() == TRUE)
        {
            return FALSE;
        }
    }
    return TRUE;
}

//------------------------------------------------------------------------------
// Created Brent Knowles, Georg Zoeller 2003-07-31
// Returns TRUE (and charges the sequencer item) if the spell
// ... was cast on an item AND
// ... the item has the sequencer property
// ... the spell was non hostile
// ... the spell was not cast from an item
// in any other case, FALSE is returned an the normal spellscript will be run
//------------------------------------------------------------------------------
int X2GetSpellCastOnSequencerItem(object oItem)
{

    if (!GetIsObjectValid(oItem))
    {
        return FALSE;
    }

    // Check if the spell is marked as hostile in spells.2da
    int nHostile = StringToInt(Get2DACache("spells","HostileSetting",PRCGetSpellId()));

    if (GetIsObjectValid(GetSpellCastItem())) // spell cast from item?
    {
        // we allow scrolls
        int nBt = GetBaseItemType(GetSpellCastItem());
        if ( nBt !=BASE_ITEM_SPELLSCROLL && nBt != 105)
        {
            FloatingTextStrRefOnCreature(83373, OBJECT_SELF);
            return TRUE; // wasted!
        }
    }

    if(nHostile)
    {
        int nMaxChanSpells = IPGetItemChannelingProperty(oItem);

        if(nMaxChanSpells < 1)
        {
            FloatingTextStrRefOnCreature(83885,OBJECT_SELF);
            return TRUE; // no hostile spells on sequencers, sorry ya munchkins :)
        }

        int nNumberOfTriggers = GetLocalInt(oItem, "X2_L_NUMCHANNELTRIGGERS");
        // is there still space left on the sequencer?
        if (nNumberOfTriggers < nMaxChanSpells)
        {
            // success visual and store spell-id on item.
            effect eVisual = EffectVisualEffect(VFX_IMP_BREACH);
            nNumberOfTriggers++;
            //NOTE: I add +1 to the SpellId to spell 0 can be used to trap failure
            int nSID = PRCGetSpellId()+1;
            SetLocalInt(oItem, "X2_L_CHANNELTRIGGER"  +IntToString(nNumberOfTriggers), nSID);
            SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_L"+IntToString(nNumberOfTriggers), PRCGetCasterLevel(OBJECT_SELF));
            SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_M"+IntToString(nNumberOfTriggers), PRCGetMetaMagicFeat());
            SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_D"+IntToString(nNumberOfTriggers), PRCGetSaveDC(OBJECT_INVALID, OBJECT_SELF));
            SetLocalInt(oItem, "X2_L_NUMCHANNELTRIGGERS", nNumberOfTriggers);
            //add an OnHit:DischargeSequencer property
            itemproperty ipTest = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER, 1);
            IPSafeAddItemProperty(oItem ,ipTest, 99999999.9);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, OBJECT_SELF);
            FloatingTextStrRefOnCreature(83884, OBJECT_SELF);
        }
        else
            FloatingTextStrRefOnCreature(83859,OBJECT_SELF);
    }
    else
    {
        int nMaxSeqSpells = IPGetItemSequencerProperty(oItem); // get number of maximum spells that can be stored

        if(nMaxSeqSpells < 1)
        {
            return FALSE;
        }

        int nNumberOfTriggers = GetLocalInt(oItem, "X2_L_NUMTRIGGERS");
        // is there still space left on the sequencer?
        if (nNumberOfTriggers < nMaxSeqSpells)
        {
            // success visual and store spell-id on item.
            effect eVisual = EffectVisualEffect(VFX_IMP_BREACH);
            nNumberOfTriggers++;
            //NOTE: I add +1 to the SpellId to spell 0 can be used to trap failure
            int nSID = PRCGetSpellId()+1;
            SetLocalInt(oItem, "X2_L_SPELLTRIGGER"  +IntToString(nNumberOfTriggers), nSID);
            SetLocalInt(oItem, "X2_L_SPELLTRIGGER_L"+IntToString(nNumberOfTriggers), PRCGetCasterLevel(OBJECT_SELF));
            SetLocalInt(oItem, "X2_L_SPELLTRIGGER_M"+IntToString(nNumberOfTriggers), PRCGetMetaMagicFeat());
            SetLocalInt(oItem, "X2_L_SPELLTRIGGER_D"+IntToString(nNumberOfTriggers), PRCGetSaveDC(OBJECT_INVALID, OBJECT_SELF));
            SetLocalInt(oItem, "X2_L_NUMTRIGGERS", nNumberOfTriggers);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, OBJECT_SELF);
            FloatingTextStrRefOnCreature(83884, OBJECT_SELF);
        }
        else
            FloatingTextStrRefOnCreature(83859,OBJECT_SELF);
    }

    return TRUE; // in any case, spell is used up from here, so do not fire regular spellscript
}

//------------------------------------------------------------------------------
// * This is our little concentration system for black blade of disaster
// * if the mage tries to cast any kind of spell, the blade is signaled an event to die
//------------------------------------------------------------------------------
void X2BreakConcentrationSpells()
{
    // * At the moment we got only one concentration spell, black blade of disaster

    object oAssoc = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    if (GetIsObjectValid(oAssoc))
    {
        if(GetTag(oAssoc) == "x2_s_bblade") // black blade of disaster
        {
            if (GetLocalInt(OBJECT_SELF,"X2_L_CREATURE_NEEDS_CONCENTRATION"))
            {
                SignalEvent(oAssoc,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
        }
    }
}

//------------------------------------------------------------------------------
// being hit by any kind of negative effect affecting the caster's ability to concentrate
// will cause a break condition for concentration spells
//------------------------------------------------------------------------------
int X2GetBreakConcentrationCondition(object oPlayer)
{
     effect e1 = GetFirstEffect(oPlayer);
     int nType;
     int bRet = FALSE;
     while (GetIsEffectValid(e1) && !bRet)
     {
        nType = GetEffectType(e1);

        if (nType == EFFECT_TYPE_STUNNED || nType == EFFECT_TYPE_PARALYZE ||
            nType == EFFECT_TYPE_SLEEP || nType == EFFECT_TYPE_FRIGHTENED ||
            nType == EFFECT_TYPE_PETRIFY || nType == EFFECT_TYPE_CONFUSED ||
            nType == EFFECT_TYPE_DOMINATED || nType == EFFECT_TYPE_POLYMORPH)
         {
           bRet = TRUE;
         }
                    e1 = GetNextEffect(oPlayer);
     }
    return bRet;
}

void X2DoBreakConcentrationCheck()
{
    object oMaster = GetMaster();
    if (GetLocalInt(OBJECT_SELF,"X2_L_CREATURE_NEEDS_CONCENTRATION"))
    {
         if (GetIsObjectValid(oMaster))
         {
            int nAction = GetCurrentAction(oMaster);
            // master doing anything that requires attention and breaks concentration
            if (nAction == ACTION_DISABLETRAP || nAction == ACTION_TAUNT ||
                nAction == ACTION_PICKPOCKET || nAction ==ACTION_ATTACKOBJECT ||
                nAction == ACTION_COUNTERSPELL || nAction == ACTION_FLAGTRAP ||
                nAction == ACTION_CASTSPELL || nAction == ACTION_ITEMCASTSPELL)
            {
                SignalEvent(OBJECT_SELF,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
            else if (X2GetBreakConcentrationCondition(oMaster))
            {
                SignalEvent(OBJECT_SELF,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
         }
    }
}

//------------------------------------------------------------------------------
// This function will return TRUE if the spell that is cast is a shape shifting
// spell.
//------------------------------------------------------------------------------
int X3ShapeShiftSpell(object oTarget)
{ // PURPOSE: Return TRUE if a shape shifting spell was cast at oTarget
    int nSpellID=GetSpellId();
    string sUp=GetStringUpperCase(Get2DAString("x3restrict","SHAPESHIFT", nSpellID));
    if (sUp=="YES") return TRUE;
    return FALSE;
} // X3ShapeShiftSpell()


int CounterspellExploitCheck()
{
    if(GetCurrentAction(OBJECT_SELF) ==  ACTION_COUNTERSPELL)
    {
        ClearAllActions();
        SendMessageToPC(OBJECT_SELF,"Because of the infinite spell casting exploit, you cannot use counterspell in this manner.");
        return TRUE;
    }
    return FALSE;
}
void VoidCounterspellExploitCheck()
{
    if(GetCurrentAction(OBJECT_SELF) ==  ACTION_COUNTERSPELL)
    {
        ClearAllActions();
        SendMessageToPC(OBJECT_SELF,"Because of the infinite spell casting exploit, you cannot use counterspell in this manner.");
    }
}

// this will execute the prespellcastcode, whose full functionality is incoded in X2PreSpellCastCode2(),
// as a script, to save loading time for spells scripts and reduce memory usage of NWN
// the prespellcode takes up roughly 250 kByte compiled code, meaning that every spell script that
// calls it directly as a function (e.g.: X2PreSpellCastCode2) will be between 100 kByte to 250 kByte
// larger, than a spell script calling the prespellcode via ExecuteScript (e.g. X2PreSpellCastCode)
// Although ExecuteScript is slightly slower than a direct function call, quite likely overall performance is
// increased, because for every new spell 100-250 kByte less code need to be loaded into memory
// and NWN has more free memory available to keep more spells scripts (and other crucial scripts)
//in RAM
/*int X2PreSpellCastCode()
{
    object oCaster = OBJECT_SELF;

        // SetLocalInt(oCaster, "PSCC_Ret", 0);
        ExecuteScript("prc_prespell", oCaster);

        int nReturn = GetLocalInt(oCaster, "PSCC_Ret");
        // DeleteLocalInt(oCaster, "PSCC_Ret");

        return nReturn;
}
moved to prc_spellhook */
//------------------------------------------------------------------------------
// if FALSE is returned by this function, the spell will not be cast
// the order in which the functions are called here DOES MATTER, changing it
// WILL break the crafting subsystems
//------------------------------------------------------------------------------
int X2PreSpellCastCode2()
{
    object oCaster        = OBJECT_SELF;
    object oTarget        = PRCGetSpellTargetObject();
    object oSpellCastItem = PRCGetSpellCastItem();
    int nOrigSpellID = GetSpellId();
    int nSpellID     = PRCGetSpellId();
    string sComponent = GetStringUpperCase(Get2DACache("spells", "VS", nSpellID));
    int nContinue;

    DeleteLocalInt(oCaster, "SpellConc"); // Something to do with Drangosong Lyrist? - Ornedan
    nContinue = !ExecuteScriptAndReturnInt("prespellcode", oCaster);
    // 1.69 change
   //---------------------------------------------------------------------------
   // This small addition will check to see if the target is mounted and the
   // spell is therefor one that should not be permitted.
   //---------------------------------------------------------------------------
   if (!GetLocalInt(GetModule(),"X3_NO_SHAPESHIFT_SPELL_CHECK"))
   { // do check for abort due to being mounted check
       if (PRCHorseGetIsMounted(oTarget)&&X3ShapeShiftSpell(oTarget))
       { // shape shifting not allowed while mounted
           if(GetIsPC(oTarget))
           {
               FloatingTextStrRefOnCreature(111982,oTarget,FALSE);
           }
           return FALSE;
       } // shape shifting not allowed while mounted
   } // do check for abort due to being mounted check



    //---------------------------------------------------------------------------
    // This stuff is only interesting for player characters we assume that use
    // magic device always works and NPCs don't use the crafting feats or
    // sequencers anyway. Thus, any NON PC spellcaster always exits this script
    // with TRUE (unless they are DM possessed or in the Wild Magic Area in
    // Chapter 2 of Hordes of the Underdark.
    //---------------------------------------------------------------------------
    if (!GetIsPC(oCaster)
        && !GetPRCSwitch(PRC_NPC_HAS_PC_SPELLCASTING)
        && !GetIsDMPossessed(oCaster)
        && !GetLocalInt(GetArea(oCaster), "X2_L_WILD_MAGIC"))
            return TRUE;

    //counterspell exploit check

    if(nContinue
        && CounterspellExploitCheck())
        nContinue = FALSE;
    DelayCommand(0.1,VoidCounterspellExploitCheck());
    DelayCommand(0.2,VoidCounterspellExploitCheck());
    DelayCommand(0.3,VoidCounterspellExploitCheck());
    DelayCommand(0.4,VoidCounterspellExploitCheck());
    DelayCommand(0.5,VoidCounterspellExploitCheck());
    DelayCommand(0.6,VoidCounterspellExploitCheck());
    DelayCommand(0.7,VoidCounterspellExploitCheck());
    DelayCommand(0.8,VoidCounterspellExploitCheck());
    DelayCommand(0.9,VoidCounterspellExploitCheck());
    DelayCommand(1.0,VoidCounterspellExploitCheck());
    DelayCommand(2.0,VoidCounterspellExploitCheck());
    DelayCommand(3.0,VoidCounterspellExploitCheck());

    //Pnp Tensers Transformation
    if(nContinue
        && GetPRCSwitch(PRC_PNP_TENSERS_TRANSFORMATION)
        && GetHasSpellEffect(SPELL_TENSERS_TRANSFORMATION))
        nContinue = FALSE;
    //PnP Timestop
    if(nContinue
        && GetPRCSwitch(PRC_TIMESTOP_NO_HOSTILE)
        && (GetHasSpellEffect(SPELL_TIME_STOP)
            || GetHasSpellEffect(4032)          //epic spell: Greater Timestop
            || GetHasSpellEffect(14236))        //psionic power: Temporal Acceleration
        && (!GetIsObjectValid(oTarget)
            || oTarget != oCaster
            || Get2DACache("spells", "HostileSetting", nOrigSpellID) == "1")
        )
    {
        nContinue = FALSE;
    }
    //Pnp spellschools
    if(nContinue
        && GetPRCSwitch(PRC_PNP_SPELL_SCHOOLS)
        && GetLevelByClass(CLASS_TYPE_WIZARD))
    {
        int nSchool = GetSpellSchool(nSpellID);
        if(nSchool == SPELL_SCHOOL_ABJURATION
            && GetHasFeat(2265, oCaster))
            nContinue = FALSE;
        else if(nSchool == SPELL_SCHOOL_CONJURATION
            && GetHasFeat(2266, oCaster))
            nContinue = FALSE;
        else if(nSchool == SPELL_SCHOOL_DIVINATION
            && GetHasFeat(2267, oCaster))
            nContinue = FALSE;
        else if(nSchool == SPELL_SCHOOL_ENCHANTMENT
            && GetHasFeat(2268, oCaster))
            nContinue = FALSE;
        else if(nSchool == SPELL_SCHOOL_EVOCATION
            && GetHasFeat(2269, oCaster))
            nContinue = FALSE;
        else if(nSchool == SPELL_SCHOOL_ILLUSION
            && GetHasFeat(2270, oCaster))
            nContinue = FALSE;
        else if(nSchool == SPELL_SCHOOL_NECROMANCY
            && GetHasFeat(2271, oCaster))
            nContinue = FALSE;
        else if(nSchool == SPELL_SCHOOL_TRANSMUTATION
            && GetHasFeat(2272, oCaster))
            nContinue = FALSE;
        if(!nContinue)
            FloatingTextStringOnCreature("You cannot cast spells of an opposition school.", oCaster, FALSE);
    }
    //Pnp somatic components
    if(nContinue
        && (GetPRCSwitch(PRC_PNP_SOMATIC_COMPOMENTS)
            || GetPRCSwitch(PRC_PNP_SOMATIC_ITEMS)))
    {
        int nHandFree;
        int nHandRequired;
        object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCaster);
        if(!GetIsObjectValid(oItem)
            || GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD)
            nHandFree = TRUE;
        oItem = oSpellCastItem;
        //check item is not equiped
        if(!nHandFree
            && GetIsObjectValid(oItem)
            && GetPRCSwitch(PRC_PNP_SOMATIC_COMPOMENTS))
        {
            int nSlot;
            nHandRequired = TRUE;
            for(nSlot = 0; nSlot<NUM_INVENTORY_SLOTS; nSlot++)
            {
                if(GetItemInSlot(nSlot, oCaster) == oItem)
                    nHandRequired = FALSE;
            }
        }
        //check its a real spell and that it requires a free hand
        if(!nHandFree
            && !nHandRequired
            && !GetIsObjectValid(oItem)
            && GetPRCSwitch(PRC_PNP_SOMATIC_COMPOMENTS))
        {
            if(sComponent == "VS"
                || sComponent == "SV"
                || sComponent == "S")
                nHandRequired = TRUE;
        }

        if(nHandRequired && nHandFree)
        {
            nContinue = FALSE;
            FloatingTextStringOnCreature("You do not have any free hands.", oCaster, FALSE);
        }
    }
    
    //Corrupt or Sanctified spell
    if(nContinue)
    {
       //Check for each Corrupt and Sanctified spell

      if(nSpellID == SPELL_ABSORB_STRENGTH           ||
      nSpellID == SPELL_APOCALYPSE_FROM_THE_SKY   ||
      nSpellID == SPELL_CLAWS_OF_THE_BEBILITH     ||
      nSpellID == SPELL_DEATH_BY_THORNS           ||
      nSpellID == SPELL_EVIL_WEATHER              ||
      nSpellID == SPELL_FANGS_OF_THE_VAMPIRE_KING ||
      nSpellID == SPELL_LAHMS_FINGER_DARTS        ||
      nSpellID == SPELL_POWER_LEECH               ||
      nSpellID == SPELL_RAPTURE_OF_RUPTURE        ||
      nSpellID == SPELL_RED_FESTER                ||
      nSpellID == SPELL_ROTTING_CURSE_OF_URFESTRA ||
      nSpellID == SPELL_SEETHING_EYEBANE          ||
      nSpellID == SPELL_TOUCH_OF_JUIBLEX          ||
      nSpellID == SPELL_AYAILLAS_RADIANT_BURST    ||
      nSpellID == SPELL_BRILLIANT_EMANATION       ||
      nSpellID == SPELL_DIVINE_INSPIRATION        ||
      nSpellID == SPELL_DIAMOND_SPRAY             ||
      nSpellID == SPELL_DRAGON_CLOUD              ||
      nSpellID == SPELL_EXALTED_FURY              ||
      nSpellID == SPELL_HAMMER_OF_RIGHTEOUSNESS   ||
      nSpellID == SPELL_PHIERANS_RESOLVE          ||
      nSpellID == SPELL_PHOENIX_FIRE              ||
      nSpellID == SPELL_RAIN_OF_EMBERS            ||
      nSpellID == SPELL_SICKEN_EVIL               ||
      nSpellID == SPELL_STORM_OF_SHARDS           ||
      nSpellID == SPELL_SUNMANTLE                 ||
      nSpellID == SPELL_TWILIGHT_LUCK
      )
      {             
              int nClass = PRCGetLastSpellCastClass();
              int nBookType = GetSpellbookTypeForClass(nClass);
              
              // check if the caster is a spontaneous caster
              if(nBookType == SPELLBOOK_TYPE_SPONTANEOUS)
              {
                      nContinue = FALSE;
                      SendMessageToPC(oCaster, "Spontaneous casters cannot cast this spell!");
              }
              
              //check for immunity to ability damage - sorry undead buddies
              if(GetIsImmune(oCaster, IMMUNITY_TYPE_ABILITY_DECREASE))
              {
                      if(nSpellID != SPELL_TWILIGHT_LUCK &&
                         nSpellID != SPELL_DIAMOND_SPRAY)
                      {
                              nContinue = FALSE;
                              SendMessageToPC(oCaster, "You must be able to take ability damage to cast this spell!");
                      }
              }
      }
      
      //Check for alignment restrictions
      if(GetAlignmentGoodEvil(oCaster) == ALIGNMENT_EVIL)
      {
              if(nSpellID == SPELL_AYAILLAS_RADIANT_BURST ||
               nSpellID == SPELL_BRILLIANT_EMANATION       ||
               nSpellID == SPELL_DIVINE_INSPIRATION        ||
               nSpellID == SPELL_DIAMOND_SPRAY             ||
               nSpellID == SPELL_DRAGON_CLOUD              ||
               nSpellID == SPELL_EXALTED_FURY              ||
               nSpellID == SPELL_HAMMER_OF_RIGHTEOUSNESS   ||
               nSpellID == SPELL_PHIERANS_RESOLVE          ||
               nSpellID == SPELL_PHOENIX_FIRE              ||
               nSpellID == SPELL_RAIN_OF_EMBERS            ||
               nSpellID == SPELL_SICKEN_EVIL               ||
               nSpellID == SPELL_STORM_OF_SHARDS           ||
               nSpellID == SPELL_SUNMANTLE                 ||
               nSpellID == SPELL_TWILIGHT_LUCK)
               {
                       nContinue = FALSE;
                       SendMessageToPC(oCaster, "You cannot cast Sanctified spells if you are evil.");
               }
        }

        if(GetAlignmentGoodEvil(oCaster) == ALIGNMENT_GOOD)
        {
                if(nSpellID == SPELL_ABSORB_STRENGTH        ||
                nSpellID == SPELL_APOCALYPSE_FROM_THE_SKY   ||
                nSpellID == SPELL_CLAWS_OF_THE_BEBILITH     ||
                nSpellID == SPELL_DEATH_BY_THORNS           ||
                nSpellID == SPELL_EVIL_WEATHER              ||
                nSpellID == SPELL_FANGS_OF_THE_VAMPIRE_KING ||
                nSpellID == SPELL_LAHMS_FINGER_DARTS        ||
                nSpellID == SPELL_POWER_LEECH               ||
                nSpellID == SPELL_RAPTURE_OF_RUPTURE        ||
                nSpellID == SPELL_RED_FESTER                ||
                nSpellID == SPELL_ROTTING_CURSE_OF_URFESTRA ||
                nSpellID == SPELL_SEETHING_EYEBANE          ||
                nSpellID == SPELL_TOUCH_OF_JUIBLEX)

                {
                        nContinue = FALSE;
                        SendMessageToPC(oCaster, "You cannot cast Corrupt spells if you are good.");
                }
        }
    }

    //Violet Rain check
    if(GetHasSpellEffect(SPELL_EVIL_WEATHER_VIOLET_RAIN, oCaster))
    {
            int nClass = PRCGetLastSpellCastClass();

            if(GetIsDivineClass(nClass, oCaster))
            {
                    nContinue = FALSE;
            }
    }

    //Spell Barriers
    if(nContinue)
    {
            object oPC = OBJECT_SELF;
            object oTarget = PRCGetSpellTargetObject();

            if(GetHasSpellEffect(SPELL_OTILUKES_RESILIENT_SPHERE, oTarget))
            {
                    if(GetDistanceBetween(oPC, oTarget) > 6.096)
                    {
                            nContinue = FALSE;
                    }
            }

            if(GetHasSpellEffect(SPELL_PRISMATIC_SPHERE, oTarget))
            {
                    if(GetDistanceBetween(oPC, oTarget) > 3.048)
                    {
                            nContinue = FALSE;
                    }
            }
    }

    //---------------------------------------------------------------------------
    // Break any spell require maintaining concentration (only black blade of
    // disaster)
    // /*REM*/
    if(GetPRCSwitch(PRC_PNP_BLACK_BLADE_OF_DISASTER))
        X2BreakConcentrationSpells();
        //this is also in summon HB
        //but needed here to handle quickend spells
        //Disintegrate is cast from the blade so doenst end the summon
    //---------------------------------------------------------------------------

    //---------------------------------------------------------------------------
    // Druid spontaneous summoning
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = DruidSpontSummon();

    //---------------------------------------------------------------------------
    // Run New Spellbook Spell Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = NSB_SpellCast();

    //---------------------------------------------------------------------------
    // Run Material Component Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = MaterialComponents();

    //---------------------------------------------------------------------------
    // Run Red Wizard School Restriction Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = RedWizRestrictedSchool();

    //---------------------------------------------------------------------------
    // Run NullPsionicsField Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = NullPsionicsField();

    //---------------------------------------------------------------------------
    // Run Scrying Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = Scrying();

    //---------------------------------------------------------------------------
    // Run WardOfPeace Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = WardOfPeace();

    //---------------------------------------------------------------------------
    // Run Ectoplasmic Shambler Concentration Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = EShamConc();
        
    //---------------------------------------------------------------------------
    // Run Grappling Concentration Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = GrappleConc();        

    //---------------------------------------------------------------------------
    // Baelnorn attempting to use items while projection
    //---------------------------------------------------------------------------
    if(nContinue                                         && // No need to evaluate if casting has been cancelled already
       GetLocalInt(oCaster, "BaelnornProjection_Active") && // If projection is active AND
       GetIsObjectValid(oSpellCastItem)                     // Cast from an item
       )
    {
        nContinue = FALSE; // Prevent casting
    }

    //---------------------------------------------------------------------------
    // Run Knight of the Chalice Heavenly Devotion check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = KOTCHeavenDevotion(oTarget);

    //---------------------------------------------------------------------------
    // Run Bard/Sorc PrC check
    //---------------------------------------------------------------------------
    if(nContinue)
        nContinue = BardSorcPrCCheck();

    //---------------------------------------------------------------------------
    // Run Inscribe Rune Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = InscribeRune();

    //---------------------------------------------------------------------------
    // Run Attune Gem Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = AttuneGem();

    //---------------------------------------------------------------------------
    // Run Class Spell-like-ability Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = ClassSLAStore();

    //---------------------------------------------------------------------------
    // Run use magic device skill check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = X2UseMagicDeviceCheck();

    //-----------------------------------------------------------------------
    // run any user defined spellscript here
    //-----------------------------------------------------------------------
    if (nContinue)
        nContinue = X2RunUserDefinedSpellScript();

    //-----------------------------------------------------------------------
    // run any object-specific spellscript here
    //-----------------------------------------------------------------------
    if (nContinue)
        nContinue = PRCRunUserSpecificSpellScript();
    //---------------------------------------------------------------------------
    // Check for the new restricted itemproperties
    //---------------------------------------------------------------------------
    if(nContinue
        && GetIsObjectValid(oSpellCastItem)
        && !CheckPRCLimitations(oSpellCastItem, oCaster))
    {
        SendMessageToPC(oCaster, "You cannot use "+GetName(oSpellCastItem));
        nContinue = FALSE;
    }
if(DEBUG) DoDebug("x2_inc_spellhook pre-crafting "+IntToString(nContinue));
    //-----------------------------------------------------------------------
    // Check if spell was used for Duskblade channeling
    //-----------------------------------------------------------------------
    if (nContinue)
        nContinue = DuskbladeArcaneChanneling();


    //---------------------------------------------------------------------------
    // The following code is only of interest if an item was targeted
    //---------------------------------------------------------------------------
    if (GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {

if(DEBUG) DoDebug("x2_inc_spellhook pre-x2_pc_craft "+IntToString(nContinue));
        //-----------------------------------------------------------------------
        // Check if spell was used to trigger item creation feat
        //-----------------------------------------------------------------------
        if (nContinue)
            nContinue = !ExecuteScriptAndReturnInt("x2_pc_craft", oCaster);

if(DEBUG) DoDebug("x2_inc_spellhook pre-sequencer "+IntToString(nContinue));
        //-----------------------------------------------------------------------
        // Check if spell was used for on a sequencer item
        // Check if spell was used for Arcane Archer Imbue Arrow
        // Check if spell was used for Spellsword ChannelSpell
        //-----------------------------------------------------------------------
        if (nContinue)
            nContinue = (!X2GetSpellCastOnSequencerItem(oTarget));

if(DEBUG) DoDebug("x2_inc_spellhook pre-tagbased "+IntToString(nContinue));
        //-----------------------------------------------------------------------
        // * Execute item OnSpellCast At routing script if activated
        //-----------------------------------------------------------------------
        if (nContinue
            && GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
        {
            SetUserDefinedItemEventNumber(X2_ITEM_EVENT_SPELLCAST_AT);
            int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oTarget), oCaster);
            if (nRet == X2_EXECUTE_SCRIPT_END)
                return FALSE;
        }

if(DEBUG) DoDebug("x2_inc_spellhook pre-X2CastOnItemWasAllowed "+IntToString(nContinue));

        //-----------------------------------------------------------------------
        // Prevent any spell that has no special coding to handle targetting of items
        // from being cast on items. We do this because we can not predict how
        // all the hundreds spells in NWN will react when cast on items
        //-----------------------------------------------------------------------
        if (nContinue)
            nContinue = X2CastOnItemWasAllowed(oTarget);
    }



    //spellsharing for bonded summoner
    //Pnp familiar spellsharing
    if (nContinue
        && GetHasFeat(FEAT_SUMMON_FAMILIAR, oCaster)
        && (GetLevelByClass(CLASS_TYPE_BONDED_SUMMONNER, oCaster)
            || GetPRCSwitch(PRC_PNP_FAMILIARS)
        && GetIsObjectValid(GetLocalObject(oCaster, "Familiar"))
        /*&& (PRCGetLastSpellCastClass() == CLASS_TYPE_WIZARD ||
            PRCGetLastSpellCastClass() == CLASS_TYPE_SORCERER ||
            PRCGetLastSpellCastClass() == CLASS_TYPE_WITCH)*///the manual says *any* spell
        && !GetLocalInt(oCaster, "PRC_SPELL_HOLD")     //holding the charge doesnt work
        && (Get2DACache("spells", "Range", nSpellID) == "P" || oTarget == oCaster) // Either of these is legal
        && !GetIsObjectValid(oSpellCastItem)     // no item spells
        && nSpellID != SPELL_SHAPECHANGE         // no polymorphs
        && nSpellID != SPELL_POLYMORPH_SELF
        && nSpellID != SPELL_SCRY                // no scrying
        && nSpellID != SPELL_GREATER_SCRYING
        && nSpellID != SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE
        && nSpellID != SPELL_ARCANE_EYE
        && nSpellID != SPELL_PNP_SCRY_FAMILIAR
        && nSpellID != SPELL_TENSERS_TRANSFORMATION))
    {
        object oFam = GetLocalObject(oCaster, "Familiar");
        // Run the ShareSpell code to duplicate the spell on the familiar
        // spell has to be wiz/sorc/witch and cast on self to be shared
        if(3.33 >= GetDistanceBetween(oCaster, oFam))
        {
            AssignCommand(oFam, ClearAllActions());
            AssignCommand(oFam, ActionCastSpell(nSpellID, PRCGetCasterLevel(oCaster), 0, PRCGetSaveDC(oCaster, oCaster, nSpellID), PRCGetMetaMagicFeat(), CLASS_TYPE_INVALID, FALSE, TRUE, oFam));
        }
    }

    //PnP familiar - deliver touch spell
    if (nContinue
        && GetHasFeat(FEAT_SUMMON_FAMILIAR, oCaster)
        && GetPRCSwitch(PRC_PNP_FAMILIARS)
//        && GetLocalInt(oCaster, "DeliverTouchSpells")
        && GetIsObjectValid(GetLocalObject(oCaster, "Familiar"))
        && !GetLocalInt(oCaster, "PRC_SPELL_HOLD") //holding the charge doesnt work
        && (Get2DACache("spells", "Range", nSpellID) == "T") //only touch spells
        && !GetIsObjectValid(oSpellCastItem))     // no item spells
    {
        object oFam = GetLocalObject(oCaster, "Familiar");
        //int nSpell = PRCGetSpellId();

        if(GetIsObjectValid(oFam) && GetHitDice(oFam)>2 && oTarget == oFam)
        {
        //find the item
        object oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oFam);
        if(!GetIsObjectValid(oItem)) oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oFam);
        if(!GetIsObjectValid(oItem)) oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oFam);
        if(GetIsObjectValid(oItem)
            //&& IPGetIsMeleeWeapon(oItem)
            //&& GetIsEnemy(PRCGetSpellTargetObject())
            && !GetLocalInt(oItem, "X2_L_NUMCHANNELTRIGGERS"))
        {
            //valid spell, store
            //this uses similar things to the spellsequencer/spellsword/arcanearcher stuff
            effect eVisual = EffectVisualEffect(VFX_IMP_BREACH);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oFam);
            //NOTE: I add +1 to the SpellId to spell 0 can be used to trap failure
            int nSID = PRCGetSpellId()+1;
            float fDelay = 60.0;

            SetLocalInt(oItem, "X2_L_CHANNELTRIGGER"  , nSID);
            SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_L", PRCGetCasterLevel(OBJECT_SELF));
            SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_M", PRCGetMetaMagicFeat());
            SetLocalInt(oItem, "X2_L_CHANNELTRIGGER_D", PRCGetSaveDC(OBJECT_SELF, OBJECT_SELF));
            SetLocalInt(oItem, "X2_L_NUMCHANNELTRIGGERS", 1);

            itemproperty ipTest = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER, 1);
            IPSafeAddItemProperty(oItem ,ipTest, fDelay);

            DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_CHANNELTRIGGER"));
            DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_CHANNELTRIGGER_L"));
            DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_CHANNELTRIGGER_M"));
            DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_CHANNELTRIGGER_D"));

            DelayCommand(fDelay, DeleteLocalInt(oItem, "X2_L_NUMCHANNELTRIGGERS"));

            return FALSE;//don't cast
        }
        }
    }

    // Healer Spellsharing
    if(nContinue && GetLevelByClass(CLASS_TYPE_HEALER, oCaster) >= 8)
    {
        object oComp = GetLocalObject(oCaster, "HealerCompanion");
        /*int nHealCount = GetLocalInt(oCaster, "HealerCompanionSpell");
        int nCompCount = GetLocalInt(oComp, "HealerCompanionSpell");
        if(DEBUG) DoDebug("x2_inc_spellhook: nHealCount: " + IntToString(nHealCount));
        if(DEBUG) DoDebug("x2_inc_spellhook: nCompCount: " + IntToString(nCompCount));*/
        if(DEBUG) DoDebug("x2_inc_spellhook: oCaster Name: " + GetName(oCaster));
        if(DEBUG) DoDebug("x2_inc_spellhook: Caster Level: " + IntToString(PRCGetCasterLevel(oCaster)));
        if(DEBUG) DoDebug("x2_inc_spellhook: Save DC: " + IntToString(PRCGetSaveDC(oCaster, oCaster, nSpellID)));
        // Allow the spell twice, once to affect target and once to affect companion

        if (GetIsObjectValid(oComp))
        {
                /* X - Not sure if this is still needed:
                SetLocalInt(oCaster, "HealerCompanionSpell", nHealCount + 1);
                SetLocalInt(oComp, "HealerCompanionSpell", nCompCount + 1);
                DelayCommand(3.0, DeleteLocalInt(oCaster, "HealerCompanionSpell"));
                DelayCommand(3.0, DeleteLocalInt(oComp, "HealerCompanionSpell"));
                if (nHealCount < 1 ) 
                {*/
                        // Makes it only harmless spells, to stop abuse of things like Word of Faith.
                        if ((Get2DACache("spells", "Range", nSpellID) == "P" || !GetLastSpellHarmful() || oTarget == oCaster) // Either of these is legal
                             && !GetLocalInt(oCaster, "PRC_SPELL_HOLD") && 3.33 >= GetDistanceBetween(oCaster, oComp) //10 feet - the source book says it's 5, but that will make it very difficult to use in NWN
                             && nSpellID != SPELL_SCRY && nSpellID != SPELL_GREATER_SCRYING && nSpellID != SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE
                             && nSpellID != SPELL_ARCANE_EYE && nSpellID != SPELL_PNP_SCRY_FAMILIAR)            // no scrying
                        {
                            AssignCommand(oComp, ClearAllActions());
                            AssignCommand(oComp, ActionCastSpell(nSpellID, PRCGetCasterLevel(oCaster), 0, PRCGetSaveDC(oCaster, oCaster, nSpellID), PRCGetMetaMagicFeat(), CLASS_TYPE_INVALID, FALSE, TRUE, oComp));
                        }
                //}
        }
    }

    if(GetPRCSwitch(PRC_PW_SPELL_TRACKING))
    {
        if(GetLocalInt(oCaster, "UsingActionCastSpell"))
        {
        }
        else
        {
            string sSpell = IntToString(nOrigSpellID)+"|"; //use original spellID
            string sStored = GetPersistantLocalString(oCaster, "persist_spells");
            SetPersistantLocalString(oCaster, "persist_spells", sStored+sSpell);
        }
    }

    //Combat medic healing kicker
    if(nContinue && GetLevelByClass(CLASS_TYPE_COMBAT_MEDIC))
        CombatMedicHealingKicker();

    // Havoc Mage Battlecast
    if(nContinue && GetLevelByClass(CLASS_TYPE_HAVOC_MAGE))
        Battlecast();

    //Draconic Feat effects
    if(nContinue)
        DraconicFeatsOnSpell();
        
    // Feats
    if(nContinue)
    {
        DazzlingIllusion();
        EnergyAbjuration();
        InsightfulDivination();
        TougheningTransmutation();
        CloudyConjuration();
    }

    //casting from staffs uses caster DC calculations
    if(nContinue
       && GetIsObjectValid(oSpellCastItem)
       && (GetBaseItemType(oSpellCastItem) == BASE_ITEM_MAGICSTAFF || GetBaseItemType(oSpellCastItem) == BASE_ITEM_CRAFTED_STAFF)
       && GetPRCSwitch(PRC_STAFF_CASTER_LEVEL))
    {
        int nDC = 10 + StringToInt(lookup_spell_innate(nSpellID));
        nDC += (GetAbilityScoreForClass(GetPrimaryArcaneClass(oCaster), oCaster)-10)/2;
        SetLocalInt(oCaster, PRC_DC_BASE_OVERRIDE, nDC);
        DelayCommand(0.01, DeleteLocalInt(oCaster, PRC_DC_BASE_OVERRIDE));
    }
if(DEBUG) DoDebug("x2_inc_spellhook pre-spellfire "+IntToString(nContinue));
    //---------------------------------------------------------------------------
    // Spellfire
    //---------------------------------------------------------------------------
    if(nContinue)
    {
        if(GetHasFeat(FEAT_SPELLFIRE_WIELDER, oCaster))
        {
            int nStored = GetPersistantLocalInt(oCaster, "SpellfireLevelStored");
            int nCON = GetAbilityScore(oCaster, ABILITY_CONSTITUTION);
            if(nStored > 4 * nCON)
            {
                if(!GetIsSkillSuccessful(oCaster, SKILL_CONCENTRATION, 25)) nContinue = FALSE;
            }
            else if(nStored > 3 * nCON)
            {
                if(!GetIsSkillSuccessful(oCaster, SKILL_CONCENTRATION, 20)) nContinue = FALSE;
            }
        }
        if(GetLocalInt(oTarget, "SpellfireAbsorbFriendly") && GetIsFriend(oTarget, oCaster))
        {
            if(CheckSpellfire(oCaster, oTarget, TRUE))
            {
                PRCShowSpellResist(oCaster, oTarget, SPELL_RESIST_MANTLE);
                nContinue = FALSE;
            }
        }
    }

    //-----------------------------------------------------------------------
    // Shifting casting restrictions
    //-----------------------------------------------------------------------
    // The variable tells that the new form is unable to cast spells (very inaccurate, determined by racial type)
    // with somatic or vocal components and is lacking Natural Spell feat
    if(nContinue                                           && // Any point to checking this?
       GetLocalInt(oCaster, "PRC_Shifting_RestrictSpells")    // See if the restriction might apply
       )
    {
        int bDisrupted  = FALSE;
        int nSpellLevel = StringToInt(Get2DACache("spells", "Innate", nSpellID));

        // Somatic component and no silent meta or high enough auto-still
        if((FindSubString(sComponent, "S") != -1)                                       &&
           !(PRCGetMetaMagicFeat() & METAMAGIC_STILL)                                   &&
           !(GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_3, oCaster)                       ||
             (nSpellLevel <= 6 && GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_2, oCaster)) ||
             (nSpellLevel <= 3 && GetHasFeat(FEAT_EPIC_AUTOMATIC_STILL_SPELL_1, oCaster))
             )
           )
            bDisrupted = TRUE;
        // Vocal component and no silent meta or high enough auto-silent
        if((FindSubString(sComponent, "V") != -1)                                        &&
           !(PRCGetMetaMagicFeat() & METAMAGIC_SILENT)                                   &&
           !(GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_3, oCaster)                       ||
             (nSpellLevel <= 6 && GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_2, oCaster)) ||
             (nSpellLevel <= 3 && GetHasFeat(FEAT_EPIC_AUTOMATIC_SILENT_SPELL_1, oCaster))
             )
           )
            bDisrupted = TRUE;

        // Potion drinking is not restricted
        if(GetIsObjectValid(oSpellCastItem) &&
           (GetBaseItemType(oSpellCastItem) == BASE_ITEM_ENCHANTED_POTION ||
            GetBaseItemType(oSpellCastItem) == BASE_ITEM_POTIONS
           ))
            bDisrupted = FALSE;

        //OnHit properties on equipped items not restricted
        if(bDisrupted && GetIsObjectValid(oSpellCastItem))
        {
            int nSlot;
            for(nSlot = 0; nSlot<NUM_INVENTORY_SLOTS; nSlot++)
            {
                if(GetItemInSlot(nSlot, oCaster) == oSpellCastItem)
                    bDisrupted = FALSE;
            }
        }

        if(bDisrupted)
        {
            FloatingTextStrRefOnCreature(16828386, oCaster, FALSE); // "Your spell failed due to being in a form that prevented either a somatic or a vocal component from being used"
            nContinue = FALSE;
        }
    }

    //Cleaning spell variables used for holding the charge
    if(!GetLocalInt(oCaster, "PRC_SPELL_EVENT"))
    {
        DeleteLocalInt(oCaster, "PRC_SPELL_CHARGE_COUNT");
        DeleteLocalInt(oCaster, "PRC_SPELL_CHARGE_SPELLID");
        DeleteLocalObject(oCaster, "PRC_SPELL_CONC_TARGET");
        DeleteLocalInt(oCaster, "PRC_SPELL_METAMAGIC");
        DeleteLocalManifestation(oCaster, "PRC_POWER_HOLD_MANIFESTATION");
    }
    else if(GetLocalInt(oCaster, "PRC_SPELL_CHARGE_SPELLID") != nSpellID)
    {   //Sanity check, in case something goes wrong with the action queue
        DeleteLocalInt(oCaster, "PRC_SPELL_EVENT");
    }
    
    //---------------------------------------------------------------------------
    // Run Dark Discorporation Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = !GetLocalInt(oCaster, "DarkDiscorporation");

    return nContinue;
}


// Test main
//void main(){}
