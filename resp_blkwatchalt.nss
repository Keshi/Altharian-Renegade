#include "x0_i0_treasure"


/*                         Created By Ben Hawkins 1.26.04
                               edited by Turan 2.1.06

  --->    Place this script in the OnDeath and OnOpen script events of the placeable  <---                */



    void MagicalChest(int nObjectType, string sObj, location lLoc)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sObj, lLoc);
}

    void main ()
{
    object oArea = GetArea(OBJECT_SELF);
    string sObj;
{
     sObj="blkwatchaltar";
   }

    //This line designates the TAG of the Waypoint where you want the chest to spawn.
    location lLoc = GetLocation(GetWaypointByTag ("WP_blkwatchaltar"));

    //This line determines the length of time before the chest actually respawns. The purple number is how many seconds. (60.0 = 1 minute / 300.0 = 5 minutes / 600.0 = 10 minutes etc)
    //I have it set for speedy respawn to play test the treasure.
    AssignCommand(oArea, DelayCommand(1800.0, MagicalChest(OBJECT_TYPE_PLACEABLE, sObj, lLoc)));


        object oPC = GetLastOpenedBy();

        if (!GetIsPC(oPC)) return;

        object oTarget;
        oTarget = OBJECT_SELF;


        //This next block generates treasure with the Custom Treasure Generator system. Very nice and simple although if you are data base savvy, im sure that would be more desirable.
{       //Please note that the treasure type is   LOW    <----  you can easily change this.
        CTG_CreateTreasure(TREASURE_TYPE_HIGH, GetLastOpener(), OBJECT_SELF);
        SetLocalInt(OBJECT_SELF,"Looted",1);
        CTG_SetIsTreasureGenerated(OBJECT_SELF, FALSE);
        DelayCommand (2.0,SetLocalInt(OBJECT_SELF,"Looted",0));
}

        int nInt;
        nInt = GetObjectType(oTarget);

        // Apply a visual effect to the chest. You can also delay the effect to occur in time with the destruction.The number ->>> DelayCommand (5.0, <---- must correspond with
        // the number in line 79    DestroyObject (oTarget,6.0 <----
        // Note that the effect should be fired before the object is gone. Hence DelayCommand(5.0) versus DestroyObject(oTarget,6.0)
        if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand (5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget));
        else DelayCommand (5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget)));

            oTarget = OBJECT_SELF;

            DestroyObject(oTarget,6.0);


}


