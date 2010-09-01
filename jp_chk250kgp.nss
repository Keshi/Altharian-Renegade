int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetGold(oPC) < 250000) return FALSE;

return TRUE;
}
