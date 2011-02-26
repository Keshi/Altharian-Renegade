//::///////////////////////////////////////////////
//:: Debug Command include
//:: prc_inc_chat_dbg
//::///////////////////////////////////////////////

#include "prc_alterations"
#include "prc_inc_chat"
#include "prc_inc_shifting" //For _prc_inc_EffectString, etc.
#include "prc_inc_util"

const string CMD_EXECUTE = "exec-ute";
const string CMD_VARIABLE = "var-iable";
    const string CMD_LOCAL = "loc-al";
    const string CMD_PERSISTANT = "per-sistant";

const string CMD_INFORMATION = "info-rmation";
const string CMD_ABILITIES = "abil-ities";
const string CMD_EFFECTS = "eff-ects";
const string CMD_PROPERTIES = "prop-erties";
const string CMD_SKILLS = "skil-ls";

const string CMD_CHANGE = "change";
    const string CMD_ABILITY = "abil-ity";
        const string CMD_STR = "str-ength";
        const string CMD_DEX = "dex-terity";
        const string CMD_CON = "con-stitution";
        const string CMD_INT = "int-elligence";
        const string CMD_WIS = "wis-dom";
        const string CMD_CHA = "cha-risma";
    const string CMD_LEVEL = "level";
    const string CMD_XP = "xp";
    const string CMD_GOLD = "gold";
    const string CMD_BY = "by";
    const string CMD_TO = "to";

const string CMD_SPAWN = "spawn";
    const string CMD_CREATURE = "creature";
    const string CMD_ITEM = "item";

const string CMD_RELEVEL = "relevel";

const string CMD_SPECIAL = "special";
    const string CMD_REST = "rest";
    const string CMD_HANDLE_FORCE_REST_1 = "handle";
    const string CMD_HANDLE_FORCE_REST_2 = "force-d";
    const string CMD_HANDLE_FORCE_REST_3 = "rest-ing";

