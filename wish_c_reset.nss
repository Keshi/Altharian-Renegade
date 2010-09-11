// Carson 2010-9-11
// Part of the automated wishing system
// Call this at beginning of the conversation
void main()
{
    object pc = GetPCSpeaker();
    DeleteLocalInt(pc,"wish_inc_str");
    DeleteLocalInt(pc,"wish_inc_dex");
    DeleteLocalInt(pc,"wish_inc_con");
    DeleteLocalInt(pc,"wish_inc_int");
    DeleteLocalInt(pc,"wish_inc_wis");
    DeleteLocalInt(pc,"wish_inc_cha");
}
