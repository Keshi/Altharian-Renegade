/////::///////////////////////////////////////////
/////:: wk_onspawn
/////:: Written by Winterknight for Altharia 11/19/07
/////::///////////////////////////////////////////

#include "x2_inc_itemprop"

int GetCreatureRating (object oCritter)
{
  float fCR= GetChallengeRating(oCritter);
  int nLevel;
  if (fCR < 50.0) nLevel = 1;
  else if (fCR >= 50.0 & fCR < 100.0) nLevel = 2;
  else if (fCR >= 100.0 & fCR < 200.0) nLevel = 3;
  else if (fCR >= 200.0 & fCR < 400.0) nLevel = 4;
  else if (fCR >= 400.0) nLevel = 5;
  return nLevel;
}

////////////////////////////////////////////////////////////////////////////////
//                                WEAPON UPGRADES                             //
////////////////////////////////////////////////////////////////////////////////

void ElementDamageRandom(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iType;
 int nDam = 5;
 if (iRange == 2) nDam = 20;
 if (iRange == 3) nDam = 25;
 if (iRange >= 4) nDam = 30;

 if (iRange == 1 ||
     iRange == 2)
   {
   int iRoll = Random(5)+1;
   switch (iRoll)
     {
       case 1: {iType = IP_CONST_DAMAGETYPE_ACID;} break;
       case 2: {iType = IP_CONST_DAMAGETYPE_COLD;}break;
       case 3: {iType = IP_CONST_DAMAGETYPE_ELECTRICAL;}break;
       case 4: {iType = IP_CONST_DAMAGETYPE_FIRE;}break;
       case 5: {iType = IP_CONST_DAMAGETYPE_SONIC;}break;
     }
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
   }
// Mid level upgrades - 2 elemental damage types
 else if (iRange == 3 ||
          iRange == 4)
   {
   // fire or ice
   int iRoll = d2();
   switch (iRoll)
     {
       case 1: {iType = IP_CONST_DAMAGETYPE_FIRE;} break;
       case 2: {iType = IP_CONST_DAMAGETYPE_COLD;}break;
     }
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
   // acid, electrical, or sonic
   iRoll = d3();
   switch (iRoll)
     {
       case 1: {iType = IP_CONST_DAMAGETYPE_ACID;} break;
       case 2: {iType = IP_CONST_DAMAGETYPE_SONIC;}break;
       case 3: {iType = IP_CONST_DAMAGETYPE_ELECTRICAL;}break;
     }
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
   }
// Max upgrade - 3 elemental damage types.
 else if (iRange == 5)
   {
   // fire or ice
   int iRoll = d2();
   switch (iRoll)
     {
       case 1: {iType = IP_CONST_DAMAGETYPE_FIRE;} break;
       case 2: {iType = IP_CONST_DAMAGETYPE_COLD;}break;
     }
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
   // acid or electrical
   iRoll = d2();
   switch (iRoll)
     {
       case 1: {iType = IP_CONST_DAMAGETYPE_ACID;} break;
       case 2: {iType = IP_CONST_DAMAGETYPE_ELECTRICAL;}break;
     }
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
   // sonic
   iType = IP_CONST_DAMAGETYPE_SONIC;
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
   }
}

void MagicDamageRandom(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iType;
 int nDam = 5;
 if (iRange == 2) nDam = 20;
 if (iRange == 3) nDam = 25;
 if (iRange >= 4) nDam = 30;

 if (iRange == 2 || iRange == 3)
 {
   int iRoll = d4();
   switch (iRoll)
     {
       case 1: {iType = IP_CONST_DAMAGETYPE_POSITIVE;} break;
       case 2: {iType = IP_CONST_DAMAGETYPE_NEGATIVE;}break;
       case 3: {iType = IP_CONST_DAMAGETYPE_DIVINE;}break;
       case 4: {iType = IP_CONST_DAMAGETYPE_MAGICAL;}break;
     }
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
 }
 else if (iRange == 4 || iRange == 5)
 {
   // positive or negative
   int iRoll = d2();
   switch (iRoll)
     {
       case 1: {iType = IP_CONST_DAMAGETYPE_POSITIVE;} break;
       case 2: {iType = IP_CONST_DAMAGETYPE_NEGATIVE;}break;
     }
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
   // divine or magical
   iRoll = d2();
   switch (iRoll)
     {
       case 1: {iType = IP_CONST_DAMAGETYPE_DIVINE;}break;
       case 2: {iType = IP_CONST_DAMAGETYPE_MAGICAL;}break;
     }
   ipAdd = ItemPropertyDamageBonus(iType, nDam);
   IPSafeAddItemProperty(oItem, ipAdd);
 }
}

