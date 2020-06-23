class com.clubpenguin.achievements.verbs.AchievementVerbPuffles extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _property, _shell, addSubjectFound, _debug;
    function AchievementVerbPuffles(descriptor, debug)
    {
        super(descriptor, debug);
        _property = String(descriptor.shift());
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        var _loc2 = 0;
        if (subjects.length > 1)
        {
            throw new com.clubpenguin.achievements.AchievementException("AchievementVerbPuffles::activate cannot check puffles for penguins other than the user.");
        } // end if
        if (subjects[0].player_id != _shell.getMyPlayerId())
        {
            throw new com.clubpenguin.achievements.AchievementException("AchievementVerbPuffles::activate cannot check puffles for penguins other than the user. Player ID of subject did not match.");
        } // end if
        switch (_property)
        {
            case "countGreaterThan":
            {
                if (_shell.getMyPuffleCount() > objects[0])
                {
                    _loc2 = 1;
                } // end if
                break;
            } 
            default:
            {
                throw new com.clubpenguin.achievements.AchievementException("AchievementVerbPuffles did not recognise property:\"" + _property + "\"");
                break;
            } 
        } // End of switch
        if (_loc2 == 1)
        {
            this.addSubjectFound(subjects[0]);
        } // end if
        return (_loc2);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
