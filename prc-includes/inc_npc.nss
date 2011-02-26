//::///////////////////////////////////////////////
//:: NPC associate include
//:: inc_npc
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

// Get the master of oAssociate.
object GetMasterNPC(object oAssociate=OBJECT_SELF);

// Returns the associate type of the specified creature.
// - Returns ASSOCIATE_TYPE_NONE if the creature is not the associate of anyone.
int GetAssociateTypeNPC( object oAssociate );

// Get the henchman belonging to oMaster.
// * Return OBJECT_INVALID if oMaster does not have a henchman.
// -nNth: Which henchman to return.
object GetHenchmanNPC(object oMaster=OBJECT_SELF,int nNth=1);

// Get the associate of type nAssociateType belonging to oMaster.
// - nAssociateType: ASSOCIATE_TYPE_*
// - nMaster
// - nTh: Which associate of the specified type to return
// * Returns OBJECT_INVALID if no such associate exists.
object GetAssociateNPC(int nAssociateType, object oMaster=OBJECT_SELF, int nTh=1);

// Returns TRUE if the specified condition flag is set on
// the associate.
int GetAssociateStateNPC(int nCondition, object oAssoc=OBJECT_SELF);

// Determine if this henchman is currently dying
int GetIsHenchmanDyingNPC(object oHench=OBJECT_SELF);

// Determine if Should I Heal My Master
int GetAssociateHealMasterNPC();

// Create the next AssociateType creature
object CreateLocalNextNPC(object oMaster,int nAssociateType,string sTemplate,location loc,string sTag="");

// Create a AssociateType creature
object CreateLocalNPC(object oMaster,int nAssociateType,string sTemplate,location loc,int Nth=1,string sTag="");


#include "prc_inc_function"
#include "x0_i0_assoc"

void SetLocalNPC(object oMaster,object oAssociate,int nAssociateType ,int nNth=1)
{
  SetLocalObject(oAssociate, "oMaster", oMaster);
  SetLocalInt(oAssociate, "iAssocType", nAssociateType);
  SetLocalObject(oMaster, IntToString(nAssociateType)+"oHench"+IntToString(nNth), oAssociate);
  SetLocalInt(oAssociate, "iAssocNth", nNth);

}

void DeleteLocalNPC(object oAssociate=OBJECT_SELF)
{
   int nType = GetLocalInt(oAssociate, "iAssocType");
   object oMaster = GetMasterNPC(oAssociate);
   int Nth = GetLocalInt(oAssociate, "iAssocNth");

   DeleteLocalInt(oMaster, IntToString(nType)+"oHench"+IntToString(Nth));
   DeleteLocalInt(oAssociate, "iAssocNth");
   DeleteLocalObject(oAssociate, "oMaster");
   DeleteLocalInt(oAssociate, "iAssocType");
}

void DestroySummon(object oSummon)
{
   effect eVis = EffectVisualEffect(VFX_IMP_UNSUMMON);
   ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetLocation(oSummon));
   DeleteLocalNPC(oSummon);
   DestroyObject(oSummon);
}


object CreateLocalNPC(object oMaster,int nAssociateType,string sTemplate,location loc,int Nth=1,string sTag="")
{
     object oSummon=CreateObject(OBJECT_TYPE_CREATURE,sTemplate,loc,FALSE,sTag);

     SetLocalNPC(oMaster,oSummon,nAssociateType ,Nth);
     SetAssociateState(NW_ASC_HAVE_MASTER,TRUE,oSummon);
     SetAssociateState(NW_ASC_DISTANCE_2_METERS);
     SetAssociateState(NW_ASC_DISTANCE_4_METERS, FALSE);
     SetAssociateState(NW_ASC_DISTANCE_6_METERS, FALSE);

     if (nAssociateType == ASSOCIATE_TYPE_FAMILIAR) SetLocalInt(oMaster, "FamiliarToTheDeath", 100);
     if (nAssociateType == ASSOCIATE_TYPE_ANIMALCOMPANION) SetLocalInt(oMaster, "AniCompToTheDeath", 100);

     effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
     ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oSummon));

     return oSummon;
}

