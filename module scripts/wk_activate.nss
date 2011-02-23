/////::///////////////////////////////////////////
/////:: wk_activate - Main Mod activation script for Altharia
/////:: Written by Winterknight for Altharia 5/25/07
/////::///////////////////////////////////////////

#include "x0_i0_position"

void main()
{
    if (GetLocalInt  (GetArea(GetObjectByTag("SecureArea")), "dmwands")==0)
      {
       ExecuteScript("dmfi_activate", GetItemActivator());
      }
///////////////////////////////////////////////////////////////////////////////
    object oItem=GetItemActivated();
    string oName = GetTag(oItem);
    object oTarget = GetItemActivatedTarget();
    object oPC = GetItemActivator();
    location lLocation=GetItemActivatedTargetLocation();
    string sLeft9 = GetStringLeft(oName,9);

///////////////////////////////////////////////////////////////////////////////
    if ( oName == "earofstats" )
      {
       int iSTR= GetAbilityScore(oTarget,ABILITY_STRENGTH);
       int iDEX= GetAbilityScore(oTarget,ABILITY_DEXTERITY);
       int iCON= GetAbilityScore(oTarget,ABILITY_CONSTITUTION);
       int iINT= GetAbilityScore(oTarget,ABILITY_INTELLIGENCE);
       int iWIZ= GetAbilityScore(oTarget,ABILITY_WISDOM);
       int iCHR= GetAbilityScore(oTarget,ABILITY_CHARISMA);

       SendMessageToPC(oPC, "STR: "+ IntToString (iSTR));
       SendMessageToPC(oPC, "DEX: "+ IntToString (iDEX));
       SendMessageToPC(oPC, "CON: "+ IntToString (iCON));
       SendMessageToPC(oPC, "INT: "+ IntToString (iINT));
       SendMessageToPC(oPC, "WIZ: "+ IntToString (iWIZ));
       SendMessageToPC(oPC, "CHR: "+ IntToString (iCHR));
       SendMessageToPC(oPC, "Total: "+ IntToString (iWIZ+ iINT +iCON+ iDEX+ iSTR +iCHR));
       return;
      }
//////////////Sack, now crystal of refracted light//////////////////////////////
    if ( oName == "sackofdust" )
        {
        AssignCommand(oPC, ActionStartConversation(OBJECT_SELF, "act_gemrefract", TRUE));
        }

//////////////Wand of Stats/////////////////////////////////////////////////////
    if ( oName == "wandofstats" )
        {
        AssignCommand(oPC, ActionStartConversation(OBJECT_SELF, "wandofdata", TRUE));
        }

////////////////////////////////////////////////////////////////////////////////
// DM' Ring                                                                   //
////////////////////////////////////////////////////////////////////////////////
  if (oName == "dm_onering")
  {
    if (!GetIsDM(oPC))
    {
      SendMessageToPC(oPC,"Only DM's may use this ring!");
      SendMessageToAllDMs("Player "+GetName(oPC)+" is using The One Ring!");
      return;
    }
    oTarget = GetItemActivatedTarget();
    if (GetIsPC(oTarget))
    {
      SetLocalObject(oPC,"PCTarget",oTarget);
      SetLocalLocation(oPC,"lSpawn",GetBehindLocation(oTarget));
    }
    else SetLocalLocation(oPC,"lSpawn",GetItemActivatedTargetLocation());
    ActionStartConversation(OBJECT_SELF,"con_dm_onering",TRUE,FALSE);
  }


 //////  druids white herb summoning
  if ( oName == "whiteherb" )
        {
        effect eSummon;
        location lLocation;
        string element;
        int  driudlevel= GetLevelByClass(CLASS_TYPE_DRUID,oPC);

         if (driudlevel < 41)
        { element ="whitewingedlizar";}
         if (driudlevel < 36)
        { element ="whitechimp";}
        if (driudlevel < 30)
        { element ="whiterooster";}
        if (driudlevel < 25)
        { element ="whitespider";}
        if (driudlevel <20)
        { element ="whitestag";}
         if (driudlevel <15)
        { element ="whitewolf";}
         if (driudlevel < 10)
        { element ="whitelion";}
        if (driudlevel < 5)
        { element ="whitebear";}

        eSummon = EffectSummonCreature(element,VFX_FNF_LOS_NORMAL_30,0.5f);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSummon, oPC, 1800.0f);
        AddHenchman ( oPC, GetObjectByTag(element));
        }

  if ( oName == "magestaff"||
       oName == "harmonics"||
       oName == "stilletto"||
       oName == "whitegold"||
       oName == "innerpath"||
       oName == "archerbow"||
       oName == "vesperbel"||
       oName == "holysword"||
       oName == "fulminate")
       {

        if (GetCurrentHitPoints(oPC) < 3000)
        {
          PlaySound ("as_mg_frstmagic1");
          ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_SOUND_BURST),oPC);
          effect TempHP=EffectTemporaryHitpoints(1000);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,TempHP,oPC,1200.0f);
        }
        AssignCommand(oPC, ActionStartConversation(OBJECT_SELF, "act_"+oName, TRUE));
       }

   //////  ranger summoning
  if ( oName == "mahoganybug" )
        {
        effect eSummon;
        location lLocation;
        string element;
        int  driudlevel= GetLevelByClass(CLASS_TYPE_RANGER,oPC);

         if (driudlevel < 41)
        { element ="forestwingedliza";}
         if (driudlevel < 36)
        { element ="forestfalcon";}
        if (driudlevel < 30)
        { element ="forestfey";}
        if (driudlevel < 25)
        { element ="forestspider";}
        if (driudlevel <20)
        { element ="foreststag";}
         if (driudlevel <15)
        { element ="forestwolf";}
         if (driudlevel < 10)
        { element ="forestfeline";}
        if (driudlevel < 5)
        { element ="forestbear";}

        eSummon = EffectSummonCreature(element,VFX_FNF_LOS_NORMAL_30,0.5f);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSummon, oPC, 1800.0f);
        AddHenchman ( oPC, GetObjectByTag(element));
        }

    // arcane quiver

    if ( oName == "arcanequiver" || oName == "bottomlessbulle"|| oName == "bundleofbolts")
      {
       int  PClevel= GetHitDice(oPC);
       int iAA=  GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC);
       string sArrow="" ;
       string sArrow1="soulssteelrain";
       string sArrow2="soulssteelaura";
       string sArrow3="soulssteelfire";
       string sArrow4="soulssteelice";
       string sArrow5="soulssteelacid";
       string sArrow6="soulssteelmyth";
       if (oName == "bottomlessbulle")
         {
          sArrow1="dantesteelrain";
          sArrow2="dantesteelaura";
          sArrow3="dantesteelfire";
          sArrow4="dantesteelice";
          sArrow5="dantesteelacid";
         }
         if (oName == "bundleofbolts")
           {
            sArrow1="runessteelrain";
            sArrow2="runessteelaura";
            sArrow3="runessteelfire";
            sArrow4="runessteelice";
            sArrow5="runessteelacid";
           }
       object oItemToTake;

       //destroy all the old arrows
         oItemToTake = GetItemPossessedBy(oPC,sArrow1+"15");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
         oItemToTake = GetItemPossessedBy(oPC,sArrow1+"20");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
         oItemToTake = GetItemPossessedBy(oPC,sArrow1+"25");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
         oItemToTake = GetItemPossessedBy(oPC,sArrow1+"30");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
         oItemToTake = GetItemPossessedBy(oPC,sArrow1+"35");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
         oItemToTake = GetItemPossessedBy(oPC,sArrow1+"40");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
         oItemToTake = GetItemPossessedBy(oPC, sArrow1+"45");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
         oItemToTake = GetItemPossessedBy(oPC, sArrow2+"15");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow2+"20");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow2+"25");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow2+"30");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow2+"35");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow2+"40");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow2+"45");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow3+"15");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow3+"20");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow3+"25");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow3+"30");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow3+"35");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow3+"40");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow3+"45");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow4+"15");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow4+"20");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow4+"25");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow4+"30");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow4+"35");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow4+"40");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow4+"45");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow5+"15");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC,sArrow5+"20");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow5+"25");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow5+"30");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow5+"35");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow5+"40");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow5+"45");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow6+"40");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);
        oItemToTake = GetItemPossessedBy(oPC, sArrow6+"45");
       if(GetIsObjectValid(oItemToTake) != 0) DestroyObject(oItemToTake);

       if (PClevel == 40)
         {
         sArrow ="40";
         if (iAA >20)sArrow ="45";
         }
       if (PClevel < 40)
         {
         sArrow ="35";
         if (iAA >20)sArrow ="40";
         }
       if (PClevel < 35)
         {
         sArrow ="30";
         if (iAA >15)sArrow ="35";
         }
       if (PClevel < 30)
         {
         sArrow ="25";
         if (iAA >10)sArrow ="30";
         }
       if (PClevel < 25)
         {
         sArrow ="20";
         if (iAA >5)sArrow ="25";
         }
       if (PClevel <20) sArrow ="15";


       // make the arrows
       CreateItemOnObject(sArrow1+sArrow, oPC, 99);
       SetItemStackSize(GetItemPossessedBy(oPC, sArrow1+sArrow),99);

       CreateItemOnObject(sArrow2+sArrow, oPC, 99);
       SetItemStackSize(GetItemPossessedBy(oPC, sArrow2+sArrow),99);

       CreateItemOnObject(sArrow3+sArrow, oPC, 99);
       SetItemStackSize(GetItemPossessedBy(oPC, sArrow3+sArrow),99);

       CreateItemOnObject(sArrow4+sArrow, oPC, 99);
       SetItemStackSize(GetItemPossessedBy(oPC, sArrow4+sArrow),99);

       CreateItemOnObject(sArrow5+sArrow, oPC, 99);
       SetItemStackSize(GetItemPossessedBy(oPC, sArrow5+sArrow),99);

       if (GetCampaignInt("12dark2","mithril",oPC) >= 300)
         {
         CreateItemOnObject(sArrow6+sArrow, oPC, 99);
         SetItemStackSize(GetItemPossessedBy(oPC, sArrow6+sArrow),99);
         }
         return;

      }

    if ( oName == "dmsring0089" )
      {
       DelayCommand(1.0, AssignCommand(oPC, JumpToObject(GetObjectByTag("asecurearea"))));
       return ;
      }
