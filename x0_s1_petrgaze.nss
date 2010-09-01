//::///////////////////////////////////////////////////
//:: X0_S1_PETRGAZE
//:: Petrification gaze monster ability.
//:: Fortitude save (DC 15) or be turned to stone permanently.
//:: This will be changed to a temporary effect.
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/14/2002
//::///////////////////////////////////////////////////
//:: Used by Basilisk


#include "x0_i0_spells"

void main()
{
    object oTarget = GetSpellTargetObject();
    int nHitDice = GetHitDice(OBJECT_SELF);


    location lTargetLocation = GetSpellTargetLocation();

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 20.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;

        object oSelf = OBJECT_SELF;


        if(!GetIsReactionTypeFriendly(oTarget))
        {

        float fTime = 0.0;
        int bIsPC = GetIsPC(oTarget);
        fTime = 45.0f -IntToFloat(nHitDice); // One Round per hit-die or caster level
        if (GetTag(OBJECT_SELF)=="lessermedusa")  fTime = 65.0f -IntToFloat(nHitDice);
         if (GetTag(OBJECT_SELF)=="greatermedusa")  fTime = 105.0f -IntToFloat(nHitDice);
         if (GetTag(OBJECT_SELF)=="petra")  fTime = 125.0f -IntToFloat(nHitDice);

        int nSaveDC = 60; //// modify this
         if (GetTag(OBJECT_SELF)=="lessermedusa")  nSaveDC=70;
         if (GetTag(OBJECT_SELF)=="greatermedusa") nSaveDC=80;
          if (GetTag(OBJECT_SELF)=="petra") nSaveDC=90;




        effect ePetrify = EffectPetrify();

        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

        effect eLink = EffectLinkEffects(eDur, ePetrify);


            // Do a fortitude save check
            if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nSaveDC))
            {
                // Save failed; apply paralyze effect and VFX impact

                /// * The duration  temporary
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fTime);

             }
                // April 2003: Clearing actions to kick them out of conversation when petrified
                AssignCommand(oTarget, ClearAllActions(TRUE));

         }

     //Get next target in spell area
    oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, 20.0, lTargetLocation, TRUE);
    }

 }


