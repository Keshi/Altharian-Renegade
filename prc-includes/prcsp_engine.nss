
// Module Constants
const float CACHE_TIMEOUT_CAST = 2.0;
const string CASTER_LEVEL_TAG = "PRCEffectiveCasterLevel";

// Constants that dictate ResistSpell results
const int SPELL_RESIST_FAIL = 0;
const int SPELL_RESIST_PASS = 1;
const int SPELL_RESIST_GLOBE = 2;
const int SPELL_RESIST_MANTLE = 3;

int PRCDoResistSpell(object oCaster, object oTarget, int nEffCasterLvl=0, float fDelay = 0.0);

int CheckSpellfire(object oCaster, object oTarget, int bFriendly = FALSE);

#include "prc_inc_racial"
//#include "prc_feat_const"
//#include "prc_class_const"
//#include "prcsp_reputation"
#include "prcsp_archmaginc"
//#include "prc_add_spell_dc"
#include "prc_add_spl_pen"


//
//  This function is a wrapper should someone wish to rewrite the Bioware
//  version. This is where it should be done.
//
int PRCResistSpell(object oCaster, object oTarget)
{
    return ResistSpell(oCaster, oTarget);
}

//
//  This function is a wrapper should someone wish to rewrite the Bioware
//  version. This is where it should be done.
//
int PRCGetSpellResistance(object oTarget, object oCaster)
{
        int iSpellRes = GetSpellResistance(oTarget);

        //racial pack SR
        int iRacialSpellRes = 0;
        if(GetHasFeat(FEAT_SPELL27, oTarget))
            iRacialSpellRes += 27+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL25, oTarget))
            iRacialSpellRes += 25+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL23, oTarget))
            iRacialSpellRes += 23+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL22, oTarget))
            iRacialSpellRes += 22+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL21, oTarget))
            iRacialSpellRes += 21+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL20, oTarget))
            iRacialSpellRes += 20+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL19, oTarget))
            iRacialSpellRes += 19+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL18, oTarget))
            iRacialSpellRes += 18+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL17, oTarget))
            iRacialSpellRes += 17+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL16, oTarget))
            iRacialSpellRes += 16+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL15, oTarget))
            iRacialSpellRes += 15+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL14, oTarget))
            iRacialSpellRes += 14+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL13, oTarget))
            iRacialSpellRes += 13+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL11, oTarget))
            iRacialSpellRes += 11+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL10, oTarget))
            iRacialSpellRes += 10+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL8, oTarget))
            iRacialSpellRes += 8+GetHitDice(oTarget);
        else if(GetHasFeat(FEAT_SPELL5, oTarget))
            iRacialSpellRes += 5+GetHitDice(oTarget);
        if(iRacialSpellRes > iSpellRes)
            iSpellRes = iRacialSpellRes;

        // Exalted Companion, can also be used for Celestial Template
        if (GetLocalInt(oTarget, "CelestialTemplate") || GetLocalInt(oTarget, "PseudonaturalTemplate"))
        {
            int nHD = GetHitDice(oTarget);
            int nSR = nHD * 2;
            if (nSR > 25) nSR = 25;
            if (nSR > iSpellRes) iSpellRes = nSR;
        }

        // Foe Hunter SR stacks with normal SR
        // when a spell is cast by their hated enemy
        if(GetHasFeat(FEAT_HATED_ENEMY_SR, oTarget) && GetLocalInt(oTarget, "HatedFoe") == MyPRCGetRacialType(oCaster) )
        {
             iSpellRes += 15 + GetLevelByClass(CLASS_TYPE_FOE_HUNTER, oTarget);
        }

    return iSpellRes;
}

//
//  If a spell is resisted, display the effect
//
void PRCShowSpellResist(object oCaster, object oTarget, int nResist, float fDelay = 0.0)
{
    // If either caster/target is a PC send them a message
    if (GetIsPC(oCaster))
    {
        string message = nResist == SPELL_RESIST_FAIL ?
            "Target is affected by the spell." : "Target resisted the spell.";
        SendMessageToPC(oCaster, message);
    }
    if (GetIsPC(oTarget))
    {
        string message = nResist == SPELL_RESIST_FAIL ?
            "You are affected by the spell." : "You resisted the spell.";
        SendMessageToPC(oTarget, message);
    }

    if (nResist != SPELL_RESIST_FAIL) {
        // Default to a standard resistance
        int eve = VFX_IMP_MAGIC_RESISTANCE_USE;

        // Check for other resistances
        if (nResist == SPELL_RESIST_GLOBE)
            eve = VFX_IMP_GLOBE_USE;
        else if (nResist == SPELL_RESIST_MANTLE)
            eve = VFX_IMP_SPELL_MANTLE_USE;

        // Render the effect
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectVisualEffect(eve), oTarget));
    }
}

