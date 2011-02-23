//Smoking Function by Jason Robinson
location GetLocationAboveAndInFrontOf(object oPC, float fDist, float fHeight)
{
    float fDistance = -fDist;
    object oTarget = (oPC);
    object oArea = GetArea(oTarget);
    vector vPosition = GetPosition(oTarget);
    vPosition.z += fHeight;
    float fOrientation = GetFacing(oTarget);
    vector vNewPos = AngleToVector(fOrientation);
    float vZ = vPosition.z;
    float vX = vPosition.x - fDistance * vNewPos.x;
    float vY = vPosition.y - fDistance * vNewPos.y;
    fOrientation = GetFacing(oTarget);
    vX = vPosition.x - fDistance * vNewPos.x;
    vY = vPosition.y - fDistance * vNewPos.y;
    vNewPos = AngleToVector(fOrientation);
    vZ = vPosition.z;
    vNewPos = Vector(vX, vY, vZ);
    return Location(oArea, vNewPos, fOrientation);
}

//Smoking Function by Jason Robinson
void SmokePipe(object oActivator)
{
    string sEmote1 = "*puffs on a pipe*";
    string sEmote2 = "*inhales from a pipe*";
    string sEmote3 = "*pulls a mouthful of smoke from a pipe*";
    float fHeight = 1.7;
    float fDistance = 0.1;
    // Set height based on race and gender
    if (GetGender(oActivator) == GENDER_MALE)
    {
        switch (GetRacialType(oActivator))
        {
            case RACIAL_TYPE_HUMAN:
            case RACIAL_TYPE_HALFELF: fHeight = 1.7; fDistance = 0.12; break;
            case RACIAL_TYPE_ELF: fHeight = 1.55; fDistance = 0.08; break;
            case RACIAL_TYPE_GNOME:
            case RACIAL_TYPE_HALFLING: fHeight = 1.15; fDistance = 0.12; break;
            case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.12; break;
            case RACIAL_TYPE_HALFORC: fHeight = 1.9; fDistance = 0.2; break;
        }
    }
    else
    {
        // FEMALES
        switch (GetRacialType(oActivator))
        {
            case RACIAL_TYPE_HUMAN:
            case RACIAL_TYPE_HALFELF: fHeight = 1.6; fDistance = 0.12; break;
            case RACIAL_TYPE_ELF: fHeight = 1.45; fDistance = 0.12; break;
            case RACIAL_TYPE_GNOME:
            case RACIAL_TYPE_HALFLING: fHeight = 1.1; fDistance = 0.075; break;
            case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.1; break;
            case RACIAL_TYPE_HALFORC: fHeight = 1.8; fDistance = 0.13; break;
        }
    }
    location lAboveHead = GetLocationAboveAndInFrontOf(oActivator, fDistance, fHeight);
    // emotes
    switch (d3())
    {
        case 1: AssignCommand(oActivator, ActionSpeakString(sEmote1)); break;
        case 2: AssignCommand(oActivator, ActionSpeakString(sEmote2)); break;
        case 3: AssignCommand(oActivator, ActionSpeakString(sEmote3));break;
    }
    // glow red
    AssignCommand(oActivator, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oActivator, 0.15)));
    // wait a moment
    AssignCommand(oActivator, ActionWait(3.0));
    // puff of smoke above and in front of head
    AssignCommand(oActivator, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), lAboveHead)));
    // if female, turn head to left
    if ((GetGender(oActivator) == GENDER_FEMALE) && (GetRacialType(oActivator) != RACIAL_TYPE_DWARF))
        AssignCommand(oActivator, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 5.0));
}

