//::///////////////////////////////////////////////
//:: Greater Ruin
//:: X2_S2_Ruin
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
// The caster deals 35d6 damage to a single target
   fort save for half damage
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 18, 2002
//:://////////////////////////////////////////////

// 2010-9-8, Carson: May be used for certain item spells.  Modified for preliminary PRC compatibility.
//                   We also need to move the Altharia modifications here to the PRC epic ruin spells soon.
#include "inc_epicspells"
#include "prc_alterations"
#include "wk_tools"

void main()
{
    /*
      Spellcast Hook Code
      Added 2003-06-20 by Georg
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more
    */

        if (!X2PreSpellCastCode())
        {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
            return;
        }

    // End of Spell Cast Hook

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nStaff = GetMageStaff(OBJECT_SELF);
    int nDice = GetSkillRank(SKILL_SPELLCRAFT,OBJECT_SELF);
    int nSpellDC = GetEpicSpellSaveDC(OBJECT_SELF);
    int nLevel = GetCasterLevel(OBJECT_SELF);
    if (nStaff >= 3)
    {
        nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        nSpellDC = nSpellDC + (nLevel - 20)/5;
    }
    if (nDice < 35) nDice = 35;

    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);

    int iCount=GetCampaignInt("attic","bottlecount",OBJECT_SELF);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    //Roll damage
    int nDam = d6(nDice);
    if  (GetIsPC(oTarget)) nDam=0;
     //Set damage effect

    if (PRCMySavingThrow(SAVING_THROW_FORT,oTarget,nSpellDC,SAVING_THROW_TYPE_SPELL,OBJECT_SELF) != 0 )
    {
        nDam /=2;
    }

    //-=E/Z=- code assign the damage  it wll be made nehative below
    if (GetName(OBJECT_SELF)=="End of Hope" ||GetName(OBJECT_SELF)=="Abandoned Dreams") nDam=250;
    if (GetName(OBJECT_SELF)=="Wasted Carcass" ) nDam=200;
    if (GetTag(OBJECT_SELF)=="steriledemon" ) nDam=GetMaxHitPoints(oTarget)/4;
    if (GetTag(OBJECT_SELF)=="searingdemon" || GetTag(OBJECT_SELF)=="homleydemon"|| GetTag(OBJECT_SELF)=="debaucheddemon") nDam=GetMaxHitPoints(oTarget)/2;
    if (GetTag(OBJECT_SELF)=="morbiddemon" ) nDam=GetMaxHitPoints(oTarget);
    if (GetTag(OBJECT_SELF)=="frigiddemon" ) nDam=(GetMaxHitPoints(oTarget)*3)/2;
    if (GetName(OBJECT_SELF)=="Kaathaz Watcher" ) nDam=300;
    if (GetName(OBJECT_SELF)=="Kaathaz" ) nDam=GetMaxHitPoints(oTarget)/2;
    if (GetTag(OBJECT_SELF)=="boom_5n_RuinsBanner" ) nDam=1000;
    if (GetTag(OBJECT_SELF)=="boom_3n_RuinHead" ) nDam=500;
    if (GetTag(OBJECT_SELF)=="pc_RuinDemonGreater" ) nDam=300;
    if (GetTag(OBJECT_SELF)=="boom_2n_LootRuinDem" ) nDam=300;
    if (GetTag(OBJECT_SELF)=="boom_1n_RuinDemon" ) nDam=200;



     //  if the caster possesses Demon's Ruin, increase the damage.
     // caster does 25/level   no save
    if(GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF, "demonsruin"))&& !GetIsPC(oTarget) )
    {
     int iSkullcount=GetLocalInt(OBJECT_SELF, "skullcount");
     //int iCount=GetCampaignInt("attic","bottlecount",OBJECT_SELF);

        if (iSkullcount==0 &&  GetHasFeat(FEAT_EPIC_SPELL_RUIN,OBJECT_SELF))
            {
              SetLocalInt(OBJECT_SELF, "skullcount",11);
              iSkullcount=11;
            }

        if (iSkullcount>=0 && iSkullcount<5)
          {
          nDam = nLevel * (25 - (5 * iSkullcount)) + iCount *25;
          //nDam=iCount *25;
          SetLocalInt(OBJECT_SELF, "skullcount",iSkullcount + 1);
          }

        if (iSkullcount>=5 && iSkullcount < 11)
          {
          nDam=0;
          }
  /////////////////////////////////////////////////////
      if (iSkullcount>=11)
          {
          nDam = nLevel * 25 + iCount *25;
          SetLocalInt(OBJECT_SELF, "skullcount",12);
          }

      if (iSkullcount==12)
          {
          nDam = nLevel * 25 + iCount *25;
          SetLocalInt(OBJECT_SELF, "skullcount",13);
          }

       if (iSkullcount==13)
          {
          nDam = nLevel * 20 + iCount *25;
          SetLocalInt(OBJECT_SELF, "skullcount",14);
          }

        if (iSkullcount==14)
          {
          nDam = nLevel * 15 + iCount *25;
          SetLocalInt(OBJECT_SELF, "skullcount",15);
          }
         if (iSkullcount==15)
          {
          nDam = nLevel * 10 + iCount *25;
          //SetLocalInt(OBJECT_SELF, "skullcount",16);
          }


      if (GetTag (oTarget)=="laughingdemon") nDam=nDam/4 ;
      if (GetTag (oTarget)=="kaathazwatcher") nDam=nDam/3;
      if (GetTag (oTarget)=="kaathaz") nDam=nDam/4;
      if (GetTag (oTarget)=="frigiddemon") nDam=nDam/4 ;
      if (GetTag (oTarget)=="hungrydemon") nDam=nDam/4 ;
      if (GetTag (oTarget)=="lordoftheunde") nDam=nDam/4 ;
      if (GetTag (oTarget)=="GreaterGuardMage") nDam=nDam/3 ;
      if (GetTag (oTarget)=="GreaterGuardFight") nDam=nDam/3;
      if (GetTag (oTarget)=="LesserGuardMage") nDam=nDam/2  ;
      if (GetTag (oTarget)=="LesserGuardFight") nDam=nDam/2 ;


    }

    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_PLUS_TWENTY);
      //-=E/Z=- code  but if its a demon, make it negative
        if (GetName(OBJECT_SELF)=="End of Hope" ||
            GetName(OBJECT_SELF)=="Kaathaz Watcher" ||
            GetName(OBJECT_SELF)=="Kaathaz" ||
            GetName(OBJECT_SELF)=="Abandoned Dreams" ||
            GetTag(OBJECT_SELF)=="steriledemon"||
            GetTag(OBJECT_SELF)=="searingdemon"||
            GetName(OBJECT_SELF)=="Wasted Carcass" ||
            GetTag(OBJECT_SELF)=="debaucheddemon" ||
            GetTag(OBJECT_SELF)=="homleydemon"   ||
            GetTag(OBJECT_SELF)=="frigiddemon"   ||
            GetTag(OBJECT_SELF)=="morbiddemon"
            )

              //if player is wearing Demon hair   redise damage 10%
        {
            int nDamage =nDam;
            ///////////////////////insert demon item check here
             int NegImmunity=100;


           object oCloak=GetItemInSlot( INVENTORY_SLOT_CLOAK,oTarget);
           if (GetTag (oCloak)== "demonshaircloa") NegImmunity= NegImmunity-10;

           oCloak=GetItemInSlot( INVENTORY_SLOT_NECK,oTarget);
           if (GetTag(oCloak)=="talismanofde1" ||
               GetTag(oCloak)=="talismanofde2" ||
               GetTag(oCloak)=="talismanofde3" ||
               GetTag(oCloak)=="talismanofde4" ||
               GetTag(oCloak)=="talismanofde5"
              )

            {
            NegImmunity= NegImmunity-10;
            }

            oCloak=GetItemInSlot( INVENTORY_SLOT_BELT,oTarget);
            if (GetTag(oCloak)=="twentysevenint")
            {
            NegImmunity= NegImmunity-20;
            }



            oCloak=GetItemInSlot( INVENTORY_SLOT_CHEST,oTarget);
            if (GetTag(oCloak)=="leafarmor12" ||
               GetTag(oCloak)=="barkarmor003" ||
               GetTag(oCloak)=="twigarmor12" ||
               GetTag(oCloak)=="woodenarmor12"
              )

            {
            NegImmunity= NegImmunity-10;
            }
            nDamage=(nDamage* NegImmunity)/100  ;
////////////////////////insert demon item check here
            nDam=nDamage;


            eDam = EffectDamage(nDam, DAMAGE_TYPE_NEGATIVE);
        }

    ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oTarget));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(487), oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED), oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM), oTarget);
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

}
