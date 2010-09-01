//:://////////////////////////////////////////////
//:: Created By: Winterknight
//:: Created On: 10/28/05
//:://////////////////////////////////////////////
#include "nw_i0_tool"
void main()

{
    object oPC = GetEnteringObject();
    if(GetIsObjectValid(oPC) && GetIsPC(oPC))
        {
        /////::Jehon's Warrior Blessing - update quests
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "jehonbless_1_1")) )
            {
            AddJournalQuestEntry("SaintsQuests2",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests4",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests7",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests9",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests11",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests12",2,oPC,FALSE,FALSE,FALSE);
            }

        /////::Jehon's Peaceful Blessing - update quests
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "jehonbless_1_2")) )
            {
            AddJournalQuestEntry("SaintsQuests1",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests3",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests5",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests6",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests8",2,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests10",2,oPC,FALSE,FALSE,FALSE);
            }
        /////::Jehon's Benediction - update quests
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "jehonbenediction")) )
            {
            AddJournalQuestEntry("SaintsQuests1",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests3",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests5",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests6",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests8",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests10",4,oPC,FALSE,FALSE,FALSE);
            }
        /////::Jehon's Malediction - update quests
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "jehonmalediction")) )
            {
            AddJournalQuestEntry("SaintsQuests2",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests4",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests7",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests9",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests11",4,oPC,FALSE,FALSE,FALSE);
            AddJournalQuestEntry("SaintsQuests12",4,oPC,FALSE,FALSE,FALSE);
            }



        /////:: Corek's Objects (SaintsQuests1)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "corekstok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests1",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "coreksbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests1",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "corekstok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests1",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "coreksbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests1",4,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Antir's Objects (SaintsQuests2)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "antirstok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests2",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "antirsbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests2",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "antirstok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests2",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "antirsbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests2",4,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "antirsbles_2"))&&
           GetIsObjectValid(GetItemPossessedBy(oPC, "antirssextant")))
            {
            AddJournalQuestEntry("SaintsQuests2",5,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Johan's Objects (SaintsQuests3)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "johanstok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests3",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "johansbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests3",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "johanstok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests3",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "johansbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests3",4,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Halshor's Objects (SaintsQuests4)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "halshorstok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests4",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "halshorsbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests4",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "halshorstok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests4",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "halshorsbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests4",4,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Laranna's Objects (SaintsQuests5)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "larannastok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests5",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "larannasbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests5",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "larannastok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests5",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "larannasbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests5",4,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Ahram's Objects (SaintsQuests6)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "ahramstok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests6",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "ahramsbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests6",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "ahramstok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests6",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "ahramsbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests6",4,oPC,FALSE,FALSE,FALSE);
            }
        /////:: Imrahadel's Objects (SaintsQuests7)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "imrahadelstok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests7",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "imrahadelsbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests7",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "imrahadelstok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests7",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "imrahadelsbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests7",4,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Rechard's Objects (SaintsQuests8)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "rechardstok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests8",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "rechardsbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests8",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "rechardstok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests8",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "rechardsbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests8",4,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Urleck's Objects (SaintsQuests9)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "urleckstok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests9",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "urlecksbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests9",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "urleckstok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests9",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "urlecksbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests9",4,oPC,FALSE,FALSE,FALSE);
            }


        /////:: Phaegan N'dal's Objects (SaintsQuests10)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "phaeganndalst_1")) )
            {
            AddJournalQuestEntry("SaintsQuests10",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "phaeganndalsb_1")) )
            {
            AddJournalQuestEntry("SaintsQuests10",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "phaeganndalst_2")) )
            {
            AddJournalQuestEntry("SaintsQuests10",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "phaeganndalsb_2")) )
            {
            AddJournalQuestEntry("SaintsQuests10",4,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Shai'Thanis's Objects (SaintsQuests11)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "sharthanistok_1")) )
            {
            AddJournalQuestEntry("SaintsQuests11",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "sharthanisbles_1")) )
            {
            AddJournalQuestEntry("SaintsQuests11",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "sharthanistok_2")) )
            {
            AddJournalQuestEntry("SaintsQuests11",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "sharthanisbles_2")) )
            {
            AddJournalQuestEntry("SaintsQuests11",4,oPC,FALSE,FALSE,FALSE);
            }

        /////:: Kataya Moran's Objects (SaintsQuests12)
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "katayamoranst_1")) )
            {
            AddJournalQuestEntry("SaintsQuests12",1,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "katayamoransb_1")) )
            {
            AddJournalQuestEntry("SaintsQuests12",2,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "katayamoranst_2")) )
            {
            AddJournalQuestEntry("SaintsQuests12",3,oPC,FALSE,FALSE,FALSE);
            }
        if(GetIsObjectValid(GetItemPossessedBy(oPC, "katayamoransb_2")) )
            {
            AddJournalQuestEntry("SaintsQuests12",4,oPC,FALSE,FALSE,FALSE);
            }

        }
}
