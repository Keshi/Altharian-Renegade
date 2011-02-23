/////:://///////////////////////////////////////////////////////////////////
/////:: Modified for Altharia by Winterknight
/////:: Adapted from original 12DS script
/////:: Last modified on 3/15/08 to remove the requirement for a positive
/////::   mithril balance to make a deposit.
/////:://///////////////////////////////////////////////////////////////////

void main()
{

object oItem=GetInventoryDisturbItem();
object oPC=GetLastUsedBy();
string sItem=GetTag (oItem);
int nWorth;
string sCause;
int nXP;

if (sItem=="mithrildust")
    {nWorth = 1;
     nXP = 10;
     sCause = "small";}
if (sItem=="mithrilchip")
    {nWorth = 5;
     nXP = 20;
     sCause = "moderate";}
if (sItem=="mithrilnugget")
    {nWorth = 20;
     nXP = 50;
     sCause = "large";}
if (sItem=="wish")
    {nWorth = 35;
     nXP = 100;
     sCause = "significant";}
if (sItem=="mcrafttoken")
    {nWorth = 400;
     nXP = 1000;
     sCause = "considerable";}
if (sItem=="grcrafttoken")
    {nWorth = 600;
     nXP = 1000;
     sCause = "considerable";}
if (sItem=="tokenofmithril")
    {nWorth = 500;
     nXP = 1000;
     sCause = "massive";}

    string sCampaign = "12dark2" ;
    string sVar="mithril" ;
    int iMith= GetCampaignInt(sCampaign,sVar,oPC);

    DestroyObject(oItem,0.1f) ;
    iMith=iMith+nWorth;

    GiveXPToCreature(oPC,nXP);

    SendMessageToPC(oPC,"You have added a "+sCause+" amount to the coffers of Viisperfjorg. Mithril Credit:"+IntToString(iMith));
    PlaySound("as_cv_bellship1");
    SetCampaignInt(sCampaign,sVar,iMith,oPC);

}
