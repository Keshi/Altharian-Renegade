//Script Name: counterrod
//////////////////////////////////////////
//Created By: Genisys (Guile)
//Created On: 9/4/08
/////////////////////////////////////////
/*
  This is a tagbase item script for the
  item tagnamed "speedcaster", it will
  run through all of the user's memorized
  spells and have them buff themself very
  fast!  This is the item, because you
  do not have to keep charging the item!
*/
////////////////////////////////////////

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    object oPC;         //The caster
    object oItem;       //This item
    object oTarget;     //The Target of the Item

    int nResult = X2_EXECUTE_SCRIPT_CONTINUE;

//this handles "use" or activation of item.
 if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
 {
   oItem = GetItemActivated();
   oPC = GetItemActivator();
   oTarget = GetItemActivatedTarget();

//They have to target a creature..
if(GetObjectType(oTarget)!= OBJECT_TYPE_CREATURE)
{
 FloatingTextStringOnCreature("You must target a creature!", oPC, FALSE);
 return;
}

    //They must be a caster to use the item!
if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0))
   {

    //They must be a caster to use the item!
 if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0))
    {
    AssignCommand(oPC, ActionCounterSpell(oTarget));
    }

   }
  //If it's not a caster they are targeting...
  else
  {
   string sMsg = "The target is not a spell caster!";
   FloatingTextStringOnCreature(sMsg, oPC, FALSE);
   return;
  }
}



 //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}
