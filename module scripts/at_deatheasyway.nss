
void main()
{
object oClicker = GetClickingObject();
 int Is20 =  GetXP (oClicker);
  if(Is20<1000000)
   {
    SendMessageToPC  (oClicker,  "You must be Truly Worthy to use this portal.");
   }
   else
   {

  object oTarget = GetTransitionTarget(OBJECT_SELF);
  location lLoc = GetLocation(oTarget);
    AssignCommand(oClicker,JumpToLocation(lLoc));
   }

}
