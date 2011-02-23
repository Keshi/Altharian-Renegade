#include "wk_lootsystem"

void main()
{
 object oChest = OBJECT_SELF;              // Get the Chest Object
 DelayCommand(0.1, wk_chestloot(oChest));  // Spawn the goods
 DelayCommand(590.0, ClearChest(oChest));
 DelayCommand(600.0, SetLocalInt(oChest,"AmILooted",0));
}
