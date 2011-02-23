//::///////////////////////////////////////////////
//:: wk_bossloot* scripts
//:: Scripts fire OnDeath.
//:: OnDeath event fires to activate the lootdrop.
//:://////////////////////////////////////////////

void main()
{
  if (GetUserDefinedEventNumber() == 1007)
  {
    SetLocalInt(OBJECT_SELF,"BossLoot",1);
    ExecuteScript("wk_habeuscorpus",OBJECT_SELF);
    ExecuteScript("wk_deathdrops",OBJECT_SELF);
    ExecuteScript("wk_deatheffects",OBJECT_SELF);

  }
    return;

}
