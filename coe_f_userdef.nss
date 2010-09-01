#include "x0_i0_corpses"

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == EVENT_HEARTBEAT) {

    } else if (nEvent == EVENT_PERCEIVE) {

    } else if (nEvent == EVENT_DIALOGUE) {

    } else if (nEvent == EVENT_DISTURBED) {

    } else if (nEvent == EVENT_ATTACKED) {

    } else if (nEvent == EVENT_DAMAGED) {

    } else if (nEvent == EVENT_END_COMBAT_ROUND) {

    } else if (nEvent == EVENT_SPELL_CAST_AT) {

    } else if (nEvent == 1007) {

       // golems leave bodies only if the scavenger is still alive.
       object oScavenger = GetObjectByTag("kres_coe_cleric");
       if(oScavenger != OBJECT_INVALID)
       {
            SetObjectIsDestroyable(OBJECT_SELF, FALSE, TRUE);
            DoActualKilling(OBJECT_SELF);
       }

    }

}
