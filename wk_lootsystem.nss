//////////////////////////////////////////////////////////
//::use: #include"wk_lootsystem"
//::  Original version by Commche 2006, Commche's Loot System
//::
//::  Present version modified by Winterknight for Altharia
//::  Last Modified June 2007
//::    - Simplified some system elements, eliminated socketed items
//::    - Changed power levels to be more appropriate to Altharia (higher)
//::    - Got rid of some item types for drops
//::

#include "x2_inc_itemprop"
#include "nw_i0_generic"

//////////////////////////////////////////////////////////
//: Constants
//:
//:note* See line 4408 for specific item droprate configuration

const int LUCK_CHANCE = 100;  // 1 in x chance getting a much better item (0 for off)
const int DROP_RATE = 4;      // % modifyer for loot drop (see line 4619 for specifics)
const int CHANCE_WORN = 0;    // % chance of worn item (0 for off)
const int CHANCE_BROKEN = 0;  // % chance of broken item (0 for off)

const string COLORTOKEN ="                  ##################$%&'()*+,-./0123456789:;;==?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[[]^_`abcdefghijklmnopqrstuvwxyz{|}~~ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûü°°¢£§•¶ß®©™´¨¨ÆØ∞±≤≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛˛";

string ColorString(string sText, int nRed=255, int nGreen=255, int nBlue=255)
{
    return "<c" + GetSubString(COLORTOKEN, nRed, 1) + GetSubString(COLORTOKEN, nGreen, 1) + GetSubString(COLORTOKEN, nBlue, 1) + ">" + sText + "</c>";
}


// Generates a colored name description by power - common function
string GetColorName(int iQual, string sIName)
{
  if (iQual>9)iQual=9;
  if (iQual==0)iQual=1;
  string sName;
  switch(iQual)
       {
        case 1: sName = ColorString("Adventurer's "+sIName,255, 255, 255); break;
        case 2: sName = ColorString("Veteran's "+sIName, 0, 255, 0); break;
        case 3: sName = ColorString("Champion's "+sIName, 65, 105, 225); break;
        case 4: sName = ColorString("Hero's "+sIName, 102, 205, 170); break;
        case 5: sName = ColorString("Paragon's "+sIName, 128, 0, 218); break;
        case 6: sName = ColorString("Icon's "+sIName, 218, 165, 32 ); break;
        case 7: sName = ColorString("Eidolon's "+sIName, 255, 255, 0 ); break;
        case 8: sName = ColorString("Legend's "+sIName, 255, 0, 255 ); break;
        case 9: sName = ColorString("Saint's "+sIName, 165, 218, 128 ); break;
       }
  return sName;
}

// Generates a random weapon
// =======================================
// oMob = the creature that just died
// oSack = the object into which you will spawn the weapon
// iRange = the quality of the weapon: 1=lowest 5=highest
// SockChance = a % chance for the generated weapon to be socketed
// DamBroke = a switch to disable chance of damaged/broken weapon: 0=on 1=off
void DropWeapon(object oSack, int iRange);

// Generates random chest armor
// =======================================
// oMob = the creature that just died
// oSack = the object into which you will spawn the armor
// iRange = the quality of the armor: 1=lowest 5=highest
// SockChance = a % chance for the generated armor to be socketed
// DamBroke = a switch to disable chance of damaged/broken armor: 0=on 1=off
void DropArmor(object oSack, int iRange);

// Generates a random shield
// =======================================
// oMob = the creature that just died
// oSack = the object into which you will spawn the shield
// iRange = the quality of the shield: 1=lowest 5=highest
// SockChance = a % chance for the generated shield to be socketed
// DamBroke = a switch to disable chance of damaged/broken shield: 0=on 1=off
void DropShield(object oSack, int iRange);

// Generates random monk gloves
// =======================================
// oMob = the creature that just died
// oSack = the object into which you will spawn the gloves
// iRange = the quality of the gloves: 1=lowest 5=highest
// SockChance = a % chance for the generated gloves to be socketed
// DamBroke = a switch to disable chance of damaged/broken gloves: 0=on 1=off
void DropMonkGloves(object oSack, int iRange);

// Generates a random magic item (i.e. boots, helm, amulet, ring, belt, bracer)
// ============================================================================
// oMob = the creature that just died
// oSack = the object into which you will spawn the item
// iRange = the quality of the item: 1=lowest 5=highest
// SockChance = a % chance for the generated item to be socketed
// DamBroke = a switch to disable chance of damaged/broken item: 0=on 1=off
void DropMagicItem(object oSack, int iRange);

// Generates a random potion
// =======================================
// oMob = the creature that just died
// oSack = the object into which you will spawn the potion
void DropPot(object oSack);

// Generates a random misc item (i.e. bag)
// =======================================
// oMob = the creature that just died
// oSack = the object into which you will spawn the misc
void DropMisc(object oSack);

// Generates a random rod or wand
// =======================================
// oMob = the creature that just died
// oSack = the object into which you will spawn the rod or wand
void DropRodWand(object oSack);

// Generates random gold
// ==================================================
// oMob = the creature that just died
// note* the gold amount will be based on the creature's level using the below formula
// Gold = (d20()*Creature LVL)+(15*Creature LVL)+iBonus
// oSack = the object into which you will spawn the ammo
// iBonus = additional gold to be added to the tally
void DropGold(object oMob, object oSack, int iBonus);

// Drop randomly chosen and generated loot & some gold
// ===================================================
// *This is the main call function of the sd lootsystem
// oMob = the creature that just died (the loot dropped is based on their class & level)
// oSack = the object into which you will spawn the loot
void wk_droploot (object oMob, object oSack);

void SetThreatLevel(object oMob)
{                                                // Use this in conjunction with
 int iHD = GetLocalInt(OBJECT_SELF,"BossLoot");  // the wk_spawnboss* functions.
 int iRange = iHD;                               // The wk_spawnboss scripts are
 string sName;                                   // used for tough creatures to
 string cName = GetName(oMob);                   // set a given power level of
                                                 // item drops.  The number at
                                                 // the end of the spawnboss
                                                 // script determines the power
 switch(iRange)                                  // level of the drops.
       {
        case 1: sName = ColorString(cName,255, 255, 255); break;
        case 2: sName = ColorString(cName,189, 183, 107); break;
        case 3: sName = ColorString(cName,218, 165, 32); break;
        case 4: sName = ColorString(cName,210, 105, 30); break;
        case 5: sName = ColorString(cName,255, 0, 0); break;
       }
 if (GetLocalInt(OBJECT_SELF, "BOSS")==1)sName = ColorString(cName,255, 255, 0);
 SetName(oMob, sName);
}

void NameSack(object oSack)
{
 string sName = GetName(OBJECT_SELF);
 sName+= "'s Corpse";
 SetName(oSack, sName);
}

void InvClear (object oMob)
{
 object oItem = GetFirstItemInInventory(oMob);               //Clears all non-plot items
 while (GetIsObjectValid(oItem))                             //from the mob's inventory.
       {                                                     //Does not destroy the mob.
        if (GetPlotFlag(oItem)==FALSE)DestroyObject(oItem);
        oItem = GetNextItemInInventory(oMob);
       }
}

void ClearChest (object oMob)
{
 object oItem = GetFirstItemInInventory(oMob);               //Clears all inventory items
 while (GetIsObjectValid(oItem))                             //from the mob, then destroys
       {                                                     //the mob object itself.
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oMob);
       }
}

void LootClear (object oMob)
{
 object oItem = GetFirstItemInInventory(oMob);               //Clears all inventory items
 while (GetIsObjectValid(oItem))                             //from the mob, then destroys
       {                                                     //the mob object itself.
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oMob);
       }
DestroyObject(oMob);
}

void SackFade(object oHostBody)
{
  object oBones;
  location lLoc = GetLocation(oHostBody);
  SetPlotFlag(oHostBody, FALSE);
  AssignCommand(oHostBody, SetIsDestroyable(TRUE,FALSE,FALSE));
  LootClear(oHostBody);
  if (GetIsDead(oHostBody))DestroyObject(oHostBody, 0.2f);
}

void DropWish(object oSack, int iRange)
{
 string sName = "wish";
 int nDice = d20();
 if (iRange == 3)
 {
   if (nDice < 2) sName = "wish001";
 }
 if (iRange == 4)
 {
   if (nDice < 16) sName = "wish001";
   if (nDice > 18) sName = "ultimatewish";
 }
 else if (iRange == 5)
 {
   if (nDice < 14) sName = "ultimatewish";
   if (nDice > 13) sName = "wish001";
 }
 CreateItemOnObject(sName, oSack, 1);
}

void DropCollChip(object oSack, int iRange)
{
 string sChip = "coll_token00"+IntToString(iRange);
 CreateItemOnObject(sChip, oSack, 1);
}

void DropPot(object oSack)
{
 string sPotion;

 int nRandom = d2();
 switch (nRandom)
        {
         case 1:sPotion = "jehonianelixir";  break;
         case 2:sPotion = "nw_it_mpotion012" ; break;
        }
 CreateItemOnObject(sPotion, oSack, 1);
}

void DropRodWand(object oSack)
{
 string sType;

 int nRandom = d6();
 switch (nRandom)
        {
                       // rods

        case 1: sType = "nw_wmgmrd002";break;  //res
        case 2: sType = "nw_wmgmrd006";break;  //rev
                      // wands

        case 3: sType = "nw_wmgwn011";break;
        case 4: sType = "nw_wmgwn008";break;
        case 5: sType = "nw_wmgwn007";break;
        case 6: sType = "nw_wmgwn009";break;
        }
 CreateItemOnObject(sType, oSack, 1);
}

void CastImbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iSpell;
 int iUses;
 int iRoll;
 switch (iRange)
      {
       case 1: {
                iRoll = d8();
                if (iRoll==1)iSpell = IP_CONST_CASTSPELL_BURNING_HANDS_2;
                if (iRoll==2)iSpell = IP_CONST_CASTSPELL_BARKSKIN_3;
                if (iRoll==3)iSpell = IP_CONST_CASTSPELL_MAGE_ARMOR_2;
                if (iRoll==4)iSpell = IP_CONST_CASTSPELL_MAGIC_MISSILE_5;
                if (iRoll==5)iSpell = IP_CONST_CASTSPELL_COLOR_SPRAY_2;
                if (iRoll==6)iSpell = IP_CONST_CASTSPELL_DOOM_5;
                if (iRoll==7)iSpell = IP_CONST_CASTSPELL_ENTANGLE_5;
                if (iRoll==8)iSpell = IP_CONST_CASTSPELL_GHOSTLY_VISAGE_3;
               }break;
       case 2: {
                iRoll = d8();
                if (iRoll==1)iSpell = IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_12;
                if (iRoll==2)iSpell = IP_CONST_CASTSPELL_FIREBALL_10;
                if (iRoll==3)iSpell = IP_CONST_CASTSPELL_HEAL_11;
                if (iRoll==4)iSpell = IP_CONST_CASTSPELL_SLAY_LIVING_9;
                if (iRoll==5)iSpell = IP_CONST_CASTSPELL_STONESKIN_7;
                if (iRoll==6)iSpell = IP_CONST_CASTSPELL_ICE_STORM_9;
                if (iRoll==7)iSpell = IP_CONST_CASTSPELL_CALL_LIGHTNING_10;
                if (iRoll==8)iSpell = IP_CONST_CASTSPELL_ISAACS_LESSER_MISSILE_STORM_13;
               }break;
       case 3: {
                iRoll = d8();
                if (iRoll==1)iSpell = IP_CONST_CASTSPELL_SUNBEAM_13;
                if (iRoll==2)iSpell = IP_CONST_CASTSPELL_CONE_OF_COLD_15;
                if (iRoll==3)iSpell = IP_CONST_CASTSPELL_MASS_HEAL_15;
                if (iRoll==4)iSpell = IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_5;
                if (iRoll==5)iSpell = IP_CONST_CASTSPELL_GREATER_DISPELLING_15;
                if (iRoll==6)iSpell = IP_CONST_CASTSPELL_ISAACS_GREATER_MISSILE_STORM_15;
                if (iRoll==7)iSpell = IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20;
                if (iRoll==8)iSpell = IP_CONST_CASTSPELL_GREATER_STONESKIN_11;
               }break;
       case 4: {
                iRoll = d12();
                if (iRoll==1)iSpell = IP_CONST_CASTSPELL_BIGBYS_FORCEFUL_HAND_15;
                if (iRoll==2)iSpell = IP_CONST_CASTSPELL_HORRID_WILTING_20;
                if (iRoll==3)iSpell = IP_CONST_CASTSPELL_IMPLOSION_17;
                if (iRoll==4)iSpell = IP_CONST_CASTSPELL_FINGER_OF_DEATH_13;
                if (iRoll==5)iSpell = IP_CONST_CASTSPELL_FIRE_STORM_18;
                if (iRoll==6)iSpell = IP_CONST_CASTSPELL_MORDENKAINENS_DISJUNCTION_17;
                if (iRoll==7)iSpell = IP_CONST_CASTSPELL_METEOR_SWARM_17;
                if (iRoll==8)iSpell = IP_CONST_CASTSPELL_ISAACS_GREATER_MISSILE_STORM_15;
                if (iRoll==9)iSpell = IP_CONST_CASTSPELL_SUNBEAM_13;
                if (iRoll==10)iSpell = IP_CONST_CASTSPELL_CONE_OF_COLD_15;
                if (iRoll==11)iSpell = IP_CONST_CASTSPELL_MASS_HEAL_15;
                if (iRoll==12)iSpell = IP_CONST_CASTSPELL_ETHEREAL_VISAGE_15;
               }break;
       case 5: {
                iRoll = d12();
                if (iRoll==1)iSpell = IP_CONST_CASTSPELL_WAIL_OF_THE_BANSHEE_17;
                if (iRoll==2)iSpell = IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17;
                if (iRoll==3)iSpell = IP_CONST_CASTSPELL_IMPLOSION_17;
                if (iRoll==4)iSpell = IP_CONST_CASTSPELL_ISAACS_GREATER_MISSILE_STORM_15;
                if (iRoll==5)iSpell = IP_CONST_CASTSPELL_HORRID_WILTING_20;
                if (iRoll==6)iSpell = IP_CONST_CASTSPELL_MORDENKAINENS_SWORD_18;
                if (iRoll==7)iSpell = IP_CONST_CASTSPELL_MORDENKAINENS_DISJUNCTION_17;
                if (iRoll==8)iSpell = IP_CONST_CASTSPELL_MASS_HEAL_15;
                if (iRoll==9)iSpell = IP_CONST_CASTSPELL_BIGBYS_FORCEFUL_HAND_15;
                if (iRoll==10)iSpell = IP_CONST_CASTSPELL_HORRID_WILTING_20;
                if (iRoll==11)iSpell = IP_CONST_CASTSPELL_IMPLOSION_17;
                if (iRoll==12)iSpell = IP_CONST_CASTSPELL_INCENDIARY_CLOUD_15;
               }break;

      }


 switch (iRange)
        {
         case 1: {iRoll = d3();
                  if (iRoll==1)iUses = IP_CONST_CASTSPELL_NUMUSES_5_CHARGES_PER_USE;
                  if (iRoll==2)iUses = IP_CONST_CASTSPELL_NUMUSES_4_CHARGES_PER_USE;
                  if (iRoll==3)iUses = IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE;
                  break; }
         case 2: {iRoll = d3();
                  if (iRoll==1)iUses = IP_CONST_CASTSPELL_NUMUSES_4_CHARGES_PER_USE;
                  if (iRoll==2)iUses = IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE;
                  if (iRoll==3)iUses = IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE;
                  break; }
         case 3: {iRoll = d3();
                  if (iRoll==1)iUses = IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE;
                  if (iRoll==2)iUses = IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE;
                  if (iRoll==3)iUses = IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE;
                  break; }
         case 4: {iRoll = d3();
                  if (iRoll==1)iUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
                  if (iRoll==2)iUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
                  if (iRoll==3)iUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
                  break;}
         case 5: {iRoll = d3();
                  if (iRoll==1)iUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
                  if (iRoll==2)iUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
                  if (iRoll==3)iUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
                  break;}

        }
  ipAdd = ItemPropertyCastSpell(iSpell, iUses);
  IPSafeAddItemProperty(oItem, ipAdd);
  if (iUses != IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE)
   {
    if (iRange <= 3)
     {
      iRoll = (d12() * iRange)+1; if (iRoll>50)iRoll=50;
      SetItemCharges(oItem, iRoll);
     }
   }
}


void SpellSlot(object oItem, int iRange, int iNum)
{
 itemproperty ipAdd;
 itemproperty ipClass;
 int iLvl, i;
 int iClass;
 int iSpec;
 int iRoll;
 iRoll = d8();
 switch (iRoll)
      {
       case 1: {
                iClass = IP_CONST_CLASS_BARD; iSpec = 1;
                ipClass = ItemPropertyLimitUseByClass(IP_CONST_CLASS_BARD);
                } break;
       case 2: {
                iClass = IP_CONST_CLASS_DRUID;
                ipClass = ItemPropertyLimitUseByClass(IP_CONST_CLASS_DRUID);
                } break;
       case 3: {
                iClass = IP_CONST_CLASS_SORCERER;
                ipClass = ItemPropertyLimitUseByClass(IP_CONST_CLASS_SORCERER);
                } break;
       case 4: {
                iClass = IP_CONST_CLASS_WIZARD;
                ipClass = ItemPropertyLimitUseByClass(IP_CONST_CLASS_WIZARD);
                } break;
       case 5: {
                iClass = IP_CONST_CLASS_PALADIN; iSpec = 2;
                ipClass = ItemPropertyLimitUseByClass(IP_CONST_CLASS_PALADIN);
                } break;
       case 6: {
                iClass = IP_CONST_CLASS_RANGER; iSpec = 2;
                ipClass = ItemPropertyLimitUseByClass(IP_CONST_CLASS_RANGER);
                } break;
       case 7: {
                iClass = IP_CONST_CLASS_CLERIC;
                ipClass = ItemPropertyLimitUseByClass(IP_CONST_CLASS_CLERIC);
                } break;
       case 8: {
                iClass = IP_CONST_CLASS_WIZARD;
                ipClass = ItemPropertyLimitUseByClass(IP_CONST_CLASS_WIZARD);
                } break;
      }

 for (i = 0; i < iNum; i++)
     {
      if (iSpec==1)
         {
          switch (iRange)  // Bard max lvl 6
                 {
                  case 1: iLvl = d2(); break;                       // 1-2
                  case 2: iLvl = d3(); break;                       // 1-3
                  case 3: iLvl = d2()+2; break;                     // 3-4
                  case 4: iLvl = d3()+2; break;                     // 3-5
                  case 5: iLvl = d3()+3; break;                     // 4-6
                 }
         }
      else if (iSpec==2)
         {
          switch (iRange)  // Pally & Ranger max lvl 4
                 {
                  case 1: iLvl = 1; break;                            // 1
                  case 2: iLvl = d2(); break;                         // 1-2
                  case 3: iLvl = d3(); break;                         // 1-3
                  case 4: iLvl = d3()+1; break;                       // 2-4
                  case 5: iLvl = d2()+2; break;                       // 3-4
                 }
        }
     else
        {
         switch (iRange)  // The rest max lvl 9
                {
                 case 1: iLvl = d4(); break;                      // 1-4
                 case 2: iLvl = d6(); break;                      // 1-6
                 case 3: iLvl = d6()+1; break;                    // 2-7
                 case 4: iLvl = d6()+3; break;                    // 4-9
                 case 5: iLvl = d3()+6; break;                    // 7-9
                }
        }
    ipAdd = ItemPropertyBonusLevelSpell(iClass, iLvl);
    AddItemProperty(DURATION_TYPE_PERMANENT, ipAdd, oItem);
   }
 IPSafeAddItemProperty(oItem, ipClass);
}

