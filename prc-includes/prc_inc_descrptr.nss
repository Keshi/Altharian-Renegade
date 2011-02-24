//::///////////////////////////////////////////////
//:: Magic descriptors and subschools include
//:: prc_inc_descrptr
//::///////////////////////////////////////////////
/** @file prc_inc_descrptr
    A set of constants and functions for managing
    spell's / power's / other stuffs's descriptors
    and sub{school|discipline|whatever}s.

    The functions SetDescriptor() and SetSubschool()
    should be called at the beginning of the
    spellscript, before spellhook or equivalent.

    The values are stored on the module object and
    are automatically cleaned up after script
    execution terminates (ie, DelayCommand(0.0f)).
    This is a potential gotcha, as the descriptor
    and subschool data will no longer be available
    during the spell's delayed operations. An
    ugly workaround would be to set the descriptor
    values again in such cases.
    If you come up with an elegant solution, please
    try to generalise it and change this as needed.


    @author Ornedan
    @date   Created - 2006.06.30
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

// The descriptor and subschool constants are bit flags for easy combination and lookup
const int DESCRIPTOR_ACID              =      1; // = 0x00001
const int DESCRIPTOR_AIR               =      2; // = 0x00002
const int DESCRIPTOR_CHAOTIC           =      4; // = 0x00004
const int DESCRIPTOR_COLD              =      8; // = 0x00008
const int DESCRIPTOR_DARKNESS          =     16; // = 0x00010
const int DESCRIPTOR_DEATH             =     32; // = 0x00020
const int DESCRIPTOR_EARTH             =     64; // = 0x00040
const int DESCRIPTOR_ELECTRICITY       =    128; // = 0x00080
const int DESCRIPTOR_EVIL              =    256; // = 0x00100
const int DESCRIPTOR_FEAR              =    512; // = 0x00200
const int DESCRIPTOR_FIRE              =   1024; // = 0x00400
const int DESCRIPTOR_FORCE             =   2048; // = 0x00800
const int DESCRIPTOR_GOOD              =   4096; // = 0x01000
const int DESCRIPTOR_LANGUAGEDEPENDENT =   8192; // = 0x02000
const int DESCRIPTOR_LAWFUL            =  16384; // = 0x04000
const int DESCRIPTOR_LIGHT             =  32768; // = 0x08000
const int DESCRIPTOR_MINDAFFECTING     =  65536; // = 0x10000
const int DESCRIPTOR_SONIC             = 131072; // = 0x20000
const int DESCRIPTOR_WATER             = 262144; // = 0x40000

const int SUBSCHOOL_CALLING            =      1; // = 0x00001
const int SUBSCHOOL_CHARM              =      2; // = 0x00002
const int SUBSCHOOL_COMPULSION         =      4; // = 0x00004
const int SUBSCHOOL_CREATION           =      8; // = 0x00008
const int SUBSCHOOL_FIGMENT            =     16; // = 0x00010
const int SUBSCHOOL_GLAMER             =     32; // = 0x00020
const int SUBSCHOOL_HEALING            =     64; // = 0x00040
const int SUBSCHOOL_PATTERN            =    128; // = 0x00080
const int SUBSCHOOL_PHANTASM           =    256; // = 0x00100
const int SUBSCHOOL_POLYMORPH          =    512; // = 0x00200
const int SUBSCHOOL_SCRYING            =   1024; // = 0x00400
const int SUBSCHOOL_SHADOW             =   2048; // = 0x00800
const int SUBSCHOOL_SUMMONING          =   4096; // = 0x01000
const int SUBSCHOOL_TELEPORTATION      =   8192; // = 0x02000

const string PRC_DESCRIPTOR = "PRC_Descriptor";
const string PRC_SUBSCHOOL  = "PRC_Subschool";


//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

/**
 * Sets the descriptor of currently being cast spell / power / whatever
 * to be the given value. This should be called before spellhook / powerhook
 * / whateverhook.
 *
 * If the magic in question has multiple descriptors, they should be OR'd together.
 * For example, Phantasmal Killer would call the function thus:
 *  SetDescriptor(DESCRIPTOR_FEAR | DESCRIPTOR_MINDAFFECTING);
 *
 * This will override values set in prc_spells.2da
 *
 * @param nfDescriptorFlags The descriptors of a spell / power / X being currently used
 */
