void main()
{
   object oPC = OBJECT_SELF;

   //If they can cast the spell (whether it's memorized or not..)
   if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0))
   {

      int g = 0;
      if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=1))
      {
       if(GetHasFeat(FEAT_MAGIC_DOMAIN_POWER, oPC))
       {
        g = 1;
       }

      }
      else
      { g = 1; }

      //If they can in fact cast this!
      if(g==1)
      {

         AssignCommand(oPC, ActionCastSpellAtObject
         (SPELL_MAGE_ARMOR, oPC
         , METAMAGIC_NONE
         , TRUE
         , 40
         , PROJECTILE_PATH_TYPE_DEFAULT
         , TRUE));

         DecrementRemainingSpellUses(oPC, SPELL_MAGE_ARMOR);
      }
   }

   //If they can cast the spell (whether it's memorized or not..)
   if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0))
   {
     int h = 0;
      if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=1))
      {
       if(GetHasFeat(FEAT_MAGIC_DOMAIN_POWER, oPC))
       {
        h = 1;
       }

      }
      else
      { h = 1; }

      //If they can in fact cast this!
      if(h==1)
      {
         AssignCommand(oPC, ActionCastSpellAtObject
         (SPELL_STONESKIN, oPC
         , METAMAGIC_NONE
         , TRUE
         , 40
         , PROJECTILE_PATH_TYPE_DEFAULT
         , TRUE));

         DecrementRemainingSpellUses(oPC, SPELL_STONESKIN);
      }
   }


   //Code to make them cast barkskin, (as it's not working normally)
   if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=1)||
       (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>=1))
   {
     int n = 0;

      if(GetLevelByClass(CLASS_TYPE_DRUID, oPC)>=1)
      { n =1; }

      else if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=1))
      {
       if(GetHasFeat(FEAT_PLANT_DOMAIN_POWER, oPC))
       {
        n = 1;
       }

      }



      if(n==1)
      {
         AssignCommand(oPC, ActionCastSpellAtObject
         (SPELL_BARKSKIN, oPC
         , METAMAGIC_NONE
         , TRUE
         , 40
         , PROJECTILE_PATH_TYPE_DEFAULT
         , TRUE));

         DecrementRemainingSpellUses(oPC, SPELL_BARKSKIN);
      }
   }
}
