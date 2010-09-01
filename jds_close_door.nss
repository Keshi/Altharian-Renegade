void main()

//Created by Turan.  (Auto Close Doors)
//Place in the 'on open' event of whichever door you want to close.
{
   DelayCommand(15.0, ActionCloseDoor(OBJECT_SELF));
}
