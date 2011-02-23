/////::///////////////////////////////////////////
/////:: alt_artifactdrop
/////:: Part of the Unified lootsystem for Altharia
/////:: Written by Winterknight for Altharia 7/31/07
/////::///////////////////////////////////////////

void DropArtifact(object oSack, int nCR)
{
  if (nCR > 2) nCR = 2;
  else nCR = 1;
  string sItem;
  int nDice;

  if (nCR == 1)
  {// Do the low level stuff in here
    nDice = d20();
    switch(nDice)
    {
      case 1: sItem="Render"; break;
      case 2: sItem="pc_RestoreRingSimple"; break;
      case 3: sItem="strikersflail"; break;
      case 4: sItem="pc_BarCloak"; break;
      case 5: sItem="fallenpalshield"; break;
      case 6: sItem="defilersedge"; break;
      case 7: sItem="shadowkukri"; break;
      case 8: sItem="i31_dp_bluespide"; break;
      case 9: sItem="i31_trollhalberd"; break;
      case 10: sItem="i31_guardsheild1"; break;
      case 11: sItem="ice_myrlongswor1"; break;
      case 12: sItem="i31_vampspear"; break;
      case 13: sItem="rift_insidlbow"; break;
      case 14: sItem="i31_dp_egg"; break;
      case 15: sItem="i31_badgertooth"; break;
      case 16: sItem="ice_spiderfang1"; break;
      case 17: sItem="i31_badgertooth"; break;
      case 18: sItem="i31_bloodtalonhe"; break;
      case 19: sItem="pc_swlizgsword"; break;
      case 20: sItem="i31_hydrostinger"; break;
    }
  }

  if (nCR == 2)
  {// Do the low level stuff in here
    nDice = Random(22)+1;
    switch(nDice)
    {
      case 1: sItem="dawnsherald"; break;
      case 2: sItem="jp_arvonskama"; break;
      case 3: sItem="khavarlegacy"; break;
      case 4: sItem="rift_revkatana1"; break;
      case 5: sItem="jp_scimicereav"; break;
      case 6: sItem="jp_arvonscry"; break;
      case 7: sItem="mc_whiswind"; break;
      case 8: sItem="hydroganswand001"; break;
      case 9: sItem="ice_sslusionssta"; break;
      case 10: sItem="i31_guardaxe_1"; break;
      case 11: sItem="minstrel"; break;
      case 12: sItem="pc_formanblazon"; break;
      case 13: sItem="breakeroffaith"; break;
      case 14: sItem="rift_thdrbs1"; break;
      case 15: sItem="jp_rembsflame"; break;
      case 16: sItem="rift_magickiller"; break;
      case 17: sItem="shadowofavanar"; break;
      case 18: sItem="celewardersword"; break;
      case 19: sItem="pc_swlizgsword"; break;
      case 20: sItem="blackenedsoul"; break;
      case 21: sItem="spearoftheshaka"; break;
      case 22: sItem="grimharvester"; break;
    }
  }

      CreateItemOnObject(sItem,oSack,1);

}

//void main(){}