void MightyEnhance(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iEnh = d4();

 switch (iRange)
      {
       case 1: iEnh+=0; break;                       // 1-4
       case 2: iEnh+=2; break;                       // 3-6
       case 3: iEnh+=4; break;                       // 5-8
       case 4: iEnh+=6; break;                       // 7-10
       case 5: iEnh+=8; break;                       // 9-12
      }
 ipAdd = ItemPropertyMaxRangeStrengthMod(iEnh);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void BowEnhance(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iEnh = d3();

 switch (iRange)
      {
       case 1: iEnh+=0; break;                       // 1-3
       case 2: iEnh+=2; break;                       // 3-5
       case 3: iEnh+=4; break;                       // 5-7
       case 4: iEnh+=6; break;                       // 7-9
       case 5: iEnh+=8; break;                       // 9-11
      }
 ipAdd = ItemPropertyAttackBonus(iEnh);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void AmmoUnlim(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iType;
 int iDam;
 int iRoll = d12();
 switch (iRange)
        {
         case 1:
                {
                 iRoll = d3();
                 if (iRoll==1)iType = IP_CONST_UNLIMITEDAMMO_PLUS2;
                 if (iRoll==2)iType = IP_CONST_UNLIMITEDAMMO_PLUS2;
                 if (iRoll==3)iType = IP_CONST_UNLIMITEDAMMO_PLUS3;
                }break;
         case 2: {
                 iRoll = d4();
                 if (iRoll==1)iType = IP_CONST_UNLIMITEDAMMO_PLUS3;
                 if (iRoll==2)iType = IP_CONST_UNLIMITEDAMMO_PLUS4;
                 if (iRoll==3)iType = IP_CONST_UNLIMITEDAMMO_1D6COLD;
                 if (iRoll==4)iType = IP_CONST_UNLIMITEDAMMO_1D6LIGHT;
                }break;
         case 3: {
                 iRoll = d6();
                 if (iRoll==1)iType = IP_CONST_UNLIMITEDAMMO_PLUS3;
                 if (iRoll==2)iType = IP_CONST_UNLIMITEDAMMO_PLUS4;
                 if (iRoll==3)iType = IP_CONST_UNLIMITEDAMMO_PLUS5;
                 if (iRoll==4)iType = IP_CONST_UNLIMITEDAMMO_1D6FIRE;
                 if (iRoll==5)iType = IP_CONST_UNLIMITEDAMMO_1D6COLD;
                 if (iRoll==6)iType = IP_CONST_UNLIMITEDAMMO_1D6LIGHT;
                }break;
         case 4: {
                 iRoll = d6();
                 if (iRoll==1)iType = IP_CONST_UNLIMITEDAMMO_PLUS4;
                 if (iRoll==2)iType = IP_CONST_UNLIMITEDAMMO_PLUS4;
                 if (iRoll==3)iType = IP_CONST_UNLIMITEDAMMO_PLUS5;
                 if (iRoll==4)iType = IP_CONST_UNLIMITEDAMMO_1D6FIRE;
                 if (iRoll==5)iType = IP_CONST_UNLIMITEDAMMO_1D6COLD;
                 if (iRoll==6)iType = IP_CONST_UNLIMITEDAMMO_1D6LIGHT;
                }break;
         case 5: {
                 iRoll = d4();
                 if (iRoll==1)iType = IP_CONST_UNLIMITEDAMMO_PLUS5;
                 if (iRoll==2)iType = IP_CONST_UNLIMITEDAMMO_1D6FIRE;
                 if (iRoll==3)iType = IP_CONST_UNLIMITEDAMMO_1D6COLD;
                 if (iRoll==4)iType = IP_CONST_UNLIMITEDAMMO_1D6LIGHT;
                }break;
        }
ipAdd = ItemPropertyUnlimitedAmmo(iType);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void AmmoEnhance(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iType;
 int iDam;
 int iRoll = d12();
 switch (iRoll)
        {
         case 1: iType = IP_CONST_DAMAGETYPE_ACID; break;
         case 2: iType = IP_CONST_DAMAGETYPE_BLUDGEONING; break;
         case 3: iType = IP_CONST_DAMAGETYPE_COLD; break;
         case 4: iType = IP_CONST_DAMAGETYPE_ELECTRICAL; break;
         case 5: iType = IP_CONST_DAMAGETYPE_FIRE; break;
         case 6: iType = IP_CONST_DAMAGETYPE_MAGICAL; break;
         case 7: iType = IP_CONST_DAMAGETYPE_NEGATIVE; break;
         case 8: iType = IP_CONST_DAMAGETYPE_DIVINE; break;
         case 9: iType = IP_CONST_DAMAGETYPE_PIERCING; break;
         case 10: iType = IP_CONST_DAMAGETYPE_POSITIVE; break;
         case 11: iType = IP_CONST_DAMAGETYPE_SLASHING; break;
         case 12: iType = IP_CONST_DAMAGETYPE_SONIC; break;
        }
 switch (iRange)
        {
         case 1: iDam = IP_CONST_DAMAGEBONUS_2; break;
         case 2: {
                iRoll = d4();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_1d4;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d6;
               }break;
         case 3: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
               }break;
         case 4: {
                iRoll = d8();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d10;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==7)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==8)iDam = IP_CONST_DAMAGEBONUS_1d12;
               }break;
         case 5: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_1d12;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d12;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_2d12;
               }break;
      }
 ipAdd = ItemPropertyDamageBonus(iType, iDam);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void WeapEnhance(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iEnh = d3();

 switch (iRange)
      {
       case 1: iEnh+=0; break;                       // 1-3
       case 2: iEnh+=2; break;                       // 3-5
       case 3: iEnh+=4; break;                       // 5-7
       case 4: iEnh+=6; break;                       // 7-9
       case 5: iEnh+=8; break;                       // 9-11
      }
 ipAdd = ItemPropertyEnhancementBonus(iEnh);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void RangedImbue(object oItem)
{
 itemproperty ipAdd;
 int iType;
 int iRoll = d3();

 switch (iRoll)
      {
       case 1: if (iRoll==1)iType=IP_CONST_DAMAGETYPE_BLUDGEONING; break;
       case 2: if (iRoll==2)iType=IP_CONST_DAMAGETYPE_SLASHING; break;
       case 3: if (iRoll==3)iType=IP_CONST_DAMAGETYPE_PIERCING; break;
      }
 ipAdd = ItemPropertyExtraRangeDamageType(iType);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void MeleeImbue(object oItem)
{
 itemproperty ipAdd;
 int iType;
 int iRoll = d3();

 switch (iRoll)
      {
       case 1: if (iRoll==1)iType=IP_CONST_DAMAGETYPE_BLUDGEONING; break;
       case 2: if (iRoll==2)iType=IP_CONST_DAMAGETYPE_SLASHING; break;
       case 3: if (iRoll==3)iType=IP_CONST_DAMAGETYPE_PIERCING; break;
      }
 ipAdd = ItemPropertyExtraMeleeDamageType(iType);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void MCimbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iDam;
 int iCol;
 int iType;
 int iRoll;

 switch (iRange)
        {
         case 1: iDam = IP_CONST_DAMAGEBONUS_5; break;
         case 2: {
                iRoll = d4();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d6;
               }break;
         case 3: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
               }break;
         case 4: {
                iRoll = d8();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d10;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==7)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==8)iDam = IP_CONST_DAMAGEBONUS_1d12;
               }break;
         case 5: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_1d12;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d12;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_2d12;
               }break;
        }
 ipAdd = ItemPropertyMassiveCritical(iDam);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void DAMimbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 itemproperty ipVis;
 int iDam;
 int iCol;
 int iType;
 int iRoll = Random(5)+1;
 switch (iRoll)
      {
       case 1: {iType = IP_CONST_DAMAGETYPE_ACID; iCol=4;} break;
       case 2: {iType = IP_CONST_DAMAGETYPE_COLD; iCol=2;}break;
       case 3: {iType = IP_CONST_DAMAGETYPE_ELECTRICAL; iCol=5;}break;
       case 4: {iType = IP_CONST_DAMAGETYPE_FIRE; iCol=3;}break;
       case 5: {iType = IP_CONST_DAMAGETYPE_SONIC; iCol=7;}break;
      }
 switch (iRange)
        {
         case 1: iDam = IP_CONST_DAMAGEBONUS_5; break;
         case 2: {
                iRoll = d4();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d6;
               }break;
         case 3: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
               }break;
         case 4: {
                iRoll = d8();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d10;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_1d12;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==7)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==8)iDam = 25;
               }break;
         case 5: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_1d12;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d12;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d12;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_2d12;
               }break;
        }
 ipAdd = ItemPropertyDamageBonus(iType, iDam);
 IPSafeAddItemProperty(oItem, ipAdd);

 //ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_EVIL);
 //IPSafeAddItemProperty(oItem, ipAdd);

 switch(iCol)
       {
        case 2: ipVis = ItemPropertyVisualEffect(ITEM_VISUAL_COLD); break;
        case 3: ipVis = ItemPropertyVisualEffect(ITEM_VISUAL_FIRE); break;
        case 4: ipVis = ItemPropertyVisualEffect(ITEM_VISUAL_ACID); break;
        case 5: ipVis = ItemPropertyVisualEffect(ITEM_VISUAL_ELECTRICAL); break;
        case 7: ipVis = ItemPropertyVisualEffect(ITEM_VISUAL_SONIC); break;
       }
 AddItemProperty(DURATION_TYPE_PERMANENT, ipVis, oItem);
}

