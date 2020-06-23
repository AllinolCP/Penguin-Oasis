class com.clubpenguin.achievements.AchievementTools
{
    static var _shell, _engine, __get__shell, __get__engine, __get__debug, __set__debug, __set__engine, __set__shell;
    function AchievementTools()
    {
    } // End of the function
    static function getClipFromObject(o)
    {
        switch (o.type)
        {
            case com.clubpenguin.achievements.AchievementTools._shell.BALL_LAND:
            {
                return (com.clubpenguin.achievements.AchievementTools._engine.getRoomMovieClip()["i" + o.id]);
                break;
            } 
        } // End of switch
        return (null);
    } // End of the function
    static function getClipsFromIDs(ids)
    {
        var _loc5 = [];
        for (var _loc3 = 0; _loc3 < ids.length; ++_loc3)
        {
            if (ids[_loc3].type != null)
            {
                var _loc7 = com.clubpenguin.achievements.AchievementTools.getClipFromObject(ids[_loc3]);
                if (_loc7 != null)
                {
                    _loc5.push(_loc7);
                } // end if
                continue;
            } // end if
            if (ids[_loc3].player_id != null)
            {
                _loc7 = com.clubpenguin.achievements.AchievementTools._engine.getPlayerMovieClip(ids[_loc3].player_id);
                if (_loc7 != null)
                {
                    _loc5.push(_loc7);
                } // end if
                continue;
            } // end if
            switch (ids[_loc3])
            {
                case "user":
                {
                    com.clubpenguin.achievements.AchievementTools.debugTrace("Push the user clip: " + com.clubpenguin.achievements.AchievementTools._engine.getPlayerMovieClip(com.clubpenguin.achievements.AchievementTools._shell.getMyPlayerId()));
                    _loc5.push(com.clubpenguin.achievements.AchievementTools._engine.getPlayerMovieClip(com.clubpenguin.achievements.AchievementTools._shell.getMyPlayerId()));
                    break;
                } 
                case "anyExceptUser":
                {
                    var _loc2 = com.clubpenguin.achievements.AchievementTools._shell.getPlayerList();
                    for (var _loc4 = 0; _loc4 < _loc2.length; ++_loc4)
                    {
                        if (_loc2[_loc4].player_id != com.clubpenguin.achievements.AchievementTools._shell.getMyPlayerId())
                        {
                            _loc5.push(com.clubpenguin.achievements.AchievementTools._engine.getPlayerMovieClip(_loc2[_loc4].player_id));
                        } // end if
                    } // end of for
                    break;
                } 
                case "any":
                {
                    _loc2 = com.clubpenguin.achievements.AchievementTools._shell.getPlayerList();
                    for (var _loc4 = 0; _loc4 < _loc2.length; ++_loc4)
                    {
                        _loc5.push(com.clubpenguin.achievements.AchievementTools._engine.getPlayerMovieClip(_loc2[_loc4].player_id));
                    } // end of for
                    break;
                } 
                default:
                {
                    com.clubpenguin.achievements.AchievementTools.debugTrace("unrecognised token \'" + ids[_loc3] + "\' is this a room clip?");
                    var _loc8 = ids[_loc3].split(".");
                    for (var _loc1 = com.clubpenguin.achievements.AchievementTools._engine.getRoomMovieClip(); _loc8.length > 0 && _loc1 != undefined; _loc1 = _loc1[_loc8.shift()])
                    {
                    } // end of for
                    com.clubpenguin.achievements.AchievementTools.debugTrace("room is " + com.clubpenguin.achievements.AchievementTools._engine.getRoomMovieClip());
                    com.clubpenguin.achievements.AchievementTools.debugTrace("clip is " + _loc1);
                    if (_loc1 != null)
                    {
                        _loc5.push(_loc1);
                    } // end if
                    break;
                } 
            } // End of switch
        } // end of for
        return (_loc5);
    } // End of the function
    static function debugTrace(msg)
    {
        if (com.clubpenguin.achievements.AchievementTools._debug)
        {
        } // end if
    } // End of the function
    static function set shell(s)
    {
        _shell = s;
        null;
        null;
        //return (com.clubpenguin.achievements.AchievementTools.shell());
        null;
    } // End of the function
    static function set engine(e)
    {
        _engine = e;
        null;
        null;
        //return (com.clubpenguin.achievements.AchievementTools.engine());
        null;
    } // End of the function
    static function set debug(d)
    {
        _debug = d;
        null;
        null;
        //return (com.clubpenguin.achievements.AchievementTools.debug());
        null;
    } // End of the function
    static var _debug = false;
} // End of Class
