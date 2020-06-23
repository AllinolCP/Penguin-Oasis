class com.clubpenguin.achievements.verbs.AchievementVerbHasID extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _identifier, addSubjectFound, _debug;
    function AchievementVerbHasID(descriptor, debug, identifier)
    {
        super(descriptor, debug);
        _identifier = identifier;
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate - identifier: " + _identifier);
        var _loc8 = 0;
        var _loc9 = subjects.length;
        var _loc6 = objects.length;
        for (var _loc4 = 0; _loc4 < _loc9; ++_loc4)
        {
            var _loc3 = false;
            for (var _loc2 = 0; _loc2 < _loc6 && !_loc3; ++_loc2)
            {
                if (subjects[_loc4][_identifier] == objects[_loc2])
                {
                    _loc3 = true;
                } // end if
            } // end of for
            if (_loc3)
            {
                ++_loc8;
                this.addSubjectFound(subjects[_loc4]);
            } // end if
        } // end of for
        return (_loc8);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
