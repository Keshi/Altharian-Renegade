//::///////////////////////////////////////////////
//:: Ballista
//:: tg_ballista
//:://////////////////////////////////////////////
/*  Placed in On_Use script for ballista object.
    The ballista object must be marked usable.

    Creates a cone shape designated as a "field of view".
    Cycles through hostile creatures in the area, and
    checks if it is safe to fire upon them.

    Fires a bolt that does area of effect damage.

    Purpose: Wrote the script to automate NPCs to use Ballistas to
    add flavor to a scenario where the PC's are involved in small battles and sieges.

*/
//:://////////////////////////////////////////////
//:: Created By: Chakar
//:: Created On: 6/24/2002
//:: Lastmodified On: 6/27/2002
//:: Version: 1.1  Broke Script into seperate functions for readability
//:: Version: 1.2  Added comments for distribution.
//:: Version: 1.3  Fixed Vector bug
//::               Now using target creature as center of effect.
//:: Version: 1.4  Saving throw now checked with: GetReflexAdjustedDamage
//::               Replaced reputation checks with GetIsEnemy()
//::               Added LoS check. (was shooting through walls).
//::               Added Delay before applying damage to better match bolt impact.
//::Version 1.5    Fixed bug caused by GetFacing returning incorrect information for
//::               heading between 180 and 360, now using GetFacingFromLocation.
//::
//::               Do some additional geometric checks to ensure object set by AcquireTarget
//::               is from the specified area as described.
//:://////////////////////////////////////////////



     //State Constants
    int ST_READY = 100;
    int ST_RELOAD = 110;
    int ST_RELOADING = 120;




     //Function Declarations
    void ReloadBallista(object oUser);

    int CheckAngleToTarget(object oTarget, float fAngle, float fOrientation);

    int AcquireTarget(object oUser);


    void ApplyDamage();


    int GetIsAcceptableTarget(object oUser, object oTarget);

    //Variables.. change these to set damage and field of view.

   float fMaxRange = 40.0f;   //Max Range
   float fMinRange = 5.0f;   //Min Range
   float fWidth = 40.0f;      //Radius of cone at widest point
   int iDC = 50;              //Difficulty check(reflex save for half damage)
   float fSize = 5.0f;        //Radius of damage area
   int iDice = 50;             //Number of dice to roll for damage (currently d8s, changeable in code)


void main()
{


    //Checks to see if the Ballista has been initialized
 if (!GetLocalInt(OBJECT_SELF, "iInitialized"))

 {
    SetLocalInt(OBJECT_SELF, "iInitialized", 1);
    SetLocalInt(OBJECT_SELF, "iState", ST_READY);

 }

   int iState = GetLocalInt(OBJECT_SELF,"iState");
   object oTarget;
   object oUser;

   oUser = GetLastUsedBy();

   switch(iState)
   {
    case 100:  //Ready

      if (AcquireTarget(oUser))
      {
       ApplyDamage();
       if (GetIsPC(oUser))
         SendMessageToPC(oUser,"Fired at " + GetLocalString(OBJECT_SELF, "sTarget"));
      }
      break;

    case 110:  //Reload

      if (GetIsPC(oUser))
        {
         SendMessageToPC(oUser, "Reloading Ballista");
        }

      SetLocalInt(OBJECT_SELF, "iState", ST_RELOADING);

      ActionWait(3.0); //Reload Time in Seconds
      AssignCommand(oUser,PlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0));
      ActionDoCommand(ReloadBallista(oUser));

      break;

    case 120: //Reloading
      break;


   }

}

void ReloadBallista(object oUser)
{

    switch (GetIsPC(oUser))
    {
        case TRUE://If User is a PC, send reload messages.
        {
             if  ((!GetIsInCombat(oUser)) && (GetDistanceToObject(oUser) < 2.5))
             {
                    SendMessageToPC(oUser, "Ballista Reloaded");
                    SetLocalInt(OBJECT_SELF, "iState", ST_READY);

             }
              else
              {
                    SendMessageToPC(oUser, "Ballista Reloaded");
                    SetLocalInt(OBJECT_SELF, "iState", ST_READY);


              }
              break;
         }
       case FALSE:
       {
             if ((!GetIsInCombat(oUser)) && (GetDistanceToObject(oUser) < 1.0))
             {

                SetLocalInt(OBJECT_SELF, "iState", ST_READY);

             }
             else
             {
                SetLocalInt(OBJECT_SELF, "iState", ST_RELOAD);

             }
          break;
        }
    }
}


