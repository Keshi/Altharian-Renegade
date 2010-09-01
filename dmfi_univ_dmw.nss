//DMFI Universal Wand scripts by hahnsoo
int DMW_START_CUSTOM_TOKEN = 8000;

//Retrieve targetting information
object oMySpeaker = GetLastSpeaker();
object oMyTarget = GetLocalObject(oMySpeaker, "dmfi_univ_target");
location lMyLoc = GetLocalLocation(oMySpeaker, "dmfi_univ_location");


int dmwand_isnearbydestroyable()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   int nTargetType = GetObjectType(oMyTest);
   return (GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)) && ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE)));
}

int dmwand_istargetcreateable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   return ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE));
}

int dmwand_istargetdestroyable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   if(! GetIsPC(oMyTarget))
   {
      return ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE));
   }
   return FALSE;
}

int dmwand_istargetinvalid()
{
   return !GetIsObjectValid(oMyTarget);
}

int dmwand_istargetinventory()
{
   return (GetIsObjectValid(oMyTarget) && GetHasInventory(oMyTarget));
}

int dmwand_istargetnotme()
{
   return (GetIsObjectValid(oMyTarget) && (oMySpeaker != oMyTarget));
}

int dmwand_istargetpcornpc()
{
   return (GetIsObjectValid(oMyTarget) && GetAbilityScore(oMyTarget, ABILITY_CONSTITUTION));
}

int dmwand_istargetnpc()
{
   return (dmwand_istargetpcornpc() && (! GetIsPC(oMyTarget)));
}

int dmwand_istargetpc()
{
   return (GetIsObjectValid(oMyTarget) && GetIsPC(oMyTarget));
}

int dmwand_istargetpcnme()
{
   return (GetIsObjectValid(oMyTarget) && GetIsPC(oMyTarget) && (oMySpeaker != oMyTarget));
}

int dmwand_istargetpcornpcnme()
{
   return (dmwand_istargetpcornpc() && (oMySpeaker != oMyTarget));
}

int dmwand_istargetplaceable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   return (nTargetType == OBJECT_TYPE_PLACEABLE);
}

