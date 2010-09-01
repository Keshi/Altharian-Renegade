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

void createhack(string sRef,object oChest)
{
    CreateItemOnObject(sRef,oChest,1);
}

void main()
{
object oChest=GetObjectByTag("PotionConverter");
object oPC=GetLastUsedBy();
int iDice;
string sRef;
//////// Use this to flip the lever as a last resort
//float direction=GetFacing(OBJECT_SELF);
//if ( direction != 270.0 ) direction = 270.0;
//    else direction = 90.0;
//SetFacing(direction);
  AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));


 AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

object oFirstItem ;
object oSecondItem;
   oFirstItem=GetFirstItemInInventory(oChest);
   oSecondItem=GetNextItemInInventory(oChest);
object  oThirdItem=GetNextItemInInventory(oChest);


///////////////////////////////////////////////////////////
///////////////////3 UNSTACKED

if (   GetTag(oFirstItem)=="foultastingliquid"  &&
       GetTag(oSecondItem)=="foultastingliquid"  &&
       GetTag(oThirdItem)=="foultastingliquid") {

    iDice=Random(3);

       // NOTE NOTE NOTE NOTE   These blueprints MUST be in Custom items.
  //  sRef="kh_custom_"+IntToString(iDice);
    if (iDice==0)
        {
        int iDice2=Random(8);
        sRef="kh_custom_"+IntToString(iDice2);
        }

    if (iDice==2)
        {
        sRef="kh_custom_8";
        }

     if (iDice==1)
        {
        sRef="kh_custom_9";
        }

    DestroyInventory(oChest);
//    SpeakString("Creating "+sRef,TALKVOLUME_TALK);
    DelayCommand(0.1f,createhack(sRef,oChest));
     SendMessageToPC (oPC, "The still boils and sputters, and makes a new potion.");

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POISON_L), oChest);
}else


///////////////////////////////////////////////////////////
///////////////////3 STACKED

if (   GetTag(oFirstItem)=="foultastingliquid"  &&
        GetNumStackedItems(oFirstItem) >2){

    iDice=Random(3);

       // NOTE NOTE NOTE NOTE   These blueprints MUST be in Custom items.
  //  sRef="kh_custom_"+IntToString(iDice);
    if (iDice==0)
        {
        int iDice2=Random(8);
        sRef="kh_custom_"+IntToString(iDice2);
        }

    if (iDice==2)
        {
        sRef="kh_custom_8";
        }

     if (iDice==1)
    {
    sRef="kh_custom_9";
    }

    DestroyInventory(oChest);
//    SpeakString("Creating "+sRef,TALKVOLUME_TALK);
    DelayCommand(0.1f,createhack(sRef,oChest));
     SendMessageToPC (oPC, "The still boils and sputters, and makes a new potion.");

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POISON_L), oChest);
}else

///////////////////////////////////////////////////////////
//////////////////2 UNSTACKED  1 UNSTACKED


if (   GetTag(oFirstItem)=="foultastingliquid"  &&
            GetTag(oSecondItem)=="foultastingliquid"  &&
        GetNumStackedItems(oFirstItem) + GetNumStackedItems(oSecondItem)>2){

    iDice=Random(3);

       // NOTE NOTE NOTE NOTE   These blueprints MUST be in Custom items.
  //  sRef="kh_custom_"+IntToString(iDice);
    if (iDice==0)
        {
        int iDice2=Random(8);
        sRef="kh_custom_"+IntToString(iDice2);
        }

    if (iDice==2)
        {
        sRef="kh_custom_8";
        }

     if (iDice==1)
    {
    sRef="kh_custom_9";
    }

    DestroyInventory(oChest);
//    SpeakString("Creating "+sRef,TALKVOLUME_TALK);
    DelayCommand(0.1f,createhack(sRef,oChest));
     SendMessageToPC (oPC, "The still boils and sputters, and makes a new potion.");

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POISON_L), oChest);
}
else
  ///////////////////////////////////////////////////////////
///////////////////2 LEAVES
    if (    GetTag(oFirstItem) =="NastySmellingleaf"  &&
            GetTag(oSecondItem)=="NastySmellingleaf" )
         {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("kh_custom_1",oChest));
        SendMessageToPC (oPC, "The still boils and sputters, and makes a foul elixir.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oChest);
        }

else
  ///////////////////////////////////////////////////////////
