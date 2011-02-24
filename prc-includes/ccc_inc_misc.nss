/**
 * convoCC misc functions
 */

#include "inc_utility"
#include "prc_alterations"
#include "inc_letoscript"
#include "inc_letocommands"
#include "inc_dynconv"
#include "prc_ccc_const"
#include "inc_sql"

// checks if it's a multiplayer game and that letoscript is set up correctly
// returns 0 for pass and 1 for fail
int DoLetoscriptTest(object oPC);

// makes a string based on the PC name and player public CD key
string Encrypt(object oPC);

// removes all equipped items from the PC
// that means ALL items, even plot ones
void DoStripPC(object oPC);

// checks if oPC is valid and in an area then boots them
void CheckAndBoot(object oPC);

// 'nice' version of CheckAndBoot() that gives a warning and a 5 second countdown
void CheckAndBootNicely(object oPC);

/**
 * main cutscene function
 * letoscript changes to the PC clone are done via this function
 * nSetup indicates whether the cutscene needs seting up or not
 */
void DoCutscene(object oPC, int nSetup = FALSE);

/**
 * Cutscene pseudo HB functions
 */
 
// used to cleanup clones when a player leaves
void CloneMasterCheck();

// sets up the camera to rotate around the clone 
// and the clone do random animations
void DoRotatingCamera(object oPC);

/**
 * functions to set appearance, portrait, soundset
 */
 
// sets race appearance as defined in racialtype.2da
// removes wings, tails and undead graft arm as well as making invisible bits visible
void DoSetRaceAppearance(object oPC);
 
// assigns the ccc chosen gender to the clone and resets the soundset
// if it's changed
void DoCloneGender(object oPC);

// changes the appearance of the PC and clone
void DoSetAppearance(object oPC);

// deletes local variables stored on the PC before the player is booted to make the new character
void DoCleanup();

// set up the ability choice in "<statvalue> (racial <+/-modifier>) <statname>. Cost to increase <cost>" format
void AddAbilityChoice(int nStatValue, string sStatName, string sRacialAdjust, int nAbilityConst);

// subtracts the correct amount of points for increasing the current ability score
// returns the current ability score incremented by 1
int IncreaseAbilityScore(int nCurrentAbilityScore);

//this returns the cost to get to a score
//or the cost saved by dropping from that score
int GetCost(int nAbilityScore);

// this marks if the PC qualifies for skill focus feats that are class specific
void MarkSkillFocusPrereq(int nSkill, string sVarName);

// works out the next stage to go to between STAGE_FEAT_CHECK and STAGE_APPEARANCE
// when given the stage just completed
// covers caster and familiar related choices
int GetNextCCCStage(int nStage, int nSpellCasterStage = TRUE);

// adds a reply choice to the cache array
// used to store a set of dynamic conversation choices so they don't have to be
// unnecessarily regenerated from the database
void AddCachedChoice(string sText, int nValue, object oPC = OBJECT_SELF);

// delete the stored convo choice cache array
void ClearCachedChoices(object oPC = OBJECT_SELF);

// sets the convoCC's current choice list to the values stored in the cache array 
void AddChoicesFromCache(object oPC = OBJECT_SELF);

// checks if the PC has the two feats given as arguements
// '****' as an arguement is treated as an automatic TRUE for that arguement
// used to check if the PC meets the prerequisites in the PreReqFeat1 AND PreReqFeat2
// columns of feat.2da
int GetMeetsANDPreReq(string sPreReqFeat1, string sPreReqFeat2);

// checks if the PC has any one of the 5 feats given as arguements
// '****' as an arguement is treated as an automatic TRUE for that arguement
// used to check if the PC meets the prerequisites in the OrReqFeat0 OR OrReqFeat1 
// OR OrReqFeat2 OR OrReqFeat3 OR OrReqFeat4 columns of feat.2da
int GetMeetsORPreReq(string sOrReqFeat0, string sOrReqFeat1, string sOrReqFeat2, string sOrReqFeat3, string sOrReqFeat4);

// loops through the feat array on the PC to see if it has nReqFeat
int PreReqFeatArrayLoop(int nReqFeat);

// checks if the PC has enough skill ranks in the two skills
// '****' as ReqSkill arguement is treated as an automatic TRUE for that arguement
// used to check if the PC meets the prerequisites in the ReqSkill AND ReqSkill2
// columns of feat.2da
int GetMeetSkillPrereq(string sReqSkill, string sReqSkill2, string sReqSkillRanks,  string sReqSkillRanks2);

// checks if the PC has enough points in sReqSkill
int CheckSkillPrereq(string sReqSkill, string sReqSkillRanks);

// adds all the cantrips to a wizard's spellbook
void SetWizCantrips(int iSpellschool);

// loops through the spell array on the PC to see if they already know the spell
// returns TRUE if they know it
int GetIsSpellKnown(int nSpell, int nSpellLevel);

// sets up the appearance choices if the PRC_CONVOCC_USE_RACIAL_APPEARANCES switch is set
void SetupRacialAppearances();

// adds appearance choices on being passed an APPEARANCE_TYPE_* constant
void AddAppearanceChoice(int nType, int nOnlyChoice = FALSE);

// adds the head choices based on race and gender
void SetupHeadChoices();

// maps the appearance to a bioware playable race
int MapAppearanceToRace(int nAppearance);

/* 2da cache functions */

// loops through a 2da, using the cache
// s2da is the name of the 2da, sColumnName the column to read the values
// from, nFileEnd the number of lines in the 2da
void Do2daLoop(string s2da, string sColumnName, int nFileEnd);

// loops through racialtypes.2da
void DoRacialtypesLoop();

// loops through classes.2da
void DoClassesLoop();

// loops through skills.2da
void DoSkillsLoop();

// loops through feat.2da
void DoFeatLoop(int nClassFeatStage = FALSE);

// loops through cls_feat_***.2da
void DoBonusFeatLoop();

// loops through spells.2da
void DoSpellsLoop(int nStage);

// loops through domains.2da
void  DoDomainsLoop();

// loops through appearance.2da
void DoAppearanceLoop();

// loops through portraits.2da
void DoPortraitsLoop(int nGenderSort = TRUE);

// loops through soundset.2da
void DoSoundsetLoop(int nGenderSort = TRUE);

// loops through wingmodel.2da
void DoWingmodelLoop();

// loops through tailmodel.2da
void DoTailmodelLoop();

// stores the feats found in race_feat_***.2da as an array on the PC
void AddRaceFeats(int nRace);

// stores the feats found in cls_feat_***.2da in the feat array on the PC
void AddClassFeats(int nClass);

// stores the feat listed in domais.2da in the feat array on the PC
void AddDomainFeats();

// loops through colours.2da depending on the stage for which column it uses.
void AddColourChoices(int nStage, int nCategory);

/* function definitions */

int DoLetoscriptTest(object oPC)
{
    int bBoot;
    //check that its a multiplayer game
    if(GetPCPublicCDKey(oPC) == "")
    {
        SendMessageToPC(oPC, "This module must be hosted as a multiplayer game with NWNX and Letoscript");
        WriteTimestampedLogEntry("This module must be hosted as a multiplayer game with NWNX and Letoscript");
        bBoot = TRUE;
    }

    //check that letoscript is setup correctly
    string sScript;
    if(GetPRCSwitch(PRC_LETOSCRIPT_PHEONIX_SYNTAX))
        sScript = LetoGet("FirstName")+" "+LetoGet("LastName");
    else
        sScript = LetoGet("FirstName")+"print ' ';"+LetoGet("LastName");
        
    StackedLetoScript(sScript);
    RunStackedLetoScriptOnObject(oPC, "LETOTEST", "SCRIPT", "", FALSE);
    string sResult = GetLocalString(GetModule(), "LetoResult");
    string sName = GetName(oPC);
    if((    sResult != sName
         && sResult != sName+" "
         && sResult != " "+sName)
         )
    {
        SendMessageToPC(oPC, "Error: Letoscript is not setup correctly or it cannot find your bic file. Check nwnx_leto.log for error messages.");
        WriteTimestampedLogEntry("Error: Letoscript is not setup correctly or it cannot find your bic file. Check nwnx_leto.log for error messages.");
        bBoot = TRUE;
    }
    
    return bBoot;
}

string Encrypt(object oPC)
{
    string sName = GetName(oPC);
    int nKey = GetPRCSwitch(PRC_CONVOCC_ENCRYPTION_KEY);
    if(nKey == 0)
        nKey = 10;
    string sReturn;

    string sPublicCDKey = GetPCPublicCDKey(oPC);
    int nKeyTotal;
    int i;
    for(i=1;i<GetStringLength(sPublicCDKey);i++)
    {
        nKeyTotal += StringToInt(GetStringLeft(GetStringRight(sPublicCDKey, i),1));
    }
    sReturn = IntToString(nKeyTotal);
    return sReturn;
}

void DoStripPC(object oPC)
{
    // remove equipped items
    int i;
    for(i=0; i<NUM_INVENTORY_SLOTS; i++)
    {
        object oEquip = GetItemInSlot(i,oPC);
        if(GetIsObjectValid(oEquip))
        {
            SetPlotFlag(oEquip,FALSE);
            DestroyObject(oEquip);
        }
    }
    // empty inventory
    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        SetPlotFlag(oItem,FALSE);
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
}

void CheckAndBoot(object oPC)
{
    if(GetIsObjectValid(GetAreaFromLocation(GetLocation(oPC))))
        BootPC(oPC);
}

void CheckAndBootNicely(object oPC)
{
    // Give a "helpful" message
    string sMessage = GetLocalString(oPC, "CONVOCC_ENTER_BOOT_MESSAGE");
    if (sMessage == "") // yes, you should have given your own message here
        sMessage = "Eeek! Something's not right.";
    // no avoiding the convoCC, so stop them running off
    effect eParal = EffectCutsceneImmobilize();
    eParal = SupernaturalEffect(eParal);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParal, oPC, 9999.9);
    // floaty text info as we can't use the dynamic convo for this
    DelayCommand(10.0, FloatingTextStringOnCreature(sMessage, oPC, FALSE));
    DelayCommand(11.0, FloatingTextStringOnCreature("You will be booted in 5...", oPC, FALSE));
    DelayCommand(12.0, FloatingTextStringOnCreature("4...", oPC, FALSE));
    DelayCommand(13.0, FloatingTextStringOnCreature("3...", oPC, FALSE));
    DelayCommand(14.0, FloatingTextStringOnCreature("2...", oPC, FALSE));
    DelayCommand(15.0, FloatingTextStringOnCreature("1...", oPC, FALSE));
    AssignCommand(oPC, DelayCommand(16.0, CheckAndBoot(oPC)));
}

