//::///////////////////////////////////////////////
//:: Truenaming include: Core functions
//:: true_inc_core
//::///////////////////////////////////////////////
/** @file
    Defines various functions and other stuff that
    other scripts in the truenaming functions require.

*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////


//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

/*
 * Returns TRUE if it is a Syllable (Bereft class ability).
 * @param nSpellId   Utterance to check
 *
 * @return           TRUE or FALSE
 */
int GetIsSyllable(int nSpellId);

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "true_utter_const"

//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

int GetIsSyllable(int nSpellId)
{
	if (SYLLABLE_DETACHMENT == nSpellId)             return TRUE;
	else if (SYLLABLE_AFFLICATION_SIGHT == nSpellId) return TRUE;
	else if (SYLLABLE_AFFLICATION_SOUND == nSpellId) return TRUE;
	else if (SYLLABLE_AFFLICATION_TOUCH == nSpellId) return TRUE;
	else if (SYLLABLE_EXILE == nSpellId)             return TRUE;
	else if (SYLLABLE_DISSOLUTION == nSpellId)       return TRUE;
	else if (SYLLABLE_ENERVATION == nSpellId)        return TRUE;

	return FALSE;
}