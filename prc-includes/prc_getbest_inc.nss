// Returns the best available-for-casting Level 0 spell from oTarget.
int GetBestL0Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 1 spell from oTarget.
int GetBestL1Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 2 spell from oTarget.
int GetBestL2Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 3 spell from oTarget.
int GetBestL3Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 4 spell from oTarget.
int GetBestL4Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 5 spell from oTarget.
int GetBestL5Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 6 spell from oTarget.
int GetBestL6Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 7 spell from oTarget.
int GetBestL7Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 8 spell from oTarget.
int GetBestL8Spell(object oTarget, int nSpell);

// Returns the best available-for-casting Level 9 spell from oTarget.
int GetBestL9Spell(object oTarget, int nSpell);

// Returns the best available-for-casting spell from oTarget's repertoire.
int GetBestAvailableSpell(object oTarget);


int GetBestL0Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_VIRTUE, oTarget) > 0) nBestSpell = SPELL_VIRTUE;
    if (GetHasSpell(SPELL_LIGHT, oTarget) > 0) nBestSpell = SPELL_LIGHT;
    if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS, oTarget) > 0) nBestSpell = SPELL_CURE_MINOR_WOUNDS;
    if (GetHasSpell(SPELL_INFLICT_MINOR_WOUNDS, oTarget) > 0) nBestSpell = SPELL_INFLICT_MINOR_WOUNDS;
    if (GetHasSpell(SPELL_RESISTANCE, oTarget) > 0) nBestSpell = SPELL_RESISTANCE;
    if (GetHasSpell(SPELL_FLARE, oTarget) > 0) nBestSpell = SPELL_FLARE;
    if (GetHasSpell(SPELL_ELECTRIC_JOLT, oTarget) > 0) nBestSpell = SPELL_ELECTRIC_JOLT;
    if (GetHasSpell(SPELL_DAZE, oTarget) > 0) nBestSpell = SPELL_DAZE;
    if (GetHasSpell(SPELL_RAY_OF_FROST, oTarget) > 0) nBestSpell = SPELL_RAY_OF_FROST;
    if (GetHasSpell(SPELL_ACID_SPLASH, oTarget) > 0) nBestSpell = SPELL_ACID_SPLASH;
    return nBestSpell;
}

