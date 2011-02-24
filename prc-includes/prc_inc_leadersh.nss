//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

const string COHORT_DATABASE     = "PRCCOHORTS";
const string COHORT_TAG          = "prc_cohort";

//in the database there is the folloxing data structures:
/*
    int    CohortCount      (total number of cohorts)
    object Cohort_X_obj     (cohort itself)
    string Cohort_X_name    (cohort name)
    int    Cohort_X_race    (cohort race)
    int    Cohort_X_class1  (cohort class pos1)
    int    Cohort_X_class2  (cohort class pos2)
    int    Cohort_X_class3  (cohort class pos3)
    int    Cohort_X_order   (cohort law/chaos measure)
    int    Cohort_X_moral   (cohort good/evil measure)
    int    Cohort_X_ethran  (cohort has ethran feat)
    string Cohort_X_cdkey   (cdkey of owning player)
*/

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

int GetMaximumCohortCount(object oPC);
object GetCohort(int nID, object oPC);
int GetCurrentCohortCount(object oPC);
int GetCohortMaxLevel(int nLeadership, object oPC);
void RegisterAsCohort(object oPC);
object AddCohortToPlayer(int nCohortID, object oPC);
void AddCohortToPlayerByObject(object oCohort, object oPC, int bDoSetup = TRUE);
void RemoveCohortFromPlayer(object oCohort, object oPC);
int GetLeadershipScore(object oPC = OBJECT_SELF);
void CheckHB(object oPC);
void AddPremadeCohortsToDB();
void StoreCohort(object oCohort);


//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "prc_feat_const"
//#include "inc_utility"
#include "inc_ecl"
#include "inc_nwnx_funcs"
//#include "pnp_shft_poly" //for DoRandomAppearance


//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

object AddCohortToPlayer(int nCohortID, object oPC)
{
    object oCohort = RetrieveCampaignObject(COHORT_DATABASE, "Cohort_"+IntToString(nCohortID)+"_obj", GetLocation(oPC));
    //give it a tag
    AssignCommand(oCohort, SetIsDestroyable(TRUE, FALSE, FALSE));
    DestroyObject(oCohort);
    oCohort = CopyObject(oCohort, GetLocation(oPC), OBJECT_INVALID, COHORT_TAG);
    SetLocalInt(oCohort, "CohortID", nCohortID);
    //pass it to the next function
    AddCohortToPlayerByObject(oCohort, oPC);
    return oCohort;
}

