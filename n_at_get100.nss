#include "x0_i0_anims"
void main()
{
    TakeGoldFromCreature(100, GetPCSpeaker());
    SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);
}
