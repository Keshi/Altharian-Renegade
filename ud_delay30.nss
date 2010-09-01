
 void RespawnObject(string sTag, int iType, location lLoc) {

// ResRef must be derivable from Tag
string sResRef = GetStringLowerCase(GetStringLeft(sTag, 16));

CreateObject(iType, sResRef, lLoc);

}



void main()
{
string sTag = GetTag(OBJECT_SELF);
int iType = GetObjectType(OBJECT_SELF);
location lLoc = GetLocalLocation (OBJECT_SELF,"myhouse");
float fDelay = 1800.0;  //15 minute delay







 int iUD= GetUserDefinedEventNumber();

    if (iUD == 1007)
    {
    // when creature spawned he found his loc   and stored it locally

              AssignCommand(GetArea(OBJECT_SELF), DelayCommand(fDelay, RespawnObject(sTag, iType, lLoc)));

    }
}
