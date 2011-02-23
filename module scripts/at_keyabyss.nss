/////:://///////////////////////////////////////////////////////////////////////
/////:: Script for checking Book of the Abyss at the door
/////:: Written by Winterknight on 12/4/05
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetClickingObject();
    string sGateTag=GetTag(OBJECT_SELF);
    int nBook;
    int nBookPlayer;
    string sVerse;
    string sBookRoot = "bookoftheabyss0";
    string sBook;
    string sBookPlayer;
    for (nBook=1; nBook < 10; nBook++)
        {
            sVerse = IntToString(nBook);
            sBook = sBookRoot+sVerse;
            if (GetIsObjectValid(GetItemPossessedBy(oPC,sBook)))
                {
                    nBookPlayer = nBook;
                    sBookPlayer = sBook;
                }
        }

    string sGate = GetStringRight(sGateTag,1);
    int nGate = StringToInt(sGate);

    if(nBookPlayer > 0)
        {
            if (nBookPlayer >= nGate)
                {
                    object oTarget = GetTransitionTarget(OBJECT_SELF);
                    location lLoc = GetLocation(oTarget);
                    AssignCommand(oPC,JumpToLocation(lLoc));
                }
            else
                {
                    SendMessageToPC(oPC,"Your Seal does not open this portal.");
                }
        }
    else
        {
            SendMessageToPC(oPC,"You must have the Guardians Seal to enter here.");
        }

}