void PhysicalDamageRandom(object oItem, int iRange)
{
 itemproperty ipAdd;
 int iType;
 int nDam = 5;
 if (iRange == 2) nDam = 20;
 if (iRange == 3) nDam = 25;
 if (iRange >= 4) nDam = 30;
 int iRoll = d3();
 switch (iRoll)
   {
     case 1: {iType = IP_CONST_DAMAGETYPE_BLUDGEONING;} break;
     case 2: {iType = IP_CONST_DAMAGETYPE_PIERCING;}break;
     case 3: {iType = IP_CONST_DAMAGETYPE_SLASHING;}break;
   }
 ipAdd = ItemPropertyDamageBonus(iType, nDam);
 IPSafeAddItemProperty(oItem, ipAdd);
}

void AddLevelProperties(object oItem, int nCR)
{
  itemproperty ipAdd;

  if (nCR == 1)
  {
    // Add EB, add keen
    ipAdd = ItemPropertyEnhancementBonus(5);
    IPSafeAddItemProperty(oItem, ipAdd);
    ipAdd = ItemPropertyKeen();
    IPSafeAddItemProperty(oItem, ipAdd);
    // Add damage properties
    PhysicalDamageRandom(oItem,nCR);
    ElementDamageRandom(oItem,nCR);
  }

  if (nCR == 2)
  {
    // Add EB, add keen
    ipAdd = ItemPropertyEnhancementBonus(20);
    IPSafeAddItemProperty(oItem, ipAdd);
    ipAdd = ItemPropertyKeen();
    IPSafeAddItemProperty(oItem, ipAdd);
    // Add damage properties
    PhysicalDamageRandom(oItem,nCR);
    ElementDamageRandom(oItem,nCR);
    MagicDamageRandom(oItem,nCR);
  }

  if (nCR == 3)
  {
    // Add EB, add keen
    ipAdd = ItemPropertyEnhancementBonus(25);
    IPSafeAddItemProperty(oItem, ipAdd);
    ipAdd = ItemPropertyKeen();
    IPSafeAddItemProperty(oItem, ipAdd);
    // Add damage properties
    PhysicalDamageRandom(oItem,nCR);
    ElementDamageRandom(oItem,nCR);
    MagicDamageRandom(oItem,nCR);
  }

  if (nCR >= 4)
  {
    // Add EB, add keen
    ipAdd = ItemPropertyEnhancementBonus(30);
    IPSafeAddItemProperty(oItem, ipAdd);
    ipAdd = ItemPropertyKeen();
    IPSafeAddItemProperty(oItem, ipAdd);
    // Add damage properties
    PhysicalDamageRandom(oItem,nCR);
    ElementDamageRandom(oItem,nCR);
    MagicDamageRandom(oItem,nCR);
  }
}

void AddTagProperties(object oItem, string sTag)
{
  itemproperty ipAdd;
  if (sTag == "zakros" ||
      sTag == "i31_hound" ||
      sTag == "i31_piratelt4" ||
      sTag == "i31_forestguard" ||
      sTag == "i31_stone_protector")
  {
    ipAdd = ItemPropertyHolyAvenger();
    IPSafeAddItemProperty(oItem, ipAdd);
  }

  if (sTag == "mc_sutma")
  {
    ipAdd = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_26,IP_CONST_POISON_1D2_DEXDAMAGE);
    IPSafeAddItemProperty(oItem, ipAdd);
  }

  if (sTag == "boom_5n_lordoftheunde")
  {
    ipAdd = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_FLESH_TO_STONE,40);
    IPSafeAddItemProperty(oItem, ipAdd);
  }
}