void DoSetRaceAppearance(object oPC)
{
    if(DEBUG) DoDebug(DebugObject2Str(oPC));
    // sets the appearance type
    int nSex = GetLocalInt(oPC, "Gender");
    int nRace = GetLocalInt(oPC, "Race");
    // appearance type switches go here
    if(nRace == RACIAL_TYPE_RAKSHASA || nRace == RACIAL_TYPE_ZAKYA_RAKSHASA || nRace == RACIAL_TYPE_NAZTHARUNE_RAKSHASA
        && nSex == GENDER_FEMALE
        && GetPRCSwitch(PRC_CONVOCC_RAKSHASA_FEMALE_APPEARANCE))
        SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_RAKSHASA_TIGER_FEMALE);
    else
        SetCreatureAppearanceType(oPC, 
                    StringToInt(Get2DACache("racialtypes", "Appearance",
                        GetLocalInt(oPC, "Race"))));
    
    // remove wings and tails - so this can be set later
    // enforcing wing and tail related switches comes later too
    SetCreatureWingType(CREATURE_WING_TYPE_NONE);
    SetCreatureTailType(CREATURE_TAIL_TYPE_NONE);
    
    // get rid of invisible/undead etc bits, but keep tatoos as is
    SetCreatureBodyPart(CREATURE_PART_RIGHT_FOOT, 1);
    SetCreatureBodyPart(CREATURE_PART_LEFT_FOOT, 1);
    SetCreatureBodyPart(CREATURE_PART_PELVIS, 1);
    SetCreatureBodyPart(CREATURE_PART_BELT, 0);
    SetCreatureBodyPart(CREATURE_PART_NECK, 1);
    SetCreatureBodyPart(CREATURE_PART_RIGHT_SHOULDER, 0);
    SetCreatureBodyPart(CREATURE_PART_LEFT_SHOULDER, 0);
    SetCreatureBodyPart(CREATURE_PART_RIGHT_HAND, 1);
    SetCreatureBodyPart(CREATURE_PART_LEFT_HAND, 1);
    // make invisible heads visible, otherwise leave
    if(GetCreatureBodyPart(CREATURE_PART_HEAD) == 0)
        SetCreatureBodyPart(CREATURE_PART_HEAD, 1);
    // preserve tattoos, get rid of anything else
    if(!(GetCreatureBodyPart(CREATURE_PART_RIGHT_SHIN) == 1))
        SetCreatureBodyPart(CREATURE_PART_RIGHT_SHIN, 2);
    if(!(GetCreatureBodyPart(CREATURE_PART_LEFT_SHIN) == 1))
        SetCreatureBodyPart(CREATURE_PART_LEFT_SHIN, 2);
    if(!(GetCreatureBodyPart(CREATURE_PART_RIGHT_THIGH) == 1))
        SetCreatureBodyPart(CREATURE_PART_RIGHT_THIGH, 2);
    if(!(GetCreatureBodyPart(CREATURE_PART_LEFT_THIGH) == 1))
        SetCreatureBodyPart(CREATURE_PART_LEFT_THIGH, 2);
    if(!(GetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM) == 1))
        SetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM, 2);
    if(!(GetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM) == 1))
        SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM, 2);
    if(!(GetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP) == 1))
        SetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP, 2);
    if(!(GetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP) == 1))
        SetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP, 2);
}

void DoCloneGender(object oPC)
{
    object oClone = GetLocalObject(oPC, "Clone");
    if(!GetIsObjectValid(oClone))
        return;
    int nSex = GetLocalInt(oPC, "Gender");
    int nCurrentSex = GetGender(oClone);
    StackedLetoScript(LetoSet("Gender", IntToString(nSex), "byte"));
    // if the gender needs changing, reset the soundset
    if (nSex != nCurrentSex)
        StackedLetoScript(LetoSet("SoundSetFile", IntToString(0), "word"));
    string sResult;
    RunStackedLetoScriptOnObject(oClone, "OBJECT", "SPAWN", "prc_ccc_app_lspw", TRUE);
    sResult = GetLocalString(GetModule(), "LetoResult");
    SetLocalObject(GetModule(), "PCForThread"+sResult, oPC);
}

void DoSetAppearance(object oPC)
{
    if(DEBUG) DoDebug(DebugObject2Str(oPC));
    // get the appearance type
    int nAppearance = GetLocalInt(oPC, "Appearance");
    // get the clone object
    object oClone = GetLocalObject(oPC, "Clone");
    SetCreatureAppearanceType(oClone, nAppearance);
}

void DoCutscene(object oPC, int nSetup = FALSE)
{
    string sScript;
    int nStage = GetStage(oPC);
    
    // check the PC has finished entering the area
    if(!GetIsObjectValid(GetArea(oPC)))
    {
        DelayCommand(1.0, DoCutscene(oPC, nSetup));
        return;
    }
    
    if(DEBUG) DoDebug("DoCutscene() stage is :" + IntToString(nStage) + " nSetup = " + IntToString(nSetup));
    
    if (nStage >= STAGE_RACE_CHECK) // if we don't need to set the clone up
    {
        object oClone;
        
        if(nStage == STAGE_RACE_CHECK || (nStage > STAGE_RACE_CHECK && nSetup))
        {
            // make the PC look like the race they have chosen
            DoSetRaceAppearance(oPC);
            // clone the PC and hide the swap with a special effect
            // make the real PC non-collideable
            effect eGhost = EffectCutsceneGhost();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPC, 99999999.9);
            // make the swap and hide with an effect
            effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC));
            // make clone
            oClone = CopyObject(oPC, GetLocation(oPC), OBJECT_INVALID, "PlayerClone");
            ChangeToStandardFaction(oClone, STANDARD_FACTION_MERCHANT);
            // make the real PC invisible
            effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oPC, 9999.9);
            // swap local objects
            SetLocalObject(oPC, "Clone", oClone);
            SetLocalObject(oClone, "Master", oPC);
            // this makes sure the clone gets destroyed if the PC leaves the game
            AssignCommand(oClone, CloneMasterCheck());
            // end of clone making
            
            int nGender = GetLocalInt(oPC, "Gender");
            // this only needs doing if the gender has changed
            if (GetGender(oPC) != nGender)
            {
                sScript = LetoSet("Gender", IntToString(nGender), "byte");
                // reset soundset only if we've not changed it yet
                if (nStage < STAGE_SOUNDSET)
                    sScript += LetoSet("SoundSetFile", IntToString(0), "word");
            }
        }
        
        if(nStage == STAGE_APPEARANCE || (nStage > STAGE_APPEARANCE && nSetup))
        {
            DoSetAppearance(oPC);
        }
        
        if(nStage == STAGE_SOUNDSET || (nStage > STAGE_SOUNDSET && nSetup))
        {
            int nSoundset = GetLocalInt(oPC, "Soundset");
            if (nSoundset != -1) // then it has been changed
            {
                sScript += LetoSet("SoundSetFile", IntToString(nSoundset), "word");
            }
        }
        
        if (nStage == STAGE_SKIN_COLOUR_CHOICE || (nStage > STAGE_SKIN_COLOUR_CHOICE && nSetup))
        {
            int nSkin = GetLocalInt(oPC, "Skin");
            if (nSkin != -1) // then it has been changed
            {
                SetColor(oClone, COLOR_CHANNEL_SKIN, nSkin);
                //sScript += SetSkinColor(nSkin);
            }
        }
        
        if (nStage == STAGE_HAIR_COLOUR_CHOICE || (nStage > STAGE_HAIR_COLOUR_CHOICE && nSetup))
        {
            int nHair = GetLocalInt(oPC, "Hair");
            if (nHair != -1) // then it has been changed
            {
                SetColor(oClone, COLOR_CHANNEL_HAIR, nHair);
                //sScript += SetHairColor(nHair);
            }
        }
        
        if (nStage == STAGE_TATTOO1_COLOUR_CHOICE || (nStage > STAGE_TATTOO1_COLOUR_CHOICE && nSetup))
        {
            int nTattooColour1 = GetLocalInt(oPC, "TattooColour1");
            if (nTattooColour1 != -1) // then it has been changed
            {
                SetColor(oClone, COLOR_CHANNEL_TATTOO_1, nTattooColour1);
                //sScript += SetTattooColor(nTattooColour1, 1);
            }
        }
        
        if (nStage == STAGE_TATTOO2_COLOUR_CHOICE || (nStage > STAGE_TATTOO2_COLOUR_CHOICE && nSetup))
        {
            int nTattooColour2 = GetLocalInt(oPC, "TattooColour2");
            if (nTattooColour2 != -1) // then it has been changed
            {
                SetColor(oClone, COLOR_CHANNEL_TATTOO_2, nTattooColour2);
                //sScript += SetTattooColor(nTattooColour2, 2);
            }
        }
        // no point in running the letoscript commands if no changes are made
        if (sScript != "")
        {
            StackedLetoScript(sScript);
            string sResult;
            if (oClone == OBJECT_INVALID)
                oClone = GetLocalObject(oPC, "Clone");
            RunStackedLetoScriptOnObject(oClone, "OBJECT", "SPAWN", "prc_ccc_app_lspw", TRUE);
            sResult = GetLocalString(GetModule(), "LetoResult");
            SetLocalObject(GetModule(), "PCForThread"+sResult, OBJECT_SELF);
        }
    }
    // DoRotatingCamera(oPC);
}

void CloneMasterCheck()
{
    object oMaster = GetLocalObject(OBJECT_SELF, "Master");
    if(!GetIsObjectValid(oMaster))
    {
        // free up the convoCC if they logged out
        DeleteLocalObject(GetModule(), "ccc_active_pc");
        SetIsDestroyable(TRUE);
        DestroyObject(OBJECT_SELF);
    }
    else
        DelayCommand(10.0, CloneMasterCheck());
}

void DoRotatingCamera(object oPC)
{
    if (DEBUG) DoDebug("Running DoRotatingCamera()");
    if(!GetIsObjectValid(oPC))
    {
        // then the ccc is free to use again
        DeleteLocalInt(GetModule(), "ccc_active_pc");
        if (DEBUG) DoDebug("Invalid PC given to DoRotatingCamera()");
        return;
    }
    if(GetLocalInt(oPC, "StopRotatingCamera"))
    {
        DeleteLocalInt(oPC, "StopRotatingCamera");
        DeleteLocalFloat(oPC, "DoRotatingCamera");
        return;
    }
    float fDirection = GetLocalFloat(oPC, "DoRotatingCamera");
    fDirection += 30.0;
    if(fDirection > 360.0)
        fDirection -= 360.0;
    if(fDirection <= 0.0)
        fDirection += 360.0;
    SetLocalFloat(oPC, "DoRotatingCamera", fDirection);
    SetCameraMode(oPC, CAMERA_MODE_TOP_DOWN);
    SetCameraFacing(fDirection, 2.0, 45.0, CAMERA_TRANSITION_TYPE_VERY_SLOW);
    DelayCommand(6.0, DoRotatingCamera(oPC));
    //its the clone not the PC that does things
    object oClone = GetLocalObject(oPC, "Clone");
    if(GetIsObjectValid(oClone))
        oPC = oClone;
    if(d2()==1)
        AssignCommand(oPC, ActionPlayAnimation(100+Random(17)));
    else
        AssignCommand(oPC, ActionPlayAnimation(100+Random(21), 1.0, 6.0));
}

void DoCleanup()
{
    object oPC = OBJECT_SELF;
    // go through the ones used to make the character
    // delete some ints
    DeleteLocalInt(oPC, "Str");
    DeleteLocalInt(oPC, "Dex");
    DeleteLocalInt(oPC, "Con");
    DeleteLocalInt(oPC, "Int");
    DeleteLocalInt(oPC, "Wis");
    DeleteLocalInt(oPC, "Cha");

    DeleteLocalInt(oPC, "Race");

    DeleteLocalInt(oPC, "Class");
    DeleteLocalInt(oPC, "HitPoints");

    DeleteLocalInt(oPC, "Gender");

    DeleteLocalInt(oPC, "LawfulChaotic");
    DeleteLocalInt(oPC, "GoodEvil");

    DeleteLocalInt(oPC, "Familiar");
    DeleteLocalInt(oPC, "Companion");

    DeleteLocalInt(oPC, "Domain1");
    DeleteLocalInt(oPC, "Domain2");

    DeleteLocalInt(oPC, "School");
    
    DeleteLocalInt(oPC, "SpellsPerDay0");
    DeleteLocalInt(oPC, "SpellsPerDay1");
    
    DeleteLocalInt(oPC, "Soundset");
    DeleteLocalInt(oPC, "Skin");
    DeleteLocalInt(oPC, "Hair");
    DeleteLocalInt(oPC, "TattooColour1");
    DeleteLocalInt(oPC, "TattooColour2");
    
    // delete some arrays
    array_delete(oPC, "spellLvl0");
    array_delete(oPC, "spellLvl1");
    array_delete(oPC, "Feats");
    array_delete(oPC, "Skills");
}