int Debug_ProcessChatCommand_Help(object oPC, string sCommand)
{
    string sCommandName = GetStringWord(sCommand, 2);
    int nLevel = (sCommandName == "") ? 1 : 2;
    int bResult = FALSE;
    
    if (nLevel == 1)
    {
        DoDebug("=== DEBUG COMMANDS");
        DoDebug("");
    }

    if(GetStringMatchesAbbreviation(sCommandName, CMD_EXECUTE) || nLevel == 1)
    {
        if (nLevel > 1)
        {
            bResult = TRUE;
            DoDebug("=== DEBUG COMMAND: " + CMD_EXECUTE);
            DoDebug("");
        }

        DoDebug("~~" + CMD_EXECUTE + " <script-name>     (requires DEBUG = TRUE)");
        DoDebug("");
    }

    if(GetStringMatchesAbbreviation(sCommandName, CMD_VARIABLE) || nLevel == 1)
    {
        if (nLevel > 1)
        {
            bResult = TRUE;
            DoDebug("=== DEBUG COMMAND: " + CMD_VARIABLE);
            DoDebug("");
        }

        DoDebug("~~" + CMD_VARIABLE + " " + CMD_LOCAL + " <type> get <varname>     (requires DEBUG = TRUE)");
        if (nLevel > 1)
            DoDebug("   Print the value of the specified local variable");
        DoDebug("~~" + CMD_VARIABLE + " " + CMD_LOCAL + " <type> set <varname> <value>     (requires DEBUG = TRUE)");
        if (nLevel > 1)
            DoDebug("   Set the value of the specified local variable and print the old value");
        if (nLevel > 1)
            DoDebug("<type> can be (ONE:int|string)");
        DoDebug("");

        DoDebug("~~" + CMD_VARIABLE + " " + CMD_PERSISTANT + " <type> get <varname>     (requires DEBUG = TRUE)");
        if (nLevel > 1)
            DoDebug("   Print the value of the specified persistant variable");
        DoDebug("~~" + CMD_VARIABLE + " " + CMD_PERSISTANT + " <type> set <varname> <value>     (requires DEBUG = TRUE)");
        if (nLevel > 1)
            DoDebug("   Set the value of the specified persistant variable and print the old value");
        if (nLevel > 1)
            DoDebug("<type> can be (ONE:int|string)");
        DoDebug("");
    }
        
    if(GetStringMatchesAbbreviation(sCommandName, CMD_INFORMATION) || nLevel == 1)
    {
        if (nLevel > 1)
        {
            bResult = TRUE;
            DoDebug("=== DEBUG COMMAND: " + CMD_INFORMATION);
            DoDebug("");
        }

        DoDebug("~~" + CMD_INFORMATION + " " + CMD_ABILITIES);
        if (nLevel > 1)
            DoDebug("   Print the STR, DEX, CON, INT, WIS, and CHA of the PC");
        DoDebug("~~" + CMD_INFORMATION + " " + CMD_EFFECTS);
        if (nLevel > 1)
            DoDebug("   Print all effects that have been applied to the PC");
        DoDebug("~~" + CMD_INFORMATION + " " + CMD_PROPERTIES);
        if (nLevel > 1)
            DoDebug("   Print the item properties of all items the PC has equipped");
        DoDebug("~~" + CMD_INFORMATION + " " + CMD_SKILLS);
        if (nLevel > 1)
            DoDebug("   Print the number of ranks that the PC has in each skill");
        DoDebug("");
    }
            
    if(GetStringMatchesAbbreviation(sCommandName, CMD_CHANGE) || nLevel == 1)
    {
        if (nLevel > 1)
        {
            bResult = TRUE;
            DoDebug("=== DEBUG COMMAND: " + CMD_CHANGE + " <what> <ONE:to|by> <value>");
            DoDebug("");
        }

        DoDebug("~~" + CMD_CHANGE + " " + CMD_LEVEL + " " + CMD_TO + " <value>     (requires DEBUG = TRUE)");
        DoDebug("~~" + CMD_CHANGE + " " + CMD_LEVEL + " " + CMD_BY + " <amount>     (requires DEBUG = TRUE)");
        if (nLevel > 1)
        {
            DoDebug("   Adjust the PC's level as specified (must be 1-40)");
        }
        DoDebug("");

        DoDebug("~~" + CMD_CHANGE + " " + CMD_XP + " " + CMD_TO + " <value>     (requires DEBUG = TRUE)");
        DoDebug("~~" + CMD_CHANGE + " " + CMD_XP + " " + CMD_BY + " <amount>     (requires DEBUG = TRUE)");
        if (nLevel > 1)
        {
            DoDebug("   Adjust the PC's XP as specified");
        }
        DoDebug("");

        DoDebug("~~" + CMD_CHANGE + " " + CMD_GOLD + " " + CMD_TO + " <value>     (requires DEBUG = TRUE)");
        DoDebug("~~" + CMD_CHANGE + " " + CMD_GOLD + " " + CMD_BY + " <amount>     (requires DEBUG = TRUE)");
        if (nLevel > 1)
        {
            DoDebug("   Adjust the PC's gold as specified");
        }
        DoDebug("");
    
        DoDebug("~~" + CMD_CHANGE + " " + CMD_ABILITY + " <ability-name> " + CMD_TO + " <value>     (requires NWNX funcs; requires DEBUG = TRUE)");
        DoDebug("~~" + CMD_CHANGE + " " + CMD_ABILITY + " <ability-name> " + CMD_BY + " <value>     (requires NWNX funcs; requires DEBUG = TRUE)");
        if (nLevel > 1)
        {
            DoDebug("   Adjust the PC's abilities as specified");
            DoDebug("   <ability-name> can be: " + CMD_STR + ", " + CMD_DEX + ", " + CMD_CON + ", " + CMD_INT + ", " + CMD_WIS + ", or " + CMD_CHA);
        }
        DoDebug("");
    }

    if(GetStringMatchesAbbreviation(sCommandName, CMD_SPAWN) || nLevel == 1)
    {
        if (nLevel > 1)
        {
            bResult = TRUE;
            DoDebug("=== DEBUG COMMAND: " + CMD_SPAWN);
            DoDebug("");
        }

        DoDebug("~~" + CMD_SPAWN + " " + CMD_CREATURE + " <resref>");
        if (nLevel > 1)
        {
            DoDebug("   Spawn the specified creature in the same location as the PC.");
            DoDebug("   It will be treated as a summoned creature--i.e., under the PC's control.");
        }

        DoDebug("~~" + CMD_SPAWN + " " + CMD_ITEM + " <resref>");
        if (nLevel > 1)
        {
            DoDebug("   Spawn the specified item in the same location as the PC");
        }
        
        DoDebug("");
    }

    if(GetStringMatchesAbbreviation(sCommandName, CMD_RELEVEL) || nLevel == 1)
    {
        if (nLevel > 1)
        {
            bResult = TRUE;
            DoDebug("=== DEBUG COMMAND: " + CMD_RELEVEL + " <level>");
            DoDebug("");
        }

        DoDebug("~~" + CMD_RELEVEL + " <level>");
        if (nLevel > 1)
        {
            DoDebug("   Relevel the PC starting from the specified level.");
            DoDebug("   The final result is a PC with exactly the same XP as before,");
            DoDebug("   but with the feats, skills, etc. reselected starting with the specified level.");
        }
        DoDebug("");
    }
        
    if(GetStringMatchesAbbreviation(sCommandName, CMD_SPECIAL) || nLevel == 1)
    {
        if (nLevel > 1)
        {
            bResult = TRUE;
            DoDebug("=== DEBUG COMMAND: " + CMD_SPECIAL);
            DoDebug("");
        }

        DoDebug("~~" + CMD_SPECIAL + " " + CMD_REST);
        if (nLevel > 1)
        {
            DoDebug("   Instantly rest the PC     (requires DEBUG = TRUE).");
        }

        DoDebug("~~" + CMD_SPECIAL + " " + CMD_HANDLE_FORCE_REST_1 + " " + CMD_HANDLE_FORCE_REST_2 + " " + CMD_HANDLE_FORCE_REST_3);
        if (nLevel > 1)
        {
            DoDebug("   Tell PRC that the module force rests PCs.");
            DoDebug("   Forced resting restores feat uses and spell uses for Bioware spellbooks,");
            DoDebug("   but does not restore spell uses for PRC conversation-based spellbooks,");
            DoDebug("   and may cause problems with some other PRC features.");
            DoDebug("   Start a detector that detects forced resting and fixes");
            DoDebug("   these issues automatically.");
        }
        DoDebug("");
    }
    
    return bResult;
}

