//::///////////////////////////////////////////////
//:: Name alt_onspawnalter
//:: Modified from default spawn script
//:://////////////////////////////////////////////
/*
  This script can be placed on any creature in the OnSpawn event handler.
  It is not recommended for very low level creatures.

  This script will use library scripts contained within the main Altharia mod
  to determine the relative power of the creature being spawned.  It will then
  upgrade the creature's weapons and armor/skins to be appropriate to that
  level of creature in the mod.

  This allows builders to equip normal creature weapons or standard armors from
  Bioware palette, but still be certain their creatures will be of an acceptable
  difficulty when they are encountered in the mod.

  This further allows us to keep the mod size smaller, since we don't have to
  worry about custom items for creatures - the main mod will take care of those
  issues when it spawns the creature.

  However, this can make full-blown testing difficult.  Builders should
  coordinate with Altharian staff for difficulty testing, when debug testing is
  done.

  Finally, this script allows builders the option to re-use existing creature
  blueprints, but change their appearance and names for use elsewhere.  The
  ShiftAppearance function below accomplishes that.  Refer to the add_onspawn
  script in the builder's mod, for more details, and instructions on how this is
  accomplished.

  If you are adding a guardian ability to a creature with the use of the
  wk_sigilonspawn, wk_rogueonspawn, etc. scripts, you will not need to use this
  script.  Those scripts have these functions built into them already.
*/

#include "wk_onspawn"

void main()
{
  int nTough = GetCreatureRating(OBJECT_SELF);
  UpgradeWeapons(OBJECT_SELF,"",nTough);
  UpgradeSkin(OBJECT_SELF, nTough);
  ShiftAppearance(OBJECT_SELF);

  // Execute default OnSpawn script.
  ExecuteScript("nw_c2_default9", OBJECT_SELF);

}