int AcquireTarget(object oUser)
{
    float fOrientation;
    vector vOrigin;
    vector vBallista;

    location lTarget;
    float fHyp;
    float fOpp;
    float fAdj;
    object oTarget;
    object oNearest;
    float fHypLength;
    float fAngle ;

    //Calculate Location for end of cone (MaxRange of Balista)
    fOrientation = GetFacingFromLocation(GetLocation(OBJECT_SELF));

    //FixOrientation --Orientation for Ballista object is not it's front side
    fOrientation += 90.0;

    //Find the Vector location in relation to Origin; not dealing with Z axis
    vOrigin = Vector();
    vOrigin.x = cos(fOrientation)* fMaxRange;
    vOrigin.y = sin(fOrientation)* fMaxRange;

    //create vector in relation to Ballista
    vBallista = GetPosition(OBJECT_SELF);
    vBallista.x += vOrigin.x;
    vBallista.y += vOrigin.y;

    fHypLength = sqrt(pow(fWidth, 2.0) + pow(fMaxRange,2.0));
    fAngle = asin(fWidth/fHypLength);

    //create location to pass to GetFirstObjectInShape function
    lTarget = Location(GetArea(OBJECT_SELF), vBallista, fOrientation);

    AssignCommand(oUser, SetFacing(fOrientation));
    //acquire first target in area that meets our conditions
    oTarget = GetFirstObjectInShape(SHAPE_CONE, fWidth, lTarget,TRUE,OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));

    while (GetIsObjectValid(oTarget))
    {

        if (GetIsAcceptableTarget(oUser, oTarget) && GetDistanceBetween(oTarget, OBJECT_SELF) > fMinRange && GetDistanceBetween(oTarget, OBJECT_SELF) <= fMaxRange && GetObjectSeen(oTarget, oUser) && CheckAngleToTarget(oTarget, fAngle, fOrientation))
        {
          SetLocalLocation(OBJECT_SELF, "lTarget", GetLocation(oTarget));
          SetLocalString(OBJECT_SELF, "sTarget", GetName(oTarget));
          SetLocalObject(OBJECT_SELF, "oTarget", oTarget);
          return TRUE;
        }

      oTarget = GetNextObjectInShape(SHAPE_CONE, fWidth, lTarget,TRUE,OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));

    }
    if (GetIsPC(oUser))
    SendMessageToPC(oUser, "You are unable to get a clear shot at the enemies!");

    return FALSE;
}


//Apply Damage to Creatures/Doors/Placeables in damage sphere)
void ApplyDamage()
{
 object oTarget;
 location lTarget;
 int iDamage;
 effect eBolt;
 effect eDam;
 float fDelay;

 eBolt = EffectVisualEffect(22, FALSE);
 lTarget = GetLocalLocation(OBJECT_SELF, "lTarget");

 oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
 ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, GetLocalObject(OBJECT_SELF,"oTarget"));


 while(GetIsObjectValid(oTarget))
    {
     fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
     iDamage = d4(iDice); //Set Ballista Damage Here

     eDam = EffectDamage( iDamage, DAMAGE_TYPE_FIRE, DAMAGE_POWER_PLUS_TWENTY);
     iDamage = GetReflexAdjustedDamage(iDamage, oTarget, iDC,SAVING_THROW_REFLEX);
        if (iDamage > 0)
          DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

     oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
            SetLocalInt(OBJECT_SELF, "iState", ST_RELOAD);

}


//Set Conditions for firing here. Current condition is that there are more
// enemies than friends in target damage area.
int GetIsAcceptableTarget(object oUser, object oTarget)
{
   object oPotentialVictim;
   int iFriends = 0;
   int iEnemies = 0;
   oPotentialVictim = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oTarget), TRUE, OBJECT_TYPE_CREATURE);
   while (GetIsObjectValid(oPotentialVictim))
   {
      if (GetIsEnemy(oTarget, oUser))
          iEnemies += 1;
      else
          iFriends += 1;

      oPotentialVictim = GetNextObjectInShape (SHAPE_SPHERE, fSize, GetLocation(oTarget), TRUE, OBJECT_TYPE_CREATURE);
   }

   if (iEnemies > iFriends)
     return 1;
   else
     return 0;

}

//The GetObjectInShape functions were returning objects that would not be in the shape
//as I envisioned it. (Specifically, it was returning objects from the ballista's right hand side,
//which were way out of the range of the cone.. this checks to make sure they are with in range of the cone

int CheckAngleToTarget(object oTarget, float fAngle, float fOrientation)
{
 vector vBallista;
 vector vTarget;
 float fTargetAngle;
 float fHyp;
 float fRightHeading;
 float fLeftHeading;

 vBallista = GetPosition(OBJECT_SELF);
 vTarget = GetPosition(oTarget);

 vTarget.x = vTarget.x - vBallista.x ;
 vTarget.y = vTarget.y - vBallista.y  ;
 fHyp =  sqrt(pow(vTarget.x, 2.0) + pow(vTarget.y, 2.0));
 fTargetAngle = asin((vTarget.y / fHyp));



 if (vTarget.x < 0.0)
 {
    if(vTarget.y < 0.0)
    {
        fTargetAngle= 180.0 + fTargetAngle;
    }
    else if (vTarget.y > 0.0)
    {
        fTargetAngle = 180.0 - fTargetAngle;
    }
    else
    {
        fTargetAngle = 180.0;
    }

 }
 else if (vTarget.x > 0.0)
 {
    if (vTarget.y < 0.0)
    {
        fTargetAngle = 360.0 - fTargetAngle;
    }
    else if (vTarget.y > 0.0)
    {
        fTargetAngle = 0.0 + fTargetAngle;
    }
    else
    {
        fTargetAngle = 360.0;
    }
 }
 else
 {
    if (vTarget.y > 0.0)
    {
        fTargetAngle = 90.0;
    }
    else if (vTarget.y < 0.0)
    {
        fTargetAngle = 270.0;
    }
 }

fRightHeading = fOrientation - fAngle;
fLeftHeading = fOrientation + fAngle;

if (fRightHeading > 360.0)
{
    fRightHeading -= 360.0;
}
else if (fRightHeading == 360.0)
    fRightHeading = 0.0;

if (fLeftHeading > 360.0)
    fLeftHeading -= 360.0;
else if (fLeftHeading == 0.0)
    fLeftHeading == 360.0;

if (fTargetAngle > 360.0)
    fTargetAngle -= 360.0;

if (fTargetAngle  >= fRightHeading && fTargetAngle <= fLeftHeading)
{
    PrintString("Angle within range");
    return 1;
}
else
return 0;

}
