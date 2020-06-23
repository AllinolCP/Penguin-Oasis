class com.clubpenguin.achievements.verbs.AchievementVerbOccursUniquely extends com.clubpenguin.achievements.verbs.AchievementVerb
{
    var _uniqueTypeSeen, _uniqueType, _debug, _shell, addSubjectFound;
    function AchievementVerbOccursUniquely(descriptor, debug)
    {
        super(descriptor, debug);
        _uniqueTypeSeen = {};
        _uniqueType = String(descriptor.shift());
    } // End of the function
    function activate(subjects, objects, objectOperation)
    {
        this.debugTrace("activate");
        var _loc3 = 0;
        com.clubpenguin.achievements.AchievementTools.__set__debug(_debug);
        switch (_uniqueType)
        {
            case "room":
            {
                var _loc2 = String(_shell.getCurrentRoomId());
                if (_uniqueTypeSeen[_loc2] == undefined)
                {
                    _uniqueTypeSeen[_loc2] = true;
                    --objects[0];
                }
                else
                {
                    return (0);
                } // end else if
                break;
            } 
            default:
            {
                throw new com.clubpenguin.achievements.AchievementException("[AchievementVerbOccursUniquely] unrecognise unique type:\"" + _uniqueType + "\"");
            } 
        } // End of switch
        if (objects[0] <= 0)
        {
            _loc3 = 1;
            this.addSubjectFound(subjects[0]);
            this.debugTrace("activate - event has occured a sufficient number of times.");
        }
        else
        {
            this.debugTrace("activate - event must occur " + objects[0] + " more times.");
        } // end else if
        return (_loc3);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
} // End of Class