int GetBestL1Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_IDENTIFY, oTarget) > 0) nBestSpell = SPELL_IDENTIFY;
    if (GetHasSpell(SPELL_PROTECTION_FROM_EVIL, oTarget) > 0) nBestSpell = SPELL_PROTECTION_FROM_EVIL;
    if (GetHasSpell(SPELL_PROTECTION__FROM_CHAOS, oTarget) > 0) nBestSpell = SPELL_PROTECTION__FROM_CHAOS;
    if (GetHasSpell(SPELL_PROTECTION_FROM_GOOD, oTarget) > 0) nBestSpell = SPELL_PROTECTION_FROM_GOOD;
    if (GetHasSpell(SPELL_PROTECTION_FROM_LAW, oTarget) > 0) nBestSpell = SPELL_PROTECTION_FROM_LAW;
    if (GetHasSpell(SPELL_INFLICT_LIGHT_WOUNDS, oTarget) > 0) nBestSpell = SPELL_INFLICT_LIGHT_WOUNDS;
    if (GetHasSpell(SPELL_IRONGUTS, oTarget) > 0) nBestSpell = SPELL_IRONGUTS;
    if (GetHasSpell(SPELL_REMOVE_FEAR, oTarget) > 0) nBestSpell = SPELL_REMOVE_FEAR;
    if (GetHasSpell(SPELL_RESIST_ELEMENTS, oTarget) > 0) nBestSpell = SPELL_RESIST_ELEMENTS;
    if (GetHasSpell(SPELL_COLOR_SPRAY, oTarget) > 0) nBestSpell = SPELL_COLOR_SPRAY;
    if (GetHasSpell(SPELL_CAMOFLAGE, oTarget) > 0) nBestSpell = SPELL_CAMOFLAGE;
    if (GetHasSpell(SPELL_GREASE, oTarget) > 0) nBestSpell = SPELL_GREASE;
    if (GetHasSpell(SPELL_SCARE, oTarget) > 0) nBestSpell = SPELL_SCARE;
    if (GetHasSpell(SPELL_MAGIC_WEAPON, oTarget) > 0) nBestSpell = SPELL_MAGIC_WEAPON;
    if (GetHasSpell(SPELL_SLEEP, oTarget) > 0) nBestSpell = SPELL_SLEEP;
    if (GetHasSpell(SPELL_DIVINE_FAVOR, oTarget) > 0) nBestSpell = SPELL_DIVINE_FAVOR;
    if (GetHasSpell(SPELL_ENTANGLE, oTarget) > 0) nBestSpell = SPELL_ENTANGLE;
    if (GetHasSpell(SPELL_ENTROPIC_SHIELD, oTarget) > 0) nBestSpell = SPELL_ENTROPIC_SHIELD;
    if (GetHasSpell(SPELL_ICE_DAGGER, oTarget) > 0) nBestSpell = SPELL_ICE_DAGGER;
    if (GetHasSpell(SPELL_EXPEDITIOUS_RETREAT, oTarget) > 0) nBestSpell = SPELL_EXPEDITIOUS_RETREAT;
    if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT, oTarget) > 0) nBestSpell = SPELL_RAY_OF_ENFEEBLEMENT;
    if (GetHasSpell(SPELL_TRUE_STRIKE, oTarget) > 0) nBestSpell = SPELL_TRUE_STRIKE;
    if (GetHasSpell(SPELL_AMPLIFY, oTarget) > 0) nBestSpell = SPELL_AMPLIFY;
    if (GetHasSpell(SPELL_SHIELD_OF_FAITH, oTarget) > 0) nBestSpell = SPELL_SHIELD_OF_FAITH;
    if (GetHasSpell(SPELL_HORIZIKAULS_BOOM, oTarget) > 0) nBestSpell = SPELL_HORIZIKAULS_BOOM;
    if (GetHasSpell(SPELL_BURNING_HANDS, oTarget) > 0) nBestSpell = SPELL_BURNING_HANDS;
    if (GetHasSpell(SPELL_NEGATIVE_ENERGY_RAY, oTarget) > 0) nBestSpell = SPELL_NEGATIVE_ENERGY_RAY;
    if (GetHasSpell(SPELL_SHELGARNS_PERSISTENT_BLADE, oTarget) > 0) nBestSpell = SPELL_SHELGARNS_PERSISTENT_BLADE;
    if (GetHasSpell(SPELL_BLESS_WEAPON, oTarget) > 0) nBestSpell = SPELL_BLESS_WEAPON;
    if (GetHasSpell(SPELL_BALAGARNSIRONHORN, oTarget) > 0) nBestSpell = SPELL_BALAGARNSIRONHORN;
    if (GetHasSpell(SPELL_DEAFENING_CLANG, oTarget) > 0) nBestSpell = SPELL_DEAFENING_CLANG;
    if (GetHasSpell(SPELL_CHARM_PERSON, oTarget) > 0) nBestSpell = SPELL_CHARM_PERSON;
    if (GetHasSpell(SPELL_SHIELD, oTarget) > 0) nBestSpell = SPELL_SHIELD;
    if (GetHasSpell(SPELL_SANCTUARY, oTarget) > 0) nBestSpell = SPELL_SANCTUARY;
    if (GetHasSpell(SPELL_LESSER_DISPEL, oTarget) > 0) nBestSpell = SPELL_LESSER_DISPEL;
    if (GetHasSpell(SPELL_ENDURE_ELEMENTS, oTarget) > 0) nBestSpell = SPELL_ENDURE_ELEMENTS;
    if (GetHasSpell(SPELL_MAGE_ARMOR, oTarget) > 0) nBestSpell = SPELL_MAGE_ARMOR;
    if (GetHasSpell(SPELL_MAGIC_FANG, oTarget) > 0) nBestSpell = SPELL_MAGIC_FANG;
    if (GetHasSpell(SPELL_BLESS, oTarget) > 0) nBestSpell = SPELL_BLESS;
    if (GetHasSpell(SPELL_BANE, oTarget) > 0) nBestSpell = SPELL_BANE;
    if (GetHasSpell(SPELL_DOOM, oTarget) > 0) nBestSpell = SPELL_DOOM;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_I, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_I;
    if (GetHasSpell(SPELL_MAGIC_MISSILE, oTarget) > 0) nBestSpell = SPELL_MAGIC_MISSILE;
    if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS, oTarget) > 0) nBestSpell = SPELL_CURE_LIGHT_WOUNDS;
    return nBestSpell;
}

