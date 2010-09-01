void main()
{
    object oCreature = GetExitingObject();
    int nFound = FALSE;
    effect eEffect = GetFirstEffect(oCreature);
    //remove effect if it was created by this trigger
    while (nFound == FALSE)
    {
        //if the effect creator was the trigger
        if (GetEffectCreator(eEffect) == OBJECT_SELF)
        {
            RemoveEffect(oCreature, eEffect);
            nFound = TRUE;
        }
        eEffect = GetNextEffect(oCreature);
        if (GetEffectType(eEffect) == EFFECT_TYPE_INVALIDEFFECT)
        {
            nFound = TRUE;
        }

    }
}
