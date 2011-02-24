object oCaster = OBJECT_SELF;
object oSpellTarget = PRCGetSpellTargetObject();
object oOrigItem = GetSpellCastItem();
int nOrigClass = GetLastSpellCastClass();
int nCastingClass = PRCGetLastSpellCastClass();
int nClassLvl = GetLevelByClass(nCastingClass, oCaster);
int nCasterLevel = PRCGetCasterLevel(oCaster);
int nSpellbookType = GetSpellbookTypeForClass(nCastingClass);
int nSpellID = PRCGetSpellId();
int nSchool = GetSpellSchool(nSpellID);
int nSpellLevel = PRCGetSpellLevel(oCaster, nSpellID);
int nDC = PRCGetSaveDC(oTarget, oCaster);
int nMetamagic = PRCGetMetaMagicFeat();
int bArcane = GetIsArcaneClass(nCastingClass);
int bDivine = GetIsDivineClass(nCastingClass);
int bHarmful = GetLastSpellHarmful();