//changes portrait, head, and appearance
//based on the target race with a degree of randomization.
//This should only be used on NPCs, not players.
void DoRandomAppearance(int nRace, object oTarget = OBJECT_SELF)
{
    //store current appearance to be safe
    int nAppearance; //appearance to change into
    int nHeadMax;    //max head ID, changed to random 1-max
    int nGender = GetGender(oTarget);
    int nPortraitMin;//minimum row in portraits.2da
    int nPortraitMax;//maximum row in portraits.2da
    switch(nRace)
    {
        case RACIAL_TYPE_DWARF:
            nAppearance = APPEARANCE_TYPE_DWARF;
            if(nGender == GENDER_MALE)
            {   nHeadMax = 10; nPortraitMin =   9;  nPortraitMax =  17; }
            else
            {   nHeadMax = 12; nPortraitMin =   1;  nPortraitMax =   8; }
            break;
        case RACIAL_TYPE_ELF:
            nAppearance = APPEARANCE_TYPE_ELF;
            if(nGender == GENDER_MALE)
            {   nHeadMax = 10; nPortraitMin =  31;  nPortraitMax =  40; }
            else
            {   nHeadMax = 16; nPortraitMin =  18;  nPortraitMax =  30; }
            break;
        case RACIAL_TYPE_HALFELF:
            nAppearance = APPEARANCE_TYPE_HALF_ELF;
            if(nGender == GENDER_MALE)
            {   nHeadMax = 18; nPortraitMin =  93;  nPortraitMax = 112; }
            else
            {   nHeadMax = 15; nPortraitMin =  67;  nPortraitMax = 92;  }
            break;
        case RACIAL_TYPE_HALFORC:
            nAppearance = APPEARANCE_TYPE_HALF_ORC;
            if(nGender == GENDER_MALE)
            {   nHeadMax = 11; nPortraitMin = 134;  nPortraitMax = 139; }
            else
            {   nHeadMax = 1;  nPortraitMin = 130;  nPortraitMax = 133; }
            break;
        case RACIAL_TYPE_HUMAN:
            nAppearance = APPEARANCE_TYPE_HUMAN;
            if(nGender == GENDER_MALE)
            {   nHeadMax = 18; nPortraitMin = 93;   nPortraitMax = 112; }
            else
            {   nHeadMax = 15; nPortraitMin = 67;   nPortraitMax = 92;  }
            break;
        case RACIAL_TYPE_HALFLING:
            nAppearance = APPEARANCE_TYPE_HALFLING;
            if(nGender == GENDER_MALE)
            {   nHeadMax =  8; nPortraitMin = 61;   nPortraitMax = 66; }
            else
            {   nHeadMax = 11; nPortraitMin = 54;   nPortraitMax = 59;  }
            break;
        case RACIAL_TYPE_GNOME:
            nAppearance = APPEARANCE_TYPE_GNOME;
            if(nGender == GENDER_MALE)
            {   nHeadMax = 11; nPortraitMin = 47;   nPortraitMax = 53; }
            else
            {   nHeadMax =  9; nPortraitMin = 41;   nPortraitMax = 46;  }
            break;
        default: //not a normal race, abort
            return;
    }
    //change the appearance
    SetCreatureAppearanceType(oTarget, nAppearance);

    //need to be delayed a bit otherwise you get "supergnome" and "exploded elf" effects
    DelayCommand(1.1, SetCreatureBodyPart(CREATURE_PART_RIGHT_SHIN,       d2(), oTarget));
    DelayCommand(1.2, SetCreatureBodyPart(CREATURE_PART_LEFT_SHIN,        d2(), oTarget));
    DelayCommand(1.3, SetCreatureBodyPart(CREATURE_PART_RIGHT_THIGH,      d2(), oTarget));
    DelayCommand(1.4, SetCreatureBodyPart(CREATURE_PART_LEFT_THIGH,       d2(), oTarget));
    DelayCommand(1.5, SetCreatureBodyPart(CREATURE_PART_TORSO,            d2(), oTarget));
    DelayCommand(1.6, SetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM,    d2(), oTarget));
    DelayCommand(1.7, SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM,     d2(), oTarget));
    DelayCommand(1.8, SetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP,      d2(), oTarget));
    DelayCommand(1.9, SetCreatureBodyPart(CREATURE_PART_LEFT_BICEP,       d2(), oTarget));
    
    //dont do these body parts, they dont have tattoos and weird things could happen
    //SetCreatureBodyPart(CREATURE_PART_BELT,             d2(), oTarget);
    //SetCreatureBodyPart(CREATURE_PART_NECK,             d2(), oTarget);
    //SetCreatureBodyPart(CREATURE_PART_RIGHT_SHOULDER,   d2(), oTarget);
    //SetCreatureBodyPart(CREATURE_PART_LEFT_SHOULDER,    d2(), oTarget);
    //SetCreatureBodyPart(CREATURE_PART_RIGHT_HAND,       d2(), oTarget);
    //SetCreatureBodyPart(CREATURE_PART_LEFT_HAND,        d2(), oTarget);
    //SetCreatureBodyPart(CREATURE_PART_PELVIS,           d2(), oTarget);
    //SetCreatureBodyPart(CREATURE_PART_RIGHT_FOOT,       d2(), oTarget);
    //SetCreatureBodyPart(CREATURE_PART_LEFT_FOOT,        d2(), oTarget);
    //randomise the head
    DelayCommand(2.0, SetCreatureBodyPart(CREATURE_PART_HEAD, Random(nHeadMax)+1, oTarget));
    
    //remove any wings/tails
    SetCreatureWingType(CREATURE_WING_TYPE_NONE, oTarget);
    SetCreatureTailType(CREATURE_TAIL_TYPE_NONE, oTarget);

    int nPortraitID = Random(nPortraitMax-nPortraitMin+1)+nPortraitMin;
    string sPortraitResRef = Get2DACache("portraits", "BaseResRef", nPortraitID);
    sPortraitResRef = GetStringLeft(sPortraitResRef, GetStringLength(sPortraitResRef)-1); //trim the trailing _
    SetPortraitResRef(oTarget, sPortraitResRef);
    SetPortraitId(oTarget, nPortraitID);
}

