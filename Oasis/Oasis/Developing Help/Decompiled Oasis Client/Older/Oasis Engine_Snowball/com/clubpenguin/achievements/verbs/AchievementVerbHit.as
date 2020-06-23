class com.clubpenguin.achievements.verbs.AchievementVerbHit extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _debug, addSubjectFound;
    function AchievementVerbHit(descriptor, debug)
    {
        super(descriptor, debug);
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate");
        var _loc8 = 0;
        com.clubpenguin.achievements.AchievementTools.__set__debug(_debug);
        var _loc5 = com.clubpenguin.achievements.AchievementTools.getClipsFromIDs(subjects);
        var _loc6 = com.clubpenguin.achievements.AchievementTools.getClipsFromIDs(objects);
        this.debugTrace("-----------------------------------------------------------");
        this.debugTrace(" hit subjects: " + subjects.join(" "));
        this.debugTrace(" hit objects: " + objects.join(" "));
        this.debugTrace("-----------------------------------------------------------");
        this.debugTrace(" hit subject clips: " + _loc5.join(" "));
        this.debugTrace(" hit object clips: " + _loc6.join(" "));
        this.debugTrace("-----------------------------------------------------------");
        var _loc10 = _loc5.length;
        var _loc7 = _loc6.length;
        for (var _loc3 = 0; _loc3 < _loc10; ++_loc3)
        {
            var _loc4 = false;
            for (var _loc2 = 0; _loc2 < _loc7 && !_loc4; ++_loc2)
            {
                if (_loc5[_loc3].hitTest(_loc6[_loc2]))
                {
                    this.debugTrace(" subj " + _loc3 + " hit obj " + _loc2);
                    _loc4 = true;
                } // end if
            } // end of for
            if (_loc4)
            {
                ++_loc8;
                this.addSubjectFound(subjects[_loc3]);
            } // end if
        } // end of for
        this.debugTrace(" -----------------------------------------------------------");
        return (_loc8);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
