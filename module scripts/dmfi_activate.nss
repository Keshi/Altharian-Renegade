void dmw_CleanUp(object oMySpeaker)
{
   int nCount;
   int nCache;
   DeleteLocalObject(oMySpeaker, "dmfi_univ_target");
   DeleteLocalLocation(oMySpeaker, "dmfi_univ_location");
   DeleteLocalObject(oMySpeaker, "dmw_item");
   DeleteLocalString(oMySpeaker, "dmw_repamt");
   DeleteLocalString(oMySpeaker, "dmw_repargs");
   nCache = GetLocalInt(oMySpeaker, "dmw_playercache");
   for(nCount = 1; nCount <= nCache; nCount++)
   {
      DeleteLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCount));
   }
   DeleteLocalInt(oMySpeaker, "dmw_playercache");
   nCache = GetLocalInt(oMySpeaker, "dmw_itemcache");
   for(nCount = 1; nCount <= nCache; nCount++)
   {
      DeleteLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount));
   }
   DeleteLocalInt(oMySpeaker, "dmw_itemcache");
   for(nCount = 1; nCount <= 10; nCount++)
   {
      DeleteLocalString(oMySpeaker, "dmw_dialog" + IntToString(nCount));
      DeleteLocalString(oMySpeaker, "dmw_function" + IntToString(nCount));
      DeleteLocalString(oMySpeaker, "dmw_params" + IntToString(nCount));
   }
   DeleteLocalString(oMySpeaker, "dmw_playerfunc");
   DeleteLocalInt(oMySpeaker, "dmw_started");
}