void ParseEmote(string sEmote, object oPC)
{
    DeleteLocalInt(oPC, "dmfi_univ_int");
    object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    object oLeftHand =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    if (GetStringLeft(sEmote, 1) == "*")
    {
        int iToggle;
        string sBuffer;
        sBuffer = GetStringRight(sEmote, GetStringLength(sEmote)-1);
        while (!iToggle && GetStringLength(sBuffer) > 1)
        {
            if (GetStringLeft(sBuffer,1) == "*")
                iToggle = abs(iToggle - 1);
            sBuffer = GetStringRight(sBuffer, GetStringLength(sBuffer)-1);
        }
        sEmote = GetStringLeft(sEmote, GetStringLength(sEmote)-GetStringLength(sBuffer));
    }

    int iSit;
    object oArea;
    object oChair;

    //*emote* rolls
    if (FindSubString(sEmote, "Strength") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 71);
    else if (FindSubString(sEmote, "Dexterity") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 72);
    else if (FindSubString(sEmote, "Constitution") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 73);
    else if (FindSubString(sEmote, "Intelligence") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 74);
    else if (FindSubString(sEmote, "Wisdom") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 75);
    else if (FindSubString(sEmote, "Charisma") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 76);
    else if (FindSubString(sEmote, "Fortitude") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 77);
    else if (FindSubString(sEmote, "Reflex") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 78);
    else if (FindSubString(sEmote, "Will") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 79);
    else if (FindSubString(sEmote, "Animal Empathy") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 81);
    else if (FindSubString(sEmote, "Concentration") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 82);
    else if (FindSubString(sEmote, "Disable Trap") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 83);
    else if (FindSubString(sEmote, "Discipline") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 84);
    else if (FindSubString(sEmote, "Heal") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 85);
    else if (FindSubString(sEmote, "Hide") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 86);
    else if (FindSubString(sEmote, "Listen") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 87);
    else if (FindSubString(sEmote, "Lore") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 88);
    else if (FindSubString(sEmote, "Move Silently") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 89);
    else if (FindSubString(sEmote, "Open Lock") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 80);
    else if (FindSubString(sEmote, "Parry") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 91);
    else if (FindSubString(sEmote, "Perform") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 92);
    else if (FindSubString(sEmote, "Persuade") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 93);
    else if (FindSubString(sEmote, "Pickpocket") != -1 ||
             FindSubString(sEmote, "Pick Pocket") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 94);
    else if (FindSubString(sEmote, "Search") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 95);
    else if (FindSubString(sEmote, "Set Trap") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 96);
    else if (FindSubString(sEmote, "Spellcraft") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 97);
    else if (FindSubString(sEmote, "Spot") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 98);
    else if (FindSubString(sEmote, "Taunt") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 99);
    else if (FindSubString(sEmote, "Use Magic Device") != -1)
        SetLocalInt(oPC, "dmfi_univ_int", 90);

    if (GetLocalInt(oPC, "dmfi_univ_int"))
    {
        SetLocalString(oPC, "dmfi_univ_conv", "pc_dicebag");
        ExecuteScript("dmfi_execute", oPC);
        return;
    }

    //*emote*
    if (FindSubString(GetStringLowerCase(sEmote), "*bow") != -1 ||
        FindSubString(GetStringLowerCase(sEmote), " bow") != -1 ||
        FindSubString(GetStringLowerCase(sEmote), "curtsey") != -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "drink") != -1 ||
             FindSubString(GetStringLowerCase(sEmote), "sips") != -1)
            AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "drinks") != -1 &&
             FindSubString(GetStringLowerCase(sEmote), "sits") != -1)
             {
                AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0f));
                DelayCommand(1.0f, AssignCommand(oPC, PlayAnimation( ANIMATION_FIREFORGET_DRINK, 1.0)));
                DelayCommand(3.0f, AssignCommand(oPC, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0)));
             }
    else if (FindSubString(GetStringLowerCase(sEmote), "reads") != -1 &&
             FindSubString(GetStringLowerCase(sEmote), "sits") != -1)
             {
                AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0f));
                DelayCommand(1.0f, AssignCommand(oPC, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0)));
                DelayCommand(3.0f, AssignCommand(oPC, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0)));
             }
    else if (FindSubString(GetStringLowerCase(sEmote), "greet")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "wave") != -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "yawn")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "stretch") != -1 ||
             FindSubString(GetStringLowerCase(sEmote), "bored") != -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "scratch")!= -1)
    {
        AssignCommand(oPC,ActionUnequipItem(oRightHand));
        AssignCommand(oPC,ActionUnequipItem(oLeftHand));
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "*reads")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), " reads")!= -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "salute")!= -1)
    {
        AssignCommand(oPC,ActionUnequipItem(oRightHand));
        AssignCommand(oPC,ActionUnequipItem(oLeftHand));
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "steal")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "swipe") != -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "taunt")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "mock") != -1)
    {
        PlayVoiceChat(VOICE_CHAT_TAUNT, oPC);
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "smokes") != -1)
    {
        SmokePipe(oPC);
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "cheer")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_CHEER, oPC);
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "hooray")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_CHEER, oPC);
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "celebrate")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_CHEER, oPC);
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "giggle")!= -1 && GetGender(oPC) == GENDER_FEMALE)
        AssignCommand(oPC, PlaySound("vs_fshaldrf_haha"));
    else if (FindSubString(GetStringLowerCase(sEmote), "flop")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "prone")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "bends")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "stoop")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "fiddle")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 5.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "nod")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "agree")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 4.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "peers")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "scans")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "search")!= -1)
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "*pray")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), " pray")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "meditate")!= -1)
    {
        AssignCommand(oPC,ActionUnequipItem(oRightHand));
        AssignCommand(oPC,ActionUnequipItem(oLeftHand));
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 99999.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "drunk")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "woozy")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "tired")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "fatigue")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "exhausted")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_REST, oPC);
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 3.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "fidget")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "shifts")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "sits")!= -1 &&
             (FindSubString(GetStringLowerCase(sEmote), "floor")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "ground")!= -1))
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "demand")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "threaten")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "laugh")!= -1 ||
            FindSubString(GetStringLowerCase(sEmote), "chuckle")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_LAUGH, oPC);
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "begs")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "plead")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "worship")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "snore")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "*nap")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), " nap")!= -1)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPC);
    else if (FindSubString(GetStringLowerCase(sEmote), "*sings")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), " sings")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "hums")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "whistles")!= -1)
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), oPC, 6.0f);
    else if (FindSubString(GetStringLowerCase(sEmote), "talks")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "chats")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "shakes head")!= -1)
    {
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 0.25f));
        DelayCommand(0.15f, AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 1.0, 0.25f)));
        DelayCommand(0.40f, AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 0.25f)));
        DelayCommand(0.65f, AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 1.0, 0.25f)));
    }
}

string ConvertLeetspeak(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (GetStringLowerCase(sLetter) == "a") sTranslate = "4";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "8";
    if (GetStringLowerCase(sLetter) == "c") sTranslate = "(";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "|)";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "3";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "F";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "9";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "H";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "!";
    if (GetStringLowerCase(sLetter) == "j") sTranslate = "J";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "|<";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "1";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "/\/\";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "|\|";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "0";
    if (GetStringLowerCase(sLetter) == "p") sTranslate = "p";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "Q";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "R";
    if (GetStringLowerCase(sLetter) == "s") sTranslate = "5";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "7";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "U";
    if (GetStringLowerCase(sLetter) == "v") sTranslate = "\/";
    if (GetStringLowerCase(sLetter) == "w") sTranslate = "\/\/";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "X";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "Y";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "2";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}//end ConvertLeetspeak

string ProcessLeetspeak(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertLeetspeak(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertInfernal(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (GetStringLowerCase(sLetter) == "a") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "c";
    if (GetStringLowerCase(sLetter) == "c") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "j";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "a";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "v";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "y";
    if (GetStringLowerCase(sLetter) == "j") sTranslate = "z";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "m";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "z";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "y";
    if (GetStringLowerCase(sLetter) == "p") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "s") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "d";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "'";
    if (GetStringLowerCase(sLetter) == "v") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "w") sTranslate = "'";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "i";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "g";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}//end ConvertInfernal