void DAMimbue2(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iDam;
 int iType;
 int iRoll = d4();
 switch (iRoll)
      {
       case 1: {iType = IP_CONST_DAMAGETYPE_MAGICAL; }break;
       case 2: {iType = IP_CONST_DAMAGETYPE_NEGATIVE; }break;
       case 3: {iType = IP_CONST_DAMAGETYPE_DIVINE; }break;
       case 4: {iType = IP_CONST_DAMAGETYPE_POSITIVE; }break;
      }
 switch (iRange)
        {
         case 1: iDam = IP_CONST_DAMAGEBONUS_5; break;
         case 2: {
                iRoll = d4();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d6;
               }break;
         case 3: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
               }break;
         case 4: {
                iRoll = d8();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d10;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==7)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==8)iDam = IP_CONST_DAMAGEBONUS_1d12;
               }break;
         case 5: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_1d12;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d12;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d12;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_2d12;
               }break;
        }
 ipAdd = ItemPropertyDamageBonus(iType, iDam);
 IPSafeAddItemProperty(oItem, ipAdd);

}

void DAMimbue3(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iDam;
 int iType;
 int iRoll = d3();
 switch (iRoll)
      {
       case 1: {iType = IP_CONST_DAMAGETYPE_BLUDGEONING; } break;
       case 2: {iType = IP_CONST_DAMAGETYPE_PIERCING; } break;
       case 3: {iType = IP_CONST_DAMAGETYPE_SLASHING; } break;
      }
 switch (iRange)
        {
         case 1: iDam = IP_CONST_DAMAGEBONUS_5; break;
         case 2: {
                iRoll = d4();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d6;
               }break;
         case 3: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d4;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d6;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
               }break;
         case 4: {
                iRoll = d8();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2d6;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d8;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d8;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d10;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
                if (iRoll==7)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==8)iDam = IP_CONST_DAMAGEBONUS_1d12;
               }break;
         case 5: {
                iRoll = d6();
                if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_1d12;
                if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_10;
                if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_2d12;
                if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_2d12;
                if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_2d10;
                if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_2d12;
               }break;
        }
 ipAdd = ItemPropertyDamageBonus(iType, iDam);
 IPSafeAddItemProperty(oItem, ipAdd);

}

void ACmisc(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iEnh = d4();

 switch (iRange)
      {
       case 1: iEnh+=0; break;                       // 1-4
       case 2: iEnh+=1; break;                       // 2-5
       case 3: iEnh+=2; break;                       // 3-6
       case 4: iEnh+=3; break;                       // 4-7
       case 5: iEnh+=4; break;                       // 5-8
      }
 ipAdd = ItemPropertyACBonus(iEnh);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void MIMMimbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iType;
 int iRoll;
 switch (iRange)
      {
       case 1: {}; break;
       case 2: {
                iRoll = d4();
                if (iRoll==1)iType = IP_CONST_IMMUNITYMISC_POISON;
                if (iRoll==2)iType = IP_CONST_IMMUNITYMISC_DISEASE;
                if (iRoll==3)iType = IP_CONST_IMMUNITYMISC_FEAR;
                if (iRoll==4)iType = IP_CONST_IMMUNITYMISC_PARALYSIS;
               }; break;
       case 3: {
                iRoll = d6();
                if (iRoll==1)iType = IP_CONST_IMMUNITYMISC_POISON;
                if (iRoll==2)iType = IP_CONST_IMMUNITYMISC_DISEASE;
                if (iRoll==3)iType = IP_CONST_IMMUNITYMISC_FEAR;
                if (iRoll==4)iType = IP_CONST_IMMUNITYMISC_PARALYSIS;
                if (iRoll==5)iType = IP_CONST_IMMUNITYMISC_KNOCKDOWN;
                if (iRoll==6)iType = IP_CONST_IMMUNITYMISC_BACKSTAB;
               }; break;
       case 4: {
                iRoll = d10();
                if (iRoll==1)iType = IP_CONST_IMMUNITYMISC_POISON;
                if (iRoll==2)iType = IP_CONST_IMMUNITYMISC_DISEASE;
                if (iRoll==3)iType = IP_CONST_IMMUNITYMISC_FEAR;
                if (iRoll==4)iType = IP_CONST_IMMUNITYMISC_PARALYSIS;
                if (iRoll==5)iType = IP_CONST_IMMUNITYMISC_DEATH_MAGIC;
                if (iRoll==6)iType = IP_CONST_IMMUNITYMISC_CRITICAL_HITS;
                if (iRoll==7)iType = IP_CONST_IMMUNITYMISC_KNOCKDOWN;
                if (iRoll==8)iType = IP_CONST_IMMUNITYMISC_MINDSPELLS;
                if (iRoll==9)iType = IP_CONST_IMMUNITYMISC_BACKSTAB;
                if (iRoll==10)iType = IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN;
               }; break;
       case 5: {
                iRoll = d10();
                if (iRoll==1)iType = IP_CONST_IMMUNITYMISC_BACKSTAB;
                if (iRoll==2)iType = IP_CONST_IMMUNITYMISC_DEATH_MAGIC;
                if (iRoll==3)iType = IP_CONST_IMMUNITYMISC_KNOCKDOWN;
                if (iRoll==4)iType = IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN;
                if (iRoll==5)iType = IP_CONST_IMMUNITYMISC_DEATH_MAGIC;
                if (iRoll==6)iType = IP_CONST_IMMUNITYMISC_MINDSPELLS;
                if (iRoll==7)iType = IP_CONST_IMMUNITYMISC_POISON;
                if (iRoll==8)iType = IP_CONST_IMMUNITYMISC_DISEASE;
                if (iRoll==9)iType = IP_CONST_IMMUNITYMISC_FEAR;
                if (iRoll==10)iType = IP_CONST_IMMUNITYMISC_PARALYSIS;
               }; break;
      }
 ipAdd = ItemPropertyImmunityMisc(iType);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void AbilityImbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iAbil;
 int iType;
 int iRoll = d6();
 switch (iRoll)
      {
       case 1: iType = ABILITY_DEXTERITY; break;
       case 2: iType = ABILITY_CONSTITUTION; break;
       case 3: iType = ABILITY_STRENGTH; break;
       case 4: iType = ABILITY_CHARISMA; break;
       case 5: iType = ABILITY_INTELLIGENCE; break;
       case 6: iType = ABILITY_WISDOM; break;
      }

  switch (iRange)
      {
       case 1: {iAbil = d2(); break;}                             // 1-2
       case 2: {iAbil = d2()+1; break;}                           // 2-3
       case 3: {iAbil = d3()+2; break;}                           // 3-5
       case 4: {iAbil = d3()+3; break;}                           // 4-6
       case 5: {iAbil = d4()+4; break;}                           // 5-8
      }
 ipAdd = ItemPropertyAbilityBonus(iType, iAbil);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void BodyAbilityImbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iAbil;
 int iType;
 int iRoll = d3();
 switch (iRoll)
      {
       case 1: iType = ABILITY_DEXTERITY; break;
       case 2: iType = ABILITY_CONSTITUTION; break;
       case 3: iType = ABILITY_STRENGTH; break;
      }

  switch (iRange)
      {
       case 1: {iAbil = d2(); break;}                             // 1-2
       case 2: {iAbil = d2()+1; break;}                           // 2-3
       case 3: {iAbil = d3()+2; break;}                           // 3-5
       case 4: {iAbil = d3()+3; break;}                           // 4-6
       case 5: {iAbil = d4()+4; break;}                           // 5-8
      }
 ipAdd = ItemPropertyAbilityBonus(iType, iAbil);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void MindAbilityImbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iAbil;
 int iType;
 int iRoll = d3();
 switch (iRoll)
      {
       case 1: iType = ABILITY_CHARISMA; break;
       case 2: iType = ABILITY_INTELLIGENCE; break;
       case 3: iType = ABILITY_WISDOM; break;
      }

  switch (iRange)
      {
       case 1: {iAbil = d2(); break;}                             // 1-2
       case 2: {iAbil = d2()+1; break;}                           // 2-3
       case 3: {iAbil = d3()+2; break;}                           // 3-5
       case 4: {iAbil = d3()+3; break;}                           // 4-6
       case 5: {iAbil = d4()+4; break;}                           // 5-8
      }
 ipAdd = ItemPropertyAbilityBonus(iType, iAbil);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void MiscImbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iRoll;
 switch (iRange)
      {
       case 1: {}; break;
       case 2: {
                iRoll = d3();
                if (iRoll==1)ipAdd = ItemPropertyDarkvision();
                if (iRoll==2)ipAdd = ItemPropertyRegeneration(d4());
                if (iRoll==3)ipAdd = ItemPropertyBonusSavingThrow(IP_CONST_SAVEVS_UNIVERSAL, 2);
               }; break;
       case 3: {
                iRoll = d4();
                if (iRoll==1)ipAdd = ItemPropertyVampiricRegeneration(d3());
                if (iRoll==2)ipAdd = ItemPropertyBonusSavingThrow(IP_CONST_SAVEVS_UNIVERSAL, 3);
                if (iRoll==3)ipAdd = ItemPropertyRegeneration(d4()+1);
                if (iRoll==4)ipAdd = ItemPropertyDarkvision();
               }; break;
       case 4: {
                iRoll = d4();
                if (iRoll==3)ipAdd = ItemPropertyVampiricRegeneration(d4()+1);
                if (iRoll==4)ipAdd = ItemPropertyBonusSavingThrow(IP_CONST_SAVEVS_UNIVERSAL, 4);
                if (iRoll==1)ipAdd = ItemPropertyRegeneration(d4()+2);
                if (iRoll==2)ipAdd = ItemPropertyTrueSeeing();
                }; break;
       case 5: {
                iRoll = d4();
                if (iRoll==3)ipAdd = ItemPropertyVampiricRegeneration(d6()+4);
                if (iRoll==4)ipAdd = ItemPropertyBonusSavingThrow(IP_CONST_SAVEVS_UNIVERSAL, 5);
                if (iRoll==1)ipAdd = ItemPropertyRegeneration(d6()+4);
                if (iRoll==2)ipAdd = ItemPropertyTrueSeeing();
                }; break;
      }
 IPSafeAddItemProperty(oItem, ipAdd);
}