void UpgradeWeapons(object oCritter, string sTag, int nCR)
{
  int nSlot = INVENTORY_SLOT_RIGHTHAND;
  object oWeapon = GetItemInSlot(nSlot,oCritter);
  itemproperty ip;
  int nLoop = 1;
  if (sTag == "archerbow")
  {
    ip = ItemPropertyUnlimitedAmmo(IP_CONST_UNLIMITEDAMMO_1D6LIGHT);
    AddItemProperty(DURATION_TYPE_PERMANENT, ip, oWeapon);
  }
  object oNew;
  string sNew;
  ip = ItemPropertyOnHitCastSpell(125,1);
  while (nLoop < 7)
  {
    if (GetIsObjectValid(oWeapon))
    {
      sNew = GetResRef(oWeapon);
      oNew = CreateItemOnObject(sNew,oCritter,1,sTag);
      AddItemProperty(DURATION_TYPE_PERMANENT, ip, oNew);
      AddLevelProperties(oNew, nCR);     // This is where we add the level-based
                                         // upgrades to the items.
      AddTagProperties(oNew,GetTag(oCritter));
      SetDroppableFlag(oNew, FALSE);
      ActionUnequipItem(oWeapon);
      ActionEquipItem(oNew,nSlot);
      DestroyObject(oWeapon,0.1);
    }
    nLoop++;
    if (nLoop == 2) nSlot = INVENTORY_SLOT_LEFTHAND;
    if (nLoop == 3) nSlot = INVENTORY_SLOT_CWEAPON_B;
    if (nLoop == 4) nSlot = INVENTORY_SLOT_CWEAPON_L;
    if (nLoop == 5) nSlot = INVENTORY_SLOT_CWEAPON_R;
    if (nLoop == 6) nSlot = INVENTORY_SLOT_ARMS;

    oWeapon =GetItemInSlot(nSlot,oCritter);
  }
}

////////////////////////////////////////////////////////////////////////////////
//                              ARMOR UPGRADES                                //
////////////////////////////////////////////////////////////////////////////////

void ArmorRandomElementalDR(object oItem, int nCR)
{
  int nDice = d6();
  int iType;
  itemproperty ipAdd;
  int iRoll = Random(5)+1;
  int iDam;
  switch (iRoll)
  {
    case 1: {iType = IP_CONST_DAMAGETYPE_ACID;} break;
    case 2: {iType = IP_CONST_DAMAGETYPE_COLD;}break;
    case 3: {iType = IP_CONST_DAMAGETYPE_ELECTRICAL;}break;
    case 4: {iType = IP_CONST_DAMAGETYPE_FIRE;}break;
    case 5: {iType = IP_CONST_DAMAGETYPE_SONIC;}break;
  }

  if (nDice < 4) // This loop for DR - higher loop for immunity
  {
    switch (nCR)
    {
      case 3: {iDam = IP_CONST_DAMAGERESIST_20;} break;
      case 4: {iDam = IP_CONST_DAMAGERESIST_35;}break;
      case 5: {iDam = IP_CONST_DAMAGERESIST_50;}break;
    }
    ipAdd = ItemPropertyDamageResistance(iType,iDam);
  }
  if (nDice >= 4) // This loop for immunity
  {
    switch (nCR)
    {
      case 3: {iDam = IP_CONST_DAMAGEIMMUNITY_25_PERCENT;} break;
      case 4: {iDam = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;}break;
      case 5: {iDam = IP_CONST_DAMAGEIMMUNITY_75_PERCENT;}break;
    }
    ipAdd = ItemPropertyDamageImmunity(iType,iDam);
  }
  IPSafeAddItemProperty(oItem, ipAdd);
}

void ArmorRandomPhysicalDR(object oItem, int nCR)
{
  int nDice = d6();
  int iType;
  itemproperty ipAdd;
  int iRoll = d3();
  int iDam;
  switch (iRoll)
  {
    case 1: {iType = IP_CONST_DAMAGETYPE_BLUDGEONING;} break;
    case 2: {iType = IP_CONST_DAMAGETYPE_PIERCING;}break;
    case 3: {iType = IP_CONST_DAMAGETYPE_SLASHING;}break;
  }

  if (nDice < 4) // This loop for DR - higher loop for immunity
  {
    switch (nCR)
    {
      case 3: {iDam = IP_CONST_DAMAGERESIST_20;} break;
      case 4: {iDam = IP_CONST_DAMAGERESIST_35;}break;
      case 5: {iDam = IP_CONST_DAMAGERESIST_50;}break;
    }
    ipAdd = ItemPropertyDamageResistance(iType,iDam);
  }
  if (nDice >= 4) // This loop for immunity
  {
    switch (nCR)
    {
      case 3: {iDam = IP_CONST_DAMAGEIMMUNITY_25_PERCENT;} break;
      case 4: {iDam = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;}break;
      case 5: {iDam = IP_CONST_DAMAGEIMMUNITY_75_PERCENT;}break;
    }
    ipAdd = ItemPropertyDamageImmunity(iType,iDam);
  }
  IPSafeAddItemProperty(oItem, ipAdd);
}

