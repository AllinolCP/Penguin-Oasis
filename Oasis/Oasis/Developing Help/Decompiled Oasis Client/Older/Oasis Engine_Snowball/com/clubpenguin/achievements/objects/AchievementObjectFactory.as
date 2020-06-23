class com.clubpenguin.achievements.objects.AchievementObjectFactory
{
    var _debug, _shell, __get__debug, __get__shell, __set__debug, __set__shell;
    function AchievementObjectFactory(debug)
    {
        _debug = debug;
    } // End of the function
    function createObject(descriptor)
    {
        for (var _loc2 = 0; _loc2 < descriptor.length; ++_loc2)
        {
            descriptor[_loc2] = descriptor[_loc2].split(com.clubpenguin.achievements.objects.AchievementObjectFactory.XML_QUOTATION).join("\"");
        } // end of for
        this.debugTrace("createObject - " + descriptor.join(" "));
        if (descriptor[0] == "myIgloo")
        {
            descriptor.shift();
            var _loc4 = 1000;
            return (new com.clubpenguin.achievements.objects.AchievementObjectId([Number(_shell.getMyPlayerId()) + _loc4]));
        } // end if
        if (descriptor[0].charAt(0) == "\"" || descriptor[0].indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG) != -1)
        {
            return (new com.clubpenguin.achievements.objects.AchievementObjectString(descriptor, _shell));
        } // end if
        return (new com.clubpenguin.achievements.objects.AchievementObjectId([String(descriptor.shift())]));
    } // End of the function
    function set debug(state)
    {
        _debug = state;
        //return (this.debug());
        null;
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
    function set shell(s)
    {
        _shell = s;
        //return (this.shell());
        null;
    } // End of the function
    static var XML_QUOTATION = "&quot;";
} // End of Class