void main()
{
    object oItem=GetItemActivated();
    object oUser=GetItemActivator();
    object oOther=GetItemActivatedTarget();
    location lLocation=GetItemActivatedTargetLocation();
    string sItemTag=GetTag(oItem);

    dmw_CleanUp(oUser);
    if (GetStringLeft(sItemTag,8) == "hlslang_")
    {
            //Destroy any existing Voice attached to the user
            if (GetIsObjectValid(GetLocalObject(oUser, "dmfi_MyVoice")))
            {
                DestroyObject(GetLocalObject(oUser, "dmfi_MyVoice"));
                FloatingTextStringOnCreature("You have destroyed your previous Voice", oUser, FALSE);
            }

            //Set the Voice to interpret language of the appropriate widget
            string ssLanguage = GetStringRight(sItemTag, 2);
            if (GetStringLeft(ssLanguage, 1) == "_")
                ssLanguage = GetStringRight(sItemTag, 1);
            SetLocalInt(oUser, "hls_MyLanguage", StringToInt(ssLanguage));
            SetLocalString(oUser, "hls_MyLanguageName", GetName(oItem));
            DelayCommand(1.0f, FloatingTextStringOnCreature("You are speaking " + GetName(oItem) + ". Type /dm [(what you want to say in brackets)]", oUser, FALSE));
            object oArea = GetFirstObjectInArea(GetArea(oUser));
            while (GetIsObjectValid(oArea))
            {
                if (GetObjectType(oArea) == OBJECT_TYPE_CREATURE &&
                    GetLocalInt(oArea, "hls_Listening") &&
                    GetDistanceBetween(oUser, oArea) < 20.0f &&
                    oArea != GetLocalObject(oUser, "dmfi_MyVoice"))
                    {
                        DeleteLocalObject(oUser, "dmfi_MyVoice");
                        return;
                    }
                oArea = GetNextObjectInArea(GetArea(oUser));
            }
        //Create the Voice
        object oVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", GetLocation(oUser));
        //Set the Voice to Autofollow the User
        AssignCommand(oVoice, ActionForceFollowObject(oUser, 3.0f));
        //Set Ownership of the Voice to the User
        SetLocalObject(oUser, "dmfi_MyVoice", oVoice);
        return;
    }


    if (GetStringLeft(sItemTag, 5) == "dmfi_")
    {
        if (!GetIsDM(oUser) &&
            !GetLocalInt(GetModule(), "dmfi_Admin" + GetPCPublicCDKey(oUser)) &&
            !GetLocalInt(oUser, "hls_Listening") &&
            GetIsPC(oUser) &&
            GetLocalInt(GetModule(), "dmfi_DMToolLock"))
        {
            FloatingTextStringOnCreature("You cannot use this item." ,oUser, FALSE);
            SendMessageToAllDMs(GetName(oUser)+ " is attempting to use a DM item.");
            return;
        }
        if (sItemTag == "dmfi_exploder")
        {
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_afflict"))) CreateItemOnObject("dmfi_afflict", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_dicebag"))) CreateItemOnObject("dmfi_dicebag", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_pc_dicebag"))) CreateItemOnObject("dmfi_pc_dicebag", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_pc_follow"))) CreateItemOnObject("dmfi_pc_follow", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_pc_emote"))) CreateItemOnObject("dmfi_pc_emote", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_dmw"))) CreateItemOnObject("dmfi_dmw", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_emote"))) CreateItemOnObject("dmfi_emote", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_encounter"))) CreateItemOnObject("dmfi_encounter", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_faction"))) CreateItemOnObject("dmfi_faction", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_fx"))) CreateItemOnObject("dmfi_fx", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_music"))) CreateItemOnObject("dmfi_music", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_sound"))) CreateItemOnObject("dmfi_sound", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_voice"))) CreateItemOnObject("dmfi_voice", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_xp"))) CreateItemOnObject("dmfi_xp", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_500xp"))) CreateItemOnObject("dmfi_500xp", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_en_ditto"))) CreateItemOnObject("dmfi_en_ditto", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_mute"))) CreateItemOnObject("dmfi_mute", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_peace"))) CreateItemOnObject("dmfi_peace", oUser);
            if(!GetIsObjectValid(GetItemPossessedBy(oUser, "dmfi_voicewidget"))) CreateItemOnObject("dmfi_voicewidget", oUser);
            return;
        }
        if (sItemTag == "dmfi_peace")
        {   //This widget sets all creatures in the area to a neutral stance and clears combat.
            object oArea = GetFirstObjectInArea(GetArea(oUser));
            object oP;
            while (GetIsObjectValid(oArea))
            {
                if (GetObjectType(oArea) == OBJECT_TYPE_CREATURE && !GetIsPC(oArea))
                {
                    AssignCommand(oArea, ClearAllActions(TRUE));
                    oP = GetFirstPC();
                    while (GetIsObjectValid(oP))
                    {
                        if (GetArea(oP) == GetArea(oUser))
                        {
                            ClearPersonalReputation(oArea, oP);
                            SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 25, oP);
                            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 91, oP);
                            SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 91, oP);
                            SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 91, oP);
                        }
                        oP = GetNextPC();
                    }
                    AssignCommand(oArea, ClearAllActions(TRUE));
                }
                oArea = GetNextObjectInArea(GetArea(oUser));
            }
        }
        if (sItemTag == "dmfi_voicewidget")
        {
            object oVoice;
            //Destroy any existing Voice attached to the user
            if (GetIsObjectValid(GetLocalObject(oUser, "dmfi_MyVoice")))
            {
                DestroyObject(GetLocalObject(oUser, "dmfi_MyVoice"));
                FloatingTextStringOnCreature("You have destroyed your previous Voice", oUser, FALSE);
            }
            if (GetIsObjectValid(oOther))
            {
                SetLocalObject(oUser, "dmfi_VoiceTarget", oOther);
                FloatingTextStringOnCreature("You have targeted " + GetName(oOther) + " with the Voice Widget", oUser, FALSE);
                object oArea = GetFirstObjectInArea(GetArea(oUser));
                while (GetIsObjectValid(oArea))
                {
                    if (GetObjectType(oArea) == OBJECT_TYPE_CREATURE &&
                    GetLocalInt(oArea, "hls_Listening") &&
                    GetDistanceBetween(oUser, oArea) < 20.0f &&
                    oArea != GetLocalObject(oUser, "dmfi_MyVoice"))
                    {
                        DeleteLocalObject(oUser, "dmfi_MyVoice");
                        return;
                    }
                oArea = GetNextObjectInArea(GetArea(oUser));
                }
                //Create the Voice
                object oVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", GetLocation(oUser));
                //Set Ownership of the Voice to the User
                AssignCommand(oVoice, ActionForceFollowObject(oUser, 3.0f));
                SetLocalObject(oUser, "dmfi_MyVoice", oVoice);
                return;
            }
            else
            {
                //Create the Voice
                oVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", lLocation);
                AssignCommand(oVoice, ActionForceFollowObject(oUser, 3.0f));
                SetLocalObject(oUser, "dmfi_VoiceTarget", oVoice);
                //Set Ownership of the Voice to the User
                SetLocalObject(oUser, "dmfi_MyVoice", oVoice);
                DelayCommand(1.0f, FloatingTextStringOnCreature("The Voice is operational", oUser, FALSE));
                return;
            }
            return;
        }
        if (sItemTag == "dmfi_mute")
        {
            SetLocalObject(oUser, "dmfi_univ_target", oUser);
            SetLocalString(oUser, "dmfi_univ_conv", "voice");
            SetLocalInt(oUser, "dmfi_univ_int", 8);
            ExecuteScript("dmfi_execute", oUser);
            return;
        }
        if (sItemTag == "dmfi_en_ditto")
        {
            SetLocalObject(oUser, "dmfi_univ_target", oOther);
            SetLocalLocation(oUser, "dmfi_univ_location", lLocation);
            SetLocalString(oUser, "dmfi_univ_conv", "encounter");
            SetLocalInt(oUser, "dmfi_univ_int", GetLocalInt(oUser, "EncounterType"));
            ExecuteScript("dmfi_execute", oUser);
            return;
        }
        if (sItemTag == "dmfi_500xp")
        {
            SetLocalObject(oUser, "dmfi_univ_target", oOther);
            SetLocalLocation(oUser, "dmfi_univ_location", lLocation);
            SetLocalString(oUser, "dmfi_univ_conv", "xp");
            SetLocalInt(oUser, "dmfi_univ_int", 53);
            ExecuteScript("dmfi_execute", oUser);
            return;
        }
        SetLocalObject(oUser, "dmfi_univ_target", oOther);
        SetLocalLocation(oUser, "dmfi_univ_location", lLocation);
        SetLocalString(oUser, "dmfi_univ_conv", GetStringRight(sItemTag, GetStringLength(sItemTag) - 5));
        AssignCommand(oUser, ClearAllActions());
        AssignCommand(oUser, ActionStartConversation(OBJECT_SELF, "dmfi_universal", TRUE));
    }
}
