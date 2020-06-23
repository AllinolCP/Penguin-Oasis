class com.clubpenguin.achievements.AchievementCondition
{
    var _shell, _debug, _achievementCheck, _isOptional, _subject, _verb, _object, __get__shell, __get__debug, __set__debug, __get__isOptional, __set__shell;
    static var _achievementVerbFactory, _achievementSubjectFactory, _achievementObjectFactory;
    function AchievementCondition(shell, descriptor, achievementCheck, isOptional, debug)
    {
        _shell = shell;
        _debug = debug || false;
        _achievementCheck = achievementCheck;
        _isOptional = isOptional;
        if (com.clubpenguin.achievements.AchievementCondition._achievementVerbFactory == null)
        {
            _achievementVerbFactory = new com.clubpenguin.achievements.verbs.AchievementVerbFactory(false);
        } // end if
        if (com.clubpenguin.achievements.AchievementCondition._achievementSubjectFactory == null)
        {
            _achievementSubjectFactory = new com.clubpenguin.achievements.subjects.AchievementSubjectFactory(false);
        } // end if
        if (com.clubpenguin.achievements.AchievementCondition._achievementObjectFactory == null)
        {
            _achievementObjectFactory = new com.clubpenguin.achievements.objects.AchievementObjectFactory(false);
            com.clubpenguin.achievements.AchievementCondition._achievementObjectFactory.__set__shell(shell);
        } // end if
        com.clubpenguin.achievements.AchievementCondition._achievementSubjectFactory.__set__debug(_debug);
        _subject = com.clubpenguin.achievements.AchievementCondition._achievementSubjectFactory.createSubject(descriptor, _achievementCheck);
        _subject.__set__debug(_debug);
        _subject.__set__shell(shell);
        com.clubpenguin.achievements.AchievementCondition._achievementVerbFactory.__set__debug(_debug);
        _verb = com.clubpenguin.achievements.AchievementCondition._achievementVerbFactory.createVerb(descriptor);
        _verb.__set__shell(shell);
        _verb.__set__debug(_debug);
        com.clubpenguin.achievements.AchievementCondition._achievementObjectFactory.__set__debug(_debug);
        _object = com.clubpenguin.achievements.AchievementCondition._achievementObjectFactory.createObject(descriptor);
        _object.__set__debug(_debug);
        _object.__set__shell(_shell);
        while (descriptor[0] == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_OR || descriptor[0] == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_AND)
        {
            if (_object.__get__operation() == com.clubpenguin.achievements.objects.AchievementObject.OPERATION_NONE)
            {
                _object.__set__operation(descriptor[0]);
            } // end if
            if (descriptor[0] != _object.__get__operation())
            {
                throw new com.clubpenguin.achievements.AchievementException("AchievementCondition cannot mix \"or\" and \"and\" operators");
            } // end if
            descriptor.shift();
            _object.addElement(descriptor);
        } // end while
        if (descriptor.length > 0)
        {
            _verb.__set__isList(true);
            do
            {
                _object.addElement(descriptor);
            } while (descriptor.length > 0)
        } // end if
    } // End of the function
    function check(event)
    {
        var _loc5 = _subject.getCurrentSubjects(event);
        _verb.clearSubjectsFoundOn();
        if (_subject.__get__quantity() > 1)
        {
            this.debugTrace("Need to get " + _subject.__get__quantity() + " hits to pass this check ...");
        } // end if
        if (_subject.__get__quantity() > _loc5.length)
        {
            this.debugTrace("we don\'t have enough currentSubjects to meet the quantity of matches.");
            return (false);
        } // end if
        var _loc6 = _object.getCurrentObjects();
        if (_verb.activate(_loc5, _loc6, _object.__get__operation()) < _subject.__get__quantity())
        {
            this.debugTrace("got " + _loc5.length + " subjects to check, which failed.");
            return (false);
        }
        else if (_subject.__get__includeUserInCount())
        {
            var _loc4 = _verb.__get__subjectsFoundOn().length;
            var _loc3 = false;
            for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
            {
                if (_shell.isMyPlayer(_verb.__get__subjectsFoundOn()[_loc2].player_id))
                {
                    _loc3 = true;
                    break;
                } // end if
            } // end of for
            if (!_loc3)
            {
                this.debugTrace("user was specified to be included in condition but was not found.");
                return (false);
            } // end if
        } // end else if
        this.debugTrace("got " + _loc5.length + " subjects to check, which suceeded.");
        _achievementCheck.__set__subjectsSatisfyingPreviousCondition(_verb.subjectsFoundOn);
        _achievementCheck.__set__quantity(_subject.quantity);
        _achievementCheck.__set__includeUserInCount(_subject.includeUserInCount);
        return (true);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
    function set shell(s)
    {
        _shell = s;
        _subject.__set__shell(s);
        _verb.__set__shell(s);
        _object.__set__shell(s);
        //return (this.shell());
        null;
    } // End of the function
    function get isOptional()
    {
        return (_isOptional);
    } // End of the function
    function set debug(d)
    {
        _debug = d;
        if (_subject != null)
        {
            _subject.__set__debug(d);
        } // end if
        if (_verb != null)
        {
            _verb.__set__debug(d);
        } // end if
        if (_object != null)
        {
            _object.__set__debug(d);
        } // end if
        //return (this.debug());
        null;
    } // End of the function
} // End of Class
