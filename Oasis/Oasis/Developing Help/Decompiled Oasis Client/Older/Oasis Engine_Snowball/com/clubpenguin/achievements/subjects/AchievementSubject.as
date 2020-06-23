class com.clubpenguin.achievements.subjects.AchievementSubject
{
    var _includeUserInCount, _debug, _quantity, _shell, __get__debug, __get__shell, __set__debug, __get__includeUserInCount, __get__quantity, __set__shell;
    function AchievementSubject(descriptor, includeUserInCount, debug)
    {
        _includeUserInCount = includeUserInCount;
        _debug = debug;
        _quantity = 1;
    } // End of the function
    function get includeUserInCount()
    {
        return (_includeUserInCount);
    } // End of the function
    function getCurrentSubjects(event)
    {
        throw new com.clubpenguin.achievements.AchievementException("AchievementSubject::getCurrentSubjects must be overridden.");
        return ([]);
    } // End of the function
    function shouldEventFire(event)
    {
        return (true);
    } // End of the function
    function getEnterRoomEvent()
    {
        return (_shell.ADD_PLAYER);
    } // End of the function
    function get quantity()
    {
        return (_quantity);
    } // End of the function
    function set debug(d)
    {
        _debug = d;
        //return (this.debug());
        null;
    } // End of the function
    function set shell(s)
    {
        _shell = s;
        //return (this.shell());
        null;
    } // End of the function
    function isNumeric(s)
    {
        return (!isNaN(s));
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
