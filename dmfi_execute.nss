/*DMFI Universal Wand executable by hahnsoo

Credits: Bioware - Dicebag
         Arawen - Skill Check Wand (implemented with the Dicebag)
         Jhenne (tallonzek@hotmail.com)   \ Authors of the original FX Wand,
         Doppleganger                     / DM Wand and Emote Wand
         Demetrious - XP wand
         Dezran (dezran@roguepenguin.com) - Rod of Affliction
         Lurker - Music Wand
         Oddbod - FX wand improvements
         Ty Worsham (volition) - Sound Creator Beta
         OldManWhistler - NPC corpse functions

         hahnsoo (hahns_shin@hotmail.com) - Final Improved FX wand, Universal wand scripts,
                                            Encounter wand, DM Voice scripts, Faction wand
         J.R.R.Tolkien
*/
#include "dmfi_dmw_inc"

//By OldManWhistler for the DMFI Control Wand
void DestroyAllItems()
{
    if(GetIsDead(OBJECT_SELF))
    {
        object oItem = GetFirstItemInInventory();
        while(GetIsObjectValid(oItem))
        {
            DestroyObject(oItem);
            oItem = GetNextItemInInventory();
        }
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_ARMS)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_ARROWS)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_BELT)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_BOLTS)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_BOOTS)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_BULLETS)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_CARMOUR)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_CHEST)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_CLOAK)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_B)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_L)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_R)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_HEAD)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_LEFTHAND)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_LEFTRING)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_NECK)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)))
            DestroyObject(oItem);
        if(GetIsObjectValid(oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTRING)))
            DestroyObject(oItem);
    }
}

// Function to destroy a target, by OldManWhistler, for the DMFI Control Wand
void DestroyCreature(object oTarget)
{
    AssignCommand(oTarget,SetIsDestroyable(TRUE,FALSE,FALSE));
    DestroyObject(oTarget);
}

//DMFI NPC Control Wand
void DoControlFunction(int iFaction, object oUser)
{
    object oTarget = GetLocalObject(oUser, "dmfi_univ_target");
    object oArea = GetArea(oUser);
    object oChange;

    switch(iFaction)
    {
        case 11: ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE); break;
        case 12: ChangeToStandardFaction(oTarget, STANDARD_FACTION_COMMONER); break;
        case 13: ChangeToStandardFaction(oTarget, STANDARD_FACTION_DEFENDER); break;
        case 14: ChangeToStandardFaction(oTarget, STANDARD_FACTION_MERCHANT); break;
        case 15: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange))
                    ChangeToStandardFaction(oChange, STANDARD_FACTION_HOSTILE);
                oChange = GetNextObjectInArea(oArea);}break;
        case 16: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange))
                    ChangeToStandardFaction(oChange, STANDARD_FACTION_COMMONER);
                oChange = GetNextObjectInArea(oArea);}break;
        case 17: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange))
                    ChangeToStandardFaction(oChange, STANDARD_FACTION_DEFENDER);
                oChange = GetNextObjectInArea(oArea);}break;
        case 18: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange))
                    ChangeToStandardFaction(oChange, STANDARD_FACTION_MERCHANT);
                oChange = GetNextObjectInArea(oArea);}break;
        case 21: oChange = GetFirstPC();
            while (GetIsObjectValid(oChange))
            {   SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oChange);
                oChange = GetNextPC();}break;
        case 22: oChange = GetFirstPC();
            while (GetIsObjectValid(oChange))
            {   SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 20, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 91, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 50, oChange);
                oChange = GetNextPC();}break;
        case 23: oChange = GetFirstPC();
            while (GetIsObjectValid(oChange))
            {   SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0 , oChange);
                SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 0, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 0, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 0, oChange);
                oChange = GetNextPC();}break;
        case 24: oChange = GetFirstPC();
            while (GetIsObjectValid(oChange))
            {   SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 100, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oChange);
                oChange = GetNextPC();}break;
        case 25: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE){
                SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 0, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 0, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 0, oChange);}
                oChange = GetNextObjectInArea(oArea);}break;
        case 26: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE){
                AssignCommand(oChange, ClearAllActions(TRUE));
                SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 50, oChange);
                SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 50, oChange);}
                oChange = GetNextObjectInArea(oArea);}break;
        case 31: SetLocalObject(oUser, "dmfi_customfaction1", oTarget); break;
        case 32: SetLocalObject(oUser, "dmfi_customfaction2", oTarget); break;
        case 33: SetLocalObject(oUser, "dmfi_customfaction3", oTarget); break;
        case 34: SetLocalObject(oUser, "dmfi_customfaction4", oTarget); break;
        case 35: SetLocalObject(oUser, "dmfi_customfaction5", oTarget); break;
        case 36: SetLocalObject(oUser, "dmfi_customfaction6", oTarget); break;
        case 37: SetLocalObject(oUser, "dmfi_customfaction7", oTarget); break;
        case 38: SetLocalObject(oUser, "dmfi_customfaction8", oTarget); break;
        case 39: SetLocalObject(oUser, "dmfi_customfaction9", oTarget); break;
        case 41: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction1")); break;
        case 42: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction2")); break;
        case 43: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction3")); break;
        case 44: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction4")); break;
        case 45: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction5")); break;
        case 46: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction6")); break;
        case 47: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction7")); break;
        case 48: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction8")); break;
        case 49: ChangeFaction(oTarget, GetLocalObject(oUser, "dmfi_customfaction9")); break;
        case 51: RemoveHenchman(GetMaster(oTarget), oTarget);
                 SetLocalObject(oUser, "dmfi_henchman", oTarget); break;
        case 52: RemoveHenchman(oTarget, GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oTarget));
                 AddHenchman(oTarget, GetLocalObject(oUser, "dmfi_henchman")); break;
        case 61: AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionMoveAwayFromObject(oUser, TRUE)); break;
        case 62: AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionForceMoveToObject(oUser, TRUE, 2.0f, 30.0f)); break;
        case 63: AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionRandomWalk()); break;
        case 64: AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionRest()); break;
        case 65: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange)){
                    AssignCommand(oChange, ClearAllActions()); AssignCommand(oChange, ActionMoveAwayFromObject(oUser, TRUE));}
                oChange = GetNextObjectInArea(oArea);} break;
        case 66: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange)){
                    AssignCommand(oChange, ClearAllActions()); AssignCommand(oChange, ActionForceMoveToObject(oUser, TRUE, 2.0f, 30.0f));}
                oChange = GetNextObjectInArea(oArea);} break;
        case 67: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange)){
                    AssignCommand(oChange, ClearAllActions()); AssignCommand(oChange, ActionRandomWalk());}
                oChange = GetNextObjectInArea(oArea);} break;
        case 68: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange)){
                    AssignCommand(oChange, ClearAllActions()); AssignCommand(oChange, ActionRest());}
                oChange = GetNextObjectInArea(oArea);} break;
        case 69: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappear(), oTarget); break;
        case 70: DestroyCreature(oTarget); break;
        case 71: AssignCommand(oTarget, SetIsDestroyable(FALSE, TRUE, TRUE)); break;
        case 72: AssignCommand(oTarget, SetIsDestroyable(FALSE, FALSE, TRUE)); break;
        case 73: AssignCommand(oTarget, SetIsDestroyable(FALSE, FALSE, FALSE)); break;
        case 74: AssignCommand(oTarget, SetIsDestroyable(TRUE, FALSE, FALSE)); break;
        case 75: AssignCommand(oTarget, SetIsDestroyable(FALSE, TRUE, TRUE));
            DelayCommand(0.1, AssignCommand(oTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDeath(), oTarget))); break;
        case 76: AssignCommand(oTarget, SetIsDestroyable(FALSE, FALSE, TRUE));
            DelayCommand(0.1, AssignCommand(oTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDeath(), oTarget))); break;
        case 77: AssignCommand(oTarget, SetIsDestroyable(FALSE, FALSE, FALSE));
            DelayCommand(0.1, AssignCommand(oTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDeath(), oTarget))); break;
        case 78: AssignCommand(oTarget, SetIsDestroyable(TRUE, FALSE, FALSE));
            DelayCommand(0.1, AssignCommand(oTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDeath(), oTarget))); break;
        case 79: AssignCommand(oTarget, DestroyAllItems());
            DelayCommand(1.0, DestroyCreature(oTarget));

        default: break;

    }
}

//DMFI Creates the "settings" creature
void CreateSetting(object oUser)
{
    object oSetting = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_setting", GetLocation(oUser));
    DelayCommand(0.5f, AssignCommand(oSetting, ActionSpeakString(GetLocalString(oUser, "EffectSetting") + " is currently set at " + FloatToString(GetLocalFloat(oUser, GetLocalString(oUser, "EffectSetting"))))));
    SetLocalObject(oSetting, "MyMaster", oUser);
    SetListenPattern(oSetting, "**", 20600); //listen to all text
    SetLocalInt(oSetting, "hls_Listening", 1); //listen to all text
    SetListening(oSetting, TRUE);          //be sure NPC is listening
}

//DMFI Processes the dice rolls
void RollDemBones(object oUser, int iBroadcast = 0, int iMod = 0, string sAbility = "", int iNum = 1, int iSide = 20)
{
    string sString = "";
    int iRoll = 0;
    int iTotal = 0;
    //Build the string
    sString = sAbility+"Roll " + IntToString(iNum) + "d" + IntToString(iSide) + ": ";
    while(iNum > 1)
    {
        iRoll = Random(iSide) + 1;
        iTotal = iTotal + iRoll;
        sString = sString + IntToString(iRoll) + " + ";
        iNum--;
    }
    iRoll = Random(iSide) + 1;
    iTotal = iTotal + iRoll;
    sString = sString + IntToString(iRoll);
    if (iMod)
    {
        iTotal = iTotal + iMod;
        sString = sString + " + Modifier: " + IntToString(iMod);
    }
    sString = sString + " = Total: " + IntToString(iTotal);

    //Perform appropriate animation
    switch(GetLocalInt(oUser, "dmfi_univ_int"))
    {
        case 72: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0)); break;
        case 74: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0)); break;
        case 75: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0)); break;
        case 76: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.0f)); break;
        case 78: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0)); break;
        case 79: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 5.0f)); break;
        case 81: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0f)); break;
        case 83: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0f)); break;
        case 86: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 999.0f)); break;
        case 87: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0)); break;
        case 88: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0)); break;
        case 89: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0)); break;
        case 90: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0)); break;
        case 92: AssignCommand(oUser, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), oUser, 6.0f)); break;
        case 93: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0f)); break;
        case 94: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0)); break;
        case 95: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 3.0f)); break;
        case 96: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0f)); break;
        case 97: AssignCommand(oUser, ActionCastFakeSpellAtObject(SPELL_FOXS_CUNNING, oUser)); break;
        case 98: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 3.0f)); break;
        case 99: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0)); break;
        default: AssignCommand(oUser, PlayAnimation (ANIMATION_LOOPING_GET_MID, 1.0, 3.0)); break;
    }

    switch(iBroadcast)
    {
        case 3: break;
        case 1: AssignCommand(oUser, SpeakString(sString, TALKVOLUME_SHOUT)); break;
        case 2: AssignCommand(oUser, SpeakString(sString)); break;
        default: if (GetIsPC(oUser)) SendMessageToPC(oUser, sString); break;
    }
    SendMessageToAllDMs(GetName(oUser) + " : " + sString);
    return;
}