void CancelGreatFeats(object oSpawn)
{
    //store how many Great X feats they have
    //this is to fix a bioware bug where de-leveling doesnt remove the stat bonus
    int nGreatStr;
    int nGreatDex;
    int nGreatCon;
    int nGreatInt;
    int nGreatWis;
    int nGreatCha;
    if     (GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_10, oSpawn)) nGreatStr = 10;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_9, oSpawn)) nGreatStr = 9;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_8, oSpawn)) nGreatStr = 8;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_7, oSpawn)) nGreatStr = 7;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_6, oSpawn)) nGreatStr = 6;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_5, oSpawn)) nGreatStr = 5;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_4, oSpawn)) nGreatStr = 4;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_3, oSpawn)) nGreatStr = 3;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_2, oSpawn)) nGreatStr = 2;
    else if(GetHasFeat(FEAT_EPIC_GREAT_STRENGTH_1, oSpawn)) nGreatStr = 1;
    if     (GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_10, oSpawn)) nGreatDex = 10;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_9, oSpawn)) nGreatDex = 9;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_8, oSpawn)) nGreatDex = 8;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_7, oSpawn)) nGreatDex = 7;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_6, oSpawn)) nGreatDex = 6;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_5, oSpawn)) nGreatDex = 5;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_4, oSpawn)) nGreatDex = 4;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_3, oSpawn)) nGreatDex = 3;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_2, oSpawn)) nGreatDex = 2;
    else if(GetHasFeat(FEAT_EPIC_GREAT_DEXTERITY_1, oSpawn)) nGreatDex = 1;
    if     (GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_10, oSpawn)) nGreatCon = 10;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_9, oSpawn)) nGreatCon = 9;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_8, oSpawn)) nGreatCon = 8;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_7, oSpawn)) nGreatCon = 7;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_6, oSpawn)) nGreatCon = 6;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_5, oSpawn)) nGreatCon = 5;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_4, oSpawn)) nGreatCon = 4;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_3, oSpawn)) nGreatCon = 3;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_2, oSpawn)) nGreatCon = 2;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CONSTITUTION_1, oSpawn)) nGreatCon = 1;
    if     (GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_10, oSpawn)) nGreatInt = 10;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_9, oSpawn)) nGreatInt = 9;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_8, oSpawn)) nGreatInt = 8;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_7, oSpawn)) nGreatInt = 7;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_6, oSpawn)) nGreatInt = 6;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_5, oSpawn)) nGreatInt = 5;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_4, oSpawn)) nGreatInt = 4;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_3, oSpawn)) nGreatInt = 3;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_2, oSpawn)) nGreatInt = 2;
    else if(GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_1, oSpawn)) nGreatInt = 1;
    if     (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_10, oSpawn)) nGreatWis = 10;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_9, oSpawn)) nGreatWis = 9;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_8, oSpawn)) nGreatWis = 8;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_7, oSpawn)) nGreatWis = 7;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_6, oSpawn)) nGreatWis = 6;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_5, oSpawn)) nGreatWis = 5;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_4, oSpawn)) nGreatWis = 4;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_3, oSpawn)) nGreatWis = 3;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_2, oSpawn)) nGreatWis = 2;
    else if(GetHasFeat(FEAT_EPIC_GREAT_WISDOM_1, oSpawn)) nGreatWis = 1;
    if     (GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_10, oSpawn)) nGreatCha = 10;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_9, oSpawn)) nGreatCha = 9;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_8, oSpawn)) nGreatCha = 8;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_7, oSpawn)) nGreatCha = 7;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_6, oSpawn)) nGreatCha = 6;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_5, oSpawn)) nGreatCha = 5;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_4, oSpawn)) nGreatCha = 4;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_3, oSpawn)) nGreatCha = 3;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_2, oSpawn)) nGreatCha = 2;
    else if(GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_1, oSpawn)) nGreatCha = 1;

    int bFuncs = GetPRCSwitch(PRC_NWNX_FUNCS);
    //apply penalties to counter the GreatX feats
    if(nGreatStr)
        if(bFuncs)
            PRC_Funcs_ModAbilityScore(oSpawn, ABILITY_STRENGTH, -nGreatStr);
        else
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH, nGreatStr)),
            oSpawn);
    if(nGreatDex)
        if(bFuncs)
            PRC_Funcs_ModAbilityScore(oSpawn, ABILITY_DEXTERITY, -nGreatDex);
        else
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, nGreatDex)),
            oSpawn);
    if(nGreatCon)
        if(bFuncs)
            PRC_Funcs_ModAbilityScore(oSpawn, ABILITY_CONSTITUTION, -nGreatCon);
        else
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, nGreatCon)),
            oSpawn);
    if(nGreatInt)
        if(bFuncs)
            PRC_Funcs_ModAbilityScore(oSpawn, ABILITY_INTELLIGENCE, -nGreatInt);
        else
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE, nGreatInt)),
            oSpawn);
    if(nGreatWis)
        if(bFuncs)
            PRC_Funcs_ModAbilityScore(oSpawn, ABILITY_WISDOM, -nGreatWis);
        else
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM, nGreatWis)),
            oSpawn);
    if(nGreatCha)
        if(bFuncs)
            PRC_Funcs_ModAbilityScore(oSpawn, ABILITY_CHARISMA, -nGreatCha);
        else
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA, nGreatCha)),
            oSpawn);
}

