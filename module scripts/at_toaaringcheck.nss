/////:://///////////////////////////////////////////////////////////////////////
/////:: Check for Specific Guild Ring, ToAA
/////:: Written by Winterknight, modified 11/25/05
/////:://///////////////////////////////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    object oClick = GetClickingObject();
    int nPort;

    if (HasItem(oClick, "toaa_ring_01")) {nPort=1;}
    if (HasItem(oClick, "toaa_ring_02")) {nPort=1;}
    if (HasItem(oClick, "toaa_ring_03")) {nPort=1;}
    if (HasItem(oClick, "toaa_ring_04")) {nPort=1;}
    if (HasItem(oClick, "toaa_ring_05")) {nPort=1;}

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
