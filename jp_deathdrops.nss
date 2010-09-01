#include "NW_I0_GENERIC"

void main()
{

    int nObjectType ;
    string strTemplate ;

    if (GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
      {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
      }

    int iDice;
    string sItem, sItem2;
    //object oPC = GetLastKiller();

    // Crypt Defender
    if (GetTag (OBJECT_SELF)=="jp_arvonmonk")
      {
        sItem2 = "jp_5kgp" ;
        iDice=Random(25);
        if (iDice==1) sItem="jp_arvonskama" ;
      }

    // Crypt Guardian
    if (GetTag (OBJECT_SELF)=="jp_arvonguard")
      {
        sItem2 = "jp_5kgp" ;
        iDice=Random(25);
        if (iDice==1) sItem="jp_arvonscry" ;
      }

    // Crypt Emmisary
    if (GetTag (OBJECT_SELF)=="jp_mortcleric")
      {
        sItem2 = "jp_10kgp" ;
        iDice=Random(25);
        if (iDice==1) sItem="jp_arvonbreath" ;
      }

    // Ancient Spirit of Mortife
    if (GetTag (OBJECT_SELF)=="jp_crypt3boss")
      {
        iDice=Random(20);
        if (iDice==0)  sItem="jp_morthammer";
        if (iDice==1)  sItem="jp_ringregen10";
        if (iDice==2)  sItem="jp_amortscimi";
        if (iDice==3)  sItem="jp_amortkama";
        if (iDice==4)  sItem="jp_amortmstar";
      }

    // Ancient Commander of Mortife
    if (GetTag (OBJECT_SELF)=="jp_crypt4boss")
      {
        iDice=Random(5);
        if (iDice==0)  sItem="jp_morthammer";
        if (iDice==1)  sItem="jp_ringregen10";
        if (iDice==2)  sItem="jp_amortscimi";
        if (iDice==3)  sItem="jp_amortkama";
        if (iDice==4)  sItem="jp_amortmstar";
      }

    // Heretic Bard
    if (GetTag (OBJECT_SELF)=="jp_hereticbard1")
      {
        sItem2 = "jp_1kgp" ;
        iDice=Random(20);
        if (iDice==1)sItem="jp_herrapier1";
      }

    // Heretic Monk
    if (GetTag (OBJECT_SELF)=="jp_hereticmonk1")
      {
        sItem2 = "jp_1kgp" ;
        iDice=Random(20);
        if (iDice==1)sItem="jp_herkama1";
      }

    // Heretic Fighter
    if (GetTag (OBJECT_SELF)=="jp_hereticfig1")
      {
        sItem2 = "jp_1kgp" ;
        iDice=Random(20);
        if (iDice==1)sItem="jp_herkatana1";
      }

    // Heretic Elite
    if (GetTag (OBJECT_SELF)=="jp_hereticelite")
      {
        sItem2 = "jp_3kgp" ;
      }

    // Heretic Leader
    if (GetTag (OBJECT_SELF)=="jp_hereticleader")
      {
        sItem2 = "jp_5kgp" ;
        iDice=Random(3);
        if (iDice==0)  sItem="jp_herkama2";
        if (iDice==1)  sItem="jp_herkatana2";
        if (iDice==2)  sItem="jp_herrapier2";
      }

    //
    if (GetTag (OBJECT_SELF)=="jp_minmaster")
      {
        sItem2 = "wish" ;
        iDice=Random(3);
        if (iDice==0)  sItem="jp_minohelm";
        if (iDice==1)  sItem="jp_minotoken";
        if (iDice==2)  sItem="jp_50kgp";
      }
    location locLocation= GetLocation( OBJECT_SELF); // Find the location of the death drop
    if (sItem != "") CreateObject(OBJECT_TYPE_ITEM,sItem, locLocation, TRUE);
    if (sItem2 == "wish") CreateObject(OBJECT_TYPE_ITEM,sItem2, locLocation, TRUE);
    else if (sItem2 != "" ) ExecuteScript(sItem2,OBJECT_SELF);
}