void AddCohortToPlayerByObject(object oCohort, object oPC, int bDoSetup = TRUE)
{
    //add it to the pc
    int nMaxHenchmen = GetMaxHenchmen();
    SetMaxHenchmen(99);
    AddHenchman(oPC, oCohort);
    SetMaxHenchmen(nMaxHenchmen);
    object oSkin  = GetPCSkin(oCohort);

    if(bDoSetup)
    {
        //if it was a premade one, give it a random name
        //randomize its appearance using DoRandomAppearance
        if(GetResRef(oCohort) != "")
        {
            string sName;
            //first name
            switch(MyPRCGetRacialType(oCohort))
            {
                case RACIAL_TYPE_DWARF:
                    if(GetGender(oCohort) == GENDER_FEMALE)
                        sName += RandomName(NAME_FIRST_DWARF_FEMALE);
                    else
                        sName += RandomName(NAME_FIRST_DWARF_MALE);
                    break;
                case RACIAL_TYPE_ELF:
                    if(GetGender(oCohort) == GENDER_FEMALE)
                        sName += RandomName(NAME_FIRST_ELF_FEMALE);
                    else
                        sName += RandomName(NAME_FIRST_ELF_MALE);
                    break;
                case RACIAL_TYPE_GNOME:
                    if(GetGender(oCohort) == GENDER_FEMALE)
                        sName += RandomName(NAME_FIRST_GNOME_FEMALE);
                    else
                        sName += RandomName(NAME_FIRST_GNOME_MALE);
                    break;
                case RACIAL_TYPE_HUMAN:
                    if(GetGender(oCohort) == GENDER_FEMALE)
                        sName += RandomName(NAME_FIRST_HUMAN_FEMALE);
                    else
                        sName += RandomName(NAME_FIRST_HUMAN_MALE);
                    break;
                case RACIAL_TYPE_HALFELF:
                    if(GetGender(oCohort) == GENDER_FEMALE)
                        sName += RandomName(NAME_FIRST_HALFELF_FEMALE);
                    else
                        sName += RandomName(NAME_FIRST_HALFELF_MALE);
                    break;
                case RACIAL_TYPE_HALFORC:
                    if(GetGender(oCohort) == GENDER_FEMALE)
                        sName += RandomName(NAME_FIRST_HALFORC_FEMALE);
                    else
                        sName += RandomName(NAME_FIRST_HALFORC_MALE);
                    break;
                case RACIAL_TYPE_HALFLING:
                    if(GetGender(oCohort) == GENDER_FEMALE)
                        sName += RandomName(NAME_FIRST_HALFLING_FEMALE);
                    else
                        sName += RandomName(NAME_FIRST_HALFLING_MALE);
                    break;
            }
            sName += " ";
            //surname
            switch(MyPRCGetRacialType(oCohort))
            {
                case RACIAL_TYPE_DWARF:
                    sName += RandomName(NAME_LAST_DWARF);
                    break;
                case RACIAL_TYPE_ELF:
                    sName += RandomName(NAME_LAST_ELF);
                    break;
                case RACIAL_TYPE_GNOME:
                    sName += RandomName(NAME_LAST_GNOME);
                    break;
                case RACIAL_TYPE_HUMAN:
                    sName += RandomName(NAME_LAST_HUMAN);
                    break;
                case RACIAL_TYPE_HALFELF:
                    sName += RandomName(NAME_LAST_HALFELF);
                    break;
                case RACIAL_TYPE_HALFORC:
                    sName += RandomName(NAME_LAST_HALFORC);
                    break;
                case RACIAL_TYPE_HALFLING:
                    sName += RandomName(NAME_LAST_HALFLING);
                    break;
            }
            //sanity check
            if(sName == " ")
                sName = "";
            //change the name
            AssignCommand(oCohort, SetName(oCohort, sName));

            //use disguise code to alter head etc
            DoRandomAppearance(MyPRCGetRacialType(oCohort), oCohort);

            //DoRandomAppearance removed wings/tails need to re-add
            if(GetRacialType(oCohort) == RACIAL_TYPE_FEYRI)
                SetCreatureWingType(CREATURE_WING_TYPE_DEMON, oCohort);
            else if(GetRacialType(oCohort) == RACIAL_TYPE_AVARIEL)
                SetCreatureWingType(CREATURE_WING_TYPE_BIRD, oCohort);
        }
        //if its a custom made cohort, need to cancel GreatX feats
        else
            CancelGreatFeats(oCohort);

        //set it to the pcs level
        int nLevel = GetCohortMaxLevel(GetLeadershipScore(oPC), oPC);
        SetXP(oCohort, nLevel*(nLevel-1)*500);
        SetLocalInt(oCohort, "MastersXP", GetXP(oPC));
        DelayCommand(1.0, AssignCommand(oCohort, SetIsDestroyable(FALSE, TRUE, TRUE)));
        DelayCommand(1.0, AssignCommand(oCohort, SetLootable(oCohort, TRUE)));
        //set its maximum level lag
        if(GetCurrentCohortCount(oPC) <= GetPRCSwitch(PRC_BONUS_COHORTS))
        {
            //bonus cohort, no cap
        }
        else if(GetPRCSwitch(PRC_THRALLHERD_LEADERSHIP)
            && GetLevelByClass(CLASS_TYPE_THRALLHERD, oPC)
            && GetCurrentCohortCount(oPC) <= GetPRCSwitch(PRC_BONUS_COHORTS)+1)
        {
            //thrallherd with switch, 1 level lag
            SetLocalInt(oCohort, "CohortLevelLag", 1);
        }
        else if(GetPRCSwitch(PRC_THRALLHERD_LEADERSHIP)
            && GetLevelByClass(CLASS_TYPE_THRALLHERD, oPC) >= 10
            && GetCurrentCohortCount(oPC) <= GetPRCSwitch(PRC_BONUS_COHORTS)+2)
        {
            //twofold master with switch, 2 level lag
            SetLocalInt(oCohort, "CohortLevelLag", 2);
        }
        else
        {
            //other cohort have a 2 level lag
            SetLocalInt(oCohort, "CohortLevelLag", 2);
        }

        //strip its equipment & inventory
        object oTest  = GetFirstItemInInventory(oCohort);
        object oToken = GetHideToken(oCohort);
        while(GetIsObjectValid(oTest))
        {
            if(GetHasInventory(oTest))
            {
                object oTest2 = GetFirstItemInInventory(oTest);
                while(GetIsObjectValid(oTest2))
                {
                    // Avoid blowing up the hide and token that just had the eventscripts stored on them
                    if(oTest2 != oSkin && oTest2 != oToken)
                        DestroyObject(oTest2);
                    oTest2 = GetNextItemInInventory(oTest);
                }
            }
            // Avoid blowing up the hide and token that just had the eventscripts stored on them
            if(oTest != oSkin && oTest != oToken)
                DestroyObject(oTest);
            oTest = GetNextItemInInventory(oCohort);
        }
        int nSlot;
        for(nSlot = 0;nSlot<14;nSlot++)
        {
            oTest = GetItemInSlot(nSlot, oCohort);
            DestroyObject(oTest);
        }
        //get rid of any gold it has
        TakeGoldFromCreature(GetGold(oCohort), oCohort, TRUE);
    }
    //clean up any leftovers on the skin
    ScrubPCSkin(oCohort, oSkin);
    DeletePRCLocalInts(oSkin);

    //turn on its scripts
    //normal MoB set
    AddEventScript(oCohort, EVENT_VIRTUAL_ONPHYSICALATTACKED,   "prc_ai_mob_attck", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONBLOCKED,            "prc_ai_mob_block", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONCOMBATROUNDEND,     "prc_ai_mob_combt", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONDAMAGED,            "prc_ai_mob_damag", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONDISTURBED,          "prc_ai_mob_distb", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONPERCEPTION,         "prc_ai_mob_percp", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONSPAWNED,            "prc_ai_mob_spawn", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONSPELLCASTAT,        "prc_ai_mob_spell", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONDEATH,              "prc_ai_mob_death", TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONRESTED,             "prc_ai_mob_rest",  TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONUSERDEFINED,        "prc_ai_mob_userd", TRUE, FALSE);
    //dont run this, cohort-specific script replaces it
    //AddEventScript(oCohort, EVENT_VIRTUAL_ONCONVERSATION,       "prc_ai_mob_conv",  TRUE, TRUE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONHEARTBEAT,          "prc_ai_mob_heart", TRUE, FALSE);
    //cohort specific ones
    AddEventScript(oCohort, EVENT_VIRTUAL_ONCONVERSATION,       "prc_ai_coh_conv",  TRUE, FALSE);
    AddEventScript(oCohort, EVENT_VIRTUAL_ONHEARTBEAT,          "prc_ai_coh_hb",    TRUE, FALSE);

    //mark the master on the cohort
    SetLocalObject(oCohort, "MasterObject", oPC);

    //DEBUG
    //various tests
    if (DEBUG) DoDebug("Cohort Name="+GetName(oCohort));
    if (DEBUG) DoDebug("Cohort HD="+IntToString(GetHitDice(oCohort)));
    if (DEBUG) DoDebug("Cohort XP="+IntToString(GetXP(oCohort)));
    if (DEBUG) DoDebug("Cohort GetIsPC="+IntToString(GetIsPC(oCohort)));
}

