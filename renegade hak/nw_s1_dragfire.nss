//::///////////////////////////////////////////////
//:: Dragon Breath Fire
//:: NW_S1_DragFire
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calculates the proper damage and DC Save for the
    breath weapon based on the HD of the dragon.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 9, 2001
//:://////////////////////////////////////////////

const string DRAGBREATHLOCK = "DragonBreathLock";


//modified to use the breath include - Fox
#include "prc_alterations"
#include "prc_inc_breath"

void main()
{
    // Check the dragon breath delay lock
    if(GetLocalInt(OBJECT_SELF, DRAGBREATHLOCK))
    {
        SendMessageToPC(OBJECT_SELF, "You cannot use your breath weapon again so soon");
        return;
    }

    //Declare major variables
    int nAge = GetHitDice(OBJECT_SELF);
    int nDC;// = nAge / 2;
    int nDamageDice = 1;
    int nDamage;
    struct breath FireBreath;

   //Use the HD of the creature to determine damage and save DC
    if (nAge <= 6) //Wyrmling
    {
       nDamage = 8;
       nDamageDice = 2; 
       nDC = 14;
    }
    else if (nAge >= 7 && nAge <= 9) //Very Young
    {
       nDamage = 8;
       nDamageDice = 4;
        nDC = 16;
    }
    else if (nAge >= 10 && nAge <= 12) //Young
    {
        nDamage = 8;
        nDamageDice = 6;
        nDC = 18;
    }
    else if (nAge >= 13 && nAge <= 15) //Juvenile
    {
        nDamage = 8;
        nDamageDice = 8;
        nDC = 20;
    }
    else if (nAge >= 16 && nAge <= 18) //Young Adult
    {
        nDamage = 8;
        nDamageDice = 10;
        nDC = 23;
    }
    else if (nAge >= 19 && nAge <= 21) //Adult
    {
        nDamage = 8;
        nDamageDice = 12;
        nDC = 25;
    }
    else if (nAge >= 22 && nAge <= 24) //Mature Adult
    {
        nDamage = 8;
        nDamageDice = 14;
        nDC = 27;
    }
    else if (nAge >= 25 && nAge <= 27) //Old
    {
        nDamage = 8;
        nDamageDice = 16;
        nDC = 29;
    }
    else if (nAge >= 28 && nAge <= 30) //Very Old
    {
        nDamage = 8;
        nDamageDice = 18;
        nDC = 31;
    }
    else if (nAge >= 31 && nAge <= 33) //Ancient
    {
        nDamage = 10;
        nDamageDice = 30;
        nDC = 50;
    }
    else if (nAge >= 34 && nAge <= 37) //Wyrm
    {
        nDamage = 10;
        nDamageDice = 40;
        nDC = 60;
    }
    else if (nAge > 37) //Great Wyrm
    {
        nDamage = 10;
        nDamageDice = 50;
        nDC = 70;
    }



if (GetTag(OBJECT_SELF)=="pc_MortifeAttackDog")
     {
        nDamage = 400;
        nDC = 60;
     }

   if (GetTag(OBJECT_SELF)=="pc_MiniDragon")
     {
        nDamage = 400;
        nDC = 60;
     }

   if (GetTag(OBJECT_SELF)=="pc_RiftDragon")
     {
        nDamage = 600;
        nDC = 70;
     }

   if (GetTag(OBJECT_SELF)=="pc_Torch")
     {
        nDamage = 800;
        nDC = 80;
     }

   if (GetTag(OBJECT_SELF)=="boom_4m_RiftBoss")
     {
        nDamage = 800;
        nDC = 90;
     }

// Check for Dragon armor/PC items
  //  if (GetIsPC(OBJECT_SELF))
  //      {
  //          nDamage = 20;
  //          nDamageDice = nAge;
  //          nDC = 70;
  //      }



    //create the breath - 40' ~ 14m? - should set it based on size later
    FireBreath = CreateBreath(OBJECT_SELF, FALSE, 40.0, DAMAGE_TYPE_FIRE, nDamage, nDamageDice, ABILITY_CONSTITUTION, nDC);

    //Apply the breath
    PRCPlayDragonBattleCry();
    ApplyBreath(FireBreath, GetSpellTargetLocation());

    //Apply the recharge lock
    SetLocalInt(OBJECT_SELF, DRAGBREATHLOCK, TRUE);

    // Schedule opening the delay lock
    float fDelay = RoundsToSeconds(FireBreath.nRoundsUntilRecharge);
    SendMessageToPC(OBJECT_SELF, "Your breath weapon will be ready again in " + IntToString(FireBreath.nRoundsUntilRecharge) + " rounds.");

    DelayCommand(fDelay, DeleteLocalInt(OBJECT_SELF, DRAGBREATHLOCK));
    DelayCommand(fDelay, SendMessageToPC(OBJECT_SELF, "Your breath weapon is ready now"));
}

