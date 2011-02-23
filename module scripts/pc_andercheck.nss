void main()
{
object oPC=GetPCSpeaker();

string sTag=GetTag(OBJECT_SELF);

SetLocalInt(oPC, sTag, 1);
}
