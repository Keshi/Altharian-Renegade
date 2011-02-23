/////:://///////////////////////////////////////////////////////////////////////
/////:: Saint Quiz system
/////:: Written by Winterknight for Altharia
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  int nDice;
  object oPC = GetPCSpeaker();
  string sRand;
  int nCheck;
  int nLoop = GetLocalInt(oPC,"quizcount");
  if (nLoop <12)  // i.e. if the questioncount is not maxed out
    {
      int iGoOn=0;
        while (iGoOn==0)
         {
            nDice = d12();
            sRand = IntToString(nDice);
            nCheck = GetLocalInt(oPC,"saintquestion"+sRand);
            if (nCheck==0)
               {// i.e. the random question has not been asked
                  SetLocalInt(oPC,"saintquestion"+sRand,1);
                  // Set the corresponding value for the question
                  SetLocalInt(oPC,"saintask",nDice);
                  //get out of the loop
                  iGoOn=1 ;
                  nLoop++;
                  SetLocalInt(oPC,"quizcount",nLoop);
               }
          }

    }
  else if (nLoop >= 12)
    {
      nLoop++;
      SetLocalInt(oPC,"quizcount",nLoop);
    }



}
