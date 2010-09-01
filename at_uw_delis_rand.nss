void main()
{

string sDest;

int iPortPlace=GetLocalInt (OBJECT_SELF,"PortLocation");
    if (iPortPlace==0)
    { /////this shaft has not been useed this game

      int iGoOn=0;
        while (iGoOn==0)
         {
            int roll= Random(15)+1;
       //     SpeakString ("rolled:"+IntToString (roll) ,TALKVOLUME_SHOUT);
   //// has it been used?
              if (GetLocalInt( GetModule(),"PortLocked"+IntToString(roll))==0)
              { ////  the random destination is NOT locked
                 // Lock it
                 SetLocalInt( GetModule(),"PortLocked"+IntToString(roll),1) ;
                 // Set the Shafts int
                 SetLocalInt( OBJECT_SELF,"PortLocation",roll) ;
                 //get out of the loop
                   iGoOn=1 ;
               }
          }
    }

  ////  Now we have set the local for the shaft and the mod if necessary
  /////  Build the wayponnt string and port the user

int iJumpNum=  GetLocalInt(OBJECT_SELF,"PortLocation") ;
sDest="uw_delusion_"+ IntToString(iJumpNum);

//SpeakString ("PortLocation:"+IntToString (iJumpNum)+  " Portstring: "+ sDest ,TALKVOLUME_SHOUT);




object oJumper= GetLastUsedBy();
//SpeakString ("The sDest is " + sDest,TALKVOLUME_SHOUT);
object oidDest = GetWaypointByTag(sDest);

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
