/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Goes OnPerceived of a creature
void main()
{

object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
object oCaster;
oCaster = GetObjectByTag("DroneFactoryOverseer");

object oTarget;
oTarget = GetObjectByTag("DroneFactoryOverseer");

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_SPELL_RESISTANCE, oTarget, METAMAGIC_ANY, TRUE, 50, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}