//This function is for the DMFI PC Dicebag
void DoDiceBagFunction(int iDice, object oUser, int iDMOverride = 0)
{
    string sAbility = "";
    int iNum = 0;
    int iSide = 0;
    int iMod = 0;
    int iLeft;
    if (iDice < 100)
        iLeft = StringToInt(GetStringLeft(IntToString(iDice), 1));
    else
        iLeft = 10;
    int iRight = StringToInt(GetStringRight(IntToString(iDice), 1));
    switch(iDice)
    {
        case 71: iNum = 1; iSide = 20; sAbility="Strength Check, "; iMod = GetAbilityModifier(ABILITY_STRENGTH, oUser); break;
        case 72: iNum = 1; iSide = 20; sAbility="Dexterity Check, "; iMod = GetAbilityModifier(ABILITY_DEXTERITY, oUser); break;
        case 73: iNum = 1; iSide = 20; sAbility="Constitution Check, "; iMod = GetAbilityModifier(ABILITY_CONSTITUTION, oUser); break;
        case 74: iNum = 1; iSide = 20; sAbility="Intelligence Check, "; iMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oUser); break;
        case 75: iNum = 1; iSide = 20; sAbility="Wisdom Check, "; iMod = GetAbilityModifier(ABILITY_WISDOM, oUser); break;
        case 76: iNum = 1; iSide = 20; sAbility="Charisma Check, "; iMod = GetAbilityModifier(ABILITY_CHARISMA, oUser); break;
        case 77: iNum = 1; iSide = 20; sAbility="Fortitude Save, "; iMod = GetFortitudeSavingThrow(oUser); break;
        case 78: iNum = 1; iSide = 20; sAbility="Reflex Save, "; iMod = GetReflexSavingThrow(oUser); break;
        case 79: iNum = 1; iSide = 20; sAbility="Will Save, "; iMod = GetWillSavingThrow(oUser); break;
        case 80: iNum = 1; iSide = 20; sAbility="Open Lock Check, "; iMod = GetSkillRank(SKILL_OPEN_LOCK, oUser); break;
        case 81: iNum = 1; iSide = 20; sAbility="Animal Empathy Check, "; iMod = GetSkillRank(SKILL_ANIMAL_EMPATHY, oUser); break;
        case 82: iNum = 1; iSide = 20; sAbility="Concentration Check, "; iMod = GetSkillRank(SKILL_CONCENTRATION, oUser); break;
        case 83: iNum = 1; iSide = 20; sAbility="Disable Trap Check, "; iMod = GetSkillRank(SKILL_DISABLE_TRAP, oUser); break;
        case 84: iNum = 1; iSide = 20; sAbility="Discipline Check, "; iMod = GetSkillRank(SKILL_DISCIPLINE, oUser); break;
        case 85: iNum = 1; iSide = 20; sAbility="Heal Check, "; iMod = GetSkillRank(SKILL_HEAL, oUser); break;
        case 86: iNum = 1; iSide = 20; sAbility="Hide Check, "; iMod = GetSkillRank(SKILL_HIDE, oUser); break;
        case 87: iNum = 1; iSide = 20; sAbility="Listen Check, "; iMod = GetSkillRank(SKILL_LISTEN, oUser); break;
        case 88: iNum = 1; iSide = 20; sAbility="Lore Check, "; iMod = GetSkillRank(SKILL_LORE, oUser); break;
        case 89: iNum = 1; iSide = 20; sAbility="Move Silently Check, "; iMod = GetSkillRank(SKILL_MOVE_SILENTLY, oUser); break;
        case 90: iNum = 1; iSide = 20; sAbility="Use Magic Device Check, "; iMod = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oUser); break;
        case 91: iNum = 1; iSide = 20; sAbility="Parry Check, "; iMod = GetSkillRank(SKILL_PARRY, oUser); break;
        case 92: iNum = 1; iSide = 20; sAbility="Perform Check, "; iMod = GetSkillRank(SKILL_PERFORM, oUser); break;
        case 93: iNum = 1; iSide = 20; sAbility="Persuade Check, "; iMod = GetSkillRank(SKILL_PERSUADE, oUser); break;
        case 94: iNum = 1; iSide = 20; sAbility="Pick Pocket Check, "; iMod = GetSkillRank(SKILL_PICK_POCKET, oUser); break;
        case 95: iNum = 1; iSide = 20; sAbility="Search Check, "; iMod = GetSkillRank(SKILL_SEARCH, oUser); break;
        case 96: iNum = 1; iSide = 20; sAbility="Set Trap Check, "; iMod = GetSkillRank(SKILL_SET_TRAP, oUser); break;
        case 97: iNum = 1; iSide = 20; sAbility="Spellcraft Check, "; iMod = GetSkillRank(SKILL_SPELLCRAFT, oUser); break;
        case 98: iNum = 1; iSide = 20; sAbility="Spot Check, "; iMod = GetSkillRank(SKILL_SPOT, oUser); break;
        case 99: iNum = 1; iSide = 20; sAbility="Taunt Check, "; iMod = GetSkillRank(SKILL_TAUNT, oUser); break;
        case 101: SetLocalInt(oUser, "dmfi_dicebag", 2); SetCustomToken(20681, "Local"); FloatingTextStringOnCreature("Broadcast Mode set to Local", oUser, FALSE); return; break;
        case 102: SetLocalInt(oUser, "dmfi_dicebag", 1); SetCustomToken(20681, "Global"); FloatingTextStringOnCreature("Broadcast Mode set to Global", oUser, FALSE); return; break;
        case 103: SetLocalInt(oUser, "dmfi_dicebag", 0); SetCustomToken(20681, "Private"); FloatingTextStringOnCreature("Broadcast Mode set to Private", oUser, FALSE); return; break;
        case 104: iNum = 1; iSide = 2; break;
        case 105: iNum = 1; iSide = 3; break;
        case 106: iNum = 1; iSide = 5; break;
        case 107: iNum = 1; iSide = 7; break;
        case 108: iNum = 1; iSide = 9; break;
        case 109: iNum = 1; iSide = 100; break;
        default: iNum = iRight;
        switch(iLeft)
        {
            case 1: iSide = 4; break;
            case 2: iSide = 6; break;
            case 3: iSide = 8; break;
            case 4: iSide = 10; break;
            case 5: iSide = 12; break;
            case 6: iSide = 20; break;
        }
        break;
    }
    int iTell;
    if (iDMOverride)
        iTell = iDMOverride;
    else
        iTell = GetLocalInt(oUser, "dmfi_dicebag");
    RollDemBones(oUser, iTell, iMod, sAbility, iNum, iSide);
}

//This is for the DMFI Dicebag Wand
void DoDMDiceBagFunction(int iDice, object oUser)
{
    object oTarget = GetLocalObject(oUser, "dmfi_univ_target");
    if (!GetIsObjectValid(oTarget))
        oTarget = oUser;
    int iOverride = GetLocalInt(oUser, "dmfi_dicebag");
    object oArea = GetArea(oUser);
    object oRoll;
    int iLeft;
    if (iDice < 100)
        iLeft = StringToInt(GetStringLeft(IntToString(iDice), 1));
    else
        iLeft = 10;
    switch(iLeft)
    {
        case 1:
        case 2:
        case 3: //Single Creature Roll
              DoDiceBagFunction(iDice+60, oTarget, iOverride); break;
        case 4:
        case 5:
        case 6: //All PCs/NPCs in the area
              oRoll = GetFirstObjectInArea(oArea);
              while (GetIsObjectValid(oRoll))
              {
                if ((GetIsPC(oTarget) && GetIsPC(oRoll)) || (!GetIsPC(oTarget) && !GetIsPC(oRoll) && GetObjectType(oRoll) == OBJECT_TYPE_CREATURE))
                    DoDiceBagFunction(iDice+30, oRoll, iOverride);
                oRoll = GetNextObjectInArea(oArea);
              }
              break;
        case 7:
        case 8:
        case 9: //All PCs
              oRoll = GetFirstPC();
              while (GetIsObjectValid(oRoll))
              {
                DoDiceBagFunction(iDice, oRoll, iOverride);
                oRoll = GetNextPC();
              }break;
        case 10:
        switch(iDice)
        {
            case 101: SetLocalInt(oUser, "dmfi_dicebag", 2); SetCustomToken(20681, "Local"); FloatingTextStringOnCreature("Broadcast Mode set to Local", oUser, FALSE); return; break;
            case 102: SetLocalInt(oUser, "dmfi_dicebag", 1); SetCustomToken(20681, "Global"); FloatingTextStringOnCreature("Broadcast Mode set to Global", oUser, FALSE); return; break;
            case 103: SetLocalInt(oUser, "dmfi_dicebag", 0); SetCustomToken(20681, "Private"); FloatingTextStringOnCreature("Broadcast Mode set to Private", oUser, FALSE); return; break;
            case 104: SetLocalInt(oUser, "dmfi_dicebag", 3); SetCustomToken(20681, "DM Only"); FloatingTextStringOnCreature("Broadcast Mode set to DM Only", oUser, FALSE); return; break;
        }
        default: break;
    }


}

