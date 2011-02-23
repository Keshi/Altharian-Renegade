void main()
{
    int nNth;
    int nPlayerHere;
    object oCreature;
    string sCreatureTag;
    object oPlayer;
    // The AREA can't seem to do this, so I set an invisible object called ZoneSweeper
    //as my slave and assign him the task.
    object oSlave = GetObjectByTag("AreaCleaner");
    //are there any other players here?
    nNth = 1;
    oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, oSlave, nNth);
    while((oCreature != OBJECT_INVALID) && (nPlayerHere != 1))
    {
        if(GetIsPC(oCreature) == TRUE)
        {
            nPlayerHere = 1;
        }
        nNth++;
        oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, oSlave, nNth);
    }
    if(nPlayerHere != 1)
    {
        //start clean up
        nNth = 1;
        oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, oSlave, nNth);
        while(oCreature != OBJECT_INVALID)
        {
            DestroyObject(oCreature);
            nNth++;
            oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, oSlave, nNth);
        }
    }
}