int dmw_conv_Start(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Hello there, DM.  What can I do for you?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Display this creature's attributes.";
            sCall =       "conv_DispAttribs";
            sCallParams = "";
            break;
         }
      case 2:
         nCurrent = 2;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Change this creature's alignment.";
            sCall =       "conv_ChangeAlign";
            sCallParams = "";
            break;
         }
      case 3:
         nCurrent = 3;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Map area out for this player.";
            sCall =       "func_MapArea";
            sCallParams = "";
            break;
         }
      case 4:
         nCurrent = 4;
         if(dmwand_istargetinventory())
         {
            sText =       "Work with this object's inventory.";
            sCall =       "conv_Inventory";
            sCallParams = "";
            break;
         }
     case 5:
         nCurrent = 5;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Follow this creature.";
            sCall =       "func_FollowTarget";
            sCallParams = "";
            break;
         }
      case 6:
         nCurrent = 6;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Make this creature follow me.";
            sCall =       "func_FollowMe";
            sCallParams = "";
            break;
         }
      case 7:
         nCurrent = 7;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Make this creature go about its business.";
            sCall =       "func_ResumeDefault";
            sCallParams = "";
            break;
         }
      case 8:
         nCurrent = 8;
         if(dmwand_istargetpcnme())
         {
            sText =       "Penguin this player.";
            sCall =       "func_Toad";
            sCallParams = "";
            break;
         }
      case 9:
         nCurrent = 9;
         if(dmwand_istargetpcnme())
         {
            sText =       "Unpenguin this player.";
            sCall =       "func_Untoad";
            sCallParams = "";
            break;
         }
      case 10:
         nCurrent = 10;
         if(dmwand_istargetpcnme())
         {
            sText =       "Boot this player.";
            sCall =       "func_KickPC";
            sCallParams = "";
            break;
         }
      case 11:
         nCurrent = 11;
         if(dmwand_istargetnpc())
         {
            sText =       "Kill this, leaving a corpse.";
            sCall =       "func_KillAndReplace";
            sCallParams = "";
            break;
         }
      case 12:
         nCurrent = 12;
         if(dmwand_istargetinvalid())
         {
            sText =       "List all players...";
            sCall =       "conv_ListPlayers";
            sCallParams = "func_PlayerListConv";
            break;
         }
      case 13:
         nCurrent = 13;
         if(dmwand_istargetinvalid())
         {
            sText =       "Advance the current time of day.";
            sCall =       "conv_TimeOfDay";
            sCallParams = "";
            break;
         }
      case 14:
         nCurrent = 14;
         if(dmwand_istargetinvalid())
         {
            sText =       "Reload the current running module.";
            sCall =       "func_ReloadModule";
            sCallParams = "";
            break;
         }
      case 15:
         nCurrent = 15;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Roll a skill check.";
            sCall =       "conv_Roll";
            sCallParams = "skill__";
            break;
         }
      case 16:
         nCurrent = 16;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Roll an ability check.";
            sCall =       "conv_Roll";
            sCallParams = "ability";
            break;
         }
      case 17:
         nCurrent = 17;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Destroy this object.";
            sCall =       "func_DestroyTarget";
            sCallParams = "";
            break;
         }
      case 18:
         nCurrent = 18;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Destroy an object near this spot.";
            sCall =       "func_DestroyNearbyTarget";
            sCallParams = "";
            break;
         }
      case 19:
         nCurrent = 19;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Turn this object on.";
            sCall =       "func_TurnTargetOn";
            sCallParams = "";
            break;
         }
      case 20:
         nCurrent = 20;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Turn this object off.";
            sCall =       "func_TurnTargetOff";
            sCallParams = "";
            break;
         }
      case 21:
         nCurrent = 21;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Turn on an object near this spot.";
            sCall =       "func_TurnNearOn";
            sCallParams = "";
            break;
         }
      case 22:
         nCurrent = 22;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Turn off an object near this spot.";
            sCall =       "func_TurnNearOff";
            sCallParams = "";
            break;
         }
      case 23:
         nCurrent = 23;
         if(dmwand_istargetnpc())
         {
            sText =       "Change a player's reputation with this creature's faction.";
            sCall =       "conv_ModRep";
            sCallParams = "one";
            break;
         }
      case 24:
         nCurrent = 24;
         if(dmwand_istargetnpc())
         {
            sText =       "Change all player reputations with this creature's faction.";
            sCall =       "conv_ModRep";
            sCallParams = "all";
            break;
         }
      case 25:
         nCurrent = 25;
         if(dmwand_istargetinvalid())
         {
            sText =       "Export all characters.";
            sCall =       "func_ExportChars";
            sCallParams = "";
            break;
         }
      case 26:
         nCurrent = 26;
         if(dmwand_istargetpcnme())
         {
            sText =       "Join this player's party.";
            sCall =       "func_JoinParty";
            sCallParams = "";
            break;
         }
      case 27:
         nCurrent = 27;
         if(dmwand_istargetinvalid())
         {
            sText =       "Remove me from my current party.";
            sCall =       "func_LeaveParty";
            sCallParams = "";
            break;
         }
      case 28:
         nCurrent = 28;
         if(dmwand_istargetpcnme())
         {
            sText =       "Jump this player to my location.";
            sCall =       "func_JumpPlayerHere";
            sCallParams = "";
            break;
         }
      case 29:
         nCurrent = 29;
         if(dmwand_istargetpcnme())
         {
            sText =       "Jump me to this player's location.";
            sCall =       "func_JumpToPlayer";
            sCallParams = "";
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmwand_BuildConversationDialog(int nCurrent, int nChoice, string sConversation, string sParams)
{
   if(TestStringAgainstPattern(sConversation, "Start"))
   {
      return dmw_conv_Start(nCurrent, nChoice, sParams);
   }
   return FALSE;
}

void dmwand_BuildConversation(string sConversation, string sParams)
{
   int nLast;
   int nTemp;
   int nChoice = 1;
   int nCurrent = 1;
   int nMatch;

   if(TestStringAgainstPattern(sParams, "prev"))
   {
      //Get the number choice to start with
      nCurrent = GetLocalInt(oMySpeaker, "dmw_dialogprev");

      //Since we're going to the previous page, there will be a next
      SetLocalString(oMySpeaker, "dmw_dialog9", "Next ->");
      SetLocalString(oMySpeaker, "dmw_function9", "conv_" + sConversation);
      SetLocalString(oMySpeaker, "dmw_params9", "next");
      SetLocalInt(oMySpeaker, "dmw_dialognext", nCurrent);

      nChoice = 8;
      for(;nChoice >= 0; nChoice--)
      {
         int nTemp1 = nCurrent;
         int nTemp2 = nCurrent;
         nMatch = nTemp2;
         while((nCurrent == nMatch) && (nTemp2 > 0))
         {
            nTemp2--;
            nMatch = dmwand_BuildConversationDialog(nTemp2, nChoice, sConversation, sParams);
         }

         if(nTemp2 <= 0)
         {
            //we went back too far for some reason, so make this choice blank
            SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), "");
            SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), "");
            SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), "");
         }
         nLast = nTemp;
         nTemp = nTemp1;
         nTemp1 = nMatch;
         nCurrent = nMatch;
      }

      if(nMatch > 0)
      {
         SetLocalString(oMySpeaker, "dmw_dialog1", "<- previous");
         SetLocalString(oMySpeaker, "dmw_function1", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params1", "prev");
         SetLocalInt(oMySpeaker, "dmw_dialogprev", nLast);
      }

      //fill the NPC's dialog spot
      //(saved for last because the build process tromps on it)
      dmwand_BuildConversationDialog(0, 0, sConversation, sParams);
   }
   else
   {
      //fill the NPC's dialog spot
      dmwand_BuildConversationDialog(0, 0, sConversation, sParams);

      //No parameters specified, start at the top of the conversation
      if(sParams == "")
      {
         nChoice = 1;
         nCurrent = 1;
      }

      //A "next->" choice was selected
      if(TestStringAgainstPattern(sParams, "next"))
      {
         //get the number choice to start with
         nCurrent = GetLocalInt(oMySpeaker, "dmw_dialognext");

         //set this as the number for the "previous" choice to use
         SetLocalInt(oMySpeaker, "dmw_dialogprev", nCurrent);

         //Set the first dialog choice to be "previous"
         nChoice = 2;
         SetLocalString(oMySpeaker, "dmw_dialog1", "<- Previous");
         SetLocalString(oMySpeaker, "dmw_function1", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params1", "prev");
      }

      //Loop through to build the dialog list
      for(;nChoice <= 10; nChoice++)
      {
         nMatch = dmwand_BuildConversationDialog(nCurrent, nChoice, sConversation, sParams);
         //nLast will be the value of the choice before the last one
         nLast = nTemp;
         nTemp = nMatch;
         if(nMatch > 0) { nCurrent = nMatch; }
         if(nMatch == 0) { nLast = 0; }
         nCurrent++;
      }

      //If there were enough choices to fill 10 spots, make spot 9 a "next"
      if(nLast > 0)
      {
         SetLocalString(oMySpeaker, "dmw_dialog9", "Next ->");
         SetLocalString(oMySpeaker, "dmw_function9", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params9", "next");
         SetLocalInt(oMySpeaker, "dmw_dialognext", nLast);
      }
   }
}

void dmwand_StartConversation()
{
   if(! GetIsObjectValid(oMySpeaker))
   {
      return;
   }

   dmwand_BuildConversation("Start", "");
}

int StartingConditional()
{
   object oPC = GetPCSpeaker();
   int nMyNum = 0;

   //Set Dicebag Broadcast token
   switch(GetLocalInt(oPC, "dmfi_dicebag"))
   {
    case 1: SetCustomToken(20681, "Global"); break;
    case 2: SetCustomToken(20681, "Local"); break;
    case 3: SetCustomToken(20681, "DM Only"); break;
    default: SetCustomToken(20681, "Private"); break;
   }
   //Set Voice preset tokens
   int iLoop = 20610;
   while (iLoop < 20680)
   {
       SetCustomToken(iLoop, GetLocalString(GetModule(), "hls" + IntToString(iLoop)));
       iLoop++;
   }
   SetCustomToken(20680, GetName(GetLocalObject(oPC, "dmfi_univ_target")));
   //Set Faction Wand tokens
   iLoop = 1;
   string sName;
   object sFaction;
   while (iLoop < 10)
   {
        sFaction = GetLocalObject(oPC, "dmfi_customfaction" + IntToString(iLoop));
        sName = GetName(sFaction);
        SetCustomToken(20690 + iLoop, sName + "'s Faction ");
        iLoop++;
   }
   SetCustomToken(20690, GetName(GetLocalObject(oPC, "dmfi_henchman")));

   DeleteLocalInt(oPC, "Tens");
   DeleteLocalInt(oPC, "dmfi_univ_offset");
   SetLocalInt(OBJECT_SELF, "dmfi_dmwOffset", 1);
   //Check whether this conversation has been started already, start it if not.
   int nStarted = GetLocalInt(oMySpeaker, "dmw_started");
   if(! nStarted)
   {
      SetLocalInt(oMySpeaker, "dmw_started", 1);
      dmwand_StartConversation();
   }

   string sMyString = GetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nMyNum));

   if(sMyString == "")
   {
      return FALSE;
   }
   else if (GetLocalString(oPC, "dmfi_univ_conv") == "dmw")
   {
      SetCustomToken(DMW_START_CUSTOM_TOKEN + nMyNum, sMyString);
      return TRUE;
   }
   else
    return FALSE;
}
