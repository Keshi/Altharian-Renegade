//::////////////////////////////////////////////
//:: wk_cleansweep
//:: From Bioware boards
//:: Modified by Winterknight for Altharia
//:: Last update 04/21/08
//::////////////////////////////////////////////

// Area OnExit script.
//:://////////////////////////////////////////////////////////////////////////
// When the last PC leaves the area a timer starts. When the timer expires if
// there are no PCs in the area, the area cleaner is initiated. The cleaner:
// 1. Destroys all non-plot, non-immortal creatures in the area that were
//    spawned from a Bioware encounter.
// 2. Destroys all the "Remains" bags left over from battle as long as they
//    do not contain a plot item. All non-plot items inside body bags will
//    get destroyed and if that leaves the body bag empty, it will be
//    destroyed as well.
// 3. Destroys all non-plot items in the area that are lying on the ground.
// 4. Destroys all Area-Of-Effects leftover from spells or traps.
// 5. Closes all open doors in the area and locks those that have locks on them.
//:://////////////////////////////////////////////////////////////////////////


const float CLEANER_TIMER_DELAY = 300.0f; // 5 minutes after last PC leaves the area is cleaned.


// Function to determine if any PCs are in an area.
int GetIsPCInArea(object oArea = OBJECT_SELF)
{
  if (!GetIsObjectValid( oArea) || (GetArea(oArea) != oArea)) return FALSE;

  object oInArea = GetFirstObjectInArea(oArea);
  if (!GetIsObjectValid(oInArea)) return FALSE;
  if (GetIsPC(oInArea)) return TRUE;
  return GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oInArea));
}


// Function to destroy BodyBags, Encounter creatures, and Items left laying around.
// Plot items will be left alone.
// Also closes all open doors in the area and locks ones that have a lock on them.
// Only does all this if the area has no PCs in it.
void CleanArea(object oArea = OBJECT_SELF)
{
  if (!GetIsObjectValid(oArea) || (GetArea(oArea) != oArea) || GetIsPCInArea(oArea)) return;

  object oObject = GetFirstObjectInArea(oArea);
  while (GetIsObjectValid(oObject))
  {
    switch (GetObjectType(oObject))
    {
      case OBJECT_TYPE_CREATURE:
        if (GetIsEncounterCreature(oObject) &&
            !GetPlotFlag(oObject) &&
            !GetImmortal(oObject))
        {
          DestroyObject(oObject, 0.1f);
        }
        break;

      case OBJECT_TYPE_PLACEABLE:
        if (GetTag( oObject) == "BodyBag")
        {
          int bPlotFound = FALSE;
          object oObjectInside = GetFirstItemInInventory(oObject);
          while (GetIsObjectValid(oObjectInside))
          {
            if (GetPlotFlag(oObjectInside)) bPlotFound = TRUE;
            else DestroyObject(oObjectInside, 0.1f);
            oObjectInside = GetNextItemInInventory(oObject);
          }
          if (!bPlotFound) DestroyObject(oObject, 0.2f);
        }
        break;

      case OBJECT_TYPE_ITEM:
        {
          int bPlotFound = GetPlotFlag(oObject);
          if (!bPlotFound && GetHasInventory(oObject))
          {
            object oObjectInside = GetFirstItemInInventory(oObject);
            while (GetIsObjectValid(oObjectInside))
            {
              if (GetPlotFlag(oObjectInside)) bPlotFound = TRUE;
              else DestroyObject(oObjectInside, 0.1f);
              oObjectInside = GetNextItemInInventory(oObject);
            }
          }
          if (!bPlotFound) DestroyObject(oObject, 0.2f);
        }
        break;

      case OBJECT_TYPE_AREA_OF_EFFECT:
        DestroyObject( oObject, 0.1f);
        break;

      case OBJECT_TYPE_DOOR:
        if (GetIsOpen(oObject)) AssignCommand(GetArea(oObject), ActionCloseDoor(oObject));
        if (!GetLocked(oObject) && GetLockLockable(oObject)) AssignCommand(GetArea(oObject), ActionDoCommand(SetLocked(oObject, TRUE)));
        break;

      case OBJECT_TYPE_ENCOUNTER:
        // Nothing to clean up with these.
        // wk modification: set to active, so they can be spawned again.
        SetEncounterActive(TRUE, oObject);
        break;

      case OBJECT_TYPE_STORE:
        // Nothing to clean up with these.
        break;

      case OBJECT_TYPE_TRIGGER:
        // Nothing to clean up with these.
        break;

      case OBJECT_TYPE_WAYPOINT:
        // Nothing to clean up with these.
        break;
    }
    oObject = GetNextObjectInArea(oArea);
  }
}


// Area OnExit main function.
void main()
{
  object oExiting = GetExitingObject();
  if (!GetIsObjectValid(oExiting)) return;

  // Schedule the area cleaner.
  DelayCommand(CLEANER_TIMER_DELAY, CleanArea());
}


