class com.clubpenguin.achievements.AchievementEvent
{
    var _debug, _shell, _customEventId, _subject, _eventType, _customEventType, _refToLocalCallback, _eventCallback, __get__shell, __get__eventCallback, __set__eventCallback, __set__shell, __get__type;
    static var _subjectFactory;
    function AchievementEvent(shell, descriptor, debug)
    {
        _debug = debug || false;
        _shell = shell;
        _customEventId = com.clubpenguin.achievements.AchievementEvent.INVALID_INTERVAL_ID;
        this.debugTrace("AchievementEvent: (" + descriptor.join(" ") + ")");
        if (com.clubpenguin.achievements.AchievementEvent._subjectFactory == null)
        {
            _subjectFactory = new com.clubpenguin.achievements.subjects.AchievementSubjectFactory();
        } // end if
        if (descriptor[0] != "every")
        {
            com.clubpenguin.achievements.AchievementEvent._subjectFactory.__set__debug(debug);
            _subject = com.clubpenguin.achievements.AchievementEvent._subjectFactory.createSubject(descriptor);
            _subject.__set__debug(debug);
            _subject.__set__shell(_shell);
        } // end if
        var _loc3 = String(descriptor.shift());
        var _loc6;
        var _loc4;
        this.debugTrace("type: " + _loc3);
        switch (_loc3)
        {
            case "login":
            {
                _eventType = _shell.WORLD_CONNECT_SUCCESS;
                break;
            } 
            case "enterIgloo":
            {
                _eventType = _shell.JOIN_PLAYER_IGLOO;
                break;
            } 
            case "enterRoom":
            {
                _eventType = _subject.getEnterRoomEvent();
                break;
            } 
            case "leaveRoom":
            {
                _eventType = _shell.REMOVE_PLAYER;
                break;
            } 
            case "iglooFurnitureLoaded":
            {
                _eventType = _shell.IGLOO_FURNITURE_COMPLETE;
                break;
            } 
            case "iglooEdited":
            {
                _eventType = _shell.IGLOO_EDIT_MODE;
                break;
            } 
            case "wearItem":
            {
                _eventType = _shell.UPDATE_PLAYER;
                break;
            } 
            case "throwSnowball":
            {
                _eventType = _shell.THROW_BALL;
                break;
            } 
            case "snowballHit":
            {
                _eventType = _shell.BALL_LAND;
                break;
            } 
            case "move":
            {
                _eventType = _shell.PLAYER_MOVE;
                break;
            } 
            case "moveEnd":
            {
                _eventType = _shell.PLAYER_MOVE_DONE;
                break;
            } 
            case "changesFrame":
            {
                _eventType = _shell.PLAYER_FRAME;
                break;
            } 
            case "playerAction":
            {
                _eventType = _shell.PLAYER_ACTION;
                break;
            } 
            case "purchaseItem":
            {
                _eventType = _shell.BUY_INVENTORY;
                break;
            } 
            case "sendMessage":
            {
                _eventType = _shell.SEND_MESSAGE;
                break;
            } 
            case "purchaseFurniture":
            {
                _eventType = _shell.BUY_FURNITURE;
                break;
            } 
            case "sendEmote":
            {
                _eventType = _shell.SHOW_EMOTE;
                break;
            } 
            case "hasAchievementEvent":
            {
                _eventType = _shell.ACHIEVEMENT_EVENT;
                break;
            } 
            case "every":
            {
                _customEventType = com.clubpenguin.achievements.AchievementEvent.CUSTOM_EVENT_PERIODIC;
                _loc4 = String(descriptor.shift());
                _loc6 = String(descriptor.shift());
                break;
            } 
            default:
            {
                throw new com.clubpenguin.achievements.AchievementException("AchievementEvent did not recognise event type:\"" + _loc3 + "\"");
                break;
            } 
        } // End of switch
        if (_eventType != null)
        {
            this.debugTrace("_eventType: " + _eventType);
            _refToLocalCallback = com.clubpenguin.util.Delegate.create(this, onEvent);
            if (!_shell.addListener(_eventType, _refToLocalCallback, null))
            {
                throw new com.clubpenguin.achievements.AchievementException("AchievementEvent could not add a listener for event type:\"" + _loc3 + "\"");
            } // end if
        } // end if
        if (_customEventType != null)
        {
            this.debugTrace("_customEventType: " + _customEventType);
            if (_customEventType == com.clubpenguin.achievements.AchievementEvent.CUSTOM_EVENT_PERIODIC)
            {
                var _loc5 = com.clubpenguin.achievements.AchievementEvent.getIntervalPeriod(_loc6, _loc4);
                _customEventId = setInterval(this, "onEvent", _loc5, null);
            } // end if
        } // end if
    } // End of the function
    function destroy()
    {
        if (_eventType != null)
        {
            _shell.removeListener(_eventType, _refToLocalCallback);
            _refToLocalCallback = null;
            _eventType = null;
        } // end if
        if (_customEventType != null)
        {
            if (_customEventId != com.clubpenguin.achievements.AchievementEvent.INVALID_INTERVAL_ID)
            {
                clearInterval(_customEventId);
                _customEventId = com.clubpenguin.achievements.AchievementEvent.INVALID_INTERVAL_ID;
            } // end if
            _customEventType = null;
        } // end if
    } // End of the function
    function onEvent(event)
    {
        this.debugTrace("onEvent - _eventType: \'" + (_eventType || "Custom " + _customEventType) + "\'");
        if (_subject == null || _subject.shouldEventFire(event))
        {
            this._eventCallback(event);
        } // end if
    } // End of the function
    static function getIntervalPeriod(periodMultiplier, value)
    {
        var _loc1;
        switch (periodMultiplier)
        {
            case "second":
            case "seconds":
            {
                _loc1 = com.clubpenguin.achievements.AchievementEvent.INTERVAL_SECOND;
                break;
            } 
            case "minute":
            case "minutes":
            {
                _loc1 = com.clubpenguin.achievements.AchievementEvent.INTERVAL_MINUTE;
                break;
            } 
            case "hour":
            case "hours":
            {
                _loc1 = com.clubpenguin.achievements.AchievementEvent.INTERVAL_HOUR;
                break;
            } 
            case "day":
            case "days":
            {
                _loc1 = com.clubpenguin.achievements.AchievementEvent.INTERVAL_DAY;
                break;
            } 
            default:
            {
                throw new com.clubpenguin.achievements.AchievementException("AchievementEvent::getIntervalPeriod did not recognise periodMultiplier type:\"" + periodMultiplier + "\"");
            } 
        } // End of switch
        var _loc2 = _loc1 * Number(value);
        if (isNaN(_loc2))
        {
            throw new com.clubpenguin.achievements.AchievementException("AchievementEvent::getIntervalPeriod calculated an invalid period from the description: \"" + value + " " + periodMultiplier + "\"");
        } // end if
        return (_loc2);
    } // End of the function
    function set shell(s)
    {
        _shell = s;
        //return (this.shell());
        null;
    } // End of the function
    function set eventCallback(callback)
    {
        _eventCallback = callback;
        //return (this.eventCallback());
        null;
    } // End of the function
    function get type()
    {
        return (_eventType);
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
    static var CUSTOM_EVENT_PERIODIC = 0;
    static var INVALID_INTERVAL_ID = -1;
    static var INTERVAL_SECOND = 1000;
    static var INTERVAL_MINUTE = 60 * com.clubpenguin.achievements.AchievementEvent.INTERVAL_SECOND;
    static var INTERVAL_HOUR = 60 * com.clubpenguin.achievements.AchievementEvent.INTERVAL_MINUTE;
    static var INTERVAL_DAY = 24 * com.clubpenguin.achievements.AchievementEvent.INTERVAL_HOUR;
} // End of Class