void _prc_inc_DoLocalVar(object oPC, string sCommand)
{
    string sCommandName = GetStringWord(sCommand, 4);
    if (sCommandName != "get" && sCommandName != "set")
    {
        DoDebug("Unrecognized command (expected 'get' or 'set'): " + sCommandName);
        return;
    }

    string sVarName = GetStringWord(sCommand, 5);
    if (sVarName == "")
    {
        DoDebug("Invalid variable name: '" + sCommandName + "'");
        return;
    }
    
    string sDataType = GetStringWord(sCommand, 3);
    string sVarValue = GetStringWord(sCommand, 6);

    if (sDataType == "string")
    {
        string sValue = GetLocalString(oPC, sVarName);
        DoDebug("Value: '" + sValue + "'");
        if (sCommandName == "set")
        {
            SetLocalString(oPC, sVarName, sVarValue);
            DoDebug("New Value: '" + sVarValue + "'");
        }
    }
    else if (sDataType == "int")
    {
        int nValue = GetLocalInt(oPC, sVarName);
        DoDebug("Value: " + IntToString(nValue));
        if (sCommandName == "set")
        {
            int nVarValue = StringToInt(sVarValue);
            if (sVarValue == IntToString(nVarValue))
            {
                SetLocalInt(oPC, sVarName, nVarValue);
                DoDebug("New Value: " + sVarValue);
            }
            else
                DoDebug("Can't set integer variable to non-integer value: " +sVarValue);
        }
    }
    else
    {
        DoDebug("Unrecognized varget data type: " + sDataType);
    }
}

