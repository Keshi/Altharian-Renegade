void main()
{
    object oPC = GetLastUsedBy();
    object oSelf = OBJECT_SELF;
    AssignCommand(oPC,ActionSit(oSelf));
}