void RemoveCohortFromPlayer(object oCohort, object oPC)
{
    int nValidPC = FALSE;
    if(GetIsObjectValid(oPC))
        nValidPC = TRUE;

    //strip its equipment & inventory
    object oTest = GetFirstItemInInventory(oCohort);
    while(GetIsObjectValid(oTest))
    {
        if(GetHasInventory(oTest))
        {
            object oTest2 = GetFirstItemInInventory(oTest);
            while(GetIsObjectValid(oTest2))
            {
                if(nValidPC)
                    AssignCommand(oCohort, ActionGiveItem(oTest2, oPC));
                else
                    DestroyObject(oTest2);
                oTest = GetNextItemInInventory(oTest);
            }
        }
        if(nValidPC)
            AssignCommand(oCohort, ActionGiveItem(oTest, oPC));
        else
            DestroyObject(oTest);
        oTest = GetNextItemInInventory(oCohort);
    }
    int nSlot;
    for(nSlot = 0;nSlot<14;nSlot++)
    {
        if(nValidPC)
            AssignCommand(oCohort, ActionGiveItem(GetItemInSlot(nSlot, oCohort), oPC));
        else
            DestroyObject(oTest);
    }
    //now destroy it
    AssignCommand(oCohort, ActionDoCommand(SetIsDestroyable(TRUE, FALSE, FALSE)));
    AssignCommand(oCohort, ActionDoCommand(SetLootable(oCohort, FALSE)));
    AssignCommand(oCohort, ActionDoCommand(DestroyObject(oCohort)));
}

int GetLeadershipScore(object oPC = OBJECT_SELF)
{
    int nLeadership = GetECL(oPC);
    nLeadership += GetAbilityModifier(ABILITY_CHARISMA, oPC);
    if(GetHasFeat(FEAT_RULERSHIP, oPC)) nLeadership += 4;
    if(GetHasFeat(FEAT_MIGHT_MAKES_RIGHT, oPC)) nLeadership += GetAbilityModifier(ABILITY_STRENGTH, oPC);;
    //without epic leadership its capped at 25
    if(!GetHasFeat(FEAT_EPIC_LEADERSHIP, oPC) && nLeadership > 25)
        nLeadership = 25;

    return nLeadership;
}