void ArmorRandomSpiritualDR(object oItem, int nCR)
{
  int nDice = d6();
  int iType;
  itemproperty ipAdd;
  int iRoll = d4();
  int iDam;
  switch (iRoll)
  {
    case 1: {iType = IP_CONST_DAMAGETYPE_DIVINE;} break;
    case 2: {iType = IP_CONST_DAMAGETYPE_MAGICAL;}break;
    case 3: {iType = IP_CONST_DAMAGETYPE_NEGATIVE;}break;
    case 4: {iType = IP_CONST_DAMAGETYPE_POSITIVE;}break;
  }

  if (nDice < 4) // This loop for DR - higher loop for immunity
  {
    switch (nCR)
    {
      case 3: {iDam = IP_CONST_DAMAGERESIST_20;} break;
      case 4: {iDam = IP_CONST_DAMAGERESIST_35;}break;
      case 5: {iDam = IP_CONST_DAMAGERESIST_50;}break;
    }
    ipAdd = ItemPropertyDamageResistance(iType,iDam);
  }
  if (nDice >= 4) // This loop for immunity
  {
    switch (nCR)
    {
      case 3: {iDam = IP_CONST_DAMAGEIMMUNITY_25_PERCENT;} break;
      case 4: {iDam = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;}break;
      case 5: {iDam = IP_CONST_DAMAGEIMMUNITY_75_PERCENT;}break;
    }
    ipAdd = ItemPropertyDamageImmunity(iType,iDam);
  }
  IPSafeAddItemProperty(oItem, ipAdd);
}

void ArmorRandomImmunity(object oItem, int nCR)
{
  int nDice = d6();
  int iType;
  itemproperty ipAdd;
  int iRoll = d6();
  switch (iRoll)
  {
    case 1: {iType = IP_CONST_IMMUNITYMISC_BACKSTAB;} break;
    case 2: {iType = IP_CONST_IMMUNITYMISC_CRITICAL_HITS;}break;
    case 3: {iType = IP_CONST_IMMUNITYMISC_DEATH_MAGIC;}break;
    case 4: {iType = IP_CONST_IMMUNITYMISC_KNOCKDOWN;}break;
    case 5: {iType = IP_CONST_IMMUNITYMISC_PARALYSIS;} break;
    case 6: {iType = IP_CONST_IMMUNITYMISC_MINDSPELLS;}break;
  }
  ipAdd = ItemPropertyImmunityMisc(iType);
  IPSafeAddItemProperty(oItem, ipAdd);
}


void ArmorLevelProperties(object oItem, int nCR)
{
  int iRoll = d4();
  while (iRoll> 0)
  {
    switch (iRoll)
    {
      case 1: {ArmorRandomPhysicalDR(oItem,nCR); iRoll = iRoll - (d2());}break;
      case 2: {ArmorRandomElementalDR(oItem,nCR); iRoll = iRoll - (d2());}break;
      case 3: {ArmorRandomSpiritualDR(oItem,nCR); iRoll = iRoll - (d2());}break;
      case 4: {ArmorRandomImmunity(oItem,nCR);; iRoll = iRoll - (d2());}break;
    }
  }
}

int ArmorTagProperties(object oItem, string sTag)
{
  itemproperty ipAdd;
  int nCheck = 0;

  // Begin section for individual creature properties //
  if (sTag == "zakros")
  {
    ipAdd = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEIMMUNITY_100_PERCENT);
    IPSafeAddItemProperty(oItem, ipAdd);
    nCheck = 1;
  }
  // End creature section //
  return nCheck;
}

