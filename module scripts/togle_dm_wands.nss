void main()
{
object oArea=GetArea(OBJECT_SELF);
int iIsOn=GetLocalInt( oArea, "dmwands");
 AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
  AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

/////it was on    turn it off
    if (iIsOn !=0)
    {
     SpeakString ("The DM wands are now ON");
     SetLocalInt( oArea, "dmwands",0) ;
    }
   else
    {  //////   turn them on
    SpeakString ("The DM wands are now OFF");
     SetLocalInt( oArea, "dmwands",1);
    }


}
