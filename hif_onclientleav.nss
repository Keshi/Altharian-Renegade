// prc_onleave,onmodexit
/////////////////////////////////////////////////////////////////////
//
// This script has been auto-generated by HakInstaller to call
// multiple handlers for the onclientleave event.
//
/////////////////////////////////////////////////////////////////////

void main()
{
    ExecuteScript("prc_onleave", OBJECT_SELF);
    ExecuteScript("onmodexit", OBJECT_SELF);
}