//////////////////////////////////////////////////////////////////////////
    if ( oName == "nodestone_giants"  )
     //nodestone_giants (Three Peaks Pass)
    {
       ExecuteScript("nodestone_giants",oItem);
       return;
    }
//////////////////////////////////////////////////////////////////////////
    if ( oName == "nodestone_abyss"  )
     //nodestone_delath
    {
       ExecuteScript("nodestone_abyss",oItem);
       return;
    }
//////////////////////////////////////////////////////////////////////////
    if ( oName == "nodestone_delath"  )
     //nodestone_delath
    {
       ExecuteScript("nodestone_delath",oItem);
       return;
    }
//////////////////////////////////////////////////////////////////////////
    if ( oName == "nodestone_deepho"  )
     //nodestone_deephold
    {
       ExecuteScript("nodestone_deepho",oItem);
       return;
    }
//////////////////////////////////////////////////////////////////////////
    if ( oName == "jehonianelixir" ||
         oName == "jehonbenediction")
     //temple recall potion
    {
       ExecuteScript("jehonianelixir2",oItem);
       return;
    }
//////////////////////////////////////////////////////////////////////////
    if ( oName == "combinednodes")
     //combined nodestone device
    {
       string sArea = GetTag(GetArea(oPC));
       string sPref = GetStringLeft(sArea,5);
       if (sPref == "Dela_") ExecuteScript("nodestone_delath",oItem);
       if (sPref == "Abyss") ExecuteScript("nodestone_abyss", oItem);
       if (sPref == "Viis_") ExecuteScript("nodestone_deepho",oItem);
       if (sPref == "3ppp_" ||
           sPref == "3ppf_" ||
           sPref == "3ppc_" ||
           sPref == "3pps_") ExecuteScript("nodestone_giants",oItem);
       if (sPref == "Than_") ExecuteScript("nodestone_thanwa",oItem);
       if (sPref == "Gate_") ExecuteScript("nodestone_drakar",oItem);
       if (sPref == "Riftt") ExecuteScript("nodestone_dragon",oItem);
    }



