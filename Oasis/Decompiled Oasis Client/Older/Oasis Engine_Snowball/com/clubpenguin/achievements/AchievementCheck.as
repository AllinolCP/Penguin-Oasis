class com.clubpenguin.achievements.AchievementCheck
{
    var _events, _conditions, _optionalConditions, _results, _shell, _debug, _complete, __set__enabled, _descriptor, _enabled, __set__complete, __get__id, __get__debug, _name, __get__name, _id, __get__enabled, __get__complete, _subjectsSatisfyingPreviousCondition, __get__subjectsSatisfyingPreviousCondition, _quantity, __get__quantity, _includeUserInCount, __get__includeUserInCount, __set__debug, __set__id, __set__includeUserInCount, __set__name, __set__quantity, __set__subjectsSatisfyingPreviousCondition;
    function AchievementCheck(shell)
    {
        _events = null;
        _conditions = null;
        _optionalConditions = null;
        _results = null;
        _shell = shell;
        _debug = false;
        _complete = false;
        this.__set__enabled(true);
        _descriptor = "";
    } // End of the function
    null[] = (com.clubpenguin.achievements.AchievementException)() == null ? (null, throw , function (descriptor)
    {
        if (_events == null)
        {
            _events = [];
        } // end if
        _descriptor = _descriptor + (descriptor + " ");
        this.debugTrace("addEvent \'" + descriptor + "\'");
        try
        {
            var _loc4 = descriptor.split(" ");
            var _loc3 = new com.clubpenguin.achievements.AchievementEvent(_shell, _loc4, _debug);
            _loc3.__set__eventCallback(com.clubpenguin.util.Delegate.create(this, onCheck));
            _events.push(_loc3);
        } // End of try
        catch ()
        {
        } // End of catch
    }) : (var ae = (com.clubpenguin.achievements.AchievementException)(), throw new com.clubpenguin.achievements.AchievementException("Error adding event from string \"" + descriptor + "\".\nThe error reported was:\n\"" + ae.message + "\""), "addEvent");
    null[] = (com.clubpenguin.achievements.AchievementException)() == null ? (null, throw , function (descriptor, isOptional)
    {
        if (_conditions == null)
        {
            _conditions = [];
        } // end if
        if (_optionalConditions == null)
        {
            _optionalConditions = [];
        } // end if
        _descriptor = _descriptor + (descriptor + " ");
        this.debugTrace("addCondition \'" + descriptor + "\'");
        try
        {
            var _loc4 = descriptor.split(" ");
            var _loc3 = new com.clubpenguin.achievements.AchievementCondition(_shell, _loc4, this, isOptional, _debug);
            isOptional ? (_optionalConditions.push(_loc3)) : (_conditions.push(_loc3));
        } // End of try
        catch ()
        {
        } // End of catch
    }) : (var ae = (com.clubpenguin.achievements.AchievementException)(), throw new com.clubpenguin.achievements.AchievementException("Error adding condition from string \"" + descriptor + "\".\nThe error reported was:\n\"" + ae.message + "\""), "addCondition");
    null[] = (com.clubpenguin.achievements.AchievementException)() == null ? (null, throw , function (descriptor)
    {
        if (_results == null)
        {
            _results = [];
        } // end if
        _descriptor = _descriptor + (descriptor + " ");
        try
        {
            var _loc3 = null;
            this.debugTrace("addResult type:\'" + typeof(descriptor) + "\' desc:\'" + descriptor + "\'");
            if (typeof(descriptor) == "string")
            {
                var _loc4 = descriptor.split(" ");
                _loc3 = new com.clubpenguin.achievements.AchievementResult(_shell, _loc4, _debug);
            }
            else if (typeof(descriptor) == "object")
            {
                _loc3 = new com.clubpenguin.achievements.AchievementResult(_shell, descriptor, _debug);
            } // end else if
            _results.push(_loc3);
        } // End of try
        catch ()
        {
        } // End of catch
    }) : (var ae = (com.clubpenguin.achievements.AchievementException)(), throw new com.clubpenguin.achievements.AchievementException("Error adding result from string \"" + descriptor + "\".\nThe error reported was:\n\"" + ae.message + "\""), "addResult");
    function onCheck(event)
    {
        if (!_enabled)
        {
            this.debugTrace("onCheck \'" + _descriptor + "\' - is not enabled.");
            return;
        } // end if
        this.debugTrace("onCheck \'" + _descriptor + "\' pid:" + event.player_id + " type:" + event.type);
        try
        {
            this.debugTrace("Checking " + _conditions.length + " conditions and " + _optionalConditions.length + " optionalConditions:");
            var _loc12 = _conditions.length;
            var _loc9 = _optionalConditions.length;
            var _loc10 = false;
            for (var _loc3 = 0; _loc3 < _loc12; ++_loc3)
            {
                var _loc6 = _conditions[_loc3];
                var _loc7 = _loc6.check(event);
                if (!_loc7)
                {
                    this.debugTrace("  condition " + _loc3 + " failed for condition.");
                    return;
                } // end if
            } // end of for
            for (var _loc3 = 0; _loc3 < _loc9; ++_loc3)
            {
                _loc6 = _optionalConditions[_loc3];
                _loc7 = _loc6.check(event);
                if (_loc7)
                {
                    this.debugTrace("  check succeeded for optionalCondition.");
                    _loc10 = true;
                    break;
                } // end if
            } // end of for
            if (_loc9 > 0 && !_loc10)
            {
                this.debugTrace("achievement failed, all " + _loc9 + " optionalConditions failed.");
                return;
            } // end if
            this.__set__complete(true);
            var _loc11 = _results.length;
            this.debugTrace("achievement suceeded! Firing " + _loc11 + " results.");
            for (var _loc4 = 0; _loc4 < _loc11; ++_loc4)
            {
                _results[_loc4].fire();
            } // end of for
            _shell.updateListeners(_shell.ACHIEVEMENT_DONE, this.__get__id());
        } // End of try
        catch ()
        {
            if ((com.clubpenguin.achievements.AchievementException)() != null)
            {
                var ae = (com.clubpenguin.achievements.AchievementException)();
                var _loc2 = "Error evaluating condition.\nThe error reported was:\n\"" + ae.message;
                _loc2 = _loc2 + ("\nThe check has " + _events.length + " events:\n");
                for (var _loc5 = 0; _loc5 < _events.length; ++_loc5)
                {
                    _loc2 = _loc2 + ("  " + _events[_loc5].type + "\n");
                } // end of for
                _loc2 = _loc2 + ("\nThe check has " + _conditions.length + " conditions:");
                for (var _loc3 = 0; _loc3 < _conditions.length; ++_loc3)
                {
                    _loc2 = _loc2 + ("  [" + _loc3 + "] verb type " + _conditions[_loc3]._verb + "\n");
                } // end of for
                _loc2 = _loc2 + ("\nThe check has " + _optionalConditions.length + " optionalConditions:");
                for (var _loc3 = 0; _loc3 < _optionalConditions.length; ++_loc3)
                {
                    _loc2 = _loc2 + ("  [" + _loc3 + "] verb type " + _optionalConditions[_loc3]._verb + "\n");
                } // end of for
                _loc2 = _loc2 + ("\nThe check has " + _results.length + " results:");
                for (var _loc4 = 0; _loc4 < _results.length; ++_loc4)
                {
                    _loc2 = _loc2 + ("  [" + _loc4 + "] callback param " + _results[_loc4]._callbackParams + "\n");
                } // end of for
            }
            else
            {
                null;
                throw ;
            } // end else if
        } // End of catch
    } // End of the function
    function destroy()
    {
        delete this._conditions;
        delete this._optionalConditions;
        for (var _loc2 = 0; _loc2 < _events.length; ++_loc2)
        {
            _events[_loc2].destroy();
            delete _events[_loc2];
        } // end of for
        delete this._events;
        for (var _loc2 = 0; _loc2 < _results.length; ++_loc2)
        {
            _results[_loc2].destroy();
            delete _results[_loc2];
        } // end of for
        delete this._results;
    } // End of the function
    function set debug(d)
    {
        _debug = d;
        //return (this.debug());
        null;
    } // End of the function
    function set name(checkName)
    {
        _name = checkName;
        //return (this.name());
        null;
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function set id(checkID)
    {
        _id = checkID;
        //return (this.id());
        null;
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function set enabled(isEnabled)
    {
        _enabled = isEnabled;
        //return (this.enabled());
        null;
    } // End of the function
    function get enabled()
    {
        return (_enabled);
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
    function get subjectsSatisfyingPreviousCondition()
    {
        return (_subjectsSatisfyingPreviousCondition);
    } // End of the function
    function set subjectsSatisfyingPreviousCondition(subjects)
    {
        _subjectsSatisfyingPreviousCondition = [];
        _subjectsSatisfyingPreviousCondition = _subjectsSatisfyingPreviousCondition.concat(subjects);
        //return (this.subjectsSatisfyingPreviousCondition());
        null;
    } // End of the function
    function get quantity()
    {
        return (_quantity);
    } // End of the function
    function set quantity(quantity)
    {
        _quantity = quantity;
        //return (this.quantity());
        null;
    } // End of the function
    function get includeUserInCount()
    {
        return (_includeUserInCount);
    } // End of the function
    function set includeUserInCount(include)
    {
        _includeUserInCount = include;
        //return (this.includeUserInCount());
        null;
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
