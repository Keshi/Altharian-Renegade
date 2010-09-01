/////:://///////////////////////////////////////////////////////////////////////
/////:: Jump to Antir's Past
/////:: Written by Winterknight on 2/9/06
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oJumpPoint = GetWaypointByTag("WP_distantshore");
  location lJumpPoint = GetLocation(oJumpPoint);
  effect eSFX = GetFirstEffect(oPC);
  while (GetIsEffectValid(eSFX))
      {
        object oCreator = GetEffectCreator(eSFX);
        if (oCreator == OBJECT_SELF)
            {
              RemoveEffect(oPC, eSFX);
            }
        eSFX = GetNextEffect(oPC);
      }
  DelayCommand(1.5, AssignCommand(oPC,JumpToLocation(lJumpPoint)));
}