////////////Guild Armor Activation////////////////////////////////////////
    if ( oName == "guild_lyt" ||
         oName == "guild_med" ||
         oName == "guild_hvy")
    {
       string sClass = GetCampaignString("Character","guild",oPC);
       string sTotal = "guild_act_"+sClass;
       int nCheck = GetLocalInt(oPC,"guild_uses");
       if (nCheck < 3)
         {
           ExecuteScript(sTotal,oItem);
           nCheck++;
           SetLocalInt(oPC,"guild_uses",nCheck);
         }
       return;
    }
//////////////////////////////////////////////////////////////////////////

    if ( oName == "sacredsymbol" )
      {
       object oTarget=GetItemActivatedTarget();
       if (  GetIsReactionTypeHostile (  oTarget,oPC))
         {
          int iPercent =5;
          int iSC= GetSkillRank(SKILL_SPELLCRAFT,oPC);
          int iUMD= GetSkillRank(SKILL_USE_MAGIC_DEVICE,oPC);
          iPercent= iPercent +( iSC +iUMD)/4;
          if (GetRacialType(oTarget)==RACIAL_TYPE_OUTSIDER)
            { iPercent=iPercent *2;
            if (iPercent > 25) iPercent =25;
            }
          else
            {
            if (iPercent > 10) iPercent =10;
            }

          int nDam=FloatToInt(IntToFloat(GetMaxHitPoints(oTarget))* iPercent/100);
          effect eDam = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_PLUS_TWENTY);
          ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oTarget));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(487),oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED),oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM),oTarget);
          DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oTarget));
          return;
         }

      }