void AddAbilityChoice(int nAbilityScore, string sAbilityName, string sRacialAdjust, int nAbilityConst)
{
    // if it is still possible to increase the ability score, add that choice
    if (nAbilityScore < GetLocalInt(OBJECT_SELF, "MaxStat") && GetLocalInt(OBJECT_SELF, "Points") >= GetCost(nAbilityScore + 1))
    {
        AddChoice(sAbilityName + " " + IntToString(nAbilityScore) + " (Racial " + sRacialAdjust + "). " 
            + GetStringByStrRef(137) + " " + IntToString(GetCost(nAbilityScore + 1)), nAbilityConst);
    }
}

int IncreaseAbilityScore(int nCurrentAbilityScore)
{
    int nPoints = GetLocalInt(OBJECT_SELF, "Points");
    // get cost and remove from total
    // note: because of how GetCost() works, the ability score is incremented here not later
    nPoints -= GetCost(++nCurrentAbilityScore);
    // store the total points left on the PC
    SetLocalInt(OBJECT_SELF, "Points", nPoints);
    return nCurrentAbilityScore;
}

int GetCost(int nAbilityScore)
{
    int nCost = (nAbilityScore-11)/2;
    if(nCost < 1)
        nCost = 1;
    return nCost;
}

void MarkSkillFocusPrereq(int nSkill, string sVarName)
{
    string sFile = Get2DACache("classes", "SkillsTable", GetLocalInt(OBJECT_SELF, "Class"));
    // query to see if nSkill is on the cls_skill*** list
    string sSkill = IntToString(nSkill);
    string sSQL = "SELECT data FROM prc_cached2da WHERE file = '" + sFile + "' AND columnid= 'skillindex' AND " 
    +"data = '" + sSkill + "'";
    
    PRC_SQLExecDirect(sSQL);
    if (PRC_SQLFetch() == PRC_SQL_SUCCESS)
        SetLocalInt(OBJECT_SELF, sVarName, TRUE);
}

int GetNextCCCStage(int nStage, int nSpellCasterStage = TRUE)
{
    // check we're in the right place
    if (nStage < STAGE_FEAT_CHECK)
        return -1; // sent here too early
    // get some info
    int nClass = GetLocalInt(OBJECT_SELF, "Class");
    if(nSpellCasterStage)
    {
        switch (nStage) // with no breaks to go all the way through
        {
            case STAGE_FEAT_CHECK: {
                if(nClass == CLASS_TYPE_WIZARD)
                {
                    return STAGE_WIZ_SCHOOL;
                }
            }
            case STAGE_WIZ_SCHOOL_CHECK: {
                if (nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_BARD)
                {
                    return STAGE_SPELLS_0;
                }
                else if (nClass == CLASS_TYPE_WIZARD)
                {
                    return STAGE_SPELLS_1;
                }
            }
            case STAGE_SPELLS_0: {
                if (nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_BARD)
                {
                    string sSpkn = Get2DACache("classes", "SpellKnownTable", nClass);
                    // if they can pick level 1 spells
                    if (StringToInt(Get2DACache(sSpkn, "SpellLevel1", 0)))
                        return STAGE_SPELLS_1;
                }       
            }
            case STAGE_SPELLS_1: {
                if (nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_BARD)
                {
                    return STAGE_SPELLS_CHECK; // checks both 0 and 1 level spells
                }
            }
            case STAGE_SPELLS_CHECK: {
                if (nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_SORCERER || nClass == CLASS_TYPE_DRUID)
                {
                    return STAGE_FAMILIAR; // also does animal companion
                }
            }
            case STAGE_FAMILIAR_CHECK: {
                if (nClass == CLASS_TYPE_CLERIC)
                {
                    return STAGE_DOMAIN;
                }
            }
            default:
                return STAGE_APPEARANCE;
        }
    }
    else
    {
        int nAppearance = GetLocalInt(OBJECT_SELF, "Appearance");
        // the model type determines if the model is dynamic, can have wings or tails
        string sModelType = Get2DACache("appearance", "MODELTYPE", nAppearance);
        switch(nStage) // with no breaks to go all the way through
        {
            case STAGE_SOUNDSET:
            case STAGE_SOUNDSET_CHECK:
            {
                if (sModelType == "P")
                    return STAGE_HEAD;
            }
            case STAGE_HEAD:
            case STAGE_HEAD_CHECK:
            {
                if (sModelType == "P")
                    return STAGE_TATTOO;
            }
            case STAGE_TATTOO:
            case STAGE_TATTOO_CHECK:
            {
                if (sModelType == "P" || TestStringAgainstPattern("**W**", sModelType))
                    return STAGE_WINGS;
            }
            case STAGE_WINGS_CHECK:
            {
                if (sModelType == "P" || TestStringAgainstPattern("**T**", sModelType))
                    return STAGE_TAIL;
            }
            case STAGE_TAIL_CHECK:
            {
                if (sModelType == "P")
                    return STAGE_SKIN_COLOUR;
            }
            default:
                return FINAL_STAGE;
        }
    }
    return -1; // silly compiler
}

void AddCachedChoice(string sText, int nValue, object oPC = OBJECT_SELF)
{
    // pretty much the same as the AddChoice() function
    if(!array_exists(oPC, "CachedChoiceTokens"))
        array_create(oPC, "CachedChoiceTokens");
    if(!array_exists(oPC, "CachedChoiceValues"))
        array_create(oPC, "CachedChoiceValues");
    array_set_string(oPC, "CachedChoiceTokens", array_get_size(oPC, "CachedChoiceTokens"), sText);
    array_set_int   (oPC, "CachedChoiceValues", array_get_size(oPC, "CachedChoiceValues"), nValue);
}

void ClearCachedChoices(object oPC = OBJECT_SELF)
{
    array_delete(oPC, "CachedChoiceTokens");
    array_delete(oPC, "CachedChoiceValues");
}

void AddChoicesFromCache(object oPC = OBJECT_SELF)
{
    int nArraySize = array_get_size(oPC, "CachedChoiceTokens");
    int i, nValue;
    string sText;
    for(i = 0; i < nArraySize; i++)
    {
        sText = array_get_string(oPC, "CachedChoiceTokens", i);
        nValue = array_get_int(oPC, "CachedChoiceValues", i);
        AddChoice(sText, nValue);
    }
}

int GetMeetsANDPreReq(string sPreReqFeat1, string sPreReqFeat2)
{
    // are there any prereq?
    if (sPreReqFeat1 == "****" && sPreReqFeat2 == "****")
        return TRUE;
    // test if the PC meets the first prereq
    // if not, exit
    if(!PreReqFeatArrayLoop(StringToInt(sPreReqFeat1)))
        return FALSE;
    // got this far, then the first prereq was met
    // is there a second prereq? If not, done
    if (sPreReqFeat2 == "****")
        return TRUE;
    // test if the PC meets the second one
    if(!PreReqFeatArrayLoop(StringToInt(sPreReqFeat2)))
        return FALSE;
    // got this far, so second one matched too
    return TRUE;
}

int GetMeetsORPreReq(string sOrReqFeat0, string sOrReqFeat1, string sOrReqFeat2, string sOrReqFeat3, string sOrReqFeat4)
{
    // are there any prereq
    if (sOrReqFeat0 == "****")
        return TRUE;
    // first one
    if(PreReqFeatArrayLoop(StringToInt(sOrReqFeat0)))
        return TRUE;
    // second one
    if(PreReqFeatArrayLoop(StringToInt(sOrReqFeat1)))
        return TRUE;
    // third one
    if(PreReqFeatArrayLoop(StringToInt(sOrReqFeat2)))
        return TRUE;
    // 4th one
    if(PreReqFeatArrayLoop(StringToInt(sOrReqFeat3)))
        return TRUE;
    // 5th one
    if(PreReqFeatArrayLoop(StringToInt(sOrReqFeat4)))
        return TRUE;
    // no match
    return FALSE;
}

int PreReqFeatArrayLoop(int nOrReqFeat)
{
    // as alertness is stored in the array as -1
    if (nOrReqFeat == 0)
        nOrReqFeat = -1;
    int i = 0;
    while (i != array_get_size(OBJECT_SELF, "Feats"))
    {
        int nFeat  = array_get_int(OBJECT_SELF, "Feats", i);
        if(nFeat == nOrReqFeat) // if there's a match, the prereq are met
            return TRUE;
        i++;
    }
    // otherwise no match
    return FALSE;
}

int GetMeetSkillPrereq(string sReqSkill, string sReqSkill2, string sReqSkillRanks,  string sReqSkillRanks2)
{
    if(sReqSkill == "****" && sReqSkill2 == "****")
        return TRUE;
    // test if the PC meets the first prereq
    if(!CheckSkillPrereq(sReqSkill, sReqSkillRanks))
        return FALSE;
    
    // got this far, then the first prereq was met
	// is there a second prereq? If not, done
    if(sReqSkill2 == "****")
        return TRUE;
    if(!CheckSkillPrereq(sReqSkill2, sReqSkillRanks2))
        return FALSE;
    // got this far, so second one matched too
    return TRUE;
}

int CheckSkillPrereq(string sReqSkill, string sReqSkillRanks)
{
    // for skill focus feats
    if (sReqSkillRanks == "0" || sReqSkillRanks == "****") // then it just requires being able to put points in the skill
    {
        // if requires animal empathy, but the PC can't take ranks in it
        if(sReqSkill == "0" && !GetLocalInt(OBJECT_SELF, "bHasAnimalEmpathy"))
            return FALSE;
        // if requires UMD, but the PC can't take ranks in it
        if(sReqSkill == IntToString(SKILL_USE_MAGIC_DEVICE) && !GetLocalInt(OBJECT_SELF, "bHasUMD"))
            return FALSE;
    }
    else // test if the PC has enough ranks in the skill
    {
        int nSkillPoints = array_get_int(OBJECT_SELF, "Skills", StringToInt(sReqSkill));
        if (nSkillPoints < StringToInt(sReqSkillRanks))
            return FALSE;
    }
    // get this far then not failed any of the prereq
    return TRUE;
}

void SetWizCantrips(int iSpellschool)
{
    string sOpposition = "";
    // if not a generalist
    if(iSpellschool)
    {
        sOpposition = Get2DACache("spellschools", "Letter", StringToInt(Get2DACache("spellschools", "Opposition", iSpellschool)));
    }
    
    array_create(OBJECT_SELF, "SpellLvl0");
    string sSQL = "SELECT rowid FROM prc_cached2da_spells WHERE (wiz_sorc = '0') AND (school != '"+sOpposition+"')";
    PRC_SQLExecDirect(sSQL);
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        int nRow = StringToInt(PRC_SQLGetData(1));
        array_set_int(OBJECT_SELF, "SpellLvl0", array_get_size(OBJECT_SELF, "SpellLvl0"),nRow);
    }
}

int GetIsSpellKnown(int nSpell, int nSpellLevel)
{
    // spell 0 is a level 6 spell, so no need to do the 0 == -1 workaround
    int i = 0;
    string sArray = "SpellLvl" + IntToString(nSpellLevel);
    // if the array doesn't exist then there won't be a match
    if (!array_exists(OBJECT_SELF, sArray))
        return FALSE;
    while (i != array_get_size(OBJECT_SELF, sArray))
    {
        int nKnownSpell  = array_get_int(OBJECT_SELF, sArray, i);
        if(nKnownSpell == nSpell) // if there's a match, don't add it
            return TRUE;
        i++;
    }
    // otherwise no match
    return FALSE;
}

