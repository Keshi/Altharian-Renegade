/////::///////////////////////////////////////////
/////:: wk_deatheffects
/////:: Part of the Unified lootsystem for Altharia
/////:: Written by Winterknight for Altharia 7/21/07
/////::///////////////////////////////////////////
/////:: Calling Scripts include:
/////:: alt_drop_and_efx (for non-bossloot creatures)
/////:: wk_bossloot_* (for all bossloot creatures).
/////::///////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "NW_I0_SPELLS"

void DoKaboom()
{
  object oCaster = OBJECT_SELF;
  string sTag = GetTag(oCaster);
  string sDam = GetSubString(sTag, 5, 1);
  string sType = GetSubString(sTag, 6, 1);
  int nDamage = StringToInt(sDam)*200;
  if (nDamage < 200) nDamage = 200;
  if (nDamage > 1000) nDamage = 1000;
  int nType = DAMAGE_TYPE_MAGICAL;
  int nSave = SAVING_THROW_TYPE_SPELL;
  if (sType == "n"){nType = DAMAGE_TYPE_NEGATIVE; nSave = SAVING_THROW_TYPE_NEGATIVE;}
  if (sType == "p"){nType = DAMAGE_TYPE_POSITIVE; nSave = SAVING_THROW_TYPE_POSITIVE;}
  if (sType == "s"){nType = DAMAGE_TYPE_SONIC; nSave = SAVING_THROW_TYPE_SONIC;}

  float fDelay;
  effect eExplode = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
  effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
  effect eDam;

  location lTarget = GetLocation(oCaster);

  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
  object  oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
  while (GetIsObjectValid(oTarget))
  {
    fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
    if (fDelay *20 < 11.0f && GetObjectType(oTarget)==OBJECT_TYPE_CREATURE)
    {
      int iMadesave = WillSave (oTarget, 60, nSave, OBJECT_SELF);
      if(iMadesave ==0) nDamage = nDamage;      // Normal damage
      if(iMadesave ==1) nDamage = nDamage / 2;  // Half damage
      if(iMadesave ==2) nDamage = nDamage / 4;  // Quarter damage

      eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
      if(nDamage > 0)
      {
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
      }
    }
    oTarget =GetNextObjectInShape(SHAPE_SPHERE, 20.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
  }
}

void DoBonusXP (int nBonus)
{
  object oKiller = GetLastKiller();
  object oKilledArea = GetArea (oKiller);
  object oPC = GetFirstFactionMember(oKiller);

  while(GetIsObjectValid(oPC))
    {
      if (oKilledArea == GetArea(oPC))
        {
          int oPCMaxXP= GetLocalInt ( oPC,"XPMax");
          SetLocalInt (oPC, "XPMax", oPCMaxXP+nBonus);
          GiveXPToCreature(oPC, nBonus);
          SendMessageToPC(oPC, "Received Bonus XP: "+IntToString(nBonus));
        }
      oPC = GetNextFactionMember(oKiller, TRUE);
    }
}

void main()
{
  object oDead = OBJECT_SELF;
  string sTag = GetTag(oDead);
  object oPC = GetLastKiller();
// Section for those with tags that will create explosion effect
  string sFive = GetStringLeft(sTag,5);
  if (sFive == "boom_") DoKaboom();
// Start of the Creatures with special effects or spawns.

// Kydonia High Mage
  if (sTag == "minohighmage")
  {
    object oTarget = GetNearestObjectByTag("BonTower_8");
    SetLocked(oTarget, FALSE);
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
    DelayCommand(1800.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
    SetLocked(oTarget, TRUE);
  }

  // Seed Of Hate
  if (sTag == "pc_zarekdfgkey")
  {
    object oTarget = GetNearestObjectByTag("pc_zarektempledoor");
    SetLocked(oTarget, FALSE);
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
    DelayCommand(1800.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
    SetLocked(oTarget, TRUE);
  }

  // Captain Jhoulie Rhoger
  if (sTag == "captjhoulie")
  {
    object oDeadChest = GetNearestObjectByTag("corsairschest");
    if (!GetIsObjectValid(oDeadChest))
    {
      if (GetIsNight())
      {
        object oChestPoint = GetWaypointByTag("WP_corsairschest");
        location lDMCSpawn=GetLocation(oChestPoint);
        CreateObject(OBJECT_TYPE_PLACEABLE,"corsairschest",lDMCSpawn);
      }
    }
    location locLocation= GetLocation( OBJECT_SELF); // Find the location of the death drop
  }

  if (sTag == "pc_zarek")
  {
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPC),FALSE, OBJECT_TYPE_CREATURE);
    while (oTarget != OBJECT_INVALID & GetIsPC(oTarget))
    {
      SetLocalInt(oTarget,"cultydead",1);
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oPC),FALSE, OBJECT_TYPE_CREATURE);
    }
    SetLocalInt(oPC,"cultydead",1);
  }

// Risen Familiar - unlock door on death.
  if (sTag == "pc_WhisperBoss")
  {
    object oTarget = GetObjectByTag("pc_WhisperDoor");
    SetLocalInt(oTarget,"Lockable",1);
    DelayCommand(900.0, SetLocalInt(oTarget,"Lockable",0));
    SetLocked(oTarget, FALSE);
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
  }

 //Mortife Additions
  if (sTag == "pc_MajorColds")
  {
    object oTarget = GetNearestObjectByTag("pc_NorthernGate");
    SetLocked(oTarget, FALSE);
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
    DelayCommand(1800.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
    SetLocked(oTarget, TRUE);
  }

  if (sTag == "pc_MajorBurns")
  {
    object oTarget = GetNearestObjectByTag("pc_SouthernGate");
    SetLocked(oTarget, FALSE);
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
    DelayCommand(1800.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
    SetLocked(oTarget, TRUE);
  }

  if (sTag == "pc_MajorUnderwood")
  {
    object oTarget = GetNearestObjectByTag("pc_UWGate");
    SetLocked(oTarget, FALSE);
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
    DelayCommand(1800.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
    SetLocked(oTarget, TRUE);
  }

  if (sTag == "pc_wolf")
  {
    location lSpawn = GetLocation(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_CREATURE, "pc_were", lSpawn);
  }

  if (sTag == "boom_4p_pc_MortifeGeneral")
  {
    location lSpawn = GetLocation(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_PLACEABLE, "pc_SOPGiver", lSpawn);
    object oTarget;
    oTarget = GetObjectByTag("pc_SOPGiver");
    DelayCommand(1500.0, DestroyObject(oTarget, 0.0));
  }

 // Ice on death open
  if (sTag == "ice_hdrogan001")
  {
    object oTarget = GetNearestObjectByTag("ice_Lth_11");
    SetLocked(oTarget, FALSE);
    AssignCommand(oTarget, ActionOpenDoor(oTarget));
    DelayCommand(1800.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));
    SetLocked(oTarget, TRUE);
  }

  return;
}