void SaveImbue(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iAbil;
 int iType;
 int iRoll = d6();
 switch (iRoll)
      {
       case 1: iType = IP_CONST_SAVEBASETYPE_FORTITUDE; break;
       case 2: iType = IP_CONST_SAVEBASETYPE_REFLEX; break;
       case 3: iType = IP_CONST_SAVEBASETYPE_WILL; break;
       case 4: iType = IP_CONST_SAVEBASETYPE_FORTITUDE; break;
       case 5: iType = IP_CONST_SAVEBASETYPE_REFLEX; break;
       case 6: iType = IP_CONST_SAVEBASETYPE_WILL; break;
      }

 switch (iRange)
      {
       case 1: {iAbil = d3();  if (iAbil==3)iAbil=1; break;}  // 1-2
       case 2: {iAbil = d3()+1;if (iAbil==4)iAbil=2; break;}  // 2-3
       case 3: {iAbil = d3()+2;if (iAbil==5)iAbil=3; break;}  // 3-4
       case 4: {iAbil = d3()+3;if (iAbil==6)iAbil=4; break;}  // 4-5
       case 5: {iAbil = d3()+4;if (iAbil==7)iAbil=5; break;}  // 5-6
      }
 ipAdd = ItemPropertyBonusSavingThrow(iType, iAbil);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void ImpEvasionImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyImprovedEvasion();
IPSafeAddItemProperty(oItem, ipAdd);
}

void TruseeingImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyTrueSeeing();
IPSafeAddItemProperty(oItem, ipAdd);
}

void DarkvisionImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyDarkvision();
IPSafeAddItemProperty(oItem, ipAdd);
}

void VisionImbue(object oItem)
{
  int iRoll = d2();
  switch(iRoll)
  {
    case 1: {DarkvisionImbue(oItem);} break;
    case 2: {TruseeingImbue(oItem);} break;
  }
}

void FreedomImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyFreeAction();
IPSafeAddItemProperty(oItem, ipAdd);
}

void RegenImbue(object oItem, int iRange)
{
int iRegen;
itemproperty ipAdd;
switch (iRange)
      {
       case 1: iRegen = d3(); break;                             //1-3
       case 2: iRegen = d3()+1; break;                           //2-4
       case 3: iRegen = d3()+2; break;                           //3-5
       case 4: iRegen = d3()+3; break;                           //4-6
       case 5: iRegen = d4()+4; break;                           //5-8
      }
ipAdd = ItemPropertyRegeneration(iRegen);
IPSafeAddItemProperty(oItem, ipAdd);
}

void VRimbue(object oItem, int iRange)
{
int iRegen;
itemproperty ipAdd;
switch (iRange)
      {
       case 1: iRegen = d3(); break;                            //1-3
       case 2: iRegen = d4()+2; break;                          //3-6
       case 3: iRegen = d6()+4; break;                          //5-10
       case 4: iRegen = d8()+6; break;                          //7-14
       case 5: iRegen = d10()+10;break;                         //11-20
      }
ipAdd = ItemPropertyVampiricRegeneration(iRegen);
IPSafeAddItemProperty(oItem, ipAdd);
}

void EvilImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_EVIL);
IPSafeAddItemProperty(oItem, ipAdd);
}

void HolyImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_HOLY);
IPSafeAddItemProperty(oItem, ipAdd);
}

void FireImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_FIRE);
IPSafeAddItemProperty(oItem, ipAdd);
}

void ElecImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_ELECTRICAL);
IPSafeAddItemProperty(oItem, ipAdd);
}

void AcidImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyVisualEffect(ITEM_VISUAL_ACID);
IPSafeAddItemProperty(oItem, ipAdd);
}


void HasteImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyHaste();
IPSafeAddItemProperty(oItem, ipAdd);
}

void KeenImbue(object oItem)
{
itemproperty ipAdd;
ipAdd = ItemPropertyKeen();
IPSafeAddItemProperty(oItem, ipAdd);
}

void DropShield (object oSack, int iRange)
{
 object oItem;
 itemproperty ipAdd;
 string sType, sName, sIName;
 int iQual = 0;
 int iRoll = d20();
 switch(iRoll)
       {
        // Shields
        case 1: {sType = "nw_ashsw001";   sIName = "Targe";} break;
        case 2: {sType = "nw_ashmsw006";  sIName = "Shield";} break;
        case 3: {sType = "nw_ashmsw011";  sIName = "Buckler";} break;
        case 4: {sType = "nw_ashmsw005";  sIName = "Shield";} break;
        case 5: {sType = "nw_ashlw001";   sIName = "Shield";} break;
        case 6: {sType = "x2_adrowshl001"; sIName = "Defense";} break;
        case 7: {sType = "x2_it_iwoodshldl"; sIName = "Defender";} break;
        case 8: {sType = "nw_ashmlw006";  sIName = "Shield";} break;
        case 9: {sType = "nw_ashmto003";  sIName = "Wall";} break;
        case 10: {sType = "nw_ashto001";  sIName = "Tower";} break;
        case 11: {sType = "nw_ashmto010"; sIName = "Shield";} break;
        case 12: {sType = "nw_ashmto006"; sIName = "Shield";} break;
        // Helms
        case 13: {sType = "x2_ardrowhe001";  sIName = "Helm";} break;
        case 14: {sType = "x2_arduerhe001";  sIName = "Cover";} break;
        case 15: {sType = "x2_it_arhelm03";  sIName = "Helm";} break;
        case 16: {sType = "nw_arhe004";      sIName = "Defense";} break;
        case 17: {sType = "x2_it_arhelm01";  sIName = "Helm";} break;
        case 18: {sType = "nw_arhe002";      sIName = "Helm";} break;
        case 19: {sType = "nw_arhe001";  sIName = "Helm";} break;
        case 20: {sType = "nw_arhe003";  sIName = "Helm";} break;
       }
  oItem = CreateItemOnObject(sType, oSack, 1, "shielddrop");
  IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
  SetIdentified(oItem, TRUE);
  SetStolenFlag(oItem, TRUE);
 //////////////////////////////////////////// Lvls 1-5

 // Ac bonus


 DelayCommand(0.2, ACmisc(oItem, iRange));
 ++iQual;

 ////////////////////////////////////////// Lvls 6-10

  if (iRange == 1 || iRange == 2)
  {
     // Ability bonus
     iRoll = Random(iRange+1) + 1;
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, AbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, AbilityImbue(oItem, iRange));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 11-20

  if (iRange==3)
  {
     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, AbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, AbilityImbue(oItem, iRange));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, RegenImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, HasteImbue(oItem));++iQual;} break;
        case 3: {DelayCommand(0.2, RegenImbue(oItem, iRange));
                 DelayCommand(0.2, HasteImbue(oItem)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 20-30

  if (iRange==4)
  {
     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, BodyAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));
                 DelayCommand(0.2, BodyAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, FreedomImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, FreedomImbue(oItem));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, RegenImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, HasteImbue(oItem));++iQual;} break;
        case 3: {DelayCommand(0.2, RegenImbue(oItem, iRange));
                 DelayCommand(0.2, HasteImbue(oItem)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 30-40

  if (iRange==5)
  {
     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, BodyAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));
                 DelayCommand(0.2, BodyAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, FreedomImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, FreedomImbue(oItem));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, RegenImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, HasteImbue(oItem));++iQual;} break;
        case 3: {DelayCommand(0.2, RegenImbue(oItem, iRange));
                 DelayCommand(0.2, HasteImbue(oItem)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        // Shields
        case 1: {DelayCommand(0.2, VisionImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, VisionImbue(oItem));
                 DelayCommand(0.2, CastImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }
  sName = GetColorName(iQual, sIName);
  SetName(oItem, sName);
}

void DropMagicItem (object oSack, int iRange)
{
 string sType, sName, sIName;
 object oItem;
 itemproperty ipAdd;
 int iID = 0;
 int iQual = 0;
 int iRoll = Random(30)+1;
 switch(iRoll)
       {
        case 1: {sType = "boot_hobnailed";  sIName = "Boots";} break;
        case 2: {sType = "boot_bigbysankle";sIName = "Boots";} break;
        case 3: {sType = "boot_barhain";    sIName = "Boots";}break;
        case 4: {sType = "boot_ironheart";  sIName = "Slippers";} break;
        case 5: {sType = "boot_shadows";    sIName = "Shoes";} break;
        case 6: {sType = "stcl_blood";      sIName = "Cloak";} break;
        case 7: {sType = "stcl_devout";     sIName = "Cloak";} break;
        case 8: {sType = "stcl_pride";      sIName = "Mantle";} break;
        case 9: {sType = "stcl_simple";     sIName = "Cloak";} break;
        case 10: {sType = "stcl_bearskin";  sIName = "Shawl";} break;
        case 11: {sType = "ammy_midnight";  sIName = "Amulet";} break;
        case 12: {sType = "ammy_starlight"; sIName = "Necklace";} break;
        case 13: {sType = "ammy_moonlight"; sIName = "Choker";} break;
        case 14: {sType = "ammy_dawn";      sIName = "Talisman";} break;
        case 15: {sType = "ammy_dusk";      sIName = "Charm";} break;
        case 16: {sType = "brac_warrior";   sIName = "Bracer";} break;
        case 17: {sType = "brac_mage";      sIName = "Greaves";} break;
        case 18: {sType = "brac_rogue";     sIName = "Armband";} break;
        case 19: {sType = "brac_priest";    sIName = "Bracer";} break;
        case 20: {sType = "brac_minstrel";  sIName = "Bracer";} break;
        case 21: {sType = "nw_it_mring021"; sIName = "Ring";} break;
        case 22: {sType = "nw_it_mring022"; sIName = "Ring";} break;
        case 23: {sType = "nw_it_mring023"; sIName = "Ring";} break;
        case 24: {sType = "nw_it_mring022"; sIName = "Ring";} break;
        case 25: {sType = "nw_it_mring021"; sIName = "Ring";} break;
        case 26: {sType = "belt_longroad";  sIName = "Belt";} break;
        case 27: {sType = "belt_weave";     sIName = "Belt";} break;
        case 28: {sType = "belt_woventwigs";sIName = "Wrap";} break;
        case 29: {sType = "belt_cutpurse";  sIName = "Sash";} break;
        case 30: {sType = "belt_faith";     sIName = "Belt";} break;
       }
  if (iRoll <= 15) iID = 1;  // boot, cloak, amulet - AC bonuses and others
  if (iRoll >= 16) iID = 2;  // bracer, ring - chance for spellslot
  if (iRoll >= 26) iID = 0;  // belts

  // chance for socketed item

  oItem = CreateItemOnObject(sType, oSack, 1, "mobdrop");
  IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
  SetIdentified(oItem, TRUE);
  SetStolenFlag(oItem, TRUE);

//////////////////////////////////////////// Everything gets a spell

  DelayCommand(0.2, CastImbue(oItem, iRange));
  ++iQual;

////////////////////////////////////////// Lvls 6-10

  if (iRange==2 || iRange==1)
  {
     iRoll = Random(iRange+1) + 1;
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, AbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, AbilityImbue(oItem, iRange));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
     if (iID==2)
     {
        // Spell Slot
        iRoll = d3();
        if (iRoll<=iRange)
        {
           iRoll=d2();   // 1-2 slots
           DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll));
           iQual++;
        }
     }
  }

