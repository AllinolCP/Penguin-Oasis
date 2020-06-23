class com.clubpenguin.achievements.verbs.AchievementVerbIn extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _shell, _isList, addSubjectFound, _debug;
    function AchievementVerbIn(descriptor, debug)
    {
        super(descriptor, debug);
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate");
        var _loc8 = 0;
        var _loc9 = subjects.length;
        var _loc6 = objects.length;
        var _loc7 = _shell.getCurrentRoomId();
        for (var _loc5 = 0; _loc5 < _loc9; ++_loc5)
        {
            this.debugTrace("activate - peng:" + _loc5 + " is in room " + _loc7);
            var _loc3 = false;
            if (_isList)
            {
                if (_loc6 > 0)
                {
                    _loc3 = true;
                    for (var _loc2 = 0; _loc2 < _loc6; ++_loc2)
                    {
                        if (!_shell.visitedThisRoom(objects[_loc2]))
                        {
                            _loc3 = false;
                            break;
                        } // end if
                    } // end of for
                } // end if
            }
            else
            {
                for (var _loc2 = 0; _loc2 < _loc6 && !_loc3; ++_loc2)
                {
                    this.debugTrace("activate - objIdx:" + _loc2 + " has Id:" + objects[_loc2]);
                    if (_loc7 == objects[_loc2])
                    {
                        this.debugTrace("activate - peng:" + _loc5 + " is in room " + objects[_loc2]);
                        _loc3 = true;
                    } // end if
                } // end of for
            } // end else if
            if (_loc3)
            {
                ++_loc8;
                this.addSubjectFound(subjects[_loc5]);
                continue;
            } // end if
            this.debugTrace("activate - peng:" + _loc5 + " is not in room " + objects[_loc2]);
        } // end of for
        this.debugTrace("activate (currentRoomId:" + _loc7 + ") hits: " + _loc8);
        return (_loc8);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
