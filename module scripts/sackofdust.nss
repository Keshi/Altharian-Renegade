/////:://///////////////////////////////////////////////////////////////////////
/////::Gem of refracted light script
/////::Modified/Written by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
    effect eSummon;
    location lLocation;
    object oPC = GetPCSpeaker();
    string Piece = GetLocalString(oPC,"gemsummon");

    eSummon = EffectSummonCreature(Piece,VFX_FNF_GAS_EXPLOSION_EVIL,0.5f);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSummon, oPC, 1800.0f);
    AddHenchman (oPC, GetObjectByTag(Piece));
}
