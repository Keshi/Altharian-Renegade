/////:://////////////////////////////////
/////:: Clean Spring script on disturbed for Johan Grove
/////:: Written by Winterknight, modified from grinder script.
/////:://////////////////////////////////

void WhatsInForge();
void ZeroAllVariables();
void CreateSomething(string szThing);

void main()
{
    //Check to see if inventory has been added
    //On added to
    if (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED)
    {
        //Find if proper ingredients are in the Altar
        WhatsInForge();

        //Reliquary
        if (GetLocalInt(OBJECT_SELF, "nElixir") > 0)
        {
            //Create Visual Effect

               location lSpring = GetLocation(GetObjectByTag("HalshorsAltar"));
               DelayCommand(0.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), lSpring));

                //Adjust the variables
                SetLocalInt(OBJECT_SELF, "nElixir", GetLocalInt(OBJECT_SELF, "nElixir") - 1);

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
        if (GetTag(oItem) == "halshorsreliquary")
        {
            SetLocalInt(OBJECT_SELF, "nElixir", GetLocalInt(OBJECT_SELF, "nElixir") + 1);
        }
        oItem = GetNextItemInInventory();
    }

}
void ZeroAllVariables()
{
    SetLocalInt(OBJECT_SELF, "nElixir", 0);
}

void CreateSomething(string szThing)
{
    CreateItemOnObject(szThing);
}
