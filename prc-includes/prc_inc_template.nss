//::///////////////////////////////////////////////
//:: Name           template include
//:: FileName       prc_inc_template
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the main include file for the template system
    Deals with applying templates and interacting with the 2da
*/
//:://////////////////////////////////////////////
//:: Created By: Primogenitor
//:: Created On: 18/4/06
//:://////////////////////////////////////////////

//Checks if the target has the template or not.
//returns 1 if it does, 0 if it doesnt or if its an invalid target
int GetHasTemplate(int nTemplate, object oPC = OBJECT_SELF);

//Get total template ECL
int GetTemplateLA(object oPC);

//add a template to the creature
//will not work if it already has the template
//will not work on non-creatures
//if bApply is false, this can test if the template is applicable or not
int ApplyTemplateToObject(int nTemplate, object oPC = OBJECT_SELF, int bApply = TRUE);

#include "prc_inc_function"
//#include "x2_inc_switches"
#include "prc_template_con"
#include "inc_persist_loca"

int GetHasTemplate(int nTemplate, object oPC = OBJECT_SELF)
{
    int bHasTemplate = GetPersistantLocalInt(oPC, "template_"+IntToString(nTemplate));
    if(bHasTemplate && DEBUG)
        DoDebug("GetHasTemplate("+IntToString(nTemplate)+", "+GetName(oPC)+") is true");
    return bHasTemplate;
}

int GetTemplateLA(object oPC)
{
    return GetPersistantLocalInt(oPC, "template_LA");
    /*
    //Loop could TMI avoid it
    int nLA;
    //loop over all templates and see if the player has them
    int i;
    for(i=0;i<200;i++)
    {
        if(GetHasTemplate(i, oPC))
            nLA += StringToInt(Get2DACache("templates", "LA", i));
    }
    return nLA;*/
}

int ApplyTemplateToObject(int nTemplate, object oPC = OBJECT_SELF, int bApply = TRUE)
{
    //templates never stack, so dont let them
    if(GetHasTemplate(nTemplate, oPC))
        return FALSE;
        
    //sanity checks
    if(GetObjectType(oPC) != OBJECT_TYPE_CREATURE)
        return FALSE;
    if(nTemplate < 0 || nTemplate > 200)
        return FALSE;
    
    //test if it can be applied
    string sScript = Get2DACache("templates", "TestScript", nTemplate);
    if(sScript != ""
        && ExecuteScriptAndReturnInt(sScript, oPC))
        return FALSE;      
    
    //if not applying it, abort at this point
    if(!bApply)
        return TRUE;
    
    //run the application script
    sScript = Get2DACache("templates", "SetupScript", nTemplate);
    if(sScript != "")
        ExecuteScript(sScript, oPC);
    
    //mark the PC as possessing the template
    SetPersistantLocalInt(oPC, "template_"+IntToString(nTemplate), TRUE);
    //adjust the LA marker accordingly
    if (!(GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oPC) >= 20 && nTemplate == TEMPLATE_LICH))
    {
    	if(DEBUG) DoDebug("ApplyTemplateToObject(): Adding Template LA");
    	SetPersistantLocalInt(oPC, "template_LA", 
        	GetPersistantLocalInt(oPC, "template_LA")+StringToInt(Get2DACache("templates", "LA", nTemplate)));
    }
    //add the template to the array
    if(!persistant_array_exists(oPC, "templates"))
        persistant_array_create(oPC, "templates");
    persistant_array_set_int(oPC, "templates", persistant_array_get_size(oPC, "templates"), nTemplate);    
    
    
    //run the main PRC feat system so we trigger any other feats weve borrowed
    DelayCommand(0.01, EvalPRCFeats(oPC));
    //ExecuteScript("prc_feat", oPC);
    //ran, evalated, done
    return TRUE;
}