////////////////////////////////////////// Lvls 11-20

  if (iRange==3)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, AbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, RegenImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, AbilityImbue(oItem, iRange));
                 DelayCommand(0.2, RegenImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MIMMimbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, SaveImbue(oItem, iRange));
                 DelayCommand(0.2, MIMMimbue(oItem, iRange)); iQual=iQual+2;} break;
     }
     if (iID==2)
     {
        // Spell Slot
        iRoll = d4();
        if (iRoll<=iRange)
        {
           iRoll=d3();   // 1-3 slots
           DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll));
           iQual = iQual + (iRoll/2);
        }
     }
  }

////////////////////////////////////////// Lvls 20-30

  if (iRange==4)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, BodyAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));
                 DelayCommand(0.2, BodyAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MIMMimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MIMMimbue(oItem, iRange));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, RegenImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, VisionImbue(oItem));++iQual;} break;
        case 3: {DelayCommand(0.2, RegenImbue(oItem, iRange));
                 DelayCommand(0.2, VisionImbue(oItem)); iQual=iQual+2;} break;
     }

     if (iID==2)
     {
        // Spell Slot
        iRoll = d4();
        if (iRoll<=3)
        {
           iRoll=d3()+1;  // 2-4 slots
           DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll));
           iQual = iQual + (iRoll/2);
        }
     }
  }

////////////////////////////////////////// Lvls 30-40

  if (iRange==5)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, BodyAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));
                 DelayCommand(0.2, BodyAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MIMMimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MIMMimbue(oItem, iRange));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, RegenImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, VisionImbue(oItem));++iQual;} break;
        case 3: {DelayCommand(0.2, RegenImbue(oItem, iRange));
                 DelayCommand(0.2, VisionImbue(oItem)); iQual=iQual+2;} break;
     }

     DelayCommand(0.2, CastImbue(oItem, iRange));
     ++iQual;

     if (iID==2)
     {
        // Spell Slot
        {
           iRoll=d4()+2;  // 3-6 slots
           DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll));
           iQual = iQual + (iRoll/2);
        }
     }
  }

  sName = GetColorName(iQual, sIName);
  SetName(oItem, sName);
}

