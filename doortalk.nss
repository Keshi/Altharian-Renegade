void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  location lLoc = GetLocation(oTarget);
       SpeakString ("Behind this door is a dark passageway that leads through a maze of twists and turns.If you enter this labyrinth, you will not be able to find your way back to this place.", TALKVOLUME_TALK) ;

}