//
//  This function overrides the BioWare MyResistSpell.
//  TODO: Change name to PRCMyResistSpell.
//
int PRCDoResistSpell(object oCaster, object oTarget, int nEffCasterLvl=0, float fDelay = 0.0)
{
    int nResist;

    // Check if the archmage shape mastery applies to this target
    if (CheckSpellfire(oCaster, oTarget) || CheckMasteryOfShapes(oCaster, oTarget) || ExtraordinarySpellAim(oCaster, oTarget))
        nResist = SPELL_RESIST_MANTLE;
    else if(GetLevelByClass(CLASS_TYPE_BEGUILER, oCaster) >= 20 && GetIsDeniedDexBonusToAC(oTarget, oCaster, TRUE))
    {
        //Beguilers of level 20+ automatically overcome SR of targets denied Dex bonus to AC
        nResist = SPELL_RESIST_FAIL;
    }
    else {
        // Check immunities and mantles, otherwise ignore the result completely
        nResist = PRCResistSpell(oCaster, oTarget);

        //Resonating Resistance
        if((nResist <= SPELL_RESIST_PASS) && (GetHasSpellEffect(SPELL_RESONATING_RESISTANCE, oTarget)))
        {
            nResist = PRCResistSpell(oCaster, oTarget);
        }

        if (nResist <= SPELL_RESIST_PASS)
        {
            nResist = SPELL_RESIST_FAIL;

            // Because the version of this function was recently changed to
            // optionally allow the caster level, we must calculate it here.
            // The result will be cached for a period of time.
            if (!nEffCasterLvl) {
                nEffCasterLvl = GetLocalInt(oCaster, CASTER_LEVEL_TAG);
                if (!nEffCasterLvl) {
                    nEffCasterLvl = PRCGetCasterLevel(oCaster) + SPGetPenetr();
                    SetLocalInt(oCaster, CASTER_LEVEL_TAG, nEffCasterLvl);
                    DelayCommand(CACHE_TIMEOUT_CAST,
                        DeleteLocalInt(oCaster, CASTER_LEVEL_TAG));
                }
            }
            
            // Pernicious Magic
            // +4 caster level vs SR Weave user (not Evoc & Trans spells)
            int iWeav;
            if (GetHasFeat(FEAT_PERNICIOUSMAGIC,oCaster))
            {
                    if (!GetHasFeat(FEAT_SHADOWWEAVE,oTarget))
                    {
                            int nSchool = GetLocalInt(oCaster, "X2_L_LAST_SPELLSCHOOL_VAR");
                            if ( nSchool != SPELL_SCHOOL_EVOCATION && nSchool != SPELL_SCHOOL_TRANSMUTATION )
                            iWeav=4;
                    }
            }


            // A tie favors the caster.
            if ((nEffCasterLvl + d20(1)+iWeav) < PRCGetSpellResistance(oTarget, oCaster))
                nResist = SPELL_RESIST_PASS;
        }
    }

    PRCShowSpellResist(oCaster, oTarget, nResist, fDelay);

    return nResist;
}

//Returns the maximum number of spellfire levels oPC can store
int SpellfireMax(object oPC)
{
    //can't absorb spells without feat
    if(!GetHasFeat(FEAT_SPELLFIRE_WIELDER, oPC)) return 0;

    int nCON = GetAbilityScore(oPC, ABILITY_CONSTITUTION);
    int nStorage = ((GetLevelByClass(CLASS_TYPE_SPELLFIRE, oPC) + 1) / 2) + 1;
    if(nStorage > 5) nStorage = 5;
    return nCON * nStorage;
}

//Increases the number of stored spellfire levels on a creature
void AddSpellfireLevels(object oPC, int nLevels)
{
    int nMax = SpellfireMax(oPC);
    int nStored = GetPersistantLocalInt(oPC, "SpellfireLevelStored");
    nStored += nLevels;
    if(nStored > nMax) nStored = nMax;  //capped
    SetPersistantLocalInt(oPC, "SpellfireLevelStored", nStored);
}

//Checks if spell target can absorb spells by being a spellfire wielder
int CheckSpellfire(object oCaster, object oTarget, int bFriendly = FALSE)
{
    //can't absorb spells without feat
    if(!GetHasFeat(FEAT_SPELLFIRE_WIELDER, oTarget)) return 0;

    //Can't absorb own spells/powers if switch is set
    if(GetPRCSwitch(PRC_SPELLFIRE_DISALLOW_CHARGE_SELF) && oTarget == oCaster) return 0;

    //abilities rely on access to weave
    if(GetHasFeat(FEAT_SHADOWWEAVE, oTarget)) return 0;

    int nSpellID = PRCGetSpellId();
    if(!bFriendly && GetLocalInt(oCaster, "IsAOE_" + IntToString(nSpellID)))
        return 0; //can't absorb hostile AOE spells

    int nSpellfireLevel = GetPersistantLocalInt(oTarget, "SpellfireLevelStored");
    if(DEBUG) DoDebug("CheckSpellfire: " + IntToString(nSpellfireLevel) + " levels stored", oTarget);

    int nMax = SpellfireMax(oTarget);

    if(DEBUG) DoDebug("CheckSpellfire: Maximum " + IntToString(nMax), oTarget);

    //can't absorb any more spells, sanity check
    if(nSpellfireLevel >= nMax) return 0;

    //increasing stored levels
    int nSpellLevel = GetLocalInt(oCaster, "PRC_CurrentManifest_PowerLevel");   //replicates GetPowerLevel(oCaster);
    if(!nSpellLevel)    //not a power                       //avoids compiler problems
    {                                                       //with includes
        string sInnate = Get2DACache("spells", "Innate", nSpellID);//lookup_spell_innate(nSpellID);
        if(sInnate == "") return 0; //no innate level, unlike cantrips
        nSpellLevel = StringToInt(sInnate);
    }
    /*
    string sInnate = Get2DACache("spells", "Innate", nSpellID);
    if(sInnate == "") return 0; //no innate level, unlike cantrips
    int nSpellLevel = StringToInt(sInnate);
    */

    AddSpellfireLevels(oTarget, nSpellLevel);

    //absorbed
    return 1;
}