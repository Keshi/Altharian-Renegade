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
  object oUserArea=GetArea (oUser);
  string sAreaTag = GetTag(oUserArea);
  string sCheck = GetStringLeft(sAreaTag,5);
  location lRecall = GetLocation(oUser);
  int iHasRecalled;
  int canport=0;
       if (sCheck =="Abyss") canport=1;

     PlaySound ("as_mg_telepout1");
     ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oUser);

       if (canport<1)
          {
          SendMessageToPC(oUser,"The distance to the Node Gate is too far, or something is interfering with its ability to recall you.");
          }
       else
          {
          SetLocalLocation(oUser,"lRecall",lRecall);
          SetLocalInt(oUser,"iHasRecalled",1);
          string sPoint = IntToString(canport);
          DelayCommand(1.0, AssignCommand(oUser, JumpToObject(GetObjectByTag("pc_TC9Enter"))));
          return ;
          }
}
