void main()
{
object oJumper= GetLastUsedBy();
object oidDest=GetObjectByTag("uw_delusion_00");

//SpeakString ("The sDest is " + sDest,TALKVOLUME_SHOUT);
PlaySound ("as_mg_telepout1");
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_DISPEL_GREATER),OBJECT_SELF);





            AssignCommand(oJumper,ClearAllActions());
           DelayCommand(1.3, AssignCommand(oJumper,ActionJumpToObject(oidDest,FALSE)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oJumper),ClearAllActions());
           DelayCommand(1.3, AssignCommand(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oJumper),ClearAllActions());
           DelayCommand(1.3, AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oJumper),ClearAllActions());
           DelayCommand(1.3, AssignCommand(GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oJumper),ActionJumpToObject(oidDest)));

            AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oJumper),ClearAllActions());
           DelayCommand(1.3,AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED,oJumper),ActionJumpToObject(oidDest)));




















}