int GetBestL2Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_CONTINUAL_FLAME, oTarget) > 0) nBestSpell = SPELL_CONTINUAL_FLAME;
    if (GetHasSpell(SPELL_AID, oTarget) > 0) nBestSpell = SPELL_AID;
    if (GetHasSpell(SPELL_INFLICT_MODERATE_WOUNDS, oTarget) > 0) nBestSpell = SPELL_INFLICT_MODERATE_WOUNDS;
    if (GetHasSpell(SPELL_HOLD_ANIMAL, oTarget) > 0) nBestSpell = SPELL_HOLD_ANIMAL;
    if (GetHasSpell(SPELL_AURAOFGLORY, oTarget) > 0) nBestSpell = SPELL_AURAOFGLORY;
    if (GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL, oTarget) > 0) nBestSpell = SPELL_CHARM_PERSON_OR_ANIMAL;
    if (GetHasSpell(SPELL_DARKNESS, oTarget) > 0) nBestSpell = SPELL_DARKNESS;
    if (GetHasSpell(SPELL_DEATH_ARMOR, oTarget) > 0) nBestSpell = SPELL_DEATH_ARMOR;
    if (GetHasSpell(SPELL_DARKVISION, oTarget) > 0) nBestSpell = SPELL_DARKVISION;
    if (GetHasSpell(SPELL_BARKSKIN, oTarget) > 0) nBestSpell = SPELL_BARKSKIN;
    if (GetHasSpell(SPELL_STONE_BONES, oTarget) > 0) nBestSpell = SPELL_STONE_BONES;
    if (GetHasSpell(SPELL_BLINDNESS_AND_DEAFNESS, oTarget) > 0) nBestSpell = SPELL_BLINDNESS_AND_DEAFNESS;
    if (GetHasSpell(SPELL_BLOOD_FRENZY, oTarget) > 0) nBestSpell = SPELL_BLOOD_FRENZY;
    if (GetHasSpell(SPELL_TASHAS_HIDEOUS_LAUGHTER, oTarget) > 0) nBestSpell = SPELL_TASHAS_HIDEOUS_LAUGHTER;
    if (GetHasSpell(SPELL_CLOUD_OF_BEWILDERMENT, oTarget) > 0) nBestSpell = SPELL_CLOUD_OF_BEWILDERMENT;
    if (GetHasSpell(SPELL_REMOVE_PARALYSIS, oTarget) > 0) nBestSpell = SPELL_REMOVE_PARALYSIS;
    if (GetHasSpell(SPELL_GEDLEES_ELECTRIC_LOOP, oTarget) > 0) nBestSpell = SPELL_GEDLEES_ELECTRIC_LOOP;
    if (GetHasSpell(SPELL_HOLD_PERSON, oTarget) > 0) nBestSpell = SPELL_HOLD_PERSON;
    if (GetHasSpell(SPELL_SEE_INVISIBILITY, oTarget) > 0) nBestSpell = SPELL_SEE_INVISIBILITY;
    if (GetHasSpell(SPELL_SILENCE, oTarget) > 0) nBestSpell = SPELL_SILENCE;
    if (GetHasSpell(SPELL_SOUND_BURST, oTarget) > 0) nBestSpell = SPELL_SOUND_BURST;
    if (GetHasSpell(SPELL_GHOSTLY_VISAGE, oTarget) > 0) nBestSpell = SPELL_GHOSTLY_VISAGE;
    if (GetHasSpell(SPELL_KNOCK, oTarget) > 0) nBestSpell = SPELL_KNOCK;
    if (GetHasSpell(SPELL_GHOUL_TOUCH, oTarget) > 0) nBestSpell = SPELL_GHOUL_TOUCH;
    if (GetHasSpell(SPELL_COMBUST, oTarget) > 0) nBestSpell = SPELL_COMBUST;
    if (GetHasSpell(SPELL_WEB, oTarget) > 0) nBestSpell = SPELL_WEB;
    if (GetHasSpell(SPELL_FLAME_WEAPON, oTarget) > 0) nBestSpell = SPELL_FLAME_WEAPON;
    if (GetHasSpell(SPELL_FLAME_LASH, oTarget) > 0) nBestSpell = SPELL_FLAME_LASH;
    if (GetHasSpell(SPELL_LESSER_RESTORATION, oTarget) > 0) nBestSpell = SPELL_LESSER_RESTORATION;
    if (GetHasSpell(SPELL_FIND_TRAPS, oTarget) > 0) nBestSpell = SPELL_FIND_TRAPS;
    if (GetHasSpell(SPELL_CLARITY, oTarget) > 0) nBestSpell = SPELL_CLARITY;
    if (GetHasSpell(SPELL_INVISIBILITY, oTarget) > 0) nBestSpell = SPELL_INVISIBILITY;
    if (GetHasSpell(SPELL_ONE_WITH_THE_LAND, oTarget) > 0) nBestSpell = SPELL_ONE_WITH_THE_LAND;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_II, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_II;
    if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS, oTarget) > 0) nBestSpell = SPELL_PROTECTION_FROM_ELEMENTS;
    if (GetHasSpell(SPELL_OWLS_WISDOM, oTarget) > 0) nBestSpell = SPELL_OWLS_WISDOM;
    if (GetHasSpell(SPELL_EAGLE_SPLEDOR, oTarget) > 0) nBestSpell = SPELL_EAGLE_SPLEDOR;
    if (GetHasSpell(SPELL_FOXS_CUNNING, oTarget) > 0) nBestSpell = SPELL_FOXS_CUNNING;
    if (GetHasSpell(SPELL_ENDURANCE, oTarget) > 0) nBestSpell = SPELL_ENDURANCE;
    if (GetHasSpell(SPELL_CATS_GRACE, oTarget) > 0) nBestSpell = SPELL_CATS_GRACE;
    if (GetHasSpell(SPELL_BULLS_STRENGTH, oTarget) > 0) nBestSpell = SPELL_BULLS_STRENGTH;
    if (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS, oTarget) > 0) nBestSpell = SPELL_CURE_MODERATE_WOUNDS;
    if (GetHasSpell(SPELL_MELFS_ACID_ARROW, oTarget) > 0) nBestSpell = SPELL_MELFS_ACID_ARROW;
    return nBestSpell;
}