string ProcessInfernal(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertInfernal(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertAbyssal(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (sLetter == "a") sTranslate =  "oo";
    if (sLetter == "A") sTranslate =  "OO";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "c") sTranslate = "m";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "a";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "s";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "d";
    if (sLetter == "i") sTranslate =  "oo";
    if (sLetter == "I") sTranslate =  "OO";
    if (GetStringLowerCase(sLetter) == "j") sTranslate = "h";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "b";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "l";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "p";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "t";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "e";
    if (GetStringLowerCase(sLetter) == "p") sTranslate = "b";
    if (sLetter == "q") sTranslate =  "ch";
    if (sLetter == "Q") sTranslate =  "Ch";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "s") sTranslate = "m";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "g";
    if (sLetter == "u") sTranslate =  "ae";
    if (sLetter == "U") sTranslate =  "Ae";
    if (sLetter == "v") sTranslate =  "ts";
    if (sLetter == "V") sTranslate =  "Ts";
    if (GetStringLowerCase(sLetter) == "w") sTranslate = "b";
    if (sLetter == "x") sTranslate =  "bb";
    if (sLetter == "X") sTranslate =  "Bb";
    if (sLetter == "y") sTranslate =  "ee";
    if (sLetter == "Y") sTranslate =  "Ee";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "t";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}//end ConvertAbyssal

string ProcessAbyssal(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertAbyssal(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertCelestial(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (GetStringLowerCase(sLetter) == "a") sTranslate = "a";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "p";
    if (GetStringLowerCase(sLetter) == "c") sTranslate = "v";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "t";
    if (sLetter == "e") sTranslate =  "el";
    if (sLetter == "E") sTranslate =  "El";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "b";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "w";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "i";
    if (GetStringLowerCase(sLetter) == "j") sTranslate = "m";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "x";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "h";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "s";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "c";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "u";
    if (GetStringLowerCase(sLetter) == "p") sTranslate = "q";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "d";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "s") sTranslate = "l";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "y";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "v") sTranslate = "j";
    if (GetStringLowerCase(sLetter) == "w") sTranslate = "f";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "z";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "k";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}//end ConvertCelestial

string ProcessCelestial(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertCelestial(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertGoblin(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (GetStringLowerCase(sLetter) == "a") sTranslate = "u";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "p";
    if (GetStringLowerCase(sLetter) == "c") sTranslate = "";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "t";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "'";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "v";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "j") sTranslate = "z";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "m";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "s";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "u";
    if (GetStringLowerCase(sLetter) == "p") sTranslate = "b";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "s") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "d";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "u";
    if (GetStringLowerCase(sLetter) == "v") sTranslate = "";
    if (GetStringLowerCase(sLetter) == "w") sTranslate = "'";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "w";

    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);

    return sTranslate;
}//end ConvertGoblin