void UpgradeSkin(object oCritter, int nCR)
{
  int nSlot = INVENTORY_SLOT_CHEST;
  object oSkin = GetItemInSlot(nSlot,oCritter);
  int nLoop = 1;
  int nCheck;
  while (nLoop < 3)
  {
    if (GetIsObjectValid(oSkin))
    {
      nCheck = ArmorTagProperties(oSkin,GetTag(oCritter));
                             // ArmorTagProperties was made into an integer
                             // so we could add the ability to do a limitation
                             // check easily.  Builders have the option to limit
                             // properties to only what is in the armortag loop
                             // or still be able to add random props via the
                             // ArmorLevelProperties.
      if (nCheck == 0)
      {
        ArmorLevelProperties(oSkin, nCR);     // This is where we add the level-based
      }                                       // upgrades to the items.
      SetDroppableFlag(oSkin, FALSE);
      nLoop++;
    }
    nLoop++;
    if (nLoop == 2) nSlot = INVENTORY_SLOT_CARMOUR;
    oSkin = GetItemInSlot(nSlot,oCritter);
  }
}

////////////////////////////////////////////////////////////////////////////////
/*
  ShiftAppearance function can be used to alter the appearance and change the
  name of any spawned creature.  Paste in the additional creatures, following
  the format outlined in the add_onspawn script from the builder's mod.
*/
////////////////////////////////////////////////////////////////////////////////

void ShiftAppearance(object oSpawn)
{
  string sTag = GetTag(oSpawn);

///Gelid
  if (sTag == "pc_GreaterIceWyrm")
  {
    string sArea;
    object oArea;

    sArea = "Freze25_5Icedragonlair";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"Gelid");
    }

    sArea = "pc_FirestormPeak";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DRAGON_SILVER);
      SetName(OBJECT_SELF,"Ancient Ice Wyrm");
    }
  }

///Volt
  if (sTag == "pc_StormDragon")
  {
    string sArea;
    object oArea;

    sArea = "Storm35_5VoltRoom";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"Volt");
    }
    sArea = "Storm77_5StormPeak";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"Storm Dragon");
    }
  }


 ////Acid Dragon Boss
  if (sTag == "pc_GreenDragon")
  {
    string sArea;
    object oArea;

    sArea = "Acide35_5CCaves";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"Corrosion Of Conformity");
    }
  }

///Fire Dragon Boss

  if (sTag == "pc_Torch")
  {
    string sArea;
    object oArea;

    sArea = "Flame35_5DRFire3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"Imaorata");
    }
  }

  if (sTag == "boom_4p_pc_MortifeGeneral")
  {
    string sArea;
    object oArea = GetArea(OBJECT_SELF);

    sArea = "Magic77_5pc_MortUWTr1Lvl4";
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"General Killjoy");
    }

    sArea = "Magic77_5pc_MortUWTr2Lvl3";
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"General Messatingz");
    }

    sArea = "Flame77_5pc_MortSouthCitUpper";
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"General Yspekin");
    }

    sArea = "Freze77_5pc_MortNorCitUpper";
    if (GetTag(oArea) == sTag)
    {
      SetName(OBJECT_SELF,"General Dizordar");
    }
  }

  ///DraHaruInMortifeDesert
  if (sTag == "pc_DesertWarrior")
  {
    string sArea;
    object oArea= GetArea(OBJECT_SELF);

    sArea = "pc_MortSouthCitThrallCenter";
    if (GetTag(oArea) == sTag)
    {
      SetName(OBJECT_SELF,"Mortife Thrall");
    }
  }

  ///DraHaruInMortifeSouthCitadel
  if (sTag == "pc_SouthNativeDruid")
  {
    string sArea;
    object oArea = GetArea(OBJECT_SELF);

    sArea = "pc_MortSouthCitThrallCenter";
    if (GetTag(oArea) == sTag)
    {
      SetName(OBJECT_SELF,"Mortife Thrall");
    }
  }

///BasicRuinDemon
   if (sTag == "boom_1n_RuinDemon")
  {
    string sArea;
    object oArea;

    sArea = "Abyss10_5Tow1_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BALOR);
      SetName(OBJECT_SELF,"Keeper Of The Pale");
    }

    sArea = "Abyss20_5Tow3_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BODAK);
      SetName(OBJECT_SELF,"Corrupting Demon");
    }

    sArea = "Abyss77_4Tow6_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GRAY_OOZE);
      SetName(OBJECT_SELF,"Foul Matter");
    }

    sArea = "Abyss77_4Tow6_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GRAY_OOZE);
      SetName(OBJECT_SELF,"Foul Matter");
    }

    sArea = "Abyss77_4Tow6_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GRAY_OOZE);
      SetName(OBJECT_SELF,"Foul Matter");
    }
 }

