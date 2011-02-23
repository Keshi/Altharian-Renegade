/*
XP Bank by uhmm TheGrimReefer, yay..
This Bank is a way for people to transfer Experience points from an old character
to a new one, so they dont have to deal with those tedious first levels.

Obviously there would be a penalty, this is represented by the Int "Penalty", go figure.

*/////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/*//////////////////////*/    int Penalty = 25;    /////////////////////////////
//The magic number, this is a percent of the XP taken that is actually stored \\
//in the bank. Ex, if they deposit 100 XP, only 25 XP is stored for withdraw. \\
////////////////////////////////////////////////////////////////////////////////
int fraction = 100/Penalty; // just a divider, to send the % to the other scripts,ignore.

// OK now, this I just threw in at the last second, if enabled, it will stop
// people from withdrawing after they reach a certain amount of XP.

int WithdrawCap = FALSE; // set as 'TRUE' if you want to stop them from withdrawing after a certain lvl
int XPcap = 190000; //this is the number to have them stop at, 190k = lvl 20
string slvlcap = "I am sorry, but you currently have too many experience points for me to help you.";
// and that's the happy message you tell them. ^^
/////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/*
//
//
//
*/
// These next lines just prevents ppl from dumping thier XP if thier below a designated lvl
// I believe there is a reason I did those, aside from making slackers hit lvl 10 or so,
// but you can probly jut set it to 1, and it'll turn this feature off
int lvl = 6; // meaning u have to be lvl 10 or higher to dump ALL your XP into bank.
string slvl = IntToString(lvl);
string sNO = "Sorry, but you need to be at least level "+slvl+" to deposit all your experience.";