void _prc_inc_DumpItemProperty(string sPrefix, itemproperty iProp)
{
    int nDurationType = GetItemPropertyDurationType(iProp);
    string sPropString = _prc_inc_ItemPropertyString(iProp);
    if(sPropString != "")
    {
        if (nDurationType == DURATION_TYPE_TEMPORARY)
            sPropString = GetStringByStrRef(57473+0x01000000) + sPropString; //"TEMPORARY: "
        DoDebug(sPrefix + sPropString);
    }
}

void _prc_inc_DumpAllItemProperties(string sPrefix, object oItem)
{
    if(GetIsObjectValid(oItem))
    {
        itemproperty iProp = GetFirstItemProperty(oItem);
        while(GetIsItemPropertyValid(iProp))
        {
            _prc_inc_DumpItemProperty(sPrefix, iProp);
            iProp = GetNextItemProperty(oItem);
        }
    }
}

int _prc_inc_XPToLevel(int nXP)
{
    float fXP = IntToFloat(nXP);
    float fLevel = (sqrt(8 * fXP / 1000 + 1) + 1) / 2;
    return FloatToInt(fLevel);
}

int _prc_inc_LevelToXP(int nLevel)
{
    return (nLevel * (nLevel - 1)) * 500;
}

void _prc_inc_DoPersistantVar(object oPC, string sCommand)
{
    string sCommandName = GetStringWord(sCommand, 4);
    if (sCommandName != "get" && sCommandName != "set")
    {
        DoDebug("Unrecognized command (expected 'get' or 'set'): " + sCommandName);
        return;
    }

    string sVarName = GetStringWord(sCommand, 5);
    if (sVarName == "")
    {
        DoDebug("Invalid variable name: '" + sCommandName + "'");
        return;
    }
    
    string sDataType = GetStringWord(sCommand, 3);
    string sVarValue = GetStringWord(sCommand, 6);

    if (sDataType == "string")
    {
        string sValue = GetPersistantLocalString(oPC, sVarName);
        DoDebug("Value: '" + sValue + "'");
        if (sCommandName == "set")
            SetPersistantLocalString(oPC, sVarName, sVarValue);
    }
    else if (sDataType == "int")
    {
        int nValue = GetPersistantLocalInt(oPC, sVarName);
        DoDebug("Value: " + IntToString(nValue));
        if (sCommandName == "set")
        {
            int nVarValue = StringToInt(sVarValue);
            if (sVarValue == IntToString(nVarValue))
                SetPersistantLocalInt(oPC, sVarName, nVarValue);
            else
                DoDebug("Can't set integer variable to non-integer value: " +sVarValue);
        }
    }
    else
    {
        DoDebug("Unrecognized varget data type: " + sDataType);
    }
}

void DoPrintSummon(object oPC, string sResRef)
{
    object oCreature = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if (GetIsObjectValid(oCreature))
        DoDebug("Created creature: " + GetName(oCreature));
    else
        DoDebug("Failed to create creature--invalid resref?: " + sResRef);
}

void DoSummon(object oPC, string sResRef)
{
    effect eSummon = EffectSummonCreature(sResRef);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSummon, GetLocation(oPC));
    AssignCommand(oPC, DoPrintSummon(oPC, sResRef));
}

