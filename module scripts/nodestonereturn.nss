// Return to NodeStone last used location.
// modified by Winterknight
// **

void main()
{
  object oUser = GetPCSpeaker();
  int iYes = GetLocalInt(oUser,"iHasRecalled");
  if (iYes == 1)
     {
     location lLoc = GetLocalLocation(oUser, "lRecall");
     TakeGoldFromCreature(500, oUser, TRUE);
     ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
     DelayCommand(1.0,AssignCommand(oUser, JumpToLocation(lLoc)));
     }

if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE)
    {
    int nActive = GetLocalInt (OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE");
    // * Play Appropriate Animation
        if (!nActive)
            {
            ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
            }
        else
            {
            DelayCommand(1.0, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
            }
    // * Store New State
    SetLocalInt(OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE",!nActive);
    }
}

