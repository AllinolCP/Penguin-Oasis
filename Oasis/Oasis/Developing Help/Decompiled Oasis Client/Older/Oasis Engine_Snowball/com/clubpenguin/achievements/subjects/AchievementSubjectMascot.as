class com.clubpenguin.achievements.subjects.AchievementSubjectMascot extends com.clubpenguin.achievements.subjects.AchievementSubject
{
    var _shell, _debug;
    function AchievementSubjectMascot(descriptor, debug)
    {
        super();
    } // End of the function
    function getCurrentSubjects(event)
    {
        var _loc2 = _shell.getPlayerList();
        var _loc3 = [];
        for (var _loc4 in _loc2)
        {
            if (_shell.isPlayerMascotById(_loc2[_loc4].player_id))
            {
                _loc3.push(_loc2[_loc4]);
            } // end if
        } // end of for...in
        return (_loc3);
    } // End of the function
    function shouldEventFire(event)
    {
        if (_shell.isPlayerMascotById(event.player_id))
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