int GetBestL3Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_BESTOW_CURSE, oTarget) > 0) nBestSpell = SPELL_BESTOW_CURSE;
    if (GetHasSpell(SPELL_CHARM_MONSTER, oTarget) > 0) nBestSpell = SPELL_CHARM_MONSTER;
    if (GetHasSpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oTarget) > 0) nBestSpell = SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
    if (GetHasSpell(SPELL_INFLICT_SERIOUS_WOUNDS, oTarget) > 0) nBestSpell = SPELL_INFLICT_SERIOUS_WOUNDS;
    if (GetHasSpell(SPELL_DARKFIRE, oTarget) > 0) nBestSpell = SPELL_DARKFIRE;
    if (GetHasSpell(SPELL_PRAYER, oTarget) > 0) nBestSpell = SPELL_PRAYER;
    if (GetHasSpell(SPELL_CONFUSION, oTarget) > 0) nBestSpell = SPELL_CONFUSION;
    if (GetHasSpell(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, oTarget) > 0) nBestSpell = SPELL_REMOVE_BLINDNESS_AND_DEAFNESS;
    if (GetHasSpell(SPELL_REMOVE_CURSE, oTarget) > 0) nBestSpell = SPELL_REMOVE_CURSE;
    if (GetHasSpell(SPELL_REMOVE_DISEASE, oTarget) > 0) nBestSpell = SPELL_REMOVE_DISEASE;
    if (GetHasSpell(SPELL_HEALING_STING, oTarget) > 0) nBestSpell = SPELL_HEALING_STING;
    if (GetHasSpell(SPELL_CONTAGION, oTarget) > 0) nBestSpell = SPELL_CONTAGION;
    if (GetHasSpell(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget) > 0) nBestSpell = SPELL_NEGATIVE_ENERGY_PROTECTION;
    if (GetHasSpell(SPELL_NEUTRALIZE_POISON, oTarget) > 0) nBestSpell = SPELL_NEUTRALIZE_POISON;
    if (GetHasSpell(SPELL_ANIMATE_DEAD, oTarget) > 0) nBestSpell = SPELL_ANIMATE_DEAD;
    if (GetHasSpell(SPELL_INFESTATION_OF_MAGGOTS, oTarget) > 0) nBestSpell = SPELL_INFESTATION_OF_MAGGOTS;
    if (GetHasSpell(SPELL_GUST_OF_WIND, oTarget) > 0) nBestSpell = SPELL_GUST_OF_WIND;
    if (GetHasSpell(SPELL_GREATER_MAGIC_FANG, oTarget) > 0) nBestSpell = SPELL_GREATER_MAGIC_FANG;
    if (GetHasSpell(SPELL_QUILLFIRE, oTarget) > 0) nBestSpell = SPELL_QUILLFIRE;
    if (GetHasSpell(SPELL_WOUNDING_WHISPERS, oTarget) > 0) nBestSpell = SPELL_WOUNDING_WHISPERS;
    if (GetHasSpell(SPELL_SPIKE_GROWTH, oTarget) > 0) nBestSpell = SPELL_SPIKE_GROWTH;
    if (GetHasSpell(SPELL_STINKING_CLOUD, oTarget) > 0) nBestSpell = SPELL_STINKING_CLOUD;
    if (GetHasSpell(SPELL_POISON, oTarget) > 0) nBestSpell = SPELL_POISON;
    if (GetHasSpell(SPELL_GREATER_MAGIC_WEAPON, oTarget) > 0) nBestSpell = SPELL_GREATER_MAGIC_WEAPON;
    if (GetHasSpell(SPELL_BLADE_THIRST, oTarget) > 0) nBestSpell = SPELL_BLADE_THIRST;
    if (GetHasSpell(SPELL_FEAR, oTarget) > 0) nBestSpell = SPELL_FEAR;
    if (GetHasSpell(SPELL_INVISIBILITY_PURGE, oTarget) > 0) nBestSpell = SPELL_INVISIBILITY_PURGE;
    if (GetHasSpell(SPELL_INVISIBILITY_SPHERE, oTarget) > 0) nBestSpell = SPELL_INVISIBILITY_SPHERE;
    if (GetHasSpell(SPELL_GLYPH_OF_WARDING, oTarget) > 0) nBestSpell = SPELL_GLYPH_OF_WARDING;
    if (GetHasSpell(SPELL_DOMINATE_ANIMAL, oTarget) > 0) nBestSpell = SPELL_DOMINATE_ANIMAL;
    if (GetHasSpell(SPELL_MAGIC_VESTMENT, oTarget) > 0) nBestSpell = SPELL_MAGIC_VESTMENT;
    if (GetHasSpell(SPELL_KEEN_EDGE, oTarget) > 0) nBestSpell = SPELL_KEEN_EDGE;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_III, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_III;
    if (GetHasSpell(SPELL_NEGATIVE_ENERGY_BURST, oTarget) > 0) nBestSpell = SPELL_NEGATIVE_ENERGY_BURST;
    if (GetHasSpell(SPELL_LIGHTNING_BOLT, oTarget) > 0) nBestSpell = SPELL_LIGHTNING_BOLT;
    if (GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_CHAOS, oTarget) > 0) nBestSpell = SPELL_MAGIC_CIRCLE_AGAINST_CHAOS;
    if (GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_EVIL, oTarget) > 0) nBestSpell = SPELL_MAGIC_CIRCLE_AGAINST_EVIL;
    if (GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_GOOD, oTarget) > 0) nBestSpell = SPELL_MAGIC_CIRCLE_AGAINST_GOOD;
    if (GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_LAW, oTarget) > 0) nBestSpell = SPELL_MAGIC_CIRCLE_AGAINST_LAW;
    if (GetHasSpell(SPELL_MESTILS_ACID_BREATH, oTarget) > 0) nBestSpell = SPELL_MESTILS_ACID_BREATH;
    if (GetHasSpell(SPELL_SCINTILLATING_SPHERE, oTarget) > 0) nBestSpell = SPELL_SCINTILLATING_SPHERE;
    if (GetHasSpell(SPELL_SEARING_LIGHT, oTarget) > 0) nBestSpell = SPELL_SEARING_LIGHT;
    if (GetHasSpell(SPELL_VAMPIRIC_TOUCH, oTarget) > 0) nBestSpell = SPELL_VAMPIRIC_TOUCH;
    if (GetHasSpell(SPELL_SLOW, oTarget) > 0) nBestSpell = SPELL_SLOW;
    if (GetHasSpell(SPELL_HASTE, oTarget) > 0) nBestSpell = SPELL_HASTE;
    if (GetHasSpell(SPELL_DISPEL_MAGIC, oTarget) > 0) nBestSpell = SPELL_DISPEL_MAGIC;
    if (GetHasSpell(SPELL_DISPLACEMENT, oTarget) > 0) nBestSpell = SPELL_DISPLACEMENT;
    if (GetHasSpell(SPELL_FIREBALL, oTarget) > 0) nBestSpell = SPELL_FIREBALL;
    if (GetHasSpell(SPELL_CALL_LIGHTNING, oTarget) > 0) nBestSpell = SPELL_CALL_LIGHTNING;
    if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS, oTarget) > 0) nBestSpell = SPELL_CURE_SERIOUS_WOUNDS;
    if (GetHasSpell(SPELL_FLAME_ARROW, oTarget) > 0) nBestSpell = SPELL_FLAME_ARROW;
    return nBestSpell;
}

