void main()
{

    string sDest = GetLocalString(OBJECT_SELF,"wpEnter") ;
    object oJumper= GetEnteringObject();

    object oidDest = GetWaypointByTag(sDest);

           AssignCommand(oJumper,ClearAllActions());
           DelayCommand(0.1, AssignCommand(oJumper,ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oJumper),ClearAllActions());
           DelayCommand(0.1, AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oJumper),ClearAllActions());
           DelayCommand(0.1,AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oJumper),ActionJumpToObject(oidDest)));
}
