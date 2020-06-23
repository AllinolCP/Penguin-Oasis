class com.clubpenguin.achievements.subjects.AchievementSubjectAny extends com.clubpenguin.achievements.subjects.AchievementSubject
{
    var _includeUserInCount, _quantity, isNumeric, _shell, _debug;
    function AchievementSubjectAny(descriptor, includeUserInCount, debug)
    {
        super();
        _includeUserInCount = includeUserInCount;
        var _loc3 = String(descriptor.shift());
        if (_loc3 == "penguin")
        {
            _quantity = 1;
        }
        else if (this.isNumeric(_loc3))
        {
            var _loc4 = String(descriptor.shift());
            if (_loc4 != "penguins")
            {
                throw new com.clubpenguin.achievements.AchievementException("AchievementSubjectAny was parsing type; expected token \"penguins\", instead got \"" + _loc4 + "\".");
            } // end if
            _quantity = Number(_loc3);
        }
        else
        {
            throw new com.clubpenguin.achievements.AchievementException("AchievementSubjectAny was parsing type; expected token \"" + _loc4 + "\" was not handled.");
        } // end else if
    } // End of the function
    function getCurrentSubjects(event)
    {
        return (_shell.getPlayerList());
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