void DoOneRingFunction(int iRing, object oUser)
{
    switch(iRing)
    {
        case 1: SetLocalString(oUser, "dmfi_univ_conv", "afflict"); break;
        case 2: SetLocalString(oUser, "dmfi_univ_conv", "faction"); break;
        case 3: SetLocalString(oUser, "dmfi_univ_conv", "dicebag"); break;
        case 4: SetLocalString(oUser, "dmfi_univ_conv", "dmw"); break;
        case 5: SetLocalString(oUser, "dmfi_univ_conv", "emote"); break;
        case 6: SetLocalString(oUser, "dmfi_univ_conv", "encounter"); break;
        case 7: SetLocalString(oUser, "dmfi_univ_conv", "fx"); break;
        case 8: SetLocalString(oUser, "dmfi_univ_conv", "music"); break;
        case 91: SetLocalString(oUser, "dmfi_univ_conv", "sound"); break;
        case 92: SetLocalString(oUser, "dmfi_univ_conv", "voice"); break;
        case 93: SetLocalString(oUser, "dmfi_univ_conv", "xp"); break;
        default: SetLocalString(oUser, "dmfi_univ_conv", "dmw"); break;
    }
    AssignCommand(oUser, ClearAllActions());
    AssignCommand(oUser, ActionStartConversation(OBJECT_SELF, "dmfi_universal", TRUE));
}
//This function is for the DMFI Sound FX Wand
void DoSoundFunction(int iSound, object oUser)
{
    location lLocation = GetLocalLocation(oUser, "dmfi_univ_location");
    float fDuration;
    float fDelay;
    object oTarget;

    if (GetLocalFloat(oUser, "EffectDuration") == 0.0f)
        fDuration = 1.0f;
    else
        fDuration = GetLocalFloat(oUser, "EffectDuration");

    if (GetLocalFloat(oUser, "EffectSoundDelay") == 0.0f)
        fDelay = 0.5f;
    else
        fDelay = GetLocalFloat(oUser, "EffectSoundDelay");
    switch(iSound)
    {
        case 11: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_batsflap1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 12: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_bugsscary1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 13: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_crptvoice1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 14: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_orcgrunt1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 15: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_minepick2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 16: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_ratssqeak1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 17: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_rockfallg1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 18: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_rockfalgl2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 19: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_gustcavrn1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 21: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_belltower3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 22: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_claybreak3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 23: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_glasbreak2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 24: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_gongring3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 25: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_marketgrp4"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 26: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_cv_millwheel1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 27: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_sawing1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 28: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_bellwind1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 29: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_cv_smithhamr2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 31: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_firelarge1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 32: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_lavapillr1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 33: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_lavafire1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 34: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_firelarge2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 35: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_surf2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 36: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_drips1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 37: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_waterlap1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 38: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_stream4"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 39: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_waterfall2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 41: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_crynight3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 42: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_bushmove1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 43: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_birdsflap2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 44: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_grassmove3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 45: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_hawk1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 46: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_leafmove3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 47: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_gulls2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 48: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_songbirds1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 49: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_an_toads1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 51: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_beaker1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 52: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_cauldron1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 53: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_chntmagic1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 54: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_crystalev1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 55: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_crystalic1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 56: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_portal1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 57: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_mg_telepin1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 58: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_mg_telepout1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 59: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_mg_frstmagic1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 61: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_tavclap1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 62: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_battlegrp7"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 63: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_laughincf2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 64: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_comtntgrp3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 65: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_chantingm2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 66: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_cryingf2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 67: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_laughingf3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 68: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_chantingf2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 69: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_wailingm6"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 71: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_evilchantm"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 72: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_crows2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 73: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_wailingcf1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 74: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_crptvoice2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 75: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_lafspook2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 76: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_owlhoot1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 77: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_wolfhowl1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 78: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_screamf3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 79: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_zombiem3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 81: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_gustsoft1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 82: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_thundercl3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 83: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_thunderds4"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 84: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLocation); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_gusforst1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
        case 85: SetWeather(GetArea(oUser), WEATHER_CLEAR); break;
        case 86: SetWeather(GetArea(oUser), WEATHER_RAIN); break;
        case 87: SetWeather(GetArea(oUser), WEATHER_SNOW); break;
        case 88: SetWeather(GetArea(oUser), WEATHER_USE_AREA_SETTINGS); break;
        case 89: SetWeather(GetArea(oUser), WEATHER_USE_AREA_SETTINGS); break;
        //Settings
        case 91:
        SetLocalString(oUser, "EffectSetting", "EffectDuration");
        CreateSetting(oUser);
        break;
        case 92:
        SetLocalString(oUser, "EffectSetting", "EffectSoundDelay");
        CreateSetting(oUser);
        break;
        case 93:
        SetLocalString(oUser, "EffectSetting", "EffectBeamDuration");
        CreateSetting(oUser);
        break;
        case 94: //Change Day Music
        iDayMusic = MusicBackgroundGetDayTrack(GetArea(oUser)) + 1;
        if (iDayMusic > 33) iDayMusic = 49;
        if (iDayMusic > 55) iDayMusic = 1;
        MusicBackgroundStop(GetArea(oUser));
        MusicBackgroundChangeDay(GetArea(oUser), iDayMusic);
        MusicBackgroundPlay(GetArea(oUser));
        break;
        case 95: //Change Night Music
        iNightMusic = MusicBackgroundGetDayTrack(GetArea(oUser)) + 1;
        if (iNightMusic > 33) iNightMusic = 49;
        if (iNightMusic > 55) iNightMusic = 1;
        MusicBackgroundStop(GetArea(oUser));
        MusicBackgroundChangeNight(GetArea(oUser), iNightMusic);
        MusicBackgroundPlay(GetArea(oUser));
        break;
        case 96: //Play Background Music
        MusicBackgroundPlay(GetArea(oUser));
        break;
        case 97: //Stop Background Music
        MusicBackgroundStop(GetArea(oUser));
        break;
        case 98: //Change and Play Battle Music
        iBattleMusic = MusicBackgroundGetBattleTrack(GetArea(oUser)) + 1;
        if (iBattleMusic < 34 || iBattleMusic > 48) iBattleMusic = 34;
        MusicBattleStop(GetArea(oUser));
        MusicBattleChange(GetArea(oUser), iBattleMusic);
        MusicBattlePlay(GetArea(oUser));
        break;
        case 99: //Stop Battle Music
        MusicBattleStop(GetArea(oUser));
        break;

        default: break;
    }
return;
}

//This function is for the DMFI DM Voice
void DoVoiceFunction(int iSay, object oUser)
{
    object oMod = GetModule();
    object oTarget = GetLocalObject(oUser, "dmfi_univ_target");
    location lLocation = GetLocalLocation(oUser, "dmfi_univ_location");
    object oVoice;
    string sSay;

    if (!GetIsObjectValid(oTarget))
    {
        switch (iSay)
        {
            case 8: SetLocalInt(GetModule(), "dmfi_DMSpy", abs(GetLocalInt(GetModule(), "dmfi_DMSpy") - 1));
                    if (GetLocalInt(GetModule(), "dmfi_DMSpy") == 1)
                        FloatingTextStringOnCreature("DM Spy is on.", oUser, FALSE);
                    else
                        FloatingTextStringOnCreature("DM Spy is off.", oUser, FALSE);
                    break;
            case 9: //Destroy any existing Voice attached to the user
                if (GetIsObjectValid(GetLocalObject(oUser, "dmfi_MyVoice")))
                {
                    DestroyObject(GetLocalObject(oUser, "dmfi_MyVoice"));
                    DeleteLocalObject(oUser, "dmfi_MyVoice");
                    FloatingTextStringOnCreature("You have destroyed your previous Voice", oUser, FALSE);
                }
                //Create the Voice
                oVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", lLocation);
                SetListenPattern(oVoice, "**", 20600); //listen to all text
                SetLocalInt(oVoice, "hls_Listening", 1); //listen to all text
                SetListening(oVoice, TRUE);          //be sure NPC is listening
                //Sets the Voice as the object to throw to.
                SetLocalObject(oUser, "dmfi_VoiceTarget", oVoice);
                //Set Ownership of the Voice to the User
                SetLocalObject(oUser, "dmfi_MyVoice", oVoice);
                DelayCommand(1.0f, FloatingTextStringOnCreature("The Voice is operational", oUser, FALSE));
                break;
            default: oVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", lLocation);
                SetListenPattern(oVoice, "**", 20600); //listen to all text
                SetLocalInt(oVoice, "hls_Listening", 1); //listen to all text
                SetListening(oVoice, TRUE);          //be sure NPC is listening
                SetLocalInt(oVoice, "dmfi_Loiter", 1);
                SetLocalString(oVoice, "dmfi_LoiterSay", GetLocalString(oMod, "hls206" + IntToString(iSay)));
                break;
        }
    }
    else if (oTarget == oUser)
    {
        switch (iSay)
        {
            case 8: SetLocalInt(GetModule(), "dmfi_AllMute", abs(GetLocalInt(GetModule(), "dmfi_AllMute") - 1));
                    if (GetLocalInt(GetModule(), "dmfi_AllMute") == 1)
                        FloatingTextStringOnCreature("All NPC conversations are muted", oUser, FALSE);
                    else
                        FloatingTextStringOnCreature("All NPC conversations are unmuted", oUser, FALSE);
                    break;
            case 9: //Destroy any existing Voice attached to the user
                if (GetIsObjectValid(GetLocalObject(oUser, "dmfi_MyVoice")))
                {
                    DestroyObject(GetLocalObject(oUser, "dmfi_MyVoice"));
                    DeleteLocalObject(oUser, "dmfi_MyVoice");
                    FloatingTextStringOnCreature("You have destroyed your previous Voice", oUser, FALSE);
                }
                //Create the Voice
                oVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", lLocation);
                SetListenPattern(oVoice, "**", 20600); //listen to all text
                SetLocalInt(oVoice, "hls_Listening", 1); //listen to all text
                SetListening(oVoice, TRUE);          //be sure NPC is listening
                SetLocalObject(oUser, "dmfi_VoiceTarget", oVoice);
                //Set Ownership of the Voice to the User
                SetLocalObject(oUser, "dmfi_MyVoice", oVoice);
                DelayCommand(1.0f, FloatingTextStringOnCreature("The Voice is operational", oUser, FALSE));
                break;
            default: FloatingTextStringOnCreature("Ready to record new phrase", oUser, FALSE);
                     SetLocalInt(oUser, "hls_EditPhrase", 20600 + iSay); break;
        }
    }
    else
    {
        switch (iSay)
        {
            case 8: SetLocalInt(oTarget, "dmfi_Mute", abs(GetLocalInt(oTarget, "dmfi_Mute") - 1));
            case 9: SetLocalObject(oUser, "dmfi_VoiceTarget", oTarget);
                if(!GetIsPC(oTarget)){
                SetListenPattern(oTarget, "**", 20600); //listen to all text
                SetLocalInt(oTarget, "hls_Listening", 1); //listen to all text
                SetListening(oTarget, TRUE);}          //be sure NPC is listening
                break;
            default: sSay = GetLocalString(oMod, "hls206" + IntToString(iSay));
            AssignCommand(oTarget, SpeakString(sSay)); break;
        }
    }
}

