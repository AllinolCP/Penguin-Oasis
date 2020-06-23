class com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _debug, _subjectsFoundOn, _isList, __get__isList, __get__debug, _shell, __get__shell, __set__debug, __set__isList, __set__shell, __get__subjectsFoundOn;
    function AchievementVerb(descriptor, debug)
    {
        _debug = debug;
        _subjectsFoundOn = [];
    } // End of the function
    function set isList(flag)
    {
        _isList = flag;
        //return (this.isList());
        null;
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        throw new com.clubpenguin.achievements.AchievementException("AchievementVerb::activate - this function should be overridden!");
        return (-1);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
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
    function addSubjectFound(subject)
    {
        var _loc3 = _subjectsFoundOn.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (_subjectsFoundOn[_loc2] == subject)
            {
                return;
            } // end if
        } // end of for
        _subjectsFoundOn.push(subject);
    } // End of the function
    function clearSubjectsFoundOn()
    {
        _subjectsFoundOn = [];
    } // End of the function
    function get subjectsFoundOn()
    {
        return (_subjectsFoundOn);
    } // End of the function
} // End of Class
