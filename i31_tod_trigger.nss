// TOD Encounter Trigger
//::///////////////////////
// This script enables you to use a trigger to make an encounter spawn only during
// a specific time of day (TOD). There are four time periods used: dawn, day, dusk,
// and night. You can specify any combination of those four TODs on the trigger to
// tell it when you want the encounter to spawn. To use this, all your encounters
// must have different tags. You can, however have two or more TOD triggers
// associated with the same encounter by giving them all the same tag.
// Typically what you do is place your encounter down on the map, then place a TOD
// trigger down so that it completely overlaps the encounter trigger with a little
// space to spare all the way around it. You place it so that there is no way to
// get to the encounter trigger without first going through the TOD trigger. The
// TOD trigger will activate and deactivate the encounter trigger based on the time
// of day. Note that the encounter trigger is still the one used to determine if
// the spawn should occur when the encounter is active. A player must walk onto the
// encounter trigger just as he would without the TOD trigger.
//::///////////////////////
// Triggers are associated with an encounter object by thier tag names.
// The trigger tag = "TOD_" +TagOfEncounter
// If you have an encounter with a tag "myEncounter" then you can associate a
// TOD Encounter Trigger to it by making the trigger's tag be "TOD_myEncounter"
// and placing this script into the trigger's OnEnter event.
//::///////////////////////
// Putting this script into the OnEnter script of a trigger will turn that trigger
// into a TOD Encounter Trigger. Set up the tag names of the trigger and some
// encounter you want to associate with the trigger as described above. Then enter
// the TOD Spawn code into the KeyTag field in the Advanced tab of the properties
// screen of the trigger. The first 4 letters of this key will be used as the code
// and the rest of the key tag will be ignored.
// TOD Spawn Code format is 4 letters:
//   1st letter is Dawn  - "S" = spawn at dawn, "N" = don't spawn at dawn.
//   2nd letter is Day   - "S" = spawn at day, "N" = don't spawn at day.
//   3rd letter is Dusk  - "S" = spawn at dusk, "N" = don't spawn at dusk.
//   4th letter is Night - "S" = spawn at night, "N" = don't spawn at night.
// Examples: NNSS = spawn at dusk and night, don't spawn at dawn or daytime.
//           nSnn = spawn during day only.
//           S_S_ = spawn at dusk and dawn only.
// Note you can use any letter instead of "N" to disable spawns during that
// time of day, but if you use "S" or "s" you will enable spawning.
//::///////////////////////
// Note thet if the trigger's tag does not match up with any encounter correctly
// or if the keytag entered into the trigger is less than 4 letters long, the
// trigger will do nothing at all to the encounter.
// Note also that only the first four letters of the KeyTag field are used for the
// TOD code so you can still use the rest of the KeyTag field for your own purposes
// as long as you remember the first four letters will be used to determine the
// time of day code.
//::///////////////////////
// The faction of the trigger should be set to match the faction of the encounter.
// You can play with the Faction setting of the trigger to get one type of creature
// to set them off but if its different than the encounter its not clear if the
// spawns will happen outside the specified time restrictions. I suspect that will
// happen sometimes depending on what the two factions are and how they relate to
// each other and how they relate to NPCs or PCs.
//
// These triggers work when any creature (NPC or PC) walks over them.
//::///////////////////////