//This function is for the DMFI Affliction Wand
void DoAfflictFunction(int iAfflict, object oUser)
{
    effect eEffect;
    object oTarget = GetLocalObject(oUser, "dmfi_univ_target");
    float fDuration;

    if (GetLocalFloat(oUser, "EffectStunDuration") == 0.0f)
        fDuration = 1000.0f;
    else
        fDuration = GetLocalFloat(oUser, "EffectStunDuration");

    if (!(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) ||
        GetIsDM(oTarget))
    {
        FloatingTextStringOnCreature("You must target a valid creature!", oUser, FALSE);
        return;
    }
    switch(iAfflict)
    {
        case 11: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL), oTarget); break;
        case 12: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(5, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget); break;
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_LRG_RED), oTarget); break;
        case 13: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget); break;
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_LRG_RED), oTarget); break;
        case 14: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(25, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget); break;
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL), oTarget); break;
        case 15: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(50, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget); break;
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL), oTarget); break;
        case 16: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oTarget)/4, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget); break;
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_LRG_RED), oTarget); break;
        case 17: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oTarget)/2, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget); break;
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_LRG_RED), oTarget); break;
        case 18: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oTarget) * 3 / 4, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget); break;
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL), oTarget); break;
        case 19: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oTarget)-1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget); break;
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL), oTarget); break;
        case 21: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_FILTH_FEVER), oTarget); break;
        case 22: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_MINDFIRE), oTarget); break;
        case 23: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_DREAD_BLISTERS), oTarget); break;
        case 24: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_SHAKES), oTarget); break;
        case 25: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_VERMIN_MADNESS), oTarget); break;
        case 26: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_DEVIL_CHILLS), oTarget); break;
        case 27: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_SLIMY_DOOM), oTarget); break;
        case 28: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_RED_ACHE), oTarget); break;
        case 29: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_ZOMBIE_CREEP), oTarget); break;
        case 31: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_BLINDING_SICKNESS), oTarget); break;
        case 32: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_CACKLE_FEVER), oTarget); break;
        case 33: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_BURROW_MAGGOTS), oTarget); break;
        case 34: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_RED_SLAAD_EGGS), oTarget); break;
        case 35: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_DEMON_FEVER), oTarget); break;
        case 36: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_GHOUL_ROT), oTarget); break;
        case 37: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_MUMMY_ROT), oTarget); break;
        case 38: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_SOLDIER_SHAKES), oTarget); break;
        case 39: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDisease(DISEASE_SOLDIER_SHAKES), oTarget); break;
        case 41: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_TINY_SPIDER_VENOM), oTarget); break;
        case 42: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_ARANEA_VENOM), oTarget); break;
        case 43: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_MEDIUM_SPIDER_VENOM), oTarget); break;
        case 44: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_CARRION_CRAWLER_BRAIN_JUICE), oTarget); break;
        case 45: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_OIL_OF_TAGGIT), oTarget); break;
        case 46: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_ARSENIC), oTarget); break;
        case 47: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_GREENBLOOD_OIL), oTarget); break;
        case 48: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_NITHARIT), oTarget); break;
        case 49: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_PHASE_SPIDER_VENOM), oTarget); break;
        case 51: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_LICH_DUST), oTarget); break;
        case 52: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_SHADOW_ESSENCE), oTarget); break;
        case 53: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_LARGE_SPIDER_VENOM), oTarget); break;
        case 54: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_PURPLE_WORM_POISON), oTarget); break;
        case 55: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_IRON_GOLEM), oTarget); break;
        case 56: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_PIT_FIEND_ICHOR), oTarget); break;
        case 57: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_WYVERN_POISON), oTarget); break;
        case 58: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_BLACK_LOTUS_EXTRACT), oTarget); break;
        case 59: ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(POISON_GARGANTUAN_SPIDER_VENOM), oTarget); break;
        case 61: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oTarget, fDuration);
                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BLIND), oTarget, fDuration); break;
        case 62: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCurse(4,4,4,4,4,4), oTarget, fDuration); break;
        case 63: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectFrightened(), oTarget, fDuration);
                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR), oTarget, fDuration); break;
        case 64: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oTarget, fDuration); break;
        case 65: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSilence(), oTarget, fDuration); break;
        case 66: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSleep(), oTarget, fDuration);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oTarget); break;
        case 67: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oTarget, fDuration); break;
        case 68: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, fDuration); break;
        case 69: ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDamage( GetCurrentHitPoints(oTarget)-1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oTarget);
                 AssignCommand( oTarget, ClearAllActions());
                 AssignCommand( oTarget, ActionPlayAnimation( ANIMATION_LOOPING_DEAD_FRONT, 1.0, 99999.0));
                 DelayCommand(0.5, SetCommandable( FALSE, oTarget)); break;
        case 71: FloatingTextStringOnCreature("You have lost 50 XP!", oTarget);
                 SetXP(oTarget, GetXP(oTarget) - 50); break;
        case 72: FloatingTextStringOnCreature("You have lost 100 XP!", oTarget);
                 SetXP(oTarget, GetXP(oTarget) - 100); break;
        case 73: FloatingTextStringOnCreature("You have lost 250 XP!", oTarget);
                 SetXP(oTarget, GetXP(oTarget) - 250); break;
        case 74: FloatingTextStringOnCreature("You have lost 500 XP!", oTarget);
                 SetXP(oTarget, GetXP(oTarget) - 500); break;
        case 75: FloatingTextStringOnCreature("You have lost 1000 XP!", oTarget);
                 SetXP(oTarget, GetXP(oTarget) - 1000); break;
        case 76: FloatingTextStringOnCreature("You have lost 2000 XP!", oTarget);
                 SetXP(oTarget, GetXP(oTarget) - 2000); break;
        case 77: FloatingTextStringOnCreature("You have lost " + IntToString(GetXP(oTarget) - ((GetHitDice(oTarget) * (GetHitDice(oTarget)-1))/2 * 1000)) + " XP!", oTarget);
                 SetXP(oTarget, ((GetHitDice(oTarget) * (GetHitDice(oTarget)-1))/2 * 1000)); break;
        case 78: FloatingTextStringOnCreature("You have lost a level!", oTarget);
                 SetXP(oTarget, ((GetHitDice(oTarget) * (GetHitDice(oTarget)-1))/2 * 1000) - (((GetHitDice(oTarget)-1)*1000)/2)); break;
        case 79: FloatingTextStringOnCreature("You have lost all of your XP!", oTarget);
                 SetXP(oTarget, 1); break;
        case 81: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_POISON) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 82: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 83: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 84: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_CURSE) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 85: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_FRIGHTENED) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 86: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_STUNNED) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 87: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_SILENCE) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 88: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 89: SetCommandable(TRUE, oTarget);
                 AssignCommand(oTarget, ClearAllActions()); break;
        case 91: SetLocalString(oUser, "EffectSetting", "EffectStunDuration");
                 CreateSetting(oUser);
        default: break;
    }
return;
}

//This function is for the DMFI Music Wand
void DoMusicFunction(int iMusic, object oUser)
{
    int iSet;
    switch(iMusic)
    {
        case 1: MusicBackgroundPlay(GetArea(oUser)); return; break;
        case 2: MusicBackgroundStop(GetArea(oUser)); DelayCommand(1.0, MusicBackgroundStop(GetArea(oUser))); return; break;
        case 31: iSet = 34; break;
        case 32: iSet = 35; break;
        case 33: iSet = 36; break;
        case 34: iSet = 37; break;
        case 35: iSet = 38; break;
        case 36: iSet = 39; break;
        case 37: iSet = 40; break;
        case 38: iSet = 41; break;
        case 39: iSet = 42; break;
        case 41: iSet = 43; break;
        case 42: iSet = 44; break;
        case 43: iSet = 45; break;
        case 44: iSet = 46; break;
        case 45: iSet = 47; break;
        case 46: iSet = 48; break;
        case 51: iSet = 15; break;
        case 52: iSet = 16; break;
        case 53: iSet = 17; break;
        case 54: iSet = 18; break;
        case 55: iSet = 19; break;
        case 56: iSet = 20; break;
        case 57: iSet = 21; break;
        case 58: iSet = 29; break;
        case 61: iSet = 22; break;
        case 62: iSet = 23; break;
        case 63: iSet = 24; break;
        case 64: iSet = 56; break;
        case 65: iSet = 25; break;
        case 66: iSet = 26; break;
        case 67: iSet = 27; break;
        case 68: iSet = 49; break;
        case 69: iSet = 50; break;
        case 71: iSet = 28; break;
        case 72: iSet = 7; break;
        case 73: iSet = 8; break;
        case 74: iSet = 9; break;
        case 75: iSet = 10; break;
        case 76: iSet = 11; break;
        case 77: iSet = 12; break;
        case 78: iSet = 13; break;
        case 79: iSet = 14; break;
        case 81: iSet = 1; break;
        case 82: iSet = 2; break;
        case 83: iSet = 3; break;
        case 84: iSet = 4; break;
        case 85: iSet = 5; break;
        case 86: iSet = 6; break;
        case 91: iSet = 30; break;
        case 92: iSet = 31; break;
        case 93: iSet = 32; break;
        case 94: iSet = 33; break;
        case 95: iSet = 51; break;
        case 96: iSet = 52; break;
        case 97: iSet = 53; break;
        case 98: iSet = 54; break;
        case 99: iSet = 55; break;
        default: break;
    }

    MusicBackgroundStop(GetArea(oUser));
    MusicBackgroundChangeDay(GetArea(oUser), iSet);
    MusicBackgroundChangeNight(GetArea(oUser), iSet);
    MusicBackgroundPlay(GetArea(oUser));
    return;
}

