/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.0

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this OnUsed
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("gate_1");

AssignCommand(oTarget, ActionOpenDoor(oTarget));

//Put this within OnUsed script which opens the gate
// Change MySuperGate to the name of the unique tag name for your gate being opened.
// Locks MySuperGate in 10.  Great for making floor traps.

if (!GetIsPC(oPC)) return;

oTarget = GetObjectByTag("gate_1");

DelayCommand(10.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));

SetLocked(oTarget, TRUE);

}

