/////::///////////////////////////////////////////
/////:: alt_death_efx
/////:: Part of the Unified lootsystem for Altharia
/////:: Written by Winterknight for Altharia 7/21/07
/////::///////////////////////////////////////////
/////:: Calls the unified death effects script.
/////::///////////////////////////////////////////


void main()
{
   SetLocalInt(OBJECT_SELF,"lootlevel",1);
   ExecuteScript("wk_deatheffects",OBJECT_SELF);
   ExecuteScript("wk_deathdrops",OBJECT_SELF);

}
