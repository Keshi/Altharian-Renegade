/////::///////////////////////////////////////////
/////:: wk_deathdrops
/////:: Part of the Unified lootsystem for Altharia
/////:: Written by Winterknight for Altharia 7/21/07
/////::///////////////////////////////////////////
/////:: Calling Scripts include:
/////:: alt_drop_and_efx (for non-bossloot creatures)
/////:: wk_bossloot_* (for all bossloot creatures).
/////::///////////////////////////////////////////

#include "wk_lootsystem"
#include "alt_artifactdrop"

int FindCritterLevel(object oDead)
{
  float fCR= GetChallengeRating(oDead);
  int nLevel;
  if (fCR < 75.0) nLevel = 1;
  else if (fCR < 250.0) nLevel = 2;
  else if (fCR < 750.0) nLevel = 3;
  else if (fCR < 1500.0) nLevel = 4;
  else if (fCR >= 1500.0) nLevel = 5;
  return nLevel;
}

string GetSpecialDrops()
{
    int nDice;
    string sItem;
    string sTag = GetTag(OBJECT_SELF);


    if (GetTag (OBJECT_SELF)=="pc_Violencia")
      {
        sItem="violenciaward";
      }

    if (GetTag (OBJECT_SELF)=="boom_5n_lordoftheunde")
      {
        sItem="deathskull";
      }

    if (GetTag (OBJECT_SELF)=="ArchonofBarsdale")
      {
        sItem="jds_smallarckey";
      }

    if (GetTag (OBJECT_SELF)=="pc_IceProtector")
      {
        nDice=2;
        sItem="mithrildust" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_IceMiner")
      {
        nDice=2;
        sItem="mithrildust" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_SentientCold")
      {
        nDice=2;
        sItem="mithrilchip" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_RedForman")
      {
        sItem="pc_formanblazon" ;
      }

    if (GetTag (OBJECT_SELF)=="undeadcaptain")
      {
        sItem="deadcaptainshead" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_FirePrince")
      {
        nDice=2;
        sItem="mithrilchip" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_FireDancer2")
      {
        sItem="mithrilchip" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_LivingFire" )
      {
        int iDice=Random(4);
        if (iDice==0) sItem="mithrilchip" ;
        if (iDice==1) sItem="mithrilchip" ;
        if (iDice==2) sItem="mithrilnugget" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_NullElement" )
      {
        nDice = 2;
        sItem="mithrilnugget";
      }

    if (GetTag (OBJECT_SELF)=="pc_StormStriker")
      {
        nDice=4;
        sItem="mithrilnugget" ;
      }

    if (GetTag (OBJECT_SELF)=="LieutenantPralg")
      {
        sItem = "pc_riverlookinnkey" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_LizardQueen")
      {
        sItem = "pc_rune";
      }

    if (GetTag (OBJECT_SELF)=="pc_SWLizDruid2")
      {
        sItem = "pc_BarKey" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_SWLizDruid")
      {
        nDice=5;
        sItem="pc_rune";
      }

    if (GetTag (OBJECT_SELF)=="pc_SWLizBow")
      {
        int iDice=Random(8);
        if (iDice==0) sItem="pc_SWLizBow" ;
        if (iDice==1) sItem="coll_token001" ;
        if (iDice==2) sItem="coll_token001" ;
      }

    if (GetTag (OBJECT_SELF)=="pc_zarek")
      {
        sItem="pc_sohkey";
      }

    if (GetTag (OBJECT_SELF)=="mc_mithgolcont")
      {
        int iDice=Random(3);
        if (iDice==0) sItem="mithrilchip" ;
        if (iDice==1) sItem="mithrilchip" ;
        if (iDice==2) sItem="mithrilnugget" ;
      }

    if (GetTag (OBJECT_SELF)=="mc_mithgolem")
      {
        nDice=4;
        sItem="mithrildust";
      }

    if (GetTag(OBJECT_SELF)=="mc_mithrildrone1")
      {
        nDice=4;
        sItem="mithrilchip";
      }

    if (GetTag(OBJECT_SELF)=="mc_mithgolem2")
      {
        nDice=3;
        sItem="mithrildust";
      }

    if (GetTag(OBJECT_SELF)=="brutak")
      {
        sItem="brutakspine";
      }

    if (GetTag (OBJECT_SELF)=="BkwatchighPriest")
      {
        sItem="antiraltarkey" ;
      }

    if (GetTag (OBJECT_SELF)=="boom_4m_RiftBoss")
      {
        sItem="wish001" ;
      }

    if (GetTag (OBJECT_SELF)=="zakros")
      {
        sItem="wish001" ;
      }

/// Ruins Banner (Lota Replacement)
     if (sTag == "boom_5n_RuinsBanner")
      {
        sItem = "ultimatewish";
      }

///Ruin Head
    if (sTag == "boom_3n_RuinHead")
      {
        int iDice=Random(20);
        if (iDice==0) sItem="demonsruin" ;
        if (iDice==2) sItem="coll_token004" ;
        if (iDice==13) sItem="coll_token004" ;
      }
/// To Drop Ruins Edge

    if (sTag == "boom_2n_LootRuinDem")
      {
        nDice = 4;
        sItem = "sacredsymbol";
      }

    if (sTag == "DroneFactoryOverseer")
      {
        nDice = 10;
        sItem = "sc_ringofweaponr";
      }

///Kyar
    if (sTag == "pc_KyarIQ")
      {
        sItem = "jp_kyarcaptring";
      }

    if (sTag == "pc_KyarMiner")
      {
        int iDice=Random(6);
        if (iDice==0) sItem="mithrildust" ;
        if (iDice==2) sItem="mithrildust" ;
        if (iDice==3) sItem="coll_token001" ;
      }

/// Werewolf
    if (GetTag (OBJECT_SELF)=="pc_were")
      {
        int iDice=Random(8);
        if (iDice==0) sItem="coll_token001" ;
      }


/// Hydro Guys
    if (GetTag (OBJECT_SELF)=="ice_hydrofighter001")
      {
        int iDice=Random(6);
        if (iDice==0) sItem="coll_token001" ;
      }


/// Werewolf
    if (GetTag (OBJECT_SELF)=="ice_hydromage01")
      {
        int iDice=Random(6);
        if (iDice==0) sItem="coll_token002" ;
      }

/// Barsdale Defiler
    if (GetTag (OBJECT_SELF)=="barsdaledefiler")
      {
        int iDice=Random(8);
        if (iDice==0) sItem="coll_token002" ;
      }

/// Rift Dragon
    if (GetTag (OBJECT_SELF)=="pc_RiftDragon")
      {
        int iDice=Random(8);
        if (iDice==0) sItem="coll_token004" ;
      }

///Hell Golem Key Drop
    if (sTag == "pc_zarekdfgkey")
      {
        sItem = "pc_sohkey";
      }

// Loops for creation of objects, checks for creation.

  if (nDice == 0 & sItem != "")
  {
    return sItem;
  }
  if (nDice > 0)
  {
    int nRoll = Random(nDice);
    if (nRoll < 1 & sItem != "")
    {
      return sItem;
    }
    else sItem ="";
  }
  return sItem;
}

void main ()
{
  object oDead = OBJECT_SELF;
  location lDrop = GetLocation(oDead);
  object oSack;
  int nItems, nCR, nDice;
  string sItem = GetSpecialDrops();    // Get the resref of the item drop
  nDice = GetLocalInt(oDead,"BossLoot");
  nCR = GetLocalInt(oDead,"lootlevel");
  if (nCR == 0 & nDice == 0)
  {
    nDice = d20();
    if (nDice < 2) nCR = FindCritterLevel(oDead);
    nDice = 0;
  }
  if (sItem != "")
  {
    oSack = CreateObject(OBJECT_TYPE_PLACEABLE, "wk_bodysack", lDrop, FALSE);
    SetName(oSack,"A Strange Sack");
    CreateItemOnObject(sItem,oSack,1);
    nItems++;
  }

  if (nDice == 0)
  {
    if (nItems < nCR)
    {
      nDice = d100();
      if (nDice < 3 & oSack == OBJECT_INVALID)
      {
        oSack = CreateObject(OBJECT_TYPE_PLACEABLE, "wk_bodysack", lDrop, FALSE);
        SetName(oSack,"A Strange Sack");
      }

      if (nDice == 1)
      {
        DropArtifact(oSack, nCR);
      }
      if (nDice == 2)
      {
        DoChumpLoot(oSack, nCR);
      }
    }
    nDice = d20();
    if (nDice <= nCR & nCR >= 1)
    {
      if (oSack == OBJECT_INVALID)
      {
        oSack = CreateObject(OBJECT_TYPE_PLACEABLE, "wk_bodysack", lDrop, FALSE);
        SetName(oSack,"A Strange Sack");
      }
      if (nCR > 3) nCR = 3;
      DropCollChip(oSack,nCR);    // Collector drop. 5% chance per CR
    }
  }
  return;
}