void SetupRacialAppearances()
{
    int nRace = GetLocalInt(OBJECT_SELF, "Race");
    int nSex  = GetLocalInt(OBJECT_SELF, "Gender");
    string sSex = nSex == 0 ? "male" : "female";
    object oPC = OBJECT_SELF;

    // see if the PC's race and gender combination has an entry in racialappearances.2da
    /*
        SELECT appearance.data FROM prc_cached2da, prc_cached2da AS appearance, prc_cached2da AS gender
        WHERE prc_cached2da.rowid = appearance.rowid 
        AND prc_cached2da.rowid = gender.rowid
        AND prc_cached2da.file = "racialappearance" AND appearance.file = "racialappearance" AND gender.file = "racialappearance"
        AND prc_cached2da.columnid = "Race" AND appearance.columnid = "Appearance" AND gender.columnid = "Gender"
        AND prc_cached2da.data = "<race>" AND (gender.data = "<gender>" OR gender.data = "2");
     */

    /*
    string sSQL = "SELECT appearance.data FROM prc_cached2da, prc_cached2da AS appearance, prc_cached2da AS gender " +
    "WHERE prc_cached2da.rowid = appearance.rowid AND prc_cached2da.rowid = gender.rowid " +
    "AND prc_cached2da.file = 'racialappearance' AND appearance.file = 'racialappearance' AND gender.file = 'racialappearance' " +
    "AND prc_cached2da.columnid = 'race' AND appearance.columnid = 'appearance' AND gender.columnid = 'gender' " +
    "AND prc_cached2da.data = " + IntToString(nRace) + " AND (gender.data = " + IntToString(nSex) + " OR gender.data = '2')";
    */
    string sSQL = "SELECT data FROM prc_cached2da WHERE file = 'racialappear' AND rowid = "+IntToString(nRace)+
                  " AND (columnid = '"+sSex+"1' OR columnid = '"+sSex+"2' OR columnid = '"+sSex+"3' OR columnid = '"+sSex+"4' OR columnid = '"+sSex+"5')";

    PRC_SQLExecDirect(sSQL);
    int i;
    array_create(oPC, "AppearanceChoices");
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
         string sTemp = PRC_SQLGetData(1);
         if(sTemp != "****")
         {
             i = StringToInt(sTemp); // appearance
             // as doing a Get2DACache() call here will overwrite the sql result, add to an array to do this later
             array_set_int (oPC, "AppearanceChoices", array_get_size(oPC, "AppearanceChoices"), i);
         }
    }
    // if there's any values in the array use those for choices
    int nNumberOfChoices = array_get_size(oPC, "AppearanceChoices");
    if (nNumberOfChoices)
    {
        // loop through the array and add all the choices
        i = 0;
        while (i < nNumberOfChoices)
        {
            AddAppearanceChoice(array_get_int(oPC, "AppearanceChoices", i));
            i++;
        }
    }
    else // it is the appearance given at the race stage
    {
        // the only 'choice'
        AddAppearanceChoice(StringToInt(Get2DACache("racialtypes", "Appearance", nRace)), TRUE);
    }
    // tidy up
    array_delete(oPC, "AppearanceChoices");
    DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
}

void AddAppearanceChoice(int nType, int nOnlyChoice = FALSE)
{
    // get the appearance type name
    string sName;
    int nStrRef = StringToInt(Get2DACache("appearance", "STRING_REF", nType));
    if(nStrRef)
        sName = GetStringByStrRef(nStrRef);
    else
        sName = Get2DACache("appearance", "LABEL", nType);
    // if there's only one option, it has already been stored on the PC
    // at the race choice stage
    if (nOnlyChoice) 
    {
        // add a "continue" so player doesn't expect a choice
        sName = GetStringByStrRef(39) + " (" + sName + ")";
        // marker to skip the check stage
        nType = -1;
    }
    AddChoice(sName, nType);
}

void SetupHeadChoices()
{
    int nGender = GetLocalInt(OBJECT_SELF, "Gender");
    int nAppearance = GetLocalInt(OBJECT_SELF, "Appearance");
    // determine the number of heads (based on both appearance and gender)
    int nHeadNumber;
    int nHead2Start; // some appearances have a second run of head numbers
    int nHead2End;
    // change numbers to account for custom heads here
    if(GetPRCSwitch(MARKER_CEP2)) // add in the extra (consecutive) heads
    {
        if(nAppearance == APPEARANCE_TYPE_HUMAN
        || nAppearance == APPEARANCE_TYPE_HALF_ELF)
        {
            if(nGender == GENDER_MALE)
            {
                nHeadNumber = 49;
                nHead2Start = 100;
                nHead2End = 113;
            }
            else if (nGender == GENDER_FEMALE)
            {
                nHeadNumber = 49;
                nHead2Start = 100;
                nHead2End = 114;
            }
        }
        else if (nAppearance == APPEARANCE_TYPE_ELF)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 34;
            else if (nGender == GENDER_FEMALE)
            {
                nHeadNumber = 43;
                nHead2Start = 179;
                nHead2End = 180;
            }
        }
        else if (nAppearance == APPEARANCE_TYPE_HALFLING)
        {
            if(nGender == GENDER_MALE)
            {
                nHeadNumber = 26;
                nHead2Start = 160;
                nHead2End = 161;
            }
            else if (nGender == GENDER_FEMALE)
            {
                nHeadNumber = 15;
                nHead2Start = 161;
                nHead2End = 167;
            }
        }
        else if (nAppearance == APPEARANCE_TYPE_HALF_ORC)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 31;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 15;
        }
        else if (nAppearance == APPEARANCE_TYPE_DWARF)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 24;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 23;
        }
        else if(nAppearance == APPEARANCE_TYPE_GNOME)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 35;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 10;
        }
        else if (nAppearance == APPEARANCE_TYPE_CEP_BROWNIE)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 12;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 11;
        }
        else if (nAppearance == APPEARANCE_TYPE_CEP_WEMIC)
        {
            if (nGender == GENDER_MALE)
                nHeadNumber = 4;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 2;
        }
    }
    else
    {
        if(nAppearance == APPEARANCE_TYPE_HUMAN
            || nAppearance == APPEARANCE_TYPE_HALF_ELF)
        {
            if(nGender == GENDER_MALE)
            {
                nHeadNumber = 34;
                nHead2Start = 140;
                nHead2End = 143;
            }
            else if (nGender == GENDER_FEMALE)
            {
                nHeadNumber = 27;
                nHead2Start = 140;
                nHead2End = 143;
            }
        }
        else if (nAppearance == APPEARANCE_TYPE_ELF)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 18;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 16;
        }
        else if (nAppearance == APPEARANCE_TYPE_HALFLING)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 10;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 11;
        }
        else if (nAppearance == APPEARANCE_TYPE_HALF_ORC)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 13;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 12;
        }
        else if (nAppearance == APPEARANCE_TYPE_DWARF)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 13;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 12;
        }
        else if(nAppearance == APPEARANCE_TYPE_GNOME)
        {
            if(nGender == GENDER_MALE)
                nHeadNumber = 13;
            else if (nGender == GENDER_FEMALE)
                nHeadNumber = 9;
        }
    }
    int i;
    for(i=1;i<= nHeadNumber;i++)
        AddChoice(IntToString(i), i);
    if (nHead2Start)
    {
        for(i = nHead2Start;i <= nHead2End;i++)
        AddChoice(IntToString(i), i);
    }
    
    // and the non consecutive heads for the CEP
    if((nAppearance == APPEARANCE_TYPE_HUMAN
        || nAppearance == APPEARANCE_TYPE_HALF_ELF) && GetPRCSwitch(MARKER_CEP2))
    {
        if(nGender == GENDER_MALE)
        {
            AddChoice(IntToString(140), 140);
            AddChoice(IntToString(141), 141);
            AddChoice(IntToString(142), 142);
            AddChoice(IntToString(143), 143);
            AddChoice(IntToString(155), 155);
        }
        else if (nGender == GENDER_FEMALE)
        {
            AddChoice(IntToString(140), 140);
            AddChoice(IntToString(141), 141);
            AddChoice(IntToString(142), 142);
            AddChoice(IntToString(143), 143);
            AddChoice(IntToString(147), 147);
            AddChoice(IntToString(148), 148);
            AddChoice(IntToString(149), 149);
            AddChoice(IntToString(150), 150);
            AddChoice(IntToString(151), 151);
            AddChoice(IntToString(152), 152);
            AddChoice(IntToString(155), 155);
            AddChoice(IntToString(180), 180);
            AddChoice(IntToString(181), 181);
        }
    }
}

int MapAppearanceToRace(int nAppearance)
{
    switch(nAppearance)
    {
        case APPEARANCE_TYPE_DWARF:
            return RACIAL_TYPE_DWARF;
            break;
        case APPEARANCE_TYPE_ELF:
            return RACIAL_TYPE_ELF;
            break;
        case APPEARANCE_TYPE_GNOME:
            return RACIAL_TYPE_GNOME;
            break;
        case APPEARANCE_TYPE_HALFLING:
            return RACIAL_TYPE_HALFLING;
            break;
        case APPEARANCE_TYPE_HALF_ORC:
            return RACIAL_TYPE_HALFORC;
            break;
        case APPEARANCE_TYPE_HUMAN:
        case APPEARANCE_TYPE_HALF_ELF: // half-elves get human portraits
            return RACIAL_TYPE_HUMAN;
            break;
        default: 
            return -1;
    }
    return -1; // silly compiler
}

void Do2daLoop(string s2da, string sColumnName, int nFileEnd)
{
    /* SELECT statement
     * SELECT rowid, data FROM prc_cached2da
     * WHERE file = <s2DA> AND columnid = <sColumnName> AND rowid >= <nFileEnd>
     */
     string sSQL = "SELECT rowid, data FROM prc_cached2da WHERE file = '"+ s2da +"' AND columnid = '" + sColumnName +"' AND  rowid <= " + IntToString(nFileEnd);
     PRC_SQLExecDirect(sSQL);
     int i;
     string sData;
     while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
     {
         i = StringToInt(PRC_SQLGetData(1)); // rowid
         sData = GetStringByStrRef(StringToInt(PRC_SQLGetData(2))); // data
         AddChoice(sData, i);
         
     }
}

void DoRacialtypesLoop()
{
    // get the results 25 rows at a time to avoid TMI
    int nReali = GetLocalInt(OBJECT_SELF, "i");
    /* SELECT statement
    SELECT rowid, Name FROM prc_cached2da_racialtypes
    WHERE PlayerRace = 1
    LIMIT 25 OFFSET <nReali>
    */
    string sSQL = "SELECT rowid, name FROM prc_cached2da_racialtypes WHERE (playerrace = 1) LIMIT 25 OFFSET "+IntToString(nReali);
    PRC_SQLExecDirect(sSQL);
    // to keep track of where in the 25 rows we stop getting a result
    int nCounter = 0;
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nCounter++;
        int nRace = StringToInt(PRC_SQLGetData(1)); // rowid
        int bIsTakeable = TRUE;
        
        // check for right drow gender IF the switch is set
        if(GetPRCSwitch(PRC_CONVOCC_DROW_ENFORCE_GENDER))
        {
            if(nRace == RACIAL_TYPE_DROW_FEMALE
                && GetLocalInt(OBJECT_SELF, "Gender") == GENDER_MALE)
                bIsTakeable = FALSE;
            if(nRace == RACIAL_TYPE_DROW_MALE
                && GetLocalInt(OBJECT_SELF, "Gender") == GENDER_FEMALE)
                bIsTakeable = FALSE;
        }
        
        // add the choices, choice number is race rowid/constant value
        if(bIsTakeable)
        {
            string sName = GetStringByStrRef(StringToInt(PRC_SQLGetData(2)));
            AddChoice(sName, nRace);
        }
    }
    
    // IF there were 25 rows, carry on
    if(nCounter == 25)
    {
        SetLocalInt(OBJECT_SELF, "i", nReali+25);
        DelayCommand(0.01, DoRacialtypesLoop());
    }
    else // there were less than 25 rows, it's the end of the 2da
    {
        FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
        DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
        DeleteLocalInt(OBJECT_SELF, "i");
        return;
    }
}