int GetBestL4Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_DISMISSAL, oTarget) > 0) nBestSpell = SPELL_DISMISSAL;
    if (GetHasSpell(SPELL_INFLICT_CRITICAL_WOUNDS, oTarget) > 0) nBestSpell = SPELL_INFLICT_CRITICAL_WOUNDS;
    if (GetHasSpell(SPELL_HOLD_MONSTER, oTarget) > 0) nBestSpell = SPELL_HOLD_MONSTER;
    if (GetHasSpell(SPELL_HOLY_SWORD, oTarget) > 0) nBestSpell = SPELL_HOLY_SWORD;
    if (GetHasSpell(SPELL_ENERVATION, oTarget) > 0) nBestSpell = SPELL_ENERVATION;
    if (GetHasSpell(SPELL_MASS_CAMOFLAGE, oTarget) > 0) nBestSpell = SPELL_MASS_CAMOFLAGE;
    if (GetHasSpell(SPELL_RESTORATION, oTarget) > 0) nBestSpell = SPELL_RESTORATION;
    if (GetHasSpell(SPELL_WALL_OF_FIRE, oTarget) > 0) nBestSpell = SPELL_WALL_OF_FIRE;
    if (GetHasSpell(SPELL_WAR_CRY, oTarget) > 0) nBestSpell = SPELL_WAR_CRY;
    if (GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT, oTarget) > 0) nBestSpell = SPELL_FREEDOM_OF_MOVEMENT;
    if (GetHasSpell(SPELL_DEATH_WARD, oTarget) > 0) nBestSpell = SPELL_DEATH_WARD;
    if (GetHasSpell(SPELL_DIVINE_POWER, oTarget) > 0) nBestSpell = SPELL_DIVINE_POWER;
    if (GetHasSpell(SPELL_PHANTASMAL_KILLER, oTarget) > 0) nBestSpell = SPELL_PHANTASMAL_KILLER;
    if (GetHasSpell(SPELL_POLYMORPH_SELF, oTarget) > 0) nBestSpell = SPELL_POLYMORPH_SELF;
    if (GetHasSpell(SPELL_LEGEND_LORE, oTarget) > 0) nBestSpell = SPELL_LEGEND_LORE;
    if (GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oTarget) > 0) nBestSpell = SPELL_MINOR_GLOBE_OF_INVULNERABILITY;
    if (GetHasSpell(SPELL_EVARDS_BLACK_TENTACLES, oTarget) > 0) nBestSpell = SPELL_EVARDS_BLACK_TENTACLES;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_IV, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_IV;
    if (GetHasSpell(SPELL_HAMMER_OF_THE_GODS, oTarget) > 0) nBestSpell = SPELL_HAMMER_OF_THE_GODS;
    if (GetHasSpell(SPELL_ICE_STORM, oTarget) > 0) nBestSpell = SPELL_ICE_STORM;
    if (GetHasSpell(SPELL_IMPROVED_INVISIBILITY, oTarget) > 0) nBestSpell = SPELL_IMPROVED_INVISIBILITY;
    if (GetHasSpell(SPELL_ELEMENTAL_SHIELD, oTarget) > 0) nBestSpell = SPELL_ELEMENTAL_SHIELD;
    if (GetHasSpell(SPELL_LESSER_SPELL_BREACH, oTarget) > 0) nBestSpell = SPELL_LESSER_SPELL_BREACH;
    if (GetHasSpell(SPELL_DOMINATE_PERSON, oTarget) > 0) nBestSpell = SPELL_DOMINATE_PERSON;
    if (GetHasSpell(SPELL_STONESKIN, oTarget) > 0) nBestSpell = SPELL_STONESKIN;
    if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS, oTarget) > 0) nBestSpell = SPELL_CURE_CRITICAL_WOUNDS;
    if (GetHasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM, oTarget) > 0) nBestSpell = SPELL_ISAACS_LESSER_MISSILE_STORM;
    return nBestSpell;
}

