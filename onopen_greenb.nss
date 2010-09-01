
void createhack(string sRef,object oChest)
{
    CreateItemOnObject(sRef,oChest,1);

}

void main()
{
 object oChest=OBJECT_SELF;
 string sRef="greenberry";
  object oArea= GetObjectByTag("Roomwith7DoorsSouth");
  int iMinute = GetLocalInt (oArea,"minute") ;
  int iWhenToGrowLeaf = GetLocalInt (OBJECT_SELF,"WhenToGrowLeaf") ;


  if (iWhenToGrowLeaf < iMinute)
  {
   /// set when to sprout the next leaf
   SetLocalInt (OBJECT_SELF,"WhenToGrowLeaf",iMinute+60)  ;
   // put 2 leaves in inventory

DelayCommand(0.25f,createhack(sRef,oChest));









  }


}
