class com.clubpenguin.login.LocalData
{
    static var _playerToSave, _unstoredNewspaperIssue, _lastWorldId, _savedGame;
    function LocalData()
    {
    } // End of the function
    static function setPlayerObjectToSave(obj)
    {
        _playerToSave = obj;
    } // End of the function
    static function getPlayerObjectToSave()
    {
        return (com.clubpenguin.login.LocalData._playerToSave);
    } // End of the function
    static function savePlayerObject()
    {
        com.clubpenguin.login.LocalData.debugTrace("savePlayerObject");
        var _loc3 = com.clubpenguin.login.LocalData.getPlayerObjectToSave();
        var _loc4 = _global.getCurrentShell().getMyPlayerObject();
        var _loc6 = _loc3.isRememberUsername;
        var _loc7 = _loc3.isRememberPassword;
        var _loc5 = com.clubpenguin.login.LocalData.isPlayerCurrentlySaved(_loc3.Username.toLowerCase());
        if (_loc6)
        {
            var _loc2 = new Object();
            _loc2.Feet = _loc4.feet;
            _loc2.Hand = _loc4.hand;
            _loc2.Body = _loc4.body;
            _loc2.Neck = _loc4.neck;
            _loc2.Face = _loc4.face;
            _loc2.Head = _loc4.head;
            _loc2.Colour = _loc4.colour_id;
            _loc2.LastSave = _global.getCurrentShell().getLocalEpoch();
            _loc2.Nickname = _loc4.nickname.toLowerCase();
            _loc2.Username = _loc3.Username.toLowerCase();
            _loc2.PassCode = undefined;
            _loc2.LastWorldId = com.clubpenguin.login.LocalData.getLastWorldId();
            var _loc8 = _loc3.Username.toLowerCase();
            if (_loc7)
            {
                _loc2.PassCode = _global.getCurrentShell().freezeCode(_loc8, _loc3.Password);
            } // end if
            _loc2.LastNewspaper = com.clubpenguin.login.LocalData.getStoredNewspaperIssue();
            _loc2.so_version = com.clubpenguin.login.LocalData.SAVED_GAME_VERSION;
            if (_loc5)
            {
                com.clubpenguin.login.LocalData.removeFromSavedPlayersByUsername(_loc3.Username);
            } // end if
            com.clubpenguin.login.LocalData.addPlayerToSavedPlayers(_loc2);
            var _loc9 = com.clubpenguin.login.LocalData.getSavedPlayers().length;
            if (_loc9 > com.clubpenguin.login.LocalData.MAX_SAVED_PLAYERS)
            {
                com.clubpenguin.login.LocalData.removeOldSavedPlayers();
            } // end if
            return;
        } // end if
        if (_loc5)
        {
            com.clubpenguin.login.LocalData.removeFromSavedPlayersByUsername(_loc3.Username);
        } // end if
    } // End of the function
    static function saveRoomPlayerObject(room_playerObject)
    {
        var _loc3 = com.clubpenguin.login.LocalData.getPlayerObjectToSave();
        var _loc8 = _global.getCurrentShell().getMyPlayerObject();
        var _loc10 = _loc3.isRememberUsername;
        var _loc6 = _loc3.isRememberPassword;
        var _loc5 = com.clubpenguin.login.LocalData.isPlayerCurrentlySaved(_loc3.Username.toLowerCase());
        if (_loc10)
        {
            var _loc2 = new Object();
            _loc2.Feet = room_playerObject.feet;
            _loc2.Hand = room_playerObject.hand;
            _loc2.Body = room_playerObject.body;
            _loc2.Neck = room_playerObject.neck;
            _loc2.Face = room_playerObject.face;
            _loc2.Head = room_playerObject.head;
            _loc2.Colour = room_playerObject.colour_id;
            _loc2.LastSave = _global.getCurrentShell().getLocalEpoch();
            _loc2.Nickname = _loc8.nickname.toLowerCase();
            _loc2.Username = _loc3.Username.toLowerCase();
            _loc2.PassCode = undefined;
            _loc2.LastWorldId = com.clubpenguin.login.LocalData.getLastWorldId();
            var _loc7 = _loc3.Username.toLowerCase();
            if (_loc6)
            {
                _loc2.PassCode = _global.getCurrentShell().freezeCode(_loc7, _loc3.Password);
            } // end if
            _loc2.LastNewspaper = com.clubpenguin.login.LocalData.getStoredNewspaperIssue();
            _loc2.so_version = com.clubpenguin.login.LocalData.SAVED_GAME_VERSION;
            if (_loc5)
            {
                com.clubpenguin.login.LocalData.removeFromSavedPlayersByUsername(_loc3.Username);
            } // end if
            com.clubpenguin.login.LocalData.addPlayerToSavedPlayers(_loc2);
            var _loc9 = com.clubpenguin.login.LocalData.getSavedPlayers().length;
            if (_loc9 > com.clubpenguin.login.LocalData.MAX_SAVED_PLAYERS)
            {
                com.clubpenguin.login.LocalData.removeOldSavedPlayers();
            } // end if
            return;
        } // end if
        if (_loc5)
        {
            com.clubpenguin.login.LocalData.removeFromSavedPlayersByUsername(_loc3.Username);
        } // end if
    } // End of the function
    static function removeFromSavedPlayersByUsername(username)
    {
        var _loc2 = com.clubpenguin.login.LocalData.getSavedPlayers();
        var _loc3 = _loc2.length;
        for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
        {
            if (_loc2[_loc1].Username.toLowerCase() == username.toLowerCase())
            {
                _loc2.splice(_loc1, 1);
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function getSavedPlayers()
    {
        var _loc1 = com.clubpenguin.login.LocalData.getSavedGame();
        if (_loc1.data.playerlist == undefined)
        {
            _loc1.data.playerlist = new Array();
        } // end if
        var _loc2 = _loc1.data.playerlist;
        return (_loc1.data.playerlist.sortOn(["Nickname"], [Array.CASEINSENSITIVE]));
    } // End of the function
    static function getLastWorldIdForActivePlayer()
    {
        var _loc1 = com.clubpenguin.login.LocalData.getPlayerObjectToSave().Username;
        var _loc2 = com.clubpenguin.login.LocalData.getSavedPlayerByUsername(_loc1);
        return (_loc2.LastWorldId);
    } // End of the function
    static function setLastNewspaperIssue(issue)
    {
        _unstoredNewspaperIssue = issue;
        com.clubpenguin.login.LocalData.savePlayerObject();
    } // End of the function
    static function getLastWorldId()
    {
        return (com.clubpenguin.login.LocalData._lastWorldId);
    } // End of the function
    static function setLastWorldId(id)
    {
        _lastWorldId = id;
    } // End of the function
    static function getStoredNewspaperIssue()
    {
        if (com.clubpenguin.login.LocalData._unstoredNewspaperIssue != null)
        {
            var _loc1 = com.clubpenguin.login.LocalData._unstoredNewspaperIssue;
            _unstoredNewspaperIssue = null;
            return (_loc1);
        } // end if
        var _loc3 = com.clubpenguin.login.LocalData.getPlayerObjectToSave().Username;
        var _loc2 = com.clubpenguin.login.LocalData.getSavedPlayerByUsername(_loc3);
        return (_loc2.LastNewspaper);
    } // End of the function
    static function getSavedGame()
    {
        if (com.clubpenguin.login.LocalData._savedGame == undefined)
        {
            _savedGame = SharedObject.getLocal(com.clubpenguin.login.LocalData.SAVED_GAME_NAME, com.clubpenguin.login.LocalData.SAVED_GAME_LOCATION);
        } // end if
        return (com.clubpenguin.login.LocalData._savedGame);
    } // End of the function
    static function removeOldSavedPlayers()
    {
        var _loc1 = com.clubpenguin.login.LocalData.getSavedPlayers();
        _loc1.sortOn("LastSave");
        _loc1.splice(com.clubpenguin.login.LocalData.MAX_SAVED_PLAYERS);
    } // End of the function
    static function addPlayerToSavedPlayers(playerObject)
    {
        com.clubpenguin.login.LocalData.getSavedPlayers().push(playerObject);
    } // End of the function
    static function isPlayerCurrentlySaved(username)
    {
        var _loc2 = com.clubpenguin.login.LocalData.getSavedPlayers();
        var _loc3 = _loc2.length;
        for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
        {
            if (_loc2[_loc1].Username.toLowerCase() == username.toLowerCase())
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function getSavedPlayerByUsername(username)
    {
        var _loc3 = com.clubpenguin.login.LocalData.getSavedPlayers();
        var _loc4 = _loc3.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            if (_loc3[_loc2].Username.toLowerCase() == username.toLowerCase())
            {
                return (_loc3[_loc2]);
            } // end if
        } // end of for
        _global.getCurrentShell().$e("[shell] getSavedPlayerByUsername() -> Not able to find player in the saved player list: username: " + username);
        return;
    } // End of the function
    static function saveNicknameToCookie(nickname)
    {
        flash.external.ExternalInterface.call(com.clubpenguin.login.LocalData.SET_COOKIE_METHOD, com.clubpenguin.login.LocalData.NICKNAME_COOKIE_NAME, nickname);
    } // End of the function
    static function setSavedPlayers(players)
    {
        com.clubpenguin.login.LocalData.getSavedGame().data.playerlist = players;
    } // End of the function
    static function debugTrace(msg)
    {
        if (!com.clubpenguin.login.LocalData._debugTracesActive)
        {
            return;
        } // end if
    } // End of the function
    static var SAVED_GAME_LOCATION = "/";
    static var SAVED_GAME_NAME = "SaveGame";
    static var SAVED_GAME_VERSION = 1;
    static var MAX_SAVED_PLAYERS = 6;
    static var SET_COOKIE_METHOD = "setCookie";
    static var NICKNAME_COOKIE_NAME = "penguinNickname";
    static var _debugTracesActive = false;
} // End of Class