string ProcessGoblin(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertGoblin(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDraconic(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (GetStringLowerCase(sLetter) == "a") sTranslate = "e";
    if (sLetter == "A") sTranslate = "E";
    if (sLetter == "b") return "po";
    if (sLetter == "B") return "Po";
    if (sLetter == "c") return "st";
    if (sLetter == "C") return "St";
    if (sLetter == "d") return "ty";
    if (sLetter == "D") return "Ty";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "i";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "w";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "k";
    if (sLetter == "h") return "ni";
    if (sLetter == "H") return "Ni";
    if (sLetter == "i") return "un";
    if (sLetter == "I") return "Un";
    if (sLetter == "j") return "vi";
    if (sLetter == "J") return "Vi";
    if (sLetter == "k") return "go";
    if (sLetter == "K") return "Go";
    if (sLetter == "l") return "ch";
    if (sLetter == "L") return "Ch";
    if (sLetter == "m") return "li";
    if (sLetter == "M") return "Li";
    if (sLetter == "n") return "ra";
    if (sLetter == "N") return "Ra";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "y";
    if (sLetter == "p") return "ba";
    if (sLetter == "P") return "Ba";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "x";
    if (sLetter == "r") return "hu";
    if (sLetter == "R") return "Hu";
    if (sLetter == "s") return "my";
    if (sLetter == "S") return "My";
    if (sLetter == "t") return "dr";
    if (sLetter == "T") return "Dr";
    if (sLetter == "u") return "on";
    if (sLetter == "U") return "On";
    if (sLetter == "v") return "fi";
    if (sLetter == "V") return "Fi";
    if (sLetter == "w") return "zi";
    if (sLetter == "W") return "Zi";
    if (sLetter == "x") return "qu";
    if (sLetter == "X") return "Qu";
    if (sLetter == "y") return "an";
    if (sLetter == "Y") return "An";
    if (sLetter == "z") return "ji";
    if (sLetter == "Z") return "Ji";

    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);

    return sTranslate;
}//end ConvertDraconic

string ProcessDraconic(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertDraconic(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertDwarf(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (sLetter == "a") return "az";
    if (sLetter == "A") return "Az";
    if (sLetter == "b") return "po";
    if (sLetter == "B") return "Po";
    if (sLetter == "c") return "zi";
    if (sLetter == "C") return "Zi";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "t";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "a";
    if (sLetter == "f") return "wa";
    if (sLetter == "F") return "Wa";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "'";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "a";
    if (sLetter == "j") return "dr";
    if (sLetter == "J") return "Dr";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "l";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "r";
    if (sLetter == "o") return "ur";
    if (sLetter == "O") return "Ur";
    if (sLetter == "p") return "rh";
    if (sLetter == "P") return "Rh";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "h";
    if (sLetter == "s") return "th";
    if (sLetter == "S") return "Th";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "'";
    if (GetStringLowerCase(sLetter) == "v") sTranslate = "g";
    if (sLetter == "w") return "zh";
    if (sLetter == "W") return "Zh";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "q";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "j";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}//end ConvertDwarf

string ProcessDwarf(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertDwarf(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertElven(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (sLetter == "a") return "il";
    if (sLetter == "A") return "Il";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "f";
    if (sLetter == "c") return "ny";
    if (sLetter == "C") return "Ny";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "w";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "a";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "v";
    if (sLetter == "h") return "ir";
    if (sLetter == "H") return "Ir";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "e";
    if (sLetter == "j") return "qu";
    if (sLetter == "J") return "Qu";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "c";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "s";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "l";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "e";
    if (sLetter == "p") return "ty";
    if (sLetter == "P") return "Ty";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "h";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "m";
    if (sLetter == "s") return "la";
    if (sLetter == "S") return "La";
    if (sLetter == "t") return "an";
    if (sLetter == "T") return "An";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "y";
    if (sLetter == "v") return "el";
    if (sLetter == "V") return "El";
    if (sLetter == "w") return "am";
    if (sLetter == "W") return "Am";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "'";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "a";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "j";

    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);

    return sTranslate;
}

string ProcessElven(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertElven(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertGnome(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
//cipher based on English -> Al Baed
    if (GetStringLowerCase(sLetter) == "a") sTranslate = "y";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "p";
    if (GetStringLowerCase(sLetter) == "c") sTranslate = "l";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "t";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "a";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "v";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "e";
    if (GetStringLowerCase(sLetter) == "j") sTranslate = "z";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "m";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "s";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "h";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "u";
    if (GetStringLowerCase(sLetter) == "p") sTranslate = "b";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "x";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "s") sTranslate = "c";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "d";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "i";
    if (GetStringLowerCase(sLetter) == "v") sTranslate = "j";
    if (GetStringLowerCase(sLetter) == "w") sTranslate = "f";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "q";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "w";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}

string ProcessGnome(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertGnome(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertHalfling(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
//cipher based on Al Baed -> English
    if (GetStringLowerCase(sLetter) == "a") sTranslate = "e";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "p";
    if (GetStringLowerCase(sLetter) == "c") sTranslate = "s";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "t";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "i";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "w";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "u";
    if (GetStringLowerCase(sLetter) == "j") sTranslate = "v";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "c";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "l";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "y";
    if (GetStringLowerCase(sLetter) == "p") sTranslate = "b";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "x";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "h";
    if (GetStringLowerCase(sLetter) == "s") sTranslate = "m";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "d";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "v") sTranslate = "f";
    if (GetStringLowerCase(sLetter) == "w") sTranslate = "z";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "q";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "a";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "j";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}

string ProcessHalfling(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertHalfling(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertOrc(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (sLetter == "a") sTranslate = "ha";
    if (sLetter == "A") sTranslate = "Ha";
    if (GetStringLowerCase(sLetter) == "b") sTranslate = "p";
    if (GetStringLowerCase(sLetter) == "c") sTranslate = "z";
    if (GetStringLowerCase(sLetter) == "d") sTranslate = "t";
    if (GetStringLowerCase(sLetter) == "e") sTranslate = "o";
    if (GetStringLowerCase(sLetter) == "f") sTranslate = "";
    if (GetStringLowerCase(sLetter) == "g") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "h") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "i") sTranslate = "a";
    if (GetStringLowerCase(sLetter) == "j") sTranslate = "m";
    if (GetStringLowerCase(sLetter) == "k") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "l") sTranslate = "h";
    if (GetStringLowerCase(sLetter) == "m") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "n") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "o") sTranslate = "u";
    if (GetStringLowerCase(sLetter) == "p") sTranslate = "b";
    if (GetStringLowerCase(sLetter) == "q") sTranslate = "k";
    if (GetStringLowerCase(sLetter) == "r") sTranslate = "h";
    if (GetStringLowerCase(sLetter) == "s") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "t") sTranslate = "n";
    if (GetStringLowerCase(sLetter) == "u") sTranslate = "";
    if (GetStringLowerCase(sLetter) == "v") sTranslate = "g";
    if (GetStringLowerCase(sLetter) == "w") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "x") sTranslate = "r";
    if (GetStringLowerCase(sLetter) == "y") sTranslate = "'";
    if (GetStringLowerCase(sLetter) == "z") sTranslate = "m";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}

string ProcessOrc(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertOrc(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertAnimal(string sLetter)
{
    string sTranslate = sLetter;
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    if (GetStringLowerCase(sLetter) == "a") return "'";
    if (GetStringLowerCase(sLetter) == "b") return "'";
    if (GetStringLowerCase(sLetter) == "c") return "'";
    if (GetStringLowerCase(sLetter) == "d") return "'";
    if (GetStringLowerCase(sLetter) == "e") return "'";
    if (GetStringLowerCase(sLetter) == "f") return "'";
    if (GetStringLowerCase(sLetter) == "g") return "'";
    if (GetStringLowerCase(sLetter) == "h") return "'";
    if (GetStringLowerCase(sLetter) == "i") return "'";
    if (GetStringLowerCase(sLetter) == "j") return "'";
    if (GetStringLowerCase(sLetter) == "k") return "'";
    if (GetStringLowerCase(sLetter) == "l") return "'";
    if (GetStringLowerCase(sLetter) == "m") return "'";
    if (GetStringLowerCase(sLetter) == "n") return "'";
    if (GetStringLowerCase(sLetter) == "o") return "'";
    if (GetStringLowerCase(sLetter) == "p") return "'";
    if (GetStringLowerCase(sLetter) == "q") return "'";
    if (GetStringLowerCase(sLetter) == "r") return "'";
    if (GetStringLowerCase(sLetter) == "s") return "'";
    if (GetStringLowerCase(sLetter) == "t") return "'";
    if (GetStringLowerCase(sLetter) == "u") return "'";
    if (GetStringLowerCase(sLetter) == "v") return "'";
    if (GetStringLowerCase(sLetter) == "w") return "'";
    if (GetStringLowerCase(sLetter) == "x") return "'";
    if (GetStringLowerCase(sLetter) == "y") return "'";
    if (GetStringLowerCase(sLetter) == "z") return "'";
    if (GetStringLength(sTranslate) == 1 && GetStringUpperCase(sLetter) == sLetter)
        sTranslate = GetStringUpperCase(sTranslate);
    return sTranslate;
}

string ProcessAnimal(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) > 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertAnimal(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ProcessCant(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);

    if (sLetter == "a" || sLetter == "A") return "*shields eyes*";
    if (sLetter == "b" || sLetter == "B") return "*blusters*";
    if (sLetter == "c" || sLetter == "C") return "*coughs*";
    if (sLetter == "d" || sLetter == "D") return "*furrows brow*";
    if (sLetter == "e" || sLetter == "E") return "*examines ground*";
    if (sLetter == "f" || sLetter == "F") return "*frowns*";
    if (sLetter == "g" || sLetter == "G") return "*glances up*";
    if (sLetter == "h" || sLetter == "H") return "*looks thoughtful*";
    if (sLetter == "i" || sLetter == "I") return "*looks bored*";
    if (sLetter == "j" || sLetter == "J") return "*rubs chin*";
    if (sLetter == "k" || sLetter == "K") return "*scratches ear*";
    if (sLetter == "l" || sLetter == "L") return "*looks around*";
    if (sLetter == "m" || sLetter == "M") return "*mmm hmm*";
    if (sLetter == "n" || sLetter == "N") return "*nods*";
    if (sLetter == "o" || sLetter == "O") return "*grins*";
    if (sLetter == "p" || sLetter == "P") return "*smiles*";
    if (sLetter == "q" || sLetter == "Q") return "*shivers*";
    if (sLetter == "r" || sLetter == "R") return "*rolls eyes*";
    if (sLetter == "s" || sLetter == "S") return "*scratches nose*";
    if (sLetter == "t" || sLetter == "T") return "*turns a bit*";
    if (sLetter == "u" || sLetter == "U") return "*glances idly*";
    if (sLetter == "v" || sLetter == "V") return "*runs hand through hair*";
    if (sLetter == "w" || sLetter == "W") return "*waves*";
    if (sLetter == "x" || sLetter == "X") return "*stretches*";
    if (sLetter == "y" || sLetter == "Y") return "*yawns*";
    if (sLetter == "z" || sLetter == "Z") return "*shrugs*";

    return "*nods*";
}

string TranslateCommonToLanguage(int iLang, string sText)
{
    switch(iLang)
    {
        case 1: //Elven
        return ProcessElven(sText); break;
        case 2: //Gnome
        return ProcessGnome(sText); break;
        case 3: //Halfling
        return ProcessHalfling(sText); break;
        case 4: //Dwarf Note: Race 4 is normally Half Elf and Race 0 is normally Dwarf. This is changed.
        return ProcessDwarf(sText); break;
        case 5: //Orc
        return ProcessOrc(sText); break;
        case 6: //Goblin
        return ProcessGoblin(sText); break;
        case 7: //Draconic
        return ProcessDraconic(sText); break;
        case 8: //Animal
        return ProcessAnimal(sText); break;
        case 9: //Thieves Cant
        return ProcessCant(sText); break;
        case 10: //Celestial
        return ProcessCelestial(sText); break;
        case 11: //Abyssal
        return ProcessAbyssal(sText); break;
        case 12: //Infernal
        return ProcessInfernal(sText); break;
        case 99: //1337
        return ProcessLeetspeak(sText); break;
        default: break;
    }
    return "";
}

int GetDefaultRacialLanguage(object oPC, int iRename)
{
    switch(GetRacialType(oPC))
    {
        case RACIAL_TYPE_DWARF: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Dwarven"); return 4; break;
        case RACIAL_TYPE_ELF:
        case RACIAL_TYPE_HALFELF: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Elven"); return 1; break;
        case RACIAL_TYPE_GNOME: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Gnome"); return 2; break;
        case RACIAL_TYPE_HALFLING: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Halfling"); return 3; break;
        case RACIAL_TYPE_HUMANOID_ORC:
        case RACIAL_TYPE_HALFORC: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Orc"); return 5; break;
        case RACIAL_TYPE_HUMANOID_GOBLINOID: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Goblin"); return 6; break;
        case RACIAL_TYPE_HUMANOID_REPTILIAN:
        case RACIAL_TYPE_DRAGON: if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Draconic"); return 7; break;
        default: if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) || GetLevelByClass(CLASS_TYPE_DRUID, oPC))
                 {
                    if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Animal");
                    return 8;
                 }
                 if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC))
                 {
                    if (iRename) SetLocalString(oPC, "hls_MyLanguageName", "Thieves' Cant");
                    return 9;
                 }
                 break;
    }
    return 0;
}