//BasicBlastDemon
   if (sTag == "pc_BlastDemon")
  {
    string sArea;
    object oArea;

    sArea = "Abyss20_5Tow3_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_PENGUIN);
      SetName(OBJECT_SELF,"Beguiling Demon");
    }

    sArea = "Abyss20_5Tow3_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_PENGUIN);
      SetName(OBJECT_SELF,"Beguiling Demon");
    }
  }

///BasicDemon
   if (sTag == "boom_1n_basicdemon")
  {
    string sArea;
    object oArea;

    sArea = "Abyss20_5Tow3_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_PENGUIN);
      SetName(OBJECT_SELF,"Beguiling Demon");
    }

    sArea = "Abyss20_5Tow3_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_PENGUIN);
      SetName(OBJECT_SELF,"Beguiling Demon");
    }
  }

///GreaterBlastDemon
if (sTag == "boom_1n_GBlastDem")
  {
    string sArea;
    object oArea;

    sArea = "Abyss25_5Tow4_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_SUCCUBUS);
      SetName(OBJECT_SELF,"Temptress");
    }

    sArea = "Abyss25_5Tow4_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_SUCCUBUS);
      SetName(OBJECT_SELF,"Temptress");
    }

      sArea = "Abyss25_5Tow4_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_SUCCUBUS);
      SetName(OBJECT_SELF,"Temptress");
    }

  }

///Drones reworked by Red

  if (sTag == "dronefactoryacco")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == " dronewerksteahut")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_HALF_ORC_NPC_FEMALE);
      SetName(OBJECT_SELF,"Dronewerks Cook");
    }
  }

  if (sTag == "mc_mithgolcont")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == " dronewerksboat" || sArea == " dronewerksshipof")
     {
       SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GOLEM_ADAMANTIUM);
       SetName(OBJECT_SELF,"Loading Drone");
     }
  }

///KoboldSwitch

  if (sTag == "jp_minegoblin2")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "Dela_ofkt1" || sArea == "Dela_ofkt2"
      || sArea == "Dela_ofkt3")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_CHIEF_B);
      SetName(OBJECT_SELF,"Kobold Corporal");
    }
  }

  if (sTag == "jp_minegoblin1")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

      if (sArea == "Dela_ofkt1" || sArea == "Dela_ofkt2"
      || sArea == "Dela_ofkt3")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_CHIEF_A);
      SetName(OBJECT_SELF,"Kobold Sentry");
    }
  }

 /// SkullcrushermarinesSwitch
 if (sTag == "skullcrushermarine")
  {
    string sArea;
    object oArea;

    sArea = "Abyss25_5Tow4_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BEGGER);
      SetName(OBJECT_SELF,"Venal Helot");
    }

    sArea = "Abyss25_5Tow4_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BEGGER);
      SetName(OBJECT_SELF,"Venal Helot");
    }

    sArea = "Abyss25_5Tow4_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BEGGER);
      SetName(OBJECT_SELF,"Venal Helot");
    }

    sArea = "Abyss77_5Tow5_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_INVISIBLE_STALKER);
      SetName(OBJECT_SELF,"Darkling");
    }
  }

///LootDroppingRuinDemon
  if (sTag == " boom_2n_LootRuinDem")
  {
    string sArea;
    object oArea;

    sArea = "Abyss77_5Tow5_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_SLAAD_BLACK);
      SetName(OBJECT_SELF,"Dark Master");
    }

    sArea = "Abyss77_4Tow6_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_OCHRE_JELLY_LARGE);
      SetName(OBJECT_SELF,"Living Slime");
    }

    sArea = "Abyss77_4Tow6_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_OCHRE_JELLY_LARGE);
      SetName(OBJECT_SELF,"Living Slime");
    }

    sArea = "Abyss77_4Tow7_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_VROCK);
      SetName(OBJECT_SELF,"Subjugator");
    }

    sArea = "Abyss77_4Tow7_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_VROCK);
      SetName(OBJECT_SELF,"Subjugator");
    }

    sArea = "Abyss77_5Tow8_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_VROCK);
      SetName(OBJECT_SELF,"Subjugator");
    }

    sArea = "Abyss77_4Tow8_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_VROCK);
      SetName(OBJECT_SELF,"Subjugator");
    }
  }

