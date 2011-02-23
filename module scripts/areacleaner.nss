//::///////////////////////////////////////////////
//:: Name : Area Cleaner Script
//:: FileName : areacleaner

//:://////////////////////////////////////////////
/*

Place the 'Area Cleaner' placeable in an area.

Every 10 minutes it will 'flag' bodybag objects. While flagging
if it finds a bodybag that has already been flagged it will destroy it.

The end result is that 20 min after a mob dies it's bodybag will be removed.

This will help keep areas free of trash.

*/
//:://////////////////////////////////////////////
//:: Created By: Jaris Tarconis http://www.aot.guildcentral.org
//:: Created On: 08-17-2002
//:://////////////////////////////////////////////
void Proceed();
void DoDest();

void main(){
    if(GetLocalInt(OBJECT_SELF,"Cleaning") == 1){return;}
    SetLocalInt(OBJECT_SELF,"Cleaning",1);
    AssignCommand(OBJECT_SELF,Proceed());
}

void Proceed(){
    object oAreaOb=GetFirstObjectInArea();
    while(GetIsObjectValid(oAreaOb)){
        int nMarked=GetLocalInt(oAreaOb,"IsMarked");
        if ((GetTag(oAreaOb) == "BodyBag") && (nMarked == 1))
        {
            AssignCommand(oAreaOb,DoDest());
        }

        else if (GetTag(oAreaOb) == "BodyBag")
        {
            SetLocalInt(oAreaOb,"IsMarked",1);
        }

        else if ((GetTag(oAreaOb) == "youngelderkindcl") && (nMarked == 1))
        {
           AssignCommand(oAreaOb,DoDest());
        }

        else if (GetTag(oAreaOb) == "youngelderkindcl")
        {
            SetLocalInt(oAreaOb,"IsMarked",1);
        }
       else if ((GetTag(oAreaOb) == "goldflake") && (nMarked == 1))
        {
           AssignCommand(oAreaOb,DoDest());
        }

        else if (GetTag(oAreaOb) == "goldflake")
        {
            SetLocalInt(oAreaOb,"IsMarked",1);
        }




        oAreaOb=GetNextObjectInArea();
    }
    DelayCommand(300.0f,Proceed());
}

void DoDest(){
    object oInv=GetFirstItemInInventory(OBJECT_SELF);
    while(GetIsObjectValid(oInv)){
        DestroyObject(oInv);
        oInv=GetNextItemInInventory(OBJECT_SELF);
    }
    DelayCommand(1.0f,DestroyObject(OBJECT_SELF));
}

