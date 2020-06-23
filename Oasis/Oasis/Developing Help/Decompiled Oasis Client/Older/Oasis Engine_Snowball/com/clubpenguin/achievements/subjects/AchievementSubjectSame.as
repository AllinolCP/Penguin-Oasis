class com.clubpenguin.achievements.subjects.AchievementSubjectSame extends com.clubpenguin.achievements.subjects.AchievementSubject
{
    var _achievementCheck, _quantity, _includeUserInCount, _debug;
    function AchievementSubjectSame(descriptor, achievementCheck, debug)
    {
        super();
        _achievementCheck = achievementCheck;
    } // End of the function
    function getCurrentSubjects(event)
    {
        var _loc2 = _achievementCheck.__get__subjectsSatisfyingPreviousCondition();
        _quantity = _achievementCheck.quantity;
        _includeUserInCount = _achievementCheck.includeUserInCount;
        return (_loc2);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
