

string showcount(object oItem)
{
int count;
    count=GetNumStackedItems(oItem);
    if (count>1) return "("+IntToString(count)+")";
        else return "";
}

int gpvalue(object oItem)
{
int cash;
if ( GetBaseItemType(oItem) == BASE_ITEM_GOLD) {
    cash=GetNumStackedItems(oItem);
} else {
    cash=GetGoldPieceValue(oItem);
}
return cash;
}


int container(object mybox,object oItem,int iEvent,int total)
{
//object oItem=GetInventoryDisturbItem();
//int iEvent=GetInventoryDisturbType();
//string sEvil;
int cash;
object oBag;
int tcash=total;
int i;
string iString;
string sCount;
object oIn;
int iItemType=GetBaseItemType(oItem);

tcash=total;
if (iEvent == INVENTORY_DISTURB_TYPE_ADDED) {
 cash=gpvalue(oItem);
sCount=showcount(oItem);
if (iItemType == BASE_ITEM_LARGEBOX) total=container(oItem,OBJECT_INVALID,-1,tcash);
if ( total ) iString=GetName(oItem)+sCount+" worth "+IntToString(cash)+"+"+IntToString(total)+" added by "+GetName(GetLastDisturbed());
    else iString=GetName(oItem)+sCount+" worth "+IntToString(cash)+" added by "+GetName(GetLastDisturbed());
} else if (iEvent == INVENTORY_DISTURB_TYPE_REMOVED) {
cash=gpvalue(oItem);
sCount=showcount(oItem);
if (iItemType == BASE_ITEM_LARGEBOX) total=container(oItem,OBJECT_INVALID,-1,tcash);
if ( total ) iString=GetName(oItem)+sCount+" worth "+IntToString(cash)+"+"+IntToString(total)+" removed by "+GetName(GetLastDisturbed());
    else iString=GetName(oItem)+sCount+" worth "+IntToString(cash)+" removed by "+GetName(GetLastDisturbed());
}

       oIn=GetFirstItemInInventory(mybox);
        i=0;
        cash=0;
        while (GetIsObjectValid(oIn)) {
         tcash=tcash+gpvalue(oIn);
            if (iEvent == -1 ) {
                cash=gpvalue(oIn);
                sCount=showcount(oIn);
                iString=GetName(oIn)+sCount+" worth "+IntToString(cash)+" in a "+ GetName(mybox);
//                SpeakString(iString+" total value is "+IntToString(tcash)+" gold.",TALKVOLUME_TALK);
                SpeakString(iString,TALKVOLUME_TALK);

                    }
            i++;

            oIn=GetNextItemInInventory(mybox);
        }
        if (  -1 != iEvent)
            SpeakString(iString+" Total value is "+IntToString(tcash)+" gold.",TALKVOLUME_TALK);
         else
            SpeakString("Total value in "+GetName(mybox)+" is "+IntToString(tcash)+" gold.",TALKVOLUME_TALK);

return tcash;
}

void main()
{
container(OBJECT_SELF,GetInventoryDisturbItem(),GetInventoryDisturbType(),0);
}

