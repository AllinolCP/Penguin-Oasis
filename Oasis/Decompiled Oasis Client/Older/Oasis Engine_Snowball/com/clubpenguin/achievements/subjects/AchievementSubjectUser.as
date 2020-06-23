class com.clubpenguin.achievements.subjects.AchievementSubjectUser extends com.clubpenguin.achievements.subjects.AchievementSubject
{
    var _shell, _debug;
    function AchievementSubjectUser(descriptor, debug)
    {
        super();
    } // End of the function
    function getCurrentSubjects(event)
    {
        return ([_shell.getMyPlayerObject()]);
    } // End of the function
    function getEnterRoomEvent()
    {
        return (_shell.JOIN_ROOM);
    } // End of the function
    function shouldEventFire(event)
    {
        this.debugTrace("shouldEventFire - is " + event.player_id + " equal to " + _shell.getMyPlayerId());
        if (event == null || _shell.isMyPlayer(event.player_id))
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