int GetDefaultClassLanguage(object oPC)
{
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) || GetLevelByClass(CLASS_TYPE_DRUID, oPC))
        return 8;
    if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC))
        return 9;
    return 0;
}

int GetIsAlphanumeric(string sCharacter)
{
    if (GetStringLowerCase(sCharacter) == "a" ||
        GetStringLowerCase(sCharacter) == "b" ||
        GetStringLowerCase(sCharacter) == "c" ||
        GetStringLowerCase(sCharacter) == "d" ||
        GetStringLowerCase(sCharacter) == "e" ||
        GetStringLowerCase(sCharacter) == "f" ||
        GetStringLowerCase(sCharacter) == "g" ||
        GetStringLowerCase(sCharacter) == "h" ||
        GetStringLowerCase(sCharacter) == "i" ||
        GetStringLowerCase(sCharacter) == "j" ||
        GetStringLowerCase(sCharacter) == "k" ||
        GetStringLowerCase(sCharacter) == "l" ||
        GetStringLowerCase(sCharacter) == "m" ||
        GetStringLowerCase(sCharacter) == "n" ||
        GetStringLowerCase(sCharacter) == "o" ||
        GetStringLowerCase(sCharacter) == "p" ||
        GetStringLowerCase(sCharacter) == "q" ||
        GetStringLowerCase(sCharacter) == "r" ||
        GetStringLowerCase(sCharacter) == "s" ||
        GetStringLowerCase(sCharacter) == "t" ||
        GetStringLowerCase(sCharacter) == "u" ||
        GetStringLowerCase(sCharacter) == "v" ||
        GetStringLowerCase(sCharacter) == "w" ||
        GetStringLowerCase(sCharacter) == "x" ||
        GetStringLowerCase(sCharacter) == "y" ||
        GetStringLowerCase(sCharacter) == "z" ||
        sCharacter == "1" ||
        sCharacter == "2" ||
        sCharacter == "3" ||
        sCharacter == "4" ||
        sCharacter == "5" ||
        sCharacter == "6" ||
        sCharacter == "7" ||
        sCharacter == "8" ||
        sCharacter == "9" ||
        sCharacter == "0")
        return TRUE;

    return FALSE;
}