int GetBestL5Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_AWAKEN, oTarget) > 0) nBestSpell = SPELL_AWAKEN;
    if (GetHasSpell(SPELL_CLOUDKILL, oTarget) > 0) nBestSpell = SPELL_CLOUDKILL;
    if (GetHasSpell(SPELL_CIRCLE_OF_DOOM, oTarget) > 0) nBestSpell = SPELL_CIRCLE_OF_DOOM;
    if (GetHasSpell(SPELL_BATTLETIDE, oTarget) > 0) nBestSpell = SPELL_BATTLETIDE;
    if (GetHasSpell(SPELL_VINE_MINE, oTarget) > 0) nBestSpell = SPELL_VINE_MINE;
    if (GetHasSpell(SPELL_ETHEREAL_VISAGE, oTarget) > 0) nBestSpell = SPELL_ETHEREAL_VISAGE;
    if (GetHasSpell(SPELL_FEEBLEMIND, oTarget) > 0) nBestSpell = SPELL_FEEBLEMIND;
    if (GetHasSpell(SPELL_MESTILS_ACID_SHEATH, oTarget) > 0) nBestSpell = SPELL_MESTILS_ACID_SHEATH;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_V, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_V;
    if (GetHasSpell(SPELL_HEALING_CIRCLE, oTarget) > 0) nBestSpell = SPELL_HEALING_CIRCLE;
    if (GetHasSpell(SPELL_ENERGY_BUFFER, oTarget) > 0) nBestSpell = SPELL_ENERGY_BUFFER;
    if (GetHasSpell(SPELL_BALL_LIGHTNING, oTarget) > 0) nBestSpell = SPELL_BALL_LIGHTNING;
    if (GetHasSpell(SPELL_CONE_OF_COLD, oTarget) > 0) nBestSpell = SPELL_CONE_OF_COLD;
    if (GetHasSpell(SPELL_INFERNO, oTarget) > 0) nBestSpell = SPELL_INFERNO;
    if (GetHasSpell(SPELL_FIREBRAND, oTarget) > 0) nBestSpell = SPELL_FIREBRAND;
    if (GetHasSpell(SPELL_FLAME_STRIKE, oTarget) > 0) nBestSpell = SPELL_FLAME_STRIKE;
    if (GetHasSpell(SPELL_LESSER_MIND_BLANK, oTarget) > 0) nBestSpell = SPELL_LESSER_MIND_BLANK;
    if (GetHasSpell(SPELL_LESSER_PLANAR_BINDING, oTarget) > 0) nBestSpell = SPELL_LESSER_PLANAR_BINDING;
    if (GetHasSpell(SPELL_SLAY_LIVING, oTarget) > 0) nBestSpell = SPELL_SLAY_LIVING;
    if (GetHasSpell(SPELL_MIND_FOG, oTarget) > 0) nBestSpell = SPELL_MIND_FOG;
    if (GetHasSpell(SPELL_RAISE_DEAD, oTarget) > 0) nBestSpell = SPELL_RAISE_DEAD;
    if (GetHasSpell(SPELL_MONSTROUS_REGENERATION, oTarget) > 0) nBestSpell = SPELL_MONSTROUS_REGENERATION;
    if (GetHasSpell(SPELL_SPELL_RESISTANCE, oTarget) > 0) nBestSpell = SPELL_SPELL_RESISTANCE;
    if (GetHasSpell(SPELL_LESSER_SPELL_MANTLE, oTarget) > 0) nBestSpell = SPELL_LESSER_SPELL_MANTLE;
    if (GetHasSpell(SPELL_GREATER_DISPELLING, oTarget) > 0) nBestSpell = SPELL_GREATER_DISPELLING;
    if (GetHasSpell(SPELL_BIGBYS_INTERPOSING_HAND, oTarget) > 0) nBestSpell = SPELL_BIGBYS_INTERPOSING_HAND;
    if (GetHasSpell(SPELL_TRUE_SEEING, oTarget) > 0) nBestSpell = SPELL_TRUE_SEEING;
    return nBestSpell;
}

