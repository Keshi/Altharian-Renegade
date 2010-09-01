/////::///////////////////////////////////////////
/////:: add_deathdrops
/////:: Written by Winterknight for Altharia 8/21/07
/////::///////////////////////////////////////////
/////:: This script is used for builders only.  It is used to add creature
/////:: special drops into the system. This will not be an in-mod script for
/////:: the main mod. Instead, any creatures used in here will be copied
/////:: to the main mod from this script.  Builders are responsible to ensure
/////:: that creature tags are correct, and that the item resref is correct.
/////::///////////////////////////////////////////
/*

// Use the following format for any item drop that needs to be consistent.
// I.e., use this one when you want the item to drop every time the creature
// is killed.  Examples would be Zarek in Silent Hills, who needs to drop his
// key.  Do NOT use any special tags for creatures that just need any random
// chance of loot.  This can be combined with the bossloot system, if you
// need to have a fixed special item drop, as well as boss type loot.
// Copy the following lines (without the comments) and type in your information
// as needed, paste below the line at the bottom of the script.

    if (sTag == "tag_of_creature")       // Tag of creature dropping item
      {
        sItem = "resref_of_item";        // RESREF of dropped item
      }
////////////////////////////////////////////////////////////////////////////////

// Use the following format for items that may or may not drop from a creature.
// In general, if it's just a random item like a weapon or armor, we prefer
// to use the bossloot system, or the alt_drop_and_efx script, which has a
// random chance for any associated creatures to drop a special item.  However,
// for some creatures this provides a valuable way to drop special items on a
// random basis.  The best example of this is mithril dust/chips/nugget item
// drops from the mines or the 3 Peaks areas.
// Copy the following lines (without the comments) and type in your information
// as needed, paste below the line at the bottom of the script.

    if (sTag == "tag_of_creature")       // Tag of creature dropping item
      {
        nDice = 4;                       // Integer number (no decimals) **
        sItem = "resref_of_item";        // RESREF of dropped item
      }
// ** The number used for the nDice value is basically the size of die the
// engine will roll to determine if the item drops.  Base your number choice on
// a 1 in X chance of dropping, where X is the number you have selected.
// For example, if you want an item to drop 50% of the time, you would use 2 as
// the nDice value.  A 25% chance would use an integer of 4.

////////////////////////////////////////////////////////////////////////////////

// Use the following format for creatures where you want a random chance of
// dropping more than one type of item.  Only one item will drop, but you may
// offer multiple choices through this method.  An example would be if you had
// a creature that USUALLY dropped 1 type of item but you wanted a small chance
// of a higher level of item to drop.  This is a bit more advanced type of
// item drop, so it should be used with care.
// Copy the following lines (without the comments) and type in your information
// as needed, paste below the line at the bottom of the script.

    if (sTag == "tag_of_creature")          // Tag of creature dropping item
      {
        int iDice=Random(4);                // Range of possibilities for roll.
        if (iDice==0) sItem="resref_one" ;  // With the options shown, there
        if (iDice==1) sItem="resref_one" ;  // are two items that can drop. A
        if (iDice==2) sItem="resref_two" ;  // 50% chance of item 1, 25% item 2,
      }                                     // and a 25% chance of no item drop.

// Paste your specific code below the following line:  Do not compile.
////////////////////////////////////////////////////////////////////////////////

         if (sTag == "DroneFactoryOverseer")
      {
        nDice = 10;
        sItem = "sc_ringofweaponr";




}
*/
