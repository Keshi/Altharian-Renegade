//:://///////////////////
//:: cw_mod_onequip
//:://///////////////////
//:: Created By: Old Crow
//:: Created On:
//::////////////////////
void main()
  {
   object oItem = GetPCItemLastEquipped();
   object oPC = GetPCItemLastEquippedBy();
   string sItemTag = GetTag(oItem);
//::edigitz_set
if (sItemTag == "digitz_cowl" || sItemTag == "digitz_links" || sItemTag == "digitz_gloves")
ExecuteScript("edigitz_set", OBJECT_SELF);
//::eset_two
else if(sItemTag == "st_my_helm" || sItemTag == "st_my_belt" || sItemTag == "st_my_chest")
ExecuteScript("eset_two", OBJECT_SELF);

else if(sItemTag == "rsg_bluetorch")
ExecuteScript("rsg_glowspell", OBJECT_SELF);

else if(sItemTag == "rsg_redtorch")
ExecuteScript("rsg_glowspell1", OBJECT_SELF);

else
   {
//:: Remove this line if you are not using single item add props.
ExecuteScript("eq_"+GetTag(GetPCItemLastEquipped()), OBJECT_SELF);
}
}