int GetBestL6Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_ACID_FOG, oTarget) > 0) nBestSpell = SPELL_ACID_FOG;
    if (GetHasSpell(SPELL_BANISHMENT, oTarget) > 0) nBestSpell = SPELL_BANISHMENT;
    if (GetHasSpell(SPELL_BLADE_BARRIER, oTarget) > 0) nBestSpell = SPELL_BLADE_BARRIER;
    if (GetHasSpell(SPELL_DIRGE, oTarget) > 0) nBestSpell = SPELL_DIRGE;
    if (GetHasSpell(SPELL_PLANAR_ALLY, oTarget) > 0) nBestSpell = SPELL_PLANAR_ALLY;
    if (GetHasSpell(SPELL_PLANAR_BINDING, oTarget) > 0) nBestSpell = SPELL_PLANAR_BINDING;
    if (GetHasSpell(SPELL_CONTROL_UNDEAD, oTarget) > 0) nBestSpell = SPELL_CONTROL_UNDEAD;
    if (GetHasSpell(SPELL_CREATE_UNDEAD, oTarget) > 0) nBestSpell = SPELL_CREATE_UNDEAD;
    if (GetHasSpell(SPELL_TENSERS_TRANSFORMATION, oTarget) > 0) nBestSpell = SPELL_TENSERS_TRANSFORMATION;
    if (GetHasSpell(SPELL_STONE_TO_FLESH, oTarget) > 0) nBestSpell = SPELL_STONE_TO_FLESH;
    if (GetHasSpell(SPELL_FLESH_TO_STONE, oTarget) > 0) nBestSpell = SPELL_FLESH_TO_STONE;
    if (GetHasSpell(SPELL_STONEHOLD, oTarget) > 0) nBestSpell = SPELL_STONEHOLD;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_VI, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_VI;
    if (GetHasSpell(SPELL_REGENERATE, oTarget) > 0) nBestSpell = SPELL_REGENERATE;
    if (GetHasSpell(SPELL_CRUMBLE, oTarget) > 0) nBestSpell = SPELL_CRUMBLE;
    if (GetHasSpell(SPELL_UNDEATH_TO_DEATH, oTarget) > 0) nBestSpell = SPELL_UNDEATH_TO_DEATH;
    if (GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY, oTarget) > 0) nBestSpell = SPELL_GLOBE_OF_INVULNERABILITY;
    if (GetHasSpell(SPELL_CIRCLE_OF_DEATH, oTarget) > 0) nBestSpell = SPELL_CIRCLE_OF_DEATH;
    if (GetHasSpell(SPELL_GREATER_SPELL_BREACH, oTarget) > 0) nBestSpell = SPELL_GREATER_SPELL_BREACH;
    if (GetHasSpell(SPELL_GREATER_STONESKIN, oTarget) > 0) nBestSpell = SPELL_GREATER_STONESKIN;
    if (GetHasSpell(SPELL_DROWN, oTarget) > 0) nBestSpell = SPELL_DROWN;
    if (GetHasSpell(SPELL_MASS_HASTE, oTarget) > 0) nBestSpell = SPELL_MASS_HASTE;
    if (GetHasSpell(SPELL_CHAIN_LIGHTNING, oTarget) > 0) nBestSpell = SPELL_CHAIN_LIGHTNING;
    if (GetHasSpell(SPELL_BIGBYS_FORCEFUL_HAND, oTarget) > 0) nBestSpell = SPELL_BIGBYS_FORCEFUL_HAND;
    if (GetHasSpell(SPELL_HEAL, oTarget) > 0) nBestSpell = SPELL_HEAL;
    if (GetHasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM, oTarget) > 0) nBestSpell = SPELL_ISAACS_GREATER_MISSILE_STORM;
    if (GetHasSpell(SPELL_HARM, oTarget) > 0) nBestSpell = SPELL_HARM;
    return nBestSpell;
}

int GetBestL7Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_AURA_OF_VITALITY, oTarget) > 0) nBestSpell = SPELL_AURA_OF_VITALITY;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_VII, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_VII;
    if (GetHasSpell(SPELL_GREATER_RESTORATION, oTarget) > 0) nBestSpell = SPELL_GREATER_RESTORATION;
    if (GetHasSpell(SPELL_RESURRECTION, oTarget) > 0) nBestSpell = SPELL_RESURRECTION;
    if (GetHasSpell(SPELL_MORDENKAINENS_SWORD, oTarget) > 0) nBestSpell = SPELL_MORDENKAINENS_SWORD;
    if (GetHasSpell(SPELL_POWER_WORD_STUN, oTarget) > 0) nBestSpell = SPELL_POWER_WORD_STUN;
    if (GetHasSpell(SPELL_GREAT_THUNDERCLAP, oTarget) > 0) nBestSpell = SPELL_GREAT_THUNDERCLAP;
    if (GetHasSpell(SPELL_DELAYED_BLAST_FIREBALL, oTarget) > 0) nBestSpell = SPELL_DELAYED_BLAST_FIREBALL;
    if (GetHasSpell(SPELL_PRISMATIC_SPRAY, oTarget) > 0) nBestSpell = SPELL_PRISMATIC_SPRAY;
    if (GetHasSpell(SPELL_DESTRUCTION, oTarget) > 0) nBestSpell = SPELL_DESTRUCTION;
    if (GetHasSpell(SPELL_CREEPING_DOOM, oTarget) > 0) nBestSpell = SPELL_CREEPING_DOOM;
    if (GetHasSpell(SPELL_SHADOW_SHIELD, oTarget) > 0) nBestSpell = SPELL_SHADOW_SHIELD;
    if (GetHasSpell(SPELL_WORD_OF_FAITH, oTarget) > 0) nBestSpell = SPELL_WORD_OF_FAITH;
    if (GetHasSpell(SPELL_PROTECTION_FROM_SPELLS, oTarget) > 0) nBestSpell = SPELL_PROTECTION_FROM_SPELLS;
    if (GetHasSpell(SPELL_FINGER_OF_DEATH, oTarget) > 0) nBestSpell = SPELL_FINGER_OF_DEATH;
    if (GetHasSpell(SPELL_FIRE_STORM, oTarget) > 0) nBestSpell = SPELL_FIRE_STORM;
    if (GetHasSpell(SPELL_BIGBYS_GRASPING_HAND, oTarget) > 0) nBestSpell = SPELL_BIGBYS_GRASPING_HAND;
    if (GetHasSpell(SPELL_SPELL_MANTLE, oTarget) > 0) nBestSpell = SPELL_SPELL_MANTLE;
    return nBestSpell;
}

