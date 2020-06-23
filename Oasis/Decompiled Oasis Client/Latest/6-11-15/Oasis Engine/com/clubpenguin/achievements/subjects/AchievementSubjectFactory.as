class com.clubpenguin.achievements.subjects.AchievementSubjectFactory
{
    var _debug, __get__debug, __set__debug;
    function AchievementSubjectFactory(debug)
    {
        _debug = debug;
    } // End of the function
    function createSubject(descriptor, achievementCheck)
    {
        this.debugTrace("createSubject - " + descriptor.join(" "));
        var _loc3 = String(descriptor.shift());
        switch (_loc3)
        {
            case "user":
            {
                return (new com.clubpenguin.achievements.subjects.AchievementSubjectUser(descriptor, true));
            } 
            case "mascot":
            {
                return (new com.clubpenguin.achievements.subjects.AchievementSubjectMascot(descriptor));
            } 
            case "sameSubjects":
            {
                return (new com.clubpenguin.achievements.subjects.AchievementSubjectSame(descriptor, achievementCheck));
            } 
            case "any":
            {
                return (new com.clubpenguin.achievements.subjects.AchievementSubjectAny(descriptor, false));
            } 
            case "anyWithUser":
            {
                return (new com.clubpenguin.achievements.subjects.AchievementSubjectAny(descriptor, true));
            } 
            case "event":
            {
                return (new com.clubpenguin.achievements.subjects.AchievementSubjectEvent(descriptor));
            } 
        } // End of switch
        throw new com.clubpenguin.achievements.AchievementException("Subject type not recognised:\"" + _loc3 + "\"");
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
} // End of Class