//This function is for the DMFI XP Wand
void DoXPFunction(int iXP, object oUser)
{
    object oTarget = GetLocalObject(oUser, "dmfi_univ_target");
    object oPartyMember;
    int iHD = GetHitDice(oUser);
    int iParty = 0;
    int iPercent = 0;
    int iReward = 0;
    int iGold = 0;
    int iValue = 0;

    if (!GetIsObjectValid(oTarget) ||
        !GetIsPC(oTarget))
    {
        FloatingTextStringOnCreature("You did not target a Player Character", oUser, FALSE);
        return;
    }
    switch(iXP)
    {
     case 11: SetLocalString(oUser, "BonusType", "small roleplaying"); iPercent = 1; break;
     case 12: SetLocalString(oUser, "BonusType", "small roleplaying"); iPercent = 2; break;
     case 13: SetLocalString(oUser, "BonusType", "small roleplaying"); iPercent = 3; break;
     case 14: SetLocalString(oUser, "BonusType", "small roleplaying"); iPercent = 4; break;
     case 15: SetLocalString(oUser, "BonusType", "small roleplaying"); iPercent = 5; break;
     case 21: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 10; break;
     case 22: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 20; break;
     case 23: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 25; break;
     case 24: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 33; break;
     case 25: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 50; break;
     case 31: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 10; iParty = 1; break;
     case 32: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 20; iParty = 1; break;
     case 33: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 25; iParty = 1; break;
     case 34: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 33; iParty = 1; break;
     case 35: SetLocalString(oUser, "BonusType", "main plot"); iPercent = 50; iParty = 1; break;
     case 41: SetLocalString(oUser, "BonusType", "best in game roleplaying"); iPercent = 2; break;
     case 42: SetLocalString(oUser, "BonusType", "best in game roleplaying"); iPercent = 5; break;
     case 43: SetLocalString(oUser, "BonusType", "best in game roleplaying"); iPercent = 10; break;
     case 44: SetLocalString(oUser, "BonusType", "best in game roleplaying"); iPercent = 20; break;
     case 45: SetLocalString(oUser, "BonusType", "best in game roleplaying"); iPercent = 25; break;
     case 51: iParty = 1; iReward = 100; break;
     case 52: iParty = 1; iReward = 250; break;
     case 53: iParty = 1; iReward = 500; break;
     case 54: iParty = 1; iReward = 1000; break;
     case 55: iParty = 1; iReward = 2000; break;
     case 61:   iHD = GetHitDice(oTarget);
                SendMessageToPC(oUser, GetName(oTarget) +" has received " + IntToString(GetLocalInt(oPartyMember, "dmfi_XPGiven")) + " XP this session.");
                SendMessageToPC(oUser, GetName(oTarget) +" currently has " + IntToString(GetXP(oTarget)) + " total XP.");
                SendMessageToPC(oUser, GetName(oTarget) +" currently needs " + IntToString(((iHD * (iHD + 1)) / 2 * 1000) - GetXP(oTarget)) + " to level.");
                SendMessageToPC(oUser, GetName(oTarget) +" has "+ IntToString(GetGold(oTarget)) + " gp.");
                SendMessageToPC(oUser, GetName(oTarget) +" has items totaling " + IntToString(DMFI_GetNetWorth(oTarget)) + " in gp value.");
                return; break;
     case 62:   oPartyMember=GetFirstFactionMember(oTarget, TRUE);
                while (GetIsObjectValid(oPartyMember)==TRUE)
                    {
                        iGold = iGold + GetGold(oPartyMember);
                        iValue = iValue + DMFI_GetNetWorth(oPartyMember);
                        SendMessageToPC(oUser, GetName(oPartyMember) +" has " + IntToString(GetXP(oPartyMember)) + " XP total.");
                        oPartyMember = GetNextFactionMember(oTarget, TRUE);
                    }
                SendMessageToPC(oUser, "The party has a total of "+ IntToString(iGold) + " gp.");
                SendMessageToPC(oUser, "The party has items totaling " + IntToString(iValue) + " in gp value.");
                return; break;
     case 63:   oPartyMember=GetFirstFactionMember(oTarget, TRUE);
                while (GetIsObjectValid(oPartyMember)==TRUE)
                {
                    SendMessageToPC(oUser, GetName(oPartyMember) +" has received " + IntToString(GetLocalInt(oPartyMember, "dmfi_XPGiven")) + " XP this session.");
                    oPartyMember = GetNextFactionMember(oTarget, TRUE);
                }
                return; break;
     case 64:   oPartyMember=GetFirstFactionMember(oTarget, TRUE);
                while (GetIsObjectValid(oPartyMember)==TRUE)
                    {
                        iHD = GetHitDice(oPartyMember);
                        SendMessageToPC(oUser, GetName(oPartyMember) + " is level " + IntToString(GetHitDice(oPartyMember)) + " and needs " + IntToString(((iHD * (iHD + 1)) / 2 * 1000) - GetXP(oPartyMember)) + " XP to level up.");
                        oPartyMember = GetNextFactionMember(oTarget, TRUE);
                    }
                return; break;
    }

    if (iParty && iReward)
    {
        oPartyMember=GetFirstFactionMember(oTarget, TRUE);
        while (GetIsObjectValid(oPartyMember)==TRUE)
        {
            GiveXPToCreature(oPartyMember, iReward);
            SetLocalInt(oPartyMember, "dmfi_XPGiven", GetLocalInt(oPartyMember, "dmfi_XPGiven") + iReward);
            SendMessageToPC(oPartyMember, "You have been granted "+ IntToString(iReward)+ " XP.");
            oPartyMember = GetNextFactionMember(oTarget, TRUE);
        }
        SendMessageToAllDMs("The entire party was granted "+ IntToString(iReward)+ " XP.");
    }
    else if (iParty)
    {
        oPartyMember=GetFirstFactionMember(oTarget, TRUE);
        while (GetIsObjectValid(oPartyMember)==TRUE)
        {
            iReward = (GetHitDice(oTarget)*iPercent*10);
            GiveXPToCreature(oPartyMember, iReward);
            SetLocalInt(oPartyMember, "dmfi_XPGiven", GetLocalInt(oPartyMember, "dmfi_XPGiven") + iReward);
            SendMessageToPC(oPartyMember, "You have been granted a "+GetLocalString(oUser, "BonusType")+ " XP reward of "+ IntToString(iReward)+ ".");
            SendMessageToAllDMs(GetName(oPartyMember) +" was granted a "+GetLocalString(oUser, "BonusType")+ " XP reward of "+ IntToString(iReward)+ ".");
            oPartyMember = GetNextFactionMember(oTarget, TRUE);
        }
    }
    else
    {
        iReward = (GetHitDice(oTarget)*iPercent*10);
        GiveXPToCreature(oTarget, iReward);
        SetLocalInt(oTarget, "dmfi_XPGiven", GetLocalInt(oTarget, "dmfi_XPGiven") + iReward);
        SendMessageToPC(oTarget, "You have been granted a "+GetLocalString(oUser, "BonusType")+ " experience reward of "+ IntToString(iReward)+ ".");
        SendMessageToAllDMs(GetName(oTarget) +" was granted a "+GetLocalString(oUser, "BonusType")+ " experience reward of "+ IntToString(iReward)+ ".");
    }
    return;
}

