const string sHenchSummonedFamiliar = "HenchSummonedFamiliar";
const string sHenchSummonedAniComp = "HenchSummonedAniComp";
const string sHenchPseudoSummon = "HenchPseudoSummon";

const string sHenchLastHeardOrSeen          = "LastSeenOrHeard";

void ClearEnemyLocation()
{
    DeleteLocalInt(OBJECT_SELF, sHenchLastHeardOrSeen);
    DeleteLocalLocation(OBJECT_SELF, sHenchLastHeardOrSeen);

    object oInvisTarget = GetLocalObject(OBJECT_SELF, sHenchLastHeardOrSeen);
    if (GetIsObjectValid(oInvisTarget))
    {
        DestroyObject(oInvisTarget);
        DeleteLocalObject(OBJECT_SELF, sHenchLastHeardOrSeen);
    }
}