void DoClassesLoop()
{
    // remove if decide not to make the convo wait
    if(GetLocalInt(OBJECT_SELF, "DynConv_Waiting") == FALSE)
        return;
    // get the results 25 rows at a time to avoid TMI
    int nReali = GetLocalInt(OBJECT_SELF, "i");
    /*
    SELECT `rowid`, `PreReqTable` FROM `prc_cached2da_classes`
    WHERE (`PlayerClass` = 1) AND (`XPPenalty` = 1) 
    LIMIT 25 OFFSET <nReali>
    */
    string sSQL = "SELECT rowid, prereqtable FROM prc_cached2da_classes WHERE (playerclass = 1) AND (xppenalty = 1) LIMIT 25 OFFSET "+IntToString(nReali);
    PRC_SQLExecDirect(sSQL);
    // to keep track of where in the 25 rows we stop getting a result
    int nCounter = 0;
    int nClass;
    string sPreReq, sReqType, sParam1, sParam2;
    // this needs storing in a temp array because the 2da cache retrieval will clear
    // the query above if both steps are done in the same loop
    // two parallel arrays as there's no struct arrays
    array_create(OBJECT_SELF, "temp_classes");
    array_create(OBJECT_SELF, "temp_class_prereq");
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nCounter++;
        nClass = StringToInt(PRC_SQLGetData(1)); // rowid
        array_set_int(OBJECT_SELF, "temp_classes", array_get_size(OBJECT_SELF, "temp_classes"), nClass);
        sPreReq = PRC_SQLGetData(2); // PreReq tablename
        array_set_string(OBJECT_SELF, "temp_class_prereq", array_get_size(OBJECT_SELF, "temp_class_prereq"), sPreReq);

    }
    
    // loop through the temp array to check for banned classes
    int i;
    for (i=0; i < array_get_size(OBJECT_SELF, "temp_classes"); i++)
    {
        nClass = array_get_int(OBJECT_SELF, "temp_classes", i); // class
        sPreReq = array_get_string(OBJECT_SELF, "temp_class_prereq", i); // prereq table name
        int j = 0;
        // check if this base class is allowed
        do
        {
            sReqType = Get2DACache(sPreReq, "ReqType", j);
            if (sReqType == "VAR") // if we've found the class allowed variable
            {
                sParam1 = Get2DACache(sPreReq, "ReqParam1", j);
                if(!GetLocalInt(OBJECT_SELF, sParam1)) // if the class is allowed
                {
                    // adds the class to the choice list
                    string sName = GetStringByStrRef(StringToInt(Get2DACache("classes", "Name", nClass)));
                    AddChoice(sName, nClass);
                }
            } // end of if (sReqType == "VAR")
            j++;
            
        } while (sReqType != "VAR"); // terminates as soon as we get the allowed variable
        
    } // end of for loop
    // clean up
    array_delete(OBJECT_SELF, "temp_classes");
    array_delete(OBJECT_SELF, "temp_class_prereq");
    
    // IF there were 25 rows, carry on
    if(nCounter == 25)
    {
        SetLocalInt(OBJECT_SELF, "i", nReali+25);
        DelayCommand(0.01, DoClassesLoop());
    }
    else // there were less than 25 rows, it's the end of the 2da
    {
        FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
        DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
        DeleteLocalInt(OBJECT_SELF, "i");
        return;
    }
}

void DoSkillsLoop()
{
    if(GetPRCSwitch(PRC_CONVOCC_ALLOW_SKILL_POINT_ROLLOVER))
    {
        // add the "store" option
        AddChoice("Store all remaining points.", -2);
    }
    // get the class of the PC
    int nClass = GetLocalInt(OBJECT_SELF, "Class");
    // get the cls_skill_*** 2da to use
    string sFile = Get2DACache("classes", "SkillsTable", nClass);
    // too convoluted to do via SQL..meh
    // set up the while
    int i = 0;
    // because with strings, "0" (Animal Empathy) and "" (blank entry) are different
    string sSkillIndex = Get2DACache(sFile, "SkillIndex", i);
    // loop over each valid row - as soon as we hit an empty line, quit
    while(sSkillIndex != "")
    {
        int nPoints = GetLocalInt(OBJECT_SELF, "Points");
        // see if it's class or cross-class
        int nClassSkill = StringToInt(Get2DACache(sFile, "ClassSkill", i));
        int nSkillID = StringToInt(sSkillIndex); // line of skills.2da for the skill
        // get the skill name
        string sName = GetStringByStrRef(StringToInt(Get2DACache("skills", "Name", nSkillID)));
        // class skill or truespeak and PC is a truenamer
        if (nClassSkill == 1 || (nSkillID == SKILL_TRUESPEAK && nClass == CLASS_TYPE_TRUENAMER))
        {
            sName += " " + GetStringByStrRef(52951); // (Class Skill)
            // check there's not already 4 points in there
            int nStoredPoints = array_get_int(OBJECT_SELF, "Skills", nSkillID);
            if (nStoredPoints < 4) // level (ie 1) + 3
            {
                sName += " : "+IntToString(nStoredPoints);
                // only add if there's less than the maximum points allowed
                AddChoice(sName, i); // uses cls_skill_*** rowid as choice number
            }
        }
        else // cross-class skill
        {
            // check there's not already 2 points in there
            int nStoredPoints = array_get_int(OBJECT_SELF, "Skills", nSkillID);
            // if there's only 1 point left, then no cross class skills
            if (nStoredPoints < 2 && nPoints > 1) // level (ie 1) + 1
            {
                sName += " : "+IntToString(nStoredPoints);
                // only add if there's less than the maximum points allowed
                AddChoice(sName, i); // uses cls_skill_*** rowid as choice number
            }
        }
        i++; // go to next line
        sSkillIndex = Get2DACache(sFile, "SkillIndex", i);
    }
    // if the dynamic convo is set waiting (first time through only)
    // then mark as done
    if (GetLocalInt(OBJECT_SELF, "DynConv_Waiting"))
    {
        FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
        DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
    }
}

void DoFeatLoop(int nClassFeatStage = FALSE)
{
    /* TODO - scripting feat enforcement */
    string sSQL;
    object oPC = OBJECT_SELF;

    // get the information needed to work out if the prereqs are met
    int nSex = GetLocalInt(oPC, "Gender");
    int nRace = GetLocalInt(oPC, "Race");
    int nClass = GetLocalInt(oPC, "Class");
    int nStr = GetLocalInt(oPC, "Str");
    int nDex = GetLocalInt(oPC, "Dex");
    int nCon = GetLocalInt(oPC, "Con");
    int nInt = GetLocalInt(oPC, "Int");
    int nWis = GetLocalInt(oPC, "Wis");
    int nCha = GetLocalInt(oPC, "Cha"); 
    int nOrder = GetLocalInt(oPC, "LawfulChaotic");
    int nMoral = GetLocalInt(oPC, "GoodEvil");

    //add racial ability alterations
    nStr += StringToInt(Get2DACache("racialtypes", "StrAdjust", nRace));
    nDex += StringToInt(Get2DACache("racialtypes", "DexAdjust", nRace));
    nCon += StringToInt(Get2DACache("racialtypes", "ConAdjust", nRace));
    nInt += StringToInt(Get2DACache("racialtypes", "IntAdjust", nRace));
    nWis += StringToInt(Get2DACache("racialtypes", "WisAdjust", nRace));
    nCha += StringToInt(Get2DACache("racialtypes", "ChaAdjust", nRace));

    // get BAB
    int nBAB = StringToInt(Get2DACache(Get2DACache("classes", "AttackBonusTable", nClass), "BAB", 0));

    // get fortitude save
    int nFortSave = StringToInt(Get2DACache(Get2DACache("classes","SavingThrowTable" , nClass), "FortSave", 0));

    // get the results 5 rows at a time to avoid TMI
    int nReali = GetLocalInt(OBJECT_SELF, "i");

    if (!nClassFeatStage) // select the general feats
    {
        /*
        SELECT `rowid`, `feat`, `PREREQFEAT1`, `PREREQFEAT2`, `OrReqFeat0`, `OrReqFeat1`, `OrReqFeat2`, `OrReqFeat3`, `OrReqFeat4`,
        `REQSKILL`, `REQSKILL2`, `ReqSkillMinRanks`, `ReqSkillMinRanks2`
        FROM `prc_cached2da_feat`
        WHERE (`feat` != '****') AND (`PreReqEpic` != 1)
        AND (`MinLevel` = '****' OR `MinLevel` = '1')
        AND `ALLCLASSESCANUSE` = 1
        AND `minattackbonus` <= <nBAB>
        AND `minspelllvl` <= 1
        AND `minstr`<= <nStr>
        AND `mindex`<= <nDex>
        AND `mincon`<= <nCon>
        AND `minint`<= <nInt>
        AND `minwis`<= <nWis>
        AND `mincha`<= <nCha>
        AND `MinFortSave` <= <nFortSave>
        */

        sSQL = "SELECT rowid, feat, prereqfeat1, prereqfeat2, orreqfeat0, orreqfeat1, orreqfeat2, orreqfeat3, orreqfeat4, "
                +"reqskill, reqskill2, reqskillminranks, reqskillminranks2 FROM prc_cached2da_feat"
                +" WHERE (feat != '****') AND (prereqepic != 1)"
                +" AND (minlevel = '****' OR minlevel = '1')"
                +" AND (allclassescanuse = 1)"
                +" AND (minattackbonus <= "+IntToString(nBAB)+")"
                +" AND (minspelllvl <= 1)"
                +" AND (minstr <= "+IntToString(nStr)+")"
                +" AND (mindex <= "+IntToString(nDex)+")"
                +" AND (mincon <= "+IntToString(nCon)+")"
                +" AND (minint <= "+IntToString(nInt)+")"
                +" AND (minwis <= "+IntToString(nWis)+")"
                +" AND (mincha <= "+IntToString(nCha)+")"
                +" AND (minfortsave <= "+IntToString(nFortSave)+")"
                +" LIMIT 5 OFFSET "+IntToString(nReali);
    }
    else // select the class feats
    {
        // get which cls_feat_*** 2da to use
    string sFile = GetStringLowerCase(Get2DACache("classes", "FeatsTable", nClass));

        /*
        SELECT prc_cached2da_cls_feat.FeatIndex, prc_cached2da_cls_feat.FEAT, 
            prc_cached2da_feat.PREREQFEAT1, prc_cached2da_feat.PREREQFEAT2, 
            prc_cached2da_feat.OrReqFeat0, prc_cached2da_feat.OrReqFeat1, prc_cached2da_feat.OrReqFeat2, prc_cached2da_feat.OrReqFeat3, prc_cached2da_feat.OrReqFeat4, 
            prc_cached2da_feat.REQSKILL, prc_cached2da_feat.REQSKILL2,
            prc_cached2da_feat.ReqMinSkillRanks, prc_cached2da_feat.ReqMinSkillRanks2
        FROM prc_cached2da_cls_feat INNER JOIN prc_cached2da_feat
        WHERE (prc_cached2da_feat.FEAT != '****') AND (prc_cached2da_cls_feat.FeatIndex != '****')
            AND (prc_cached2da_cls_feat.file = '<cls_feat***>')
            AND (prc_cached2da_cls_feat.List <= 1)
            AND (prc_cached2da_cls_feat.GrantedOnLevel <= 1)
            AND (prc_cached2da_feat.rowid = prc_cached2da_cls_feat.FeatIndex)
            AND (`PreReqEpic` != 1)
            AND (`MinLevel` = '****' OR `MinLevel` = '1')
            AND `ALLCLASSESCANUSE` = 0
            AND `minattackbonus` <= <nBAB>
            AND `minspelllvl` <= 1
            AND `minstr`<= <nStr>
            AND `mindex`<= <nDex>
            AND `mincon`<= <nCon>
            AND `minint`<= <nInt>
            AND `minwis`<= <nWis>
            AND `mincha`<= <nCha>
            AND `MinFortSave` <= <nFortSave>
        */

        sSQL = "SELECT prc_cached2da_feat.rowid, feat, prereqfeat1, prereqfeat2, "
                +"orreqfeat0, orreqfeat1, orreqfeat2, orreqfeat3, orreqfeat4, "
                +"reqskill, reqskill2, reqskillminranks, reqskillminranks2"
                +" FROM prc_cached2da_feat INNER JOIN prc_cached2da_cls_feat"
                +" WHERE (prc_cached2da_feat.feat != '****') AND (prc_cached2da_cls_feat.featindex != '****')"
                +" AND (prc_cached2da_cls_feat.file = '" + sFile + "')"
                +" AND (prc_cached2da_cls_feat.list <= 1)"
                +" AND (prc_cached2da_cls_feat.grantedonlevel <= 1)"
                +" AND (prc_cached2da_feat.rowid = prc_cached2da_cls_feat.featindex)"
                +" AND (prereqepic != 1)"
                +" AND (minlevel = '****' OR minlevel = '1')"
                +" AND (allclassescanuse != 1)"
                +" AND (minattackbonus <= "+IntToString(nBAB)+")"
                +" AND (minspelllvl <= 1)"
                +" AND (minstr <= "+IntToString(nStr)+")"
                +" AND (mindex <= "+IntToString(nDex)+")"
                +" AND (mincon <= "+IntToString(nCon)+")"
                +" AND (minint <= "+IntToString(nInt)+")"
                +" AND (minwis <= "+IntToString(nWis)+")"
                +" AND (mincha <= "+IntToString(nCha)+")"
                +" AND (minfortsave <= "+IntToString(nFortSave)+")"
                +" LIMIT 5 OFFSET "+IntToString(nReali);
    }

    // debug print the sql statement
    if(DEBUG)
    {
        DoDebug(sSQL);
    }

    PRC_SQLExecDirect(sSQL);
    // to keep track of where in the 25 rows we stop getting a result
    int nCounter = 0;
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nCounter++;
        int nRow = StringToInt(PRC_SQLGetData(1));
        int nStrRef = StringToInt(PRC_SQLGetData(2));
        string sName = GetStringByStrRef(nStrRef);
        string sPreReqFeat1 = PRC_SQLGetData(3);
        string sPreReqFeat2 = PRC_SQLGetData(4);
        string sOrReqFeat0 = PRC_SQLGetData(5);
        string sOrReqFeat1 = PRC_SQLGetData(6);
        string sOrReqFeat2 = PRC_SQLGetData(7);
        string sOrReqFeat3 = PRC_SQLGetData(8);
        string sOrReqFeat4 = PRC_SQLGetData(9);
        string sReqSkill = PRC_SQLGetData(10);
        string sReqSkill2 = PRC_SQLGetData(11);
        string sReqSkillRanks = PRC_SQLGetData(12);
        string sReqSkillRanks2 = PRC_SQLGetData(13);

        // check AND feat prerequisites
        if (GetMeetsANDPreReq(sPreReqFeat1, sPreReqFeat2))
        {
            // check OR feat prerequisites
            if (GetMeetsORPreReq(sOrReqFeat0, sOrReqFeat1, sOrReqFeat2, sOrReqFeat3, sOrReqFeat4))
            {
                // check skill prerequisites
                if(GetMeetSkillPrereq(sReqSkill, sReqSkill2, sReqSkillRanks, sReqSkillRanks2))
                {
                    // check they don't have it already
                    if(!PreReqFeatArrayLoop(nRow))
                    {
                        AddCachedChoice(sName, nRow);
                    }
                    else
                    {
                        if(DEBUG) DoDebug("Already picked feat " + IntToString(nRow) + ". Not added!");
                    }
                }
                else
                {
                    if(DEBUG) DoDebug("Not met skill prereq for feat " + IntToString(nRow) + ". Not added!");
                }
            }
            else
            {
                if(DEBUG) DoDebug("Not met OR prereqfeat test for feat " + IntToString(nRow) + ". Not added!");
            }
        }
        else
        {
            if(DEBUG) DoDebug("Not met AND prereqfeat test for feat " + IntToString(nRow) + ". Not added!");
        }
    } // end of while(PRC_SQLFetch() == PRC_SQL_SUCCESS)

    if(nCounter == 5)
    {
        SetLocalInt(OBJECT_SELF, "i", nReali+5);
        DelayCommand(0.01, DoFeatLoop(nClassFeatStage));
    }
    else // there were less than 5 rows, it's the end of the 2da
    {
        if(nClassFeatStage)
        {
            AddChoicesFromCache();
            FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
            if(DEBUG) DoDebug("Finished class feats");
            DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
            DeleteLocalInt(OBJECT_SELF, "i");
            return;
        }
        else // run again to select class feats
        {
            nClassFeatStage = TRUE;
            if(DEBUG) DoDebug("Finished general feats");
            DeleteLocalInt(OBJECT_SELF, "i");
            DelayCommand(0.01, DoFeatLoop(nClassFeatStage));
        }
    }
}

