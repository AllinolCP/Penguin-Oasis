class com.clubpenguin.achievements.verbs.AchievementVerbHasProperty extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _property, _comparison, addSubjectFound, _debug;
    function AchievementVerbHasProperty(descriptor, debug)
    {
        super(descriptor, debug);
        _property = String(descriptor.shift());
        var _loc3 = "comparison_" + String(descriptor.shift());
        _comparison = com.clubpenguin.achievements.verbs.AchievementVerbHasProperty[_loc3];
        if (_comparison == undefined)
        {
            throw new com.clubpenguin.achievements.AchievementException("AchievementVerbHasProperty: The comparison was not defined for \"" + _loc3 + "\". The property named was: \"" + _property + "\".");
        } // end if
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate - property: " + _property);
        var _loc8 = 0;
        var _loc9 = subjects.length;
        var _loc7 = objects.length;
        for (var _loc3 = 0; _loc3 < _loc9; ++_loc3)
        {
            var _loc4 = false;
            for (var _loc2 = 0; _loc2 < _loc7 && !_loc4; ++_loc2)
            {
                this.debugTrace("activate - does " + subjects[_loc3][_property] + " match " + objects[_loc2]);
                if (this._comparison(subjects[_loc3][_property], objects[_loc2]))
                {
                    _loc4 = true;
                } // end if
            } // end of for
            if (_loc4)
            {
                ++_loc8;
                this.addSubjectFound(subjects[_loc3]);
            } // end if
        } // end of for
        this.debugTrace("activate - hits: " + _loc8);
        return (_loc8);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
    static function comparison_greaterThan(value, comparison)
    {
        return (value > comparison);
    } // End of the function
    static function comparison_lessThan(value, comparison)
    {
        return (value < comparison);
    } // End of the function
    static function comparison_equals(value, comparison)
    {
        return (value == comparison);
    } // End of the function
    static function comparison_stringEquals(value, comparison)
    {
        return (value == comparison);
    } // End of the function
    static function comparison_stringNotEquals(value, comparison)
    {
        return (value != comparison);
    } // End of the function
} // End of Class
