void main()
{
AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

  object oArea = GetObjectByTag ("Roomwith7DoorsSouth");
  SetLocalInt(oArea, "minute", 599);
AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

 // Roomwith7DoorsSouth
}
