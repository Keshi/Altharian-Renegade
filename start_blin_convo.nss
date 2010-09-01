void main()
{
object oPC = GetLastUsedBy();
//Clear PC action queue
AssignCommand(oPC, ClearAllActions(TRUE));
//Start affiliated convo (if no convo affiliated, convo file name must go between quotes
DelayCommand(0.2, ActionStartConversation(oPC, "convo_blinc", FALSE, FALSE));
//Turn on animation, so that it never appears to go off
PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
}

