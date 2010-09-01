// Created by: Iznoghoud
//
// A piece of sample code to make polymorphing effects reapply after an
// exportallcharacters.

void main()
{

    ExportAllCharacters();
    // ===== This is the code you need to add =====
    object oPC = GetFirstPC();
    while ( GetIsObjectValid(oPC) ) // Loop through all the Players
    {
        if ( GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC)) )
        {
            ExecuteScript("ws_saveall_sub", oPC);
        }

        oPC = GetNextPC();
    } // while
}

