class com.clubpenguin.achievements.objects.AchievementObjectId extends com.clubpenguin.achievements.objects.AchievementObject
{
    var _objects, _idTag, _shell;
    function AchievementObjectId(descriptor)
    {
        super(descriptor);
        _objects.push(descriptor.shift());
        if (typeof(_objects[0]) == "string")
        {
            _idTag = _objects[0];
        }
        else
        {
            _idTag = "";
        } // end else if
    } // End of the function
    function getCurrentObjects()
    {
        if (_idTag == com.clubpenguin.achievements.objects.AchievementObjectId.MY_PENGUIN_COLOUR_TAG)
        {
            var _loc2 = _shell.getMyPlayerObject();
            if (_loc2.colour_id != undefined)
            {
                var _loc3 = Number(_loc2.colour_id);
                _objects[0] = _loc3;
            } // end if
        } // end if
        return (_objects);
    } // End of the function
    static var MY_PENGUIN_COLOUR_TAG = "myPenguinColourID";
} // End of Class
