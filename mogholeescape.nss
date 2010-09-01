/////:://///////////////////////////////////////////////////////////////////////
/////::Revised Jehonian Elixir script
/////::Modified by Winterknight
/////:://///////////////////////////////////////////////////////////////////////
void PortPC(object oUser)
{
  // Jump the PC to the Temple in Delath
  DelayCommand(0.5, AssignCommand(oUser, JumpToObject(GetObjectByTag("WP_pc_escapetribal"))));
}
void main()
{
  // modified from Portal script.
  object oUser = GetPCSpeaker();
  AssignCommand(GetModule(), PortPC(oUser));

}

