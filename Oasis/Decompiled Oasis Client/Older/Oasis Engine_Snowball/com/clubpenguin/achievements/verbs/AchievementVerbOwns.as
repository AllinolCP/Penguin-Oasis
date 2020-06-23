class com.clubpenguin.achievements.verbs.AchievementVerbOwns extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _shell, addSubjectFound, _debug;
    function AchievementVerbOwns(descriptor, debug)
    {
        super(descriptor, debug);
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate");
        if (subjects.length > 1)
        {
            throw new com.clubpenguin.achievements.AchievementException("AchievementVerbOwns::activate cannot check ownership for penguins other than the user.");
        } // end if
        if (subjects[0].player_id != _shell.getMyPlayerId())
        {
            throw new com.clubpenguin.achievements.AchievementException("AchievementVerbOwns::activate cannot check ownership for penguins other than the user. Player ID of subject did not match.");
        } // end if
        var _loc3 = 0;
        var _loc4 = objects.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            if (_shell.isItemInMyInventory(objects[_loc2]))
            {
                ++_loc3;
                this.addSubjectFound(subjects[0]);
            } // end if
        } // end of for
        return (_loc3);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