//This function is for the DMFI Encounter Wand
void CreateEncounter(int iEncounter, location lEncounter, object oUser)
{
    SetLocalInt(oUser, "EncounterType", iEncounter);
    switch(iEncounter)
    {
        case 11: //Animal - Low Badger Encounter
            SetLocalString(oUser, "EncounterName", "Low Badger");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BADGER", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BADGER", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BADGER", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BADGER", lEncounter, FALSE);
            break;
        case 12: //Animal - Low Canine Encounter
            SetLocalString(oUser, "EncounterName", "Low Canine");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WOLF", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WOLF", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WOLF", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WOLF", lEncounter, FALSE);
            break;
        case 13: //Animal - Low Feline Encounter
            SetLocalString(oUser, "EncounterName", "Low Feline");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_COUGAR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_COUGAR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_COUGAR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_COUGAR", lEncounter, FALSE);
            break;
        case 14: //Animal - Low Bear Encounter
            SetLocalString(oUser, "EncounterName", "Low Bear (Boss)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEARBLCK", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEARBLCK", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEARBLCK", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEARBRWN", lEncounter, FALSE);
            break;
        case 15: //Animal - Boar Encounter
            SetLocalString(oUser, "EncounterName", "Boar (Boss)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BOAR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BOAR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BOAR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BOARDIRE", lEncounter, FALSE);
            break;
        case 16: //Animal - Medium Feline Encounter
            SetLocalString(oUser, "EncounterName", "Medium Feline");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_LION", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_LION", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_LION", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_LION", lEncounter, FALSE);
            break;
        case 17: //Animal - High Canine Encounter
            SetLocalString(oUser, "EncounterName", "High Canine");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DIREWOLF", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DIREWOLF", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DIREWOLF", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DIREWOLF", lEncounter, FALSE);
            break;
        case 18: //Animal - High Feline Encounter
            SetLocalString(oUser, "EncounterName", "High Feline");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DIRETIGER", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEASTMALAR001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEASTMALAR001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEASTMALAR001", lEncounter, FALSE);
            break;
        case 19: //Animal - High Bear Encounter
            SetLocalString(oUser, "EncounterName", "High Bear");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEARDIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEARDIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEARDIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BEARDIREBOSS", lEncounter, FALSE);
            break;

        case 21: //Construct - Flesh Golem
            SetLocalString(oUser, "EncounterName", "Flesh Golem");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLFLESH", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLFLESH", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLFLESH", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLFLESH", lEncounter, FALSE);
            break;
        case 22: //Construct - Minogan
            SetLocalString(oUser, "EncounterName", "Minogon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MINOGON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MINOGON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MINOGON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MINOGON", lEncounter, FALSE);
            break;
        case 23: //Construct - Clay Golem
            SetLocalString(oUser, "EncounterName", "Clay Golem");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GolClay", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GolClay", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GolClay", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GolClay", lEncounter, FALSE);
            break;
        case 24: //Construct - Bone Golem
            SetLocalString(oUser, "EncounterName", "Bone Golem");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GolBone", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GolBone", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GolBone", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GolBone", lEncounter, FALSE);
            break;
        case 25: //Construct - Helmed Horror
            SetLocalString(oUser, "EncounterName", "Helmed Horror");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HELMHORR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HELMHORR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HELMHORR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HELMHORR", lEncounter, FALSE);
            break;
        case 26: //Construct - Stone Golem
            SetLocalString(oUser, "EncounterName", "Stone Golem");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLSTONE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLSTONE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLSTONE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLSTONE", lEncounter, FALSE);
            break;
        case 27: //Construct - Battle Horror
            SetLocalString(oUser, "EncounterName", "Battle Horror");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BATHORROR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BATHORROR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BATHORROR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BATHORROR", lEncounter, FALSE);
            break;
        case 28: //Construct - Shield Guardian
            SetLocalString(oUser, "EncounterName", "Shield Guardian");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SHGUARD", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SHGUARD", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SHGUARD", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SHGUARD", lEncounter, FALSE);
            break;
        case 29: //Construct - Iron Golem
            SetLocalString(oUser, "EncounterName", "Iron Golem");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLIRON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLIRON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLIRON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOLIRON", lEncounter, FALSE);
            break;
        case 31: //Dragon - Adult White Dragon
            SetLocalString(oUser, "EncounterName", "Adult White Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGWHITE001", lEncounter, FALSE);
            break;
        case 32: //Dragon - Adult Black Dragon
            SetLocalString(oUser, "EncounterName", "Adult Black Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGBLACK001", lEncounter, FALSE);
            break;
        case 33: //Dragon - Adult Green Dragon
            SetLocalString(oUser, "EncounterName", "Adult Green Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGGREEN001", lEncounter, FALSE);
            break;
        case 34: //Dragon - Adult Blue Dragon
            SetLocalString(oUser, "EncounterName", "Adult Blue Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGBLUE001", lEncounter, FALSE);
            break;
        case 35: //Dragon - Adult Red Dragon
            SetLocalString(oUser, "EncounterName", "Adult Red Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGRED001", lEncounter, FALSE);
            break;
        case 36: //Dragon - Old White Dragon
            SetLocalString(oUser, "EncounterName", "Old White Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGWHITE002", lEncounter, FALSE);
            break;
        case 37: //Dragon - Old Blue Dragon
            SetLocalString(oUser, "EncounterName", "Old Blue Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGBLUE002", lEncounter, FALSE);
            break;
        case 38: //Dragon - Old Red Dragon
            SetLocalString(oUser, "EncounterName", "Old Red Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGRED002", lEncounter, FALSE);
            break;
        case 39: //Dragon - Ancient Red Dragon
            SetLocalString(oUser, "EncounterName", "Ancient Red Dragon");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DRGRED003", lEncounter, FALSE);
            break;
        case 41: //Elemental - Air Elemental
            SetLocalString(oUser, "EncounterName", "Air Elemental");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIR", lEncounter, FALSE);
            break;
        case 42: //Elemental - Earth Elemental
            SetLocalString(oUser, "EncounterName", "Earth Elemental");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTH", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTH", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTH", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTH", lEncounter, FALSE);
            break;
        case 43: //Elemental - Fire Elemental
            SetLocalString(oUser, "EncounterName", "Fire Elemental");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIRE", lEncounter, FALSE);
            break;
        case 44: //Elemental - Water Elemental
            SetLocalString(oUser, "EncounterName", "Water Elemental");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATER", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATER", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATER", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATER", lEncounter, FALSE);
            break;
        case 45: //Elemental - Huge Air Elemental
            SetLocalString(oUser, "EncounterName", "Huge Air Elemental");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIRHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIRHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIRHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIRHUGE", lEncounter, FALSE);
            break;
        case 46: //Elemental - Huge Earth Elemental
            SetLocalString(oUser, "EncounterName", "Huge Earth Elemental");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTHHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTHHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTHHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTHHUGE", lEncounter, FALSE);
            break;
        case 47: //Elemental - Huge Fire Elemental
            SetLocalString(oUser, "EncounterName", "Huge Fire Elemental");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIREHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIREHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIREHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIREHUGE", lEncounter, FALSE);
            break;
        case 48: //Elemental - Huge Water Elemental
            SetLocalString(oUser, "EncounterName", "Huge Water Elemental");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATERHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATERHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATERHUGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATERHUGE", lEncounter, FALSE);
            break;
        case 49: //Elemental - Elemental Swarm
            SetLocalString(oUser, "EncounterName", "Elemental Swarm");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_AIRGREAT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_EARTHGREAT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_FIREGREAT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_WATERGREAT", lEncounter, FALSE);
            break;
        case 51: //Giant - Low Ogre
            SetLocalString(oUser, "EncounterName", "Low Ogre");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGRE01", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGRE01", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGRE02", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGRE02", lEncounter, FALSE);
            break;
        case 52: //Giant - Low Troll
            SetLocalString(oUser, "EncounterName", "Low Troll");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_TROLL", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_TROLL", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_TROLL", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_TROLL", lEncounter, FALSE);
            break;
        case 53: //Giant - High Ogre
            SetLocalString(oUser, "EncounterName", "High Ogre");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGRECHIEF01", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGRECHIEF02", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGRECHIEF01", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGREMAGE02", lEncounter, FALSE);
            break;
        case 54: //Giant - High Troll
            SetLocalString(oUser, "EncounterName", "High Troll");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_TROLLCHIEF", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_TROLLCHIEF", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_TROLLWIZ", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_TROLLWIZ", lEncounter, FALSE);
            break;
        case 55: //Giant - Ettin
            SetLocalString(oUser, "EncounterName", "Ettin");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ETTIN", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ETTIN", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ETTIN", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ETTIN", lEncounter, FALSE);
            break;
        case 56: //Giant - Hill Giant
            SetLocalString(oUser, "EncounterName", "Hill Giant");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTHILL", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTHILL", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTMOUNT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTMOUNT", lEncounter, FALSE);
            break;
        case 57: //Giant - Frost Giant
            SetLocalString(oUser, "EncounterName", "Frost Giant");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTFROST", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTFROST", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTFROST", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTFROST", lEncounter, FALSE);
            break;
        case 58: //Giant - Fire Giant
            SetLocalString(oUser, "EncounterName", "Fire Giant");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTFIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTFIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTFIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GNTFIRE", lEncounter, FALSE);
            break;
        case 59: //Giant - Ogre Mage (Boss)
            SetLocalString(oUser, "EncounterName", "Ogre Mage (Boss)");
            CreateObject(OBJECT_TYPE_CREATURE, "nw_ogreboss", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "nw_ogreboss", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGREMAGEBOSS", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OGREMAGEBOSS", lEncounter, FALSE);
            break;
        case 61: //Humanoid - Goblin
            SetLocalString(oUser, "EncounterName", "Goblin");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOBLINA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOBLINA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOBLINA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GOBLINB", lEncounter, FALSE);
            break;
        case 62: //Humanoid - Kobold
            SetLocalString(oUser, "EncounterName", "Kobold");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_KOBOLD002", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_KOBOLD002", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_KOBOLD002", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_KOBOLD001", lEncounter, FALSE);
            break;
        case 63: //Humanoid - Low Orc
            SetLocalString(oUser, "EncounterName", "Low Orc");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ORCB", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ORCA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ORCA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ORCA", lEncounter, FALSE);
            break;
        case 64: //Humanoid - High Orc (Wiz)
            SetLocalString(oUser, "EncounterName", "High Orc (Wiz)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OrcChiefA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ORCCHIEFB", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ORCCHIEFB", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ORCWIZA", lEncounter, FALSE);
            break;
        case 65: //Humanoid - Bugbear
            SetLocalString(oUser, "EncounterName", "Bugbear");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BUGBEARA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BUGBEARA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BUGBEARA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BUGBEARB", lEncounter, FALSE);
            break;
        case 66: //Humanoid - Lizardfolk
            SetLocalString(oUser, "EncounterName", "Lizardfolk");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OLDWARRA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OLDWARRA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OLDWARRA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_OLDWARB", lEncounter, FALSE);
            break;
        case 67: //Humanoid - Minotaur (Wiz)
            SetLocalString(oUser, "EncounterName", "Minotaur (Wiz)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MINOTAUR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MINOTAUR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MINOTAUR", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MINWIZ", lEncounter, FALSE);
            break;
        case 68: //Humanoid - Fey
            SetLocalString(oUser, "EncounterName", "Fey (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GRIG", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GRIG", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_PIXIE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_PIXIE", lEncounter, FALSE);
            break;
        case 69: //Humanoid -  Yuan-Ti (Mixed)
            SetLocalString(oUser, "EncounterName", "Yuan-Ti (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_YUAN_TI001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_YUAN_TI001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_YUAN_TI002", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_YUAN_TI003", lEncounter, FALSE);
            break;
        case 71: //Insects - Fire Beetle
            SetLocalString(oUser, "EncounterName", "Fire Beetle");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE", lEncounter, FALSE);
            break;
        case 72: //Insects - Spitting Fire Beetle
            SetLocalString(oUser, "EncounterName", "Spitting Fire Beetle");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE02", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE02", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE02", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE02", lEncounter, FALSE);
            break;
        case 73: //Insects - Low Beetle (Mixed)
            SetLocalString(oUser, "EncounterName", "Low Beetle (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLBOMB", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLBOMB", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLSTINK", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLFIRE02", lEncounter, FALSE);
            break;
        case 74: //Insects - Giant Spider
            SetLocalString(oUser, "EncounterName", "Giant Spider");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDGIANT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDGIANT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDGIANT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDGIANT", lEncounter, FALSE);
            break;
        case 75: //Insects - Sword Spider
            SetLocalString(oUser, "EncounterName", "Sword Spider");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDSWRD", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDSWRD", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDSWRD", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDSWRD", lEncounter, FALSE);
            break;
        case 76: //Insects - Wraith Spider
            SetLocalString(oUser, "EncounterName", "Wraith Spider");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDWRA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDWRA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDWRA", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDWRA", lEncounter, FALSE);
            break;
        case 77: //Insects - Stag Beetle
            SetLocalString(oUser, "EncounterName", "Stag Beetle");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLSTAG", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLSTAG", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLSTAG", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BTLSTAG", lEncounter, FALSE);
            break;
        case 78: //Insects - Dire Spider
            SetLocalString(oUser, "EncounterName", "Dire Spider");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDDIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDDIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDDIRE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDDIRE", lEncounter, FALSE);
            break;
        case 79: //Insects - Queen Spider
            SetLocalString(oUser, "EncounterName", "Queen Spider");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDERBOSS", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDERBOSS", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDERBOSS", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SPIDERBOSS", lEncounter, FALSE);
            break;
        case 81: //Undead - Low Zombie
            SetLocalString(oUser, "EncounterName", "Zombie");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ZOMBIE01", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ZOMBIE02", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ZOMBIE01", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ZOMBIE02", lEncounter, FALSE);
            break;
        case 82: //Undead - Low Skeleton
            SetLocalString(oUser, "EncounterName", "Low Skeleton");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SKELETON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SKELETON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SKELETON", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SKELETON", lEncounter, FALSE);
            break;
        case 83: //Undead - Ghoul
            SetLocalString(oUser, "EncounterName", "Ghoul");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GHOUL", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GHOUL", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GHOUL", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GHOUL", lEncounter, FALSE);
            break;
        case 84: //Undead - Shadow
            SetLocalString(oUser, "EncounterName", "Shadow");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SHADOW", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SHADOW", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SHADOW", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SHADOW", lEncounter, FALSE);
            break;
        case 85: //Undead - Mummy
            SetLocalString(oUser, "EncounterName", "Mummy");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MUMMY", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MUMMY", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MUMMY", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_MUMMY", lEncounter, FALSE);
            break;
        case 86: //Undead - High Skeleton
            SetLocalString(oUser, "EncounterName", "High Skeleton (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SKELWARR01", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SKELWARR02", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SKELMAGE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_SKELPRIEST", lEncounter, FALSE);
            break;
        case 87: //Undead - Curst (Mixed)
            SetLocalString(oUser, "EncounterName", "Curst (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_CURST001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_CURST002", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_CURST003", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_CURST004", lEncounter, FALSE);
            break;
        case 88: //Undead - Doom Knight
            SetLocalString(oUser, "EncounterName", "Doom Knight");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DOOMKGHT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DOOMKGHT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DOOMKGHT", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DOOMKGHT", lEncounter, FALSE);
            break;
        case 89: //Undead - Vampire (Mixed)
            SetLocalString(oUser, "EncounterName", "Vampire (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_VAMPIRE001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_VAMPIRE002", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_VAMPIRE003", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_VAMPIRE004", lEncounter, FALSE);
            break;
        case 91: //NPC - Low Gypsy
            SetLocalString(oUser, "EncounterName", "Low Gypsy");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GYPMALE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GYPMALE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GYPFEMALE", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_GYPFEMALE", lEncounter, FALSE);
            break;
        case 92: //NPC - Low Bandit
            SetLocalString(oUser, "EncounterName", "Low Bandit");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BANDIT001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BANDIT001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BANDIT001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BANDIT002", lEncounter, FALSE);
            break;
        case 93: //NPC - Medium Bandit (Mixed)
            SetLocalString(oUser, "EncounterName", "Medium Bandit (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BANDIT005", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BANDIT002", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BANDIT003", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_BANDIT004", lEncounter, FALSE);
            break;
        case 94: //NPC - Low Mercenary (Mixed)
            SetLocalString(oUser, "EncounterName", "Low Mercenary (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HUMANMERC001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HALFMERC001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DWARFMERC001", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ELFMERC001", lEncounter, FALSE);
            break;
        case 95: //NPC - Elf Ranger
            SetLocalString(oUser, "EncounterName", "Elf Ranger");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ELFRANGER005", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ELFRANGER005", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ELFRANGER005", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ELFRANGER005", lEncounter, FALSE);
            break;
        case 96: //NPC - Low Drow (Mixed)
            SetLocalString(oUser, "EncounterName", "Low Drow (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DROWFIGHT005", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DROWMAGE005", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DROWROGUE005", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DROWCLER005", lEncounter, FALSE);
            break;
        case 97: //NPC - Medium Mercenary (Mixed)
            SetLocalString(oUser, "EncounterName", "Medium Mercenary (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HUMANMERC004", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HALFMERC004", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DWARFMERC004", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ELFMERC004", lEncounter, FALSE);
            break;
        case 98: //NPC - High Drow (Mixed)
            SetLocalString(oUser, "EncounterName", "High Drow (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DROWFIGHT020", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DROWMAGE020", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DROWROGUE020", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DROWCLER020", lEncounter, FALSE);
            break;
        case 99: //NPC - High Mercenary (Mixed)
            SetLocalString(oUser, "EncounterName", "High Mercenary (Mixed)");
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HUMANMERC006", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_HALFMERC006", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_DWARFMERC006", lEncounter, FALSE);
            CreateObject(OBJECT_TYPE_CREATURE, "NW_ELFMERC006", lEncounter, FALSE);
            break;
        default:
            break;
    }
return;
}

int iDayMusic;
int iNightMusic;
int iBattleMusic;

//An FX Wand function
void FXWand_Firestorm(object oDM)
{

   // FireStorm Effect
       location lDMLoc = GetLocation ( oDM);


   // tell the DM object to rain fire and destruction
   AssignCommand ( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_METEOR_SWARM), lDMLoc));
   AssignCommand ( oDM, DelayCommand (1.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect (VFX_FNF_SCREEN_SHAKE), lDMLoc)));

   // create some fires
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
  {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lFireLoc = Location(oTargetArea, vNewVector, 0.0);
      object oFire = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lFireLoc, FALSE);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lFireLoc, FALSE);
      DelayCommand ( 10.0, DestroyObject ( oFire));
      DelayCommand ( 14.0, DestroyObject ( oDust));
   }

}

