/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this script OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oCaster;
oCaster = GetObjectByTag("sc_PortraitofCuteFluffyKittens");

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREAT_THUNDERCLAP, oTarget, METAMAGIC_ANY, TRUE, 50, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = GetObjectByTag("sc_PortraitofCuteFluffyKittens");

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS, oTarget, METAMAGIC_ANY, TRUE, 50, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
