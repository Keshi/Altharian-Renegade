//::///////////////////////////////////////////////
//:: wk_chestloot* scripts
//:: Scripts fire OnUsed.
//:: Destroys object after delay.
//:://////////////////////////////////////////////

void main()
{
    object oChest = OBJECT_SELF;
    int nCheck = GetLocalInt(oChest,"AmILooted");
    if (nCheck != 1)
    {
      SetLocalInt(oChest,"BossLoot",5);
      ExecuteScript("wk_habeuschest",oChest);
      SetLocalInt(oChest,"AmILooted",1);
    }
}
