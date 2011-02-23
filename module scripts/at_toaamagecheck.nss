
void main()
{
    object oClick = GetClickingObject();
    int nPort;

    if(GetLevelByClass(CLASS_TYPE_SORCERER, oClick)>=1){nPort=1;}
    if(GetLevelByClass(CLASS_TYPE_PALE_MASTER, oClick)>=1){nPort=1;}
    if(GetLevelByClass(CLASS_TYPE_WIZARD, oClick)>=1){nPort=1;}
    if(nPort!=1)
        {
            SendMessageToPC  (oClick,  "You shall not pass!  Only those with the art may pass.");
        }
    else
        {
            object oTarget = GetTransitionTarget(OBJECT_SELF);
            location lLoc = GetLocation(oTarget);
            AssignCommand(oClick,JumpToLocation(lLoc));
        }

}
