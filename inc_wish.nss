// Carson 2010-9-11
// Include file for the automated wishing system
// See wish_c_finalize

struct AbilityModRequirements
{
    int UltimateWishes;
    int GreaterWishes;
    int Wishes;
    int Gold;
};
struct Abilities
{
    int Str;
    int Dex;
    int Int;
    int Con;
    int Wis;
    int Cha;
};

int nmin(int x, int y) { return x>y?y:x; }
int nmax(int x, int y) { return x>y?x:y; }

// All parameters should be given as the pre-adjustment value.  range_min and range_max are inclusive.
/*
test cases:
18,1,0,19  // within, should be 1
18,3,0,19  // extending above, should be 1
18,1,20,24 // below, should be 0
18,3,20,24 // extending below should be 2
25,3,20,24 // above, should be 0
18,10,20,24 // superset, should be 5
*/

int CalcIncreasesFromRange(int base, int num_increase, int range_min, int range_max)
{
	int toolow = nmax(0, range_min - base - 1);
	int toohigh = nmax(0, base + num_increase - range_max);
	int inrange = num_increase - toolow - toohigh;
	inrange = nmin(num_increase, inrange);  // handles the cases where all increases are out of range
	return inrange;
}

// increasing from 35-39 requires 1 ultimate wish each
int CalcUltimateWishesRequired(int base, int mod)
{
    return CalcIncreasesFromRange(base, mod, 35, 5);
}
int CalcTotalUltimateWishesRequired(struct Abilities base, struct Abilities mod)
{
    return
        (CalcUltimateWishesRequired(base.Str, mod.Str)
        +CalcUltimateWishesRequired(base.Dex, mod.Dex)
        +CalcUltimateWishesRequired(base.Con, mod.Con)
        +CalcUltimateWishesRequired(base.Int, mod.Int)
        +CalcUltimateWishesRequired(base.Wis, mod.Wis)
        +CalcUltimateWishesRequired(base.Cha, mod.Cha));
}
// Incrementing from 30-34 requires 1 greater wish each
int CalcGreaterWishesRequired(int base, int mod)
{
    return CalcIncreasesFromRange(base, mod, 30, 5);
}

int CalcTotalGreaterWishesRequired(struct Abilities base, struct Abilities mod)
{
    return
        (CalcGreaterWishesRequired(base.Str, mod.Str)
        +CalcGreaterWishesRequired(base.Dex, mod.Dex)
        +CalcGreaterWishesRequired(base.Con, mod.Con)
        +CalcGreaterWishesRequired(base.Int, mod.Int)
        +CalcGreaterWishesRequired(base.Wis, mod.Wis)
        +CalcGreaterWishesRequired(base.Cha, mod.Cha));
}


// Incrementing from 25-29 requires 3 wishes each.  20-24 requires 2 wishes each.
int CalcWishesRequired(int base, int mod)
{
    return CalcIncreasesFromRange(base, mod, 20, 5) * 2
          +CalcIncreasesFromRange(base, mod, 25, 5) * 3;
}

int CalcTotalWishesRequired(struct Abilities base, struct Abilities mod)
{
    return
        (CalcWishesRequired(base.Str, mod.Str)
        +CalcWishesRequired(base.Dex, mod.Dex)
        +CalcWishesRequired(base.Con, mod.Con)
        +CalcWishesRequired(base.Int, mod.Int)
        +CalcWishesRequired(base.Wis, mod.Wis)
        +CalcWishesRequired(base.Cha, mod.Cha));
}
int CalcGoldRequired(int base, int mod)
{
    int relevant = 20-base;
    if (relevant<=0)
        return 0;
    else if (relevant > mod)
        relevant = mod;
    return relevant * 1000000;
}
// Incrementing from 0-19 requires 1 million gold each.
int CalcTotalGoldRequired(struct Abilities base, struct Abilities mod)
{
    return
        (CalcGoldRequired(base.Str, mod.Str)
        +CalcGoldRequired(base.Dex, mod.Dex)
        +CalcGoldRequired(base.Con, mod.Con)
        +CalcGoldRequired(base.Int, mod.Int)
        +CalcGoldRequired(base.Wis, mod.Wis)
        +CalcGoldRequired(base.Cha, mod.Cha));
}

struct AbilityModRequirements GetTotalAbilityModRequirements(struct Abilities base, struct Abilities mod)
{
    struct AbilityModRequirements req;
    req.Gold = CalcTotalGoldRequired(base,mod);
    req.Wishes = CalcTotalWishesRequired(base,mod);
    req.GreaterWishes =CalcTotalGreaterWishesRequired(base,mod);
    req.UltimateWishes =CalcTotalUltimateWishesRequired(base,mod);
    return req;
}
int CountNonStackingItemsInInventoryWithTag(object player, string tag)
{
    int count = 0;
    object item = GetFirstItemInInventory(player);
    while (item != OBJECT_INVALID)
    {
        if (GetTag(item) == tag)
            count++;
        item = GetNextItemInInventory(player);
    }
    SendMessageToPC(player, "You have "+IntToString(count)+" items with the tag "+tag);
    return count;
}

