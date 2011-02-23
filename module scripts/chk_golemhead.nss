// In Convo for the Mine Forman in Viisperfjorg- Altharian Adventures

int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "mc_golemhead") == OBJECT_INVALID) return FALSE;

return TRUE;
}

