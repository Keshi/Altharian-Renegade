/////:://///////////////////////////////////////////////////////////////////////
/////:: Library functions for Altharia - written by Winterknight
/////:: Backlash damage on hit
/////:://///////////////////////////////////////////////////////////////////////

// Applies an equal amount of reflective damage to the attacker.
// =======================================
// oPC = the creature that last attacked
void BacklashNegativeDamage(object oPC);

// Applies an equal amount of reflective damage to the attacker.
// =======================================
// oPC = the creature that last attacked
void BacklashAcidDamage(object oPC);

// Applies an equal amount of reflective damage to the attacker.
// =======================================
// oPC = the creature that last attacked
void BacklashColdDamage(object oPC);

// Applies an equal amount of reflective damage to the attacker.
// =======================================
// oPC = the creature that last attacked
void BacklashSonicDamage(object oPC);

// Applies an equal amount of reflective damage to the attacker.
// =======================================
// oPC = the creature that last attacked
void BacklashFireDamage(object oPC);

// Applies an equal amount of reflective damage to the attacker.
// =======================================
// oPC = the creature that last attacked
void BacklashPositiveDamage(object oPC);

// Applies an equal amount of reflective damage to the attacker.
// =======================================
// oPC = the creature that last attacked
void BacklashElectricalDamage(object oPC);

////////////////////////////////////////////////////////////////////////////////
//::                                                                        :://
////////////////////////////////////////////////////////////////////////////////

void BacklashNegativeDamage(object oPC)
{
  int iOuch = GetTotalDamageDealt();
  effect eDam = EffectDamage(iOuch, DAMAGE_TYPE_NEGATIVE);
  effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);

  if(iOuch> 0)
  {
    // Apply effects to the currently selected target.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oPC));
    //This visual effect is applied to the target object not the location as above.  This visual effect
    //represents the flame that erupts on the target not on the ground.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
  }
}

void BacklashAcidDamage(object oPC)
{
  int iOuch = GetTotalDamageDealt();
  effect eDam = EffectDamage(iOuch, DAMAGE_TYPE_ACID);
  effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);

  if(iOuch> 0)
  {
    // Apply effects to the currently selected target.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oPC));
    //This visual effect is applied to the target object not the location as above.  This visual effect
    //represents the flame that erupts on the target not on the ground.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
  }
}

void BacklashColdDamage(object oPC)
{
  int iOuch = GetTotalDamageDealt();
  effect eDam = EffectDamage(iOuch, DAMAGE_TYPE_COLD);
  effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);

  if(iOuch> 0)
  {
    // Apply effects to the currently selected target.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oPC));
    //This visual effect is applied to the target object not the location as above.  This visual effect
    //represents the flame that erupts on the target not on the ground.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
  }
}

void BacklashSonicDamage(object oPC)
{
  int iOuch = GetTotalDamageDealt();
  effect eDam = EffectDamage(iOuch, DAMAGE_TYPE_SONIC);
  effect eVis = EffectVisualEffect(VFX_IMP_SONIC);

  if(iOuch> 0)
  {
    // Apply effects to the currently selected target.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oPC));
    //This visual effect is applied to the target object not the location as above.  This visual effect
    //represents the flame that erupts on the target not on the ground.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
  }
}

void BacklashFireDamage(object oPC)
{
  int iOuch = GetTotalDamageDealt();
  effect eDam = EffectDamage(iOuch, DAMAGE_TYPE_FIRE);
  effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);

  if(iOuch> 0)
  {
    // Apply effects to the currently selected target.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oPC));
    //This visual effect is applied to the target object not the location as above.  This visual effect
    //represents the flame that erupts on the target not on the ground.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
  }
}

void BacklashPositiveDamage(object oPC)
{
  int iOuch = GetTotalDamageDealt();
  effect eDam = EffectDamage(iOuch, DAMAGE_TYPE_POSITIVE);
  effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);

  if(iOuch> 0)
  {
    // Apply effects to the currently selected target.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oPC));
    //This visual effect is applied to the target object not the location as above.  This visual effect
    //represents the flame that erupts on the target not on the ground.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
  }
}

void BacklashElectricalDamage(object oPC)
{
  int iOuch = GetTotalDamageDealt();
  effect eDam = EffectDamage(iOuch, DAMAGE_TYPE_ELECTRICAL);
  effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);

  if(iOuch> 0)
  {
    // Apply effects to the currently selected target.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oPC));
    //This visual effect is applied to the target object not the location as above.  This visual effect
    //represents the flame that erupts on the target not on the ground.
    DelayCommand(0.02f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
  }
}

//void main(){}
