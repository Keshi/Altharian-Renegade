
//:://////////////////////////////////////////////
//:: Created By: kurt
//:: Created On: 9/14/02 3:23:34 PM
//:://////////////////////////////////////////////

void main()

{
   object oPlayer = GetEnteringObject();


 if ( GetIsObjectValid(oPlayer) && GetIsPC(oPlayer)   )
        {
      object oArea = GetArea(oPlayer);
      ExploreAreaForPlayer(oArea, oPlayer);
        }

}


