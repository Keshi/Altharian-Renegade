//::///////////////////////////////////////////////////
//:: X0_S1_MANTSPIKE
//:: Handles the damage effects of the manticore spikes.
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/15/2002
//::///////////////////////////////////////////////////
#include "x0_i0_spells"
void ManticoreAttack(int nD8Dice, int nCap, int nSpell, int nMIRV = VFX_IMP_MIRV,
    int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE)
{
    object oTarget = OBJECT_INVALID;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);

    int nDamage = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt =1;
    effect eMissile = EffectVisualEffect(nMIRV);
    effect eVis = EffectVisualEffect(nVIS);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    location lTarget = GetSpellTargetLocation(); // missile spread centered around caster
    int nMissiles = 6;

    if (nMissiles > nCap)
    {
        nMissiles = nCap;
    }

    if (GetTag(OBJECT_SELF) == "riverhag")
        {
        nCasterLvl =40;
        nMissiles = 6;
        }



        /* New Algorithm
            1. Count # of targets
            2. Determine number of missiles
            3. First target gets a missile and all Excess missiles
            4. Rest of targets (max nMissiles) get one missile
       */
    int nEnemies = 0;

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) )
    {
        // * caster cannot be harmed by this spell
        if ((GetIsEnemy(oTarget)) && (oTarget != OBJECT_SELF))
        {
            nEnemies++;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

     if (nEnemies == 0) return; // * Exit if no enemies to hit

     // by default the Remainder will be 0 (if more than enough enemies for all the missiles)
     int nRemainder = 0;

     if (nEnemies > nMissiles)
        nEnemies = nMissiles;

     int nExtraMissiles = nMissiles / nEnemies;

     // April 2003
     // * if more enemies than missiles, need to make sure that at least
     // * one missile will hit each of the enemies
     nRemainder = nMissiles % nEnemies;


    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) && nCnt <= nEnemies)
    {
        // * caster cannot be harmed by this spell
        if ((GetIsEnemy(oTarget)) && (oTarget != OBJECT_SELF))
        {
                // * recalculate appropriate distances

                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = fDist/(3.0 * log(fDist) + 2.0);

                int i = 0;
                // * first target will get excess missiles
                for (i=1; i <= nExtraMissiles + nRemainder; i++)
                {
                    //Make SR Check and a succesful touch attack
                    int nResult = TouchAttackRanged(oTarget, TRUE);

                    if (nResult > 0)
                    {
                        //Roll damage
                        int nDam = d10(nD8Dice) +2;


                        if (nResult == 2)
                        {
                            nDam = nDam + d10(nD8Dice) +2;
                        }

                        fTime = fDelay;
                        fDelay2 += 0.1;
                        fTime += fDelay2;

                        if (GetTag(OBJECT_SELF) == "forestbear")nDam = d8(5);
                        if (GetTag(OBJECT_SELF) == "forestfeline")nDam = d8(10);
                        if (GetTag(OBJECT_SELF) == "forestwolf")nDam = d8(15);
                        if (GetTag(OBJECT_SELF) == "foreststag")nDam = d8(20);
                        if (GetTag(OBJECT_SELF) == "forestspider")nDam = d8(25);
                        if (GetTag(OBJECT_SELF) == "forestfalcon")nDam = d8(30);
                        if (GetTag(OBJECT_SELF) == "forestfey")nDam = d8(35);
                        if (GetTag(OBJECT_SELF) == "forestwingedlizard")nDam = d8(40);
                        if (GetTag(OBJECT_SELF) == "riverhag")
                            {   nDam = d8(20);

                            }
                         if (GetTag(OBJECT_SELF) == "cavelion" ||GetTag(OBJECT_SELF) == "cavelionmaster")
                            {   nDam = d8(30);

                            }




                        //Set damage effect
                        effect eDam = EffectDamage(nDam, nDAMAGETYPE);
                        //Apply the MIRV and damage effect
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                        DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));

                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        // Play the sound of a dart hitting
                        DelayCommand(fTime, PlaySound("cb_ht_dart1"));

                    }
                    else
                    {  // * apply a dummy visual effect
                     ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
                    }
                } // for
                nCnt++;// * increment count of missiles fired
                nRemainder = 0;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

}

void main()
{
//DoMissileStorm(int nD6Dice, int nCap, int nSpell, int nMIRV = VFX_IMP_MIRV, int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE)

ManticoreAttack(1, 6, GetSpellId(), 359, VFX_COM_BLOOD_SPARK_SMALL, DAMAGE_TYPE_PIERCING);
/*    object oTarget = GetSpellTargetObject();

    if (TouchAttackRanged(oTarget, TRUE) > 0)
    {
        // Play the sound of a dart hitting
        PlaySound("cb_ht_dart1");
        effect eDamage = EffectDamage(d8());
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDamage, oTarget);
    }  */
}
