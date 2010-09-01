/// Itharr
/// On Death script. This script fires whenever a character dies regardless
/// if they respawn or not.

void main()
{
    object oPlayer = GetLastPlayerDied();
    CreateItemOnObject("death", oPlayer, 1);

    /// Is PC really dead?
    if (!GetIsObjectValid(oPlayer))
        return;
    /// Determine level
    int pLVL=0;
    if (GetHitDice(oPlayer) <= 5) pLVL=1;

    // Start the Bleed script if player has 0 to -10hp
    SetLocalInt(oPlayer, "BLEED_STATUS", 0);
    AssignCommand(oPlayer, ClearAllActions());

    // Intialize xp penalty; Set to 0 for Altharia
    int  nPenalty = 0;

    // If 5th level or under, apply 0 xp penalty for death
    if (pLVL==1) nPenalty = 0;

    // Bring up respawn screen
    DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, TRUE, TRUE, 0));

}

