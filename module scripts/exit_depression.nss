void main()
{
    object oJumper=GetExitingObject();
    if ( GetIsPC(oJumper))
    {

      SetLocalInt(OBJECT_SELF,"howmany",GetLocalInt(OBJECT_SELF,"howmany")-1);
      SendMessageToAllDMs(" The number of people in Depression is: "+IntToString(GetLocalInt(OBJECT_SELF,"howmany")));

     }
}