//An FX Wand function
void FXWand_Earthquake(object oDM)
{
   // Earthquake Effect by Jhenne, 06/29/02
   // declare variables used for targetting and commands.
   location lDMLoc = GetLocation ( oDM);

   // tell the DM object to shake the screen
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lDMLoc));
   AssignCommand ( oDM, DelayCommand( 2.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 3.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_SHAKE), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 4.5, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 5.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   // tell the DM object to play an earthquake sound
   AssignCommand ( oDM, PlaySound ("as_cv_boomdist1"));
   AssignCommand ( oDM, DelayCommand ( 2.0, PlaySound ("as_wt_thunderds3")));
   AssignCommand ( oDM, DelayCommand ( 4.0, PlaySound ("as_cv_boomdist1")));
   // create a dust plume at the DM and clicking location
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
   {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lDustLoc = Location(oTargetArea, vNewVector, 0.0);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lDustLoc, FALSE);
      DelayCommand ( 4.0, DestroyObject ( oDust));
   }
}

//An FX Wand function
void FXWand_Lightning(object oDM)
{
   // Lightning Strike by Jhenne. 06/29/02
   location lDMLoc = GetLocation ( oDM);
   // tell the DM object to create a Lightning visual effect at targetted location
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), lDMLoc));
   // tell the DM object to play a thunderclap
   AssignCommand ( oDM, PlaySound ("as_wt_thundercl3"));
   // create a scorch mark where the lightning hit
   object oScorch = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_weathmark", lDMLoc, FALSE);
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 5; nCount++)
   {
      nXPos = Random(10) - 5;
      nYPos = Random(10) - 5;

      vector vNewVector = GetPositionFromLocation(lDMLoc);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lNewLoc = Location(oTargetArea, vNewVector, 0.0);
      AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S), lNewLoc));
   }
   DelayCommand ( 20.0, DestroyObject ( oScorch));
}

//This function is for the DMFI FX Wand
void CreateEffects(int iEffect, location lEffect, object oUser)
{
    float fDuration;
    float fDelay;
    float fBeamDuration;
    object oTarget;
    if (GetLocalFloat(oUser, "EffectDuration") == 0.0f)
        fDuration = 60.0f;
    else
        fDuration = GetLocalFloat(oUser, "EffectDuration");

    if (GetLocalFloat(oUser, "EffectDelay") == 0.0f)
        fDelay = 5.0f;
    else
        fDelay = GetLocalFloat(oUser, "EffectDelay");

    if (GetLocalFloat(oUser, "EffectBeamDuration") == 0.0f)
        fBeamDuration = 5.0f;
    else
        fBeamDuration =  GetLocalFloat(oUser, "EffectBeamDuration");

    if (!GetIsObjectValid(GetLocalObject(oUser, "dmfi_univ_target")))
        oTarget = oUser;
    else
        oTarget = GetLocalObject(oUser, "dmfi_univ_target");
    switch(iEffect)
    {
        //Magical Duration Effects
        case 11: ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_TENTACLE),lEffect, fDuration); break;
        case 12: ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_WEB_MASS),lEffect, fDuration); break;
        case 13: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND),lEffect); break;
        case 14: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_HOLY_30),lEffect, fDuration); break;
        case 15: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_EVIL_30),lEffect, fDuration); break;
        case 16: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF),lEffect, fDuration); break;
        case 17: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY),lEffect, fDuration); break;
        case 18: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lEffect, fDuration); break;
        case 19: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_IMPLOSION),lEffect, fDuration); break;
        //Magical Status Effects (must have a target)
        case 21: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_BARKSKIN), oTarget, fDuration); break;
        case 22: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN), oTarget, fDuration); break;
        case 23: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ENTANGLE), oTarget, fDuration); break;
        case 24: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE), oTarget, fDuration); break;
        case 25: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), oTarget, fDuration); break;
        case 26: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_INVISIBILITY), oTarget, fDuration); break;
        case 27: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), oTarget, fDuration); break;
        case 28: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY), oTarget, fDuration); break;
        case 29: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BLIND), oTarget, fDuration); break;
        //Magical Burst Effects
        case 31: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL),lEffect); break;
        case 32: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIRESTORM),lEffect); break;
        case 33: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_HORRID_WILTING),lEffect); break;
        case 34: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_METEOR_SWARM),lEffect); break;
        case 35: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP),lEffect); break;
        case 36: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SOUND_BURST),lEffect); break;
        case 37: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_STRIKE_HOLY),lEffect); break;
        case 38: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES),lEffect); break;
        case 39: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD),lEffect); break;
        //Lighting Effects
        case 41: ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BLACKOUT),lEffect, fDuration); break;
        case 42: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10),oTarget, fDuration); break;
        case 43: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_BLUE_20),oTarget, fDuration); break;
        case 44: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_GREY_20),oTarget, fDuration); break;
        case 45: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_20),oTarget, fDuration); break;
        case 46: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_PURPLE_20),oTarget, fDuration); break;
        case 47: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_20),oTarget, fDuration); break;
        case 48: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20),oTarget, fDuration); break;
        case 49: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20),oTarget, fDuration); break;
        //Beam Effects
        case 51: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_COLD, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
        case 52: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_EVIL, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
        case 53: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_FIRE, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
        case 54: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_FIRE_LASH, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
        case 55: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_HOLY, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
        case 56: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
        case 57: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_MIND, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
        case 58: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_ODD, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
        case 59: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_COLD, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_EVIL, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_FIRE, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_FIRE_LASH, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_HOLY, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_MIND, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_ODD, oUser, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;

        //Environmental Effects
        case 61: FXWand_Lightning(oTarget); break;
        case 62: FXWand_Firestorm(oTarget); break;
        case 63: FXWand_Earthquake(oTarget); break;
        case 64: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ICESTORM),lEffect); break;
        case 65: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUNBEAM),lEffect); break;
        case 66: SetWeather(GetArea(oUser), WEATHER_CLEAR); break;
        case 67: SetWeather(GetArea(oUser), WEATHER_RAIN); break;
        case 68: SetWeather(GetArea(oUser), WEATHER_SNOW); break;
        case 69: SetWeather(GetArea(oUser), WEATHER_USE_AREA_SETTINGS); break;
        //Summon Effects
        case 71: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1),lEffect); break;
        case 72: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2),lEffect); break;
        case 73: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3),lEffect); break;
        case 74: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL),lEffect); break;
        case 75: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE),lEffect); break;
        case 76: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD),lEffect); break;
        case 77: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_NATURES_BALANCE),lEffect); break;
        case 78: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL),lEffect); break;
        case 79: ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD),lEffect); break;
        //Delayed Effects
        case 81: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL),lEffect, fDuration)); break;
        case 82: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE),lEffect, fDuration)); break;
        case 83: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_NATURES_BALANCE),lEffect, fDuration)); break;
        case 84: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_METEOR_SWARM),lEffect, fDuration)); break;
        case 85: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND),lEffect, fDuration)); break;
        case 86: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lEffect, fDuration)); break;
        case 87: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_HORRID_WILTING),lEffect, fDuration)); break;
        case 88: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL),lEffect, fDuration)); break;
        case 89: DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD),lEffect, fDuration)); break;
        //Settings
        case 91:
        SetLocalString(oUser, "EffectSetting", "EffectDuration");
        CreateSetting(oUser);
        break;
        case 92:
        SetLocalString(oUser, "EffectSetting", "EffectDelay");
        CreateSetting(oUser);
        break;
        case 93:
        SetLocalString(oUser, "EffectSetting", "EffectBeamDuration");
        CreateSetting(oUser);
        break;
        case 94: //Change Day Music
        iDayMusic = MusicBackgroundGetDayTrack(GetArea(oUser)) + 1;
        if (iDayMusic > 33) iDayMusic = 49;
        if (iDayMusic > 55) iDayMusic = 1;
        MusicBackgroundStop(GetArea(oUser));
        MusicBackgroundChangeDay(GetArea(oUser), iDayMusic);
        MusicBackgroundPlay(GetArea(oUser));
        break;
        case 95: //Change Night Music
        iNightMusic = MusicBackgroundGetDayTrack(GetArea(oUser)) + 1;
        if (iNightMusic > 33) iNightMusic = 49;
        if (iNightMusic > 55) iNightMusic = 1;
        MusicBackgroundStop(GetArea(oUser));
        MusicBackgroundChangeNight(GetArea(oUser), iNightMusic);
        MusicBackgroundPlay(GetArea(oUser));
        break;
        case 96: //Play Background Music
        MusicBackgroundPlay(GetArea(oUser));
        break;
        case 97: //Stop Background Music
        MusicBackgroundStop(GetArea(oUser));
        break;
        case 98: //Change and Play Battle Music
        iBattleMusic = MusicBackgroundGetBattleTrack(GetArea(oUser)) + 1;
        if (iBattleMusic < 34 || iBattleMusic > 48) iBattleMusic = 34;
        MusicBattleStop(GetArea(oUser));
        MusicBattleChange(GetArea(oUser), iBattleMusic);
        MusicBattlePlay(GetArea(oUser));
        break;
        case 99: //Stop Battle Music
        MusicBattleStop(GetArea(oUser));
        break;

        default: break;
    }
    DeleteLocalObject(oUser, "EffectTarget");