void DoBonusFeatLoop()
{
    /* TODO - scripting feat enforcement */
    string sSQL;
    object oPC = OBJECT_SELF;

    int nFeatsRemaining = GetLocalInt(OBJECT_SELF, "Points");
    int nClass = GetLocalInt(oPC, "Class");

    if (nClass == CLASS_TYPE_PSION && nFeatsRemaining == 2)
    {
        // then skip everything and just list the disciplines
        /*
        SELECT rowid, FEAT FROM prc_cached2da_feat
        WHERE rowid >= 3554 AND rowid <= 3559
        */
        sSQL = "SELECT rowid, feat FROM prc_cached2da_feat WHERE rowid >= 3554 AND rowid <= 3559";
        PRC_SQLExecDirect(sSQL);
        // to keep track of where in the 25 rows we stop getting a result
        int nCounter = 0;
        while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
        {
            nCounter++;
            int nRow = StringToInt(PRC_SQLGetData(1));
            int nStrRef = StringToInt(PRC_SQLGetData(2));
            string sName = GetStringByStrRef(nStrRef);
            AddChoice(sName, nRow);
        }

        AddChoicesFromCache();
        if(DEBUG) DoDebug("Finished bonus feats");
        FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
        DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");

        return;
    }

    // get the information needed to work out if the prereqs are met
    int nSex = GetLocalInt(oPC, "Gender");
    int nRace = GetLocalInt(oPC, "Race");

    int nStr = GetLocalInt(oPC, "Str");
    int nDex = GetLocalInt(oPC, "Dex");
    int nCon = GetLocalInt(oPC, "Con");
    int nInt = GetLocalInt(oPC, "Int");
    int nWis = GetLocalInt(oPC, "Wis");
    int nCha = GetLocalInt(oPC, "Cha"); 
    int nOrder = GetLocalInt(oPC, "LawfulChaotic");
    int nMoral = GetLocalInt(oPC, "GoodEvil");

    //add racial ability alterations
    nStr += StringToInt(Get2DACache("racialtypes", "StrAdjust", nRace));
    nDex += StringToInt(Get2DACache("racialtypes", "DexAdjust", nRace));
    nCon += StringToInt(Get2DACache("racialtypes", "ConAdjust", nRace));
    nInt += StringToInt(Get2DACache("racialtypes", "IntAdjust", nRace));
    nWis += StringToInt(Get2DACache("racialtypes", "WisAdjust", nRace));
    nCha += StringToInt(Get2DACache("racialtypes", "ChaAdjust", nRace));

    // get BAB
    int nBAB = StringToInt(Get2DACache(Get2DACache("classes", "AttackBonusTable", nClass), "BAB", 0));

    // get fortitude save
    int nFortSave = StringToInt(Get2DACache(Get2DACache("classes","SavingThrowTable" , nClass), "FortSave", 0));

    // get the results 5 rows at a time to avoid TMI
    int nReali = GetLocalInt(OBJECT_SELF, "i");

    // get which cls_feat_*** 2da to use
    string sFile = GetStringLowerCase(Get2DACache("classes", "FeatsTable", nClass));

        /*
        SELECT prc_cached2da_cls_feat.FeatIndex, prc_cached2da_cls_feat.FEAT, 
            prc_cached2da_feat.PREREQFEAT1, prc_cached2da_feat.PREREQFEAT2, 
            prc_cached2da_feat.OrReqFeat0, prc_cached2da_feat.OrReqFeat1, prc_cached2da_feat.OrReqFeat2, prc_cached2da_feat.OrReqFeat3, prc_cached2da_feat.OrReqFeat4, 
            prc_cached2da_feat.REQSKILL, prc_cached2da_feat.REQSKILL2,
            prc_cached2da_feat.ReqMinSkillRanks, prc_cached2da_feat.ReqMinSkillRanks2
        FROM prc_cached2da_cls_feat INNER JOIN prc_cached2da_feat
        WHERE (prc_cached2da_feat.FEAT != '****') AND (prc_cached2da_cls_feat.FeatIndex != '****')
            AND (prc_cached2da_cls_feat.file = '<cls_feat***>')
            AND ((prc_cached2da_cls_feat.List = 1) OR (prc_cached2da_cls_feat.List = 2))
            AND (prc_cached2da_cls_feat.GrantedOnLevel <= 1)
            AND (prc_cached2da_feat.rowid = prc_cached2da_cls_feat.FeatIndex)
            AND (`PreReqEpic` != 1)
            AND (`MinLevel` = '****' OR `MinLevel` = '1')
            AND `ALLCLASSESCANUSE` = 0
            AND `minattackbonus` <= <nBAB>
            AND `minspelllvl` <= 1
            AND `minstr`<= <nStr>
            AND `mindex`<= <nDex>
            AND `mincon`<= <nCon>
            AND `minint`<= <nInt>
            AND `minwis`<= <nWis>
            AND `mincha`<= <nCha>
            AND `MinFortSave` <= <nFortSave>
        */

        sSQL = "SELECT prc_cached2da_feat.rowid, feat, prereqfeat1, prereqfeat2, "
                +"orreqfeat0, orreqfeat1, orreqfeat2, orreqfeat3, orreqfeat4, "
                +"reqskill, reqskill2, reqskillminranks, reqskillminranks2"
                +" FROM prc_cached2da_feat INNER JOIN prc_cached2da_cls_feat"
                +" WHERE (prc_cached2da_feat.feat != '****') AND (prc_cached2da_cls_feat.featindex != '****')"
                +" AND (prc_cached2da_cls_feat.file = '" + sFile + "')"
                +" AND ((prc_cached2da_cls_feat.list = 1) OR (prc_cached2da_cls_feat.list = 2))"
                +" AND (prc_cached2da_cls_feat.grantedonlevel <= 1)"
                +" AND (prc_cached2da_feat.rowid = prc_cached2da_cls_feat.featindex)"
                +" AND (prereqepic != 1)"
                +" AND (minlevel = '****' OR minlevel = '1')"
                +" AND (minattackbonus <= "+IntToString(nBAB)+")"
                +" AND (minspelllvl <= 1)"
                +" AND (minstr <= "+IntToString(nStr)+")"
                +" AND (mindex <= "+IntToString(nDex)+")"
                +" AND (mincon <= "+IntToString(nCon)+")"
                +" AND (minint <= "+IntToString(nInt)+")"
                +" AND (minwis <= "+IntToString(nWis)+")"
                +" AND (mincha <= "+IntToString(nCha)+")"
                +" AND (minfortsave <= "+IntToString(nFortSave)+")"
                +" LIMIT 5 OFFSET "+IntToString(nReali);

    // debug print the sql statement
    if(DEBUG)
    {
        DoDebug(sSQL);
    }

    PRC_SQLExecDirect(sSQL);
    // to keep track of where in the 25 rows we stop getting a result
    int nCounter = 0;
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nCounter++;
        int nRow = StringToInt(PRC_SQLGetData(1));
        int nStrRef = StringToInt(PRC_SQLGetData(2));
        string sName = GetStringByStrRef(nStrRef);
        string sPreReqFeat1 = PRC_SQLGetData(3);
        string sPreReqFeat2 = PRC_SQLGetData(4);
        string sOrReqFeat0 = PRC_SQLGetData(5);
        string sOrReqFeat1 = PRC_SQLGetData(6);
        string sOrReqFeat2 = PRC_SQLGetData(7);
        string sOrReqFeat3 = PRC_SQLGetData(8);
        string sOrReqFeat4 = PRC_SQLGetData(9);
        string sReqSkill = PRC_SQLGetData(10);
        string sReqSkill2 = PRC_SQLGetData(11);
        string sReqSkillRanks = PRC_SQLGetData(12);
        string sReqSkillRanks2 = PRC_SQLGetData(13);

        // check AND feat prerequisites
        if (GetMeetsANDPreReq(sPreReqFeat1, sPreReqFeat2))
        {
            // check OR feat prerequisites
            if (GetMeetsORPreReq(sOrReqFeat0, sOrReqFeat1, sOrReqFeat2, sOrReqFeat3, sOrReqFeat4))
            {
                // check skill prerequisites
                if(GetMeetSkillPrereq(sReqSkill, sReqSkill2, sReqSkillRanks, sReqSkillRanks2))
                {
                    // check they don't have it already
                    if(!PreReqFeatArrayLoop(nRow))
                    {
                        // check it's not a psion discipline
                        if (nClass != CLASS_TYPE_PSION || !(nRow >= 3554 && nRow <= 3559))
                            AddChoice(sName, nRow);
                    }
                    else
                    {
                        if(DEBUG) DoDebug("Already picked feat " + IntToString(nRow) + ". Not added!");
                    }
                }
                else
                {
                    if(DEBUG) DoDebug("Not met skill prereq for feat " + IntToString(nRow) + ". Not added!");
                }
            }
            else
            {
                if(DEBUG) DoDebug("Not met OR prereqfeat test for feat " + IntToString(nRow) + ". Not added!");
            }
        }
        else
        {
            if(DEBUG) DoDebug("Not met AND prereqfeat test for feat " + IntToString(nRow) + ". Not added!");
        }
    } // end of while(PRC_SQLFetch() == PRC_SQL_SUCCESS)

    if(nCounter == 5)
    {
        SetLocalInt(OBJECT_SELF, "i", nReali+5);
        DelayCommand(0.01, DoBonusFeatLoop());
    }
    else // there were less than 5 rows, it's the end of the 2da
    {
        AddChoicesFromCache();
        if(DEBUG) DoDebug("Finished bonus feats");
        FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
        DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
        DeleteLocalInt(OBJECT_SELF, "i");
        return;
    }
}

