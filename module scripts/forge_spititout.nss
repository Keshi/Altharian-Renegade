/////::///////////////////////////////////////////////
/////:: forge_spititout script - check to make sure no more than one item in forge.
/////:: Written by Winterknight on 2/20/06
/////:://////////////////////////////////////////////

void main()
{
  object oFifo2 = GetFirstItemInInventory(OBJECT_SELF);

  if (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED)
    {
      oFifo2 = GetNextItemInInventory(OBJECT_SELF);
      if (GetIsObjectValid(oFifo2))
        {
          location lDrop = GetLocation(GetNearestObjectByTag("forge_spitpoint", OBJECT_SELF,1));
          object oCopy = CopyObject(oFifo2, lDrop, OBJECT_INVALID, "");
          DestroyObject(oFifo2,0.3);
          effect eEff1 = EffectVisualEffect(VFX_FNF_SMOKE_PUFF, FALSE);
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEff1, lDrop, 0.0);
        }
    }
}