return;
}

void EmoteDance(object oPC)
{
object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
object oLeftHand =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

AssignCommand(oPC,ActionUnequipItem(oRightHand));
AssignCommand(oPC,ActionUnequipItem(oLeftHand));

AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));
AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 2.0, 2.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY1,1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY3,2.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_GET_MID, 3.0, 1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_FORCEFUL,1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));
AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 2.0, 2.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY1,1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY3,2.0));
AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_GET_MID, 3.0, 1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));

AssignCommand(oPC,ActionDoCommand(ActionEquipItem(oLeftHand,INVENTORY_SLOT_LEFTHAND)));
AssignCommand(oPC,ActionDoCommand(ActionEquipItem(oRightHand,INVENTORY_SLOT_RIGHTHAND)));
}

void SitInNearestChair(object oPC)
{
object oSit,oRightHand,oLeftHand,oChair,oCouch,oBenchPew,oStool;
float fDistSit;int nth;
// get the closest chair, couch bench or stool
   nth = 1;oChair = GetNearestObjectByTag("Chair", oPC,nth);
   while(oChair != OBJECT_INVALID &&  GetSittingCreature(oChair) != OBJECT_INVALID)
   {nth++;oChair = GetNearestObjectByTag("Chair", oPC,nth);}

   nth = 1;oCouch = GetNearestObjectByTag("Couch", oPC,nth);
   while(oCouch != OBJECT_INVALID && GetSittingCreature(oCouch) != OBJECT_INVALID)
      {nth++;oChair = GetNearestObjectByTag("Couch", oPC,nth);}

   nth = 1;oBenchPew = GetNearestObjectByTag("BenchPew", oPC,nth);
   while(oBenchPew != OBJECT_INVALID && GetSittingCreature(oBenchPew) != OBJECT_INVALID)
      {nth++;oChair = GetNearestObjectByTag("BenchPew", oPC,nth);}
/* 1.27 bug
   nth = 1;oStool = GetNearestObjectByTag("Stool", oPC,nth);
   while(oStool != OBJECT_INVALID && GetSittingCreature(oStool) != OBJECT_INVALID)
      {nth++;oStool = GetNearestObjectByTag("Stool", oPC,nth);}
*/
// get the distance between the user and each object (-1.0 is the result if no
// object is found
float fDistanceChair = GetDistanceToObject(oChair);
float fDistanceBench = GetDistanceToObject(oBenchPew);
float fDistanceCouch = GetDistanceToObject(oCouch);
float fDistanceStool = GetDistanceToObject(oStool);

// if any of the objects are invalid (not there), change the return value
// to a high number so the distance math can work
if (fDistanceChair == -1.0)
{fDistanceChair =1000.0;}

if (fDistanceBench == -1.0)
{fDistanceBench = 1000.0;}

if (fDistanceCouch == -1.0)
{fDistanceCouch = 1000.0;}

if (fDistanceStool == -1.0)
{fDistanceStool = 1000.0;}

// find out which object is closest to the PC
if (fDistanceChair<fDistanceBench && fDistanceChair<fDistanceCouch && fDistanceChair<fDistanceStool)
{oSit=oChair;fDistSit=fDistanceChair;}
else
if (fDistanceBench<fDistanceChair && fDistanceBench<fDistanceCouch && fDistanceBench<fDistanceStool)
{oSit=oBenchPew;fDistSit=fDistanceBench;}
else
if (fDistanceCouch<fDistanceChair && fDistanceCouch<fDistanceBench && fDistanceCouch<fDistanceStool)
{oSit=oCouch;fDistSit=fDistanceCouch;}
else
//if (fDistanceStool<fDistanceChair && fDistanceStool<fDistanceBench && fDistanceStool<fDistanceCouch)
{oSit=oStool;fDistSit=fDistanceStool;}

 if(oSit !=  OBJECT_INVALID && fDistSit < 12.0)
    {
     // if no one is sitting in the object the PC is closest to, have him sit in it
     if (GetSittingCreature(oSit) == OBJECT_INVALID)
         {
           oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
           oLeftHand =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
           AssignCommand(oPC,ActionMoveToObject(oSit,FALSE,2.0)); //:: Presumably this will be fixed in a patch so that Plares will not run to chair
           ActionUnequipItem(oRightHand); //:: Added to resolve clipping issues when seated
           ActionUnequipItem(oLeftHand);  //:: Added to resolve clipping issues when seated
           ActionDoCommand(AssignCommand(oPC,ActionSit(oSit)));

        }
      else
        {SendMessageToPC(oPC,"The nearest chair is already taken ");}
    }
  else
    {SendMessageToPC(oPC,"There are no chairs nearby");}
}

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

//This function is for the DMFI Emote Wand
void DoEmoteFunction(int iEmote, object oUser)
{
    object oTarget = GetLocalObject(oUser, "dmfi_univ_target");
    if (!GetIsObjectValid(oTarget))
        oTarget = oUser;
    float fDur = 9999.0f; //Duration

    switch(iEmote)
    {
        case 1: AssignCommand(oTarget, PlayAnimation( ANIMATION_FIREFORGET_DRINK, 1.0)); break;
        case 2: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, fDur)); break;
        case 3: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_DEAD_FRONT, 1.0, fDur)); break;
        case 4: AssignCommand(oTarget, ActionForceMoveToObject(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget), TRUE, 2.0f, fDur)); break;
        case 5: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_MEDITATE, 1.0, fDur)); break;
        case 6: AssignCommand(oTarget, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0)); DelayCommand(3.0f, AssignCommand(oTarget, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0)));break;
        case 7: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)); break;
        case 8: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_WORSHIP, 1.0, fDur)); break;
        case 10: if (!GetLocalInt(oTarget, "hls_emotemute")) FloatingTextStringOnCreature("*emote* commands are off", oTarget, FALSE);
                 else FloatingTextStringOnCreature("*emote* commands are on", oTarget, FALSE);
                 SetLocalInt(oTarget, "hls_emote_mute", abs(GetLocalInt(oTarget, "hls_emotemute") - 1)); break;
        case 91: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_TALK_PLEADING, 1.0, fDur)); break;
        case 92: EmoteDance(oTarget); break;
        case 93: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_GET_LOW, 1.0, fDur)); break;
        case 94: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_GET_MID, 1.0, fDur)); break;
        case 95: SitInNearestChair(oTarget); break;
        case 96: AssignCommand(oTarget, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)); DelayCommand(1.0f, AssignCommand(oTarget, PlayAnimation( ANIMATION_FIREFORGET_DRINK, 1.0))); DelayCommand(3.0f, AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)));break;
        case 97: AssignCommand(oTarget, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)); DelayCommand(1.0f, AssignCommand(oTarget, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0))); DelayCommand(3.0f, AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)));break;
        case 98: SmokePipe(oTarget); break;
        case 99: AssignCommand(oTarget, PlayAnimation( ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, fDur)); break;
        default: break;
    }
}

void main()
{
    string sDMFI = GetLocalString(OBJECT_SELF, "dmfi_univ_conv");
    int iDMFI = GetLocalInt(OBJECT_SELF, "dmfi_univ_int");
    location lDMFI = GetLocalLocation(OBJECT_SELF, "dmfi_univ_location");
    if (sDMFI == "emote" || sDMFI == "pc_emote")
        DoEmoteFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "fx")
        CreateEffects(iDMFI, lDMFI, OBJECT_SELF);
    else if (sDMFI == "encounter")
        CreateEncounter(iDMFI, lDMFI, OBJECT_SELF);
    else if (sDMFI == "music")
        DoMusicFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "xp")
        DoXPFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "dmw")
        dmwand_DoDialogChoice(iDMFI);
    else if (sDMFI == "afflict")
        DoAfflictFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "voice")
        DoVoiceFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "sound")
        DoSoundFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "onering")
        DoOneRingFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "dicebag")
        DoDMDiceBagFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "pc_dicebag")
        DoDiceBagFunction(iDMFI, OBJECT_SELF);
    else if (sDMFI == "faction")
        DoControlFunction(iDMFI, OBJECT_SELF);
    DeleteLocalInt(OBJECT_SELF,"Tens");
}