int Debug_ProcessChatCommand(object oPC, string sCommand)
{
    string sCommandName = GetStringWord(sCommand, 1);
    int bResult = FALSE;
    
    //Handle the commands we recognize no matter what, but only execute them if DEBUG is TRUE
    if(GetStringMatchesAbbreviation(sCommandName, CMD_EXECUTE))
    {
        bResult = TRUE;
        if (DEBUG)
        {
            string sScript = GetStringWord(sCommand, 2);
            DoDebug("Executing script: " + sScript);
            ExecuteScript(sScript, oPC);
        }
        else
            DoDebug("This command only works if DEBUG = TRUE");
        
    }
    else if (GetStringMatchesAbbreviation(sCommandName, CMD_VARIABLE))
    {
        bResult = TRUE;
        string sVarType = GetStringWord(sCommand, 2);
        if(GetStringMatchesAbbreviation(sVarType, CMD_LOCAL))
        {
            if (DEBUG)
                _prc_inc_DoLocalVar(oPC, sCommand);
            else
                DoDebug("This command only works if DEBUG = TRUE");
        }
        else if(GetStringMatchesAbbreviation(sVarType, CMD_PERSISTANT))
        {
            if (DEBUG)
                _prc_inc_DoPersistantVar(oPC, sCommand);
            else
                DoDebug("This command only works if DEBUG = TRUE");
        }
        else
        {
            DoDebug("Unrecognized varget variable type: " + sVarType);
        }
    }
    else if(GetStringMatchesAbbreviation(sCommandName, CMD_INFORMATION))
    {
        bResult = TRUE;
        string sInfoType = GetStringWord(sCommand, 2);
        if (GetStringMatchesAbbreviation(sInfoType, CMD_ABILITIES))
        {
            DoDebug("====== ABILITIES ======");
            DoDebug("=== The first number is the base score; the second is the modified score, which includes bonuses and penalties from gear, etc.");
            DoDebug("=== STR: " + IntToString(GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE)) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_STRENGTH, FALSE)));
            DoDebug("=== DEX: " + IntToString(GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE)) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE)));
            DoDebug("=== CON: " + IntToString(GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE)));
            DoDebug("=== INT: " + IntToString(GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE)) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE)));
            DoDebug("=== WIS: " + IntToString(GetAbilityScore(oPC, ABILITY_WISDOM, TRUE)) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_WISDOM, FALSE)));
            DoDebug("=== CHA: " + IntToString(GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE)) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE)));
            if (GetPersistantLocalInt(oPC, SHIFTER_ISSHIFTED_MARKER) && GetPRCSwitch(PRC_NWNX_FUNCS))
            {
                int iSTR = GetPersistantLocalInt(oPC, "Shifting_NWNXSTRAdjust");
                int iDEX = GetPersistantLocalInt(oPC, "Shifting_NWNXDEXAdjust");
                int iCON = GetPersistantLocalInt(oPC, "Shifting_NWNXCONAdjust");
                DoDebug("=== The first number is the base score when unshifted; the second is the modified score when unshifted.");
                DoDebug("=== STR: " + IntToString(GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE)-iSTR) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_STRENGTH, FALSE)-iSTR));
                DoDebug("=== DEX: " + IntToString(GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE)-iDEX) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE)-iDEX));
                DoDebug("=== CON: " + IntToString(GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)-iCON) + " / " + IntToString(GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE)-iCON));
            }
        }
        else if (GetStringMatchesAbbreviation(sInfoType, CMD_EFFECTS))
        {
            DoDebug("====== EFFECTS ======");
            effect eEffect = GetFirstEffect(oPC);
            while(GetIsEffectValid(eEffect))
            {
                if (GetEffectType(eEffect) == EFFECT_TYPE_INVALIDEFFECT)
                {
                    //An effect with type EFFECT_TYPE_INVALID is added for each item property
                    //They are also added for a couple of other things (Knockdown, summons, etc.)
                    //Just skip these
                }
                else
                {
                    string sEffectString = _prc_inc_EffectString(eEffect);
                    if(sEffectString != "")
                        DoDebug("=== " + sEffectString);
                }    
                eEffect = GetNextEffect(oPC);
            }
        }
        else if (GetStringMatchesAbbreviation(sInfoType, CMD_PROPERTIES))
        {
            DoDebug("====== PROPERTIES ======");
            DoDebug("====== CREATURE");
            _prc_inc_DumpAllItemProperties("=== ", oPC);
            DoDebug("====== CREATURE HIDE");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC));
            DoDebug("====== RIGHT CREATURE WEAPON");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC));
            DoDebug("====== LEFT CREATURE WEAPON");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC));
            DoDebug("====== SPECIAL CREATURE WEAPON");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC));
            DoDebug("====== RIGHT HAND");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
            DoDebug("====== LEFT HAND");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
            DoDebug("====== CHEST");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
            DoDebug("====== HEAD");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
            DoDebug("====== CLOAK");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC));
            DoDebug("====== ARMS");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_ARMS, oPC));
            DoDebug("====== BELT");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_BELT, oPC));
            DoDebug("====== BOOTS");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC));
            DoDebug("====== RIGHT HAND RING");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
            DoDebug("====== LEFT HAND RING");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
            DoDebug("====== NECK");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_NECK, oPC));
            DoDebug("====== ARROWS");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
            DoDebug("====== BOLTS");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));
            DoDebug("====== BULLETS");
            _prc_inc_DumpAllItemProperties("=== ", GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC));
        }
        else if (GetStringMatchesAbbreviation(sInfoType, CMD_SKILLS))
        {
            DoDebug("====== SKILLS ======");
            DoDebug("=== The first number is the base score; the second is the modified score, which includes bonuses and penalties from gear, etc.");
            int i = 0;
            string sSkillName;
            while((sSkillName = Get2DACache("skills", "Name", i)) != "")
            {
                sSkillName = GetStringByStrRef(StringToInt(sSkillName));
                DoDebug("=== " + sSkillName + ": " + IntToString(GetSkillRank(i, oPC, TRUE)) + " / " + IntToString(GetSkillRank(i, oPC, FALSE)));
                i += 1;
            }
        }
        else
            DoDebug("Unrecognized information request: " + sInfoType);
    }
    else if (GetStringMatchesAbbreviation(sCommandName, CMD_CHANGE))
    {
        bResult = TRUE;
        if (!DEBUG)
            DoDebug("This command only works if DEBUG = TRUE");
        else
        {
            string sChangeWhat = GetStringWord(sCommand, 2);
            string sChangeHow = GetStringWord(sCommand, 3);
            string sNumber = GetStringWord(sCommand, 4);
            int nNumber = StringToInt(sNumber);
            if (GetStringMatchesAbbreviation(sChangeWhat, CMD_LEVEL))
            {
                if (sNumber != IntToString(nNumber))
                    DoDebug("Unrecognized level: " + sNumber);
                else
                {
                    if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                    {
                        int nCurrentLevel = _prc_inc_XPToLevel(GetXP(oPC));
                        if (nCurrentLevel > 40)
                            nCurrentLevel = 40;
                        nNumber = nCurrentLevel + nNumber;
                        if (nNumber < 1)
                            nNumber = 1;
                        else if (nNumber > 40)
                            nNumber = 40;
                        SetXP(oPC, _prc_inc_LevelToXP(nNumber));
                    }
                    else if (GetStringMatchesAbbreviation(sChangeHow, CMD_TO))
                    {
                        if (nNumber < 1)
                            nNumber = 1;
                        else if (nNumber > 40)
                            nNumber = 40;
                        SetXP(oPC, _prc_inc_LevelToXP(nNumber));
                    }
                    else
                        DoDebug("Unrecognized word: " + sChangeHow);
                }
            }
            else if (GetStringMatchesAbbreviation(sChangeWhat, CMD_XP))
            {
                if (sNumber != IntToString(nNumber))
                    DoDebug("Unrecognized xp: " + sNumber);
                else
                {
                    if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                    {
                        nNumber = GetXP(oPC) + nNumber;
                        if (nNumber < 0)
                            nNumber = 0;
                        SetXP(oPC, nNumber);
                    }
                    else if (GetStringMatchesAbbreviation(sChangeHow, CMD_TO))
                    {
                        if (nNumber < 0)
                            nNumber = 0;
                        SetXP(oPC, nNumber);
                    }
                    else
                        DoDebug("Unrecognized word: " + sChangeHow);
                }
            }
            else if (GetStringMatchesAbbreviation(sChangeWhat, CMD_GOLD))
            {
                if (sNumber != IntToString(nNumber))
                    DoDebug("Unrecognized gold amount: " + sNumber);
                else
                {
                    if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                    {
                        if (nNumber > 0)
                            GiveGoldToCreature(oPC, nNumber);
                        else if (nNumber < 0)
                            AssignCommand(oPC, TakeGoldFromCreature(-nNumber, oPC, TRUE));
                    }
                    else if (GetStringMatchesAbbreviation(sChangeHow, CMD_TO))
                    {
                        nNumber = nNumber - GetGold(oPC);
                        if (nNumber > 0)
                            GiveGoldToCreature(oPC, nNumber);
                        else if (nNumber < 0)
                            AssignCommand(oPC, TakeGoldFromCreature(-nNumber, oPC, TRUE));
                    }
                    else
                        DoDebug("Unrecognized word: " + sChangeHow);
                }
            }
            else if (GetStringMatchesAbbreviation(sChangeWhat, CMD_ABILITY))
            {
                if (!GetPRCSwitch(PRC_NWNX_FUNCS))
                    DoDebug("This command only works if NWNX funcs is installed");
                else
                {
                    sChangeWhat = GetStringWord(sCommand, 3);
                    sChangeHow = GetStringWord(sCommand, 4);
                    sNumber = GetStringWord(sCommand, 5);
                    nNumber = StringToInt(sNumber);
                    if (sNumber != IntToString(nNumber))
                        DoDebug("Unrecognized ability value: " + sNumber);
                    else
                    {
                        if (GetStringMatchesAbbreviation(sChangeWhat, CMD_STR))
                        {
                            if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                                nNumber += GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE);
                            if (nNumber < 3 || nNumber > 255)
                                DoDebug("Invalid " + CMD_STR + " value (must be between 3 and 255): " + sChangeWhat);
                            else
                            {
                                if (nNumber > 100 - 12)
                                    DoDebug("NOTE: having a total " + CMD_STR + " above 100 can cause problems (the weight that you can carry goes to 0)");
                                _prc_inc_shifting_SetSTR(oPC, nNumber);
                            }
                        }
                        else if (GetStringMatchesAbbreviation(sChangeWhat, CMD_DEX))
                        {
                            if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                                nNumber += GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE);
                            if (nNumber < 3 || nNumber > 255)
                                DoDebug("Invalid " + CMD_DEX + " value (must be between 3 and 255): " + sChangeWhat);
                            else
                                _prc_inc_shifting_SetDEX(oPC, nNumber);
                        }
                        else if (GetStringMatchesAbbreviation(sChangeWhat, CMD_CON))
                        {
                            if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                                nNumber += GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
                            if (nNumber < 3 || nNumber > 255)
                                DoDebug("Invalid " + CMD_CON + " value (must be between 3 and 255): " + sChangeWhat);
                            else
                                _prc_inc_shifting_SetCON(oPC, nNumber);
                        }
                        else if (GetStringMatchesAbbreviation(sChangeWhat, CMD_INT))
                        {
                            if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                                nNumber += GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE);
                            if (nNumber < 3 || nNumber > 255)
                                DoDebug("Invalid " + CMD_INT + " value (must be between 3 and 255): " + sChangeWhat);
                            else
                                _prc_inc_shifting_SetINT(oPC, nNumber);
                        }
                        else if (GetStringMatchesAbbreviation(sChangeWhat, CMD_WIS))
                        {
                            if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                                nNumber += GetAbilityScore(oPC, ABILITY_WISDOM, TRUE);
                            if (nNumber < 3 || nNumber > 255)
                                DoDebug("Invalid " + CMD_WIS + " value (must be between 3 and 255): " + sChangeWhat);
                            else
                                _prc_inc_shifting_SetWIS(oPC, nNumber);
                        }
                        else if (GetStringMatchesAbbreviation(sChangeWhat, CMD_CHA))
                        {
                            if (GetStringMatchesAbbreviation(sChangeHow, CMD_BY))
                                nNumber += GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);
                            if (nNumber < 3 || nNumber > 255)
                                DoDebug("Invalid " + CMD_CHA + " value (must be between 3 and 255): " + sChangeWhat);
                            else
                                _prc_inc_shifting_SetCHA(oPC, nNumber);
                        }
                        else
                            DoDebug("Unrecognized ability to change: " + sChangeWhat);
                    }
                }
            }
            else
            {
                DoDebug("Unrecognized value to change: " + sChangeWhat);
            }
        }
    }
    else if (GetStringMatchesAbbreviation(sCommandName, CMD_SPAWN))
    {
        bResult = TRUE;
        if (!DEBUG)
            DoDebug("This command only works if DEBUG = TRUE");
        else
        {
            string sSpawnType = GetStringWord(sCommand, 2);
            string sResRef = GetStringWord(sCommand, 3);
            if (GetStringMatchesAbbreviation(sSpawnType, CMD_CREATURE))
            {
                AssignCommand(oPC, DoSummon(oPC, sResRef));
            }
            else if (GetStringMatchesAbbreviation(sSpawnType, CMD_ITEM))
            {
                object oItem = CreateObject(OBJECT_TYPE_ITEM, sResRef, GetLocation(oPC));
                SetIdentified(oItem, TRUE);
                if (GetIsObjectValid(oItem))
                    DoDebug("Created item: " + GetName(oItem));
                else
                    DoDebug("Faild to create item--invalid resref?: " + sResRef);
            }
            else
                DoDebug("Unrecognized spawn type: " + sSpawnType);
        }
    }
    else if (GetStringMatchesAbbreviation(sCommandName, CMD_RELEVEL))
    {
        bResult = TRUE;
        if (!DEBUG)
            DoDebug("This command only works if DEBUG = TRUE");
        else
        {
            string sNumber = GetStringWord(sCommand, 2);
            int nNumber = StringToInt(sNumber);
            int nStartXP = GetXP(oPC);
            int nStartLevel = _prc_inc_XPToLevel(nStartXP);
            if (sNumber != IntToString(nNumber))
                DoDebug("Unrecognized level: " + sNumber);
            else if (nNumber > nStartLevel)
                DoDebug("Nothing to do: specified level is higher than current level.");
            else
            {
                if (nNumber < 1)
                    nNumber = 1;
                SetXP(oPC, _prc_inc_LevelToXP(nNumber-1)); //Level down to the the level before the 1st we want to change
                SetXP(oPC, nStartXP); //Level back up to our starting XP
            }
        }
    }
    else if (GetStringMatchesAbbreviation(sCommandName, CMD_SPECIAL))
    {
        bResult = TRUE;
        
        string sSpecialCommandName = GetStringWord(sCommand, 2);

        if (GetStringMatchesAbbreviation(sSpecialCommandName, CMD_REST))
        {
            if (!DEBUG)
                DoDebug("This command only works if DEBUG = TRUE");
            else
                PRCForceRest(oPC);
        }
        else if (GetStringMatchesAbbreviation(sSpecialCommandName, CMD_HANDLE_FORCE_REST_1) && 
            GetStringMatchesAbbreviation(GetStringWord(sCommand, 3), CMD_HANDLE_FORCE_REST_2) && 
            GetStringMatchesAbbreviation(GetStringWord(sCommand, 4), CMD_HANDLE_FORCE_REST_3)
            )
        {
            StartForcedRestDetector(oPC);
        }
    }
        
    return bResult;
}