void DoSpellsLoop(int nStage)
{
    // get which spell level the choices are for
    int nSpellLevel = 0;
    if (nStage == STAGE_SPELLS_1)
        nSpellLevel = 1;
    int nClass = GetLocalInt(OBJECT_SELF, "Class");
    string sSQL;
    // get the results 30 rows at a time to avoid TMI
    int nReali = GetLocalInt(OBJECT_SELF, "i");
    switch(nClass)
    {
        case CLASS_TYPE_WIZARD: {
            int nSpellSchool = GetLocalInt(OBJECT_SELF, "School");
            string sOpposition = Get2DACache("spellschools", "letter", StringToInt(Get2DACache("spellschools", "opposition", nSpellSchool)));
            sSQL = "SELECT rowid, name FROM prc_cached2da_spells WHERE (name != '****') AND (wiz_sorc = '1') AND (school != '"+sOpposition+"') LIMIT 30 OFFSET "+IntToString(nReali);
            break;
        }
        case CLASS_TYPE_SORCERER: {
            sSQL = "SELECT rowid, name FROM prc_cached2da_spells WHERE (name != '****') AND(wiz_sorc = '"+IntToString(nSpellLevel)+"') LIMIT 30 OFFSET "+IntToString(nReali);
            break;
        }
        case CLASS_TYPE_BARD: {
            sSQL = "SELECT rowid, name FROM prc_cached2da_spells WHERE (name != '****') AND(bard = '"+IntToString(nSpellLevel)+"') LIMIT 30 OFFSET "+IntToString(nReali);
            break;
        }
    }
    
    PRC_SQLExecDirect(sSQL);
    // to keep track of where in the 10 rows we stop getting a result
    int nCounter = 0;
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nCounter++;
        // has it already been chosen?
        int nSpell = StringToInt(PRC_SQLGetData(1));
        // if they don't know the spell, add it to the choice list
        if(!GetIsSpellKnown(nSpell, nSpellLevel))
        {
            string sName = GetStringByStrRef(StringToInt(PRC_SQLGetData(2)));
            AddChoice(sName, nSpell);
        }
    } // end of while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    
    if (nCounter == 30)
    {
        SetLocalInt(OBJECT_SELF, "i", nReali+30);
        DelayCommand(0.01, DoSpellsLoop(nStage));
    }
    else // end of the 2da
    {
        if(DEBUG) DoDebug("Finished spells");
        FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
        DeleteLocalInt(OBJECT_SELF, "i");
        DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
        return;
    }
}

void  DoDomainsLoop()
{
    int i = 0;
    string sName;
    // get the first domain chosen if it's there
    int nDomain = GetLocalInt(OBJECT_SELF, "Domain1");
    
    // genasi elemental domain enforcement only is needed on the first domain
    if (!nDomain && GetPRCSwitch(PRC_CONVOCC_GENASI_ENFORCE_DOMAINS))
    {
        // now check PC race
        int nRace = GetLocalInt(OBJECT_SELF, "Race");
        if(nRace == RACIAL_TYPE_AIR_GEN)
            i = DOMAIN_AIR;
        else if(nRace == RACIAL_TYPE_EARTH_GEN)
            i = DOMAIN_EARTH;
        else if(nRace == RACIAL_TYPE_FIRE_GEN)
            i = DOMAIN_FIRE;
        else if(nRace == RACIAL_TYPE_WATER_GEN)
            i = DOMAIN_WATER;
    }
    // see if i was just set
    if (i) // if set, then the player gets no choice
    {
        i--; // the domain constants are offset by 1 to their 2da lines
        sName = Get2DACache("domains", "Name", i);
        AddChoice(GetStringByStrRef(StringToInt(sName)), i);
    }
    else // give them the full domain list
    {
        // get the file end
        int nFileEnd = GetPRCSwitch(FILE_END_DOMAINS);
        /* SELECT statement
         * SELECT rowid, data FROM prc_cached2da
         * WHERE file = 'domains' AND columnid = 'name' AND data != '****' AND rowid >= <nFileEnd>
         */
         string sSQL = "SELECT rowid, data FROM prc_cached2da WHERE file = 'domains' AND columnid = 'name' AND data != '****' AND rowid <= " + IntToString(nFileEnd);
         PRC_SQLExecDirect(sSQL);
        
        // fix for air domain being 0
        // swap around -1 (actually air/0) and variable not set (0)
        if (nDomain == -1) // air domain
            nDomain = 0;
        else if (nDomain == 0) // not set
            nDomain = -1;
        int i;
        string sRowID;
        string sName;
         while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
         {
             i = StringToInt(PRC_SQLGetData(1)); // rowid
             sName = GetStringByStrRef(StringToInt(PRC_SQLGetData(2))); // data
             if (i != nDomain)
            {
                AddChoice(sName, i);
            }
         }
    }
    DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
    FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
}

void DoAppearanceLoop()
{
    // get the results 100 rows at a time to avoid TMI
    int nReali = GetLocalInt(OBJECT_SELF, "i");
    int nCounter = 0;
    string sSQL = "SELECT rowid, string_ref, label FROM prc_cached2da_appearance WHERE (label != '****') LIMIT 100 OFFSET "+IntToString(nReali);
    PRC_SQLExecDirect(sSQL);
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nCounter++;
        string sName;
        int nStrRef = StringToInt(PRC_SQLGetData(2));
        if(nStrRef)
            sName = GetStringByStrRef(nStrRef);
        else
            sName = PRC_SQLGetData(3);
        int nRow = StringToInt(PRC_SQLGetData(1));
        AddChoice(sName, nRow);
    }
    if (nCounter == 100)
    {
        SetLocalInt(OBJECT_SELF, "i", nReali+100);
        DelayCommand(0.01, DoAppearanceLoop());
    }
    else // end of the 2da
    {
        if(DEBUG) DoDebug("Finished appearances");
        FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
        DeleteLocalInt(OBJECT_SELF, "i");
        DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
        return;
    }
}

void DoPortraitsLoop(int nGenderSort = TRUE)
{
    // get the results 100 rows at a time to avoid TMI
    int nReali = GetLocalInt(OBJECT_SELF, "i");
    int nCounter = 0;
    string sSQL;
    // get the gender and add it to the SQL statement
    string sGender = IntToString(GetLocalInt(OBJECT_SELF, "Gender"));
    // get the race for ordering
    string sRace;
    // map the race to appearance for the PC appearances
    // as eg. all drow portraits are labelled as elf portraits in bioware's portraits.2da
    int nFakeRace = MapAppearanceToRace(GetLocalInt(OBJECT_SELF, "Appearance"));
    if (nFakeRace != -1) // if the appearance was a default character model
        sRace = IntToString(nFakeRace);
    else // use the actual race
        sRace = IntToString(GetLocalInt(OBJECT_SELF, "Race"));
    
    // note: "BaseResRef != 'matron'" is because that portrait is referenced in bioware's
    // portraits.2da, but doesn't exist
    if (nGenderSort)
    {
        if(GetPRCSwitch(PRC_CONVOCC_USE_RACIAL_PORTRAIT)) // get only race specific ones
        {
            sSQL = "SELECT rowid, baseresref, FROM prc_cached2da_portraits WHERE (inanimatetype = '****') AND (baseresref != '****') AND (baseresref != 'matron') AND (sex = '" + sGender 
                + "') AND (race ='"+sRace+"') LIMIT 100 OFFSET "+IntToString(nReali);
        }
        else
        {
            // orders portraits of PC's race first, only PC's gender-specific portraits
            sSQL = "SELECT rowid, baseresref, CASE race WHEN "+ sRace +" THEN 0 else 1 END AS column1 FROM prc_cached2da_portraits WHERE (inanimatetype = '****') AND (baseresref != '****') AND (baseresref != 'matron') AND (sex = '" + sGender 
                + "') ORDER BY column1, race LIMIT 100 OFFSET "+IntToString(nReali);
        }
    }
    else
    {
        if(GetPRCSwitch(PRC_CONVOCC_USE_RACIAL_PORTRAIT)) // get only race specific ones
        {
            sSQL = "SELECT rowid, baseresref, FROM prc_cached2da_portraits WHERE (inanimatetype = '****') AND (baseresref != '****') AND (baseresref != 'matron') AND (sex != '" + sGender 
                + "') AND (race ='"+sRace+"') LIMIT 100 OFFSET "+IntToString(nReali);
        }
        else
        {
            sSQL = "SELECT rowid, baseresref FROM prc_cached2da_portraits WHERE (inanimatetype = '****') AND (baseresref != '****') AND (baseresref != 'matron') AND (sex != '" + sGender + "') LIMIT 100 OFFSET "+IntToString(nReali);
        }
    }
    PRC_SQLExecDirect(sSQL);
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nCounter++;
        int nRow = StringToInt(PRC_SQLGetData(1));
        string sName = PRC_SQLGetData(2);
        AddChoice(sName, nRow);
    }
    if (nCounter == 100)
    {
        SetLocalInt(OBJECT_SELF, "i", nReali+100);
        DelayCommand(0.01, DoPortraitsLoop(nGenderSort));
    }
    else // end of the 2da
    {
        if (nGenderSort && !GetPRCSwitch(PRC_CONVOCC_RESTRICT_PORTRAIT_BY_SEX)) // run again to select the rest of the portraits
        {
            nGenderSort = FALSE;
            if(DEBUG) DoDebug("Finished gender specific portraits");
            DeleteLocalInt(OBJECT_SELF, "i");
            DelayCommand(0.01, DoPortraitsLoop(nGenderSort));
        }
        else // done
        {
            if(DEBUG) DoDebug("Finished portraits");
            FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
            DeleteLocalInt(OBJECT_SELF, "i");
            DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
            return;
        }
    }
}

