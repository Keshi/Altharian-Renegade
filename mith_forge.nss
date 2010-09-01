
void DestroyInventory(object oSource)
{
int i;
object oInvent;
        oInvent=GetFirstItemInInventory(oSource);
        while (GetIsObjectValid(oInvent)) {
             if (GetBaseItemType(oInvent) == BASE_ITEM_LARGEBOX)
                    DestroyInventory(oInvent);
                   DestroyObject(oInvent,1.0f);
                    oInvent=GetNextItemInInventory(oSource);
        }

}

void createhack(string sRef,object oChest , int iStackSize)
{
    CreateItemOnObject(sRef,oChest,iStackSize);
}

void main()
{
object oChest=GetObjectByTag("mith_forge");
object oPC=GetLastUsedBy();
int iStack   ;
int iDice;
string sRef;
//////// Use this to flip the lever as a last resort
//float direction=GetFacing(OBJECT_SELF);
//if ( direction != 270.0 ) direction = 270.0;
//    else direction = 90.0;
//SetFacing(direction);
  AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));


 AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));


object oFirstItem=GetFirstItemInInventory(oChest);
object oSecondItem=GetNextItemInInventory(oChest);
object oThirdItem=GetNextItemInInventory(oChest);
  //Mithril Ring 1-5
if (   GetTag(oFirstItem)=="mc_mithring_001"   &&
       GetTag(oSecondItem)=="mc_mithring_001"  &&
       GetTag(oThirdItem)=="mc_mithring_001")
            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("mc_mithring_002",oChest,1));
        SendMessageToPC (oPC, "The 3 rings merge together to form a new ring.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_HOWL_MIND), oChest);
        }
else    if (  GetTag(oFirstItem)=="mc_mithring_002"  &&
       GetTag(oSecondItem)=="mc_mithring_002"  &&
       GetTag(oThirdItem)=="mc_mithring_002"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("mc_mithring_003",oChest,1));
        SendMessageToPC (oPC, "The 3 rings merge together to form a new ring.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_TIME_STOP), oChest);
        }
 else    if (  GetTag(oFirstItem)=="mc_mithring_003"  &&
       GetTag(oSecondItem)=="mc_mithring_003"  &&
       GetTag(oThirdItem)=="mc_mithring_003"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("mc_mithring_004",oChest,1));
        SendMessageToPC (oPC, "The 3 rings merge together to form a new ring.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_GLOBE_USE), oChest);
        }

else if (GetTag(oFirstItem)=="mc_mithring_004"  &&
         GetTag(oSecondItem)=="mc_mithring_004"  &&
         GetTag(oThirdItem)=="mc_mithring_004" )
        {
          DestroyInventory(oChest);
          DelayCommand(0.1f,createhack("mc_mithring_005",oChest,1));
          SendMessageToPC (oPC, "A ring of awesome craftsmanship is created.You doubt 3 these can be forged together.");
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_GHOST_SMOKE_2), oChest);
        }
       //End of Mithril Ring line
else if (GetTag(oFirstItem)=="fallenpalshield"  &&
         GetTag(oSecondItem)=="fallenpalshield"  &&
         GetTag(oThirdItem)=="fallenpalshield" )
        {
          DestroyInventory(oChest);
          DelayCommand(0.1f,createhack("paladium",oChest,1));
          SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

else if (GetItemPossessedBy(oChest,"nickel")!=  OBJECT_INVALID &&
         GetItemPossessedBy(oChest,"paladium")!=  OBJECT_INVALID &&
         GetItemPossessedBy(oChest,"goldnugget")!=  OBJECT_INVALID )
        {
          DestroyInventory(oChest);
          DelayCommand(0.1f,createhack("whitegold",oChest,1));
          SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

else if (GetTag(oFirstItem)=="whitegold"  &&
         GetTag(oSecondItem)=="whitegold"  &&
         GetTag(oThirdItem)=="whitegold" )
        {
          DestroyInventory(oChest);
          DelayCommand(0.1f,createhack("ring_whitegold",oChest,1));
          SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

else if (GetTag(oFirstItem)=="demonskin"  &&
         GetTag(oSecondItem)=="demonskin"  &&
         GetTag(oThirdItem)=="demonskin" )
        {
          DestroyInventory(oChest);
          DelayCommand(0.1f,createhack("weap_demskinwhip",oChest,1));
          SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES), oChest);
        }
 else    if (   GetTag(oFirstItem)=="weap_demskinwhip"  &&
       GetTag(oSecondItem)=="weap_demskinwhip"  &&
       GetTag(oThirdItem)=="weap_demskinwhip")

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("weap_ademskwhip",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES), oChest);
        }
  else    if (   GetTag(oFirstItem)=="demonhide"  &&
       GetTag(oSecondItem)=="demonhorn"  &&
       GetTag(oThirdItem)=="demonscale")

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("demonhorndagger",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES), oChest);
        }

 else    if (   GetTag(oFirstItem)=="demonscale"  &&
       GetTag(oSecondItem)=="demonscale" &&
       GetTag(oThirdItem)=="demonscale")

            {
        DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("shield_smdemon",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HARM), oChest);
        }




   else    if (   GetTag(oFirstItem)=="shield_smdemon"  &&
       GetTag(oSecondItem)=="shield_smdemon" &&
       GetTag(oThirdItem)=="shield_smdemon")

            {
        DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("shield_lgdemon",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HARM), oChest);
        }







