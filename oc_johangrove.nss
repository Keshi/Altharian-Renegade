//::///////////////////////////////////////////////
//:: OnClick script for Johan Grove trigger - checks to make sure you have the elixir.
//:: Written by Winterknight 9/27/05
//:://////////////////////////////////////////////

void main()
{
    object oPC=GetClickingObject();
    object oItem=GetItemPossessedBy(oPC,"pureelixir");
    object oItem2=GetItemPossessedBy(oPC,"johansbles_1");

    if(!GetIsObjectValid(oItem))
    {
        if(!GetIsObjectValid(oItem2))
            {
            SendMessageToPC (oPC, "Something prevents you from entering here.");
            }
    }
    else
    {
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    location lLoc = GetLocation(oTarget);
    AssignCommand(oPC,JumpToLocation(lLoc));
    }
}