///Greater Ruin Demon

    if (sTag == "pc_RuinDemonGreater")
  {
    string sArea;
    object oArea;

    sArea = "Abyss77_4Tow6_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GELATINOUS_CUBE);
      SetName(OBJECT_SELF,"Bottom Feeder");
    }

    sArea = "Abyss77_4Tow6_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_HOOK_HORROR);
      SetName(OBJECT_SELF,"Foul Master");
    }

    sArea = "Abyss77_4Tow6_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_OCHRE_JELLY_MEDIUM);
      SetName(OBJECT_SELF,"Foul Matter");
    }

    sArea = "Abyss77_4Tow7_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DRIDER_FEMALE);
      SetName(OBJECT_SELF,"Mistress Of Pain");
    }

    sArea = "Abyss77_4Tow7_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DRIDER_FEMALE);
      SetName(OBJECT_SELF,"Mistress Of Pain");
    }

    sArea = "Abyss77_4Tow7_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DRIDER_FEMALE);
      SetName(OBJECT_SELF,"Mistress Of Pain");
    }

    sArea = "Abyss77_5Tow8_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DEVIL);
      SetName(OBJECT_SELF,"Ruin Pawn");
    }

    sArea = "Abyss77_4Tow8_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DEVIL);
      SetName(OBJECT_SELF,"Ruin Pawn");
    }

    sArea = "Abyss99_5Tow8_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DEVIL);
      SetName(OBJECT_SELF,"Ruin Pawn");
    }

    sArea = "Abyss99_4Tow8_4";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DEVIL);
      SetName(OBJECT_SELF,"Ruin Pawn");
    }
  }

///Tyrant

  if (sTag == "boom_2n_GBlastDem2")
  {
    string sArea;
    object oArea;

    sArea = "Abyss77_5Tow8_1";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DRACOLICH);
      SetName(OBJECT_SELF,"Potentate");
    }

    sArea = "Abyss77_4Tow8_2";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DRACOLICH);
      SetName(OBJECT_SELF,"Potentate");
    }

    sArea = "Abyss99_5Tow8_3";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DRACOLICH);
      SetName(OBJECT_SELF,"Potentate");
    }

    sArea = "Abyss99_4Tow8_4";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DRACOLICH);
      SetName(OBJECT_SELF,"Potentate");
    }
  }


/// Were Creatures

 if (sTag == "pc_wolf")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_FullMoon1")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_RAT_DIRE);
      SetName(OBJECT_SELF,"Filthy Rat");
    }

    if (sArea == "pc_FullMoon3")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_CAT_MPANTHER);
      SetName(OBJECT_SELF,"Panther");
    }
  }


 if (sTag == "pc_were")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_FullMoon1")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_WERERAT);
      SetName(OBJECT_SELF,"Wererat");
    }

    if (sArea == "pc_FullMoon3")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_WERECAT);
      SetName(OBJECT_SELF,"Werecat");
    }
  }


/// Emp Pres Undead Switch

  if (sTag == "jp_mortspirit")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_ForTun")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_SPECTRE);
      SetName(OBJECT_SELF,"Forgotten Soul");
    }

    if (sArea == "pc_AncientBat" || sArea == "pc_RCT1" || sArea == "pc_RCT2"|| sArea == "pc_RCT3")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_GHOUL);
      SetName(OBJECT_SELF,"Ghoul Ravager");
    }
  }

  if (sTag == "jp_mortcleric")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_AncientBat" || sArea == "pc_RCT1" || sArea == "pc_RCT2"|| sArea == "pc_RCT3")
     {
       SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MUMMY_WARRIOR);
       SetName(OBJECT_SELF,"Befouled Corpse");
     }
  }

  if (sTag == "jp_arvonfist")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_AncientBat" || sArea == "pc_RCT1" || sArea == "pc_RCT2"|| sArea == "pc_RCT3")
     {
       SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_ZOMBIE_WARRIOR_2);
       SetName(OBJECT_SELF,"Death Echo");
     }
  }

  if (sTag == "jp_arvonlich2")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_AncientBat" || sArea == "pc_RCT1" || sArea == "pc_RCT2"|| sArea == "pc_RCT3")
     {
       SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MUMMY_GREATER);
       SetName(OBJECT_SELF,"Crypt Mummy");
     }
  }

  if (sTag == "jp_crypt3boss")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_RCT1" || sArea == "pc_RCT2"|| sArea == "pc_RCT3")
     {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MUMMY_COMMON);
      SetName(OBJECT_SELF,"Mummy Warrior");
    }
  }

  if (sTag == "jp_crypt4boss")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_RCT1" || sArea == "pc_RCT2"|| sArea == "pc_RCT3")
     {
       SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_MUMMY_FIGHTER_2);
       SetName(OBJECT_SELF,"Mummy Lord");
     }
  }

