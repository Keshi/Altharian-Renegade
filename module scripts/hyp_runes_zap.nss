void main()
{
object oUser=GetLastUsedBy();

object oWP= GetNearestObject (OBJECT_TYPE_WAYPOINT, oUser);
int iStatus= GetLocalInt (oWP,"Status");
SendMessageToAllDMs (  GetName(oUser)
                        + " touched Hypnotic Rune, status "
                        +IntToString(iStatus));


 // Inspect local variables

int iTime= GetCampaignInt("Altharia","clock");

if((GetLocalInt(OBJECT_SELF, "lastused")+75) < iTime
      || GetLocalInt(OBJECT_SELF, "lastused") ==0  )
    {
    /// set the lastused time
    SetLocalInt(OBJECT_SELF, "lastused",iTime);

    if (iStatus==1)
    {
    int nDam=FloatToInt(IntToFloat(GetMaxHitPoints(oUser))* 0.9f );
    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_PLUS_TWENTY);
    ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oUser));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(487), oUser);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED),oUser);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM),oUser);
    DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oUser));
    }

    if (iStatus==2)
    {
        string sOldBook = "bookoftheabyss04";
        string sNewBook = "bookoftheabyss05";
        object oBook = GetItemPossessedBy(oUser,sOldBook);
        if (GetIsObjectValid(oBook))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oUser);
                DestroyObject(oBook);
                CreateItemOnObject(sNewBook,oUser,1);
            }
        else
            {
                SendMessageToPC(oUser,"You already have Verse 5 of the Book of the Abyss.  Take some damage instead.");
                int nDam=FloatToInt(IntToFloat(GetMaxHitPoints(oUser))* 0.9f );
                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_PLUS_TWENTY);
                ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oUser));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(487), oUser);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED),oUser);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM),oUser);
                DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oUser));
            }
    }

    if (iStatus==3)
    {
      //  sacredsymbol
     //give him the  runeofmisbelie
        CreateItemOnObject("sacredsymbol", oUser, 1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_SUMMON_GATE),oUser);

    }

    }

else
    {
     SendMessageToPC (oUser, " This Hypnotic Rune has been  recently used and has no power.");
    }



}
