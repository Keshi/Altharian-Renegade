string LetoScript(string script) {
    // Stores a var in the module which NWNX LETO then takes and works with.
    SetLocalString(GetModule(), "NWNX!LETO!SCRIPT", script);
    // Gets the var now changed by NWNX LETO back from the module and returns it.
    return GetLocalString(GetModule(), "NWNX!LETO!SCRIPT");
}
string GetBicPath(object PC) {
    string VaultPath = "E:/NWN2/servervault/";
    string Player = GetPCPlayerName(PC);
    string BicPath = VaultPath + Player + "/";

    return LetoScript(
        "print q<" + BicPath + "> + " +
        "FindNewestBic q<" + BicPath + ">;"
    );

}
void DeleteFile(string file) {
    PrintString("File to delete: "+file);
    PrintString(LetoScript("FileDelete q<" + file + ">"));
}
void DoBootDeletePC(object oPC)
{
    if (GetIsObjectValid(oPC))
    {
        BootPC(oPC);
    }
}
void DoDelete(object oPlayer)
{
    string BicFile = GetBicPath(oPlayer);
    DelayCommand(2.0, DoBootDeletePC(oPlayer));
    DelayCommand(2.5, DeleteFile(BicFile));
}
void main()
{
    object oPC = GetLastUsedBy();
    ExportSingleCharacter(oPC);
    FloatingTextStringOnCreature("Deleting character, please wait.", oPC);
    SetCommandable(FALSE, oPC);
    DelayCommand(6.0, DoDelete(oPC));
}