///Kyar And Chryss
 if (sTag == "i31_badger1")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_KyarClimbs" || sArea == "pc_KCM1L1" || sArea == "pc_KCM1L2"
     || sArea == "pc_KCM1L3" || sArea == "pc_KCM2L1" || sArea == "pc_KCM2L2"
     || sArea == "pc_KCM2L3" || sArea == "pc_KCM3L1" || sArea == "pc_KCM3L2"
     || sArea == "pc_KIPL1" || sArea == "pc_KIPL2")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BEAR_POLAR);
      SetName(OBJECT_SELF,"Snow Bear");
    }
  }

 if (sTag == "lab_umb")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_KyarFoothills" || sArea == "pc_KyarBBCave"
      || sArea == "pc_KyarBBCave2" || sArea =="pc_MtKyarBase")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_DOG_WINTER_WOLF);
      SetName(OBJECT_SELF,"Snow Wolf");
    }
  }

   if (sTag == "pc_EmpBear")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_KyarFoothills" || sArea == "pc_KyarBBCave2"
         || sArea == "pc_ChPl1" || sArea == "pc_ChPl2" || sArea == "pc_ChC1"
         || sArea == "pc_ChC2")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BEAR_BLACK);
      SetName(OBJECT_SELF,"Black Bear");
    }
  }

 if (sTag == "pc_SentientCold")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_KIPL1" || sArea == "pc_KIPL2")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_WILL_O_WISP);
      SetName(OBJECT_SELF,"Enchanted Snowball");
    }
  }

 if (sTag == "pc_IceWyrm")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_KIPL2")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_BEAR_POLAR);
      SetName(OBJECT_SELF,"White Paw");
    }
  }

 if (sTag == "pc_BugBear")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_Ch_JT2")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_HOBGOBLIN_WIZARD);
      SetName(OBJECT_SELF,"Hobgoblin Chief");
    }
  }

///Chryss Hoblgoblin Switch
   if (sTag == "OrcBerserker")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_Ch_JT1" || sArea == "pc_Ch_JT2"
         || sArea == "pc_ChPl1" || sArea == "pc_ChPl2" || sArea == "pc_ChC1"
         || sArea == "pc_ChC2")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_HOBGOBLIN_WARRIOR);
      SetName(OBJECT_SELF,"Hobgoblin Warrior");
    }
  }

   if (sTag == "OrcStalker")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_Ch_JT1" || sArea == "pc_Ch_JT2"
         || sArea == "pc_ChPl1" || sArea == "pc_ChPl2" || sArea == "pc_ChC1"
         || sArea == "pc_ChC2")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_HOBGOBLIN_WARRIOR);
      SetName(OBJECT_SELF,"Hobgoblin Scout");
    }
  }
   if (sTag == "OrcMasterOfAir")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_Ch_JT1" || sArea == "pc_Ch_JT2"
         || sArea == "pc_ChPl1" || sArea == "pc_ChPl2" || sArea == "pc_ChC1"
         || sArea == "pc_ChC2")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_HOBGOBLIN_WIZARD);
      SetName(OBJECT_SELF,"Hobgoblin Shaman");
    }
  }

///Surf Snatcher
   if (sTag == "pc_orcrogue")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_seacaves" || sArea == "pc_seacaves2"
         || sArea == "pc_seacaves3")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_SAHUAGIN);
      SetName(OBJECT_SELF,"Surf Snatcher");
    }
  }

   if (sTag == "pc_HobBoss")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "pc_seacaves3")

    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_SAHUAGIN_LEADER);
      SetName(OBJECT_SELF,"Snatcher Elder");
    }
  }

////Tull Crypt Zombie
  if (sTag == "jp_arvonrotting")
  {
    string sArea;
    object oArea;

    sArea = "pc_tullcrypt";
    oArea = GetArea(OBJECT_SELF);
    if (GetTag(oArea) == sArea)
    {
      SetName(OBJECT_SELF,"Walking Dead");
    }
  }

}

//void main (){}
