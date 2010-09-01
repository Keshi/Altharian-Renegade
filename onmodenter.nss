#include "nw_i0_plot"

void DestroyItems(object oPC, string sItem)
{
  if(HasItem(oPC, sItem) == TRUE)
  {
    DestroyObject(GetItemPossessedBy(oPC, sItem));
    SendMessageToPC(oPC, "Um dos seus itens foi destruido pois era fruto de trapaca");
  }
}

void main()
{
  object oPC=GetEnteringObject();
  if (GetIsDM(oPC)) return;

  int nXP = GetXP(oPC);
  if (nXP == 0 & GetIsPC(oPC))
  {
    int nTotal;
    int nStat = GetAbilityScore(oPC,ABILITY_CHARISMA,TRUE);
    nTotal=nTotal+nStat;
    nStat = GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE);
    nTotal=nTotal+nStat;
    nStat = GetAbilityScore(oPC,ABILITY_DEXTERITY,TRUE);
    nTotal=nTotal+nStat;
    nStat = GetAbilityScore(oPC,ABILITY_INTELLIGENCE,TRUE);
    nTotal=nTotal+nStat;
    nStat = GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE);
    nTotal=nTotal+nStat;
    nStat = GetAbilityScore(oPC,ABILITY_WISDOM,TRUE);
    nTotal=nTotal+nStat;

    if (nTotal >= 120)
    {
      string sName = GetName(oPC);
      string sCDKEY = GetPCPublicCDKey(oPC);
      SendMessageToAllDMs("ATTENTION!!! Toon "+sName+" CDKEY "+sCDKEY+" has entered with excessive stats.");
      WriteTimestampedLogEntry("ATTENTION!!! Toon  "+sName+" CDKEY "+sCDKEY+" has entered with excessive stats.");
      BootPC(oPC);
    }
    else GiveGoldToCreature(oPC,250);
  }
/////////////////death token stuff

  object oRespawner = oPC;
  if(HasItem(oRespawner, "Death"))
  {

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);

    // Take 10% gold and 10% xp
    // This part of the script teleports the naughty PC to a place of your choosing.
    location lLocation= GetLocation(GetWaypointByTag("WP_Temple_RECALL"));
    AssignCommand(oRespawner,ClearAllActions());
    AssignCommand(oRespawner,JumpToLocation(lLocation));

    object oItemToTake;
    oItemToTake = GetItemPossessedBy(oRespawner, "Death");
    if(GetIsObjectValid(oItemToTake) != 0)
      {
        DestroyObject(oItemToTake);
      }

  }


  if (GetCampaignInt("Hermes", "WAS_CRAFTING", oPC) == TRUE)
  {
    string sCraftedItem = GetCampaignString("Hermes", "CRAFT_OBJECT", oPC);
    DestroyItems(oPC, sCraftedItem);
    string sName = GetName(oPC);
    string sCDKEY = GetPCPublicCDKey(oPC);
    SendMessageToAllDMs("ATTENTION!!! Toon "+sName+" CDKEY "+sCDKEY+" is trying to duplicate an item.");
    WriteTimestampedLogEntry("ATTENTION!!! Toon  "+sName+" CDKEY "+sCDKEY+" is trying to duplicate an item.!!");
    DeleteCampaignVariable("Hermes", "WAS_CRAFTING", oPC);
    DeleteCampaignVariable("Hermes", "CRAFT_OBJECT", oPC);
  }




}