// Trigger OnEnter script main function
void main()
{ // Get the tag name of this trigger.
  string sEncounter = GetTag( OBJECT_SELF);

  // If its not a Time Of Day Trigger return.
  if( GetStringLeft( sEncounter, 4) != "TOD_") return;

  // Find the associated encounter, return if not found.
  sEncounter = GetStringRight( sEncounter, GetStringLength( sEncounter) -4);
  object oEncounter = GetObjectByTag( sEncounter);
  if( !GetIsObjectValid( oEncounter)) return;

  // Get the TOD spawn code from the trigger key and validate it.
  string sKey = GetLockKeyTag( OBJECT_SELF);
  if( GetStringLength( sKey) < 4) return; // Key specified wrong.

  // This flag will be used to determine if the encounter should be active at
  // the time of day when the trigger was entered.
  int bActivate = FALSE;

  // Activate if its a dawn trigger and time of day is dawn.
  bActivate |= (((GetStringLeft( sKey, 1) == "S") || (GetStringLeft( sKey, 1) == "s")) && GetIsDawn());
  sKey = GetStringRight( sKey, GetStringLength( sKey) -1);

  // Activate if its a day trigger and time of day is day.
  bActivate |= (((GetStringLeft( sKey, 1) == "S") || (GetStringLeft( sKey, 1) == "s")) && GetIsDay());
  sKey = GetStringRight( sKey, GetStringLength( sKey) -1);

  // Activate if its a dusk trigger and time of day is dusk.
  bActivate |= (((GetStringLeft( sKey, 1) == "S") || (GetStringLeft( sKey, 1) == "s")) && GetIsDusk());
  sKey = GetStringRight( sKey, GetStringLength( sKey) -1);

  // Activate if its a night trigger and time of day is night.
  bActivate |= (((GetStringLeft( sKey, 1) == "S") || (GetStringLeft( sKey, 1) == "s")) && GetIsNight());
  sKey = GetStringRight( sKey, GetStringLength( sKey) -1);

  // If this encounter has never been triggered before, initialize it and make sure
  // its activation state is correct. Activation state is stored in a variable on the
  // encounter object. It is an integer and can have 3 possible values, -1/0/1. If
  // it is zero, the encounter has never been entered or triggered. If it is -1, the
  // encounter has been set to be active. If it is 1, the encounter has been set to
  // disabled.
  if( GetLocalInt( oEncounter, "TOD_Deactivated") == 0)
  { SetLocalInt( oEncounter, "TOD_Deactivated", (bActivate ? -1 : 1));
    SetEncounterActive( bActivate, oEncounter);
    return;
  }

  // Activate or deactivate the encounter object as necessary based on its current
  // state and the time of day.
  int iDeactivated = GetLocalInt( oEncounter, "TOD_Deactivated"); // Get current state.
  if( (iDeactivated == 1) && bActivate)
  { // The encounter is deactivated and it should be active, so activate it.
    SetEncounterActive( TRUE, oEncounter);
    SetLocalInt( oEncounter, "TOD_Deactivated", -1);
  }
  else if( (iDeactivated == 1) && !bActivate)
  { // The encounter is deactivated as it should be at this time of day.
    if( GetEncounterActive( oEncounter))
    { // But the encounter object seems to have reactivated itself, or there is
      // a battle in progress. Thats ok, we can just make sure its deactivated.
      // It will keep becoming active again by itself until the battle is over.
      // So everytime someone walks in try to make it deactive. Eventually the
      // battle will end and it will stick.
      SetEncounterActive( FALSE, oEncounter);
    }
  }
  else if( (iDeactivated == -1) && !bActivate)
  { // The encounter is activated and it should be inactive, so deactivate it.
    SetEncounterActive( FALSE, oEncounter);
    SetLocalInt( oEncounter, "TOD_Deactivated", 1);
  }
  else if( (iDeactivated == -1) && bActivate)
  { // The encounter is activated as it should be at this time of day.
    if( !GetEncounterActive( oEncounter))
    { // But the encounter object isn't active. It might be waiting to become
      // active after a previous trigger. Or it could be turned off by mistake
      // and will never re-activate itself. If we force another reactivate on it
      // we will bypass the respawn timer on it. If we don't it may never turn
      // itself on again. If it is indeed turned off by mistake, at least we know
      // it will get fixed on the next day/night cycle. So we will just assume
      // its not messed up but is merely on a respawn delay timer. That way we
      // don't screw up the respawn timer. Therefore, we don't force an activation
      // on it, we just do nothing and assume it will reactivate itself.
      return;
    }
  }
}


