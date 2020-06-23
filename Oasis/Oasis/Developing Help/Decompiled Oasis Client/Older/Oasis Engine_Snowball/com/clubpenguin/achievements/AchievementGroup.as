class com.clubpenguin.achievements.AchievementGroup
{
    var _shell, _debug, _complete, _type, _results, _achievements, __get__complete, __set__complete, _name, __get__name, _id, __get__id, __get__type, __get__debug, __get__achievements, __set__debug, __set__id, __set__name, __set__type;
    function AchievementGroup(shell)
    {
        _shell = shell;
        _debug = false;
        _complete = false;
        _type = com.clubpenguin.achievements.AchievementGroup.GROUPTYPE_UNSPECIFIED;
        _results = null;
    } // End of the function
    function get achievements()
    {
        return (_achievements);
    } // End of the function
    function addAchievement(achievement)
    {
        this.debugTrace("addAchievement \'" + achievement.__get__name() + "\'");
        if (_achievements == null)
        {
            _achievements = [];
        } // end if
        _achievements.push(achievement);
        achievement.addResult([com.clubpenguin.achievements.AchievementResult.ACHIEVEMENTRESULT_CALLBACK, com.clubpenguin.util.Delegate.create(this, onAchievementFired, achievement)]);
    } // End of the function
    null[] = (com.clubpenguin.achievements.AchievementException)() == null ? (null, throw , function (descriptor)
    {
        if (_results == null)
        {
            _results = [];
        } // end if
        try
        {
            var _loc3 = null;
            this.debugTrace("addResult - type:" + typeof(descriptor) + " \'" + descriptor + "\'");
            if (typeof(descriptor) == "string")
            {
                var _loc4 = descriptor.split(" ");
                _loc3 = new com.clubpenguin.achievements.AchievementResult(_shell, _loc4, _debug);
            }
            else if (typeof(descriptor) == "object")
            {
                _loc3 = new com.clubpenguin.achievements.AchievementResult(_shell, Array(descriptor), _debug);
            } // end else if
            _results.push(_loc3);
        } // End of try
        catch ()
        {
        } // End of catch
    }) : (var ae = (com.clubpenguin.achievements.AchievementException)(), throw new com.clubpenguin.achievements.AchievementException("Error adding result from string \"" + descriptor + "\".\nThe error reported was:\n\"" + ae.message + "\""), "addResult");
    function completeInitialization()
    {
        if (_type == com.clubpenguin.achievements.AchievementGroup.GROUPTYPE_SPECIFIC_ORDER)
        {
            var _loc3 = _achievements.length;
            if (_loc3 > 0)
            {
                _achievements[0].enabled = true;
            } // end if
            for (var _loc2 = 1; _loc2 < _loc3; ++_loc2)
            {
                _achievements[_loc2].enabled = false;
            } // end of for
        } // end if
    } // End of the function
    function onAchievementFired(result, achievement)
    {
        this.debugTrace("onAchievementFired - achievement:" + achievement.__get__name());
        switch (_type)
        {
            case com.clubpenguin.achievements.AchievementGroup.GROUPTYPE_ANY_ORDER:
            {
                var _loc3 = true;
                for (var _loc2 = 0; _loc2 < _achievements.length; ++_loc2)
                {
                    if (!_achievements[_loc2].complete)
                    {
                        this.debugTrace("onAchievementFired - achievement " + _loc2 + " / " + _achievements.length + " (" + _achievements[_loc2].name + ") remains incomplete. (value:" + _achievements[_loc2].complete + ")");
                        _loc3 = false;
                        break;
                    } // end if
                } // end of for
                if (_loc3)
                {
                    this.onGroupComplete();
                } // end if
                break;
            } 
            case com.clubpenguin.achievements.AchievementGroup.GROUPTYPE_SPECIFIC_ORDER:
            {
                if (achievement.__get__id() == _achievements[_achievements.length - 1].id)
                {
                    this.onGroupComplete();
                }
                else
                {
                    for (var _loc2 = 0; _loc2 < _achievements.length; ++_loc2)
                    {
                        if (achievement.__get__id() == _achievements[_loc2].id)
                        {
                            _achievements[_loc2 + 1].enabled = true;
                            break;
                        } // end if
                    } // end of for
                } // end else if
                break;
            } 
            default:
            {
                throw new com.clubpenguin.achievements.AchievementException("group did not have a defined group type.");
            } 
        } // End of switch
    } // End of the function
    function onGroupComplete()
    {
        this.debugTrace("onGroupComplete");
        if (this.__get__complete())
        {
            return;
        } // end if
        this.__set__complete(true);
        if (_results != null)
        {
            for (var _loc2 = 0; _loc2 < _results.length; ++_loc2)
            {
                _results[_loc2].fire();
            } // end of for
        } // end if
        delete this._achievements;
    } // End of the function
    function set complete(isComplete)
    {
        _complete = isComplete;
        //return (this.complete());
        null;
    } // End of the function
    function get complete()
    {
        return (_complete);
    } // End of the function
    function set name(groupName)
    {
        _name = groupName;
        //return (this.name());
        null;
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function set id(groupID)
    {
        _id = groupID;
        //return (this.id());
        null;
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function set type(groupType)
    {
        switch (groupType)
        {
            case "anyOrder":
            {
                _type = com.clubpenguin.achievements.AchievementGroup.GROUPTYPE_ANY_ORDER;
                break;
            } 
            case "specificOrder":
            {
                _type = com.clubpenguin.achievements.AchievementGroup.GROUPTYPE_SPECIFIC_ORDER;
                break;
            } 
            default:
            {
                throw new com.clubpenguin.achievements.AchievementException("AchievementGroup::set type(\"" + groupType + "\") - this group type was not recognised.");
            } 
        } // End of switch
        //return (this.type());
        null;
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
    function set debug(enabled)
    {
        _debug = enabled;
        //return (this.debug());
        null;
    } // End of the function
    static var GROUPTYPE_UNSPECIFIED = -1;
    static var GROUPTYPE_ANY_ORDER = 0;
    static var GROUPTYPE_SPECIFIC_ORDER = 1;
} // End of Class
