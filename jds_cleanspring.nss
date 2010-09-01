/////:://////////////////////////////////
/////:: Clean Spring script on disturbed for Johan Grove
/////:: Written by Winterknight, modified from grinder script.
/////:://////////////////////////////////

void WhatsInForge();
void ZeroAllVariables();

void main()
{
    //Check to see if inventory has been added or removed...
    //On added to
    if (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED
      ||GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED)
    {
        //Find if proper ingredients are in the Divine Forge
        WhatsInForge();

        //Pimpcane and golems heart
        if (GetLocalInt(OBJECT_SELF, "nElixir") > 0)
        {
            //Create Visual Effect
                location lSpring = GetLocation(GetWaypointByTag("WP_PoisonSparks"));

              //Adjust the variables
                SetLocalInt(OBJECT_SELF, "nElixir", GetLocalInt(OBJECT_SELF, "nElixir") - 1);
                string szString = "heavyminerals";
                object oToDestroy = GetItemPossessedBy(OBJECT_SELF, "pureelixir");
                DelayCommand(0.2,DestroyObject(oToDestroy));
                ActionWait(0.75);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), lSpring);
                CreateItemOnObject(szString,OBJECT_SELF,1);
                ActionSpeakString("The elixir congeals some of the sediment.",TALKVOLUME_TALK);

        }
    }
}
//Sets the variables on what is in the forge currently
void WhatsInForge()
{
    int nStackSize;
    ZeroAllVariables();
    object oItem = GetFirstItemInInventory();
    while(oItem != OBJECT_INVALID)
    {
        //Pimp Cane
        if (GetTag(oItem) == "pureelixir")
        {
            SetLocalInt(OBJECT_SELF, "nElixir", GetLocalInt(OBJECT_SELF, "nElixir") + 1);
        }
        //Golems Heart
        else if (GetTag(oItem) == "heavyminerals")
        {
            SetLocalInt(OBJECT_SELF, "nMinerals", GetLocalInt(OBJECT_SELF, "nMinerals") + 1);
        }

        oItem = GetNextItemInInventory();
    }

}
void ZeroAllVariables()
{
    SetLocalInt(OBJECT_SELF, "nMinerals", 0);
    SetLocalInt(OBJECT_SELF, "nElixir", 0);
}
