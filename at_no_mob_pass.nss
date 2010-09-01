
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);

 // SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
  int x=1;
   if (GetIsPC (oClicker))
   {
  AssignCommand(oClicker,JumpToObject(oTarget));
    }
}
