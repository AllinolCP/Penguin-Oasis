class com.clubpenguin.achievements.verbs.AchievementVerbContainsText extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var addSubjectFound, _debug;
    function AchievementVerbContainsText(descriptor, debug)
    {
        super(descriptor, debug);
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate");
        var _loc8 = 0;
        for (var _loc6 = 0; _loc6 < subjects.length; ++_loc6)
        {
            var _loc4 = String(subjects[_loc6].message);
            if (_loc4.length < 1)
            {
                continue;
            } // end if
            _loc4 = _loc4.toLowerCase();
            this.debugTrace("activate - msg: " + _loc4);
            for (var _loc2 = 0; _loc2 < objects.length; ++_loc2)
            {
                this.debugTrace("activate - cmp: " + objects[_loc2]);
                var _loc3 = _loc4.split(objects[_loc2], 2);
                this.debugTrace("activate - splits: " + _loc3.length);
                if (_loc3.length > 1)
                {
                    ++_loc8;
                    this.addSubjectFound(subjects[_loc6]);
                } // end if
            } // end of for
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
