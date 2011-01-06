//Script Name: fastbuff_pc
//////////////////////////////////////////
// Created By: Genisys (Guile)
// Created On: 8/13/08
// Updated On: 9/10/2010
/////////////////////////////////////////
/*
This script is executed from another script, utilizing the
ExecuteScript("fastbuff_pc", oPC);   //<<(Therefore OBJECT_SELF in this script = oPC)
function, basically this script will make the PC cast all of their
buff spells, if PC is a spell caster, and they have the spells
available to cast!  Some spells are fired no matter what for clerics & druids
due to bugs, and there is no way to fix this, but more importantly, you should
be aware of one other bug, and that's for Paladinds / Rangers / Bards, which
when they buff, it's only cast at level 1  (a bioware bug that's unfixable)

Lastly, remember that this system cast spells as the caster has them memorized,
so if they are using Metamagic, it will be cast as a metamagic spell (like extended).
*/
/////////////////////////////////////////////////////////////////////////
//**IMPORTANT SETTING***

//Set this to FALSE if you do NOT want to allow this to be used during
//combat, it's set to TRUE by default (allow use in combat)
const int USE_DURING_COMBAT = FALSE;

/////////////////////////////////////////////////////////////////////////

//PROTOTYPE DEFINED
int GetHasBetter(object oTarget, int nInt)
{
  int b = 0;

 //If the current spell (which might be cast) is the lesser,
 //then lets see if they have a great version!

 if(nInt ==10) //Bulls' Strength
 {
  if(GetHasSpell(SPELL_GREATER_BULLS_STRENGTH, oTarget))
  b = 1;
 }

 else if(nInt == 12) //Cat Grace
 {
  //Improved Invisibility has 50% concealment!
  if(GetHasSpell(SPELL_GREATER_CATS_GRACE, oTarget))
  b = 1;
 }

 else if(nInt == 19) //Displacement
 {
  //Improved Invisibility has 50% concealment!
  if(GetHasSpell(SPELL_IMPROVED_INVISIBILITY, oTarget))
  b = 1;
 }

 else if(nInt == 22) //Eagle's Splender
 {
  if(GetHasSpell(SPELL_GREATER_EAGLE_SPLENDOR, oTarget))
  b = 1;
 }

 else if(nInt == 24) //Endurance
 {
  if(GetHasSpell(SPELL_GREATER_ENDURANCE, oTarget))
  b = 1;
 }

 else if(nInt ==27) //SPELL_EXPEDITIOUS_RETREAT
 {
  if(GetHasSpell(SPELL_HASTE, oTarget))
  b = 1;
 }

 else if(nInt == 32) //Fox Cunning
 {
  if(GetHasSpell(SPELL_GREATER_FOXS_CUNNING, oTarget))
  b = 1;
 }

 else if(nInt ==45)//SPELL_GREATER_STONESKIN
 {
  if(GetHasSpell(SPELL_PREMONITION, oTarget))
   b = 1;
 }

 else if(nInt ==46) //SPELL_HASTE
 {
  if(GetHasSpell(SPELL_MASS_HASTE, oTarget))
  b = 1;
 }

 else if(nInt ==50)//SPELL_INVISIBILITY
 {
  if(GetHasSpell(SPELL_IMPROVED_INVISIBILITY, oTarget) ||
     GetHasSpell(SPELL_INVISIBILITY_SPHERE, oTarget))
  b = 1;
 }

else if(nInt ==51)//SPELL_INVISIBILITY_SPHERE
 {
  if(GetHasSpell(SPELL_IMPROVED_INVISIBILITY, oTarget))
  b = 1;
 }

 else if(nInt ==53)//SPELL_LESSER_MIND_BLANK
 {
  if(GetHasSpell(SPELL_MIND_BLANK, oTarget))
  b = 1;
 }

 else if(nInt ==54)//SPELL_LESSER_SPELL_MANTLE
 {
  if(GetHasSpell(SPELL_SPELL_MANTLE, oTarget) ||
     GetHasSpell(SPELL_GREATER_SPELL_MANTLE, oTarget))
  b = 1;
 }

 else if(nInt ==60)//SPELL_MAGIC_WEAPON
 {
  if(GetHasSpell(SPELL_GREATER_MAGIC_WEAPON, oTarget))
  b = 1;
 }

 else if(nInt ==65)//SPELL_MINOR_GLOBE_OF_INVULNERABILITY
 {
  if(GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY, oTarget))
  b = 1;
 }

 else if(nInt == 69) //Owl's Wisdom
 {
  //Improved Invisibility has 50% concealment!
  if(GetHasSpell(SPELL_GREATER_OWLS_WISDOM, oTarget))
  b = 1;
 }

 else if(nInt ==79)//SPELL_SEE_INVISIBILITY
 {
  if(GetHasSpell(SPELL_TRUE_SEEING, oTarget))
  b = 1;
 }

 else if(nInt ==88)//SPELL_SPELL_MANTLE
 {
  if(GetHasSpell(SPELL_GREATER_SPELL_MANTLE, oTarget))
  b = 1;
 }

  else if(nInt ==91)//SPELL_STONESKIN
 {
  if(GetHasSpell(SPELL_GREATER_STONESKIN, oTarget) ||
     GetHasSpell(SPELL_PREMONITION, oTarget))
  b = 1;
 }
 //Otherwise, if it's not a spell in one of these categories
 //Tell the script to have the player cast the spell...
 else
 {
  b = 0;
 }

