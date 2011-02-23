///////////////
///// Shut Off Node Gate At conversation end
///// Written by Gameskippy (stolen from Bioware and modified) 9/17/05
///////////////

void main()
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