/////////////// Antir's Sextant ///////////////////////
    if ( oName == "antirssextant" )
      {
        if (GetIsPC(oPC))
          {
            object oArea = GetArea(oPC);
            string sArea = GetTag(oArea);
            string sLeft4 = GetStringLeft(sArea,4);
          // List area exclusions here.  Some areas we don't want them to map.
            if (sLeft4 != "bvos")
              {
                ExploreAreaForPlayer(oArea,oPC);
          // This is so the server will remember where they've been.
          // Used in conjunction with the areamapcheck script - not all areas
          // are permanently mappable - like Death, and some other areas.
                SetCampaignInt("maps",sArea,1,oPC);
              }
          }
        return;
      }

////////////////////////////////////////////////////////////////////////////////

   if ( oName == "invsweeper" )
     {
      oName=GetTag(oTarget);
      if ( oTarget == OBJECT_INVALID || oTarget == oPC )
        {
         SendMessageToPC(oPC,"Can't destroy that.");
         return ;
        }
        if ( GetItemPossessor(oTarget) != oPC)
          {
           SendMessageToPC(oPC,"Can't destroy that.");
           return ;
          }
        if ( sLeft9 =="nodestone" ||
             oName =="ahramsbles_2" ||
             oName =="antirsbles_2" ||
             oName =="coreksbles_2" ||
             oName =="johansbles_2" ||
             oName =="jehonbless_1_1" ||
             oName =="halshorsbles_2" ||
             oName =="larannasbles_2" ||
             oName =="rechardsbles_2" ||
             oName =="urlecksbles_2" ||
             oName =="sharthanisbles_2" ||
             oName =="katayamoransb_2" ||
             oName =="phaeganndalsb_2" ||
             oName =="imrahadelsbles_2" ||
             oName =="jehonbenediction" ||
             oName =="jehonmalediction" ||
             oName =="combinednodes" ||
             oName =="ahramsbles_1" ||
             oName =="antirsbles_1" ||
             oName =="coreksbles_1" ||
             oName =="johansbles_1" ||
             oName =="jehonbless_1_2" ||
             oName =="halshorsbles_1" ||
             oName =="larannasbles_1" ||
             oName =="rechardsbles_1" ||
             oName =="urlecksbles_1" ||
             oName =="sharthanisbles_1" ||
             oName =="katayamoransb_1" ||
             oName =="phaeganndalsb_1" ||
             oName =="imrahadelsbles_1" ||
             oName =="sackofdust")
           {
             SendMessageToPC(oPC,"That item cannot be destroyed.");
             return ;
           }
        if ( GetHasInventory(oTarget) )
          {
           if ( GetFirstItemInInventory(oTarget) !=  OBJECT_INVALID)
             {
              SendMessageToPC(oPC,"You can only destroy empty containers.");
              return ;
             }
          }

        PlaySound ("as_mg_frstmagic1");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_IMPLOSION),oPC);
        SendMessageToAllDMs (GetName (oPC)+ " has destroyed a "+ GetName (oTarget) + " with the inventory sweeper.");
        DestroyObject(oTarget,1.0f);
        return ;
     }

    // Ear of Relevel
    if ( oName == "earofrelevel" )
      {
       int TargetsXP = GetXP(oTarget);
       SetXP(oTarget, 0);
       SetXP(oTarget, TargetsXP);
       SetCampaignInt("leveler","classcount",1,oPC);
       effect FX = EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, FX,oTarget);
      }
}
