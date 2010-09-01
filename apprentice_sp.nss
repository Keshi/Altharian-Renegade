#include "x0_i0_anims"
void main()
{
    SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);

    SetListening(OBJECT_SELF,TRUE);
    SetListenPattern(OBJECT_SELF,"**", 101);
}