object CreateLocalNextNPC(object oMaster,int nAssociateType,string sTemplate,location loc,string sTag="")
{
  object oSummon=CreateObject(OBJECT_TYPE_CREATURE,sTemplate,loc,FALSE,sTag);
  int nCount=1;

  while (GetIsObjectValid(GetAssociateNPC(ASSOCIATE_TYPE_SUMMONED,OBJECT_SELF,nCount)))
  {
    nCount++;
    SendMessageToPC(OBJECT_SELF," nCount:"+IntToString(nCount));
  }

  SetLocalObject(oSummon, "oMaster", oMaster);
  SetLocalInt(oSummon, "iAssocType", nAssociateType);
  SetLocalObject(oMaster, IntToString(nAssociateType)+"oHench"+IntToString(nCount), oSummon);
  SetLocalInt(oSummon, "iAssocNth", nCount);

  SetAssociateState(NW_ASC_HAVE_MASTER,TRUE,oSummon);
  SetAssociateState(NW_ASC_DISTANCE_2_METERS);
  SetAssociateState(NW_ASC_DISTANCE_4_METERS, FALSE);
  SetAssociateState(NW_ASC_DISTANCE_6_METERS, FALSE);

  if (nAssociateType ==ASSOCIATE_TYPE_FAMILIAR) SetLocalInt(oMaster, "FamiliarToTheDeath", 100);
  if (nAssociateType ==ASSOCIATE_TYPE_ANIMALCOMPANION) SetLocalInt(oMaster, "AniCompToTheDeath", 100);

  return oSummon;

}
object GetMasterNPC(object oAssociate=OBJECT_SELF)
{
   object oMaster = GetLocalObject(oAssociate, "oMaster");

   if (GetIsObjectValid(oMaster))
     return oMaster;
   else
     return GetMaster(oAssociate);
}

int GetAssociateTypeNPC( object oAssociate )
{
    int iType = GetLocalInt(oAssociate, "iAssocType");
    if (iType)
      return iType;
    else
      return GetAssociateType(oAssociate);
}

object GetHenchmanNPC(object oMaster=OBJECT_SELF,int nNth=1)
{
   object oAssociate = GetLocalObject(oMaster,IntToString(ASSOCIATE_TYPE_HENCHMAN)+"oHench"+IntToString(nNth));

   if (GetIsObjectValid(oAssociate))
     return oAssociate;
   else
     return GetHenchman(oMaster,nNth);
}

object GetAssociateNPC(int nAssociateType, object oMaster=OBJECT_SELF, int nTh=1)
{
   object oAssociate = GetLocalObject(oMaster,IntToString(nAssociateType)+"oHench"+IntToString(nTh));

   if (GetIsObjectValid(oAssociate))
     return oAssociate;
   else
     return GetAssociate(nAssociateType,oMaster,nTh);
}

int GetAssociateStateNPC(int nCondition, object oAssoc=OBJECT_SELF)
{
    //SpawnScriptDebugger();

    if(nCondition == NW_ASC_HAVE_MASTER)
    {
        if(GetIsObjectValid(GetMasterNPC(oAssoc)))
            return TRUE;
    }
    else
    {
        int nPlot = GetLocalInt(oAssoc, sAssociateMasterConditionVarname);

        if(nPlot & nCondition)
            return TRUE;
    }
    return FALSE;
}

int GetIsHenchmanDyingNPC(object oHench=OBJECT_SELF)
{
    int bHenchmanDying = GetAssociateStateNPC(NW_ASC_MODE_DYING, oHench);

    if (bHenchmanDying == TRUE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

int GetAssociateHealMasterNPC()
{
    if(GetAssociateStateNPC(NW_ASC_HAVE_MASTER))
    {
        object oMaster = GetMasterNPC();
        int nLoss = GetPercentageHPLoss(oMaster);

        if(!GetIsDead(oMaster))
        {
            if(GetAssociateStateNPC(NW_ASC_HEAL_AT_75) && nLoss <= 75)
            {
                return TRUE;
            }
            else if(GetAssociateStateNPC(NW_ASC_HEAL_AT_50) && nLoss <= 50)
            {
                return TRUE;
            }
            else if(GetAssociateStateNPC(NW_ASC_HEAL_AT_25) && nLoss <= 25)
            {
                return TRUE;
            }
        }
    }
    return FALSE;
}