void DropWeapon (object oSack, int iRange)
{
  object oItem;
  itemproperty ipAdd;
  string sType, sName, sIName, sSocks;
  int iRoll;
  int iQual = 0;
  int iWType = 0;

  iRoll = Random(40);
  switch(iRoll)
       { // Axes
        case 0: {sType = "nw_waxgr001"; iRoll = d3();
                 if (iRoll==1)sIName = "Greataxe";
                 if (iRoll==2)sIName = "Two Handed Axe";
                 if (iRoll==3)sIName = "Decapitator";}
        case 1: {sType = "nw_wthax001"; iRoll = d3();
                 if (iRoll==1)sIName = "Throwing Axe";
                 if (iRoll==2)sIName = "Dwarven Bow";
                 if (iRoll==3)sIName = "Tomahawk";}
        case 2: {sType = "nw_waxbt001"; iRoll = d3();
                 if (iRoll==1)sIName = "Battleaxe";
                 if (iRoll==2)sIName = "Axe";
                 if (iRoll==3)sIName = "Cleaver";}
                 break;         break;
        case 3: {sType = "x2_wdwraxe001"; iRoll = d3();
                 if (iRoll==1)sIName = "Dwarven War Axe";
                 if (iRoll==2)sIName = "War Axe";
                 if (iRoll==3)sIName = "Headsplitter";}
                 break;
        case 4: {sType = "nw_waxbt001"; iRoll = d3();
                 if (iRoll==1)sIName = "Battleaxe";
                 if (iRoll==2)sIName = "Beserker Axe";
                 if (iRoll==3)sIName = "Siege Axe";}
                 break;
        case 5: {sType = "nw_waxhn001"; iRoll = d3();
                 if (iRoll==1)sIName = "Handaxe";
                 if (iRoll==2)sIName = "Cleaver";
                 if (iRoll==3)sIName = "Hatchet";}
                 break;
// Bladed

        case 6: {sType = "nw_wswbs001"; iRoll = d3();
                 if (iRoll==1)sIName = "Bastard Sword";
                 if (iRoll==2)sIName = "Render";
                 if (iRoll==3)sIName = "Cleaver";}
                 break;
        case 7: {sType = "nw_wswls001"; iRoll = d3();
                 if (iRoll==1)sIName = "Longsword";
                 if (iRoll==2)sIName = "Sword";
                 if (iRoll==3)sIName = "Blade";}
                 break;
        case 8: {sType = "nw_wswls001"; iRoll = d3();
                 if (iRoll==1)sIName = "Longsword";
                 if (iRoll==2)sIName = "Sidearm";
                 if (iRoll==3)sIName = "Sword";}
                 break;
        case 9: {sType = "nw_wswss001"; iRoll = d3();
                 if (iRoll==1)sIName = "Short Sword";
                 if (iRoll==2)sIName = "Blade";
                 if (iRoll==3)sIName = "Gladius";}
                 break;
        case 10: {sType = "nw_wswgs001"; iRoll = d3();
                 if (iRoll==1)sIName = "Greatsword";
                 if (iRoll==2)sIName = "Zweihander";
                 if (iRoll==3)sIName = "Claymore";}
                 break;
        case 11: {sType = "nw_wswka001"; iRoll = d3();
                 if (iRoll==1)sIName = "Katana";
                 if (iRoll==2)sIName = "Bond";
                 if (iRoll==3)sIName = "Honor";}
                 break;
        case 12: {sType = "nw_wswsc001"; iRoll = d3();
                 if (iRoll==1)sIName = "Scimitar";
                 if (iRoll==2)sIName = "Faljadu";
                 if (iRoll==3)sIName = "Blade";}
                 break;
        case 13: {sType = "nw_wswrp001"; iRoll = d3();
                 if (iRoll==1)sIName = "Rapier";
                 if (iRoll==2)sIName = "Epee";
                 if (iRoll==3)sIName = "Foil";}
                 break;
        case 14: {sType = "nw_wswdg001"; iRoll = d3();
                 if (iRoll==1)sIName = "Dagger";
                 if (iRoll==2)sIName = "Dirk";
                 if (iRoll==3)sIName = "Knife";}
                 break;
// Exotic

        case 15: {sType = "nw_wdbqs001"; iRoll = d3();
                 if (iRoll==1)sIName = "Staff";
                 if (iRoll==2)sIName = "Stave";
                 if (iRoll==3)sIName = "Cane";}
                 break;
        case 16: {sType = "nw_wspka001"; iRoll = d3();
                 if (iRoll==1)sIName = "Kama";
                 if (iRoll==2)sIName = "Monk Claw";
                 if (iRoll==3)sIName = "Ripper";}
                 break;
        case 17: {sType = "nw_wspku001"; iRoll = d3();
                 if (iRoll==1)sIName = "Kukri";
                 if (iRoll==2)sIName = "Machette";
                 if (iRoll==3)sIName = "Blade";}
                 break;
        case 18: {sType = "nw_wbwln001"; iRoll = d3();
                 iWType = 1;
                 if (iRoll==1)sIName = "Siege Bow";
                 if (iRoll==2)sIName = "Elven War Bow";
                 if (iRoll==3)sIName = "Battle Bow";}
                 break;
// Blunt

        case 19: {sType = "nw_wblcl001"; iRoll = d3();
                 if (iRoll==1)sIName = "Club";
                 if (iRoll==2)sIName = "Club";
                 if (iRoll==3)sIName = "Truncheon";}
                 break;
        case 20: {sType = "nw_wblfh001"; iRoll = d3();
                 if (iRoll==1)sIName = "Heavy Flail";
                 if (iRoll==2)sIName = "Crusher";
                 if (iRoll==3)sIName = "Flail";}
                 break;
        case 21: {sType = "nw_wblfl001"; iRoll = d3();
                 if (iRoll==1)sIName = "Flail";
                 if (iRoll==2)sIName = "Light Flail";
                 if (iRoll==3)sIName = "Head Cracker";}
                 break;
        case 22: {sType = "nw_wblhl001"; iRoll = d3();
                 iWType = 2;
                 if (iRoll==1)sIName = "Hammer";
                 if (iRoll==2)sIName = "Riding Hammer";
                 if (iRoll==3)sIName = "Light Hammer";}
                 break;

        case 23: {sType = "nw_wblhw001"; iRoll = d3();
                 if (iRoll==1)sIName = "Warhammer";
                 if (iRoll==2)sIName = "Mattock";
                 if (iRoll==3)sIName = "Maul";}
                 break;
        case 24: {sType = "nw_wblml001"; iRoll = d3();
                 if (iRoll==1)sIName = "Mace";
                 if (iRoll==2)sIName = "Striker";
                 if (iRoll==3)sIName = "Flange";}
                 break;
        case 25: {sType = "nw_wblms001"; iRoll = d3();
                 if (iRoll==1)sIName = "Morning Star";
                 if (iRoll==2)sIName = "Chain";
                 if (iRoll==3)sIName = "Fist";}
                 break;
//Double Sided

        case 26: {sType = "nw_wdbsw001"; iRoll = d3();
                 if (iRoll==1)sIName = "Doubleblade";
                 if (iRoll==2)sIName = "Doomblade";
                 if (iRoll==3)sIName = "Ginsu";}
                 break;
        case 27: {sType = "nw_wdbma001"; iRoll = d3();
                 if (iRoll==1)sIName = "Double Mace";
                 if (iRoll==2)sIName = "Twin Mace";
                 if (iRoll==3)sIName = "Basher";}
                 break;
        case 28: {sType = "nw_wdbax001"; iRoll = d3();
                 if (iRoll==1)sIName = "Double Axe";
                 if (iRoll==2)sIName = "Crowd Cutter";
                 if (iRoll==3)sIName = "Haymaker";}
                 break;
        case 29: {sType = "nw_wdbqs001"; iRoll = d3();
                 if (iRoll==1)sIName = "Quarterstaff";
                 if (iRoll==2)sIName = "Pole";
                 if (iRoll==3)sIName = "Staff";}
                 break;
// Polearms

        case 30: {sType = "nw_wplhb001"; iRoll = d3();
                 if (iRoll==1)sIName = "Halberd";
                 if (iRoll==2)sIName = "Glaive";
                 if (iRoll==3)sIName = "Poleaxe";}
                 break;
        case 31: {sType = "nw_wplsc001"; iRoll = d3();
                 if (iRoll==1)sIName = "Reaper";
                 if (iRoll==2)sIName = "Reaver";
                 if (iRoll==3)sIName = "Scythe";}
                 break;
        case 32: {sType = "nw_wplss001"; iRoll = d3();
                 if (iRoll==1)sIName = "Spear";
                 if (iRoll==2)sIName = "Pitum";
                 if (iRoll==3)sIName = "Skewer";}
                 break;
// Whip

      case 33: {sType = "x2_it_wpwhip"; iRoll = d3();
                 if (iRoll==1)sIName = "Whip";
                 if (iRoll==2)sIName = "Sting";
                 if (iRoll==3)sIName = "Lash";}
                 break;
// Ranged

        case 34: {sType = "nw_wbwsh001"; iRoll = d3();
                 iWType = 1;
                 if (iRoll==1)sIName = "Halfling War Bow";
                 if (iRoll==2)sIName = "Shortbow";
                 if (iRoll==3)sIName = "Cavalry Bow";}
                 break;
        case 35: {sType = "nw_wbwxl001"; iRoll = d3();
                 iWType = 1;
                 if (iRoll==1)sIName = "Light Crossbow";
                 if (iRoll==2)sIName = "Crossbow";
                 if (iRoll==3)sIName = "Light Crossbow";}
                 break;
        case 36: {sType = "nw_wbwxh001"; iRoll = d3();
                 iWType = 1;
                 if (iRoll==1)sIName = "Battle Crossbow";
                 if (iRoll==2)sIName = "Crossbow";
                 if (iRoll==3)sIName = "Heavy Crossbow";}
                 break;
// Mage

        case 37: {sType = "nw_wbwsl001"; iRoll = d3();
                 iWType = 1;
                 if (iRoll==1)sIName = "Sling";
                 if (iRoll==2)sIName = "Thrower";
                 if (iRoll==3)sIName = "Sling";}
                 break;
        case 38: {sType = "wk_staff001"; iRoll = d3();
                 iWType = 2;
                 if (iRoll==1)sIName = "Mystic Cane";
                 if (iRoll==2)sIName = "Staff Arcane";
                 if (iRoll==3)sIName = "Ivory Staff";}
                 break;
        case 39: {sType = "nw_wspsc001"; iRoll = d3();
                 if (iRoll==1)sIName = "Sickle";
                 if (iRoll==2)sIName = "Harvester";
                 if (iRoll==3)sIName = "Claw";}
                 break;
      }

oItem = CreateItemOnObject(sType, oSack, 1, "weapondrop");

SetName(oItem, sName);

if (iWType==1)
{
iQual=0;


 SetIdentified(oItem, TRUE);
 SetStolenFlag(oItem, TRUE);
////////////////////////////////////////////////////     ::Ranged::

 // Attack bonus

     DelayCommand(0.2, BowEnhance(oItem, iRange));
     ++iQual;
///////////////////////////////////////////////////////////////////////////////
  if (iRange==2)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MCimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MightyEnhance(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MCimbue(oItem, iRange));
                 DelayCommand(0.2, MightyEnhance(oItem, iRange)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 11-20     ::Ranged::

  if (iRange==3)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MCimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MightyEnhance(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MCimbue(oItem, iRange));
                 DelayCommand(0.2, MightyEnhance(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, RangedImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, RangedImbue(oItem));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

  }


////////////////////////////////////////// Lvls 20-30     ::Ranged::

  if (iRange==4)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MCimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MightyEnhance(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MCimbue(oItem, iRange));
                 DelayCommand(0.2, MightyEnhance(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, RangedImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, RangedImbue(oItem));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, BodyAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));
                 DelayCommand(0.2, BodyAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 30-40     ::Ranged::

  if (iRange==5)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MCimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MightyEnhance(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MCimbue(oItem, iRange));
                 DelayCommand(0.2, MightyEnhance(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, RangedImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, RangedImbue(oItem));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, BodyAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));
                 DelayCommand(0.2, BodyAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     DelayCommand(0.2, CastImbue(oItem, iRange));
     ++iQual;

  }
}
else if (iWType==2)
{
// Mage
iQual=0;

//////////////////////////////////////////// Lvls 1-5      ::Mage::

 // Enhancement bonus

     DelayCommand(0.2, WeapEnhance(oItem, iRange));
     ++iQual;

 ////////////////////////////////////////// Lvls 6-10     ::Mage::

  if (iRange==2)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll));++iQual;} break;
        case 3: {DelayCommand(0.2, CastImbue(oItem, iRange));
                 DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 11-20     ::Mage::

  if (iRange==3)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll+1));++iQual;} break;
        case 3: {DelayCommand(0.2, CastImbue(oItem, iRange));
                 DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll+1)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, AbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, CastImbue(oItem, iRange));
                 DelayCommand(0.2, AbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 20-30     ::Mage::

  if (iRange==4)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll+1));++iQual;} break;
        case 3: {DelayCommand(0.2, CastImbue(oItem, iRange));
                 DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll+1)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, AbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, CastImbue(oItem, iRange));
                 DelayCommand(0.2, AbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MeleeImbue(oItem));++iQual;} break;
        case 3: {DelayCommand(0.2, SaveImbue(oItem, iRange));
                 DelayCommand(0.2, MeleeImbue(oItem)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 30-40     ::Mage::

  if (iRange==5)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll+1));++iQual;} break;
        case 3: {DelayCommand(0.2, CastImbue(oItem, iRange));
                 DelayCommand(0.2, SpellSlot(oItem, iRange, iRoll+1)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, BodyAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, CastImbue(oItem, iRange));
                 DelayCommand(0.2, BodyAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MeleeImbue(oItem));++iQual;} break;
        case 3: {DelayCommand(0.2, SaveImbue(oItem, iRange));
                 DelayCommand(0.2, MeleeImbue(oItem)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, CastImbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, CastImbue(oItem, iRange));
                 DelayCommand(0.2, MindAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }
}

