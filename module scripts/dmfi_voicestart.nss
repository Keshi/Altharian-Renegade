//Place the code in OnModuleLoad event in Module Properties
//Or load this file with the line:
//ExecuteScript("dmfi_voicestart", GetModule());
void main()
{
    object oMod = GetModule();
    //Battle Cries
    SetLocalString(oMod, "hls20610", "Flavor Text"); //Category 1
    SetLocalString(oMod, "hls20611", "There is a peculiar stench in this area.");
    SetLocalString(oMod, "hls20612", "You hear something in this area.");
    SetLocalString(oMod, "hls20613", "You see shadows flit about on the wall.");
    SetLocalString(oMod, "hls20614", "There is something strange about this area.");
    SetLocalString(oMod, "hls20615", "You hear distant voices.");
    SetLocalString(oMod, "hls20616", "Something is wrong, but you don't know what it is.");
    SetLocalString(oMod, "hls20617", "You feel as though you are being watched.");
    SetLocalString(oMod, "hls20618", "An arcane chill passes over you.");
    SetLocalString(oMod, "hls20619", "Bloodstains decorate the floor here.");

    //Questions
    SetLocalString(oMod, "hls20620", "Questions"); //Category 2
    SetLocalString(oMod, "hls20621", "Yes? Can I help you?");
    SetLocalString(oMod, "hls20622", "I'm sorry, what did you say?");
    SetLocalString(oMod, "hls20623", "Who are you?");
    SetLocalString(oMod, "hls20624", "What are you doing here?");
    SetLocalString(oMod, "hls20625", "Are you lost?");
    SetLocalString(oMod, "hls20626", "Can you help me with this?");
    SetLocalString(oMod, "hls20627", "How are you feeling?");
    SetLocalString(oMod, "hls20628", "Can you heal me?");
    SetLocalString(oMod, "hls20629", "Don't you have something better to do?");

    //Merchants
    SetLocalString(oMod, "hls20630", "Merchants"); //Category 3
    SetLocalString(oMod, "hls20631", "What are you trying to sell me here? Junk?");
    SetLocalString(oMod, "hls20632", "The finest weapons in the land!");
    SetLocalString(oMod, "hls20633", "Hmm... that looks very valuable.");
    SetLocalString(oMod, "hls20634", "'Ello. What can I do for ye?");
    SetLocalString(oMod, "hls20635", "Morsels! Tasty morsels and bits!");
    SetLocalString(oMod, "hls20636", "Sausages! Sausages in a bun!");
    SetLocalString(oMod, "hls20637", "We have the finest imports.");
    SetLocalString(oMod, "hls20638", "For only a copper coin of the realm!");
    SetLocalString(oMod, "hls20639", "Sale! A fire sale on everything!");

    //Singing
    SetLocalString(oMod, "hls20640", "Singing");  //Category 4
    SetLocalString(oMod, "hls20641", "Tra la la la...");
    SetLocalString(oMod, "hls20642", "Singing too ra loo ra lay...");
    SetLocalString(oMod, "hls20643", "My bonnie lass, isn't she sweet...");
    SetLocalString(oMod, "hls20644", "There once was a wench from Baldur's Gate...");
    SetLocalString(oMod, "hls20645", "My love is like a rose...");
    SetLocalString(oMod, "hls20646", "Drink with me to days gone by...");
    SetLocalString(oMod, "hls20647", "*hums a jaunty tune*");
    SetLocalString(oMod, "hls20648", "*whistles a tune you don't know*");
    SetLocalString(oMod, "hls20649", "Someone to hold me too close... someone to hurt me too deep...");

    //Guard
    SetLocalString(oMod, "hls20650", "Guards");  //Category 5
    SetLocalString(oMod, "hls20651", "Halt!");
    SetLocalString(oMod, "hls20652", "Let me see some ID");
    SetLocalString(oMod, "hls20653", "You aren't from around here, are you?");
    SetLocalString(oMod, "hls20654", "Drop your weapons and put your hands on your head!");
    SetLocalString(oMod, "hls20655", "Call the guard, we're being attacked!");
    SetLocalString(oMod, "hls20656", "*gurgles a bit* I need... help...");
    SetLocalString(oMod, "hls20657", "Hmph. This job don't pay too well, ya know?");
    SetLocalString(oMod, "hls20658", "None shall pass!");
    SetLocalString(oMod, "hls20659", "What was that? Did you hear something?");

    //Chants
    SetLocalString(oMod, "hls20660", "Chants");  //Category 6
    SetLocalString(oMod, "hls20661", "Dies irae!");
    SetLocalString(oMod, "hls20662", "Ortano vor digyamar!");
    SetLocalString(oMod, "hls20663", "Vas Por Flem!");
    SetLocalString(oMod, "hls20664", "Obidai, Veldual, Valkacht!");
    SetLocalString(oMod, "hls20665", "By the power of Greyskull!");
    SetLocalString(oMod, "hls20666", "Dei Jesu Domini...");
    SetLocalString(oMod, "hls20667", "Nu nu nu nu nu...");
    SetLocalString(oMod, "hls20668", "Homina Homina...");
    SetLocalString(oMod, "hls20669", "Does anyone ever read these?");

    //Random
    SetLocalString(oMod, "hls20670", "Random");  //Category 7
    SetLocalString(oMod, "hls20671", "Yes");
    SetLocalString(oMod, "hls20672", "No");
    SetLocalString(oMod, "hls20673", "Huh?");
    SetLocalString(oMod, "hls20674", "Have you heard the one about the wizard, the fighter, and the cleric...");
    SetLocalString(oMod, "hls20675", "That's gotta hurt!");
    SetLocalString(oMod, "hls20676", "Boo ya! Natural 20!");
    SetLocalString(oMod, "hls20677", "Where's the beef?");
    SetLocalString(oMod, "hls20678", "I can't believe I ate the whole thing...");
    SetLocalString(oMod, "hls20679", "*yodels*");

}