void StoreCohort(object oCohort)
{
    int nCohortCount = GetCampaignInt(COHORT_DATABASE, "CohortCount");
    int i;
    for(i=0;i<nCohortCount;i++)
    {
        if(GetCampaignInt(COHORT_DATABASE, "Cohort_"+IntToString(i)+"_deleted"))
        {
            nCohortCount = i;
        }
    }
    if(GetCampaignInt(COHORT_DATABASE, "CohortCount")==nCohortCount) //no "deleted" cohorts
        nCohortCount++;
    //store the player
    SetCampaignInt(COHORT_DATABASE, "CohortCount", nCohortCount);
    StoreCampaignObject(COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_obj",    oCohort);
    SetCampaignString(  COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_name",   GetName(oCohort));
    SetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_race",   GetRacialType(oCohort));
    SetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_class1", GetClassByPosition(1, oCohort));
    SetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_class2", GetClassByPosition(2, oCohort));
    SetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_class3", GetClassByPosition(3, oCohort));
    SetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_order",  GetLawChaosValue(oCohort));
    SetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_moral",  GetGoodEvilValue(oCohort));
    SetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_ethran", GetHasFeat(FEAT_ETHRAN, oCohort));
    SetCampaignString(  COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_cdkey",  GetPCPublicCDKey(oCohort));
    SetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nCohortCount)+"_deleted",   FALSE);
}

void CheckHB(object oPC)
{
    //make sure only 1 hb running at a time
    if(GetLocalInt(oPC, "CohortCheckHB") > 1)
        return;
    SetLocalInt(oPC, "CohortCheckHB", GetLocalInt(oPC, "CohortCheckHB")+1);
    DelayCommand(0.99,
        SetLocalInt(oPC, "CohortCheckHB", GetLocalInt(oPC, "CohortCheckHB")-1));
    SetCommandable(FALSE, oPC);
    if(GetHitDice(oPC) == 40)
    {
        StoreCohort(oPC);
        //restore previous xp amound
        int nOldXP = GetLocalInt(oPC, "OriginalXP");
        SetXP(oPC, nOldXP);
        //tell the player what was done
        SendMessageToPC(oPC, "Character registered as cohort.");
        //remove the non-commandabiltiy
        //csp lowes dex, which stops leveling with certain feats
        SetCommandable(TRUE, oPC);
        DeletePersistantLocalInt(oPC, "RegisteringAsCohort");
        //stop the psuedoHB
        return;
    }
    DelayCommand(1.0, CheckHB(oPC));
}

void RegisterAsCohort(object oPC)
{
    string sMessage;
    sMessage += "This will register you character to be selected as a cohort.\n";
    sMessage += "As part of this process, you have to levelup to level 40.\n";
    sMessage += "Once you reach level 40, your character will be stored.\n";
    sMessage += "Then when the character is used as a cohort, it will follow that levelup path.\n";
    sMessage += "Any changes to the cohort will not apply to the original character.\n";
    //SendMessageToPC(oPC, sMessage);
    FloatingTextStringOnCreature(sMessage, oPC);

    SetLocalInt(oPC, "OriginalXP", GetXP(oPC));
    SetXP(oPC, 40*(40-1)*500);
    SetPersistantLocalInt(oPC, "RegisteringAsCohort", TRUE);
    AssignCommand(GetModule(), CheckHB(oPC));
}


int GetCohortMaxLevel(int nLeadership, object oPC)
{
    //if its a bonus cohort, use the players ECL
    if(GetCurrentCohortCount(oPC) <= GetPRCSwitch(PRC_BONUS_COHORTS))
        return GetECL(oPC);
    int nLevel;
    switch(nLeadership)
    {
        case  1: nLevel =  0; break;
        case  2: nLevel =  1; break;
        case  3: nLevel =  2; break;
        case  4: nLevel =  3; break;
        case  5: nLevel =  3; break;
        case  6: nLevel =  4; break;
        case  7: nLevel =  5; break;
        case  8: nLevel =  5; break;
        case  9: nLevel =  6; break;
        case 10: nLevel =  7; break;
        case 11: nLevel =  7; break;
        case 12: nLevel =  8; break;
        case 13: nLevel =  9; break;
        case 14: nLevel = 10; break;
        case 15: nLevel = 10; break;
        case 16: nLevel = 11; break;
        case 17: nLevel = 12; break;
        case 18: nLevel = 12; break;
        case 19: nLevel = 13; break;
        case 20: nLevel = 14; break;
        case 21: nLevel = 15; break;
        case 22: nLevel = 15; break;
        case 23: nLevel = 16; break;
        case 24: nLevel = 17; break;
        case 25: nLevel = 17; break;
        case 26: nLevel = 18; break;
        case 27: nLevel = 18; break;
        case 28: nLevel = 19; break;
        case 29: nLevel = 19; break;
        case 30: nLevel = 20; break;
        case 31: nLevel = 20; break;
        case 32: nLevel = 21; break;
        case 33: nLevel = 21; break;
        case 34: nLevel = 22; break;
        case 35: nLevel = 22; break;
        case 36: nLevel = 23; break;
        case 37: nLevel = 23; break;
        case 38: nLevel = 24; break;
        case 39: nLevel = 24; break;
        case 40: nLevel = 25; break;
        case 41: nLevel = 25; break;
        case 42: nLevel = 26; break;
        case 43: nLevel = 26; break;
        case 44: nLevel = 27; break;
        case 45: nLevel = 27; break;
        case 46: nLevel = 28; break;
        case 47: nLevel = 28; break;
        case 48: nLevel = 29; break;
        case 49: nLevel = 29; break;
        case 50: nLevel = 30; break;
        case 51: nLevel = 30; break;
        case 52: nLevel = 31; break;
        case 53: nLevel = 31; break;
        case 54: nLevel = 32; break;
        case 55: nLevel = 32; break;
        case 56: nLevel = 33; break;
        case 57: nLevel = 33; break;
        case 58: nLevel = 34; break;
        case 59: nLevel = 34; break;
        case 60: nLevel = 35; break;
        case 61: nLevel = 36; break;
        case 62: nLevel = 36; break;
        case 63: nLevel = 37; break;
        case 64: nLevel = 37; break;
        case 65: nLevel = 38; break;
        case 66: nLevel = 38; break;
        case 67: nLevel = 39; break;
        case 68: nLevel = 39; break;
        case 69: nLevel = 40; break;
        case 70: nLevel = 40; break;
    }
    //apply a level lag
    if(GetCurrentCohortCount(oPC) <= GetPRCSwitch(PRC_BONUS_COHORTS))
    {
        //bonus cohort, no cap
    }
    else if(GetPRCSwitch(PRC_THRALLHERD_LEADERSHIP)
        && GetLevelByClass(CLASS_TYPE_THRALLHERD, oPC)
        && GetCurrentCohortCount(oPC) <= GetPRCSwitch(PRC_BONUS_COHORTS)+1)
    {
        //thrallherd with switch, 1 level lag
        if(nLevel > GetECL(oPC)-1)
            nLevel = GetECL(oPC)-1;
    }
    else if(GetPRCSwitch(PRC_THRALLHERD_LEADERSHIP)
        && GetLevelByClass(CLASS_TYPE_THRALLHERD, oPC) >= 10
        && GetCurrentCohortCount(oPC) <= GetPRCSwitch(PRC_BONUS_COHORTS)+2)
    {
        //twofold master with switch, 2 level lag
        if(nLevel > GetECL(oPC)-2)
            nLevel = GetECL(oPC)-2;
    }
    else
    {
        //other cohort have a 2 level lag
        if(nLevel > GetECL(oPC)-2)
            nLevel = GetECL(oPC)-2;
    }
    //really, leadership should be capped at 25 / 17HD
    //but this is a sanity check
    if(nLevel > 20
        && !GetHasFeat(FEAT_EPIC_LEADERSHIP, oPC))
        nLevel = 20;
    return nLevel;
}

int GetCurrentCohortCount(object oPC)
{
    int nCount;
    object oTest;
    object oOldTest;
    int i = 1;
    oTest = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
    while(GetIsObjectValid(oTest) && oTest != oOldTest)
    {
        if(GetTag(oTest) == COHORT_TAG)
            nCount++;
        i++;
        oOldTest = oTest;
        oTest = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
    }
    return nCount;
}

object GetCohort(int nID, object oPC)
{
    int nCount;
    object oTest;
    object oOldTest;
    int i = 1;
    oTest = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
    while(GetIsObjectValid(oTest) && oTest != oOldTest)
    {
        if(GetTag(oTest) == COHORT_TAG)
            nCount++;
        if(nCount == nID)
            return oTest;
        i++;
        oOldTest = oTest;
        oTest = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, i);
    }
    return OBJECT_INVALID;
}