///////////////////2 LEAVES
    if (    GetTag(oFirstItem) =="Greenberry"  &&
            GetTag(oSecondItem)=="Greenberry" )
         {

            DestroyInventory(oChest);

           /// needs secretrecipe
         if(GetIsObjectValid(GetItemPossessedBy(oPC, "secretrecipe")) )
         {

            if(!GetIsObjectValid(GetItemPossessedBy(oPC, "catalyst")) )
            {   ///no catylist
                DelayCommand(0.1f,createhack("greendraft",oChest));
            }
            else
            {   ////has the catylist
                    DelayCommand(0.1f,createhack("greendraft",oChest));
                   DelayCommand(0.1f,createhack("greendraft",oChest));
            }
                  SendMessageToPC (oPC, "The still boils and sputters, and makes a Green Draft.");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BREACH), oChest);
          }
          else
          {  ///greenberries  but no recipe
                SendMessageToPC (oPC, "The still boils and sputters, but produces no useful result.");
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE), oChest);


          }

        }




 else
  ///////////////////////////////////////////////////////////
///////////////////10 acids
    if (    GetTag(oFirstItem) =="smallbottleofaci"  &&
            GetTag(oSecondItem)=="smallbottleofaci"  &&
            GetTag(oSecondItem)=="smallbottleofaci")
         {
          int i10acids =1;
          int test10=4;
          object oTestItem;
          // test next 7 items
           while (test10 <11)
            {
           oTestItem=GetNextItemInInventory(oChest);
           if  (GetTag(oTestItem)!="smallbottleofaci" )i10acids=0 ;
            test10++;
           }

           if (i10acids==1)
            {
            DestroyInventory(oChest);
            /// does player have the catylist
            if(!GetIsObjectValid(GetItemPossessedBy(oPC, "catalyst")) )
            {   ///no catylist

                //eakString("Creating "+sRef,TALKVOLUME_TALK);
                DelayCommand(0.1f,createhack("potofpoison",oChest));
                DelayCommand(0.1f,createhack("potofpoison",oChest));
                DelayCommand(0.1f,createhack("potofpoison",oChest));
            }
            else
            {   ////has the catylist
                //eakString("Creating "+sRef,TALKVOLUME_TALK);
                DelayCommand(0.1f,createhack("potofpoison",oChest));
                DelayCommand(0.1f,createhack("potofpoison",oChest));
                DelayCommand(0.1f,createhack("potofpoison",oChest));
                DelayCommand(0.1f,createhack("potofpoison",oChest));
                DelayCommand(0.1f,createhack("potofpoison",oChest));
                DelayCommand(0.1f,createhack("potofpoison",oChest));
            }


            SendMessageToPC (oPC, "The still boils and sputters, and makes some pots of poison.");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_CHARM), oChest);
            }
          if (i10acids==0)
            {
                SendMessageToPC (oPC, "The still boils and sputters, but produces no useful result.");
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE), oChest);
                DestroyInventory(oChest);
             }




        }
  else
  ///////////////////////////////////////////////////////////
///////////////////10 acids
    if (    GetTag(oFirstItem) =="demonblood"  &&
            GetTag(oSecondItem)=="demonblood"  &&
            GetTag(oSecondItem)=="demonblood")
         {
          int i10acids =1;
          int testnum=3;
          object oTestItem;
          oTestItem=GetNextItemInInventory(oChest);
           while (GetIsObjectValid(oTestItem))
            {
            if  (GetTag(oTestItem)=="demonblood" )testnum++;
            oTestItem=GetNextItemInInventory(oChest);
            }

           if (i10acids==1 && GetIsObjectValid(GetItemPossessedBy(oPC, "catalyst")))
            {
                DestroyInventory(oChest);
            if (testnum<5) i10acids=0;
            if (testnum==5)    DelayCommand(0.1f,createhack("x2_it_dyec36",oChest));
            if (testnum==6)    DelayCommand(0.1f,createhack("x2_it_dyec37",oChest));
            if (testnum==7)    DelayCommand(0.1f,createhack("x2_it_dyel36",oChest));
            if (testnum==8)    DelayCommand(0.1f,createhack("x2_it_dyel37",oChest));
            if (testnum==9)    DelayCommand(0.1f,createhack("x2_it_dyem24",oChest));
            if (testnum==10)    DelayCommand(0.1f,createhack("x2_it_dyem25",oChest));
            if (testnum>10)  i10acids=0;
            SendMessageToPC (oPC, "The still boils and sputters, and converts the Demon Blood.");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_CHARM), oChest);
            }

            if (i10acids==0 || !GetIsObjectValid(GetItemPossessedBy(oPC, "catalyst")))
            {
                SendMessageToPC (oPC, "The still boils and sputters, but produces no useful result.");
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE), oChest);
                DestroyInventory(oChest);
             }




        }