// Calculates the total resources required for the change, and checks if the player has that.
int CanPlayerAffordAbilityMod(object player, struct Abilities mod)
{
    struct Abilities base;
    base.Str = GetAbilityScore(player, ABILITY_STRENGTH, TRUE);
    base.Dex = GetAbilityScore(player, ABILITY_DEXTERITY, TRUE);
    base.Con = GetAbilityScore(player, ABILITY_CONSTITUTION, TRUE);
    base.Int = GetAbilityScore(player, ABILITY_INTELLIGENCE, TRUE);
    base.Wis = GetAbilityScore(player, ABILITY_WISDOM, TRUE);
    base.Cha = GetAbilityScore(player, ABILITY_CHARISMA, TRUE);


    struct AbilityModRequirements req = GetTotalAbilityModRequirements(base,mod);
    if (GetGold(player) < req.Gold)
        return FALSE;
    if (CountNonStackingItemsInInventoryWithTag(player,"wish") < req.Wishes)
        return FALSE;
    if (CountNonStackingItemsInInventoryWithTag(player,"wish001") < req.GreaterWishes)
        return FALSE;
    if (CountNonStackingItemsInInventoryWithTag(player,"ultimatewish") < req.UltimateWishes)
        return FALSE;
    return TRUE;
}
// reads the ability mods for the wish redemption conversation system
struct Abilities ReadCurrentAbilityModSettings(object player)
{
    struct Abilities mod;
    mod.Str = GetLocalInt(player, "wish_inc_str");
    mod.Dex = GetLocalInt(player, "wish_inc_dex");
    mod.Con = GetLocalInt(player, "wish_inc_con");
    mod.Int = GetLocalInt(player, "wish_inc_int");
    mod.Wis = GetLocalInt(player, "wish_inc_wis");
    mod.Cha = GetLocalInt(player, "wish_inc_cha");
    return mod;

}

string AbilityIncreasesToString(struct Abilities inc)
{
    string o;
    int first = 1;
    if (inc.Str > 0)
    {
        if (!first)
            o+=", ";
        o += "Strength by "+IntToString(inc.Str);
        first=0;
    }
    if (inc.Dex > 0)
    {
        if (!first)
            o+=", ";
        o += "Dexterity by "+IntToString(inc.Dex) + " ";
        first=0;
    }
    if (inc.Con > 0)
    {
        if (!first)
            o+=", ";
        o += "Constitution by "+IntToString(inc.Con) + " ";
        first=0;
    }
    if (inc.Int > 0)
    {
        if (!first)
            o+=", ";
        o += "Intelligence by "+IntToString(inc.Int) + " ";
        first=0;
    }
    if (inc.Wis > 0)
    {
        if (!first)
            o+=", ";
        o += "Wisdom by "+IntToString(inc.Wis) + " ";
        first=0;
    }
    if (inc.Cha > 0)
    {
        if (!first)
            o+=", ";
        o += "Charisma by "+IntToString(inc.Cha) + " ";
        first=0;
    }
    if (first == 1)
        return "nothing";
    else
        return o;
}
string RequirementsToString(struct AbilityModRequirements req)
{
    int first = 1;
    string o;
    if (req.UltimateWishes > 0)
    {
        if (!first)
            o+=", ";
        first = 0;
        o+=IntToString(req.UltimateWishes) + " Ultimate Wishes";
    }
    if (req.GreaterWishes > 0)
    {
        if (!first)
            o+=", ";
        first = 0;
        o+=IntToString(req.GreaterWishes) + " Greater Wishes";
    }
    if (req.Wishes > 0)
    {
        if (!first)
            o+=", ";
        first = 0;
        o+=IntToString(req.Wishes) + " Wishes";
    }
    if (req.Gold > 0)
    {
        if (!first)
            o+=", ";
        first = 0;
        o+=IntToString(req.Gold) + " Gold";
    }
    if (first == 1)
        return "nothing";
    else
        return o;

}
void FixCustomTokens()
{
    object player = GetPCSpeaker();
    struct Abilities mod =  ReadCurrentAbilityModSettings(player);
    struct Abilities base;
    base.Str = GetAbilityScore(player, ABILITY_STRENGTH, TRUE);
    base.Dex = GetAbilityScore(player, ABILITY_DEXTERITY, TRUE);
    base.Con = GetAbilityScore(player, ABILITY_CONSTITUTION, TRUE);
    base.Int = GetAbilityScore(player, ABILITY_INTELLIGENCE, TRUE);
    base.Wis = GetAbilityScore(player, ABILITY_WISDOM, TRUE);
    base.Cha = GetAbilityScore(player, ABILITY_CHARISMA, TRUE);
    struct AbilityModRequirements req = GetTotalAbilityModRequirements(base, mod);
    SetCustomToken(14242, "Increasing "+AbilityIncreasesToString(mod)+" would cost you "+RequirementsToString(req)+".");
}
//void main()
//{
//}
