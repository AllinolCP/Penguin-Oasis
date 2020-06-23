class com.clubpenguin.achievements.verbs.AchievementVerbOccurs extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _debug, addSubjectFound;
    function AchievementVerbOccurs(descriptor, debug)
    {
        super(descriptor, debug);
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate");
        var _loc2 = 0;
        com.clubpenguin.achievements.AchievementTools.__set__debug(_debug);
        --objects[0];
        if (objects[0] <= 0)
        {
            _loc2 = 1;
            this.addSubjectFound(subjects[0]);
            this.debugTrace("activate - event has occured a sufficient number of times.");
        }
        else
        {
            this.debugTrace("activate - event must occur " + objects[0] + " more times.");
        } // end else if
        return (_loc2);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
