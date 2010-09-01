// Standard Node Transport System Placeable Script
// NodeStone Concept by Gameskippy February 2005
// Script written by Arrabal, modified by Gameskippy 2-7-05
// *****

const string NODESTONE_ROOT = "nodestone_";
void main()
{
    object oPC=GetLastUsedBy();
    if (!GetIsPC(oPC))
        return;
    string sTag=GetTag(OBJECT_SELF);               //Gets the tag of the Node Gate, then
    int nTCrop=GetStringLength(sTag)-5;            //this line and the next crop the
    string sGateID=GetSubString(sTag,5,nTCrop);    //Node Gate Tag to the location
    string sItemTag=NODESTONE_ROOT + sGateID;      //String to check location = Stone
    object oItem=GetItemPossessedBy(oPC,sItemTag); //Does PC have Stone for location?
    object oItem2=GetItemPossessedBy(oPC,"combinednodes");
    if (oItem!=OBJECT_INVALID ||
        oItem2!=OBJECT_INVALID)
    {
        BeginConversation("con_node_normal",oPC);
        FloatingTextStringOnCreature("The Node Gate awakens in response to the stone in your hand.", oPC);
        int nActive = GetLocalInt (OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE");
        // * Play Appropriate Animation
        if (!nActive)
        {
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        }
        // * Store New State
        SetLocalInt(OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE",!nActive);
    }
    else
        FloatingTextStringOnCreature("This Node Gate feels still and quiet, as if sleeping.", oPC);
}