int GetMaximumCohortCount(object oPC)
{
    int nCount = 0;
    if(GetHasFeat(FEAT_LEADERSHIP, oPC)
        && !GetLevelByClass(CLASS_TYPE_THRALLHERD, oPC))
        nCount++;
    if(GetHasFeat(FEAT_LEGENDARY_COMMANDER, oPC)
        && !GetLevelByClass(CLASS_TYPE_THRALLHERD, oPC))
        nCount++;
    //hathran class
    if(GetHasFeat(FEAT_HATH_COHORT, oPC))
        nCount++;
    //orc warlord with switch
    if(GetHasFeat(FEAT_GATHER_HORDE_I, oPC)
        && GetPRCSwitch(PRC_ORC_WARLORD_COHORT))
        nCount++;
    //thrallherd with switch
    if(GetPRCSwitch(PRC_THRALLHERD_LEADERSHIP)
        && GetLevelByClass(CLASS_TYPE_THRALLHERD, oPC))
        nCount++;
    //twofold masteer
    if(GetPRCSwitch(PRC_THRALLHERD_LEADERSHIP)
        && GetLevelByClass(CLASS_TYPE_THRALLHERD, oPC) >= 10)
        nCount++;
    nCount += GetPRCSwitch(PRC_BONUS_COHORTS);
    return nCount;
}

int GetIsCohortChoiceValid(string sName, int nRace, int nClass1, int nClass2, int nClass3, int nOrder, int nMoral, int nEthran, string sKey, int nDeleted, object oPC)
{

    int bIsValid = TRUE;
    int nCohortCount = GetMaximumCohortCount(oPC);
    int i;
    //another players cohort
    if(GetPCPublicCDKey(oPC) != ""
        && GetPCPublicCDKey(oPC) != sKey)
    {
        DoDebug("GetIsCohortChoiceValid() is FALSE because cdkey is incorrect");
        bIsValid = FALSE;
    }
    //is character
    if(bIsValid
        && GetName(oPC) == sName)
    {
        DoDebug("GetIsCohortChoiceValid() is FALSE because name is in use");
        bIsValid = FALSE;
    }
    //is already a cohort
    if(bIsValid && sName != "")
    {
        for(i=1;i<=nCohortCount;i++)
        {
            object oCohort = GetCohort(i, oPC);
            if(GetName(oCohort) == sName)
            {
                DoDebug("GetIsCohortChoiceValid() is FALSE because cohort is already in use.");
                bIsValid = FALSE;
            }
        }
    }
    //has been deleted
    if(bIsValid && nDeleted)
    {
        DoDebug("GetIsCohortChoiceValid() is FALSE because cohort had been deleted");
        bIsValid = FALSE;
    }
    //hathran
    if(bIsValid
        && GetHasFeat(FEAT_HATH_COHORT, oPC))
    {
        int nEthranBarbarianCount = 0;
        for(i=1;i<=nCohortCount;i++)
        {
            object oCohort = GetCohort(i, oPC);
            if(GetIsObjectValid(oCohort)
                &&(GetHasFeat(FEAT_HATH_COHORT, oCohort)
                    || GetLevelByClass(CLASS_TYPE_BARBARIAN, oCohort)))
                nEthranBarbarianCount++;
        }
        //must have at least one ethran or barbarian
        if(!nEthranBarbarianCount
            && GetCurrentCohortCount(oPC) >= GetMaximumCohortCount(oPC)-1
            && !nEthran
            && nClass1 != CLASS_TYPE_BARBARIAN
            && nClass2 != CLASS_TYPE_BARBARIAN
            && nClass3 != CLASS_TYPE_BARBARIAN)
                bIsValid = FALSE;
    }
    //OrcWarlord
    if(bIsValid
        && GetHasFeat(FEAT_GATHER_HORDE_I, oPC)
        && GetPRCSwitch(PRC_ORC_WARLORD_COHORT))
    {
        int nOrcCount = 0;
        for(i=1;i<=nCohortCount;i++)
        {
            object oCohort = GetCohort(i, oPC);
            if(GetIsObjectValid(oCohort)
                && (MyPRCGetRacialType(oCohort) == RACIAL_TYPE_HUMANOID_ORC
                    || MyPRCGetRacialType(oCohort) == RACIAL_TYPE_HALFORC))
                nOrcCount++;
        }
        //must have at least one orc
        if(!nOrcCount
            && GetCurrentCohortCount(oPC) >= GetMaximumCohortCount(oPC)-1
            && nRace != RACIAL_TYPE_HUMANOID_ORC
            && nRace != RACIAL_TYPE_HALFORC
            && nRace != RACIAL_TYPE_GRAYORC
            && nRace != RACIAL_TYPE_OROG
            && nRace != RACIAL_TYPE_TANARUKK
            )
            bIsValid = FALSE;
    }
    //Undead Leadership
    //Wild Cohort
        //not implemented yet
    //return result
    return bIsValid;
}

