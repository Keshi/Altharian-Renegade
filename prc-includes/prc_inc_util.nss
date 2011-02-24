


///////////////////////////////////////////////////////////////////////////////
//  FUNCTION DECLARATIONS
///////////////////////////////////////////////////////////////////////////////

// Returns the number of henchmen a player has.
int GetNumHenchmen(object oPC);

// returns the float time in seconds to close the given distance
float GetTimeToCloseDistance(float fMeters, object oPC, int bIsRunning = FALSE);

/* PRC ForceRest wrapper
 *
 * ForceRest does not trigger the module's OnRest event, nor will the targeted player show up
 * when GetLastPCRested is used. This wrapper can be used to ForceRest a target, while still
 * running the PRC's OnRest script.
 */
void PRCForceRest(object oPC);

///////////////////////////////////////////////////////////////////////////////
//  FUNCTION DEFINITIONS
///////////////////////////////////////////////////////////////////////////////

int GetNumHenchmen(object oPC)
{
     if (!GetIsPC(oPC)) return -1;

     int nLoop, nCount;
     for (nLoop = 1; nLoop <= GetMaxHenchmen(); nLoop++)
     {
          if (GetIsObjectValid(GetHenchman(oPC, nLoop)))
          nCount++;
     }

     return nCount;
}

float GetTimeToCloseDistance(float fMeters, object oPC, int bIsRunning = FALSE)
{
     float fTime = 0.0;
     float fSpeed = 0.0;

     int iMoveRate = GetMovementRate(oPC);

     switch(iMoveRate)
     {
          case 0:
               fSpeed = 2.0;
               break;
          case 1:
               fSpeed = 0.0;
               break;
          case 2:
               fSpeed = 0.75;
               break;
          case 3:
               fSpeed = 1.25;
               break;
          case 4:
               fSpeed = 1.75;
               break;
          case 5:
               fSpeed = 2.25;
               break;
          case 6:
               fSpeed = 2.75;
               break;
          case 7:
               fSpeed = 2.0;  // could change to creature default in the appearance.2da.
               break;
          case 8:
               fSpeed = 5.50;
               break;
     }

     // movement speed doubled if running
     if(bIsRunning) fSpeed *= 2.0;

     // other effects that can change movement speed
     if( PRCGetHasEffect(EFFECT_TYPE_HASTE, oPC) ) fSpeed *= 2.0;
     if( PRCGetHasEffect(EFFECT_TYPE_MOVEMENT_SPEED_INCREASE, oPC) ) fSpeed *= 2.0;

     if( PRCGetHasEffect(EFFECT_TYPE_SLOW,  oPC) ) fSpeed /= 2.0;
     if( PRCGetHasEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE,  oPC) ) fSpeed /= 2.0;

     if( GetHasFeat(FEAT_BARBARIAN_ENDURANCE, oPC) ) fSpeed *= 1.1; // 10% gain
     if( GetHasFeat(FEAT_MONK_ENDURANCE, oPC) )
     {
          float fBonus = 0.1 * (GetLevelByClass(CLASS_TYPE_MONK, oPC) / 3 );
          if (fBonus > 0.90) fBonus = 0.9;

          fBonus += 1.0;
          fSpeed *= fBonus;
     }

     // final calculation
     fTime = fMeters / fSpeed;

     return fTime;
}

void PRCForceRest(object oPC)
{
    ForceRest(oPC);

    SetLocalInt(oPC, "PRC_ForceRested", 1);

    ExecuteScript("prc_rest", oPC);
}