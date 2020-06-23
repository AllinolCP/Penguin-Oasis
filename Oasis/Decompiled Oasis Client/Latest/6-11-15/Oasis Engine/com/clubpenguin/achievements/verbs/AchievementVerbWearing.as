class com.clubpenguin.achievements.verbs.AchievementVerbWearing extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _onlyClause, addSubjectFound, _debug;
    function AchievementVerbWearing(descriptor, debug)
    {
        super(descriptor, debug);
        if (descriptor[0] == com.clubpenguin.achievements.verbs.AchievementVerbWearing.ONLY_TAG)
        {
            _onlyClause = true;
            descriptor.shift();
        }
        else
        {
            _onlyClause = false;
        } // end else if
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate");
        var _loc14 = ["feet", "hand", "body", "neck", "face", "head", "colour_id"];
        var _loc16 = 0;
        var _loc17 = subjects.length;
        var _loc11 = objects.length;
        var _loc15 = _loc14.length;
        for (var _loc4 = 0; _loc4 < _loc17; ++_loc4)
        {
            var _loc10 = 0;
            var _loc9 = 0;
            var _loc5 = false;
            for (var _loc6 = 0; _loc6 < _loc15; ++_loc6)
            {
                if (!_onlyClause && objectOperation != com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND && _loc5)
                {
                    break;
                } // end if
                var _loc3 = _loc14[_loc6];
                if (_loc3 != "colour_id" && subjects[_loc4][_loc3] != 0)
                {
                    ++_loc10;
                } // end if
                for (var _loc2 = 0; _loc2 < _loc11; ++_loc2)
                {
                    if (subjects[_loc4][_loc3] == objects[_loc2])
                    {
                        _loc5 = true;
                        ++_loc9;
                        this.debugTrace("activate - peng:" + _loc4 + " is wearing " + objects[_loc2] + " on their " + _loc3);
                        break;
                    } // end if
                } // end of for
            } // end of for
            var _loc13 = _loc9 == _loc11;
            if (_loc5 && (!_onlyClause || _loc10 == 1))
            {
                if (objectOperation != com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND || _loc13)
                {
                    ++_loc16;
                    this.addSubjectFound(subjects[_loc4]);
                } // end if
            } // end if
        } // end of for
        this.debugTrace("activate hits: " + _loc16);
        return (_loc16);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
    static var ONLY_TAG = "only";
} // End of Class