else    if (   GetTag(oFirstItem)=="demonhide"  &&
       GetTag(oSecondItem)=="demonhide"  &&
       GetTag(oThirdItem)=="demonhide")

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("boot_demonhide",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES), oChest);
        }

///////////
//////////
///////// Bronze items
else    if (  GetTag(oFirstItem)=="demonstooth"  &&
       GetTag(oSecondItem)=="demonstooth"  &&
       GetTag(oThirdItem)=="demonstooth"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("weap_demonfang",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES), oChest);
        }


else    if (  GetTag(oFirstItem)=="weap_demonfang"  &&
       GetTag(oSecondItem)=="weap_demonfang"  &&
       GetTag(oThirdItem)=="weap_demonfang"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("weap_dembiteds",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES), oChest);
        }


////////
///////
/////// brass items
    else    if (  GetTag(oFirstItem)=="pieceofbrass"  &&
       GetTag(oSecondItem)=="pieceofbrass"  &&
       GetTag(oThirdItem)=="pieceofbrass"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("brasscasting",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }


    else    if (  GetTag(oFirstItem)=="brasscasting"  &&
       GetTag(oSecondItem)=="brasscasting"  &&
       GetTag(oThirdItem)=="brasscasting"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("brassdagger",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magic item is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }


  ////////// Scrap iron
  else    if (  GetTag(oFirstItem)=="ScrapIron"  &&
       GetTag(oSecondItem)=="ScrapIron"  &&
       GetTag(oThirdItem)=="ScrapIron"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("ironring",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a magical ring is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

     else    if (  GetTag(oFirstItem)=="goldennugget"  &&
       GetTag(oSecondItem)=="goldennugget"  &&
       GetTag(oThirdItem)=="goldennugget"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("poundofgold",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a pound of gold is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

         else    if (  GetTag(oFirstItem)=="poundofgold"  &&
       GetTag(oSecondItem)=="poundofgold"  &&
       GetTag(oThirdItem)=="poundofgold"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("goldenrune",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and a golden rune is created.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

 /////////////////////////////////////////////
 //????????????????????????????????????????????/
 //interlocking


     else    if (  GetTag(oFirstItem)=="oneinterlocking"  &&
       GetTag(oSecondItem)=="oneinterlocking"  &&
       GetTag(oThirdItem)=="oneinterlocking"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("threeinterlocki",oChest,1));
        SendMessageToPC (oPC, "A strange thing happens in the forge and the scales are forged together.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

       else    if (  GetTag(oFirstItem)=="threeinterlocki"  &&
       GetTag(oSecondItem)=="threeinterlocki"  &&
       GetTag(oThirdItem)=="threeinterlocki"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("nineinterlockin",oChest,1));
   SendMessageToPC (oPC, "A strange thing happens in the forge and the scales are forged together.");
             ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }

     else    if (  GetTag(oFirstItem)=="nineinterlockin"  &&
       GetTag(oSecondItem)=="nineinterlockin"  &&
       GetTag(oThirdItem)=="nineinterlockin"
        )

            {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("twentysevenint",oChest,1));
   SendMessageToPC (oPC, "A strange thing happens in the forge and the scales are forged together.");
             ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oChest);
        }




   else
    {
    SendMessageToPC (oPC, "The forge burns brightly, but produces no useful result.");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE), oChest);
    DestroyInventory(oChest);
    }

   AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