void ParseCommand(object oNPC, object oPC, string sCom)
{
    if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".set")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        while (sCom != "")
        {
            if (GetStringLeft(sCom, 1) == " " ||
                GetStringLeft(sCom, 1) == "[" ||
                GetStringLeft(sCom, 1) == "." ||
                GetStringLeft(sCom, 1) == ":" ||
                GetStringLeft(sCom, 1) == ";" ||
                GetStringLeft(sCom, 1) == "*" ||
                GetIsAlphanumeric(GetStringLeft(sCom, 1)))
                sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            else
            {
                SetLocalObject(GetModule(), "hls_NPCControl" + GetStringLeft(sCom, 1), oNPC);
                FloatingTextStringOnCreature("The Control character for " + GetName(oNPC) + " is " + GetStringLeft(sCom, 1), oPC, FALSE);
                return;
            }
        }
        FloatingTextStringOnCreature("Your Control Character is not valid. Perhaps you are using a reserved character.", oPC, FALSE);
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".buf")
    {
        if (FindSubString(GetStringLowerCase(sCom), "barkskin") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(3, AC_NATURAL_BONUS), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_BARKSKIN), oNPC, 3600.0f);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "elements") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_COLD, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_FIRE, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_ACID, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_SONIC, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS), oNPC, 3600.0f);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "haste") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHaste(), oNPC, 3600.0f);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "invis") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oNPC, 3600.0f);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "unplot") != -1)
        {
            SetPlotFlag(oNPC, FALSE);
            FloatingTextStringOnCreature("The target is set to non-Plot.", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "plot") != -1)
        {
            SetPlotFlag(oNPC, TRUE);
            FloatingTextStringOnCreature("The target is set to Plot.", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "stoneskin") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageReduction(10, DAMAGE_POWER_PLUS_THREE, 100), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN), oNPC, 3600.0f);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "trues") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTrueSeeing(), oNPC, 3600.0f);
        }
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".dam")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            int iCom = StringToInt(sCom);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iCom, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oNPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_LRG_RED), oNPC);
            FloatingTextStringOnCreature(GetName(oNPC) + " has taken " + sCom + " damage.", oPC, FALSE);
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".dis")
    {
        DestroyObject(oNPC);
        FloatingTextStringOnCreature(GetName(oNPC) + " dismissed", oPC, FALSE);
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".dmtoollock")
    {
        SetLocalInt(GetModule(), "dmfi_DMToolLock", abs(GetLocalInt(GetModule(), "dmfi_DMToolLock") -1));
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fac")
    {
        if (FindSubString(GetStringLowerCase(sCom), "hostile") != -1)
        {
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
            FloatingTextStringOnCreature("Faction set to hostile", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "commoner") != -1)
        {
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_COMMONER);
            FloatingTextStringOnCreature("Faction set to commoner", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "defender") != -1)
        {
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_DEFENDER);
            FloatingTextStringOnCreature("Faction set to defender", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "merchant") != -1)
        {
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_MERCHANT);
            FloatingTextStringOnCreature("Faction set to merchant", oPC, FALSE);
        }
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fle")
    {
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, ActionMoveAwayFromObject(oPC, TRUE));
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fly")
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappear(), oNPC);
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fol")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            int iCom = StringToInt(sCom);
            FloatingTextStringOnCreature(GetName(oNPC) + " will follow you for "+sCom+" seconds.", oPC, FALSE);
            AssignCommand(oNPC, ClearAllActions(TRUE));
            AssignCommand(oNPC, ActionForceMoveToObject(oPC, TRUE, 2.0f, IntToFloat(iCom)));
            DelayCommand(IntToFloat(iCom), FloatingTextStringOnCreature(GetName(oNPC) + " has stopped following you.", oPC, FALSE));
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fre")
    {
        FloatingTextStringOnCreature(GetName(oNPC) + " frozen", oPC, FALSE);
        SetCommandable(TRUE, oNPC);
        AssignCommand(oNPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, SetCommandable(FALSE, oNPC));
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".get")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        while (sCom != "")
        {
            if (GetStringLeft(sCom, 1) == " " ||
                GetStringLeft(sCom, 1) == "[" ||
                GetStringLeft(sCom, 1) == "." ||
                GetStringLeft(sCom, 1) == ":" ||
                GetStringLeft(sCom, 1) == ";" ||
                GetStringLeft(sCom, 1) == "*" ||
                GetIsAlphanumeric(GetStringLeft(sCom, 1)))
                sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            else
            {
                AssignCommand(oNPC, ClearAllActions());
                AssignCommand(oNPC, ActionJumpToLocation(GetLocation(oPC)));
                return;
            }
        }
        FloatingTextStringOnCreature("Your Control Character is not valid. Perhaps you are using a reserved character.", oPC, FALSE);
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".got")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        while (sCom != "")
        {
            if (GetStringLeft(sCom, 1) == " " ||
                GetStringLeft(sCom, 1) == "[" ||
                GetStringLeft(sCom, 1) == "." ||
                GetStringLeft(sCom, 1) == ":" ||
                GetStringLeft(sCom, 1) == ";" ||
                GetStringLeft(sCom, 1) == "*" ||
                GetIsAlphanumeric(GetStringLeft(sCom, 1)))
                sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            else
            {
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oPC, ActionJumpToLocation(GetLocation(oNPC)));
                return;
            }
        }
        FloatingTextStringOnCreature("Your Control Character is not valid. Perhaps you are using a reserved character.", oPC, FALSE);
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".hea")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            int iCom = StringToInt(sCom);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(iCom), oNPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_M), oNPC);
            FloatingTextStringOnCreature(GetName(oNPC) + " has healed " + sCom + " hp.", oPC, FALSE);
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".ite")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            CreateItemOnObject(sCom, oNPC, 1);
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".lan") //sets the language of the target
    {
        if (FindSubString(GetStringLowerCase(sCom), "elven") != -1 ||
            FindSubString(GetStringLowerCase(sCom), "elf") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 1);
            SetLocalString(oNPC, "hls_MyLanguageName", "Elven");
            FloatingTextStringOnCreature("Language set to Elven", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "gnom") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 2);
            SetLocalString(oNPC, "hls_MyLanguageName", "Gnome");
            FloatingTextStringOnCreature("Language set to Gnome", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "halfling") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 3);
            SetLocalString(oNPC, "hls_MyLanguageName", "Halfling");
            FloatingTextStringOnCreature("Language set to Halfling", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "dwar") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 4);
            SetLocalString(oNPC, "hls_MyLanguageName", "Dwarven");
            FloatingTextStringOnCreature("Language set to Dwarven", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "orc") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 5);
            SetLocalString(oNPC, "hls_MyLanguageName", "Orc");
            FloatingTextStringOnCreature("Language set to Orc", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "goblin") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 6);
            SetLocalString(oNPC, "hls_MyLanguageName", "Goblin");
            FloatingTextStringOnCreature("Language set to Goblin", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "draconic") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 7);
            SetLocalString(oNPC, "hls_MyLanguageName", "Draconic");
            FloatingTextStringOnCreature("Language set to Draconic", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "animal") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 8);
            SetLocalString(oNPC, "hls_MyLanguageName", "Animal");
            FloatingTextStringOnCreature("Language set to Animal", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "cant") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 9);
            SetLocalString(oNPC, "hls_MyLanguageName", "Thieves' Cant");
            FloatingTextStringOnCreature("Language set to Thieves' Cant", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "celestial") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 10);
            SetLocalString(oNPC, "hls_MyLanguageName", "Celestial");
            FloatingTextStringOnCreature("Language set to Celestial", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "abyssal") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 11);
            SetLocalString(oNPC, "hls_MyLanguageName", "Abyssal");
            FloatingTextStringOnCreature("Language set to Abyssal", oPC, FALSE);
        }
        else if (FindSubString(GetStringLowerCase(sCom), "infernal") != -1)
        {
            SetLocalInt(oNPC, "hls_MyLanguage", 12);
            SetLocalString(oNPC, "hls_MyLanguageName", "Infernal");
            FloatingTextStringOnCreature("Language set to Infernal", oPC, FALSE);
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".mut")
    {
        FloatingTextStringOnCreature(GetName(oNPC) + " muted", oPC, FALSE);
        SetLocalInt(oNPC, "dmfi_Mute", 1);
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".npc")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            CreateObject(OBJECT_TYPE_CREATURE, sCom, GetLocation(oNPC));
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".pla")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            CreateObject(OBJECT_TYPE_PLACEABLE, sCom, GetLocation(oNPC));
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".rem")
    {
        effect eRemove = GetFirstEffect(oNPC);
        while (GetIsEffectValid(eRemove))
        {
            RemoveEffect(oNPC, eRemove);
            eRemove = GetNextEffect(oNPC);
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".say")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 5);
        int iCom = StringToInt(sCom);
        if (GetLocalString(GetModule(), "hls206" + IntToString(iCom)) != "")
        {
            AssignCommand(oNPC, SpeakString(GetLocalString(GetModule(), "hls206" + IntToString(iCom))));
        }
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".unf")
    {
        FloatingTextStringOnCreature(GetName(oNPC) + " unfrozen", oPC, FALSE);
        SetCommandable(TRUE, oNPC);
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".unm")
    {
        FloatingTextStringOnCreature(GetName(oNPC) + " un-muted", oPC, FALSE);
        DeleteLocalInt(oNPC, "dmfi_Mute");
    }
}

