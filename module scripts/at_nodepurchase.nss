// at_nodepurchase: Purchase the Delath Node Stone
// Created by Gameskippy on 2-6-05
// *****

void main()
{

    // Take gold for purchase
    TakeGoldFromCreature(1000, GetPCSpeaker(), TRUE);
    // Give Delath Nodestone to Player
    object oPC = GetPCSpeaker();

    CreateItemOnObject("truestonedelath", oPC);

}
