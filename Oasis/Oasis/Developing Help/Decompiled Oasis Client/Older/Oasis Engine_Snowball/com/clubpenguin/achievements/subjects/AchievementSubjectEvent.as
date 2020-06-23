class com.clubpenguin.achievements.subjects.AchievementSubjectEvent extends com.clubpenguin.achievements.subjects.AchievementSubject
{
    var _debug;
    function AchievementSubjectEvent(descriptor, debug)
    {
        super();
    } // End of the function
    function getCurrentSubjects(event)
    {
        return ([event]);
    } // End of the function
    function getEnterRoomEvent()
    {
        return (null);
    } // End of the function
    function shouldEventFire(event)
    {
        if (event.id != null)
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
