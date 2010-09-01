
//:://////////////////////////////////////////////
//:: Created By: kurt
//:: Created On: 9/14/02 3:23:34 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
void main()

{
    object oPlayer = GetEnteringObject();
    int iHasMapper = 0;
    if ( GetIsObjectValid(GetItemPossessedBy(oPlayer,"speakersmap")))    iHasMapper =1;

    if ( GetIsObjectValid(oPlayer) && GetIsPC(oPlayer) && iHasMapper ==1)
        {
      object oArea = GetArea(oPlayer);
      ExploreAreaForPlayer(oArea, oPlayer);
        }

   AssignCommand(GetObjectByTag("NW_HOOKER012"),ActionAttack(GetObjectByTag("NW_HOOKER021")));

}


