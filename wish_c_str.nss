// Carson 2010-9-11
// Part of the automated wishing system
#include "inc_wish"
void main()
{
    object pc = GetPCSpeaker();
    int newval =  GetLocalInt(pc, "wish_inc_str")+1;
    SetLocalInt(pc, "wish_inc_str", newval);
    FixCustomTokens();
}
