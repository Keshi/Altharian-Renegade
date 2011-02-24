//::///////////////////////////////////////////////
//:: Chat Command include
//:: prc_inc_chat
//::///////////////////////////////////////////////

struct _prc_inc_WordInfo{
    int nWordStart;
    int nWordLength;
};

struct _prc_inc_WordInfo GetStringWordInfo(string sString, int nWordToGet, string sDivider = " ")
{
    int nStrLength = GetStringLength(sString);
    int nDivLength = GetStringLength(sDivider);

    struct _prc_inc_WordInfo info;
    info.nWordStart = nStrLength;
    info.nWordLength = 0;

    // Safety checks
    if (sString == "")
        return info;
    if (sDivider == "")
        sDivider = " ";

    nWordToGet--;

    // Start with the first word.
    int nCurrentWord = 0;
    int nCurrentStart = 0;
    int nCurrentEnd = FindSubString(sString, sDivider);
    // Advance to the specified element.
    while (nCurrentWord < nWordToGet && nCurrentEnd > -1)
    {
        nCurrentWord++;
        nCurrentStart = nCurrentEnd + nDivLength;
        nCurrentEnd = FindSubString(sString, sDivider, nCurrentStart);
    }
    // Adjust the end point if this is the last element.
    if (nCurrentEnd == -1) nCurrentEnd = nStrLength;

    if (nCurrentWord >= nWordToGet)
    {
        info.nWordStart = nCurrentStart;
        info.nWordLength = nCurrentEnd-nCurrentStart;
    }

    return info;
}

string GetStringWord(string sString, int nWordToGet, string sDivider = " ")
{
    struct _prc_inc_WordInfo info = GetStringWordInfo(sString, nWordToGet, sDivider);
    return GetSubString(sString, info.nWordStart, info.nWordLength);
}

string GetStringWordToEnd(string sString, int nWordToGet, string sDivider = " ")
{
    struct _prc_inc_WordInfo info = GetStringWordInfo(sString, nWordToGet, sDivider);
    return GetSubString(sString, info.nWordStart, GetStringLength(sString)-info.nWordStart);
}

//Returns TRUE if sPrefix matches sWord or some part of the beginning of sWord
int GetStringMatchesAbbreviation(string sString, string sAbbreviationPattern)
{
    int nShortestAbbreviation = FindSubString(sAbbreviationPattern, "-");
    if(nShortestAbbreviation > 0)
        sAbbreviationPattern = GetStringLeft(sAbbreviationPattern, nShortestAbbreviation) + GetStringRight(sAbbreviationPattern, GetStringLength(sAbbreviationPattern)-(nShortestAbbreviation+1));
    else if (nShortestAbbreviation == 0)
    {
        sAbbreviationPattern = GetStringRight(sAbbreviationPattern, GetStringLength(sAbbreviationPattern)-1);
        nShortestAbbreviation = GetStringLength(sAbbreviationPattern);
    }
    else
        nShortestAbbreviation = GetStringLength(sAbbreviationPattern);

    if(GetStringLength(sString) >= nShortestAbbreviation)
        return GetStringLeft(sAbbreviationPattern, GetStringLength(sString)) == sString;
    else
        return FALSE;
}