void TranslateToLanguage(string sSaid, object oShouter)
{
    //Gets the current language that the character is speaking
    int iTranslate;
    if (GetLocalInt(oShouter, "hls_MyLanguage"))
        iTranslate = GetLocalInt(oShouter, "hls_MyLanguage");
    else
        iTranslate = GetDefaultRacialLanguage(oShouter, 1);
    if (!iTranslate) return;
    //Defines language name
    string sLanguageName = GetLocalString(oShouter, "hls_MyLanguageName");

    sSaid = GetStringRight(sSaid, GetStringLength(sSaid)-1);
    //Thieves' Cant character limit of 25
    if (iTranslate == 9 && GetStringLength(sSaid) > 25)
        sSaid = GetStringLeft(sSaid, 25);
    string sSpeak = TranslateCommonToLanguage(iTranslate, sSaid);
    if (GetStringRight(sSaid, 1) == "]")
        sSaid = GetStringLeft(sSaid, GetStringLength(sSaid)-1);
    AssignCommand(oShouter, SpeakString(sSpeak));
    //This is the complicated language widget
    object oEavesdrop = GetFirstPC();
    while (GetIsObjectValid(oEavesdrop))
    {
        if (GetArea(oEavesdrop) == GetArea(oShouter))
        {
            if (GetDistanceBetween(oEavesdrop, oShouter) < 20.0f)
            {
                //Translate and Send or do Lore check
                if (GetIsObjectValid(GetItemPossessedBy(oEavesdrop, "hlslang_" + IntToString(iTranslate))) ||
                    GetIsObjectValid(GetItemPossessedBy(oEavesdrop, "babelfish")) ||
                    iTranslate == GetDefaultRacialLanguage(oEavesdrop, 0) ||
                    iTranslate == GetDefaultClassLanguage(oEavesdrop))
                        SendMessageToPC(oEavesdrop, GetName(oShouter) + " says in " + sLanguageName + ": " + sSaid);
                else
                {
                    if (d20() + GetSkillRank(SKILL_LORE, oEavesdrop) > 20 && iTranslate != 9)
                        SendMessageToPC(oEavesdrop, GetName(oShouter) + " is speaking in " + sLanguageName);
                }
            }
        }
        oEavesdrop = GetNextPC();
    }
    PrintString("<Conv>"+GetName(GetArea(oShouter))+ " " + GetName(oShouter) + " says in " + sLanguageName + ": " + sSaid + " </Conv>");
}


