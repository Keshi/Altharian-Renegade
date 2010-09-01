void main()
{
  object oPC=GetEnteringObject();
  string sDoor="DO_ToMillerBasement";
  if (GetIsPC(oPC))
    {
     object oDoor=GetObjectByTag(sDoor);
     ActionCloseDoor(oDoor);
    }
}
