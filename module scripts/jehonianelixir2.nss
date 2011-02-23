/////:://///////////////////////////////////////////////////////////////////////
/////::Revised Jehonian Elixir script
/////::Modified by Winterknight
/////:://///////////////////////////////////////////////////////////////////////
void PortPC(object oUser)
{
  // Jump the PC to the Temple in Delath
  DelayCommand(1.0, AssignCommand(oUser, JumpToObject(GetObjectByTag("WP_Temple_RECALL"))));
  // Sound and special effects
  PlaySound ("as_mg_telepout1");
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_DISPEL_GREATER),oUser);
}
void main()
{
  // modified from Portal script.
  object oUser = GetItemActivator();
  object oUserArea = GetArea (oUser);
  string sAreaTag = GetTag(oUserArea);
  int nCanDo = 1;
  location lRecall = GetLocation(oUser);
  // If in Death, route them to the entrance to Death.
  if (sAreaTag == "ChamberofAwakening")
    {
      nCanDo = 0;
    }
  // Set the recall information so the pc can come back to this location*/
  if (nCanDo == 1)
    {
      SetLocalLocation(oUser,"lRecall",lRecall);
      SetLocalInt(oUser,"iHasRecalled",1);
      AssignCommand(GetModule(), PortPC(oUser));
    }
}

