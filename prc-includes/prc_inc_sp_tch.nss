int PRCDoRangedTouchAttack(object oTarget, int nDisplayFeedback = TRUE, object oCaster = OBJECT_SELF, int nAttackBonus = 0);
int PRCDoMeleeTouchAttack(object oTarget, int nDisplayFeedback = TRUE, object oCaster = OBJECT_SELF, int nAttackBonus = 0);

//#include "prc_inc_sneak"
#include "prc_inc_combat"
#include "prc_inc_template"

int PRCDoRangedTouchAttack(object oTarget, int nDisplayFeedback = TRUE, object oCaster = OBJECT_SELF, int nAttackBonus = 0)
{
    if(GetLocalInt(oCaster, "AttackHasHit"))
        return GetLocalInt(oCaster, "AttackHasHit");
    string sCacheName = "AttackHasHit_"+ObjectToString(oTarget);
    if(GetLocalInt(oCaster, sCacheName))
        return GetLocalInt(oCaster, sCacheName);
    if(GetHasTemplate(TEMPLATE_DEMILICH, oCaster))
        nAttackBonus += GetHitDice(oCaster);
    int nResult = GetAttackRoll(oTarget,oCaster,OBJECT_INVALID,0,nAttackBonus,0,nDisplayFeedback,0.0,TOUCH_ATTACK_RANGED_SPELL);
    SetLocalInt(oCaster, sCacheName, nResult);
    DelayCommand(1.0, DeleteLocalInt(oCaster, sCacheName));
    return nResult;
}

int PRCDoMeleeTouchAttack(object oTarget, int nDisplayFeedback = TRUE, object oCaster = OBJECT_SELF, int nAttackBonus = 0)
{
    if(GetLocalInt(oCaster, "AttackHasHit"))
        return GetLocalInt(oCaster, "AttackHasHit");
    string sCacheName = "AttackHasHit_"+ObjectToString(oTarget);
    if(GetLocalInt(oCaster, sCacheName))
        return GetLocalInt(oCaster, sCacheName);
    if(GetHasTemplate(TEMPLATE_DEMILICH, oCaster))
        nAttackBonus += GetHitDice(oCaster);
    int nResult = GetAttackRoll(oTarget,oCaster,OBJECT_INVALID,0,nAttackBonus,0,nDisplayFeedback,0.0,TOUCH_ATTACK_MELEE_SPELL);
    SetLocalInt(oCaster, sCacheName, nResult);
    DelayCommand(1.0, DeleteLocalInt(oCaster, sCacheName));
    return nResult;
}

// return sneak attack damage for a spell
// requires caster, target, and spell damage type
int SpellSneakAttackDamage(object oCaster, object oTarget)
{
     if (GetLocalInt(oCaster, "NoSpellSneak"))
         return 0;

     int numDice = GetTotalSneakAttackDice(oCaster);

     if(numDice != 0 && GetCanSneakAttack(oTarget, oCaster) )
     {
          FloatingTextStringOnCreature("*Sneak Attack Spell*", oCaster, TRUE);
          return GetSneakAttackDamage(numDice);
     }
     else
     {
          return 0;
     }
}

//Applies damage from touch attacks,
//  returns result of attack roll
//
//  object oCaster, the attacker
//  object oTarget, the victim
//  int iAttackRoll, the result of a touch
//      attack roll, 1 for hit, 2 for
//      critical hit
//  int iDamage, the normal amount of damage done
//  int iDamageType, the damage type
//  int iDamageType2, the 2nd damage type
//      if 2 types of damage are applied
int ApplyTouchAttackDamage(object oCaster, object oTarget, int iAttackRoll, int iDamage, int iDamageType, int iDamageType2 = -1)
{
    if(iAttackRoll == 2)  iDamage *= 2;
    if(!GetPRCSwitch(PRC_SPELL_SNEAK_DISABLE))
        iDamage += SpellSneakAttackDamage(oCaster, oTarget);
    //iDamage += ApplySpellBetrayalStrikeDamage(oTarget, oCaster);
    if(iAttackRoll > 0)
    {
        if(iDamageType2 == -1)
            ApplyEffectToObject(DURATION_TYPE_INSTANT, PRCEffectDamage(oTarget, iDamage, iDamageType), oTarget);
        else
        {   //for touch attacks with 2 damage types, 1st damage type has priority
            ApplyEffectToObject(DURATION_TYPE_INSTANT, PRCEffectDamage(oTarget, iDamage / 2, iDamageType2), oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage - (iDamage / 2), iDamageType), oTarget);
        }
    }

    return iAttackRoll;
}

//routes to DoRacialSLA, but checks that the ray hits first
//not sure how this will work if the spell does multiple touch attack, hopefully that shouldnt apply
//this is Base DC, not total DC. SLAs are still spells, so spell focus should still apply.
void DoSpellRay(int nSpellID, int nCasterlevel = 0, int nTotalDC = 0)
{
    int nAttack = PRCDoRangedTouchAttack(PRCGetSpellTargetObject());
    if(nAttack)
    {
        ActionDoCommand(SetLocalInt(OBJECT_SELF, "AttackHasHit", nAttack)); //preserve crits
        if(DEBUG) DoDebug("Spell DC passed to DoSpellRay: " + IntToString(nTotalDC));
        DoRacialSLA(nSpellID, nCasterlevel, nTotalDC);
        ActionDoCommand(DeleteLocalInt(OBJECT_SELF, "AttackHasHit"));
    }
}

//routes to DoRacialSLA, but checks that the rouch hits first
//not sure how this will work if the spell does multiple touch attack, hopefully that shouldnt apply
//this is Base DC, not total DC. SLAs are still spells, so spell focus should still apply.
void DoSpellMeleeTouch(int nSpellID, int nCasterlevel = 0, int nTotalDC = 0)
{
    int nAttack = PRCDoMeleeTouchAttack(PRCGetSpellTargetObject());
    if(nAttack)
    {
        ActionDoCommand(SetLocalInt(OBJECT_SELF, "AttackHasHit", nAttack)); //preserve crits
        DoRacialSLA(nSpellID, nCasterlevel, nTotalDC);
        ActionDoCommand(DeleteLocalInt(OBJECT_SELF, "AttackHasHit"));
    }
}