void main()
{
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    if (GetIsDM(oShouter))
        SetLocalInt(GetModule(), "dmfi_Admin" + GetPCPublicCDKey(oShouter), 1);
    object oIntruder;
    object oTarget = GetLocalObject(oShouter, "dmfi_VoiceTarget");
    object oMaster = OBJECT_INVALID;
    if (GetIsObjectValid(oTarget))
        oMaster = oShouter;
    int iPhrase = GetLocalInt(oShouter, "hls_EditPhrase");

    if (nMatch == 20600 && GetIsObjectValid(oShouter) && GetIsPC(oShouter))
    {
        string sSaid = GetMatchedSubstring(0);
        if (sSaid == GetLocalString(GetModule(), "hls_voicebuffer"))
            return; //(this prevents duplicate phrases from going into the log)
        else
            SetLocalString(GetModule(), "hls_voicebuffer", sSaid);

        if (GetTag(OBJECT_SELF) == "dmfi_setting" && GetLocalString(oShouter, "EffectSetting") != "")
        {
            string sPhrase = GetLocalString(oShouter, "EffectSetting");
            SetLocalFloat(oShouter, sPhrase, StringToFloat(sSaid));
            DeleteLocalString(oShouter, "EffectSetting");
            DelayCommand(0.5, ActionSpeakString("The setting " + sPhrase + " has been changed to " + FloatToString(GetLocalFloat(oShouter, sPhrase))));
            DelayCommand(1.5, DestroyObject(OBJECT_SELF));
        }
        if (iPhrase)
        {
            SetLocalString(GetModule(), "hls" + IntToString(iPhrase), sSaid);
            DeleteLocalInt(oShouter, "hls_EditPhrase");
            FloatingTextStringOnCreature("Phrase " + IntToString(iPhrase) + " has been recorded", oShouter, FALSE);
            return;
        }
        else if (GetStringLeft(sSaid, 1) == "[")
        {
            TranslateToLanguage(sSaid, oShouter);
            return;
        }
        else if (GetStringLeft(sSaid, 1) == "*" && !GetLocalInt(oShouter, "hls_emotemute"))
        {
            ParseEmote(sSaid, oShouter);
            return;
        }
        else if (GetStringLeft(sSaid, 1) == ":")
        {
            //This "throws" your voice to an object and properly dumps it into the log
            if (GetIsObjectValid(oTarget))
            {
                sSaid = GetStringRight(sSaid, GetStringLength(sSaid)-1);
                if (GetStringLeft(sSaid, 1) == "[")
                    TranslateToLanguage(sSaid, oTarget);
                else if (GetStringLeft(sSaid, 1) == "*")
                    ParseEmote(sSaid, oTarget);
                else
                {
                    AssignCommand(oTarget, SpeakString(sSaid));
                    PrintString("<Conv>"+GetName(GetArea(oTarget))+ " " + GetName(oTarget) + ": " + sSaid + " </Conv>");
                }
            }
            return;
        }
        else if (GetStringLeft(sSaid, 1) == ";" &&
        (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter))))
        {
            object oSummon;
            if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter);
            if (GetIsObjectValid(oSummon))
            {
                sSaid = GetStringRight(sSaid, GetStringLength(sSaid)-1);
                if (GetStringLeft(sSaid, 1) == "[")
                    TranslateToLanguage(sSaid, oSummon);
                else if (GetStringLeft(sSaid, 1) == "*")
                    ParseEmote(sSaid, oSummon);
                else
                {
                    AssignCommand(oSummon, SpeakString(sSaid));
                    PrintString("<Conv>"+GetName(GetArea(oSummon))+ " " + GetName(oSummon) + ": " + sSaid + " </Conv>");
                }
            }
            return;
        }
        else if (GetIsObjectValid(GetLocalObject(GetModule(), "hls_NPCControl" + GetStringLeft(sSaid, 1))) && GetLocalInt(GetModule(), "dmfi_Admin" + GetPCPublicCDKey(oShouter)))
        {
            object oControl = GetLocalObject(GetModule(), "hls_NPCControl" + GetStringLeft(sSaid, 1));
            sSaid = GetStringRight(sSaid, GetStringLength(sSaid)-1);
            if (GetStringLeft(sSaid, 1) == "[")
                TranslateToLanguage(sSaid, oControl);
            else if (GetStringLeft(sSaid, 1) == "*")
                ParseEmote(sSaid, oControl);
            else if (GetStringLeft(sSaid, 1) == ".")
                ParseCommand(oControl, oShouter, sSaid);
            else
            {
                //This "throws" your voice to an object and properly dumps it into the log
                AssignCommand(oControl, SpeakString(sSaid));
                PrintString("<Conv>"+GetName(GetArea(oControl))+ " " + GetName(oControl) + ": " + sSaid + " </Conv>");
            }
            return;
        }
        else if (GetStringLeft(sSaid, 1) == "." && GetIsObjectValid(oMaster))
        {
            ParseCommand(oTarget, oMaster, sSaid);
            return;
        }
        else
        {
            //This records the phrase into the log
            PrintString("<Conv>"+GetName(GetArea(oShouter))+ " " + GetName(oShouter) + ": " + sSaid + " </Conv>");

            if (GetLocalInt(GetModule(), "dmfi_DMSpy"))
            {
                object oTempPC = GetFirstPC();
                while(GetIsObjectValid(oTempPC))
                {
                    if (GetIsDM(oTempPC))
                        SendMessageToPC(oTempPC, "(" + GetName(GetArea(oShouter)) + ") " + GetName(oShouter) + ": " + sSaid);
                    oTempPC = GetNextPC();
                }
            }
        }
    }
}
