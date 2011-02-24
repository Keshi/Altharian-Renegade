// --------------------------- GLOBALS -----------------------------------
// needed to prevent DB hijacking
// this char is forbidden in PC names
// PCs with this delimiter in their name won't be able
// to manipulate player vaults (ID_FLAG = 2)
const string SECURE_DELIMITER = "#";

// everything not in here gets considered an illegal character
// - mixed up for additional security
const string HASH_INDEX = "#i!j$k%l{•ø&MØ/πn(o)p= qèÍ?rü^åX∆sú`TÊuÒ'Ûv”]AwB—≥xCy£DzE1F2-G3t;4I}5Y:J6_K7+Z[Lm9N\ l0kOjPhQ,gRfSeHdU8cVbWa.";

const int HASH_PRIME = 3021377;

// simple hash
// returns -1 if string contains illegal character
int hash(string sData)
{
  int nLen = GetStringLength(sData);
  int i, nHash, nChar;
  for(i=0;i<nLen;i++)
  {
     nChar = FindSubString(HASH_INDEX, GetSubString(sData,i,1));
     if(nChar == -1) return -1;
     nHash = ((nHash<<5) ^ (nHash>>27)) ^ nChar;
  }
  return nHash % HASH_PRIME;
}

// return database ID from oTarget
int GetOwnerID(object oTarget)
{
  string sID;
  // reject player names containing secure delimiter
  if(FindSubString(GetPCPlayerName(oTarget),SECURE_DELIMITER) != -1 || FindSubString(GetName(oTarget),SECURE_DELIMITER) != -1)
    return -1;
  sID = "P" + GetPCPlayerName(oTarget) + SECURE_DELIMITER + GetName(oTarget);
  return hash(sID);
}
