/////::///////////////////////////////////////////
/////:: add_deathefx
/////:: Written by Winterknight for Altharia 8/21/07
/////::///////////////////////////////////////////
/////:: This script is used for builders only.  It is used to add creature
/////:: special death effects into the system. This will not be an in-mod script
/////:: for the main mod. Instead, any creatures used in here will be copied
/////:: to the main mod from this script.  Builders are responsible to ensure
/////:: that creature tags are correct, and that the effect is correct.
/////::///////////////////////////////////////////

// Do not use this script to cause an explosion on death.  Instead, those
// creatures that will blow up on death require only a special tag structure to
// automatically activate that effect:
//   boom_xy_normaltag
//   x = a number from 1 to 5.
//   y = a letter, either m, n, p, or s (lowercase).
//   _normaltag = unique remainder of creature tag, defined by the builder.
// -The prefix boom_ on any tag tells the script that that creature will blow up
// on death.  (You must have a bossloot or the alt_death_and_efx script in the
// creature's OnUserDefined event for this to work).
// -The "x" number (1-5) tells it how many multiples of 200 to use for the base
// damage of the script.  Don't quibble about wanting to do a base of 500, or
// less than 200, or more than a thousand.  Suck it up.
// -The "y" letter tells you what kind of damage is being dealt.  m is magical,
// n is negative, p is positive, s is sonic.  Elemental damages are used so many
// other places in the mod, we wanted to have these damages be different, and
// harder to avoid.

// Do not use this script to drop items.  Use add_deathdrops instead. However,
// this script can be used to spawn other objects, including chests.

// Otherwise, place your special effect script below.  Some sample instructions
// are included, so that you will have a starting point.
/*
 if (sTag == "tag_of_creature")  //sTag is already defined in the main script.
  {
    object oPC = GetLastKiller(); //If you plan to affect the PC, this will
                                  //help you define it.  The main script
                                  //does not target the PC, so you must define
                                  //that variable here.  If not, ignore this.

    DoTheEffect;                  //Write your special effect script, such as
                                  //unlocking a door, or some visual effect.
                                  //Do not use this script for dropping items.

  }                               //Make sure you close your creature loop.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: How to unlock/open a door on death of the creature.
//:: This is a handy way to get around needing keys, but still making sure that
//:: the PC's kill the boss before moving on.
//::////////////////////////////////////////////////////////////////////////////

/*
  This simple script will unlock and open a door on the creature's death.  It
  uses a variable called "Triggered" to determine if the door can be activated
  again within a time limit.  This can be important, if you want to limit how
  often someone can go through the area.

  The DelayCommand is used to reset the "Triggered" variable back to zero after
  the time has lapses (in this case 30 minutes.) The delay is expressed in
  seconds, and must always be a float type variable.
*/
/*
  if (sTag == "tag_of_creature")
  {
    object oDoor = GetObjectByTag("tag_of_door");
    int nCheck = GetLocalInt(oDoor,"Triggered");
    if (nCheck != 1)
    {
      ActionUnlockObject(oDoor);
      ActionOpenDoor(oDoor);
      SetLocalInt(OBJECT_SELF,"Triggered",1);
      DelayCommand(1800.0,SetLocalInt(OBJECT_SELF,"Triggered",0));
    }
  }
*/
//::////////////////////////////////////////////////////////////////////////////
//:: How to spawn a chest or other object on the death of the creature.
//:: This is useful for additional loot, or special objects, or even for
//:: spawning a second "incarnation" of the enemy.
//::////////////////////////////////////////////////////////////////////////////

/*
  This script finds the location of the dying creature, and spawns an object at
  that location.  If you wish to spawn a treasure chest, I suggest that you use
  one of the treasure chests with the wk_chestloot scripts attached.  The
  resrefs are simply wk_lootchest_1 thru wk_lootchest_5.

  If you are using this script to spawn a second creature for combat, make sure
  that the creature you pick as the new spawn is a different creature from the
  one spawning it. Otherwise, you can get trapped in an endless loop of creature
  spawns, if there is no final form to be defeated.

  Refer to the CreateObject command for the restrictions and usage associated
  with it.
*/
/*
  if (sTag == "tag_of_creature")
  {
    location lSpawn = GetLocation(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_CREATURE, "new_critter", lSpawn);
  }

  if (sTag == "another_creature")
  {
    location lSpawn = GetLocation(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_PLACEABLE, "wk_lootchest_2", lSpawn);
  }

/////Emp Preserve Switches

  if (sTag == "pc_wolf")
  {
    location lSpawn = GetLocation(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_CREATURE, "pc_were", lSpawn);
  }



*/
