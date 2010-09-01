//::///////////////////////////////////////////////
//:: FileName healplayer
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 08/20/2002 4:30:46 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    effect eHeal = EffectHeal(2000);
    effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP, FALSE);
    effect ePC = GetFirstEffect(oPC);
    while (GetIsEffectValid(ePC))
    {
      RemoveEffect(oPC,ePC);
      ePC=GetNextEffect(oPC);
    }
    ePC=EffectLinkEffects(eVis,eHeal);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,ePC,oPC,0.2);
}