///electrifiedspin
 ///////////////////////////////////////////////////////////
///////////////////3 spines
    if (    GetTag(oFirstItem) =="electrifiedspin"  &&
            GetTag(oSecondItem)=="electrifiedspin"  &&
            GetTag(oSecondItem)=="electrifiedspin")
         {

           if (GetIsObjectValid(GetItemPossessedBy(oPC, "catalyst")) && GetIsObjectValid(GetItemPossessedBy(oPC, "alexandriasrec")))
            {
                DestroyInventory(oChest);
                SendMessageToPC (oPC, "The still boils and sputters, and converts the Electrified Spine.");
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_CHARM), oChest);
                DelayCommand(0.1f,createhack("tempestinabo2",oChest));
                DelayCommand(0.1f,createhack("tempestinabo2",oChest));
                DelayCommand(0.1f,createhack("tempestinabo2",oChest));
            }
            else
            {
                SendMessageToPC (oPC, "The still boils and sputters, and destroys the spines. Perhaps you need a catalyst.");
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE), oChest);
                DestroyInventory(oChest);
             }




        }

 else

    ///////////////////////////////////////////////////////////
///////////////////2 slaads tongues
    if (    GetTag(oFirstItem) =="NW_IT_MSMLMISC10"  &&
            GetTag(oSecondItem)=="NW_IT_MSMLMISC10" )
         {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        if(!GetIsObjectValid(GetItemPossessedBy(oPC, "catalyst")) )
            {   ///no catylist
                DelayCommand(0.1f,createhack("kh_custom_9",oChest));
            }
            else
            {   ////has the catylist
              DelayCommand(0.1f,createhack("kh_custom_9",oChest));
              DelayCommand(0.1f,createhack("kh_custom_9",oChest));
              DelayCommand(0.1f,createhack("kh_custom_9",oChest));
            }
                  SendMessageToPC (oPC, "The still boils and sputters, and makes a foul tasting potion of Heal.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oChest);
        }
else

    ///////////////////////////////////////////////////////////
///////////////////1 eggs and 1 seed makes 2 pathtothelderkind
  if (   GetItemPossessedBy(oChest,"EggShapedCrystal")!=  OBJECT_INVALID &&
        GetItemPossessedBy(oChest,"seedofdestruct")!=  OBJECT_INVALID )

         {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        if(!GetIsObjectValid(GetItemPossessedBy(oPC, "catalyst")) )
            {   ///no catylist
                DelayCommand(0.1f,createhack("pathtotheeld2",oChest));
            }
            else
            {   ////has the catylist
                    DelayCommand(0.1f,createhack("pathtotheeld2",oChest));
                   DelayCommand(0.1f,createhack("pathtotheeld2",oChest));
            }
                  SendMessageToPC (oPC, "The still boils and sputters, and makes an interesting item.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BREACH), oChest);
        }

 else


 ///////////////////////////////////////////////////////////
///////////////////1 LEAF AND 1 LIQUID

 if (   GetItemPossessedBy(oChest,"foultastingliquid")!=  OBJECT_INVALID &&
        GetItemPossessedBy(oChest,"NastySmellingleaf")!=  OBJECT_INVALID )

             {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("healingsalve",oChest));
        SendMessageToPC (oPC, "The still boils and sputters, and makes a nasty salve.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_CONFUSION_S), oChest);
        }

     else
 ///////////////////////////////////////////////////////////
///////////////////1 LIQUID  1 LODESTONE

 if (   GetItemPossessedBy(oChest,"foultastingliquid")!=  OBJECT_INVALID &&
        GetItemPossessedBy(oChest,"lodestone")!=  OBJECT_INVALID )

             {
         DestroyInventory(oChest);
//      SpeakString("Creating "+sRef,TALKVOLUME_TALK);
        DelayCommand(0.1f,createhack("disgustingsalve",oChest));
        SendMessageToPC (oPC, "The still boils and sputters, and makes a disgusting  goo.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGBLUE), oChest);
        }

   else





    {
    SendMessageToPC (oPC, "The still boils and sputters, but produces no useful result.");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE), oChest);
    DestroyInventory(oChest);
    }

   AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
