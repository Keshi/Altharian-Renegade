void main()
{
object oJumper=GetEnteringObject();
if ( GetIsPC(oJumper))
    {
     if(GetLocalInt(OBJECT_SELF,"howmany") >0)
        {

          SendMessageToAllDMs(" The number of people on Drepression is: "+IntToString(GetLocalInt(OBJECT_SELF,"howmany")+1));
        //  port the dude to the front door
         string sDest =  "outdepression";
            object oidDest=GetObjectByTag(sDest);

           AssignCommand(oJumper,ClearAllActions());
           DelayCommand(0.1, AssignCommand(oJumper,ActionJumpToObject(oidDest,FALSE)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oJumper),ClearAllActions());
           DelayCommand(0.1,AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oJumper),ActionJumpToObject(oidDest)));

           SetLocalInt (OBJECT_SELF,"howmany",GetLocalInt(OBJECT_SELF,"howmany")+1);

          SendMessageToPC (oJumper,"Depression is suffered ALONE");

        }
     else
        {

        SetLocalInt (OBJECT_SELF,"howmany",1);



        }
    }
}
