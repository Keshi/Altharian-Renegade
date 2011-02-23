//::///////////////////////////////////////////
//:: add_onspawn
//:: Written by Winterknight for Altharia 8/21/07
//::///////////////////////////////////////////
//:: This script is used for builders only.  It is used to add creature
//:: onspawn special changes, primarily to appearance, or to weapon properties.
//::
//:: This will not be an in-mod script for the main mod. Instead, any creatures
//:: used in here will be copied to the main mod from this script.  Builders
//:: are responsible to ensure that creature tags are correct, that the format
//:: for properties is correct, and that appearance choice is correct.
//::
//:: Builders must ensure that they export this file, if it is used, as it will
//:: not normally be exported with areas/creatures, unless specially chosen.
//::///////////////////////////////////////////

/*
  Standard changes are highlighted below.  You can copy one of these sections
  and alter the data in it to your specific needs.  Because this is set up for
  you to copy and alter, the comments are summarized above the performance
  section.

  This script will not compile.  Attempting to compile it, or build the module
  will result in an error.  Ignore it.  This script is for adding functions to
  the main mod in Altharia, not for use in the builder's mod.
*/

//::////////////////////////////////////////////////////////////////////////////
//:: How to add bonus properties to a creature's weapon or armor
//:: You should have a definite need for the properties added, to make these
//:: additions.
//::////////////////////////////////////////////////////////////////////////////

/*
  The tag of the creature is the tag that is on the creature as it appears in
  the palette.

  ipAdd can be whatever property you wish it to be. I have shown Holy Avenger
  here, as an example.  Please note that in most cases, you can simply equip
  the creature with a standard Bioware weapon that has the property you want to
  add, including Holy Avenger.

  If the bonus property is only to be applied in a certain area, change the
  nCheck value to 1, instead of 0.  Then change string sTag from "xxx" to
  the tag of the applicable area.
*/
/*
  if (sTag == "tag_of_creature")
  {
    itemproperty ipAdd = ItemPropertyHolyAvenger();
    int nCheck = 0;
    if (nCheck == 1)
    {
      string sTag = "xxx";
      object oArea = GetArea(OBJECT_SELF);
      if (GetTag(oArea) == sTag) AddBonusProperty(OBJECT_SELF, ipAdd);
    }
    else if (nCheck == 0) AddBonusProperty(OBJECT_SELF, ipAdd);
  }
*/
/*
  If you are trying to add a property to a creature's armor or skin, use the
  above procedure, but change the command AddBonusProperty to AddArmorProperty.
*/

//::////////////////////////////////////////////////////////////////////////////
//:: How to change appearance of a creature by area.  You should only add these
//:: for creatures that are re-used across multiple areas but that have
//:: different appearances and names.
//::////////////////////////////////////////////////////////////////////////////

/*
  In the example below, for a single creature's tag, we are have the opportunity
  to change appearance in two separate zones.  In reality, we would have 3
  choices for appearance: the default creature in the palette (native zone), an
  appearance for area tag "xxx", and a third appearance for area tag "yyy".

  The appearance is chosen from the Constants tab on the right hand side of the
  script editor. It is easiest to simply highlight over the entire existing
  value for APPEARANCE_TYPE_XXX in the script below, and double click on the
  new value from the list of constants.

  When we change appearance, we should change name as well.  The SetName command
  below does that.

  The section in the script beginning with sArea = "xxx", and ending with the
  end of the if check can be copied multiple times, for as many incarnations as
  there are of the base creature.

  The one thing this won't do is change the creature's tag - that has to be done
  at the time of the command to spawn, not in the OnSpawn of the creature, which
  fires after the command to spawn.  However, there is a trigger in Example area
  1 that shows how the tag can be customized when spawning, thus producing
  versions of creatures that may or may not have explosive death effects or
  other differences driven by key tag codes.

  However, this may be more complicated than desired, if many instances of the
  creature are planned.  It may be easier to simply create a copy of the
  creature with a different tag, if they will be mob spawned.
*/
/*
     if (sTag == "jp_minegoblin2")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "dela_ofkt1" || sArea == "dela_ofkt2"
      || sArea == "dela_ofkt3")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_CHIEF_B);
      SetName(OBJECT_SELF,"Kobold Corporal");
    }
  }

     if (sTag == "jp_minegoblin1")
  {
     object oArea = GetArea(OBJECT_SELF);
     string sArea = GetTag(oArea);

     if (sArea == "dela_ofkt1" || sArea == "dela_ofkt2"
      || sArea == "dela_ofkt3")
    {
      SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_KOBOLD_CHIEF_A);
      SetName(OBJECT_SELF,"Kobold Sentry");
    }
  }
*/