else
{
// Melee

     DelayCommand(0.2, WeapEnhance(oItem, iRange));
     ++iQual;

////////////////////////////////////////// Lvls 6-10     ::Melee::

  if (iRange==2)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, DAMimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MCimbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, DAMimbue(oItem, iRange));
                 DelayCommand(0.2, MCimbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 11-20     ::Melee::

  if (iRange==3)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, DAMimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MCimbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, DAMimbue(oItem, iRange));
                 DelayCommand(0.2, MCimbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, KeenImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, AbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, KeenImbue(oItem));
                 DelayCommand(0.2, AbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 20-30     ::Melee::

  if (iRange==4)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, DAMimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MCimbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, DAMimbue(oItem, iRange));
                 DelayCommand(0.2, MCimbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, KeenImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, AbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, KeenImbue(oItem));
                 DelayCommand(0.2, AbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, DAMimbue2(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, DAMimbue2(oItem, iRange));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }

////////////////////////////////////////// Lvls 30-40     ::Melee::

  if (iRange==5)
  {
     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, DAMimbue(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MCimbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, DAMimbue(oItem, iRange));
                 DelayCommand(0.2, MCimbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, KeenImbue(oItem));++iQual;} break;
        case 2: {DelayCommand(0.2, BodyAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, KeenImbue(oItem));
                 DelayCommand(0.2, BodyAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, DAMimbue2(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, SaveImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, DAMimbue2(oItem, iRange));
                 DelayCommand(0.2, SaveImbue(oItem, iRange)); iQual=iQual+2;} break;
     }

     iRoll = d3();
     switch(iRoll)
     {
        case 1: {DelayCommand(0.2, DAMimbue3(oItem, iRange));++iQual;} break;
        case 2: {DelayCommand(0.2, MindAbilityImbue(oItem, iRange));++iQual;} break;
        case 3: {DelayCommand(0.2, DAMimbue3(oItem, iRange));
                 DelayCommand(0.2, MindAbilityImbue(oItem, iRange)); iQual=iQual+2;} break;
     }
  }
}

  sName = GetColorName(iQual, sIName);
  SetName(oItem, sName);
  SetIdentified(oItem, TRUE);
  SetStolenFlag(oItem, TRUE);
}

void wk_chestloot (object oSack)
{
object oPC = GetLastUsedBy();

/////////////////////////////////////////
//::Droprate config::
//
int DamBroke = 0;
int lMod;

lMod = DROP_RATE; //default

/////////////////////////////////////////////////
//::initiate variables::                       //
int iDice;
int iHD = GetLocalInt(OBJECT_SELF,"BossLoot");
int iRange = iHD;
int iMage;
int nColChk;

// Bosses have high chance to drop loot (never broken or worn)
lMod = lMod + iHD;

int WishChance =    1;          // % chance to drop a wish item
int WeapChance =    6+lMod;        // % chance to drop a weapon
int ArmorChance =   5+lMod;        // % chance to drop armor or a shield
int MItemChance =   5+lMod;        // % chance to drop a magic item
int RodWandChance = lMod;        // % chance to drop a wand/rod item
int PotChance =     lMod;          // % chance to drop a potion

//chance of a more powerful item

if (LUCK_CHANCE>0)
   {
    iDice = Random(LUCK_CHANCE);
    if (iDice == 1) iRange++;
    if (iRange > 5) iRange=5;
   }

////////////////////////////////////////////////
// Cycle through the various drops until the number of items for the boss are
// all dropped.  This guarantees that each boss level will be distinct.
// Note that the luck chance to increase the value of the loot does not
// affect the number of items to drop.

while (iHD > 0)
{
// Wish Roll
iDice = d20();
if (iDice<WishChance+1&iHD>0&iRange>2)
 {
  DropWish(oSack, iRange);
  iHD=iHD-1;
 }

// Weapon Roll
iDice = d20();
if (iDice<WeapChance+1&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropWeapon(oSack, iRange);
  iHD=iHD-1;
 }

// Armor or shield Roll
iDice = d20();
if (iDice<ArmorChance+1&iHD>0)
   {
    nColChk = d3();
    if (nColChk == 1) DropCollChip(oSack, iRange);
    else DropShield(oSack, iRange);
    iHD=iHD-1;
   }

// Rod/Wand Roll
iDice = d20();
if (iDice<RodWandChance+1&&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropRodWand(oSack);
  iHD=iHD-1;
 }

// Magic Item Roll
iDice = d20();
if (iDice<MItemChance+1&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropMagicItem(oSack, iRange);
  iHD=iHD-1;
 }

// Pot Roll
iDice = d100();
if (iDice<PotChance+1&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropPot(oSack);
 }
} // End of the While loop that ensures that all the items will drop.

}

void DoChumpLoot (object oSack, int iRange)
{
object oPC = GetLastKiller();

int lMod;
lMod = DROP_RATE; //default

/////////////////////////////////////////////////
//::initiate variables::                       //
int iDice;
int iHD = iRange;
location lLoc = GetLocation(OBJECT_SELF);

// Bosses have high chance to drop loot (never broken or worn)
lMod = lMod + iHD;

int WeapChance =    6+lMod;        // % chance to drop a weapon
int ArmorChance =   5+lMod;        // % chance to drop armor or a shield
int MItemChance =   5+lMod;        // % chance to drop a magic item

//chance of a more powerful item

if (LUCK_CHANCE>0)
   {
    iDice = Random(LUCK_CHANCE);
    if (iDice == 1) iRange++;
    if (iRange > 5) iRange=5;
   }

// Weapon Roll
iDice = d20();
if (iDice<WeapChance+1&iHD>0)
 {
  DropWeapon(oSack, iRange);
  iHD=iHD-1;
 }

// Armor or shield Roll
iDice = d20();
if (iDice<ArmorChance+1&iHD>0)
 {
  DropShield(oSack, iRange);
  iHD=iHD-1;
 }

// Magic Item Roll
iDice = d20();
if (iDice<MItemChance+1&iHD>0)
 {
  DropMagicItem(oSack, iRange);
  iHD=iHD-1;
 }

}


void wk_droploot (object oMob, object oSack)
{
object oPC = GetLastKiller();

/////////////////////////////////////////
//::Droprate config::
//
int DamBroke = 0;
int lMod;

lMod = DROP_RATE; //default

/////////////////////////////////////////////////
//::initiate variables::                       //
int iDice;
int iHD = GetLocalInt(OBJECT_SELF,"BossLoot");
int iRange = iHD;
int iMage;
int nColChk;

// Bosses have high chance to drop loot (never broken or worn)
lMod = lMod + iHD;

int WishChance =    lMod-iHD;          // % chance to drop a wish item
int WeapChance =    6+lMod;        // % chance to drop a weapon
int ArmorChance =   5+lMod;        // % chance to drop armor or a shield
int MItemChance =   5+lMod;        // % chance to drop a magic item
int RodWandChance = 2;             // % chance to drop a wand/rod item
int PotChance =     2;             // % chance to drop a potion

//chance of a more powerful item

if (LUCK_CHANCE>0)
   {
    iDice = Random(LUCK_CHANCE);
    if (iDice == 1) iRange++;
    if (iRange > 5) iRange=5;
   }

////////////////////////////////////////////////
// Cycle through the various drops until the number of items for the boss are
// all dropped.  This guarantees that each boss level will be distinct.
// Note that the luck chance to increase the value of the loot does not
// affect the number of items to drop.

while (iHD > 0)
{
// Wish Roll
iDice = d20();
if (iDice<WishChance+1&iHD>0&iRange>2)
 {
  DropWish(oSack, iRange);
  iHD=iHD-1;
 }

// Weapon Roll
iDice = d20();
if (iDice<WeapChance+1&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropWeapon(oSack, iRange);
  iHD=iHD-1;
 }

// Armor or shield Roll
iDice = d20();
if (iDice<ArmorChance+1&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropShield(oSack, iRange);
  iHD=iHD-1;
 }

// Rod/Wand Roll
iDice = d20();
if (iDice<RodWandChance+1&&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropRodWand(oSack);
  iHD=iHD-1;
 }

// Magic Item Roll
iDice = d20();
if (iDice<MItemChance+1&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropMagicItem(oSack, iRange);
  iHD=iHD-1;
 }

// Pot Roll
iDice = d100();
if (iDice<PotChance+1&iHD>0)
 {
  nColChk = d3();
  if (nColChk == 1) DropCollChip(oSack, iRange);
  else DropPot(oSack);
 }
} // End of the While loop that ensures that all the items will drop.


}
///////////////////////////
//: For test compiling only
//: void main(){}
