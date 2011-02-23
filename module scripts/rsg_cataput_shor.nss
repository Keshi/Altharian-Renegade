//::///////////////////////////////////////////////
//:: Name Things that go boom
//:: FileName xs_catapult_use
//:: Copyright (c) 2003 NWNZone.com
//:://////////////////////////////////////////////
/*
 This is the on use event for the catapults
 [Version .5a]
*/
//:://////////////////////////////////////////////
//:: Created By: Xeno
//:: Created On: 11 Aug 2003
//:://////////////////////////////////////////////

#include "rsg_detonate_loc"

int iPCUse=TRUE;//Set TRUE if you want player to use it.
int iRandFar=40;//How far shall projectile go? 120=12 tiles.
int iRandNear=10;//What shall it's shortest range be? 10=1 tile.
int iTurnToFaceTarget=FALSE;//Shall the catapult rotate towards target?

//Do not edit below this line.
void main()
{
 object oUser = GetLastUsedBy();
 if (GetIsPC(oUser) && iPCUse==FALSE)
    {
     //object oCalapulter = GetNearestObjectByTag("xs_catapulter_01",oUser);
     object oCalapulter = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC);
     FloatingTextStringOnCreature("Get away from that!", oCalapulter);
     return;
    }
 int iReloading = GetLocalInt(OBJECT_SELF,"reloading");
 if(iReloading==TRUE)
    return;
 SetLocalInt(OBJECT_SELF,"reloading",TRUE);

 //Calc 90 Deg total from facing direction
 float fFacing = GetLocalFloat(OBJECT_SELF,"FACING");
 if(fFacing==0.0)
   {
    fFacing = GetFacing(OBJECT_SELF);
    SetLocalFloat(OBJECT_SELF,"FACING",fFacing);
   }
 float fNewFacing;

 int iOffSet = Random(45)+1;
 float fOffSet = IntToFloat(iOffSet);
 int sSwing = Random(2);
 //int sSwing=1;
 if (sSwing == 0)
    {
     fNewFacing = fFacing - fOffSet;
     if (fNewFacing<=0.0)
         fNewFacing=(360.0+fNewFacing);
    }
 if(sSwing == 1)
   {
     fNewFacing = fFacing + fOffSet;
     if (fNewFacing>=360.0)
         fNewFacing=(fNewFacing-360.0);
   }
 vector vMyPos = GetPosition(OBJECT_SELF);
 //Calc Rand Distance
 int iRandomDist = Random(iRandFar-iRandNear)+iRandNear;
 float fRandomDist =IntToFloat(iRandomDist);
 vector vNewPos = vMyPos + (fRandomDist * AngleToVector(fNewFacing));
 location lTarget = Location(GetArea(OBJECT_SELF),vNewPos, 0.0);
 float fX_Pos = vNewPos.x;
 float fY_Pos = vNewPos.y;
 //Find new z axis
 object oCheckZ = GetNearestObjectToLocation(OBJECT_TYPE_ALL,lTarget,1);
 vector vNewZCord = GetPosition(oCheckZ);
 float fZ_Pos = vNewZCord.z;
 //Calc new Z axis
 vector vFinalLocation = Vector(fX_Pos,fY_Pos,fZ_Pos);
 location lFinalTarget = Location(GetArea(OBJECT_SELF),vFinalLocation, 0.0);
 //Done
 if(iTurnToFaceTarget==TRUE)
    SetFacingPoint(vFinalLocation);
 //Set explosion delay
 float fRange = GetDistanceBetweenLocations(lTarget, GetLocation(OBJECT_SELF));
 float fDelay = fRange / 12.0;
 //Do stuff
 AssignCommand(OBJECT_SELF, ActionCastFakeSpellAtLocation(SPELL_FIREBALL, lFinalTarget, PROJECTILE_PATH_TYPE_BALLISTIC));
 PlaySound("sim_explsun");
 DelayCommand(fDelay, BlastArea(lFinalTarget));
 DelayCommand(fDelay, SetLocalInt(OBJECT_SELF,"reloading",FALSE));
}
