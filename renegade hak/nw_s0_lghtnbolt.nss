//::///////////////////////////////////////////////
//:: Lightning Bolt
//:: NW_S0_LightnBolt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does 1d6 per level in a 5ft tube for 30m
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On:  March 8, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: May 2, 2001

//:: modified by mr_bumpkin Dec 4, 2003 for PRC stuff
#include "prc_inc_spells"
#include "prc_add_spell_dc"
 #include "wk_tools"



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
    int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);
    int nStaff = GetMageStaff(OBJECT_SELF);
    int nDice = 6;
     int nLevel = CasterLvl;
    if (nStaff >= 3) nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
    if (nStaff == 2 || nStaff == 4) nDice = 8;
    int nCasterLevel = nLevel;

    int EleDmg = ChangedElementalDamage(OBJECT_SELF, DAMAGE_TYPE_ELECTRICAL);

    //int nCasterLevel = CasterLvl;
    //Limit caster level
    if (nCasterLevel > 10)
    {
        //nCasterLevel = 10;
        nCasterLevel = 10 + (nLevel - 10/5);
    }
    int nDamage;
    int nMetaMagic = PRCGetMetaMagicFeat();
    //Set the lightning stream to start at the caster's hands
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eDamage;
    object oTarget = PRCGetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
    object oNextTarget, oTarget2;
    float fDelay;
    int nCnt = 1;

    CasterLvl +=SPGetPenetr();

    oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= 30.0)
    {
        //Get first target in the lightning area by passing in the location of first target and the casters vector (position)
        oTarget = MyFirstObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, GetPosition(OBJECT_SELF));
        while (GetIsObjectValid(oTarget))
        {
           //Exclude the caster from the damage effects
           if (oTarget != OBJECT_SELF && oTarget2 == oTarget)
           {
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
                {
                   //Fire cast spell at event for the specified target
                   SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHTNING_BOLT));
                   //Make an SR check
                   if (!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLvl))
                   {
                        int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);
                        //Roll damage
                        nDamage =  d6(nCasterLevel);
                        if (nStaff == 2 || nStaff == 4) nDamage = d8(nCasterLevel);
                        //Enter Metamagic conditions
                        if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                        {
                             //nDamage = 6 * nCasterLevel;//Damage is at max
                             nDamage = nDice * nCasterLevel;//Damage is at max
                        }
                        if ((nMetaMagic & METAMAGIC_EMPOWER))
                        {
                             nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
                        }
                        //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                        //Adjust damage based on Reflex Save, Evasion and Improved Evasion
                        nDamage = PRCGetReflexAdjustedDamage(nDamage, oTarget, nDC,SAVING_THROW_TYPE_ELECTRICITY);
                        //Set damage effect
                        eDamage = PRCEffectDamage(oTarget, nDamage, EleDmg);
                        if(nDamage > 0)
                        {
                            fDelay = PRCGetSpellEffectDelay(GetLocation(oTarget), oTarget);
                            //Apply VFX impcat, damage effect and lightning effect
                            DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                            PRCBonusDamage(oTarget);
                            DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                        }
                    }
                    SPApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.0,FALSE);
                    //Set the currect target as the holder of the lightning effect
                    oNextTarget = oTarget;
                    eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oNextTarget, BODY_NODE_CHEST);
                }
           }
           //Get the next object in the lightning cylinder
           oTarget = MyNextObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, GetPosition(OBJECT_SELF));
        }
        nCnt++;
        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name
}

