//::///////////////////////////////////////////////
//:: Earthquake
//:: X0_S0_Earthquake
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Ground shakes. 1d6 damage, max 10d6
// LOCKINDAL: Changed to alternate: DC 15 or knock down, 25% creatures must make DC 20 or die.
*/ //MODIFIED BY JOE FOR ALTHARIAN RENEGADE
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 22 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 01, 2003
//:: Altered By: Lockindal

//:: altered by mr_bumpkin Dec 4, 2003 for prc stuff
#include "prc_inc_spells"
//add altharia includes
#include "wk_tools"
//end altharia includes
#include "prc_alterations"
#include "prc_add_spell_dc"

void DoQuake(object oCaster, int nCasterLvl, location lTarget)
{
    PRCSetSchool(SPELL_SCHOOL_EVOCATION);

    //Declare major variables
    int nSpectacularDeath = TRUE;
    int nDisplayFeedback  = TRUE;
    int bInside           = GetIsAreaInterior(GetArea(oCaster));
    int nProneDC;    //modified cause 15 and 20 DC is childsplay
    int nDamageDC;
    int nFissureDC;
    int nMod;
    int nDamage;
    float fDelay;
    float fSize       = FeetToMeters(80.0f);
    float fProneDur   = 18.0;
    effect eExplode   = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
    effect eExplode2  = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE);
    effect eExplode3  = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    effect eVis       = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eShake     = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE2);
    effect eKnockdown = EffectKnockdown();

    // Perform screen shake
    SPApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oCaster);

    //Apply epicenter explosion on caster
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode,  GetLocation(oCaster));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode2, GetLocation(oCaster));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode3, GetLocation(oCaster));


    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    { // Earthquake does not allow spell resistance     ***Booyah!***
        // Normal targeting restriction, except also skip affecting the caster
        if(oTarget != oCaster && spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
        {
            // Let the target's AI know
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_EARTHQUAKE));


                nDamageDC         = PRCGetSaveDC(oTarget, oCaster); //modified cause 15 and 20 DC is childsplay
                nProneDC          = PRCGetSaveDC(oTarget, oCaster);
                nFissureDC        = PRCGetSaveDC(oTarget, oCaster)-5;

            // First, always knock targets prone, CASTER DC to avoid
            if(!PRCMySavingThrow(SAVING_THROW_REFLEX, oTarget, nProneDC, SAVING_THROW_TYPE_SPELL, oCaster))
            {
                SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, fProneDur, FALSE, SPELL_EARTHQUAKE, nCasterLvl, oCaster);
            }

            // Indoors, get hit by falling rubble for 8d6, reflex half
            //MODIFIED CAUSE AN EARTHQUAKE IN ALTHARIA SHOULD HURT WHETHER INDOORS OR OUT, PAINLESS EARTHQUAKES ARE FOR WUSSIES if(bInside)
                nDamage = PRCMaximizeOrEmpower((6 + nMod), nCasterLvl,  PRCGetMetaMagicFeat());

                //VOID THE EVASION CHECK, FOR NOW.  HOW COULD YOU EVADE A MILE WIDE EARTH SHAKER?
                //nDamage = PRCGetReflexAdjustedDamage(d6(nMod), oTarget, nDamageDC, SAVING_THROW_TYPE_SPELL, oCaster);

                SPApplyEffectToObject(DURATION_TYPE_INSTANT, PRCEffectDamage(oTarget, nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_ENERGY),
                                      oTarget, 0.0f, FALSE, SPELL_EARTHQUAKE, nCasterLvl, oCaster);
            //}
            // Outdoors, 25% chance to fall into a fissure and die
            //else
            //{
                if(d4() == 4)
                {
                    if(!PRCMySavingThrow(SAVING_THROW_REFLEX, oTarget, nFissureDC, SAVING_THROW_TYPE_SPELL, oCaster))
                    {
                        DeathlessFrenzyCheck(oTarget);
                        /// @todo Find appropriate VFX to play here
                        SPApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(nSpectacularDeath, nDisplayFeedback),
                                              oTarget, 0.0f, FALSE, SPELL_EARTHQUAKE, nCasterLvl, oCaster);
                    }
                }
            //}
        }

        //Select the next target within the spell shape.
        oTarget = MyNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

    PRCSetSchool();
}


void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_EVOCATION);
/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oCaster   = OBJECT_SELF;
    location lTarget = PRCGetSpellTargetLocation();
    int nCasterLvl   = PRCGetCasterLevel(oCaster);
    int nMetaMagic   = PRCGetMetaMagicFeat();

    //altharia modifications
    int nMod = 0;
    int nVesper = GetVesper(oCaster);
    int nDruid = GetWhiteGold(oCaster);
    int nLevel = PRCGetCasterLevel(oCaster);
    if (nVesper >= 3 ||
        nDruid  >= 3)
      {
        nLevel = GetEffectiveCasterLevel(oCaster);
        nMod = 10;
      }
     nCasterLvl = nLevel;
     SpeakString(IntToString(nCasterLvl));
//end altharia mod
     //Limit Caster level for the purposes of damage
    //if (nCasterLvl > 10){nCasterLvl = ((nCasterLvl - 10) / 3) + 10;}
    //end altharia modifications

    // Perform the earthquake
    DoQuake(oCaster, nCasterLvl, lTarget);

    // Extended earthquake - apply the effects again next round
    if(nMetaMagic & METAMAGIC_EXTEND)
        DelayCommand(6.0f, DoQuake(oCaster, nCasterLvl, lTarget));

// Erasing the variable used to store the spell's spell school
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
}
