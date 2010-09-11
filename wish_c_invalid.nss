// Carson 2010-9-11
// Part of the automated wishing system
#include "inc_wish"

// True if the player CANNOT proceed in the conversation
int StartingConditional()
{
    object player = GetPCSpeaker();
    struct Abilities mod = ReadCurrentAbilityModSettings(player);
    return !CanPlayerAffordAbilityMod(player,mod);
}