int GetBestL8Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_BLACKSTAFF, oTarget) > 0) nBestSpell = SPELL_BLACKSTAFF;
    if (GetHasSpell(SPELL_CREATE_GREATER_UNDEAD, oTarget) > 0) nBestSpell = SPELL_CREATE_GREATER_UNDEAD;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_VIII, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_VIII;
    if (GetHasSpell(SPELL_GREATER_PLANAR_BINDING, oTarget) > 0) nBestSpell = SPELL_GREATER_PLANAR_BINDING;
    if (GetHasSpell(SPELL_BOMBARDMENT, oTarget) > 0) nBestSpell = SPELL_BOMBARDMENT;
    if (GetHasSpell(SPELL_MASS_BLINDNESS_AND_DEAFNESS, oTarget) > 0) nBestSpell = SPELL_MASS_BLINDNESS_AND_DEAFNESS;
    if (GetHasSpell(SPELL_MASS_CHARM, oTarget) > 0) nBestSpell = SPELL_MASS_CHARM;
    if (GetHasSpell(SPELL_SUNBEAM, oTarget) > 0) nBestSpell = SPELL_SUNBEAM;
    if (GetHasSpell(SPELL_SUNBURST, oTarget) > 0) nBestSpell = SPELL_SUNBURST;
    if (GetHasSpell(SPELL_PREMONITION, oTarget) > 0) nBestSpell = SPELL_PREMONITION;
    if (GetHasSpell(SPELL_MIND_BLANK, oTarget) > 0) nBestSpell = SPELL_MIND_BLANK;
    if (GetHasSpell(SPELL_MASS_HEAL, oTarget) > 0) nBestSpell = SPELL_MASS_HEAL;
    if (GetHasSpell(SPELL_INCENDIARY_CLOUD, oTarget) > 0) nBestSpell = SPELL_INCENDIARY_CLOUD;
    if (GetHasSpell(SPELL_NATURES_BALANCE, oTarget) > 0) nBestSpell = SPELL_NATURES_BALANCE;
    if (GetHasSpell(SPELL_EARTHQUAKE, oTarget) > 0) nBestSpell = SPELL_EARTHQUAKE;
    if (GetHasSpell(SPELL_HORRID_WILTING, oTarget) > 0) nBestSpell = SPELL_HORRID_WILTING;
    if (GetHasSpell(SPELL_BIGBYS_CLENCHED_FIST, oTarget) > 0) nBestSpell = SPELL_BIGBYS_CLENCHED_FIST;
    return nBestSpell;
}

int GetBestL9Spell(object oTarget, int nSpell)
{
    int nBestSpell = nSpell;
    if (GetHasSpell(SPELL_UNDEATHS_ETERNAL_FOE, oTarget) > 0) nBestSpell = SPELL_UNDEATHS_ETERNAL_FOE;
    if (GetHasSpell(SPELL_ENERGY_DRAIN, oTarget) > 0) nBestSpell = SPELL_ENERGY_DRAIN;
    if (GetHasSpell(SPELL_GATE, oTarget) > 0) nBestSpell = SPELL_GATE;
    if (GetHasSpell(SPELL_SUMMON_CREATURE_IX, oTarget) > 0) nBestSpell = SPELL_SUMMON_CREATURE_IX;
    if (GetHasSpell(SPELL_ELEMENTAL_SWARM, oTarget) > 0) nBestSpell = SPELL_ELEMENTAL_SWARM;
    if (GetHasSpell(SPELL_DOMINATE_MONSTER, oTarget) > 0) nBestSpell = SPELL_DOMINATE_MONSTER;
    if (GetHasSpell(SPELL_SHAPECHANGE, oTarget) > 0) nBestSpell = SPELL_SHAPECHANGE;
    if (GetHasSpell(SPELL_STORM_OF_VENGEANCE, oTarget) > 0) nBestSpell = SPELL_STORM_OF_VENGEANCE;
    if (GetHasSpell(SPELL_POWER_WORD_KILL, oTarget) > 0) nBestSpell = SPELL_POWER_WORD_KILL;
    if (GetHasSpell(SPELL_IMPLOSION, oTarget) > 0) nBestSpell = SPELL_IMPLOSION;
    if (GetHasSpell(SPELL_METEOR_SWARM, oTarget) > 0) nBestSpell = SPELL_METEOR_SWARM;
    if (GetHasSpell(SPELL_WEIRD, oTarget) > 0) nBestSpell = SPELL_WEIRD;
    if (GetHasSpell(SPELL_WAIL_OF_THE_BANSHEE, oTarget) > 0) nBestSpell = SPELL_WAIL_OF_THE_BANSHEE;
    if (GetHasSpell(SPELL_BIGBYS_CRUSHING_HAND, oTarget) > 0) nBestSpell = SPELL_BIGBYS_CRUSHING_HAND;
    if (GetHasSpell(SPELL_GREATER_SPELL_MANTLE, oTarget) > 0) nBestSpell = SPELL_GREATER_SPELL_MANTLE;
    if (GetHasSpell(SPELL_MORDENKAINENS_DISJUNCTION, oTarget) > 0) nBestSpell = SPELL_MORDENKAINENS_DISJUNCTION;
    if (GetHasSpell(SPELL_BLACK_BLADE_OF_DISASTER, oTarget) > 0) nBestSpell = SPELL_BLACK_BLADE_OF_DISASTER;
    if (GetHasSpell(SPELL_TIME_STOP, oTarget) > 0) nBestSpell = SPELL_TIME_STOP;
    return nBestSpell;
}

int GetBestAvailableSpell(object oTarget)
{
    int nBestSpell = 99999;
    nBestSpell = GetBestL0Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL1Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL2Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL3Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL4Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL5Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL6Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL7Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL8Spell(oTarget, nBestSpell);
    nBestSpell = GetBestL9Spell(oTarget, nBestSpell);
    return nBestSpell;
}