int GetIsCohortChoiceValidByID(int nID, object oPC)
{
    string sName = GetCampaignString(  COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_name");
    int    nRace = GetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_race");
    int    nClass1=GetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_class1");
    int    nClass2=GetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_class2");
    int    nClass3=GetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_class3");
    int    nOrder= GetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_order");
    int    nMoral= GetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_moral");
    int    nEthran=GetCampaignInt(     COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_ethran");
    string sKey  = GetCampaignString(  COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_cdkey");
    int    nDeleted = GetCampaignInt(COHORT_DATABASE, "Cohort_"+IntToString(nID)+"_deleted");
    return GetIsCohortChoiceValid(sName, nRace, nClass1, nClass2, nClass3, nOrder, nMoral, nEthran, sKey, nDeleted, oPC);
}

int GetCanRegister(object oPC)
{
    int bReturn = TRUE;
    int i;
    int nCohortCount = GetCampaignInt(COHORT_DATABASE, "CohortCount");
    for(i=0;i<nCohortCount;i++)
    {
        string sName = GetCampaignString(COHORT_DATABASE, "Cohort_"+IntToString(i)+"_name");
        if(sName == GetName(oPC)
            && !GetCampaignInt(COHORT_DATABASE, "Cohort_"+IntToString(i)+"_deleted"))
            bReturn = FALSE;
    }
    return bReturn;
}

void DeleteCohort(int nCohortID)
{
    //this is a bit of a fudge, but it will do for now
    //Add Cohort overwrites the first deleted cohort
    SetCampaignInt(COHORT_DATABASE, "Cohort_"+IntToString(nCohortID)+"_deleted", TRUE);
}

void LevelupAndStorePremadeCohort(object oCohort)
{
    int i;
    //levelup the cohort
    //if simple racial HD on, give them racial HD
    if(GetPRCSwitch(PRC_XP_USE_SIMPLE_RACIAL_HD))
    {
        //get the real race
        int nRace = GetRacialType(oCohort);
        int nRacialHD = StringToInt(Get2DACache("ECL", "RaceHD", nRace));
        int nRacialClass = StringToInt(Get2DACache("ECL", "RaceClass", nRace));
        for(i=0;i<nRacialHD;i++)
        {
            LevelUpHenchman(oCohort, nRacialClass, TRUE);
        }
    }
    //give them their 40 levels in their class
    for(i=0;i<40;i++)
    {
        LevelUpHenchman(oCohort, CLASS_TYPE_INVALID, TRUE);
    }
    //store them
    StoreCohort(oCohort);
    //destroy them to clean up afterwards
    //clean invetory first
    object oTest = GetFirstItemInInventory(oCohort);
    while(GetIsObjectValid(oTest))
    {
        DestroyObject(oTest);
        oTest = GetNextItemInInventory(oCohort);
    }
    for(i=0;i<14;i++)
    {
        oTest = GetItemInSlot(i, oCohort);
        DestroyObject(oTest);
    }
    DestroyObject(oCohort);
}

void AddPremadeCohortsToDB()
{
    //check not added already
    if(GetCampaignInt(COHORT_DATABASE, "PremadeCohorts"))
        return;

    //get the limbo location
    location lSpawn = GetLocation(GetObjectByTag("HEARTOFCHAOS"));
    //loop over the races
    int nRace;
    for(nRace = 0; nRace <= 255; nRace++)
    {
        //check its a playable race
        if(Get2DACache("racialtypes", "PlayerRace", nRace) == "1")
        {
            //loop over the classes
            int nClass;
            for(nClass = 0; nClass <= 10; nClass++)
            {
                //assemble the resref
                string sResRef = "PRC_NPC_"+IntToString(nRace)+"_"+IntToString(nClass);
                DoDebug("AddPremadeCohortsToDB() : sResRef = "+sResRef);
                //create the cohort
                object oCohort = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lSpawn);
                //check its valid
                if(GetIsObjectValid(oCohort))
                {
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCohort);
                    DelayCommand(1.0, LevelupAndStorePremadeCohort(oCohort));
                }
            }
        }
    }

    //make sure this is only done once
    SetCampaignInt(COHORT_DATABASE, "PremadeCohorts", TRUE);
}

