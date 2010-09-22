// Carson 2010-09-11
// Part of the automated wishing system
// Boots the PC and uses letoscript to increase PC stats
#include "inc_wish"
#include "inc_letocommands"

// void wrapper for delaycommand
void BootAndRunScript(object player)
{
    SendMessageToPC(player, "Commencing edit!");
    RunStackedLetoScriptOnObject(player, "OBJECT", "SPAWN");
}
void RemoveStuffFromPlayerAndContinueScript(object player, struct AbilityModRequirements reqs)
{
    object item = GetFirstItemInInventory(player);
    while (item!=OBJECT_INVALID)
    {
        string tag = GetTag(item);
        if (reqs.UltimateWishes>0)
            if (tag == "ultimatewish")
            {
                DestroyObject(item);
                reqs.UltimateWishes -= 1;
            }
        if (reqs.GreaterWishes>0)
            if (tag == "wish001")
            {
                DestroyObject(item);
                reqs.GreaterWishes -= 1;
            }
        if (reqs.Wishes>0)
            if (tag == "wish")
            {
                DestroyObject(item);
                reqs.Wishes -= 1;
            }
        item = GetNextItemInInventory(player);
    }
    TakeGoldFromCreature(reqs.Gold, player);

    ExecuteScript("wish_c_reset", player);

    // Delay this because we need to take away the wish items first, and item deletion runs after the current script completes
    DelayCommand(0.5f, BootAndRunScript(player));
}
void CheckForExploitAndContinueScript(object player)
{
    struct Abilities mod = ReadCurrentAbilityModSettings(player);
    // Make sure they didn't drop their money right before confirming
	if (!CanPlayerAffordAbilityMod(player,mod))
    {
        SendMessageToPC(player, "Wish aborted!  Please try again.");
        return;
    }

    struct Abilities base;
    base.Str = GetAbilityScore(player, ABILITY_STRENGTH, TRUE);
    base.Dex = GetAbilityScore(player, ABILITY_DEXTERITY, TRUE);
    base.Con = GetAbilityScore(player, ABILITY_CONSTITUTION, TRUE);
    base.Int = GetAbilityScore(player, ABILITY_INTELLIGENCE, TRUE);
    base.Wis = GetAbilityScore(player, ABILITY_WISDOM, TRUE);
    base.Cha = GetAbilityScore(player, ABILITY_CHARISMA, TRUE);



    //Ability Scores
    string sScript;
    if (mod.Str>0)
        sScript += SetAbility(ABILITY_STRENGTH, mod.Str + base.Str);
    if (mod.Dex>0)
        sScript += SetAbility(ABILITY_DEXTERITY, mod.Dex + base.Dex);
    if (mod.Con>0)
        sScript += SetAbility(ABILITY_CONSTITUTION, mod.Con + base.Con);
    if (mod.Int>0)
        sScript += SetAbility(ABILITY_INTELLIGENCE, mod.Int + base.Int);
    if (mod.Wis>0)
        sScript += SetAbility(ABILITY_WISDOM, mod.Wis + base.Wis);
    if (mod.Cha>0)
        sScript += SetAbility(ABILITY_CHARISMA, mod.Cha + base.Cha);
	
	SendMessageToPC(player, "Preparing to edit: "+sScript);
    StackedLetoScript(sScript);
    // Delay to avoid TMI
    DelayCommand(0.0f,RemoveStuffFromPlayerAndContinueScript(player, GetTotalAbilityModRequirements(base, mod)));
}

void main()
{
	//SendMessageToPC(GetPCSpeaker(), "This feature is coming soon.  Thank you for testing!");
    CheckForExploitAndContinueScript(GetPCSpeaker());
}