return b;

//PROTOTYPE END
}

void CastSpell(int nSpell, int i, object oPC)
{

       int nGs = GetHasBetter(oPC, i);

       //If the caster doesn't have a better spell cast this spell (nSpell)
       if(nGs!=1)
       {
         AssignCommand(oPC, ActionCastSpellAtObject
         (nSpell, oPC
         , METAMAGIC_ANY
         , FALSE
         , 0
         , PROJECTILE_PATH_TYPE_DEFAULT
         , TRUE));
       }
}



void Buff()
{
    object oPC;
    int nSpell;
    int i;
    int n;

    oPC = OBJECT_SELF;

     //They must be a caster to use the item!
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0))
   {
      for(i = 1; i<98; i++)
     {
       //This tells us which spell we are looking at..
       //We look at each one in turn, and IF the caster can cast it
       //then we assign them a command to cast it at thier level..
       switch (i)
       {
        case 1: { nSpell = SPELL_AID;} break;
        case 2: { nSpell = SPELL_AMPLIFY; } break;
        case 3: { nSpell = SPELL_AURA_OF_VITALITY; } break;
        case 4: { nSpell = SPELL_AURAOFGLORY; } break;
        case 5: { nSpell = 3;  } break;  // Barkskin
        case 6: { nSpell = SPELL_BATTLETIDE; } break;
        case 7: { nSpell = SPELL_BLESS; } break;
        case 8: { nSpell = SPELL_BLESS_WEAPON; } break;
        case 9: { nSpell = SPELL_BLOOD_FRENZY; } break;
        case 10: { nSpell = SPELL_BULLS_STRENGTH; } break;
        case 11: { nSpell = SPELL_CAMOFLAGE; } break;
        case 12: { nSpell = SPELL_CATS_GRACE; } break;
        case 13: { nSpell = SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE; } break;
        case 14: { nSpell = SPELL_CLARITY; } break;
        case 15: { nSpell = SPELL_DARKFIRE; } break;
        case 16: { nSpell = SPELL_DARKVISION; } break;
        case 17: { nSpell = SPELL_DEATH_ARMOR; } break;
        case 18: { nSpell = SPELL_DEATH_WARD; } break;
        case 19: { nSpell = SPELL_DISPLACEMENT; } break;
        case 20: { nSpell = SPELL_DIVINE_FAVOR; } break;
        case 21: { nSpell = SPELL_DIVINE_POWER; } break;
        case 22: { nSpell = SPELL_EAGLE_SPLEDOR; } break;
        case 23: { nSpell = SPELL_ELEMENTAL_SHIELD; } break;
        case 24: { nSpell = SPELL_ENDURANCE; } break;
        case 25: { nSpell = SPELL_ENDURE_ELEMENTS; } break;
        case 26: { nSpell = SPELL_ENERGY_BUFFER; } break;
        case 27: { nSpell = SPELL_ENTROPIC_SHIELD; } break;
        case 28: { nSpell = SPELL_ETHEREAL_VISAGE; } break;
        case 29: { nSpell = SPELL_ETHEREALNESS; } break;
        case 30: { nSpell = SPELL_EXPEDITIOUS_RETREAT; } break;
        case 31: { nSpell = SPELL_FLAME_WEAPON; } break;
        case 32: { nSpell = SPELL_FOXS_CUNNING; } break;
        case 33: { nSpell = SPELL_FREEDOM_OF_MOVEMENT; } break;
        case 34: { nSpell = SPELL_GHOSTLY_VISAGE; } break;
        case 35: { nSpell = SPELL_GLOBE_OF_INVULNERABILITY; } break;
        case 36: { nSpell = SPELL_GREATER_BULLS_STRENGTH; } break;
        case 37: { nSpell = SPELL_GREATER_CATS_GRACE; } break;
        case 38: { nSpell = SPELL_GREATER_DISPELLING; } break;
        case 39: { nSpell = SPELL_GREATER_EAGLE_SPLENDOR; } break;
        case 40: { nSpell = SPELL_GREATER_ENDURANCE; } break;
        case 41: { nSpell = SPELL_GREATER_FOXS_CUNNING; } break;
        case 42: { nSpell = SPELL_GREATER_MAGIC_WEAPON; } break;
        case 43: { nSpell = SPELL_GREATER_OWLS_WISDOM; } break;
        case 44: { nSpell = SPELL_GREATER_SPELL_MANTLE; } break;
        case 45: { nSpell = SPELL_GREATER_STONESKIN; } break;
        case 46: { nSpell = SPELL_HASTE; } break;
        case 47: { nSpell = SPELL_HOLY_AURA; } break;
        case 48: { nSpell = SPELL_HOLY_SWORD; } break;
        case 49: { nSpell = SPELL_IMPROVED_INVISIBILITY; } break;
        case 50: { nSpell = SPELL_INVISIBILITY; } break;
        case 51: { nSpell = SPELL_INVISIBILITY_SPHERE; } break;
        case 52: { nSpell = SPELL_KEEN_EDGE; } break;
        case 53: { nSpell = SPELL_LESSER_MIND_BLANK; } break;
        case 54: { nSpell = SPELL_LESSER_SPELL_MANTLE; } break;
        case 55: { nSpell = SPELL_LIGHT; } break;
        case 56: { nSpell = 102; } break;  //Mage Armor
        case 57: { nSpell = SPELL_MAGIC_CIRCLE_AGAINST_CHAOS; } break;
        case 58: { nSpell = SPELL_MAGIC_CIRCLE_AGAINST_EVIL; } break;
        case 59: { nSpell = SPELL_MAGIC_VESTMENT; } break;
        case 60: { nSpell = SPELL_MAGIC_WEAPON; } break;
        case 61: { nSpell = SPELL_MASS_CAMOFLAGE; } break;
        case 62: { nSpell = SPELL_MASS_HASTE; } break;
        case 63: { nSpell = SPELL_MESTILS_ACID_SHEATH; } break;
        case 64: { nSpell = SPELL_MIND_BLANK; } break;
        case 65: { nSpell = SPELL_MINOR_GLOBE_OF_INVULNERABILITY; } break;
        case 66: { nSpell = SPELL_NEGATIVE_ENERGY_PROTECTION; } break;
        case 67: { nSpell = SPELL_ONE_WITH_THE_LAND; } break;
        case 68: { nSpell = SPELL_OWLS_INSIGHT; } break;
        case 69: { nSpell = SPELL_OWLS_WISDOM; } break;
        case 70: { nSpell = SPELL_PRAYER; } break;
        case 71: { nSpell = SPELL_PREMONITION; } break;
        case 72: { nSpell = SPELL_PROTECTION__FROM_CHAOS; } break;
        case 73: { nSpell = SPELL_PROTECTION_FROM_ELEMENTS; } break;
        case 74: { nSpell = SPELL_PROTECTION_FROM_EVIL; } break;
        case 75: { nSpell = SPELL_PROTECTION_FROM_SPELLS; } break;
        case 76: { nSpell = SPELL_REGENERATE; } break;
        case 77: { nSpell = SPELL_RESIST_ELEMENTS; } break;
        case 78: { nSpell = SPELL_RESISTANCE; } break;
        case 79: { nSpell = SPELL_SEE_INVISIBILITY; } break;
        case 80: { nSpell = SPELL_SHADES_STONESKIN; } break;
        case 81: { nSpell = SPELL_SHADOW_CONJURATION_INIVSIBILITY; } break;
        case 82: { nSpell = SPELL_SHADOW_CONJURATION_MAGE_ARMOR; } break;
        case 84: { nSpell = SPELL_SHADOW_SHIELD; } break;
        case 85: { nSpell = SPELL_SHIELD; } break;
        case 86: { nSpell = SPELL_SHIELD_OF_FAITH; } break;
        case 87: { nSpell = SPELL_SHIELD_OF_LAW; } break;
        case 88: { nSpell = SPELL_SPELL_MANTLE; } break;
        case 89: { nSpell = SPELL_SPELL_RESISTANCE; } break;
        case 90: { nSpell = SPELL_SPELLSTAFF; } break;
        case 91: { nSpell = 172; } break; //stone skin
        case 92: { nSpell = SPELL_TRUE_SEEING; } break;
        case 93: { nSpell = SPELL_TRUE_STRIKE; } break;
        case 94: { nSpell = SPELL_UNHOLY_AURA; } break;
        case 95: { nSpell = SPELL_VINE_MINE_CAMOUFLAGE; } break;
        case 96: { nSpell = SPELL_VIRTUE; } break;
        case 97: { nSpell = SPELL_WOUNDING_WHISPERS; } break;
       }

        CastSpell(nSpell, i, oPC);
     }
    }
   //Otherwise Tell the PC why they can't buff..
   else
   {
    FloatingTextStringOnCreature("You must be a Spell Caster to use this option!", oPC, FALSE);
   }
}

//Main Script
void main()
{
 //If this system is NOT allowed during combat
 if(USE_DURING_COMBAT == FALSE)
 {
  //If the PC is in combat stop here..
  if(GetIsInCombat(OBJECT_SELF))
  {
   //Tell the PC why this failed..
   FloatingTextStringOnCreature("You cannot fast buff during combat.", OBJECT_SELF, FALSE);
   return; //stop script here (don't buff)
  }
 }

 Buff();
 //Make the PC hard cast these spells!
 DelayCommand(0.1, ExecuteScript("exc_buff_2", OBJECT_SELF));
}

/////////////THE END, WOOHOO!!!///////////

