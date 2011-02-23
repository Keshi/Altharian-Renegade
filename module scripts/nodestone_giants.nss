///////////////
///// Special property of Nodestone that allows them to transport user
///// to the attuned Node Gate.  Outside of certain areas, the Nodestone
///// will not function.  You have to be within range of the same Node Gate.
///// Modified by Winterknight on 9/17/05.
///////////////

void main()
{
  // modified from Portal Rune script as run on 12 dark secrets.
  object oItem = GetItemActivated();
  object oUser = GetItemActivator();
  string sAreaTag = GetTag(GetArea(oUser));
  string sPref = GetStringLeft(sAreaTag,5);
  location lRecall = GetLocation(oUser);
  int iHasRecalled;
  int canport=0;
  if (sPref == "3ppp_" ||
      sPref == "3ppf_" ||
      sPref == "3ppc_" ||
      sPref == "3pps_") canport=1;

  PlaySound ("as_mg_telepout1");
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oUser);

  if (canport!=1)
  {
    SendMessageToPC(oUser,"The distance to the Node Gate is too far, or something is interfering with its ability to recall you.");
  }
  else
  {
    SetLocalLocation(oUser,"lRecall",lRecall);
    SetLocalInt(oUser,"iHasRecalled",1);
    DelayCommand(1.0, AssignCommand(oUser, JumpToObject(GetObjectByTag("WP_NODE_giants"))));
    return ;
  }
}