void DoSoundsetLoop(int nGenderSort = TRUE)
{
    // get the results 100 rows at a time to avoid TMI
    int nReali = GetLocalInt(OBJECT_SELF, "i");
    int nCounter = 0;
    string sSQL;
    string sGender = IntToString(GetLocalInt(OBJECT_SELF, "Gender"));
    
    sSQL = "SELECT rowid, strref FROM prc_cached2da_soundset WHERE (resref != '****')";
    
    if(nGenderSort)
    {
        sSQL += " AND (gender = '" + sGender + "')";
    }
    else
    {
        sSQL += " AND (gender != '" + sGender + "')";
    }
    
    // make the SQL string
    if(GetPRCSwitch(PRC_CONVOCC_ONLY_PLAYER_VOICESETS))
        sSQL += " AND (TYPE = '0') LIMIT 100 OFFSET "+IntToString(nReali);
    else
        sSQL += " ORDER BY TYPE LIMIT 100 OFFSET "+IntToString(nReali);
    
    PRC_SQLExecDirect(sSQL);
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nCounter++;
        int nRow = StringToInt(PRC_SQLGetData(1));
        string sName = GetStringByStrRef(StringToInt(PRC_SQLGetData(2)));
        AddChoice(sName, nRow);
    }
    
    if (nCounter == 100)
    {
        SetLocalInt(OBJECT_SELF, "i", nReali+100);
        DelayCommand(0.01, DoSoundsetLoop());
    }
    else // end of the 2da
    {
        if (nGenderSort && !GetPRCSwitch(PRC_CONVOCC_RESTRICT_VOICESETS_BY_SEX)) // run again to select the rest of the voicesets
        {
            nGenderSort = FALSE;
            if(DEBUG) DoDebug("Finished gender specific voicesets");
            DeleteLocalInt(OBJECT_SELF, "i");
            DelayCommand(0.01, DoPortraitsLoop(nGenderSort));
        }
        else // done
        {
            if(DEBUG) DoDebug("Finished Soundsets");
            FloatingTextStringOnCreature("Done", OBJECT_SELF, FALSE);
            DeleteLocalInt(OBJECT_SELF, "i");
            DeleteLocalInt(OBJECT_SELF, "DynConv_Waiting");
            return;
        }
    }
}

void DoWingmodelLoop()
{
    if (GetPRCSwitch(PRC_CONVOCC_AVARIEL_WINGS) && GetLocalInt(OBJECT_SELF, "Race") == RACIAL_TYPE_AVARIEL)
        AddChoice("Bird", 6);
    else if (GetPRCSwitch(PRC_CONVOCC_FEYRI_WINGS) && GetLocalInt(OBJECT_SELF, "Race") == RACIAL_TYPE_FEYRI)
        AddChoice("Bat", 3);
    else if (GetPRCSwitch(PRC_CONVOCC_AASIMAR_WINGS) && GetLocalInt(OBJECT_SELF, "Race") == RACIAL_TYPE_AASIMAR)
    {
        AddChoice("None", 0);
        AddChoice("Angel", 2);
    }
    else if (GetPRCSwitch(PRC_CONVOCC_DISALLOW_CUSTOMISE_WINGS))
        AddChoice("None", 0);
    else
    {
        string sSQL;
        
        sSQL = "SELECT rowid, data FROM prc_cached2da WHERE file='wingmodel' AND columnid = 'label' AND data != '****'";
        
        PRC_SQLExecDirect(sSQL);
        while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
        {
            int nRow = StringToInt(PRC_SQLGetData(1));
            string sName = PRC_SQLGetData(2);
            AddChoice(sName, nRow);
        }
    }
}

void DoTailmodelLoop()
{
    if (GetPRCSwitch(PRC_CONVOCC_FEYRI_TAIL) && GetLocalInt(OBJECT_SELF, "Race") == RACIAL_TYPE_FEYRI)
        AddChoice("Devil", 3);
    else if (GetPRCSwitch(PRC_CONVOCC_TIEFLING_TAIL) && GetLocalInt(OBJECT_SELF, "Race") == RACIAL_TYPE_TIEFLING)
    {
        AddChoice("None", 0);
        AddChoice("Devil", 3);
    }
    else if (GetPRCSwitch(PRC_CONVOCC_DISALLOW_CUSTOMISE_TAIL))
        AddChoice("None", 0);
    else
    {
        string sSQL;
        
        sSQL = "SELECT rowid, data FROM prc_cached2da WHERE file='tailmodel' AND columnid = 'label' AND data != '****'";
        
        PRC_SQLExecDirect(sSQL);
        while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
        {
            int nRow = StringToInt(PRC_SQLGetData(1));
            string sName = PRC_SQLGetData(2);
            AddChoice(sName, nRow);
        }
    }
}

void AddRaceFeats(int nRace)
{
    // gets which race_feat***.2da to use
    string sFile = GetStringLowerCase(Get2DACache("racialtypes", "FeatsTable", nRace));
    // create the Feats array
    array_create(OBJECT_SELF, "Feats");
    int nQTMCount = 0;
    // add on any bonus feats from switches here
    nQTMCount += (GetPRCSwitch(PRC_CONVOCC_BONUS_FEATS));
    /*
        SELECT `data` FROM `prc_cached2da`
        WHERE (`file` = <race_feat***>) AND (`columnid` = 'FeatIndex') AND (`data` != '****')
    */
    string sSQL = "SELECT data FROM prc_cached2da WHERE (file = '" + sFile + "') AND (columnid = 'featindex') AND (data != '****')";
    PRC_SQLExecDirect(sSQL);
    int nFeat;
    while(PRC_SQLFetch() == PRC_SQL_SUCCESS)
    {
        nFeat = StringToInt(PRC_SQLGetData(1)); // feat index
        //alertness fix
        if(nFeat == 0)
            nFeat = -1;
        // if one of these is quick to master, mark for doing the bonus feat later
        if (nFeat == 258)
            nQTMCount++;
        array_set_int(OBJECT_SELF, "Feats", array_get_size(OBJECT_SELF, "Feats"), nFeat);
    }
    // set final bonus feat count
    SetLocalInt(OBJECT_SELF, "QTM", nQTMCount);
}

void AddClassFeats(int nClass)
{
    // gets which class_feat_***.2da to use
    string sFile = GetStringLowerCase(Get2DACache("classes", "FeatsTable", nClass));
    // Feats array should already exist, but check anyway
    int nArraySize = array_get_size(OBJECT_SELF, "Feats");
    if (nArraySize) // if there's stuff in there already
    {
        // has it's own table, so SQL is easiest
        // class feats granted at level 1
        /*
        SELECT `FeatIndex` FROM `prc_cached2da_cls_feat`
        WHERE (`file` = <cls_feat***>) AND (`List` = 3) AND (`GrantedOnLevel` = 1) AND (`FeatIndex` != '****')
        */
        string sSQL = "SELECT featindex FROM prc_cached2da_cls_feat WHERE (file = '" + sFile + "') AND (list = 3) AND (grantedonlevel = 1) AND (featindex != '****')";
        PRC_SQLExecDirect(sSQL);
        int nFeat;
        while (PRC_SQLFetch() == PRC_SQL_SUCCESS)
        {
            nFeat = StringToInt(PRC_SQLGetData(1)); // feat index
            //alertness fix
            if(nFeat == 0)
                nFeat = -1;
            array_set_int(OBJECT_SELF, "Feats", array_get_size(OBJECT_SELF, "Feats"), nFeat);
        }
    }
    else // no feat array - screw up
    {
        /* TODO - start again */
    }
    
}

void AddDomainFeats()
{
    int nDomain = GetLocalInt(OBJECT_SELF, "Domain1");
    // air domain fix
    if (nDomain == -1)
        nDomain = 0;
    // get feat
    string sFeat = Get2DACache("domains", "GrantedFeat", nDomain);
    // add to the feat array
    array_set_int(OBJECT_SELF, "Feats", array_get_size(OBJECT_SELF, "Feats"),
            StringToInt(sFeat));
    
    nDomain = GetLocalInt(OBJECT_SELF, "Domain2");
    // air domain fix
    if (nDomain == -1)
        nDomain = 0;
    sFeat = Get2DACache("domains", "GrantedFeat", nDomain);
    // add to the feat array
    array_set_int(OBJECT_SELF, "Feats", array_get_size(OBJECT_SELF, "Feats"),
            StringToInt(sFeat));
}

void AddColourChoices(int nStage, int nCategory)
{
    // get which 2da column to use
    string s2DAColumn;
    if (nStage == STAGE_SKIN_COLOUR_CHOICE)
        s2DAColumn = "skin";
    else if (nStage == STAGE_HAIR_COLOUR_CHOICE)
        s2DAColumn = "hair";
    else // it's one of the tattoo colour stages
        s2DAColumn = "cloth";
    
    // get which rows to loop through
    int nStart = 0;
    int nStop = 0;
    switch(nCategory) // the category determines which colours get listed
    {
        case 1:
            nStart = 0;
            nStop = 7;
            break;
        case 2:
            nStart = 8;
            nStop = 15;
            break;
        case 3:
            nStart = 16;
            nStop = 23;
            break;
        case 4:
            nStart = 24;
            nStop = 31;
            break;
        case 5:
            nStart = 32;
            nStop = 39;
            break;
        case 6:
            nStart = 40;
            nStop = 47;
            break;
        case 7:
            nStart = 48;
            nStop = 55;
            break;
        case 8: // new colours
            nStart = 56;
            nStop = 63;
            break;
        case 9:
            nStart = 64;
            nStop = 71;
            break;
        case 10:
            nStart = 72;
            nStop = 79;
            break;
        case 11:
            nStart = 80;
            nStop = 87;
            break;
        case 12:
            nStart = 88;
            nStop = 95;
            break;
        case 13:
            nStart = 96;
            nStop = 103;
            break;
        case 14:
            nStart = 104;
            nStop = 111;
            break;
        case 15:
            nStart = 112;
            nStop = 119;
            break;
        case 16:
            nStart = 120;
            nStop = 127;
            break;
        case 17:
            nStart = 128;
            nStop = 135;
            break;
        case 18:
            nStart = 136;
            nStop = 143;
            break;
        case 19:
            nStart = 144;
            nStop = 151;
            break;
        case 20:
            nStart = 152;
            nStop = 159;
            break;
        case 21:
            nStart = 160;
            nStop = 167;
            break;
        case 22:
            nStart = 168;
            nStop = 175;
    }
    // make the list
    int i = nStart;
    while (i <= nStop)
    {
        AddChoice(Get2DACache("colours", s2DAColumn, i), i);
        i++;
    }
}

