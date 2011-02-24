#include "ccc_inc_misc"

// sets up the header and the choices for each stage of the convoCC
void DoHeaderAndChoices(int nStage);

// processes the player choices for each stage of the convoCC
int HandleChoice(int nStage, int nChoice);

void DoHeaderAndChoices(int nStage)
{
    string sText;
    string sName;
    int i = 0; // loop counter
    switch(nStage)
    {
        case STAGE_INTRODUCTION: {
            sText = "This is the PRC Conversation Character Creator (CCC).\n";
            sText+= "This is a replicate of the bioware character creator, but it will allow you to select custom content at level 1. ";
            sText+= "Simply follow the step by step instructions and select what you want. ";
            sText+= "If you dont get all the options you think you should at a stage, select one, then select No at the confirmation step.";
            SetHeader(sText);
            // setup the choices
            AddChoice("continue", 0);
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_GENDER: {
            sText = GetStringByStrRef(158);
            SetHeader(sText);
            // set up the choices
            Do2daLoop("gender", "name", GetPRCSwitch(FILE_END_GENDER));
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_GENDER_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            sText+= GetStringByStrRef(StringToInt(Get2DACache("gender", "NAME", GetLocalInt(OBJECT_SELF, "Gender"))));
            sText+= "\n"+GetStringByStrRef(16824210);
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_RACE: {
            sText = GetStringByStrRef(162); // Select a Race for your Character
            SetHeader(sText);
            // set up choices
            // try with waiting set up first
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            DelayCommand(0.01, DoRacialtypesLoop());
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_RACE_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            sText += GetStringByStrRef(StringToInt(Get2DACache("racialtypes", "Name", GetLocalInt(OBJECT_SELF, "Race"))));
            sText += "\n";
            sText+= GetStringByStrRef(StringToInt(Get2DACache("racialtypes", "Description", GetLocalInt(OBJECT_SELF, "Race"))));
            sText+= "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_CLASS: {
            sText = GetStringByStrRef(61920); // Select a Class for Your Character
            SetHeader(sText);
            // set up choices
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            DelayCommand(0.01, DoClassesLoop());
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_CLASS_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            sText += GetStringByStrRef(StringToInt(Get2DACache("classes", "Name", GetLocalInt(OBJECT_SELF, "Class"))));
            sText += "\n";
            sText+= GetStringByStrRef(StringToInt(Get2DACache("classes", "Description", GetLocalInt(OBJECT_SELF, "Class"))));
            sText+= "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_ALIGNMENT: {
            sText = GetStringByStrRef(111); // Select an Alignment for your Character
            SetHeader(sText);
            // get the restriction info from classes.2da
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            int nClass = GetLocalInt(OBJECT_SELF, "Class");
            int iAlignRestrict = HexToInt(Get2DACache("classes", "AlignRestrict",nClass));
            int iAlignRstrctType = HexToInt(Get2DACache("classes", "AlignRstrctType",nClass));
            int iInvertRestrict = HexToInt(Get2DACache("classes", "InvertRestrict",nClass));
            // set up choices
            if(GetIsValidAlignment(ALIGNMENT_LAWFUL, ALIGNMENT_GOOD,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(112), 112);
            if(GetIsValidAlignment(ALIGNMENT_NEUTRAL, ALIGNMENT_GOOD,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(115), 115);
            if(GetIsValidAlignment(ALIGNMENT_CHAOTIC, ALIGNMENT_GOOD,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(118), 118);
            if(GetIsValidAlignment(ALIGNMENT_LAWFUL, ALIGNMENT_NEUTRAL,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(113), 113);
            if(GetIsValidAlignment(ALIGNMENT_NEUTRAL, ALIGNMENT_NEUTRAL,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(116), 116);
            if(GetIsValidAlignment(ALIGNMENT_CHAOTIC, ALIGNMENT_NEUTRAL,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(119), 119);
            if(GetIsValidAlignment(ALIGNMENT_LAWFUL, ALIGNMENT_EVIL,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(114), 114);
            if(GetIsValidAlignment(ALIGNMENT_NEUTRAL, ALIGNMENT_EVIL,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(117), 117);
            if(GetIsValidAlignment(ALIGNMENT_CHAOTIC, ALIGNMENT_EVIL,iAlignRestrict, iAlignRstrctType, iInvertRestrict))
                AddChoice(GetStringByStrRef(120), 120);
            DelayCommand(0.01, DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting"));
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_ALIGNMENT_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            int nStrRef = GetLocalInt(OBJECT_SELF, "AlignChoice"); // strref for the alignment
            sText += GetStringByStrRef(nStrRef);
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_ABILITY: {
            // the first time through this stage set everything up
            if(GetLocalInt(OBJECT_SELF, "Str") == 0)
            {
                // get the starting points to allocate
                int nPoints = GetPRCSwitch(PRC_CONVOCC_STAT_POINTS);
                if(nPoints == 0)
                    nPoints = 30; // default
                SetLocalInt(OBJECT_SELF, "Points", nPoints);
                // get the max stat level (before racial modifiers)
                int nMaxStat = GetPRCSwitch(PRC_CONVOCC_MAX_STAT);
                if(nMaxStat == 0)
                    nMaxStat = 18; // default
                SetLocalInt(OBJECT_SELF, "MaxStat", nMaxStat);
                // set the starting stat values
                SetLocalInt(OBJECT_SELF, "Str", 8);
                SetLocalInt(OBJECT_SELF, "Dex", 8);
                SetLocalInt(OBJECT_SELF, "Con", 8);
                SetLocalInt(OBJECT_SELF, "Int", 8);
                SetLocalInt(OBJECT_SELF, "Wis", 8);
                SetLocalInt(OBJECT_SELF, "Cha", 8);
            }
            sText = GetStringByStrRef(130) + "\n"; // Select Ability Scores for your Character
            sText += GetStringByStrRef(138) + ": "; // Remaining Points
            sText += IntToString(GetLocalInt(OBJECT_SELF, "Points"));
            SetHeader(sText);
            // get the racial adjustment
            int nRace = GetLocalInt(OBJECT_SELF, "Race");
            string sStrAdjust = Get2DACache("racialtypes", "StrAdjust", nRace);
            string sDexAdjust = Get2DACache("racialtypes", "DexAdjust", nRace);
            string sConAdjust = Get2DACache("racialtypes", "ConAdjust", nRace);
            string sIntAdjust = Get2DACache("racialtypes", "IntAdjust", nRace);
            string sWisAdjust = Get2DACache("racialtypes", "WisAdjust", nRace);
            string sChaAdjust = Get2DACache("racialtypes", "ChaAdjust", nRace);
            // set up the choices in "<statvalue> (racial <+/-modifier>) <statname>. Cost to increase <cost>" format
            AddAbilityChoice(GetLocalInt(OBJECT_SELF, "Str"), GetStringByStrRef(135), sStrAdjust, ABILITY_STRENGTH);
            AddAbilityChoice(GetLocalInt(OBJECT_SELF, "Dex"), GetStringByStrRef(133), sDexAdjust, ABILITY_DEXTERITY);
            AddAbilityChoice(GetLocalInt(OBJECT_SELF, "Con"), GetStringByStrRef(132), sConAdjust, ABILITY_CONSTITUTION);
            AddAbilityChoice(GetLocalInt(OBJECT_SELF, "Int"), GetStringByStrRef(134), sIntAdjust, ABILITY_INTELLIGENCE);
            AddAbilityChoice(GetLocalInt(OBJECT_SELF, "Wis"), GetStringByStrRef(136), sWisAdjust, ABILITY_WISDOM);
            AddAbilityChoice(GetLocalInt(OBJECT_SELF, "Cha"), GetStringByStrRef(131), sChaAdjust, ABILITY_CHARISMA);
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_ABILITY_CHECK: {
            sText = GetStringByStrRef(16824209) + "\n"; // You have selected:
            // get the racial adjustment
            int nRace = GetLocalInt(OBJECT_SELF, "Race");
            string sStrAdjust = Get2DACache("racialtypes", "StrAdjust", nRace);
            string sDexAdjust = Get2DACache("racialtypes", "DexAdjust", nRace);
            string sConAdjust = Get2DACache("racialtypes", "ConAdjust", nRace);
            string sIntAdjust = Get2DACache("racialtypes", "IntAdjust", nRace);
            string sWisAdjust = Get2DACache("racialtypes", "WisAdjust", nRace);
            string sChaAdjust = Get2DACache("racialtypes", "ChaAdjust", nRace);
            sText += GetStringByStrRef(135) + ": " + IntToString(GetLocalInt(OBJECT_SELF, "Str") + StringToInt(sStrAdjust)) + "\n"; // str
            sText += GetStringByStrRef(133) + ": " + IntToString(GetLocalInt(OBJECT_SELF, "Dex") + StringToInt(sDexAdjust)) + "\n"; // dex
            sText += GetStringByStrRef(132) + ": " + IntToString(GetLocalInt(OBJECT_SELF, "Con") + StringToInt(sConAdjust)) + "\n"; // con
            sText += GetStringByStrRef(134) + ": " + IntToString(GetLocalInt(OBJECT_SELF, "Int") + StringToInt(sIntAdjust)) + "\n"; // int
            sText += GetStringByStrRef(136) + ": " + IntToString(GetLocalInt(OBJECT_SELF, "Wis") + StringToInt(sWisAdjust)) + "\n"; // wis
            sText += GetStringByStrRef(131) + ": " + IntToString(GetLocalInt(OBJECT_SELF, "Cha") + StringToInt(sChaAdjust)) + "\n"; // cha
            sText += "\n" + GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_SKILL: {
            // the first time through this stage set everything up
            int nPoints = GetLocalInt(OBJECT_SELF, "Points");
            if(nPoints == 0)
            {
                SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
                //calculate number of points
                nPoints += StringToInt(Get2DACache("classes", "SkillPointBase", GetLocalInt(OBJECT_SELF, "Class")));
                // calculate the intelligence bonus/penalty
                int nInt = GetLocalInt(OBJECT_SELF, "Int");
                int nRace = GetLocalInt(OBJECT_SELF, "Race");
                nPoints += (nInt-10+StringToInt(Get2DACache("racialtypes", "IntAdjust", nRace)))/2;
                if(GetPRCSwitch(PRC_CONVOCC_SKILL_MULTIPLIER))
                    nPoints *= GetPRCSwitch(PRC_CONVOCC_SKILL_MULTIPLIER);
                else
                    nPoints *= 4;
                // humans get an extra 4 skill points at level 1
                if (GetLocalInt(OBJECT_SELF, "Race") == RACIAL_TYPE_HUMAN)
                    nPoints += 4;
                nPoints += GetPRCSwitch(PRC_CONVOCC_SKILL_BONUS);
                // minimum of 4, regardless of int
                if(nPoints < 4)
                    nPoints = 4;
                SetLocalInt(OBJECT_SELF, "Points", nPoints);
                DelayCommand(0.01, DoSkillsLoop());
            }
            else
                DoSkillsLoop();
            // do header
            sText = GetStringByStrRef(396) + "\n"; // Allocate skill points
            sText += GetStringByStrRef(395) + ": "; // Remaining Points
            sText += IntToString(GetLocalInt(OBJECT_SELF, "Points"));
            SetHeader(sText);
            /* Hack - Returning to the skill selection stage, restore the
             * offset to be the same as it was choosing the skill.
             */
            if(GetLocalInt(OBJECT_SELF, "SkillListChoiceOffset"))
            {
                SetLocalInt(OBJECT_SELF, DYNCONV_CHOICEOFFSET, GetLocalInt(OBJECT_SELF, "SkillListChoiceOffset") - 1);
                DeleteLocalInt(OBJECT_SELF, "SkillListChoiceOffset");
            }
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_SKILL_CHECK: {
            sText = GetStringByStrRef(16824209) + "\n"; // You have selected:
            if(GetPRCSwitch(PRC_CONVOCC_ALLOW_SKILL_POINT_ROLLOVER))
            {
                sText += "Stored skill points: ";
                sText += IntToString(GetLocalInt(OBJECT_SELF, "SavedSkillPoints")) + "\n";
            }
            // loop through the "Skills" array
            for(i=0; i <= GetPRCSwitch(FILE_END_SKILLS); i++) // the array can't be bigger than the skills 2da
            {
                if(array_get_int(OBJECT_SELF, "Skills",i) != 0) // if there are points in the skill, add it to the header
                {
                    sText+= GetStringByStrRef(StringToInt(Get2DACache("skills", "Name", i)));
                    sText+= " "+IntToString(array_get_int(OBJECT_SELF, "Skills",i))+"\n";
                }
            }
            sText += "\n" + GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_FEAT: {
            sText = GetStringByStrRef(397) + "\n"; // Select Feats
            sText += GetStringByStrRef(398) + ": "; // Feats remaining
            // if it's the first time through, work out the number of feats
            int nFeatsRemaining = GetLocalInt(OBJECT_SELF, "Points");
            if (!nFeatsRemaining) // first time through
            {
                nFeatsRemaining = 1; // always have at least 1
                // check for quick to master
                nFeatsRemaining += GetLocalInt(OBJECT_SELF, "QTM");
                // set how many times to go through this stage
                SetLocalInt(OBJECT_SELF, "Points", nFeatsRemaining);
                // mark skill focus feat prereq here so it's only done once
                // note: any other skill that is restricted to certain classes needs to be added here
                // and the local ints deleted in the STAGE_BONUS_FEAT_CHECK case of HandleChoice()
                // and it enforced in CheckSkillPrereq()
                // UMD and animal empathy are the only ones so far
                MarkSkillFocusPrereq(SKILL_ANIMAL_EMPATHY, "bHasAnimalEmpathy");
                MarkSkillFocusPrereq(SKILL_USE_MAGIC_DEVICE, "bHasUMD");
            }
            // check for bonus feat(s) from class - show the player the total feats
            // even though class bonuses are a different stage
            int nClass = GetLocalInt(OBJECT_SELF, "Class");
            nFeatsRemaining += StringToInt(Get2DACache(Get2DACache("Classes", "BonusFeatsTable", nClass), "Bonus", 0));
            sText += IntToString(nFeatsRemaining);
            SetHeader(sText);
            // do feat list
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            if (array_exists(OBJECT_SELF, "CachedChoiceTokens"))
            {
                // add cached choices to convo
                AddChoicesFromCache();
                DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
            }
            else
            {
                DoFeatLoop();
            }
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_FEAT_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            // get feat
            int nFeat = array_get_int(OBJECT_SELF, "Feats", (array_get_size(OBJECT_SELF, "Feats") - 1));
            // alertness fix
            if (nFeat == -1)
                nFeat = 0;
            sText += GetStringByStrRef(StringToInt(Get2DACache("feat", "FEAT", nFeat))) + "\n"; // name
            sText += GetStringByStrRef(StringToInt(Get2DACache("feat", "DESCRIPTION", nFeat))) + "\n"; // description
            sText+= "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_BONUS_FEAT: {
            sText = GetStringByStrRef(397) + "\n"; // Select Feats
            sText += GetStringByStrRef(398) + ": "; // Feats remaining
            int nFeatsRemaining = GetLocalInt(OBJECT_SELF, "Points");
            if (!nFeatsRemaining) // first time through
            {
                // check for bonus feat(s) from class
                int nClass = GetLocalInt(OBJECT_SELF, "Class");
                nFeatsRemaining += StringToInt(Get2DACache(Get2DACache("Classes", "BonusFeatsTable", nClass), "Bonus", 0));
                // set how many times to go through this stage
                SetLocalInt(OBJECT_SELF, "Points", nFeatsRemaining);
            }
            sText += IntToString(nFeatsRemaining);
            SetHeader(sText);
            // do feat list
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            if (array_exists(OBJECT_SELF, "CachedChoiceTokens"))
            {
                // add cached choices to convo
                AddChoicesFromCache();
                DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
            }
            else
            {
                DoBonusFeatLoop();
            }
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_BONUS_FEAT_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            // get feat
            int nFeat = array_get_int(OBJECT_SELF, "Feats", (array_get_size(OBJECT_SELF, "Feats") - 1));
            sText += GetStringByStrRef(StringToInt(Get2DACache("feat", "FEAT", nFeat))) + "\n"; // name
            sText += GetStringByStrRef(StringToInt(Get2DACache("feat", "DESCRIPTION", nFeat))) + "\n"; // description
            sText+= "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_WIZ_SCHOOL: {
            sText = GetStringByStrRef(381); // Select a School of Magic
            SetHeader(sText);
            // choices
            if(GetPRCSwitch(PRC_PNP_SPELL_SCHOOLS))
            {
                AddChoice(GetStringByStrRef(StringToInt(Get2DACache("spellschools", "StringRef", 9))), 9);
            }
            else
            {
                for(i = 0; i < 9; i++)
                {
                    AddChoice(GetStringByStrRef(StringToInt(Get2DACache("spellschools", "StringRef", i))), i);
                }
            }
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_WIZ_SCHOOL_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            sText+= GetStringByStrRef(StringToInt(Get2DACache("spellschools", "StringRef", GetLocalInt(OBJECT_SELF, "School"))));
            sText+= "\n\n";
            sText+= GetStringByStrRef(StringToInt(Get2DACache("spellschools", "Description", GetLocalInt(OBJECT_SELF, "School"))));
            sText+= "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_SPELLS_0: {
            // if the first time through, set up the number of cantrips to pick
            int nPoints = GetLocalInt(OBJECT_SELF, "Points");
            int nClass = GetLocalInt(OBJECT_SELF, "Class");
            if(nPoints == 0)
            {
                // set up the number of spells to pick
                // get the cls_spkn_***2da to use
                string sSpkn = Get2DACache("classes", "SpellKnownTable", nClass);
                // set the number of spells to pick
                nPoints = StringToInt(Get2DACache(sSpkn, "SpellLevel0", 0));
                SetLocalInt(OBJECT_SELF, "Points", nPoints);
                // don't want to be waiting every time
                SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            }
            sText = GetStringByStrRef(372) + "\n"; // Select Cantrips
            sText += GetStringByStrRef(371) + ": "; // Remaining Spells
            sText += IntToString(nPoints);
            SetHeader(sText);
            // choices, uses nStage to see if it's listing level 0 or level 1 spells
            DoSpellsLoop(nStage);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_SPELLS_1: {
            // if the first time through, set up the number of spells to pick
            int nPoints = GetLocalInt(OBJECT_SELF, "Points");
            int nClass = GetLocalInt(OBJECT_SELF, "Class");
            if(nPoints == 0)
            {
                switch(nClass)
                {
                    case CLASS_TYPE_WIZARD: {
                        // spells to pick is 3 + int modifier
                        int nIntMod = GetLocalInt(OBJECT_SELF, "Int");
                        nIntMod += StringToInt(Get2DACache("racialtypes", "IntAdjust", GetLocalInt(OBJECT_SELF, "Race")));
                        nIntMod = (nIntMod - 10)/2;
                        nPoints = 3 + nIntMod;
                        break;
                    }
                    case CLASS_TYPE_SORCERER: {
                        // get the cls_spkn_***2da to use
                        string sSpkn = Get2DACache("classes", "SpellKnownTable", nClass);
                        // set the number of spells to pick
                        nPoints = StringToInt(Get2DACache(sSpkn, "SpellLevel1", 0));
                        break;
                    }
                }
                SetLocalInt(OBJECT_SELF, "Points", nPoints);
                // don't want to be waiting every time
                SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            }
            sText = GetStringByStrRef(368) + "\n"; // Select Spells for your Character
            sText += GetStringByStrRef(371) + ": "; // Remaining Spells
            sText += IntToString(GetLocalInt(OBJECT_SELF, "Points"));
            SetHeader(sText);
            // choices, uses nStage to see if it's listing level 0 or level 1 spells
            DoSpellsLoop(nStage);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_SPELLS_CHECK: {
            sText = GetStringByStrRef(16824209) + "\n"; // You have selected:
            int spellID = 0;
            sText += GetStringByStrRef(691) + " - \n"; // Cantrips
            // loop through the spell choices
            for (i = 0; i < array_get_size(OBJECT_SELF, "SpellLvl0"); i++)
            {
                spellID = array_get_int(OBJECT_SELF, "SpellLvl0", i);
                sText+= GetStringByStrRef(StringToInt(Get2DACache("spells", "Name", spellID)));
                sText += "\n";
            }
            sText += GetStringByStrRef(61924) + " - \n"; // Level 1 Spells
            // loop through the spell choices
            for (i = 0; i < array_get_size(OBJECT_SELF, "SpellLvl1"); i++)
            {
                spellID = array_get_int(OBJECT_SELF, "SpellLvl1", i);
                sText+= GetStringByStrRef(StringToInt(Get2DACache("spells", "Name", spellID)));
                sText += "\n";
            }
            sText+= "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_FAMILIAR: {
            int nClass = GetLocalInt(OBJECT_SELF, "Class");
            sText = GetStringByStrRef(5607) + "\n"; // Choose a Familiar for your Character
            sText += "(" + GetStringByStrRef(StringToInt(Get2DACache("classes", "Name", nClass))) + ")";
            SetHeader(sText);
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            // do choices
            if (nClass == CLASS_TYPE_DRUID)
                Do2daLoop("hen_companion", "strref", GetPRCSwitch(FILE_END_ANIMALCOMP));
            else // wizard or sorc
                Do2daLoop("hen_familiar", "strref", GetPRCSwitch(FILE_END_FAMILIAR));
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", FALSE);
            FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_FAMILIAR_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            if (GetLocalInt(OBJECT_SELF, "Class") == CLASS_TYPE_DRUID)
            {
                int nCompanion = GetLocalInt(OBJECT_SELF, "Companion");
                sText += GetStringByStrRef(StringToInt(Get2DACache("hen_companion", "STRREF", nCompanion)));
                sText += "\n";
                sText += GetStringByStrRef(StringToInt(Get2DACache("hen_companion", "DESCRIPTION", nCompanion)));
                sText += "\n";
            }
            else
            {
                int nFamiliar = GetLocalInt(OBJECT_SELF, "Familiar");
                sText += GetStringByStrRef(StringToInt(Get2DACache("hen_familiar", "STRREF", nFamiliar)));
                sText += "\n";
                sText += GetStringByStrRef(StringToInt(Get2DACache("hen_familiar", "DESCRIPTION", nFamiliar)));
                sText += "\n";
            }
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_DOMAIN: {
            sText = GetStringByStrRef(5982); // Pick Cleric Domain
            SetHeader(sText);
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            // choices
            DoDomainsLoop();
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_DOMAIN_CHECK1: {
            sText = GetStringByStrRef(16824209) + "\n"; // You have selected:
            // first domain
            int nDomain = GetLocalInt(OBJECT_SELF,"Domain1");
            // fix for air domain being 0
            if (nDomain == -1)
                nDomain = 0;
            sText += GetStringByStrRef(StringToInt(Get2DACache("domains", "Name", nDomain))) + "\n";
            sText += GetStringByStrRef(StringToInt(Get2DACache("domains", "Description", nDomain))) + "\n";
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_DOMAIN_CHECK2: {
            sText = GetStringByStrRef(16824209) + "\n"; // You have selected:
            // second domain
            int nDomain = GetLocalInt(OBJECT_SELF,"Domain2");
            // fix for air domain being 0
            if (nDomain == -1)
                nDomain = 0;
            sText += GetStringByStrRef(StringToInt(Get2DACache("domains", "Name", nDomain))) + "\n";
            sText += GetStringByStrRef(StringToInt(Get2DACache("domains", "Description", nDomain))) + "\n";
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_APPEARANCE: {
            sText = GetStringByStrRef(124); // Select the Appearance of your Character
            SetHeader(sText);
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            if(GetPRCSwitch(PRC_CONVOCC_USE_RACIAL_APPEARANCES)) // restrict to what is given in the 2da
                SetupRacialAppearances();
            else
                DoAppearanceLoop();
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_APPEARANCE_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            int nAppearance = GetLocalInt(OBJECT_SELF, "Appearance");
            int nStrRef = StringToInt(Get2DACache("appearance", "STRING_REF", nAppearance));
            if(nStrRef)
                sText += GetStringByStrRef(nStrRef);
            else
                sText += Get2DACache("appearance", "LABEL", nAppearance);
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_PORTRAIT: {
            sText = GetStringByStrRef(7383); // Select a portrait
            SetHeader(sText);
            if(GetPRCSwitch(PRC_CONVOCC_ALLOW_TO_KEEP_PORTRAIT))
                AddChoice("Keep existing portrait.", -1);
            // if(GetPRCSwitch(PRC_CONVOCC_USE_RACIAL_PORTRAIT))
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            DoPortraitsLoop();
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_PORTRAIT_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            int nPortrait = GetPortraitId(OBJECT_SELF);
            sText += Get2DACache("portraits", "BaseResRef", nPortrait);
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice("View this portrait.", 2);
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_SOUNDSET: {
            sText = GetStringByStrRef(7535); // Select a sound set
            SetHeader(sText);
            if(GetPRCSwitch(PRC_CONVOCC_ALLOW_TO_KEEP_VOICESET))
                AddChoice("keep existing soundset.", -1);
            SetLocalInt(OBJECT_SELF, "DynConv_Waiting", TRUE);
            DoSoundsetLoop();
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_SOUNDSET_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            int nSoundset = GetLocalInt(OBJECT_SELF, "Soundset");
            sText += GetStringByStrRef(StringToInt(Get2DACache("soundset", "STRREF", nSoundset)));
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice("Listen to this soundset.", 2);
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_HEAD: {
            sText = GetStringByStrRef(124); // Select the Appearance of your Character
            sText += "(" + GetStringByStrRef(123) + ")"; // Head
            SetHeader(sText);
            AddChoice("keep existing head", -1);
            SetupHeadChoices();
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_HEAD_CHECK: {
            sText = "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_TATTOO: {
            sText = GetStringByStrRef(124); // Select the Appearance of your Character
            sText += "(" + GetStringByStrRef(1591) + ")"; // Tattoo
            SetHeader(sText);
            AddChoice("keep current tatoos", -1);
            AddChoice("torso", CREATURE_PART_TORSO);
            AddChoice("right shin", CREATURE_PART_RIGHT_SHIN);
            AddChoice("left shin", CREATURE_PART_LEFT_SHIN);
            AddChoice("right thigh", CREATURE_PART_RIGHT_THIGH);
            AddChoice("left thigh", CREATURE_PART_LEFT_THIGH);
            AddChoice("right forearm", CREATURE_PART_RIGHT_FOREARM);
            AddChoice("left forearm", CREATURE_PART_LEFT_FOREARM);
            AddChoice("right bicep", CREATURE_PART_RIGHT_BICEP);
            AddChoice("left bicep", CREATURE_PART_LEFT_BICEP);
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_TATTOO_CHECK: {
            sText = "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_WINGS: {
            sText = GetStringByStrRef(124); // Select the Appearance of your Character
            sText += "(" + GetStringByStrRef(2409) + ")"; // Wings
            SetHeader(sText);
            DoWingmodelLoop();
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_WINGS_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            int nWingType = GetCreatureWingType();
            sText += Get2DACache("wingmodel", "label", nWingType);
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_TAIL: {
            sText = GetStringByStrRef(124); // Select the Appearance of your Character
            sText += "(" + GetStringByStrRef(2410) + ")"; // Tail
            SetHeader(sText);
            DoTailmodelLoop();
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_TAIL_CHECK: {
            sText = GetStringByStrRef(16824209) + " "; // You have selected:
            int nTailType = GetCreatureTailType();
            sText += Get2DACache("tailmodel", "label", nTailType);
            sText += "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_SKIN_COLOUR: {
            sText = "Pick a colour category ";
            sText += "(" + GetStringByStrRef(128) + ")"; // Skin Color
            SetHeader(sText);
            AddChoice("Keep current skin colour", -1);
            AddChoice("Tan colours", 1);
            AddChoice("Sand & Rose brown", 2);
            AddChoice("Tan-Greys and blues", 3);
            AddChoice("Gold and obsidian", 4);
            AddChoice("Greens", 5);
            AddChoice("Greys and reds", 6);
            AddChoice("Bright blues, greens and yellows", 7);
            // new colours
            AddChoice("Metallic & pure white and black", 8);
            AddChoice("Smoky Group 1", 9);
            AddChoice("Smoky Group 2", 10);
            AddChoice("Smoky Group 3", 11);
            AddChoice("Smoky Group 4", 12);
            AddChoice("Black Cherry & Cinnamon", 13);
            AddChoice("Hunter Green & Druid Green", 14);
            AddChoice("Graveyard Fog & Chestnut", 15);
            AddChoice("Clay & Toasted Ash", 16);
            AddChoice("Snail Brown & Cobalt Blue", 17);
            AddChoice("Midnight Blue & Peacock Green", 18);
            AddChoice("Royal Purple, Mountain Blue, & Sea Foam Green", 19);
            AddChoice("Spring Green, Honey Gold, Copper Coin & Berry Ice", 20);
            AddChoice("Sugar Plum, Ice Blue, Black, & White", 21);
            AddChoice("Greens, Mystics, & Browns", 22);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_SKIN_COLOUR_CHOICE: {
            sText = "Pick a colour ";
            sText += "(" + GetStringByStrRef(128) + ")"; // Skin Color
            SetHeader(sText);
            int nCategory = GetLocalInt(OBJECT_SELF, "CATEGORY_SELECTED");
            AddColourChoices(nStage, nCategory);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_SKIN_COLOUR_CHECK: {
            sText = "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_HAIR_COLOUR: {
            sText = "Pick a colour category ";
            sText += "(" + GetStringByStrRef(125) + ")"; // Hair Color
            SetHeader(sText);
            AddChoice("Keep current hair colour", -1);
            AddChoice("Chestnuts and Reds", 1);
            AddChoice("Blondes and Browns", 2);
            AddChoice("White, Greys and Black", 3);
            AddChoice("Blues", 4);
            AddChoice("Greens", 5);
            AddChoice("Spring Greens and Yellows", 6);
            AddChoice("Oranges and Pinks", 7);
            // new colours
            AddChoice("Metallic & pure white and black", 8);
            AddChoice("Smoky Group 1", 9);
            AddChoice("Smoky Group 2", 10);
            AddChoice("Smoky Group 3", 11);
            AddChoice("Smoky Group 4", 12);
            AddChoice("Black Cherry & Cinnamon", 13);
            AddChoice("Hunter Green & Druid Green", 14);
            AddChoice("Graveyard Fog & Chestnut", 15);
            AddChoice("Clay & Toasted Ash", 16);
            AddChoice("Snail Brown & Cobalt Blue", 17);
            AddChoice("Midnight Blue & Peacock Green", 18);
            AddChoice("Royal Purple, Mountain Blue, & Sea Foam Green", 19);
            AddChoice("Spring Green, Honey Gold, Copper Coin & Berry Ice", 20);
            AddChoice("Sugar Plum, Ice Blue, Black, & White", 21);
            AddChoice("Greens, Mystics, & Browns", 22);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_HAIR_COLOUR_CHOICE: {
            sText = "Pick a colour ";
            sText += "(" + GetStringByStrRef(125) + ")"; // Hair Color
            SetHeader(sText);
            int nCategory = GetLocalInt(OBJECT_SELF, "CATEGORY_SELECTED");
            AddColourChoices(nStage, nCategory);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_HAIR_COLOUR_CHECK: {
            sText = "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_TATTOO1_COLOUR: {
            sText = "Pick a colour category ";
            sText += "(" + GetStringByStrRef(337) + ")"; // Tattoo Colors
            SetHeader(sText);
            AddChoice("Keep current tattoo 1 colour", -1);
            AddChoice("Tan/Brown & Tan/Red", 1);
            AddChoice("Tan/Yellow & Tan/Grey", 2);
            AddChoice("Olive, White, Grey & Charcoal", 3);
            AddChoice("Blue, Aqua, Teal & Green", 4);
            AddChoice("Yellow, Orange, Red & Pink", 5);
            AddChoice("Purple, Violet & Shiny/Metallic group 1", 6);
            AddChoice("Shiny/Metallic group 2", 7);
            // new colours
            AddChoice("Metallic & pure white and black", 8);
            AddChoice("Smoky Group 1", 9);
            AddChoice("Smoky Group 2", 10);
            AddChoice("Smoky Group 3", 11);
            AddChoice("Smoky Group 4", 12);
            AddChoice("Black Cherry & Cinnamon", 13);
            AddChoice("Hunter Green & Druid Green", 14);
            AddChoice("Graveyard Fog & Chestnut", 15);
            AddChoice("Clay & Toasted Ash", 16);
            AddChoice("Snail Brown & Cobalt Blue", 17);
            AddChoice("Midnight Blue & Peacock Green", 18);
            AddChoice("Royal Purple, Mountain Blue, & Sea Foam Green", 19);
            AddChoice("Spring Green, Honey Gold, Copper Coin & Berry Ice", 20);
            AddChoice("Sugar Plum, Ice Blue, Black, & White", 21);
            AddChoice("Greens, Mystics, & Browns", 22);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_TATTOO1_COLOUR_CHOICE: {
            sText = "Pick a colour ";
            sText += "(" + GetStringByStrRef(337) + ")"; // Tattoo Colors
            SetHeader(sText);
            int nCategory = GetLocalInt(OBJECT_SELF, "CATEGORY_SELECTED");
            AddColourChoices(nStage, nCategory);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_TATTOO1_COLOUR_CHECK: {
            sText = "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case STAGE_TATTOO2_COLOUR: {
            sText = "Pick a colour category ";
            sText += "(" + GetStringByStrRef(337) + ")"; // Tattoo Colors
            SetHeader(sText);
            AddChoice("Keep current tattoo 2 colour", -1);
            AddChoice("Tan/Brown & Tan/Red", 1);
            AddChoice("Tan/Yellow & Tan/Grey", 2);
            AddChoice("Olive, White, Grey & Charcoal", 3);
            AddChoice("Blue, Aqua, Teal & Green", 4);
            AddChoice("Yellow, Orange, Red & Pink", 5);
            AddChoice("Purple, Violet & Shiny/Metallic group 1", 6);
            AddChoice("Shiny/Metallic group 2", 7);
            // new colours
            AddChoice("Metallic & pure white and black", 8);
            AddChoice("Smoky Group 1", 9);
            AddChoice("Smoky Group 2", 10);
            AddChoice("Smoky Group 3", 11);
            AddChoice("Smoky Group 4", 12);
            AddChoice("Black Cherry & Cinnamon", 13);
            AddChoice("Hunter Green & Druid Green", 14);
            AddChoice("Graveyard Fog & Chestnut", 15);
            AddChoice("Clay & Toasted Ash", 16);
            AddChoice("Snail Brown & Cobalt Blue", 17);
            AddChoice("Midnight Blue & Peacock Green", 18);
            AddChoice("Royal Purple, Mountain Blue, & Sea Foam Green", 19);
            AddChoice("Spring Green, Honey Gold, Copper Coin & Berry Ice", 20);
            AddChoice("Sugar Plum, Ice Blue, Black, & White", 21);
            AddChoice("Greens, Mystics, & Browns", 22);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_TATTOO2_COLOUR_CHOICE: {
            sText = "Pick a colour ";
            sText += "(" + GetStringByStrRef(337) + ")"; // Tattoo Colors
            SetHeader(sText);
            int nCategory = GetLocalInt(OBJECT_SELF, "CATEGORY_SELECTED");
            AddColourChoices(nStage, nCategory);
            MarkStageSetUp(nStage);
            SetDefaultTokens();
            break;
        }
        case STAGE_TATTOO2_COLOUR_CHECK: {
            sText = "\n"+GetStringByStrRef(16824210); // Is this correct?
            SetHeader(sText);
            // choices Y/N
            AddChoice(GetStringByStrRef(4753), -1); // no
            AddChoice(GetStringByStrRef(4752), 1); // yes
            MarkStageSetUp(nStage);
            break;
        }
        case FINAL_STAGE: {
            sText = "Your character will now be generated. As part of this process, you will be booted. Please exit NWN completely before rejoining.";
            SetHeader(sText);
            AddChoice("Make Character", 1);
            MarkStageSetUp(nStage);
            // give the PC the woodsman outfit so they don't have to be naked
            CreateItemOnObject("NW_CLOTH001", OBJECT_SELF);
            break;
        }
        default:
            DoDebug("ccc_inc_convo: DoHeaderAndChoices(): Unknown nStage value: " + IntToString(nStage));
    }
}

int HandleChoice(int nStage, int nChoice)
{
    switch(nStage)
    {
        case STAGE_INTRODUCTION:
            nStage++;
            break;

        case STAGE_GENDER:
            SetLocalInt(OBJECT_SELF, "Gender", nChoice);
            nStage++;
            break;

        case STAGE_GENDER_CHECK: {
            if(nChoice == 1)
                nStage++;
            else // go back to pick gender
            {
                nStage = STAGE_GENDER;
                MarkStageNotSetUp(STAGE_GENDER_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_GENDER, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Gender");
            }
            break;
        }
        case STAGE_RACE:
            SetLocalInt(OBJECT_SELF, "Race", nChoice);
            nStage++;
            break;
        case STAGE_RACE_CHECK: {
            if(nChoice == 1)
            {
                nStage++;
                DoCutscene(OBJECT_SELF);
                // store racial feat variables
                AddRaceFeats(GetLocalInt(OBJECT_SELF, "Race"));
            }
            else // go back and pick race
            {
                nStage = STAGE_RACE;
                MarkStageNotSetUp(STAGE_RACE_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_RACE, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Race");
            }
            break;
        }
        case STAGE_CLASS:
            SetLocalInt(OBJECT_SELF, "Class", nChoice);
            nStage++;
            break;
        case STAGE_CLASS_CHECK: {
            if(nChoice == 1)
            {
                nStage++;
                // add class feats
                AddClassFeats(GetLocalInt(OBJECT_SELF, "Class"));
                // now for hitpoints (without con alteration)
                SetLocalInt(OBJECT_SELF, "HitPoints",
                    StringToInt(Get2DACache("classes", "HitDie",
                        GetLocalInt(OBJECT_SELF, "Class"))));
            }
            else // go back and pick class
            {
                nStage = STAGE_CLASS;
                MarkStageNotSetUp(STAGE_CLASS_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_CLASS, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Class");
            }
            break;
        }
        case STAGE_ALIGNMENT: {
            // for stage check later
            SetLocalInt(OBJECT_SELF, "AlignChoice", nChoice);
            switch(nChoice)
            {
                case 112: //lawful good
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 85);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 85);
                    break;
                case 115: //neutral good
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 50);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 85);
                    break;
                case 118: //chaotic good
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 15);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 85);
                    break;
                case 113: //lawful neutral
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 85);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 50);
                    break;
                case 116: //true neutral
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 50);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 50);
                    break;
                case 119: //chaotic neutral
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 15);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 50);
                    break;
                case 114: //lawful evil
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 85);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 15);
                    break;
                case 117: //neutral evil
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 50);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 15);
                    break;
                case 120: //chaotic evil
                    SetLocalInt(OBJECT_SELF, "LawfulChaotic", 15);
                    SetLocalInt(OBJECT_SELF, "GoodEvil", 15);
                    break;
                default:
                    DoDebug("Duh, that clearly didn't work right");
            }
            nStage++;
            break;
        }
        case STAGE_ALIGNMENT_CHECK: {
            if(nChoice == 1)
            {
                nStage++;
            }
            else // go back and pick alignment
            {
                nStage = STAGE_ALIGNMENT;
                MarkStageNotSetUp(STAGE_ALIGNMENT_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_ALIGNMENT, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "AlignChoice");
                DeleteLocalInt(OBJECT_SELF, "LawfulChaotic");
                DeleteLocalInt(OBJECT_SELF, "GoodEvil");
            }
            break;
        }
        case STAGE_ABILITY: {
            int nAbilityScore;
            switch(nChoice)
            {
                case ABILITY_STRENGTH:
                    nAbilityScore = IncreaseAbilityScore(GetLocalInt(OBJECT_SELF, "Str"));
                    SetLocalInt(OBJECT_SELF, "Str", nAbilityScore);
                    break;
                case ABILITY_DEXTERITY:
                    nAbilityScore = IncreaseAbilityScore(GetLocalInt(OBJECT_SELF, "Dex"));
                    SetLocalInt(OBJECT_SELF, "Dex", nAbilityScore);
                    break;
                case ABILITY_CONSTITUTION:
                    nAbilityScore = IncreaseAbilityScore(GetLocalInt(OBJECT_SELF, "Con"));
                    SetLocalInt(OBJECT_SELF, "Con", nAbilityScore);
                    break;
                case ABILITY_INTELLIGENCE:
                    nAbilityScore = IncreaseAbilityScore(GetLocalInt(OBJECT_SELF, "Int"));
                    SetLocalInt(OBJECT_SELF, "Int", nAbilityScore);
                    break;
                case ABILITY_WISDOM:
                    nAbilityScore = IncreaseAbilityScore(GetLocalInt(OBJECT_SELF, "Wis"));
                    SetLocalInt(OBJECT_SELF, "Wis", nAbilityScore);
                    break;
                case ABILITY_CHARISMA:
                    nAbilityScore = IncreaseAbilityScore(GetLocalInt(OBJECT_SELF, "Cha"));
                    SetLocalInt(OBJECT_SELF, "Cha", nAbilityScore);
                    break;
            }
            int nPoints = GetLocalInt(OBJECT_SELF, "Points"); // new total
            if (nPoints) // if there's still points to allocate
            {
                // resets the stage so that the convo choices reflect the new ability scores
                ClearCurrentStage();
            }
            else
                nStage++; // go to next stage
            break;
        }
        case STAGE_ABILITY_CHECK:{
            if(nChoice == 1)
            {
                nStage++;
            }
            else // go back and reselect ability score
            {
                nStage = STAGE_ABILITY;
                MarkStageNotSetUp(STAGE_ABILITY_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_ABILITY, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Str");
                DeleteLocalInt(OBJECT_SELF, "Dex");
                DeleteLocalInt(OBJECT_SELF, "Con");
                DeleteLocalInt(OBJECT_SELF, "Int");
                DeleteLocalInt(OBJECT_SELF, "Wis");
                DeleteLocalInt(OBJECT_SELF, "Cha");
            }
            break;
        }
        case STAGE_SKILL: {
            // first time through, create the skills array
            if(!array_exists(OBJECT_SELF, "Skills"))
                array_create(OBJECT_SELF, "Skills");
            // get current points
            int nPoints = GetLocalInt(OBJECT_SELF, "Points");
            if(GetChoice(OBJECT_SELF) == -2) // save all remaining points
            {
                SetLocalInt(OBJECT_SELF, "SavedSkillPoints", nPoints);
                nPoints = 0;    
            }
            else // chosen a skill to increase
            {
                // get the cls_skill_*** 2da to use
                string sFile = Get2DACache("classes", "SkillsTable", GetLocalInt(OBJECT_SELF, "Class"));
                // work out what line in skills.2da it corresponds to
                int nSkillIndex = StringToInt(Get2DACache(sFile, "SkillIndex", nChoice));
                //increase the points in that skill
                // the array index is the line number in skills.2da
                array_set_int(OBJECT_SELF, "Skills", nSkillIndex,
                    array_get_int(OBJECT_SELF, "Skills", nSkillIndex)+1);
                //decrease points remaining
                // see if it's class or cross-class
                int nClassSkill = StringToInt(Get2DACache(sFile, "ClassSkill", nChoice));
                if (nClassSkill) // class skill
                    nPoints -= 1;
                else // cross class skill
                    nPoints -= 2;
            }
            // store new points total
            SetLocalInt(OBJECT_SELF, "Points", nPoints);
            if (nPoints) // still some left to allocate
            {
                // Store offset so that if the user decides not to take the power,
                // we can return to the same page in the power list instead of resetting to the beginning
                // Store the value +1 in order to be able to differentiate between offset 0 and undefined
                SetLocalInt(OBJECT_SELF, "SkillListChoiceOffset", GetLocalInt(OBJECT_SELF, DYNCONV_CHOICEOFFSET) + 1);
                ClearCurrentStage();
            }
            else
                nStage++;
            break;
        }
        case STAGE_SKILL_CHECK: {
            if (nChoice == 1)
                nStage++;
            else
            {
                nStage = STAGE_SKILL;
                MarkStageNotSetUp(STAGE_SKILL_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_SKILL, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "SavedSkillPoints");
                DeleteLocalInt(OBJECT_SELF, "Points");
                array_delete(OBJECT_SELF, "Skills");
            }
            break;
        }
        case STAGE_FEAT: {
            int nArraySize = array_get_size(OBJECT_SELF, "Feats");
            // alertness fix
            if (nChoice == 0)
                nChoice = -1;
            // add the feat chosen to the feat array
            array_set_int(OBJECT_SELF, "Feats", array_get_size(OBJECT_SELF, "Feats"), nChoice);
            nStage++;
            break;
        }
        case STAGE_FEAT_CHECK: {
            if (nChoice == 1)
            {
                // delete the stored convo choice list
                ClearCachedChoices();
                // decrement the number of feats left to pick
                int nFeatsRemaining = GetLocalInt(OBJECT_SELF, "Points");
                --nFeatsRemaining;
                // check new number of feats left
                if (nFeatsRemaining == 0)
                {
                    // no more feats left to pick
                    // if there's a bonus feat to pick, go to next stage
                    nFeatsRemaining = StringToInt(Get2DACache(Get2DACache("Classes", "BonusFeatsTable", 
                        GetLocalInt(OBJECT_SELF, "Class")), "Bonus", 0));
                    if (nFeatsRemaining)
                    {
                        // go to bonus feat stage
                        nStage = STAGE_BONUS_FEAT;
                    }
                    else
                    {
                        // go to next stage after that the PC qualifies for
                        nStage = GetNextCCCStage(nStage);
                    }
                }
                else 
                {
                    // go back to feat stage to pick next feat
                    nStage = STAGE_FEAT;
                    MarkStageNotSetUp(STAGE_FEAT_CHECK, OBJECT_SELF);
                    MarkStageNotSetUp(STAGE_FEAT, OBJECT_SELF);
                }
                SetLocalInt(OBJECT_SELF, "Points", nFeatsRemaining);
            }
            else
            {
                nStage = STAGE_FEAT;
                MarkStageNotSetUp(STAGE_FEAT_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_FEAT, OBJECT_SELF);
                // delete the chosen feat
                if(array_shrink(OBJECT_SELF, "Feats", (array_get_size(OBJECT_SELF, "Feats") - 1)) != SDL_SUCCESS)
                    DoDebug("No feats array!");
            }
            break;
        }
        case STAGE_BONUS_FEAT: {
            int nArraySize = array_get_size(OBJECT_SELF, "Feats");
            // alertness fix
            if (nChoice == 0)
                nChoice = -1;
            // add the feat chosen to the feat array
            array_set_int(OBJECT_SELF, "Feats", array_get_size(OBJECT_SELF, "Feats"), nChoice);
            nStage++;
            break;
        }
        case STAGE_BONUS_FEAT_CHECK: {
            if (nChoice == 1)
            {
                // delete the stored convo choice list
                ClearCachedChoices();
                // decrement the number of feats left to pick
                int nFeatsRemaining = GetLocalInt(OBJECT_SELF, "Points");
                --nFeatsRemaining;
                // check new number of feats left
                if (nFeatsRemaining == 0)
                {
                    // no more feats left to pick
                    // tidy up locals
                    DeleteLocalInt(OBJECT_SELF, "bHasAnimalEmpathy");
                    DeleteLocalInt(OBJECT_SELF, "bHasUMD");
                    // go to next stage after that the PC qualifies for
                    nStage = GetNextCCCStage(nStage);
                }
                else 
                {
                    // go back to feat stage to pick next feat
                    nStage = STAGE_BONUS_FEAT;
                    MarkStageNotSetUp(STAGE_BONUS_FEAT_CHECK, OBJECT_SELF);
                    MarkStageNotSetUp(STAGE_BONUS_FEAT, OBJECT_SELF);
                }
                SetLocalInt(OBJECT_SELF, "Points", nFeatsRemaining);
            }
            else
            {
                nStage = STAGE_BONUS_FEAT;
                MarkStageNotSetUp(STAGE_BONUS_FEAT_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_BONUS_FEAT, OBJECT_SELF);
                // delete the chosen feat
                if(array_shrink(OBJECT_SELF, "Feats", (array_get_size(OBJECT_SELF, "Feats") - 1)) != SDL_SUCCESS)
                    DoDebug("No feats array!");
            }
            break;
        }
        case STAGE_WIZ_SCHOOL: {
            SetLocalInt(OBJECT_SELF, "School", GetChoice());
            nStage++;
            break;
        }
        case STAGE_WIZ_SCHOOL_CHECK: {
            if(nChoice == 1)
            {
                // go to next stage after that the PC qualifies for
                nStage = GetNextCCCStage(nStage);
                // add cantrips - wizards know all of them so don't need to choose
                SetWizCantrips(GetLocalInt(OBJECT_SELF, "School"));
            }
            else // go back and pick the school again
            {
                nStage = STAGE_WIZ_SCHOOL;
                MarkStageNotSetUp(STAGE_WIZ_SCHOOL_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_WIZ_SCHOOL, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "School");
            }
            break;
        }
        case STAGE_SPELLS_0: {
            // create the array first time through
            if (!array_exists(OBJECT_SELF, "SpellLvl0"))
                array_create(OBJECT_SELF, "SpellLvl0");
            int nPoints = GetLocalInt(OBJECT_SELF, "Points");
            // add the choice to the spells known array
            array_set_int(OBJECT_SELF, "SpellLvl0", array_get_size(OBJECT_SELF, "SpellLvl0"), nChoice);
            // decrement the number of spells left to select
            SetLocalInt(OBJECT_SELF, "Points", --nPoints);
            if (nPoints) // still some left to allocate
                ClearCurrentStage();
            else // go to next stage after that the PC qualifies for
                nStage = GetNextCCCStage(nStage);
            break;
        }
        case STAGE_SPELLS_1: {
            // create the array first time through
            if (!array_exists(OBJECT_SELF, "SpellLvl1"))
                array_create(OBJECT_SELF, "SpellLvl1");
            int nPoints = GetLocalInt(OBJECT_SELF, "Points");
            // add the choice to the spells known array
            array_set_int(OBJECT_SELF, "SpellLvl1", array_get_size(OBJECT_SELF, "SpellLvl1"), nChoice);
            // decrement the number of spells left to select
            SetLocalInt(OBJECT_SELF, "Points", --nPoints);
            if (nPoints) // still some left to allocate
                ClearCurrentStage();
            else // go to next stage after that the PC qualifies for
                nStage = GetNextCCCStage(nStage);
            break;
        }
        case STAGE_SPELLS_CHECK: {
            if(nChoice == 1)
            {
                // go to next stage after that the PC qualifies for
                nStage = GetNextCCCStage(nStage);
                int nClass = GetLocalInt(OBJECT_SELF, "Class");
                // get the cls_spgn_***2da to use
                string sSpgn = Get2DACache("classes", "SpellGainTable", nClass);
                int nSpellsPerDay;
                // level 1 spells
                if (array_exists(OBJECT_SELF, "SpellLvl1"))
                {
                    nSpellsPerDay = StringToInt(Get2DACache(sSpgn, "SpellLevel1", 0));
                    SetLocalInt(OBJECT_SELF, "SpellsPerDay1", nSpellsPerDay);
                }
                // cantrips
                if (array_exists(OBJECT_SELF, "SpellLvl0"))
                {
                    nSpellsPerDay = StringToInt(Get2DACache(sSpgn, "SpellLevel0", 0));
                    SetLocalInt(OBJECT_SELF, "SpellsPerDay0", nSpellsPerDay);
                }
            }
            else // go back and pick the spells again
            {
                // hacky...but returns the right stage, depending on the class
                nStage = GetNextCCCStage(STAGE_WIZ_SCHOOL_CHECK);
                MarkStageNotSetUp(STAGE_SPELLS_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_SPELLS_1, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_SPELLS_0, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Points");
                array_delete(OBJECT_SELF, "SpellLvl1");
                if(nStage == STAGE_SPELLS_0)
                {
                    // if the new value of nStage takes us back to picking cantrips,
                    // then also delete the level 0 array
                    array_delete(OBJECT_SELF, "SpellLvl0");
                }
            }
            break;
        }
        case STAGE_FAMILIAR: {
            if(GetLocalInt(OBJECT_SELF, "Class") == CLASS_TYPE_DRUID)
                SetLocalInt(OBJECT_SELF, "Companion", nChoice);
            else // sorc or wiz
                SetLocalInt(OBJECT_SELF, "Familiar", nChoice);
            nStage++;
            break;
        }
        case STAGE_FAMILIAR_CHECK: {
            if (nChoice == 1)
                nStage = GetNextCCCStage(nStage);
            else
            {
                nStage = STAGE_FAMILIAR;
                MarkStageNotSetUp(STAGE_FAMILIAR_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_FAMILIAR, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Familiar");
                DeleteLocalInt(OBJECT_SELF, "Companion");
            }
            break;
        }
        case STAGE_DOMAIN: {
            // if this is the first domain chosen
            if (GetLocalInt(OBJECT_SELF, "Domain1") == 0)
            {
                // fix for air domain being 0
                if (nChoice == 0)
                    nChoice = -1;
                SetLocalInt(OBJECT_SELF, "Domain1", nChoice);
                nStage = STAGE_DOMAIN_CHECK1;
            }
            else // second domain
            {
                // fix for air domain being 0
                if (nChoice == 0)
                    nChoice = -1;
                SetLocalInt(OBJECT_SELF, "Domain2", nChoice);
                nStage = STAGE_DOMAIN_CHECK2;
            }    
            break;
        }
        case STAGE_DOMAIN_CHECK1: {
            if (nChoice == 1)
            {
                nStage = STAGE_DOMAIN;
                MarkStageNotSetUp(STAGE_DOMAIN_CHECK1);
                MarkStageNotSetUp(STAGE_DOMAIN);
            }
            else
            {
                nStage = STAGE_DOMAIN;
                MarkStageNotSetUp(STAGE_DOMAIN_CHECK1);
                MarkStageNotSetUp(STAGE_DOMAIN);
                DeleteLocalInt(OBJECT_SELF,"Domain1");
                DeleteLocalInt(OBJECT_SELF,"Domain2");
            }
            break;
        }
        case STAGE_DOMAIN_CHECK2: {
            if (nChoice == 1)
            {
                nStage++;
                // add domain feats
                AddDomainFeats();
            }
            else
            {
                nStage = STAGE_DOMAIN;
                MarkStageNotSetUp(STAGE_DOMAIN_CHECK2);
                MarkStageNotSetUp(STAGE_DOMAIN);
                DeleteLocalInt(OBJECT_SELF,"Domain1");
                DeleteLocalInt(OBJECT_SELF,"Domain2");
            }
            break;
        }
        case STAGE_APPEARANCE: {
            if (nChoice == -1) // no change
            {
                SetLocalInt(OBJECT_SELF, "Appearance", GetAppearanceType(OBJECT_SELF));
                nStage = STAGE_PORTRAIT;
            }
            else
            {
                SetLocalInt(OBJECT_SELF, "Appearance", nChoice);
                SetCreatureAppearanceType(OBJECT_SELF, nChoice);
                // change the appearance
                DoCutscene(OBJECT_SELF);
                nStage++;
            }
            break;
        }
        case STAGE_APPEARANCE_CHECK: {
            if (nChoice == 1)
            {
                nStage++;
            }
            else
            {
                nStage = STAGE_APPEARANCE;
                MarkStageNotSetUp(STAGE_APPEARANCE_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_APPEARANCE, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Appearance");
            }
            break;
        }
        case STAGE_PORTRAIT: {
            if (nChoice == -1) // no change
            {
                nStage = STAGE_SOUNDSET;
            }
            else
            {
                // change the portrait
                SetPortraitId(OBJECT_SELF, nChoice);
                // change the clone's portrait
                object oClone = GetLocalObject(OBJECT_SELF, "Clone");
                SetPortraitId(oClone, nChoice);
                nStage++;
            }
            break;
        }
        case STAGE_PORTRAIT_CHECK: {
            if (nChoice == 2)
            {
                object oClone = GetLocalObject(OBJECT_SELF, "Clone");
                ActionExamine(oClone);
                // DelayCommand(1.0, ActionExamine(oClone));
                // DelayCommand(2.0, ActionExamine(oClone));
            }
            else if (nChoice == 1)
            {
                nStage++;
            }
            else
            {
                nStage = STAGE_PORTRAIT;
                MarkStageNotSetUp(STAGE_PORTRAIT_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_PORTRAIT, OBJECT_SELF);
            }
            break;
        }
        case STAGE_SOUNDSET: {
            if (nChoice == -1) // no change
            {
                SetLocalInt(OBJECT_SELF, "Soundset", nChoice);
                nStage = GetNextCCCStage(nStage, FALSE);
            }
            else
            {
                // store the choice
                SetLocalInt(OBJECT_SELF, "Soundset", nChoice);
                // modify the clone
                DoCutscene(OBJECT_SELF);
                nStage++;
            }
            break;
        }
        case STAGE_SOUNDSET_CHECK: {
            if (nChoice == 2)
            {
                object oClone = GetLocalObject(OBJECT_SELF, "Clone");
                PlayVoiceChat(0 , oClone);
            }
            else if (nChoice == 1)
            {
                // set up colour defaults here to make sure they don't reset for non-player type appearances
                SetLocalInt(OBJECT_SELF, "Skin", -1);
                SetLocalInt(OBJECT_SELF, "Hair", -1);
                SetLocalInt(OBJECT_SELF, "TattooColour1", -1);
                SetLocalInt(OBJECT_SELF, "TattooColour2", -1);
                nStage = GetNextCCCStage(nStage, FALSE);
            }
            else
            {
                nStage = STAGE_SOUNDSET;
                MarkStageNotSetUp(STAGE_SOUNDSET_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_SOUNDSET, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Soundset");
            }
            break;
        }
        case STAGE_HEAD: {
            if (nChoice == -1) // no change
            {
                nStage = GetNextCCCStage(nStage, FALSE);
            }
            else
            {
                // change the head
                SetCreatureBodyPart(CREATURE_PART_HEAD, nChoice);
                // modify the clone's head
                object oClone = GetLocalObject(OBJECT_SELF, "Clone");
                SetCreatureBodyPart(CREATURE_PART_HEAD, nChoice, oClone);
                nStage++;
            }
            break;
        }
        case STAGE_HEAD_CHECK: {
            if (nChoice == 1)
            {
                nStage = GetNextCCCStage(nStage, FALSE);
            }
            else
            {
                nStage = STAGE_HEAD;
                MarkStageNotSetUp(STAGE_HEAD_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_HEAD, OBJECT_SELF);
            }
            break;
        }
        case STAGE_TATTOO: {
            if (nChoice == -1) // no change
            {
                nStage = GetNextCCCStage(nStage, FALSE);
            }
            else
            {
                int nTattooed = GetCreatureBodyPart(nChoice, OBJECT_SELF);
                if(nTattooed == 1)
                    nTattooed = 2;
                else if(nTattooed == 2)
                    nTattooed = 1;
                // change the tattoo on the clone
                SetCreatureBodyPart(nChoice, nTattooed, 
                    GetLocalObject(OBJECT_SELF, "Clone"));
                // change the tattoo on the PC
                SetCreatureBodyPart(nChoice, nTattooed); 
            }
            break;
        }
        case STAGE_TATTOO_CHECK: {
            if (nChoice == 1)
            {
                nStage = GetNextCCCStage(nStage, FALSE);
            }
            else
            {
                nStage = STAGE_TATTOO;
                MarkStageNotSetUp(STAGE_TATTOO_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_TATTOO, OBJECT_SELF);
            }
            break;
        }
        case STAGE_WINGS: {
            SetCreatureWingType(nChoice);
            // alter the clone
            object oClone = GetLocalObject(OBJECT_SELF, "Clone");
            SetCreatureWingType(nChoice, oClone);
            nStage++;
            break;
        }
        case STAGE_WINGS_CHECK: {
            if (nChoice == 1)
            {
                nStage = GetNextCCCStage(nStage, FALSE);
            }
            else
            {
                nStage = STAGE_WINGS;
                MarkStageNotSetUp(STAGE_WINGS_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_WINGS, OBJECT_SELF);
            }
            break;
        }
        case STAGE_TAIL: {
            SetCreatureTailType(nChoice);
            // alter the clone
            object oClone = GetLocalObject(OBJECT_SELF, "Clone");
            SetCreatureTailType(nChoice, oClone);
            nStage++;
            break;
        }
        case STAGE_TAIL_CHECK: {
            if (nChoice == 1)
            {
                nStage = GetNextCCCStage(nStage, FALSE);
            }
            else
            {
                nStage = STAGE_TAIL;
                MarkStageNotSetUp(STAGE_TAIL_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_TAIL, OBJECT_SELF);
            }
            break;
        }
        case STAGE_SKIN_COLOUR: {
            if (nChoice == -1) // keep existing
            {
                nStage = STAGE_SKIN_COLOUR_CHECK;
                SetLocalInt(OBJECT_SELF, "Skin", -1);
            }
            else
            {
                SetLocalInt(OBJECT_SELF, "CATEGORY_SELECTED", nChoice);
                nStage++;
            }
            break;
        }
        case STAGE_SKIN_COLOUR_CHOICE: {
            SetLocalInt(OBJECT_SELF, "Skin", nChoice);
            // change the clone
            DoCutscene(OBJECT_SELF);
            nStage++;
            break;
        }
        case STAGE_SKIN_COLOUR_CHECK: {
            if (nChoice == 1)
            {
                nStage++;
            }
            else
            {
                nStage = STAGE_SKIN_COLOUR;
                MarkStageNotSetUp(STAGE_SKIN_COLOUR_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_SKIN_COLOUR_CHOICE, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_SKIN_COLOUR, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Skin");
            }
            DeleteLocalInt(OBJECT_SELF, "CATEGORY_SELECTED");
            break;
        }
        case STAGE_HAIR_COLOUR: {
            if (nChoice == -1) // keep existing
            {
                nStage = STAGE_HAIR_COLOUR_CHECK;
                SetLocalInt(OBJECT_SELF, "Hair", -1);
            }
            else
            {
                SetLocalInt(OBJECT_SELF, "CATEGORY_SELECTED", nChoice);
                nStage++;
            }
            break;
        }
        case STAGE_HAIR_COLOUR_CHOICE: {
            SetLocalInt(OBJECT_SELF, "Hair", nChoice);
            // change the clone
            DoCutscene(OBJECT_SELF);
            nStage++;
            break;
        }
        case STAGE_HAIR_COLOUR_CHECK: {
            if (nChoice == 1)
            {
                nStage++;
            }
            else
            {
                nStage = STAGE_HAIR_COLOUR;
                MarkStageNotSetUp(STAGE_HAIR_COLOUR_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_HAIR_COLOUR_CHOICE, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_HAIR_COLOUR, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "Hair");
            }
            DeleteLocalInt(OBJECT_SELF, "CATEGORY_SELECTED");
            break;
        }
        case STAGE_TATTOO1_COLOUR: {
            if (nChoice == -1) // keep existing
            {
                nStage = STAGE_TATTOO1_COLOUR_CHECK;
                SetLocalInt(OBJECT_SELF, "TattooColour1", -1);
            }
            else
            {
                SetLocalInt(OBJECT_SELF, "CATEGORY_SELECTED", nChoice);
                nStage++;
            }
            break;
        }
        case STAGE_TATTOO1_COLOUR_CHOICE: {
            SetLocalInt(OBJECT_SELF, "TattooColour1", nChoice);
            // change the clone
            DoCutscene(OBJECT_SELF);
            nStage++;
            break;
        }
        case STAGE_TATTOO1_COLOUR_CHECK: {
            if (nChoice == 1)
            {
                nStage++;
            }
            else
            {
                nStage = STAGE_TATTOO1_COLOUR;
                MarkStageNotSetUp(STAGE_TATTOO1_COLOUR_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_TATTOO1_COLOUR_CHOICE, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_TATTOO1_COLOUR, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "TattooColour1");
            }
            DeleteLocalInt(OBJECT_SELF, "CATEGORY_SELECTED");
            break;
        }
        case STAGE_TATTOO2_COLOUR: {
            if (nChoice == -1) // keep existing
            {
                nStage = STAGE_TATTOO2_COLOUR_CHECK;
                SetLocalInt(OBJECT_SELF, "TattooColour2", -1);
            }
            else
            {
                SetLocalInt(OBJECT_SELF, "CATEGORY_SELECTED", nChoice);
                nStage++;
            }
            break;
        }
        case STAGE_TATTOO2_COLOUR_CHOICE: {
            SetLocalInt(OBJECT_SELF, "TattooColour2", nChoice);
            // change the clone
            DoCutscene(OBJECT_SELF);
            nStage++;
            break;
        }
        case STAGE_TATTOO2_COLOUR_CHECK: {
            if (nChoice == 1)
            {
                nStage = FINAL_STAGE;
            }
            else
            {
                nStage = STAGE_TATTOO2_COLOUR;
                MarkStageNotSetUp(STAGE_TATTOO2_COLOUR_CHECK, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_TATTOO2_COLOUR_CHOICE, OBJECT_SELF);
                MarkStageNotSetUp(STAGE_TATTOO2_COLOUR, OBJECT_SELF);
                DeleteLocalInt(OBJECT_SELF, "TattooColour2");
            }
            DeleteLocalInt(OBJECT_SELF, "CATEGORY_SELECTED");
            break;
        }
        case FINAL_STAGE: {
            ExecuteScript("prc_ccc_make_pc", OBJECT_SELF);
            AllowExit(DYNCONV_EXIT_FORCE_EXIT);
            break;
        }
    }
    return nStage;
}
