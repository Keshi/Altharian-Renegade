//Fast buffing script

void main()
{
  //After this..
  object oPC = GetPCChatSpeaker();

  //Add this where you see it here in your script.
  if(GetStringLeft(GetStringLowerCase(GetPCChatMessage()), 5) == "!buff")
  {
    //Make the PC not speak anything..
    SetPCChatMessage("");

    //Make the PC cast all of their buff spells they can cast.
    ExecuteScript("fastbuff_pc", oPC);

    //Stop the script here.
    return;
  }


}