void SetDescriptor(int nfDescriptorFlags);

/**
 * Sets the subschool / subdiscipline / subwhatever of currently being cast
 * spell / power / whatever to be the given value. This should be called before
 * spellhook / powerhook / whateverhook.
 *
 * If the magic in question has multiple subschools, they should be OR'd together.
 * For example, Mislead would call the function thus:
 *  SetDescriptor(SUBSCHOOL_FIGMENT | SUBSCHOOL_GLAMER);
 *
 * This will override values set in prc_spells.2da
 *
 * @param nfSubschoolFlags The subschools of a spell / power / X being currently used
 */
void SetSubschool(int nfSubschoolFlags);

/**
 * Tests whether a magic being currently used has the given descriptor.
 *
 * NOTE: Multiple descriptors may be tested for at once. If so, the return value
 * will be true only if all the descriptors tested for are present. Doing so is
 * technically a misuse of this function.
 *
 *
 * @param nSpellID        row number of tested spell in spells.2da
 * @param nDescriptorFlag The descriptor to test for
 * @return                TRUE if the magic being used has the given descriptor(s), FALSE otherwise
 */
int GetHasDescriptor(int nSpellID, int nDescriptorFlag);

/**
 * Tests whether a magic being currently used is of the given subschool.
 *
 * NOTE: Multiple subschools may be tested for at once. If so, the return value
 * will be true only if all the subschools tested for are present. Doing so is
 * technically a misuse of this function.
 *
 *
 * @param nSpellID        row number of tested spell in spells.2da
 * @param nDescriptorFlag The subschool to test for
 * @return                TRUE if the magic being used is of the given subschool(s), FALSE otherwise
 */
int GetIsOfSubschool(int nSpellID, int nSubschoolFlag);

/**
 * Returns an integer value containing the bitflags of descriptors set in prc_splls.2da
 * for a given SpellID
 *
 * @param nSpellID  row number of tested spell in spells.2da
 * @return          The converted raw integer value from prc_spells.2da
 */
int GetDescriptorFlags(int nSpellID);

/**
 * Returns an integer value containing the bitflags of subschools set in prc_splls.2da
 * for a given SpellID
 *
 * @param nSpellID  row number of tested spell in spells.2da
 * @return          The converted raw integer value from prc_spells.2da
 */
int GetSubschoolFlags(int nSpellID);


//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "inc_2dacache"   // already has access via inc_utility
//#include "inc_utility"

//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

void SetDescriptor(int nfDescriptorFlags)
{
    // Store the value
    SetLocalInt(OBJECT_SELF, PRC_DESCRIPTOR, nfDescriptorFlags);

    // Queue cleanup. No duplicacy checks, this function is not particularly likely to be called more than once anyway
    DelayCommand(0.0f, DeleteLocalInt(OBJECT_SELF, PRC_DESCRIPTOR));
}

void SetSubschool(int nfSubschoolFlags)
{
    // Store the value
    SetLocalInt(OBJECT_SELF, PRC_SUBSCHOOL, nfSubschoolFlags);

    // Queue cleanup. No duplicacy checks, this function is not particularly likely to be called more than once anyway
    DelayCommand(0.0f, DeleteLocalInt(OBJECT_SELF, PRC_SUBSCHOOL));
}

int GetHasDescriptor(int nSpellID, int nDescriptorFlag)
{
    //check for descriptor override
    int nDescriptor = GetLocalInt(OBJECT_SELF, PRC_DESCRIPTOR);
    if(!nDescriptor)
        nDescriptor = GetDescriptorFlags(nSpellID);
    return (nDescriptor & nDescriptorFlag);
}

int GetIsOfSubschool(int nSpellID, int nSubschoolFlag)
{
    //check for subschool override
    int nSubschool = GetLocalInt(OBJECT_SELF, PRC_SUBSCHOOL);
    if(!nSubschool)
        nSubschool = GetSubschoolFlags(nSpellID);
    return (nSubschool & nSubschoolFlag);
}

int GetDescriptorFlags(int nSpellID)
{
    return HexToInt(Get2DACache("prc_spells", "Descriptor", nSpellID));
}

int GetSubschoolFlags(int nSpellID)
{
    return HexToInt(Get2DACache("prc_spells", "Subschool", nSpellID));
}

// Test main
//void main(){}
