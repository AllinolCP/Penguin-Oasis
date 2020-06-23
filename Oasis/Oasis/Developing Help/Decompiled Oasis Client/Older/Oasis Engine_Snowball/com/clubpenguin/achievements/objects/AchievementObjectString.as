class com.clubpenguin.achievements.objects.AchievementObjectString extends com.clubpenguin.achievements.objects.AchievementObject
{
    var __set__shell, _shell, _objects, _debug;
    function AchievementObjectString(descriptor, shell)
    {
        super(descriptor);
        this.__set__shell(shell);
        this.addElement(descriptor);
    } // End of the function
    function addElement(descriptor)
    {
        var _loc2 = "";
        var _loc7 = descriptor[0].indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG);
        if (_loc7 != -1)
        {
            var _loc4 = String(descriptor.shift());
            var _loc5 = _loc4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_END_TAG);
            var _loc8;
            _loc7 = _loc4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG);
            while (_loc5 == -1)
            {
                _loc4 = _loc4 + " " + String(descriptor.shift());
                _loc5 = _loc4.indexOf(com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_END_TAG);
            } // end while
            _loc8 = _loc4.substring(_loc7 + com.clubpenguin.achievements.objects.AchievementObject.LOCALIZE_START_TAG.length, _loc5);
            if (_loc8 != undefined)
            {
                _loc2 = _shell.getLocalizedString(_loc8);
            } // end if
        }
        else
        {
            var _loc3;
            do
            {
                if (_loc2.length > 0)
                {
                    _loc2 = _loc2 + " ";
                } // end if
                _loc3 = String(descriptor.shift());
                if (_loc3 == "undefined")
                {
                    throw new com.clubpenguin.achievements.AchievementException("Unterminated string in AchievementObjectFactory:createObject!");
                } // end if
                _loc2 = _loc2 + _loc3;
            } while (_loc3.charAt(_loc3.length - 1) != "\"")
            _loc2 = _loc2.substr(1);
            _loc2 = _loc2.substr(0, _loc2.length - 1);
            _loc2 = _loc2.toLowerCase();
        } // end else if
        _objects.push(_loc2);
        this.debugTrace("addElement - \'" + _loc2 + "\'");
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
