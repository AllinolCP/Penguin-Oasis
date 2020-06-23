function setPlayerObjectToSave(obj)
{
    player_to_save = obj;
} // End of the function
function getPlayerObjectToSave()
{
    return (player_to_save);
} // End of the function
function getSavedGame()
{
    if (saved_game == undefined)
    {
        saved_game = SharedObject.getLocal(SAVED_GAME_NAME, SAVED_GAME_LOCATION);
    } // end if
    return (saved_game);
} // End of the function
function savePlayerPaperdoll(player_obj)
{
} // End of the function
function savePlayerObject()
{
    var _loc3 = getPlayerObjectToSave();
    var _loc2 = getMyPlayerObject();
    var _loc8 = _loc3.isRememberUsername;
    var _loc7 = _loc3.isRememberPassword;
    var _loc4 = isPlayerCurrentlySaved(_loc3.Username.toLowerCase());
    if (_loc8)
    {
        var _loc1 = new Object();
        _loc1.Feet = _loc2.feet;
        _loc1.Hand = _loc2.hand;
        _loc1.Body = _loc2.body;
        _loc1.Neck = _loc2.neck;
        _loc1.Face = _loc2.face;
        _loc1.Head = _loc2.head;
        _loc1.Colour = _loc2.colour_id;
        _loc1.LastSave = getLocalEpoch();
        _loc1.Nickname = _loc2.nickname.toLowerCase();
        _loc1.Username = _loc3.Username.toLowerCase();
        _loc1.PassCode = undefined;
        _loc1.LastWorldId = getLastWorldId();
        var _loc6 = _loc3.Username.toLowerCase();
        if (_loc7)
        {
            _loc1.PassCode = freezeCode(_loc6, _loc3.Password);
        } // end if
        _loc1.LastNewspaper = undefined;
        _loc1.so_version = SAVED_GAME_VERSION;
        if (_loc4)
        {
            removeFromSavedPlayersByUsername(_loc3.Username);
        } // end if
        addPlayerToSavedPlayers(_loc1);
        var _loc5 = getSavedPlayers().length;
        if (_loc5 > MAX_SAVED_PLAYERS)
        {
            removeOldSavedPlayers();
        } // end if
    }
    else if (_loc4)
    {
        removeFromSavedPlayersByUsername(_loc3.Username);
    } // end else if
} // End of the function
function saveRoomPlayerObject(room_player_obj)
{
    var _loc2 = getPlayerObjectToSave();
    var _loc9 = getMyPlayerObject();
    var _loc8 = _loc2.isRememberUsername;
    var _loc7 = _loc2.isRememberPassword;
    var _loc4 = isPlayerCurrentlySaved(_loc2.Username.toLowerCase());
    if (_loc8)
    {
        var _loc1 = new Object();
        _loc1.Feet = room_player_obj.feet;
        _loc1.Hand = room_player_obj.hand;
        _loc1.Body = room_player_obj.body;
        _loc1.Neck = room_player_obj.neck;
        _loc1.Face = room_player_obj.face;
        _loc1.Head = room_player_obj.head;
        _loc1.Colour = room_player_obj.colour_id;
        _loc1.LastSave = getLocalEpoch();
        _loc1.Nickname = _loc9.nickname.toLowerCase();
        _loc1.Username = _loc2.Username.toLowerCase();
        _loc1.PassCode = undefined;
        _loc1.LastWorldId = getLastWorldId();
        var _loc6 = _loc2.Username.toLowerCase();
        if (_loc7)
        {
            _loc1.PassCode = freezeCode(_loc6, _loc2.Password);
        } // end if
        _loc1.LastNewspaper = undefined;
        _loc1.so_version = SAVED_GAME_VERSION;
        if (_loc4)
        {
            removeFromSavedPlayersByUsername(_loc2.Username);
        } // end if
        addPlayerToSavedPlayers(_loc1);
        var _loc5 = getSavedPlayers().length;
        if (_loc5 > MAX_SAVED_PLAYERS)
        {
            removeOldSavedPlayers();
        } // end if
    }
    else if (_loc4)
    {
        removeFromSavedPlayersByUsername(_loc2.Username);
    } // end else if
} // End of the function
function removeOldSavedPlayers()
{
    var _loc1 = getSavedPlayers();
    _loc1.sortOn("LastSave");
    _loc1.splice(MAX_SAVED_PLAYERS);
} // End of the function
function addPlayerToSavedPlayers(player_obj)
{
    getSavedPlayers().push(player_obj);
} // End of the function
function isPlayerCurrentlySaved(username)
{
    var _loc2 = getSavedPlayers();
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
function removeFromSavedPlayersByUsername(username)
{
    var _loc2 = getSavedPlayers();
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
function getSavedPlayerByUsername(username)
{
    var _loc2 = getSavedPlayers();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].Username.toLowerCase() == username.toLowerCase())
        {
            return (_loc2[_loc1]);
        } // end if
    } // end of for
    $e("[shell] getSavedPlayerByUsername() -> Not able to find player in the saved player list: username: " + username);
    return;
} // End of the function
function getSavedPlayers()
{
    var _loc1 = getSavedGame();
    if (_loc1.data.playerlist == undefined)
    {
        _loc1.data.playerlist = new Array();
    } // end if
    var _loc2 = _loc1.data.playerlist;
    return (_loc1.data.playerlist.sortOn(["Nickname"], [Array.CASEINSENSITIVE]));
} // End of the function
function setSavedPlayers(players)
{
    getSavedGame().data.playerlist = players;
} // End of the function
function getLastWorldIdForActivePlayer()
{
    var _loc2 = getPlayerObjectToSave().Username;
    var _loc1 = getSavedPlayerByUsername(_loc2);
    return (_loc1.LastWorldId);
} // End of the function
function getLastWorldId()
{
    return (last_world_id);
} // End of the function
function setLastWorldId(id)
{
    last_world_id = id;
} // End of the function
function setGlobalIgloo(mc)
{
    IGLOO_HOLDER = mc;
} // End of the function
function getGlobalIgloo()
{
    return (IGLOO_HOLDER);
} // End of the function
function setWebServiceManager(service)
{
    WEB_CRUMBS_SERVICE = service;
} // End of the function
function getWebServiceManager()
{
    return (WEB_CRUMBS_SERVICE);
} // End of the function
function getDomainName()
{
    var _loc4 = this._url.toLowerCase();
    var _loc2 = _loc4.split("/");
    var _loc3 = _loc2[2].split(".");
    return (_loc3);
} // End of the function
function isRunningLocal()
{
    if (is_running_local != undefined)
    {
        return (is_running_local);
    } // end if
    is_running_local = false;
    if (this._url.indexOf("file") == 0)
    {
        is_running_local = true;
    } // end if
    return (is_running_local);
} // End of the function
function startMyPuffleBrains()
{
    puffleManager.startRoomPuffleBrains();
} // End of the function
function stopMyPuffleBrains()
{
    puffleManager.stopRoomPuffleBrains();
} // End of the function
function sendPuffleMove(id, xpos, ypos)
{
    puffleManager.sendPuffleMove(id, xpos, ypos);
} // End of the function
function sendPuffleInteraction(success, id, interactionType, xpos, ypos)
{
    puffleManager.sendPuffleInteraction(success, id, interactionType, xpos, ypos);
} // End of the function
function setPuffleInteractionCompleteById(id)
{
    puffleManager.setPuffleInteractionCompleteById(id);
} // End of the function
function sendStartPuffleWalk(id)
{
    puffleManager.sendStartPuffleWalk(id);
} // End of the function
function sendStopPuffleWalk()
{
    puffleManager.stopAllPufflesWalking();
} // End of the function
function sendPufflePlay(id)
{
    puffleManager.requestPufflePlay(id);
} // End of the function
function sendPuffleRest(id)
{
    puffleManager.requestPuffleRest(id);
} // End of the function
function sendPuffleBath(id)
{
    puffleManager.requestPuffleBath(id);
} // End of the function
function sendPuffleFood(id)
{
    puffleManager.requestPuffleFeed(id);
} // End of the function
function sendPuffleCookie(id)
{
    puffleManager.sendPuffleCookie(id);
} // End of the function
function sendPuffleGum(id)
{
    puffleManager.sendPuffleGum(id);
} // End of the function
function sendAdoptPuffle(type_id, puffle_name)
{
    return (puffleManager.sendAdoptPuffle(type_id, puffle_name));
} // End of the function
function getPuffleObjectById(id)
{
    return (puffleManager.getRoomPuffleById(id));
} // End of the function
function getMyPuffleById(id)
{
    return (puffleModelManager.getMyPuffleById(id));
} // End of the function
function getMyPuffleArray()
{
    return;
} // End of the function
function getMyPuffleCount()
{
    //return (puffleManager.myPuffleCount());
} // End of the function
function disablePuffleInteractionByID(id)
{
    puffleManager.disablePuffleInteractionByID(id);
} // End of the function
function enablePuffleInteractionByID(id)
{
    puffleManager.enablePuffleInteractionByID(id);
} // End of the function
function getPuffleCrumbs()
{
    return (GLOBAL_CRUMBS.puffle_crumbs);
} // End of the function
function parseEnvironment()
{
    var _loc3 = this._url.toLowerCase().split("://");
    var _loc2 = _loc3[0];
    var _loc4;
    var _loc5;
    if (_loc2 == PROTOCOL_FILE)
    {
        setEnvironment(ENV_LOCAL);
        return;
    }
    else
    {
        _loc4 = _loc3[1].split(".");
        _loc5 = _loc4[0];
    } // end else if
    if (_loc2 == PROTOCOL_HTTP || _loc2 == PROTOCOL_HTTPS)
    {
        switch (_loc5)
        {
            case "sandbox01":
            {
                setEnvironment(ENV_SANDBOX_01);
                return;
            } 
            case "sandbox02":
            {
                setEnvironment(ENV_SANDBOX_02);
                return;
            } 
            case "sandbox03":
            {
                setEnvironment(ENV_SANDBOX_03);
                return;
            } 
            case "sandbox04":
            {
                setEnvironment(ENV_SANDBOX_04);
                return;
            } 
            case "sandbox05":
            {
                setEnvironment(ENV_SANDBOX_05);
                return;
            } 
            case "sandbox06":
            {
                setEnvironment(ENV_SANDBOX_06);
                return;
            } 
            case "sandbox07":
            {
                setEnvironment(ENV_SANDBOX_07);
                return;
            } 
            case "sandbox08":
            {
                setEnvironment(ENV_SANDBOX_08);
                return;
            } 
            case "sandbox09":
            {
                setEnvironment(ENV_SANDBOX_09);
                return;
            } 
            case "qa01":
            {
                setEnvironment(ENV_QA_01);
                return;
            } 
            case "qa02":
            {
                setEnvironment(ENV_QA_02);
                return;
            } 
            case "qa03":
            {
                setEnvironment(ENV_QA_03);
                return;
            } 
            case "qa04":
            {
                setEnvironment(ENV_QA_04);
                return;
            } 
            case "stage":
            {
                setEnvironment(ENV_STAGE);
                return;
            } 
        } // End of switch
        return;
    } // end if
} // End of the function
function getEnvironment()
{
    return (current_environment);
} // End of the function
function setEnvironment(env)
{
    current_environment = env;
} // End of the function
function setBootPaths(bootData)
{
    basePath = bootData.getBasePath();
    globalContentPath = bootData.getGlobalContentPath();
    localContentPath = bootData.getLocalContentPath();
    clientPath = bootData.getClientPath();
    gamesPath = bootData.getGamesPath();
} // End of the function
function setFieldOpWeek(week)
{
    fieldOpWeek = week;
} // End of the function
function getGlobalContentPath()
{
    return (globalContentPath);
} // End of the function
function getLocalContentPath()
{
    return (localContentPath);
} // End of the function
function getGamesPath()
{
    return (gamesPath);
} // End of the function
function getGameContentPath()
{
    return (com.clubpenguin.util.StringUtils.removeTrailingSlash(getGamesPath()));
} // End of the function
function setAffilateId(id)
{
    affiliateID = id || DEFAULT_AFFILIATE_ID;
} // End of the function
function getAffilateId()
{
    return (affiliateID);
} // End of the function
function setPromotionID(id)
{
    promotionID = id || DEFAULT_PROMOTION_ID;
} // End of the function
function getPromotionID()
{
    return (promotionID);
} // End of the function
function getLocalPathsObject()
{
    return (local_paths_object);
} // End of the function
function setLocalPathsObject(obj)
{
    local_paths_object = obj;
    com.clubpenguin.util.URLUtils.resetCacheOnURLsInObject(local_paths_object);
} // End of the function
function addLocalPath(keyword, path)
{
    if (isValidString(keyword))
    {
        if (isValidString(path))
        {
            var _loc2 = getLocalPathsObject();
            _loc2[keyword] = path;
        }
        else
        {
            $e("[shell] addLocalPath() -> Invalid String passed as path! path: " + path);
        } // end else if
    }
    else
    {
        $e("[shell] addLocalPath() -> Invalid String passed as keyword! keyword: " + keyword);
    } // end else if
} // End of the function
function getGlobalPathsObject()
{
    return (global_paths_object);
} // End of the function
function setGlobalPathsObject(paths)
{
    for (var _loc2 in paths)
    {
        paths[_loc2] = getGlobalContentPath() + paths[_loc2];
    } // end of for...in
    global_paths_object = paths;
    com.clubpenguin.util.URLUtils.resetCacheOnURLsInObject(global_paths_object);
} // End of the function
function getPath(id)
{
    var _loc3 = getLocalPathsObject();
    if (_loc3[id] != undefined)
    {
        return (getLocalContentPath() + _loc3[id]);
    } // end if
    if (LOCAL_CRUMBS.link_paths[id] != undefined)
    {
        return (LOCAL_CRUMBS.link_paths[id]);
    } // end if
    var _loc2 = getGlobalPathsObject();
    if (_loc2[id] != undefined)
    {
        return (_loc2[id]);
    } // end if
    $e("[shell] getPath() -> \"" + id + "\" does not exist!");
    return;
} // End of the function
function getBasePath()
{
    return (basePath);
} // End of the function
function getClientPath()
{
    return (clientPath);
} // End of the function
function getLocalizedFolder()
{
    return (localized_folder);
} // End of the function
function setLocalizedFolder(folder)
{
    localized_folder = folder;
} // End of the function
function getRootPath()
{
    return (getBasePath());
} // End of the function
function getStartScreenXMLPath()
{
    return (getLocalContentPath() + START_SCREEN_XML);
} // End of the function
function getStartScreenIconsPath()
{
    return (getLocalContentPath() + START_SCREEN_ICONS);
} // End of the function
function getStartScreenPopupsPath()
{
    return (getLocalContentPath() + START_SCREEN_POPUPS);
} // End of the function
function getStartScreenBackgroundsPath()
{
    return (getLocalContentPath() + START_SCREEN_BACKGROUNDS);
} // End of the function
function getLanguageObject()
{
    return (language_obj);
} // End of the function
function setLanguageObject(obj)
{
    language_obj = obj;
} // End of the function
function setJokeArray(arr)
{
    joke_arr = arr;
} // End of the function
function getJokeArray()
{
    return (joke_arr);
} // End of the function
function getJokeById(id)
{
    var _loc2 = getJokeArray();
    var _loc1 = _loc2[id];
    if (isValidString(_loc1))
    {
        return (_loc1);
    } // end if
    return;
} // End of the function
function getRandomJokeId()
{
    return (randBetween(0, getJokeArray().length - 1));
} // End of the function
function setSafeMessageArray(arr)
{
    safe_message_arr = arr;
} // End of the function
function getSafeMessageArray()
{
    return (safe_message_arr);
} // End of the function
function setTreveresdSafeMessageObject(obj)
{
    treveresed_safe_message_obj = obj;
} // End of the function
function getTreveresdSafeMessageObject()
{
    return (treveresed_safe_message_obj);
} // End of the function
function getSafeMessageById(id)
{
    var _loc2;
    var _loc1 = getTreveresdSafeMessageObject();
    if (_loc1[id].name != undefined)
    {
        _loc2 = _loc1[id].name;
    } // end if
    if (_loc1[id].message != undefined)
    {
        _loc2 = _loc1[id].message;
    } // end if
    if (isValidString(_loc2))
    {
        return (_loc2);
    } // end if
    return;
} // End of the function
function setMascotMessageArray(arr)
{
    mascot_message_arr = arr;
} // End of the function
function getMascotMessageArray()
{
    return (mascot_message_arr);
} // End of the function
function getMascotMessageById(id)
{
    var _loc10 = getMascotMessageArray();
    var _loc4;
    var _loc3 = 0;
    var _loc11 = _loc10.length;
    for (var _loc9 = 0; _loc9 < _loc11; ++_loc9)
    {
        var _loc6 = _loc10[_loc9].mascotScript;
        var _loc8 = _loc6.length;
        for (var _loc2 = 0; _loc2 < _loc8; ++_loc2)
        {
            var _loc5 = _loc3;
            var _loc1 = _loc6[_loc2].script;
            _loc3 = _loc3 + _loc1.length;
            if (_loc3 > id)
            {
                if (_loc6[_loc2].sharedScript)
                {
                    _loc4 = _loc1[id - _loc5].message;
                }
                else
                {
                    _loc4 = _loc1[id - _loc5];
                } // end else if
                if (isValidString(_loc4))
                {
                    return (_loc4);
                } // end if
            } // end if
        } // end of for
    } // end of for
    return;
} // End of the function
function setLineMessageArray(arr)
{
    line_message_arr = arr;
} // End of the function
function getLineMessageArray()
{
    return (line_message_arr);
} // End of the function
function getLineMessageById(id)
{
    var _loc2 = getLineMessageArray();
    var _loc1 = _loc2[id].message;
    if (isValidString(_loc1))
    {
        return (_loc1);
    } // end if
    return;
} // End of the function
function setQuickMessageArray(arr)
{
    quick_message_arr = arr;
} // End of the function
function getQuickMessageArray()
{
    return (quick_message_arr);
} // End of the function
function getQuickMessageById(id)
{
    var _loc2 = getQuickMessageArray();
    var _loc1 = _loc2[id];
    if (isValidString(_loc1))
    {
        return (_loc1);
    } // end if
    return;
} // End of the function
function getTourGuideMessageByRoomName(roomName)
{
    var _loc2 = getTourGuideMessageArray();
    var _loc1 = _loc2[roomName];
    if (isValidString(_loc1))
    {
        return (_loc1);
    } // end if
    return;
} // End of the function
function setTourGuideMessageArray(arr)
{
    tour_guide_message_arr = arr;
} // End of the function
function getTourGuideMessageArray()
{
    return (tour_guide_message_arr);
} // End of the function
function getLocalizedString(str)
{
    var _loc1 = getLanguageObject()[str];
    if (isValidString(_loc1))
    {
        return (_loc1);
    } // end if
    $e("getLocalizedString() -> There is no localized string for: " + str);
    return ("**" + str + "**");
} // End of the function
function replace(what, _with, input_string)
{
    return (input_string.split(what).join(_with));
} // End of the function
function replace_m(search, replacements)
{
    var _loc3 = replacements.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        search = search.split("%" + _loc1).join(replacements[_loc1]);
    } // end of for
    return (search);
} // End of the function
function setLanguageAbbreviation(abbr)
{
    var _loc1;
    switch (abbr)
    {
        case EN_ABBR:
        {
            _loc1 = EN_ABBR;
            break;
        } 
        case PT_ABBR:
        {
            _loc1 = PT_ABBR;
            break;
        } 
        case FR_ABBR:
        {
            _loc1 = FR_ABBR;
            break;
        } 
        case ES_ABBR:
        {
            _loc1 = ES_ABBR;
            break;
        } 
        default:
        {
            _loc1 = EN_ABBR;
        } 
    } // End of switch
    currentLanguageAbbreviation = _loc1.toLowerCase();
    currentLanguageBitmask = getLanguageBitmaskByAbbreviation(currentLanguageAbbreviation);
    currentLanguageFrame = getLocalizedFrameByAbbreviation(currentLanguageAbbreviation);
} // End of the function
function getLanguageBitmaskByAbbreviation(abbr)
{
    switch (abbr)
    {
        case EN_ABBR:
        {
            return (EN_BITMASK);
        } 
        case PT_ABBR:
        {
            return (PT_BITMASK);
        } 
        case FR_ABBR:
        {
            return (FR_BITMASK);
        } 
        case ES_ABBR:
        {
            return (ES_BITMASK);
        } 
    } // End of switch
    return (EN_BITMASK);
} // End of the function
function getLocalizedFrame()
{
    return (currentLanguageFrame);
} // End of the function
function getLocalizedFrameByAbbreviation(abbr)
{
    switch (abbr)
    {
        case EN_ABBR:
        {
            return (EN_FRAME);
        } 
        case PT_ABBR:
        {
            return (PT_FRAME);
        } 
        case FR_ABBR:
        {
            return (FR_FRAME);
        } 
        case ES_ABBR:
        {
            return (ES_FRAME);
        } 
    } // End of switch
    return (EN_FRAME);
} // End of the function
function getLanguageAbbreviation()
{
    return (currentLanguageAbbreviation);
} // End of the function
function getLanguageBitmask()
{
    return (currentLanguageBitmask);
} // End of the function
function e_default(obj)
{
    $d("[UNDEFINED ERROR] e_default() -> There has been an undefined error!");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(DEFAULT_ERROR);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(DEFAULT_ERROR_TYPE, DEFAULT_ERROR);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("client_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_noConnection(obj)
{
    $d("[" + obj.type + "] e_noConnection() -> No connection");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(NO_CONNECTION);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NO_CONNECTION);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("cant_connect_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_connectionLost(obj)
{
    $d("[" + obj.type + " ] e_connectionLost() -> Lost Connection");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(CONNECTION_LOST);
    var _loc2 = getLocalizedString("Learn More");
    var _loc1 = buildErrorCodeString(obj.type, CONNECTION_LOST);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("connection_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_timeOut(obj)
{
    $d("[" + obj.type + "] e_timeout() -> Client has timed out!");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(TIME_OUT);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, TIME_OUT);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("client_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_connectionAttemptTimedOut(obj)
{
    $d("[" + obj.type + "] e_connectionAttemptTimedOut() -> Client has timed out!");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(CONNECTION_TIMEOUT);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, CONNECTION_TIMEOUT);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("client_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_multiConnections(obj)
{
    $d("[" + obj.type + "] e_multiConnections() -> Multiple Connections detected");
    var _loc4 = window_size[WINDOW_SMALL];
    var _loc1 = getLocalizedErrorStringById(MULTI_CONNECTIONS);
    var _loc3 = getLocalizedString("Okay");
    var _loc2 = buildErrorCodeString(obj.type, MULTI_CONNECTIONS);
    AIRTOWER.disconnect();
    var _loc5 = function ()
    {
        var _loc1 = getEnvironment();
        if (_loc1 == ENV_STAGE)
        {
            getURL(STAGE_URL, "_self");
        }
        else
        {
            getURL(getPath("client_web"), "_self");
        } // end else if
    };
    showErrorPrompt(_loc4, _loc1, _loc3, _loc5, _loc2);
} // End of the function
function e_disconnect(obj)
{
    $d("[" + obj.type + "] e_disconnect() -> Socket Timeout");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(DISCONNECT);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, DISCONNECT);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("client_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_kick(obj)
{
    $d("[" + obj.type + "] e_kick() -> You have been kicked");
    var _loc3 = window_size[WINDOW_EXTRA_LARGE];
    var _loc5 = getLocalizedErrorStringById(KICK);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, KICK);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("client_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_relationshipErrorOne(obj)
{
    var _loc3 = window_size[WINDOW_MEDIUM];
    var _loc4 = getLocalizedErrorStringById(876);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, 876);
    showErrorPrompt(_loc3, _loc4, _loc2, _local2, _loc1);
} // End of the function
function e_relationshipErrorTwo(obj)
{
    var _loc3 = window_size[WINDOW_MEDIUM];
    var _loc4 = getLocalizedErrorStringById(877);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, 877);
    showErrorPrompt(_loc3, _loc4, _loc2, _local2, _loc1);
} // End of the function
function e_nameNotFound(obj)
{
    $d("[" + obj.type + "] e_nameNotFound() -> Name not found");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(NAME_NOT_FOUND);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NAME_NOT_FOUND);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        LOGIN_HOLDER.gotoNewPlayer();
        Selection.setFocus("LOGIN_HOLDER.NP_USERNAME_INPUT");
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_passwordWrong(obj)
{
    $d("[" + obj.type + "] e_passwordWrong() -> Password wrong");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(PASSWORD_WRONG);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, PASSWORD_WRONG);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        Selection.setFocus("LOGIN_HOLDER.NP_PASSWORD_INPUT");
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_serverFull(obj)
{
    $d("[" + obj.type + "] e_serverFull() -> Password wrong");
    var _loc4 = window_size[WINDOW_SMALL];
    var _loc6 = getLocalizedErrorStringById(SERVER_FULL);
    var _loc3 = getLocalizedString("Okay");
    var _loc2 = buildErrorCodeString(obj.type, SERVER_FULL);
    if (obj.type == SOCKET_ERROR || obj.type == DEFAULT_ERROR_TYPE)
    {
        var _loc5 = function ()
        {
            getURL(getPath("client_web"), "_self");
        };
        showLoading();
        AIRTOWER.disconnect();
    }
    else
    {
        _loc5 = function ()
        {
            LOGIN_HOLDER.gotoWorldSelection();
            hideLoading();
            closeErrorPrompt();
        };
    } // end else if
    showErrorPrompt(_loc4, _loc6, _loc3, _loc5, _loc2);
} // End of the function
function e_passwordRequired(obj)
{
    $d("[" + obj.type + "] e_passwordRequired() -> Password required");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(PASSWORD_REQUIRED);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, PASSWORD_REQUIRED);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        Selection.setFocus("LOGIN_HOLDER.NP_PASSWORD_INPUT");
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_passwordShort(obj)
{
    $d("[" + obj.type + "] e_passwordShort() -> Password too short");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(PASSWORD_SHORT);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, PASSWORD_SHORT);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        Selection.setFocus("LOGIN_HOLDER.NP_PASSWORD_INPUT");
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_passwordLong(obj)
{
    $d("[" + obj.type + "] e_passwordLong() -> Password too short");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(PASSWORD_LONG);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, PASSWORD_LONG);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        Selection.setFocus("LOGIN_HOLDER.NP_PASSWORD_INPUT");
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_nameRequired(obj)
{
    $d("[" + obj.type + "] e_nameRequired() -> Name required");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(NAME_REQUIRED);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NAME_REQUIRED);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        Selection.setFocus("LOGIN_HOLDER.NP_USERNAME_INPUT");
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_nameShort(obj)
{
    $d("[" + obj.type + "] e_nameShort() -> Name too short");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(NAME_SHORT);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NAME_SHORT);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        Selection.setFocus("LOGIN_HOLDER.NP_USERNAME_INPUT");
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_nameLong(obj)
{
    $d("[" + obj.type + "] e_nameLong() -> Name too short");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(NAME_LONG);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NAME_LONG);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        Selection.setFocus("LOGIN_HOLDER.NP_USERNAME_INPUT");
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_loginFlooding(obj)
{
    $d("[SOCKET ERROR - " + LOGIN_FLOODING + "] e_loginFlooding() -> Login flooding limit reached");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(LOGIN_FLOODING);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, LOGIN_FLOODING);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        LOGIN_HOLDER.gotoNewPlayer();
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_playerInRoom(obj)
{
    $d("[" + obj.type + "] e_playerInRoom() -> Player in room");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(PLAYER_IN_ROOM);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, PLAYER_IN_ROOM);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
} // End of the function
function e_roomFull(obj)
{
    $d("[" + obj.type + "] e_roomFull() -> Room is full");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(ROOM_FULL);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, ROOM_FULL);
    var _loc4 = function ()
    {
        hideLoading();
        closeErrorPrompt();
        INTERFACE.showContent("map");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_roomCapacityRule(obj)
{
    $d("[" + obj.type + "] e_roomCapacityRule() -> Room is full");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(ROOM_FULL);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, ROOM_CAPACITY_RULE);
    var _loc4 = function ()
    {
        hideLoading();
        closeErrorPrompt();
        INTERFACE.showContent("map");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_roomCapacityRule(obj)
{
    $d("[" + obj.type + "] e_roomCapacityRule() -> Room is full");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(ROOM_FULL);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, ROOM_CAPACITY_RULE);
    var _loc4 = function ()
    {
        hideLoading();
        closeErrorPrompt();
        INTERFACE.showContent("map");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_gameFull(obj)
{
    $d("[" + obj.type + "] e_gameFull() -> Game is full");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(GAME_FULL);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, GAME_FULL);
    var _loc4 = function ()
    {
        hideLoading();
        closeErrorPrompt();
        INTERFACE.showContent("map");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_itemInHouse(obj)
{
    $d("[" + obj.type + "] e_itemInHouse() -> Already own this item");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(ITEM_IN_HOUSE);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, ITEM_IN_HOUSE);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
} // End of the function
function e_notEnoughCoins(obj)
{
    $d("[" + obj.type + "] e_notEnoughCoins() -> Not enough coins");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(NOT_ENOUGH_COINS);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NOT_ENOUGH_COINS);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
} // End of the function
function e_notEnoughMedals(obj)
{
    $d("[" + obj.type + "] e_notEnoughMedals() -> Not enough medals");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(NOT_ENOUGH_MEDALS);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NOT_ENOUGH_MEDALS);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
} // End of the function
function e_itemNotExist(obj)
{
    $d("[" + obj.type + "] e_itemNotExist() -> Item does not exist");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(ITEM_NOT_EXIST);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, ITEM_NOT_EXIST);
    var _loc4 = function ()
    {
        closeErrorPrompt();
        INTERFACE.closePrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_nameNotAllowed(obj)
{
    $d("[" + obj.type + "] e_nameNotAllowed() -> Name is not allowed");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(NAME_NOT_ALLOWED);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NAME_NOT_ALLOWED);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
    updateListeners(ADOPT_PUFFLE, {success: false});
} // End of the function
function e_puffleLimitMember(obj)
{
    $d("[" + obj.type + "] e_puffleLimitMember() -> Member puffle limit reached");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(PUFFLE_LIMIT_M);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, PUFFLE_LIMIT_M);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
    updateListeners(ADOPT_PUFFLE, {success: false});
} // End of the function
function e_puffleLimitNonMember(obj)
{
    $d("[" + obj.type + "] e_puffleLimitNonMember() -> Non member puffle limit reached");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(PUFFLE_LIMIT_NM);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, PUFFLE_LIMIT_NM);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
    updateListeners(ADOPT_PUFFLE, {success: false});
} // End of the function
function e_alreadyOwnIgloo(obj)
{
    $d("[" + obj.type + "] e_alreadyOwnIgloo()");
    INTERFACE.showPrompt("warn", getLocalizedString("duplicate_igloo_warn"));
} // End of the function
function e_banDuration(obj)
{
    $d("[" + obj.type + "] e_banDuration() -> Still have time left in ban");
    var _loc3 = Number(obj[1]);
    var _loc2 = getLocalizedString("hours");
    if (_loc3 == 1)
    {
        _loc2 = getLocalizedString("hour");
    } // end if
    var _loc1 = getLocalizedErrorStringById(BAN_DURATION);
    _loc1 = replace_m(_loc1, [_loc3, _loc2]);
    AIRTOWER.disconnect();
    var _loc7 = function ()
    {
        getURL(getPath("main_web"), "_self");
    };
    var _loc6 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedString("Okay");
    var _loc4 = buildErrorCodeString(obj.type, BAN_DURATION);
    showErrorPrompt(_loc6, _loc1, _loc5, _loc7, _loc4);
} // End of the function
function e_banAnHour(obj)
{
    $d("[" + obj.type + "] e_banAnHour() -> Still banned, but only minutes left");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(BAN_AN_HOUR);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, BAN_AN_HOUR);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("main_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_banForever(obj)
{
    $d("[" + obj.type + "] e_banForever() -> Player is banned forever");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(BAN_FOREVER);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, BAN_FOREVER);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("main_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_autoBan(obj)
{
    $d("[" + obj.type + "] e_autoBan() -> Auto banned");
    var _loc2 = obj[1];
    var _loc1 = getLocalizedErrorStringById(AUTO_BAN);
    _loc1 = replace("%badword%", _loc2, _loc1);
    var _loc5 = window_size[WINDOW_LARGE];
    var _loc4 = getLocalizedString("Okay");
    var _loc3 = buildErrorCodeString(obj.type, AUTO_BAN);
    AIRTOWER.disconnect();
    var _loc7 = function ()
    {
        getURL(getPath("main_web"), "_self");
    };
    showErrorPrompt(_loc5, _loc1, _loc4, _loc7, _loc3);
} // End of the function
function e_hackingAutoBan(obj)
{
    $d("[" + obj.type + "] e_hackingAutoBan() -> Hacking Auto banned");
    var _loc7 = obj[1];
    var _loc1 = getLocalizedErrorStringById(HACKING_AUTO_BAN);
    _loc1 = replace("%reason%", _loc7, _loc1);
    var _loc4 = window_size[WINDOW_LARGE];
    var _loc3 = getLocalizedString("Okay");
    var _loc2 = buildErrorCodeString(obj.type, HACKING_AUTO_BAN);
    AIRTOWER.disconnect();
    var _loc5 = function ()
    {
        getURL(getPath("main_web"), "_self");
    };
    showErrorPrompt(_loc4, _loc1, _loc3, _loc5, _loc2);
} // End of the function
function e_gameCheat(obj)
{
    $d("[" + obj.type + "] e_gameCheat() -> Game cheating detected");
    var _loc3 = window_size[WINDOW_LARGE];
    var _loc5 = getLocalizedErrorStringById(GAME_CHEAT);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, GAME_CHEAT);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("client_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_accountNotActive(obj)
{
    $d("[" + obj.type + "] e_accountNotActive() -> Account is not active");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(ACCOUNT_NOT_ACTIVATE);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, ACCOUNT_NOT_ACTIVATE);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        LOGIN_HOLDER.gotoNewPlayer();
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_buddyLimit(obj)
{
    $d("[" + obj.type + "] e_buddy_limit() -> Buddy limit reached");
    var _loc5 = MAX_BUDDY_COUNT;
    var _loc4 = window_size[WINDOW_SMALL];
    var _loc1 = getLocalizedErrorStringById(BUDDY_LIMIT);
    _loc1 = replace("%number%", String(_loc5), _loc1);
    var _loc3 = getLocalizedString("Okay");
    var _loc2 = buildErrorCodeString(obj.type, BUDDY_LIMIT);
    showErrorPrompt(_loc4, _loc1, _loc3, button_action, _loc2);
} // End of the function
function e_noPlayTime(obj)
{
    $d("[" + obj.type + "] e_noPlayTime() -> No playtime left for today");
    var _loc2 = "<a href=\"https://account.oasis.ps\">";
    var _loc6 = "</a>";
    var _loc1 = getLocalizedErrorStringById(NO_PLAY_TIME);
    _loc1 = replace_m(_loc1, [_loc2, _loc6]);
    var _loc5 = window_size[WINDOW_LARGE];
    var _loc4 = getLocalizedString("Okay");
    var _loc3 = buildErrorCodeString(obj.type, NO_PLAY_TIME);
    AIRTOWER.disconnect();
    var _loc7 = function ()
    {
        getURL("https://account.oasis.ps", "_self");
    };
    showErrorPrompt(_loc5, _loc1, _loc4, _loc7, _loc3);
} // End of the function
function e_outPlayTime(obj)
{
    $d("[" + obj.type + "] e_outPlayTime() -> Trying to play outside allowed hours");
    var _loc4 = convertToStandardTime(obj[1], ":", true);
    var _loc3 = convertToStandardTime(obj[2], ":", true);
    var _loc1 = getLocalizedErrorStringById(OUT_PLAY_TIME);
    _loc1 = replace_m(_loc1, [_loc4, _loc3]);
    var _loc7 = window_size[WINDOW_SMALL];
    var _loc6 = getLocalizedString("Okay");
    var _loc5 = buildErrorCodeString(obj.type, OUT_PLAY_TIME);
    AIRTOWER.disconnect();
    var _loc8 = function ()
    {
        getURL("https://account.oasis.ps", "_self");
    };
    showErrorPrompt(_loc7, _loc1, _loc6, _loc8, _loc5);
} // End of the function
function e_grounded(obj)
{
    $d("[" + obj.type + "] e_grounded() -> Trying to play while grounded");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(GROUNDED);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, GROUNDED);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        getURL(getPath("guide_web"), "_self");
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_playTimeOver(obj)
{
    $d("[" + obj.type + "] e_noPlayTime() -> No playtime left for today");
    var _loc6 = getPath("community_web");
    var _loc2 = "<a href=\"" + _loc6 + "\" target=\"_self\" >";
    var _loc7 = "</a>";
    var _loc1 = getLocalizedErrorStringById(PLAY_TIME_OVER);
    _loc1 = replace_m(_loc1, [_loc2, _loc7]);
    AIRTOWER.disconnect();
    var _loc5 = window_size[WINDOW_LARGE];
    var _loc4 = getLocalizedString("Okay");
    var _loc3 = buildErrorCodeString(obj.type, PLAY_TIME_OVER);
    var _loc8 = function ()
    {
        getURL(getPath("guide_web"), "_self");
    };
    showErrorPrompt(_loc5, _loc1, _loc4, _loc8, _loc3);
} // End of the function
function e_systemReboot(obj)
{
    $d("[" + obj.type + "] e_systemReboot() -> System is going to reboot in five minutes");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(SYSTEM_REBOOT);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, SYSTEM_REBOOT);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
} // End of the function
function e_notMember(obj)
{
    $d("[" + obj.type + "] e_notMember() -> You must be a member to complete this action");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedErrorStringById(NOT_MEMBER);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NOT_MEMBER);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
} // End of the function
function e_noDatabaseConnection(obj)
{
    $d("[" + obj.type + "] e_noDatabaseConnection() -> Could not establish a database connection");
    var _loc3 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedErrorStringById(NO_DATABASE_CONNECTION);
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, NO_DATABASE_CONNECTION);
    AIRTOWER.disconnect();
    var _loc4 = function ()
    {
        LOGIN_HOLDER.gotoStart();
        hideLoading();
        closeErrorPrompt();
    };
    showErrorPrompt(_loc3, _loc5, _loc2, _loc4, _loc1);
} // End of the function
function e_timeWarning(obj)
{
    $d("[" + obj.type + "] e_fiveMinuteWarning() -> Time warning: " + obj.minutes_left + " minutes left!");
    var _loc1 = getLocalizedErrorStringById(TIME_WARNING);
    _loc1 = replace("%number%", String(obj.minutes_left), _loc1);
    var _loc5 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedString("Okay");
    var _loc3 = buildErrorCodeString(obj.type, TIME_WARNING);
    showErrorPrompt(_loc5, _loc1, _loc4, button_action, _loc3);
} // End of the function
function e_passwordSavePrompt(obj)
{
    $d("[" + obj.type + "] e_passwordSavePrompt() -> Telling the user about the problems with saving their password");
    var _loc4 = getLocalizedErrorStringById(PASSWORD_SAVE_PROMPT);
    var _loc3 = window_size[WINDOW_EXTRA_LARGE];
    var _loc2 = getLocalizedString("Okay");
    var _loc1 = buildErrorCodeString(obj.type, PASSWORD_SAVE_PROMPT);
    showErrorPrompt(_loc3, _loc4, _loc2, button_action, _loc1);
} // End of the function
function e_loadError(obj)
{
    $d("[" + obj.type + "] e_loadError() -> Can not load file!");
    var _loc1 = obj.file_path;
    var _loc2 = _loc1.lastIndexOf("/");
    _loc1 = _loc1.substring(_loc2 + 1, _loc1.length);
    var _loc9 = _loc1.lastIndexOf(".swf");
    _loc1 = "-" + _loc1.substring(0, _loc9);
    var _loc7 = getLocalizedErrorStringById(LOAD_ERROR);
    var _loc5 = window_size[WINDOW_SMALL];
    var _loc4 = getLocalizedString("Okay");
    var _loc3 = buildErrorCodeString(obj.type, LOAD_ERROR, _loc1);
    AIRTOWER.disconnect();
    var _loc6 = function ()
    {
        getURL(getPath("client_web"), "_self");
    };
    showErrorPrompt(_loc5, _loc7, _loc4, _loc6, _loc3);
} // End of the function
function e_maxFurniture(obj)
{
    $d("[" + obj.type + "] e_maxFurniture() -> Max furniture!");
    var _loc1 = obj.file_path;
    var _loc3 = _loc1.lastIndexOf("/");
    _loc1 = _loc1.substring(_loc3 + 1, _loc1.length);
    var _loc7 = _loc1.lastIndexOf(".swf");
    _loc1 = "-" + _loc1.substring(0, _loc7);
    var _loc2 = getLocalizedErrorStringById(MAX_IGLOO_FURNITURE_ERROR);
    _loc2 = replace("%number%", MAX_IGLOO_ITEMS.toString(), _loc2);
    var _loc6 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedString("Okay");
    var _loc4 = buildErrorCodeString(obj.type, MAX_IGLOO_FURNITURE_ERROR);
    showErrorPrompt(_loc6, _loc2, _loc5, button_action, _loc4);
} // End of the function
function e_maxStampBookCoverItems(obj)
{
    $d("[" + obj.type + "] e_maxStampBookCoverItems() -> Max Stamp Book Cover Items!");
    var _loc1 = obj.file_path;
    var _loc3 = _loc1.lastIndexOf("/");
    _loc1 = _loc1.substring(_loc3 + 1, _loc1.length);
    var _loc7 = _loc1.lastIndexOf(".swf");
    _loc1 = "-" + _loc1.substring(0, _loc7);
    var _loc2 = getLocalizedErrorStringById(MAX_STAMPBOOK_COVER_ITEMS);
    _loc2 = replace("%number%", com.clubpenguin.stamps.StampManager.MAX_STAMPBOOK_COVER_ITEMS.toString(), _loc2);
    var _loc6 = window_size[WINDOW_SMALL];
    var _loc5 = getLocalizedString("Okay");
    var _loc4 = buildErrorCodeString(obj.type, MAX_STAMPBOOK_COVER_ITEMS);
    showErrorPrompt(_loc6, _loc2, _loc5, button_action, _loc4);
} // End of the function
function getErrorActionById(id)
{
    if (e_actions[id] != undefined)
    {
        return (e_actions[id]);
    } // end if
    return (e_actions[DEFAULT_ERROR]);
} // End of the function
function getErrorFunctionByErrorCode(error_code)
{
    var _loc1 = getErrorFunctionObject();
    if (!isNaN(error_code))
    {
        var _loc2 = _loc1[error_code];
        if (_loc2 != undefined)
        {
            return (_loc2);
        } // end if
        return (_loc1[DEFAULT_ERROR]);
    }
    else
    {
        $d("[shell] getErrorFunctionByErrorCode() -> Error Code is not a real number. error_code: " + error_code + " returning default error");
        return (_loc1[DEFAULT_ERROR]);
    } // end else if
} // End of the function
function getErrorFunctionObject()
{
    return (e_func);
} // End of the function
function buildErrorCodeString(type, error_code, additional_txt)
{
    if (isValidString(type))
    {
        if (!isNaN(error_code))
        {
            var _loc1;
            switch (type)
            {
                case SOCKET_ERROR:
                {
                    _loc1 = SOCKET_ERROR.substr(0, 1).toLowerCase();
                    break;
                } 
                case CLIENT_ERROR:
                {
                    _loc1 = CLIENT_ERROR.substr(0, 1).toLowerCase();
                    break;
                } 
                default:
                {
                    _loc1 = DEFAULT_ERROR_TYPE;
                    break;
                } 
            } // End of switch
            var _loc2 = "";
            if (isValidString(additional_txt))
            {
                _loc2 = additional_txt;
            } // end if
            return (_loc1 + "" + error_code + "" + _loc2);
        }
        else
        {
            $e("buildErrorCodeString() -> Error code is not a valid number! error_code: " + error_code + " Defaulting to default error");
            return (DEFAULT_ERROR_TYPE + "" + DEFAULT_ERROR_CODE + "" + _loc2);
        } // end else if
    }
    else
    {
        $e("buildErrorCodeString() -> Error type is not a valid string! error_type: " + _loc1 + " Defaulting to default error");
        return (DEFAULT_ERROR_TYPE + "" + DEFAULT_ERROR_CODE + "" + _loc2);
    } // end else if
} // End of the function
function setupErrorScreen(mc)
{
    error_cover = mc.attachMovie("errorCover", "errorCover", mc.getNextHighestDepth());
    error_cover._alpha = 40;
    error_window = mc.attachMovie("errorWindow", "errorWindow", mc.getNextHighestDepth());
    hideErrorPrompt();
} // End of the function
function $e(message, error_obj)
{
    if (DEBUG_MODE)
    {
    } // end if
    if (error_obj != undefined)
    {
        initErrorByObj(error_obj);
    } // end if
} // End of the function
function initErrorByCode(error_code, error_obj)
{
    if (getShellErrorsActive())
    {
        if (!isNaN(error_code))
        {
            var _loc2 = getErrorFunctionByErrorCode(error_code);
            _loc2(error_obj);
        }
        else
        {
            $e("[shell] initErrorByCode() -> Not a real number passed for error code. error_code: " + error_code);
        } // end if
    } // end else if
} // End of the function
function initErrorByObj(error_obj)
{
    error_obj.type = CLIENT_ERROR;
    initErrorByCode(error_obj.error_code, error_obj);
} // End of the function
function showErrorPrompt(window_size, message, button_lable, button_action, error_code)
{
    _global.getCurrentInterface().closePrompt();
    var _loc2 = error_window;
    _loc2._visible = false;
    _loc2.bg._height = window_size.h;
    _loc2.bg._width = window_size.w;
    _loc2._x = 380 - _loc2.bg._width / 2;
    _loc2._y = 240 - _loc2.bg._height / 2;
    var _loc3 = 25;
    _loc2.message_txt._height = _loc3;
    _loc2.message_txt.htmlText = message;
    var _loc4 = _loc2.message_txt.maxscroll;
    _loc2.message_txt._height = _loc3 * _loc4;
    _loc2.message_txt._width = _loc2.bg._width - 40;
    _loc2.message_txt._x = _loc2.bg._width / 2 - _loc2.message_txt._width / 2;
    _loc2.message_txt._y = (_loc2.bg._height - _loc2.error_btn._height) / 2 - _loc2.message_txt._height / 2;
    _loc2.error_txt.text = error_code;
    _loc2.error_txt._x = _loc2.bg._width - 12 - _loc2.error_txt._width;
    _loc2.error_txt._y = _loc2.bg._height - 28;
    MovieClip.prototype.tabEnabled = false;
    Button.prototype.tabEnabled = false;
    _loc2.error_btn.tabEnabled = true;
    _loc2.error_btn.label_txt.text = button_lable;
    if (button_action != undefined)
    {
        _loc2.error_btn.onRelease = function ()
        {
            delete MovieClip.prototype.tabEnabled;
            delete Button.prototype.tabEnabled;
            button_action();
        };
    }
    else
    {
        _loc2.error_btn.onRelease = function ()
        {
            delete MovieClip.prototype.tabEnabled;
            delete Button.prototype.tabEnabled;
            closeErrorPrompt();
        };
    } // end else if
    _loc2.error_btn._x = _loc2.bg._width / 2 - _loc2.error_btn._width / 2;
    _loc2.error_btn._y = _loc2.bg._height - 80;
    error_cover._visible = true;
    error_cover.onRelease = function ()
    {
    };
    error_cover.useHandCursor = false;
    _loc2._visible = true;
} // End of the function
function closeErrorPrompt()
{
    hideErrorPrompt();
} // End of the function
function hideErrorPrompt()
{
    error_window._visible = false;
    error_cover._visible = false;
    error_cover.onRelease = null;
    delete error_cover.onRelease;
    hideLightbox();
} // End of the function
function getLocalizedErrorStringById(id)
{
    var _loc1 = getLocalizedErrorObject();
    if (!isNaN(id))
    {
        var _loc3 = _loc1[id];
        if (isValidString(_loc3))
        {
            return (_loc3);
        }
        else
        {
            $e("[shell] getLocalizedErrorStringById() -> Was not able to find a valid string for error id \"" + id + "\" returning default error string instead.");
            return (_loc1[DEFAULT_ERROR]);
        } // end else if
    }
    else
    {
        $e("[shell] getLocalizedErrorStringById() -> Not a real number passed for id! id: " + id + " Returning default error string.");
        return (_loc1[DEFAULT_ERROR]);
    } // end else if
} // End of the function
function getLocalizedErrorObject()
{
    return (local_error_obj);
} // End of the function
function setLocalizedErrorObject(obj)
{
    local_error_obj = obj;
} // End of the function
function setShellErrorsActive(active)
{
    shell_errors_active = active;
} // End of the function
function getShellErrorsActive()
{
    return (shell_errors_active);
} // End of the function
function checkIfPlayerIsIdle()
{
    if (getLocalEpoch() - last_update >= idle_timeout)
    {
        $e("[shell] checkIfPlayerIsIdle() -> Penguin has been idle for " + idle_timeout + "ms", {error_code: TIME_OUT});
        stopPlayerIdleCheck();
        AIRTOWER.disconnect();
    } // end if
} // End of the function
function startPlayerIdleCheck()
{
    last_update = getLocalEpoch();
    attachIdleListeners();
    idle_interval = setInterval(checkIfPlayerIsIdle, idle_timeout_freq);
} // End of the function
function stopPlayerIdleCheck()
{
    removeIdleListeners();
    clearInterval(idle_interval);
} // End of the function
function attachIdleListeners()
{
    key_listener = new Object();
    key_listener.onKeyDown = setLastUpdate;
    Key.addListener(key_listener);
    mouse_listener = new Object();
    mouse_listener.onMouseDown = mouseClicked;
    Mouse.addListener(mouse_listener);
} // End of the function
function removeIdleListeners()
{
    Key.removeListener(key_listener);
    Mouse.removeListener(mouse_listener);
} // End of the function
function mouseClicked()
{
    if (SHELL.bg_mc.hitTest(_xmouse, _ymouse, false))
    {
        setLastUpdate();
    } // end if
} // End of the function
function setLastUpdate()
{
    last_update = getLocalEpoch();
} // End of the function
function $d(message)
{
    if (DEBUG_MODE)
    {
    } // end if
} // End of the function
function debugObject(obj, verbose)
{
    if (DEBUG_MODE)
    {
        dumpObject(obj);
    } // end if
    return ("");
} // End of the function
function dumpObject(obj, depth, out)
{
    if (DEBUG_MODE)
    {
        if (depth == undefined)
        {
            depth = 0;
        } // end if
        if (depth == 0)
        {
        } // end if
        var _loc8 = "";
        if (out != undefined)
        {
            _loc8 = out + ": ";
        } // end if
        var _loc1;
        var _loc4 = "";
        var _loc7 = "\t";
        var _loc6;
        for (var _loc5 = 0; _loc5 < depth; ++_loc5)
        {
            _loc4 = _loc4 + _loc7;
        } // end of for
        for (var _loc1 in obj)
        {
            _loc6 = typeof(obj[_loc1]);
            if (_loc6 != "object")
            {
                continue;
            } // end if
            dumpObject(obj[_loc1], depth + 1, _loc1);
        } // end of for...in
        if (obj == undefined)
        {
        } // end if
    } // end if
} // End of the function
function setupLoading(container)
{
    loading = container.attachMovie("loadingScreen", "loadingScreen", container.getNextHighestDepth());
} // End of the function
function showLoading(message, listener)
{
    isLoadingScreenVisible = true;
    loading.loader_outline_mc._visible = false;
    loading.loading.progressBar._visible = false;
    if (!loading._visible)
    {
        loading.spinner_mc.gotoAndPlay("load");
    } // end if
    if (listener != undefined)
    {
        loading.loader_outline_mc._visible = true;
        loading.loading.progressBar._visible = true;
        listener.onLoadProgress = loadingScreenLoadProgress;
    } // end if
    loading.message_txt.text = "";
    if (message != undefined)
    {
        loading.message_txt.text = message;
    } // end if
    loading.onRelease = function ()
    {
    };
    loading.useHandCursor = false;
    loading._visible = true;
    setPauseStampNotification(true);
} // End of the function
function showLoadingProgress(message, bytesLoaded, bytesTotal)
{
    isLoadingScreenVisible = true;
    loading.loader_outline_mc._visible = true;
    loading.loading.progressBar._visible = true;
    loading.onRelease = function ()
    {
    };
    loading.useHandCursor = false;
    if (message)
    {
        loading.message_txt.text = message + (!isNaN(Math.floor(bytesLoaded / bytesTotal * 100)) ? ("... " + Math.floor(bytesLoaded / bytesTotal * 100) + "%") : (""));
    }
    else
    {
        loading.message_txt.text = "Loading Oasis";
    } // end else if
    if (!loading._visible)
    {
        loading.spinner_mc.gotoAndPlay("load");
    } // end if
    loading.loading.progressBar._xscale = Math.floor(bytesLoaded / bytesTotal * 100);
    loading._visible = true;
    setPauseStampNotification(true);
} // End of the function
function hideLoading()
{
    if (isLoadingScreenVisible)
    {
        loading.spinner_mc.gotoAndStop("park");
        loading._visible = false;
        delete loading.onRelease;
        delete loading.useHandCursor;
        loading.message_txt.text = "";
        setPauseStampNotification(false);
        isLoadingScreenVisible = false;
    } // end if
} // End of the function
function loadingScreenLoadProgress(targetClip, bytesLoaded, bytesTotal)
{
    loading.loading.progressBar._xscale = Math.floor(bytesLoaded / bytesTotal * 100);
} // End of the function
function setupLightbox(mc)
{
    lightbox = mc.attachMovie("lightbox", "lightbox", mc.getNextHighestDepth());
} // End of the function
function showLightbox()
{
    lightbox._visible = true;
    lightbox.onRelease = function ()
    {
    };
    lightbox.useHandCursor = false;
} // End of the function
function hideLightbox()
{
    lightbox._visible = false;
    delete lightbox.onRelease;
} // End of the function
function closeGridView()
{
    close_func_holder();
} // End of the function
function startGridview(in_array, file_path, on_release, user_options)
{
    close_func_holder = user_options.on_close;
    user_options.on_close = closeGridView;
    GRIDVIEW.startGridview(in_array, file_path, on_release, user_options);
} // End of the function
function addListener(type, func, scope)
{
    if (type == undefined || func == undefined)
    {
        $e("[shell] addListener() -> You must pass a valid listener type and function! type: " + type + " func: " + func);
        return (false);
    } // end if
    var _loc2 = getListenersArray(type);
    var _loc3 = getListenerIndex(_loc2, func);
    if (_loc3 == -1)
    {
        $d("[shell] Successfully added listener to: \"" + type + "\"");
        _loc2.push({func: func, scope: scope});
        return (true);
    } // end if
    $d("[shell] Failed to add listener. Tried to add a duplicate listener to: \"" + type + "\"");
    return (false);
} // End of the function
function removeListener(type, func)
{
    var _loc2 = getListenersArray(type);
    var _loc1 = getListenerIndex(_loc2, func);
    if (_loc1 != -1)
    {
        $d("[shell] Successfully removed listener from: \"" + type + "\"");
        _loc2.splice(_loc1, 1);
        return (true);
    } // end if
    $d("[shell] Failed to remove listener which did not exist from: \"" + type + "\"");
    return (false);
} // End of the function
function getListenerIndex(array, func)
{
    var _loc2 = array.length;
    for (var _loc1 = 0; _loc1 < _loc2; ++_loc1)
    {
        if (array[_loc1].func == func)
        {
            return (_loc1);
        } // end if
    } // end of for
    return (-1);
} // End of the function
function updateListeners(type, obj)
{
    var _loc5 = false;
    if (obj.type == null)
    {
        obj.type = type;
        _loc5 = true;
    } // end if
    var _loc2 = getListenersArray(type);
    var _loc4 = _loc2.length;
    if (_loc4 < 1)
    {
        $d("[airtower] No listeners currently attached to: \"" + type + "\"");
        return (false);
    } // end if
    if (_loc4 == 1)
    {
        _loc2[0].scope ? (_loc2[0].func.call(_loc2[0].scope, obj)) : (_loc2[0].func(obj));
        return (true);
    } // end if
    for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
    {
        _loc2[_loc1].scope ? (_loc2[_loc1].func.call(_loc2[_loc1].scope, obj)) : (_loc2[_loc1].func(obj));
    } // end of for
    if (_loc5)
    {
        obj.type = null;
        delete object.type;
    } // end if
    return (true);
} // End of the function
function getListenersArray(type)
{
    if (shell_listener_container[type] == undefined)
    {
        shell_listener_container[type] = new Array();
    } // end if
    return (shell_listener_container[type]);
} // End of the function
function fetchFileContents(path, on_response)
{
    $d("fetchFileContents() -> path: " + path);
    var _loc1 = new LoadVars();
    _loc1.onLoad = on_response;
    _loc1.load(path);
} // End of the function
function loadSWF(mc, path, initFunction, startFunction, errorFunction, progressFunction, options)
{
    __holder = mc;
    __initFunction = initFunction;
    __path = path;
    __options = options != undefined ? (options) : ({});
    currently_loading_path = path;
    var _loc5 = new MovieClipLoader();
    var _loc2 = {};
    _loc2.onLoadStart = startFunction;
    _loc2.onLoadProgress = progressFunction;
    _loc2.onLoadInit = initFunction;
    _loc2.onLoadError = errorFunction;
    if (startFunction == undefined)
    {
        _loc2.onLoadStart = defaultLoadStart;
    } // end if
    if (progressFunction == undefined)
    {
        _loc2.onLoadProgress = loadingScreenLoadProgress;
    } // end if
    if (initFunction == undefined)
    {
        _loc2.onLoadInit = defaultLoadInit;
    } // end if
    if (errorFunction == undefined)
    {
        _loc2.onLoadError = defaultLoadError;
    } // end if
    if (!isValidString(path))
    {
        _loc2.onLoadError(mc, "URLNotFound", 0);
        return (_loc2);
    } // end if
    if (mc == undefined)
    {
        _loc2.onLoadError(mc, "INVALID MOVIECLIP", 0);
        return (_loc2);
    } // end if
    _loc5.addListener(_loc2);
    var _loc6 = com.clubpenguin.util.URLUtils.getCacheResetURL(path);
    if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3())
    {
        var _loc9 = __options.skipLoadChecking;
        var _loc7 = {skipLoadChecking: _loc9};
        var _loc14 = new com.clubpenguin.hybrid.AS3MovieClipLoader(this, mc, _loc6, _loc2.onLoadInit, _loc2.onLoadStart, _loc2.onLoadProgress, _loc2.onLoadError, _loc7);
    }
    else
    {
        _loc5.loadClip(_loc6, mc);
    } // end else if
    return (_loc2);
} // End of the function
function defaultLoadError(target_mc, errorCode, httpStatus)
{
    $e("[shell] defaultLoadError() -> \n\terror code: " + error_code + " \n\thttp_status: " + http_status + " \n\tpath: " + currently_loading_path, {error_code: LOAD_ERROR, file_path: currently_loading_path});
} // End of the function
function addToQueue(mc, id)
{
    load_queue.push(Array(mc, id));
} // End of the function
function startLoadQueue(on_init, on_error)
{
    var _loc1 = 0;
    var _loc2 = load_queue.length;
    while (_loc1 < _loc2)
    {
        loadSWF(load_queue[_loc1][0], load_queue[_loc1][1] + ".swf", on_init, null, on_error);
        ++_loc1;
    } // end while
    clearLoadQueue();
} // End of the function
function clearLoadQueue()
{
    load_queue = new Array();
} // End of the function
function setColourFromHex(mc, hex)
{
    var _loc1 = mc.transform.colorTransform;
    _loc1.rgb = Number(hex);
    mc.transform.colorTransform = _loc1;
} // End of the function
function fadeIn(mc, start_alpha, end_alpha, step, on_finish)
{
    mc._alpha = start_alpha;
    mc.onEnterFrame = function ()
    {
        mc._alpha = mc._alpha + step;
        if (mc._alpha >= end_alpha)
        {
            delete mc.onEnterFrame;
            if (on_finish != undefined)
            {
                on_finish(mc);
            } // end if
        } // end if
    };
} // End of the function
function isValidString(txt)
{
    if (txt.length < 1)
    {
        return (false);
    } // end if
    if (txt == "")
    {
        return (false);
    } // end if
    if (txt == undefined)
    {
        return (false);
    } // end if
    if (txt == null)
    {
        return (false);
    } // end if
    if (txt == "undefined")
    {
        return (false);
    } // end if
    return (true);
} // End of the function
function getRandomFromArray(how_many, in_array)
{
    var _loc4 = new Array();
    var _loc6 = in_array.length;
    var _loc1 = in_array.slice();
    if (how_many > _loc6)
    {
        how_many = _loc6;
        $d("getRandomFromArray() - Asking for more elements than what exist! how_many reset to the length of the array");
    } // end if
    var _loc3 = 0;
    var _loc2 = 0;
    while (_loc3 < how_many)
    {
        _loc2 = randBetween(0, _loc1.length - 1);
        _loc4.push(_loc1[_loc2]);
        _loc1.splice(_loc2, 1);
        _loc1.reverse();
        ++_loc3;
    } // end while
    return (_loc4);
} // End of the function
function randBetween(from, to)
{
    return (Math.round(Math.random() * (to - from)) + from);
} // End of the function
function ucFirst(str)
{
    return (str.substr(0, 1).toUpperCase() + str.substr(1, str.length));
} // End of the function
function toTitleCase(str)
{
    var _loc2 = str.split(" ");
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        _loc2[_loc1] = ucFirst(_loc2[_loc1]);
    } // end of for
    return (_loc2.join(" "));
} // End of the function
function paginateArray(in_array, page, items_on_page)
{
    var _loc2 = page * items_on_page;
    var _loc1 = _loc2 + items_on_page;
    if (_loc1 > in_array.length)
    {
        _loc1 = in_array.length;
    } // end if
    return (in_array.slice(_loc2, _loc1));
} // End of the function
function getCleanURL(url, target, disconnect)
{
    if (isValidString(url))
    {
        if (disconnect == undefined || disconnect == true)
        {
            AIRTOWER.disconnect();
        } // end if
        getURL(url, target);
    }
    else
    {
        $d("getCleanURL() - The URL passed was invalid: " + url);
    } // end else if
} // End of the function
function freezeCode(username, password)
{
    username = username + FREEZE_CODE_HASH;
    var _loc2 = [];
    var _loc4 = password.length;
    for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
    {
        _loc2[_loc1] = password.charCodeAt(_loc1) + username.charCodeAt(_loc1);
    } // end of for
    return (_loc2);
} // End of the function
function meltCode(username, password)
{
    username = username + FREEZE_CODE_HASH;
    var _loc2 = "";
    for (var _loc1 = 0; _loc1 < password.length; ++_loc1)
    {
        _loc2 = _loc2 + String.fromCharCode(password[_loc1] - username.charCodeAt(_loc1));
    } // end of for
    return (_loc2);
} // End of the function
function duplicateObject(object)
{
    var _loc2 = {};
    for (var _loc3 in object)
    {
        _loc2[_loc3] = object[_loc3];
    } // end of for...in
    return (_loc2);
} // End of the function
function getPenguinStandardTime(epoch)
{
    if (isNaN(epoch))
    {
        local_time = new Date();
    }
    else
    {
        local_time = new Date(epoch);
    } // end else if
    local_time.setHours(local_time.getHours() - calculated_timezone_offset);
    local_time.setTime(local_time.valueOf() - calculated_time_difference);
    return (local_time);
} // End of the function
function setupPenguinStandardTime(server_epoch)
{
    server_time = new Date(server_epoch);
    local_time = new Date();
    calculated_time_difference = local_time.valueOf() - server_time.valueOf();
    var _loc1 = local_time.getTimezoneOffset() / 60;
    calculated_timezone_offset = serverTimezoneOffset - _loc1;
} // End of the function
function getLocalEpoch()
{
    var _loc1 = new Date();
    return (_loc1.valueOf());
} // End of the function
function convertToStandardTime(military_time, delimiter, with_am_pm)
{
    if (isValidString(military_time))
    {
        if (isValidString(delimiter))
        {
            var _loc2 = military_time.split(delimiter);
            var _loc1 = Number(_loc2[0]);
            var _loc6 = String(_loc2[1]);
            var _loc3 = "";
            if (with_am_pm)
            {
                _loc3 = getLocalizedString("am");
                if (_loc1 >= 12)
                {
                    _loc3 = getLocalizedString("pm");
                } // end if
            } // end if
            if (_loc1 > 12)
            {
                _loc1 = _loc1 - 12;
            } // end if
            if (_loc1 != 0)
            {
                if (String(_loc1).indexOf("0") == 0)
                {
                    _loc1 = Number(String(_loc1).substr(1, 1));
                } // end if
            }
            else
            {
                _loc1 = 12;
            } // end else if
            _loc2[0] = _loc1;
            _loc2[1] = _loc6;
            _loc2.splice(2);
            return (_loc2.join(delimiter) + _loc3);
        }
        else
        {
            $d("[shell] convertToStandardTime() -> Not a valid string passed for delimiter! delimeter: " + delimiter);
        } // end else if
    }
    else
    {
        $d("[shell] convertToStandardTime() -> Not a valid string passed for time! time: " + military_time);
    } // end else if
    return (military_time);
} // End of the function
function convertMinutesToMilliseconds(min)
{
    return (Math.round(min * ONE_MINUTE_IN_MILLISECONDS));
} // End of the function
function convertMillisecondsToMinutes(mill)
{
    return (Math.round(mill / ONE_MINUTE_IN_MILLISECONDS));
} // End of the function
function convertMillisecondsToSeconds(mill)
{
    return (Math.round(mill * ONE_SECOND_IN_MILLISECONDS));
} // End of the function
function convertMillisecondsToDays(mill)
{
    return (Math.round(mill / ONE_DAY_IN_MILLISECONDS));
} // End of the function
function checkDelay(delay_obj)
{
    var _loc2 = delay_obj.last_timestamp;
    var _loc1 = delay_obj.interval;
    if (!isNaN(_loc2))
    {
        if (!isNaN(_loc1))
        {
            var _loc3 = getLocalEpoch();
            var _loc4 = _loc3 - _loc2;
            if (_loc4 > _loc1)
            {
                delay_obj.last_timestamp = _loc3;
                return (true);
            } // end if
            return (false);
        }
        else
        {
            $e("[shell] checkDelay() -> wait time is not a real number! wait_time: " + _loc1);
        } // end else if
    }
    else
    {
        $e("[shell] checkDelay() -> last timestamp is not a real number! last_timestamp: " + _loc2);
    } // end else if
} // End of the function
function startEggTimer()
{
    if (getEggTimerMinutesRemaining() == MINUTES_IN_DAY)
    {
        setIsEggTimerActive(false);
        return;
    } // end if
    setIsEggTimerActive(true);
    egg_timer_interval = setInterval(calculateEggTimer, ONE_MINUTE_IN_MILLISECONDS);
} // End of the function
function calculateEggTimer()
{
    egg_timer_milliseconds_remaining = egg_timer_milliseconds_remaining - ONE_MINUTE_IN_MILLISECONDS;
    if (egg_timer_milliseconds_remaining == FIVE_MINUTES_IN_MILLISECONDS)
    {
        $e("[shell] calculateEggTimer() -> Egg timer five minute warning!", {error_code: TIME_WARNING, minutes_left: 5});
    } // end if
    if (egg_timer_milliseconds_remaining <= 0)
    {
        clearInterval(egg_timer_interval);
        AIRTOWER.disconnect();
        $e("[shell] calculateEggTimer() -> Egg timer out of time.", {error_code: NO_PLAY_TIME});
    } // end if
    var _loc1 = Object();
    _loc1.minutes_remaining = convertMillisecondsToMinutes(egg_timer_milliseconds_remaining);
    updateListeners(UPDATE_EGG_TIMER, _loc1);
} // End of the function
function isEggTimerActive()
{
    return (is_egg_timer_active);
} // End of the function
function setIsEggTimerActive(is_active)
{
    is_egg_timer_active = is_active;
} // End of the function
function getEggTimerMinutesRemaining()
{
    return (convertMillisecondsToMinutes(egg_timer_milliseconds_remaining));
} // End of the function
function setEggTimerMinutesRemaining(min)
{
    egg_timer_milliseconds_remaining = convertMinutesToMilliseconds(min);
} // End of the function
function sendJoinGame(game_name)
{
    if (getCurrentGameRoomId() == undefined)
    {
        var _loc1 = getGameCrumbsByName(game_name);
        var _loc2 = 0;
        var _loc3 = 0;
        if (_loc1 != undefined)
        {
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.NAVIGATION + "#" + AIRTOWER.JOIN_ROOM, [_loc1.room_id, _loc2, _loc3], "str", getCurrentServerRoomId());
        }
        else
        {
            $e("[shell] sendJoinGame() -> Tried to join a game which did not exist. game_name: " + game_name);
        } // end else if
    }
    else
    {
        $e("[shell] sendJoinRoom() -> Tried to join a room while in a game room!", {error_code: PLAYER_IN_ROOM});
    } // end else if
} // End of the function
function getGameCrumbsById(id)
{
    var _loc1 = getGameCrumbs();
    for (var _loc3 in _loc1)
    {
        if (_loc1[_loc3].room_id == id)
        {
            return (_loc1[_loc3]);
        } // end if
    } // end of for...in
    $e("[shell] getGameCrumbsById() -> Could not find the game in the crumbs. id: " + id);
    return;
} // End of the function
function getGameCrumbsKeyById(id)
{
    var _loc1 = getGameCrumbs();
    for (var _loc3 in _loc1)
    {
        if (_loc1[_loc3].room_id == id)
        {
            return (String(_loc3));
        } // end if
    } // end of for...in
    $e("[shell] getGameCrumbsById() -> Could not find the game in the crumbs. id: " + id);
    return;
} // End of the function
function getGameCrumbsByName(name)
{
    var _loc1 = getGameCrumbs()[name];
    if (_loc1 == undefined)
    {
        $e("[shell] getGameCrumbsByName() -> Could not find the game in the crumbs. name: " + name);
    } // end if
    return (_loc1);
} // End of the function
function sendGameOver(score)
{
    if (!isNaN(score))
    {
        if (score >= 0 && score < MAX_GAME_SCORE)
        {
            AIRTOWER.send(AIRTOWER.GAME_EXT, AIRTOWER.GAME_OVER, [score], "str", getCurrentServerRoomId());
        }
        else
        {
            var _loc3 = getMyPlayerTotalCoins();
            var _loc1 = new Object();
            _loc1.total = _loc3;
            _loc1.earned = 0;
            _loc1.is_table = false;
            updateListeners(GAME_OVER, _loc1);
        } // end else if
    }
    else
    {
        $e("[game] sendGameOver() -> Score is not a valid number");
    } // end else if
} // End of the function
function startGameMusic()
{
    var _loc2 = getCurrentRoomId();
    var _loc1 = getGameCrumbsById(_loc2);
    if (_loc1.music_id != undefined)
    {
        startMusicById(_loc1.music_id);
    }
    else
    {
        $e("[shell] startGameMusic() -> Could not find the music ID in the game crumbs. music_id: " + room.music_id);
    } // end else if
} // End of the function
function stopGameMusic()
{
    stopMusic();
} // End of the function
function getGameObject()
{
    return (my_game);
} // End of the function
function getGameCrumbs()
{
    return (game_crumbs);
} // End of the function
function setGameCrumbs(obj)
{
    var _loc2;
    for (var _loc2 in obj)
    {
        obj[_loc2].path = getGamesPath() + obj[_loc2].path;
    } // end of for...in
    game_crumbs = obj;
} // End of the function
function setPhoneGameCrumbs(crumbs)
{
    phoneGameCrumbs = crumbs;
} // End of the function
function getPhoneGameCrumbs()
{
    return (phoneGameCrumbs);
} // End of the function
function getTablesPopulationById(arr)
{
    if (arr.length > 0)
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.TABLE_HANDLER + "#" + AIRTOWER.GET_TABLE_POPULATION, arr, "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] getTablesPopulationById()");
    } // end else if
} // End of the function
function sendJoinTableById(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.TABLE_HANDLER + "#" + AIRTOWER.JOIN_TABLE, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] joinTableById() -> Id was not a real number: " + id);
    } // end else if
} // End of the function
function sendLeaveTable()
{
    if (getCurrentGameRoomId() != undefined)
    {
        setCurrentGameRoomId(undefined);
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.TABLE_HANDLER + "#" + AIRTOWER.LEAVE_TABLE, [], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] joinTableById() -> Id was not a real number: " + id);
    } // end else if
} // End of the function
function setCurrentGameRoomId(id)
{
    game_room_smart_id = id;
} // End of the function
function getCurrentGameRoomId()
{
    return (game_room_smart_id);
} // End of the function
function updateWaddleList(waddle_id, seat, nickname)
{
    if (!isNaN(waddle_id))
    {
        if (!isValidString(nickname))
        {
            nickname = undefined;
        } // end if
        var _loc2 = getWaddleById(waddle_id);
        if (_loc2 == undefined)
        {
            var _loc5 = getWaddleList();
            _loc5[waddle_id] = new Object();
            _loc2 = getWaddleById(waddle_id);
            _loc2.player_list = new Array();
        } // end if
        if (_loc2 != undefined)
        {
            _loc2.waddle_id = Number(waddle_id);
            if (!isNaN(seat))
            {
                _loc2.player_list[seat] = nickname;
            }
            else
            {
                var _loc3 = _loc2.player_list.length;
                for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
                {
                    _loc2.player_list[_loc1] = undefined;
                } // end of for
            } // end else if
        }
        else
        {
            $e("[shell] updateWaddleList() -> Could not get Waddle. It is undefined! waddle_id: " + waddle_id);
        } // end else if
    }
    else
    {
        $e("[shell] updateWaddleList() -> Waddle id is not a real number! waddle_id: " + waddle_id);
    } // end else if
} // End of the function
function startWaddle(obj)
{
    var _loc3 = obj.shift();
    var _loc1 = new Array();
    _loc1.push(Number(obj[0]));
    _loc1.push(Number(obj[1]));
    _loc1.push(Number(obj[2]));
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.WADDLE + "#" + AIRTOWER.SEND_WADDLE, _loc1, "str", getCurrentServerRoomId());
} // End of the function
function getWaddlePopulationById(arr)
{
    if (arr.length > 0)
    {
        AIRTOWER.send(AIRTOWER.GAME_EXT, AIRTOWER.GET_WADDLE_POPULATION, arr, "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] getWaddlePopulationById()");
    } // end else if
} // End of the function
function sendJoinWaddleById(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.GAME_EXT, AIRTOWER.JOIN_WADDLE, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendJoinWaddleById() -> Id was not a real number: " + id);
    } // end else if
} // End of the function
function sendLeaveWaddle()
{
    AIRTOWER.send(AIRTOWER.GAME_EXT, AIRTOWER.LEAVE_WADDLE, [], "str", getCurrentServerRoomId());
} // End of the function
function getWaddleList()
{
    return (waddle_list);
} // End of the function
function setWaddleList(arr)
{
    waddle_list = arr;
} // End of the function
function getWaddleById(id)
{
    if (!isNaN(id))
    {
        var _loc2 = getWaddleList();
        if (_loc2[id] != undefined)
        {
            return (_loc2[id]);
        } // end if
        $e("[shell] getWaddleById() -> Waddle is undefined: waddle_id: " + id);
        return;
    }
    else
    {
        $e("[shell] getWaddleById() -> Id was not a real number: " + id);
    } // end else if
    return;
} // End of the function
function setCurrentServerRoomId(id)
{
    current_server_room_id = id;
    if (!visitedThisRoom(id))
    {
        roomIds_visited.push(id);
    } // end if
} // End of the function
function visitedThisRoom(rommId)
{
    for (var _loc1 = 0; _loc1 < roomIds_visited.length; ++_loc1)
    {
        if (roomIds_visited[_loc1] == rommId)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function getCurrentServerRoomId()
{
    if (isSnowball)
    {
        return (980);
    } // end if
    if (current_server_room_id != undefined)
    {
        return (current_server_room_id);
    } // end if
    return (-1);
} // End of the function
function setCurrentCrumbRoomId(id)
{
    current_crumb_room_id = id;
} // End of the function
function getCurrentCrumbRoomId()
{
    if (current_crumb_room_id != undefined)
    {
        return (current_crumb_room_id);
    } // end if
    return (-1);
} // End of the function
function getRoomCrumbsById(id)
{
    var _loc1 = getRoomCrumbs();
    for (var _loc3 in _loc1)
    {
        if (_loc1[_loc3].room_id == id)
        {
            return (_loc1[_loc3]);
        } // end if
    } // end of for...in
    $e("[shell] getRoomCrumbsById() -> Could not find the room in the crumbs. id: " + id);
    return;
} // End of the function
function isPlayerMemberById(id)
{
    var _loc2 = getPlayerList();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == id)
        {
            return (_loc2[_loc1].is_member);
        } // end if
    } // end of for
    $e("[shell] isPlayerMemberById() -> Player id not found in room. player_id: " + player_id);
    return;
} // End of the function
function getNicknameById(player_id)
{
    var _loc5 = playerIndexInRoom(player_id);
    var _loc2 = getPlayerList();
    if (_loc5 != -1)
    {
        var _loc4 = _loc2.length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            if (_loc2[_loc1].player_id == player_id)
            {
                return (_loc2[_loc1].nickname);
            } // end if
        } // end of for
    }
    else
    {
        $e("[shell] getPlayerNameFromId() -> Player id not found in room. player_id: " + player_id);
    } // end else if
} // End of the function
function getRoomCrumbsByName(name)
{
    var _loc1 = getRoomCrumbs();
    for (var _loc3 in _loc1)
    {
        if (_loc3 == name)
        {
            return (_loc1[_loc3]);
        } // end if
    } // end of for...in
    $e("[shell] getRoomCrumbsByName() -> Could not find the room in the crumbs. name: " + name);
    return;
} // End of the function
function getRoomNameById(id)
{
    var _loc1 = getRoomCrumbs();
    for (var _loc3 in _loc1)
    {
        if (_loc1[_loc3].room_id == id)
        {
            return (_loc3);
        } // end if
    } // end of for...in
    $e("[shell] getRoomNameById() -> Could not find the room in the crumbs. id: " + id);
    return;
} // End of the function
function sendJoinRoom(room_name, xpos, ypos)
{
    if (getCurrentGameRoomId() == undefined)
    {
        var _loc2 = getRoomCrumbsByName(room_name);
        if (_loc2.is_member && !isMyPlayerMember())
        {
            var _loc5 = _global.getCurrentInterface();
            _loc5.showContent("oops_" + _loc2.name + "_room");
            return;
        } // end if
        if (getCurrentRoomId() != _loc2.room_id)
        {
            if (_loc2 != undefined)
            {
                last_known_xpos = getMyPlayer().x;
                last_known_ypos = getMyPlayer().y;
                if (isNaN(xpos))
                {
                    xpos = 0;
                } // end if
                if (isNaN(ypos))
                {
                    ypos = 0;
                } // end if
                showLoading(getLocalizedString("Joining") + " " + getLocalizedString(room_name));
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.NAVIGATION + "#" + AIRTOWER.JOIN_ROOM, [_loc2.room_id, xpos, ypos], "str", getCurrentServerRoomId());
            }
            else
            {
                $e("[shell] sendJoinRoom() -> Tried to join a room which did not exist in crumbs. room_name: " + room_name);
            } // end else if
        }
        else
        {
            $e("[shell] sendJoinRoom() -> Tried to join a room which your already in!: room_id: " + _loc2.room_id);
        } // end else if
    }
    else
    {
        $e("[shell] sendJoinRoom() -> Tried to join a room while in a game room!", {error_code: PLAYER_IN_ROOM});
    } // end else if
} // End of the function
function startRoomMusic()
{
    var _loc1;
    if (getIsRoomIgloo())
    {
        _loc1 = getIglooMusicId();
    }
    else
    {
        var _loc2 = getCurrentCrumbRoomId();
        var _loc3 = getRoomCrumbsById(_loc2);
        _loc1 = _loc3.music_id;
    } // end else if
    if (_loc1 != undefined)
    {
        startMusicById(_loc1);
    }
    else
    {
        $e("[shell] startRoomMusic() -> Could not find the music ID in the room crumbs. musicId: " + _loc1);
    } // end else if
} // End of the function
function getMusicURL(musicID)
{
    musicID = Number(musicID);
    if (isNaN(musicID) || musicID <= 0)
    {
        return ("");
    } // end if
    return (getPath("music") + musicID + ".swf");
} // End of the function
function startMusicById(musicID)
{
    var _loc1 = getMusicURL(musicID);
    MUSIC.playMusicURL(_loc1);
} // End of the function
function stopMusic()
{
    MUSIC.stopMusic();
} // End of the function
function setCurrentRoomId(room_id)
{
    current_room_id = room_id;
    if (!visitedThisRoom(room_id))
    {
        roomIds_visited.push(room_id);
    } // end if
} // End of the function
function getLastRoomId()
{
    return (last_room_id);
} // End of the function
function setLastRoomId(room_id)
{
    last_room_id = room_id;
} // End of the function
function getCurrentRoomId()
{
    return (current_room_id);
} // End of the function
function sendJoinLastRoom()
{
    if (getCurrentGameRoomId() == undefined)
    {
        var _loc1 = 0;
        var _loc2 = 0;
        if (getLastRoomId() != undefined)
        {
            if (!isNaN(last_known_xpos))
            {
                _loc1 = last_known_xpos;
            } // end if
            if (!isNaN(last_known_ypos))
            {
                _loc2 = last_known_ypos;
            } // end if
            var _loc3 = getLastRoomId();
            var _loc4 = getRoomNameById(_loc3);
            sendJoinRoom(_loc4, _loc1, _loc2);
        }
        else
        {
            $e("[shell] sendJoinLastRoom() -> Last room is undefined.");
        } // end else if
    }
    else
    {
        $e("[shell] sendJoinRoom() -> Tried to join a room while in a game room!", {error_code: PLAYER_IN_ROOM});
    } // end else if
} // End of the function
function getRoomObject()
{
    var _loc1 = getCurrentRoomId();
    return (getRoomCrumbsById(_loc1));
} // End of the function
function getPlayerObjectFromRoomById(player_id)
{
    var _loc1 = playerIndexInRoom(player_id);
    var _loc2 = getPlayerList();
    if (_loc1 != -1)
    {
        return (_loc2[_loc1]);
    } // end if
    return;
} // End of the function
function sendRemoveClothes()
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#uprac", [], "str", getCurrentServerRoomId());
} // End of the function
function sendUpdatePlayerColourById(id)
{
    if (player_colours[id] == undefined)
    {
        return (false);
    } // end if
    id = player_colours[id].split("0x").join("");
    id = String(id);
    if (id.length != 3 && id.length != 6)
    {
        return (false);
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_COLOUR, [id], "str", getCurrentServerRoomId());
} // End of the function
function sendUpdatePlayerColour(id)
{
    id = String(id);
    if (id.length != 3 && id.length != 6)
    {
        return (false);
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_COLOUR, [id], "str", getCurrentServerRoomId());
} // End of the function
function sendUpdatePlayerHead(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_HEAD, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayerHead() -> Not a real number passed for id! id:" + id);
    } // end else if
} // End of the function
function sendUpdatePlayerFace(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_FACE, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayerFace() -> Not a real number passed for id! id:" + id);
    } // end else if
} // End of the function
function sendUpdatePlayerNeck(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_NECK, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayerNeck() -> Not a real number passed for id! id:" + id);
    } // end else if
} // End of the function
function sendUpdatePlayerBody(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_BODY, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayerBody() -> Not a real number passed for id! id:" + id);
    } // end else if
} // End of the function
function sendUpdatePlayerHand(id)
{
    $d("[shell] sendUpdatePlayerHand() -> id: " + id);
    if (!isNaN(id))
    {
        puffleManager.stopAllPufflesWalking();
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_HAND, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayerHand() -> Not a real number passed for id! id:" + id);
    } // end else if
} // End of the function
function sendUpdatePlayerFeet(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_FEET, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayerFeet() -> Not a real number passed for id! id:" + id);
    } // end else if
} // End of the function
function sendUpdatePlayerFlag(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_FLAG, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayerFlag() -> Not a real number passed for id! id:" + id);
    } // end else if
} // End of the function
function sendUpdatePlayerPhoto(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_PHOTO, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayerPhoto() -> Not a real number passed for id! id:" + id);
    } // end else if
} // End of the function
function sendClearPaperdoll()
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SETTING_HANDLER + "#" + AIRTOWER.UPDATE_PLAYER_REMOVE, [], "str", getCurrentServerRoomId());
} // End of the function
function addPuffleToHand(puffleType)
{
    var _loc1 = com.clubpenguin.shell.PuffleManager.PUFFLE_INVENTORY_ID + puffleType;
    sendUpdatePlayerHand(_loc1);
} // End of the function
function sendPlayerMove(xpos, ypos)
{
    if (!isNaN(xpos) && !isNaN(ypos))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.PLAYER_MOVE, [xpos, ypos], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendPlayerMove() -> NaN - xpos: " + xpos + " ypos: " + ypos);
    } // end else if
} // End of the function
function roomInitiated()
{
    updateListeners(ROOM_INITIATED, undefined);
} // End of the function
function roomDestroyed()
{
    updateListeners(ROOM_DESTROYED, undefined);
} // End of the function
function sendPlayerMoveDone(player_id)
{
    if (!isNaN(player_id))
    {
        var _loc2 = getPlayerObjectFromRoomById(player_id);
        if (_loc2 != undefined)
        {
            updateListeners(PLAYER_MOVE_DONE, _loc2);
        }
        else
        {
            $d("[shell] sendPlayerMoveDone() -> Player object was not found in room! " + player_id);
            updateListeners(PLAYER_MOVE_DONE, undefined);
        } // end else if
    }
    else
    {
        $d("[shell] sendPlayerMoveDone() -> Player id is not a real number! player_id: " + player_id);
        updateListeners(PLAYER_MOVE_DONE, undefined);
    } // end else if
} // End of the function
function sendPlayerFrame(frame_num)
{
    if (!isNaN(frame_num))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.PLAYER_FRAME, [frame_num], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendPlayerFrame() -> NaN - frame_number: " + frame_num);
    } // end else if
} // End of the function
function sendPlayerAction(frame_num)
{
    if (!isNaN(frame_num))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.PLAYER_ACTION, [frame_num], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendUpdatePlayer() -> NaN - frame_number: " + frame_num);
    } // end else if
} // End of the function
function getPlayersInRoomCount()
{
    return (room_player_list.length);
} // End of the function
function getPlayerList()
{
    return (room_player_list);
} // End of the function
function setPlayerList(arr)
{
    room_player_list = arr;
} // End of the function
function getSortedPlayerList()
{
    return (getPlayerList().sortOn(["nickname"], [Array.CASEINSENSITIVE]));
} // End of the function
function playerIndexInRoom(player_id)
{
    var _loc2 = getPlayerList();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == player_id)
        {
            return (_loc1);
        } // end if
    } // end of for
    return (-1);
} // End of the function
function setRoomCrumbs(obj)
{
    var _loc1;
    for (var _loc1 in obj)
    {
        obj[_loc1].path = getGlobalContentPath() + "rooms/" + obj[_loc1].path;
        obj[_loc1].name = _loc1;
    } // end of for...in
    room_crumbs = obj;
} // End of the function
function getRoomCrumbs()
{
    return (room_crumbs);
} // End of the function
function sendGetCoinReward()
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.ROOM_HANDLER + "#" + AIRTOWER.COIN_DIG_UPDATE, [], "str", getCurrentServerRoomId());
} // End of the function
function sendUpdateMood(mood)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, "iCP#umo", [mood], "str", getCurrentServerRoomId());
} // End of the function
function setNewspaperPaths(obj)
{
    var _loc1;
    for (var _loc1 in obj)
    {
        addLocalPath(_loc1, obj[_loc1]);
    } // end of for...in
} // End of the function
function setNewspaperCrumbs(obj)
{
    news_crumbs = obj;
} // End of the function
function getNewsCrumbs()
{
    return (news_crumbs);
} // End of the function
function getPostcardById()
{
} // End of the function
function getPostcardCrumbs()
{
    return (postcard_crumbs);
} // End of the function
function getPostcardsByCategory(category)
{
    if (isValidString(category))
    {
        var _loc1 = getPostcardCrumbs()[category];
        if (_loc1 != undefined)
        {
            var _loc3 = new Array();
            var _loc2;
            for (var _loc2 in _loc1)
            {
                if (_loc1[_loc2].in_catalog)
                {
                    _loc3.push(_loc1[_loc2]);
                } // end if
            } // end of for...in
            _loc3.reverse();
            return (_loc3);
        }
        else
        {
            $e("getPostcardsByCategory() -> No postcards found in that category! category: " + category);
        } // end else if
    }
    else
    {
        $e("getPostcardsByCategory() -> Not a valid string passed for category type! category: " + category);
    } // end else if
    return;
} // End of the function
function getPostcardCategoryList()
{
    return (postcard_category_list);
} // End of the function
function setPostcardCategoryList(obj)
{
    var _loc2 = new Array();
    var _loc1;
    for (var _loc1 in obj)
    {
        _loc2.push(_loc1);
    } // end of for...in
    _loc2.reverse();
    postcard_category_list = _loc2;
} // End of the function
function setPostcardsCategory(obj)
{
    var _loc1;
    var _loc2;
    for (var _loc1 in obj)
    {
        for (var _loc2 in obj[_loc1])
        {
            obj[_loc1][_loc2].category = _loc1;
            obj[_loc1][_loc2].id = _loc2;
        } // end of for...in
    } // end of for...in
} // End of the function
function setPostcardCount(obj)
{
    var _loc3 = 0;
    var _loc1;
    var _loc4;
    for (var _loc1 in obj)
    {
        for (var _loc4 in obj[_loc1])
        {
            ++_loc3;
        } // end of for...in
    } // end of for...in
    postcard_count = _loc3;
} // End of the function
function buildPostcardFlatArray(obj)
{
    var _loc4 = new Array();
    var _loc1;
    var _loc3;
    for (var _loc1 in obj)
    {
        for (var _loc3 in obj[_loc1])
        {
            _loc4.push(obj[_loc1][_loc3]);
        } // end of for...in
    } // end of for...in
    setPostcardFlatArray(_loc4);
} // End of the function
function setPostcardFlatArray(arr)
{
    postcard_flat_arr = arr;
} // End of the function
function getPostcardFlatArray()
{
    return (postcard_flat_arr);
} // End of the function
function getPostcardMaxPages(pcs_per_page)
{
    var _loc3 = getPostcardCategoryList();
    var _loc4 = _loc3.length;
    var _loc1 = 0;
    var _loc2 = 0;
    while (_loc1 < _loc4)
    {
        _loc2 = _loc2 + getPagesPerCategory(_loc3[_loc1], pcs_per_page);
        ++_loc1;
    } // end while
    return (_loc2);
} // End of the function
function getPagesPerCategory(cat, pcs_per_page)
{
    var _loc1 = getPostcardsByCategory(cat);
    return (Math.ceil(_loc1.length / pcs_per_page));
} // End of the function
function getPostcardCategoryMaxPages(category_name, pcs_per_page)
{
    var _loc1 = getPostcardsByCategory(category_name);
    return (Math.ceil(_loc1.length / pcs_per_page));
} // End of the function
function getPostcardCount()
{
    return (postcard_count);
} // End of the function
function setPostcardCrumbs(obj)
{
    postcard_crumbs = obj;
    setPostcardsCategory(postcard_crumbs);
    setPostcardCount(postcard_crumbs);
    buildPostcardFlatArray(postcard_crumbs);
    setPostcardCategoryList(postcard_crumbs);
} // End of the function
function getMyPlayerHex()
{
    var _loc1 = getMyPlayerObject();
    if (_loc1.colour_id.substr(0, 2) != "0x")
    {
        return ("0x" + _loc1.colour_id);
    } // end if
    return (_loc1.colour_id);
} // End of the function
function setMyPlayerHexById(id)
{
    id = String(id);
    var _loc1 = getMyPlayerObject();
    var _loc3 = _loc1.colour_id;
    if (_loc3 != id)
    {
        _loc1.colour_id = id;
    } // end if
    return (_loc1.colour_id);
} // End of the function
function setMyPlayerId(id)
{
    my_player.player_id = id;
} // End of the function
function getMyPlayerId()
{
    return (my_player.player_id);
} // End of the function
function setPlayerMembershipStatusCookie()
{
    if (my_player == undefined || my_player.is_member == undefined)
    {
        return;
    } // end if
    flash.external.ExternalInterface.call(SET_COOKIE_METHOD, MEMBERSHIP_STATUS_COOKIE_NAME, my_player.is_member ? (MEMBER_COOKIE_VALUE) : (NON_MEMBER_COOKIE_VALUE), MEMBERSHIP_STATUS_COOKIE_EXPIRY_IN_DAYS);
} // End of the function
function sendOpenBook()
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.TOY_HANDLER + "#" + AIRTOWER.OPEN_BOOK, [1, 1], "str", getCurrentServerRoomId());
} // End of the function
function sendCloseBook(_biString)
{
    var _loc1 = "";
    if (_biString)
    {
        _loc1 = _biString;
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.TOY_HANDLER + "#" + AIRTOWER.CLOSE_BOOK, [1, _loc1], "str", getCurrentServerRoomId());
} // End of the function
function setMyServerBall(ballType)
{
    if (!isNaN(ballType))
    {
        AIRTOWER.send(AIRTOWER.GAME_EXT, "setball", [ballType], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] setMyServerBall() -> NaN - ballType: " + ballType);
    } // end else if
} // End of the function
function sendThrowBall(xpos, ypos)
{
    if (!isNaN(xpos) && !isNaN(ypos))
    {
        if (isSnowball)
        {
            AIRTOWER.send(AIRTOWER.GAME_EXT, "throw", [xpos, ypos], "str", getCurrentServerRoomId());
        }
        else
        {
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.THROW_BALL, [xpos, ypos], "str", getCurrentServerRoomId());
        } // end else if
    }
    else
    {
        $e("[shell] sendThrowBall() -> NaN - xpos: " + xpos + " ypos: " + ypos);
    } // end else if
} // End of the function
function getMyPlayerObject()
{
    return (my_player);
} // End of the function
function isMyPlayer(player_id)
{
    if (getMyPlayerId() == player_id)
    {
        return (true);
    } // end if
    return (false);
} // End of the function
function flashExternalCall(func, arg1)
{
    flash.external.ExternalInterface.call(func, arg1);
} // End of the function
function parseJson($json)
{
    if ($json.substr(0, 1) != "{")
    {
        return;
    } // end if
    var _loc1 = com.clubpenguin.util.JSONParser.parse($json);
    return (_loc1);
} // End of the function
function healMe()
{
    AIRTOWER.send(AIRTOWER.GAME_EXT, "heal", [], "str", getCurrentServerRoomId());
} // End of the function
function toggleGlobalSounds()
{
    if (isMuted)
    {
        isMuted = !isMuted;
        INTERFACE.sendBotMessage("Un-muting...");
        MUSIC.unMuteMusic();
        startRoomMusic();
        globalVolume.setVolume(100);
    }
    else
    {
        isMuted = !isMuted;
        INTERFACE.sendBotMessage("Muting...");
        MUSIC.muteMusic();
        stopMusic();
        globalVolume.setVolume(0);
    } // end else if
} // End of the function
function makePlayerObjectFromString(player_string)
{
    var _loc3 = player_string.split("|");
    var _loc5 = Number(_loc3[0]);
    var _loc7 = String(_loc3[1]);
    var _loc9 = Number(_loc3[2]);
    var _loc8;
    if (isValidString(_loc7))
    {
        _loc8 = com.clubpenguin.util.Localization.getLocalizedNickname(_loc5, _loc7, _loc9, getLanguageBitmask());
    }
    else if (isPlayerMascotById(_loc5))
    {
        _loc8 = getMascotNicknameByID(_loc5);
    } // end else if
    var _loc1 = new Object();
    _loc1.nickname = _loc8;
    _loc1.username = _loc7;
    _loc1.player_id = _loc5;
    _loc1.colour_id = String(_loc3[3]) || 0;
    _loc1.head = Number(_loc3[4]) || 0;
    _loc1.face = Number(_loc3[5]) || 0;
    _loc1.neck = Number(_loc3[6]) || 0;
    _loc1.body = Number(_loc3[7]) || 0;
    _loc1.hand = Number(_loc3[8]) || 0;
    _loc1.feet = Number(_loc3[9]) || 0;
    _loc1.flag_id = Number(_loc3[10]) || 0;
    _loc1.photo_id = Number(_loc3[11]) || 0;
    var _loc4 = ["head", "face", "neck", "body", "hand", "feet"];
    for (var _loc6 in _loc4)
    {
        var _loc2 = Number(_loc1[_loc4[_loc6]]);
        if (_loc2 == 0)
        {
            continue;
        } // end if
        if (banned_items[_loc2] != undefined)
        {
            _loc1[_loc4[_loc6]] = 0;
        } // end if
        if (banned_items[String(_loc2)] != undefined)
        {
            _loc1[_loc4[_loc6]] = 0;
        } // end if
    } // end of for...in
    _loc1.x = Number(_loc3[12]) || 0;
    _loc1.y = Number(_loc3[13]) || 0;
    _loc1.frame = Number(_loc3[14]) || 0;
    _loc1.is_member = Boolean(Number(_loc3[15]) || 0);
    _loc1.total_membership_days = Number(_loc3[16]) || 0;
    if (!isSnowball)
    {
        _loc1.playercard_attributes = parseJson(_loc3[19]);
        _loc1.account_permissions = _loc3[20];
        _loc1.char_permissions = _loc3[21];
        _loc1.player_attributes = parseJson(_loc3[22]);
        _loc1.ia = Boolean(Number(_loc3[23]));
        _loc1.credits = Number(_loc3[24]);
        _loc1.characterId = String(_loc3[25]);
    }
    else
    {
        _loc1.size_decrease = Number(_loc3[19]);
        _loc1.alpha = Number(_loc3[20]);
    } // end else if
    _loc1.frame_hack = buildFrameHacksString(_loc1);
    _loc1.thrownSnowballInCurrentRoom = false;
    _loc1.emoteIDDisplayedInCurrentRoom = -1;
    _loc1.data = _loc3;
    return (_loc1);
} // End of the function
function updatePlayerObjectFromString(player, string)
{
    var _loc1 = makePlayerObjectFromString(string);
    for (var _loc2 in _loc1)
    {
        player[_loc2] = _loc1[_loc2];
    } // end of for...in
} // End of the function
function getPlayerObjectById(player_id)
{
    if (!isNaN(player_id))
    {
        var _loc1;
        _loc1 = getPlayerObjectFromRoomById(player_id);
        if (_loc1 != undefined)
        {
            return (_loc1);
        } // end if
        _loc1 = getPlayerObjectFromCacheById(player_id);
        if (_loc1 != undefined)
        {
            addPlayerToCache(_loc1);
            return (_loc1);
        } // end if
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.GET_PLAYER_OBJECT, [player_id], "str", getCurrentServerRoomId());
        return;
    }
    else
    {
        $e("[shell] getPlayerObjectById() -> Not a real number passed for player id. player_id: " + player_id);
    } // end else if
} // End of the function
function getPlayerObjectByNickname(nickname)
{
    if (!nickname.length)
    {
        $e("[SHELL] getPlayerObjectByNickname() -> Invalid String passed in for player nickname: " + nickname);
    } // end if
    var _loc2 = getPlayerList();
    var _loc3 = _loc2.length;
    var _loc1;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].nickname == nickname)
        {
            return (_loc2[_loc1]);
        } // end if
    } // end of for
    _loc2 = getPlayerCache();
    _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].nickname == nickname)
        {
            return (_loc2[_loc1]);
        } // end if
    } // end of for
    return (null);
} // End of the function
function addPlayerToCache(player_obj)
{
    var _loc2 = player_obj.player_id;
    if (!isNaN(_loc2))
    {
        if (_loc2 != getMyPlayerId())
        {
            var _loc1 = getPlayerCache();
            var _loc4;
            var _loc3 = getPlayerIndexInCacheById(_loc2);
            if (_loc3 != -1)
            {
                _loc1.splice(_loc3, 1);
            } // end if
            _loc1.unshift(player_obj);
            _loc4 = _loc1.length;
            if (_loc4 > MAX_PLAYERS_IN_CACHE)
            {
                _loc1.splice(MAX_PLAYERS_IN_CACHE);
            } // end if
        }
        else
        {
            $d("[shell] addPlayerToCache() -> Local player not added to cache");
        } // end else if
    }
    else
    {
        $e("[shell] addPlayerToCache() -> Player id is not a real number. player_id: " + _loc2);
    } // end else if
} // End of the function
function removePlayerFromCacheById(player_id)
{
    if (!isNaN(player_id))
    {
        var _loc2 = getPlayerIndexInCacheById(player_id);
        if (_loc2 != -1)
        {
            player_cache.splice(_loc2, 1);
        }
        else
        {
            $d("[shell] removePlayerFromCacheById() -> Player was not found in the cache, could not remove. player_id: " + player_id);
        } // end else if
    }
    else
    {
        $e("[shell] removePlayerFromCacheById() -> Player id is not a valid id. player_id: " + player_id);
    } // end else if
} // End of the function
function getPlayerObjectFromCacheById(player_id)
{
    var _loc2 = getPlayerCache();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == player_id)
        {
            return (_loc2[_loc1]);
        } // end if
    } // end of for
    return;
} // End of the function
function getPlayerIndexInCacheById(player_id)
{
    var _loc2 = getPlayerCache();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == player_id)
        {
            return (_loc1);
        } // end if
    } // end of for
    return (-1);
} // End of the function
function isItemOnMyPlayer(item_id)
{
    if (!isNaN(item_id))
    {
        var _loc2 = getPlayerObjectFromRoomById(getMyPlayerId());
        var _loc1;
        for (var _loc1 in _loc2)
        {
            switch (_loc1)
            {
                case "head":
                {
                    if (_loc2[_loc1] == item_id)
                    {
                        return (true);
                    } // end if
                } 
                case "face":
                {
                    if (_loc2[_loc1] == item_id)
                    {
                        return (true);
                    } // end if
                } 
                case "neck":
                {
                    if (_loc2[_loc1] == item_id)
                    {
                        return (true);
                    } // end if
                } 
                case "body":
                {
                    if (_loc2[_loc1] == item_id)
                    {
                        return (true);
                    } // end if
                } 
                case "hand":
                {
                    if (_loc2[_loc1] == item_id)
                    {
                        return (true);
                    } // end if
                } 
                case "feet":
                {
                    if (_loc2[_loc1] == item_id)
                    {
                        return (true);
                    } // end if
                } 
                case "flag_id":
                {
                    if (_loc2[_loc1] == item_id)
                    {
                        return (true);
                    } // end if
                } 
                case "photo_id":
                {
                    if (_loc2[_loc1] != item_id)
                    {
                        break;
                    } // end if
                    return (true);
                } 
            } // End of switch
        } // end of for...in
    }
    else
    {
        $e("[shell] isItemOnMyPlayer() -> item id is not a real number! item_id: " + item_id);
    } // end else if
    return (false);
} // End of the function
function sendBuySnowballitem()
{
    if (browsingItem != -1)
    {
        AIRTOWER.send(AIRTOWER.GAME_EXT, "buy", [browsingItem], "str", getCurrentServerRoomId());
        return;
    } // end if
} // End of the function
function sendEPFPhoneRequest()
{
    if (!epfPhoneRequested)
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.ITEM_HANDLER + "#" + AIRTOWER.BUY_INVENTORY, [8009], "str", getCurrentServerRoomId());
        epfPhoneRequested = true;
        return;
    } // end if
} // End of the function
function getPlayerCache()
{
    return (player_cache);
} // End of the function
function isMyPlayerMember()
{
    return (my_player.is_member);
} // End of the function
function setMyPlayerTotalCoins(amount)
{
    if (!isNaN(amount))
    {
        my_player.coins = amount;
        var _loc1 = new Object();
        _loc1.coins = my_player.coins;
        updateListeners(UPDATE_COINS, _loc1);
    }
    else
    {
        $e("[shell] setMyPlayerCoins() -> Amount is not a real number: " + amount);
    } // end else if
} // End of the function
function getMyPlayerTotalCoins()
{
    return (my_player.coins);
} // End of the function
function setMyPlayerSafemode(is_safemode)
{
    my_player.is_safemode = is_safemode;
} // End of the function
function isMyPlayerSafeMode()
{
    return (my_player.is_safemode);
} // End of the function
function getMyPlayerNickname()
{
    return (my_player.nickname);
} // End of the function
function getMyPlayerUsername()
{
    return (my_player.username);
} // End of the function
function setMyPlayerDaysOld(days_old)
{
    my_player.created_date = days_old;
} // End of the function
function getMyPlayerDaysOld()
{
    return (my_player.created_date);
} // End of the function
function setMyPlayerBannedAge(date_epoch)
{
    my_player.banned_age = date_epoch;
} // End of the function
function getMyPlayerBannedAge()
{
    return (my_player.banned_age);
} // End of the function
function setSecondsPlayed(sec)
{
    seconds_played = sec;
} // End of the function
function getSecondsPlayed()
{
    return (seconds_played);
} // End of the function
function setMinutesPlayed(mins)
{
    minutes_played = mins;
} // End of the function
function getMinutesPlayed()
{
    return (minutes_played);
} // End of the function
function setMembershipDaysRemaining(days)
{
    membership_days_remaining = days;
} // End of the function
function getMembershipDaysRemaining()
{
    return (membership_days_remaining);
} // End of the function
function setupEPFPlayerData()
{
    epfService.__get__agentStatusReceived().add(onAgentStatusReceived, this);
    epfService.__get__fieldOpStatusReceived().add(onFieldOpStatusReceived, this);
    epfService.getAgentStatus();
} // End of the function
function onAgentStatusReceived(isEPFAgent)
{
    playerAgentStatusChanged.dispatch(isEPFAgent);
    my_player.isEPFAgent = isEPFAgent;
} // End of the function
function onFieldOpStatusReceived(fieldOpStatus)
{
    my_player.fieldOpStatus = fieldOpStatus;
} // End of the function
function isEPFAgent()
{
    return (my_player.isEPFAgent);
} // End of the function
function isEPFRecruit()
{
    return (inbox.getPostCardsByTypeID(EPFSystemPostCardID).length > 0 || inbox.getPostCardsByTypeID(EPFPlayerPostCardID).length > 0);
} // End of the function
function getPlayerEPFStatusChanged()
{
    return (playerAgentStatusChanged);
} // End of the function
function sendRelationshipRequest(type, pid)
{
    if (type == "bff")
    {
        return (AIRTOWER.send(AIRTOWER.PLAY_EXT, "relationship#request", [type, pid], "str", getCurrentServerRoomId()));
    } // end if
    if (type == "marriage")
    {
        return (AIRTOWER.send(AIRTOWER.PLAY_EXT, "relationship#request", [type, pid], "str", getCurrentServerRoomId()));
    } // end if
} // End of the function
function sendNewPM(id, confirm_key)
{
    return (AIRTOWER.send(AIRTOWER.PLAY_EXT, "oasis#transmit", [id, confirm_key], "str", getCurrentServerRoomId()));
} // End of the function
function sendTransform(id)
{
    return (AIRTOWER.send(AIRTOWER.PLAY_EXT, "oasis#transform", [id], "str", getCurrentServerRoomId()));
} // End of the function
function sendNewLike(id)
{
    return (AIRTOWER.send(AIRTOWER.PLAY_EXT, "oasis#like", [id], "str", getCurrentServerRoomId()));
} // End of the function
function removeLike(id)
{
    return (AIRTOWER.send(AIRTOWER.PLAY_EXT, "like#delete", [id], "str", getCurrentServerRoomId()));
} // End of the function
function resetLike(id)
{
    return (AIRTOWER.send(AIRTOWER.PLAY_EXT, "like#truncate", [id], "str", getCurrentServerRoomId()));
} // End of the function
function sendDivorceRequest()
{
    return (AIRTOWER.send(AIRTOWER.PLAY_EXT, "relationship#divorce", [], "str", getCurrentServerRoomId()));
} // End of the function
function acceptRelationshipRequest()
{
    if (REL.requestID != undefined && !isNaN(REL.requestID))
    {
        INTERFACE.RELATIONSHIP_ICON._visible = false;
        AIRTOWER.send(AIRTOWER.PLAY_EXT, "relationship#accept", [REL.relationshipType, REL.requestID, REL.requestName, REL.dataKey], "str", getCurrentServerRoomId());
        REL = new Array();
    } // end if
} // End of the function
function setMyPlayerTotalCredits(amount)
{
    if (!isNaN(amount))
    {
        my_player.credits = Number(amount);
        var _loc1 = new Object();
        _loc1.credits = Number(my_player.credits);
        updateListeners(UPDATE_CREDITS, _loc1);
    }
    else
    {
        $e("[shell] setMyPlayerCoins() -> Amount is not a real number: " + amount);
    } // end else if
} // End of the function
function getMyPlayerTotalCredits()
{
    return (my_player.credits);
} // End of the function
function getIsSnowballMonster(player_id, returnMonsterId)
{
    if (player_id == 6403)
    {
        flash.external.ExternalInterface.call("console.debug", player_id);
        flash.external.ExternalInterface.call("console.debug", _global._configuration.tuning.snowball.monsters);
        flash.external.ExternalInterface.call("console.debug", _global._configuration.tuning.snowball);
        flash.external.ExternalInterface.call("console.debug", _global._configuration.tuning);
    } // end if
    if (_global._configuration.tuning.snowball.monsters[Number(player_id)] != undefined)
    {
        return (returnMonsterId == true ? (_global._configuration.tuning.snowball.monsters[Number(player_id)]) : (true));
    } // end if
    return (false);
} // End of the function
function getMySnowballServerInfo()
{
    showLoading("Loading Snowball Info");
    AIRTOWER.send(AIRTOWER.GAME_EXT, "gmsi", [], "str", getCurrentServerRoomId());
} // End of the function
function getMyInventoryList()
{
    showLoading(getLocalizedString("Loading Your Inventory"));
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.ITEM_HANDLER + "#" + AIRTOWER.GET_INVENTORY_LIST, [], "str", getCurrentServerRoomId());
} // End of the function
function getInventoryObjectById(id)
{
    var _loc1 = getInventoryCrumbsObject();
    if (_loc1[id] != undefined)
    {
        return (_loc1[id]);
    } // end if
    $e("[shell] getInventoryObjectById() -> Inventory id was not found in the crumbs, so it was not added to player inventory. Inventory Id: " + id);
    return;
} // End of the function
function getInventoryTypeById(id)
{
    if (isInventoryInCrumbs(id))
    {
        var _loc2 = getInventoryCrumbsObject();
        return (_loc2[id].type);
    }
    else
    {
        $e("[shell] getInventoryTypeById() -> Inventory id was not found in the crumbs. Inventory Id: " + id);
        return;
    } // end else if
} // End of the function
function isInventoryInCrumbs(id)
{
    var _loc1 = getInventoryCrumbsObject();
    var _loc4 = _loc1[id];
    var _loc2;
    for (var _loc2 in _loc1)
    {
        if (_loc1[_loc2].id == id)
        {
            return (true);
        } // end if
    } // end of for...in
    return (false);
} // End of the function
function isInventoryMemberOnly(id)
{
    if (!isNaN(id))
    {
        if (isInventoryInCrumbs(id))
        {
            var _loc3 = getInventoryCrumbsObject();
            var _loc2 = _loc3[id];
            return (_loc2.is_member);
        }
        else
        {
            $e("[shell] isInventoryMemberOnly() -> Inventory id was not found in the crumbs. Inventory Id: " + id);
        } // end else if
    }
    else
    {
        $e("[shell] isInventoryMemberOnly() -> Id was not a valid number: " + id);
    } // end else if
} // End of the function
function isMyPlayerTourGuide()
{
    var _loc2 = getMyInventoryArray();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].make_tour_guide == true)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function isMyPlayerSecretAgent()
{
    var _loc2 = getMyInventoryArray();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].make_secret_agent == true)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function isItemInMyInventory(id)
{
    if (!isNaN(id))
    {
        var _loc2 = getMyInventoryArray();
        var _loc4 = _loc2.length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            if (_loc2[_loc1].id == id)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    }
    else
    {
        $e("[shell] isItemInMyInventory() -> Id was not a valid number: " + id);
    } // end else if
} // End of the function
function sendBuyInventory(id)
{
    if (!isNaN(id))
    {
        if (isInventoryInCrumbs(id))
        {
            var _loc4 = getInventoryCrumbsObject();
            var _loc3 = _loc4[id];
            if (_loc3.is_member && !isMyPlayerMember())
            {
                var _loc2 = new Object();
                _loc2.item_id = id;
                _loc2.success = false;
                _loc2.player_id = getMyPlayerId();
                updateListeners(BUY_INVENTORY, _loc2);
                $d("[shell] sendBuyInventory() -> Trying to buy a member item when not a member. Item id: " + id);
            }
            else
            {
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.ITEM_HANDLER + "#" + AIRTOWER.BUY_INVENTORY, [id], "str", getCurrentServerRoomId());
            } // end else if
        }
        else
        {
            $e("[shell] sendBuyInventory() -> Inventory id was not found in the crumbs. Inventory Id: " + id);
        } // end else if
    }
    else
    {
        $e("[shell] sendBuyInventory() -> Id was not a real number: " + id);
    } // end else if
} // End of the function
function sendCheckInventory(itemID, playerID)
{
    if (isNaN(itemID) || isNaN(playerID))
    {
        $e("[shell] sendCheckInventory() -> invalid item or player ID. (itemID:" + itemID + ", playerID:" + playerID + ")");
        return;
    } // end if
    if (!isInventoryInCrumbs(itemID))
    {
        $e("[shell] sendCheckInventory() -> item ID not found in crumbs. (itemID:" + itemID + ", playerID:" + playerID + ")");
        return;
    } // end if
    if (playerID == getMyPlayerId())
    {
        var _loc3;
        if (isItemInMyInventory(itemID))
        {
            _loc3 = "1";
        }
        else
        {
            _loc3 = "0";
        } // end else if
        handleCheckInventory([0, itemID, playerID, _loc3]);
        return;
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.ITEM_HANDLER + "#" + AIRTOWER.CHECK_INVENTORY, [itemID, playerID], "str", getCurrentServerRoomId());
} // End of the function
function addItemToInventory(itemID)
{
    var _loc1 = {success: false, message: null, item_id: itemID, player_id: getMyPlayerId()};
    var _loc2 = getInventoryObjectById(itemID);
    var _loc3 = getMyInventoryArray();
    if (!isItemInMyInventory(itemID))
    {
        _loc1.success = true;
        _loc3.push(_loc2);
    }
    else
    {
        _loc1.success = false;
        _loc1.message = "trying to add a duplicate item to player inventory";
        $d("[shell] handleBuyInventory() -> " + _loc1.message);
    } // end else if
    updateListeners(BUY_INVENTORY, _loc1);
    return (_loc1);
} // End of the function
function sendDeleteItem(itemid)
{
    if (isNaN(itemid))
    {
        return (false);
    } // end if
    removeItemFromInventory(itemid);
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.ITEM_HANDLER + "#" + "rifi", [itemid], "str", getCurrentServerRoomId());
} // End of the function
function removeItemFromInventory(itemID)
{
    var _loc2 = inventory_arr.length;
    for (var _loc1 = 0; _loc1 < _loc2; ++_loc1)
    {
        if (inventory_arr[_loc1].id == itemID)
        {
            inventory_arr.splice(_loc1, 1);
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function setInventoryCrumbsObject(obj)
{
    var _loc3 = getLocalizedCrumbsObject();
    var _loc1;
    for (var _loc1 in obj)
    {
        obj[_loc1].id = Number(_loc1);
        obj[_loc1].name = _loc3[_loc1].name;
    } // end of for...in
    deleteLocalizedCrumbsObject();
    inventory_crumbs = obj;
} // End of the function
function getInventoryCrumbsObject()
{
    return (inventory_crumbs);
} // End of the function
function setLocalizedCrumbsObject(obj)
{
    localized_inventory_crumbs = obj;
} // End of the function
function getLocalizedCrumbsObject()
{
    return (localized_inventory_crumbs);
} // End of the function
function deleteLocalizedCrumbsObject()
{
    localized_inventory_crumbs = undefined;
} // End of the function
function getMyInventoryArray()
{
    return (inventory_arr);
} // End of the function
function setMyInventoryArray(arr)
{
    inventory_arr.length = 0;
    for (var _loc1 = 0; _loc1 < arr.length; ++_loc1)
    {
        inventory_arr.push(arr[_loc1]);
    } // end of for
} // End of the function
function getMySortedInventoryArray()
{
    return (inventory_arr.sortOn(["type", "id"], [Array.CASEINSENSITIVE, Array.DESCENDING]));
} // End of the function
function setPlayerColoursObject(obj)
{
    player_colours = obj;
} // End of the function
function getPlayerColoursObject()
{
    return (player_colours);
} // End of the function
function getPlayerHexFromId(id)
{
    if (id.substr(0, 2) != "0x")
    {
        return ("0x" + String(id));
    } // end if
    return (String(id));
} // End of the function
function setFrameHackCrumbs(obj)
{
    frame_hacks = new Object();
    var _loc1;
    var _loc3;
    var _loc6;
    var _loc5;
    for (var _loc1 in obj)
    {
        frame_hacks[_loc1] = new Object();
        var _loc4;
        for (var _loc4 in obj[_loc1])
        {
            _loc3 = obj[_loc1][_loc4];
            _loc5 = buildFrameHacksString(_loc3);
            frame_hacks[_loc1][_loc5] = _loc3.secret_frame;
        } // end of for...in
    } // end of for...in
    for (i in obj)
    {
        delete obj[i];
    } // end of for...in
} // End of the function
function buildFrameHacksString(obj)
{
    var _loc1 = new Array();
    var _loc4 = Number(obj.head);
    var _loc7 = Number(obj.face);
    var _loc3 = Number(obj.neck);
    var _loc2 = Number(obj.body);
    var _loc6 = Number(obj.hand);
    var _loc5 = Number(obj.feet);
    if (_loc4 > 10000)
    {
        _loc4 = _loc4 - 10000;
    } // end if
    if (_loc7 > 10000)
    {
        _loc7 = _loc7 - 10000;
    } // end if
    if (_loc3 > 10000)
    {
        _loc3 = _loc3 - 10000;
    } // end if
    if (_loc2 > 10000)
    {
        _loc2 = _loc2 - 10000;
    } // end if
    if (_loc6 > 10000)
    {
        _loc6 = _loc6 - 10000;
    } // end if
    if (_loc5 > 10000)
    {
        _loc5 = _loc5 - 10000;
    } // end if
    _loc1.push(_loc4);
    _loc1.push(_loc7);
    _loc1.push(_loc3);
    _loc1.push(_loc2);
    _loc1.push(_loc6);
    _loc1.push(_loc5);
    return (_loc1.join("|"));
} // End of the function
function getSecretFrame(player_id, frame)
{
    if (!isNaN(player_id))
    {
        if (!isNaN(frame))
        {
            var _loc3 = getPlayerObjectById(player_id);
            var _loc4 = getFrameHackCrumbs()[frame];
            if (_loc4[_loc3.frame_hack] != undefined)
            {
                return (_loc4[_loc3.frame_hack]);
            } // end if
        }
        else
        {
            $e("[shell] getSecretFrame() -> Not a real number passed for frame! frame: " + frame);
        } // end else if
    }
    else
    {
        $e("[shell] getSecretFrame() -> Not a real number passed for player_id! player_id: " + player_id);
    } // end else if
    $d("[shell] getSecretFrame() -> Could not find a frame hack! player_id: " + player_id + " frame: " + frame);
    return (frame);
} // End of the function
function getFrameHackCrumbs()
{
    return (frame_hacks);
} // End of the function
function getFurnitureListFromServer()
{
    var _loc1 = getFurnitureList();
    if (_loc1 == undefined)
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.GET_FURNITURE_LIST, [], "str", getCurrentServerRoomId());
    }
    else
    {
        updateListeners(GET_FURNITURE_LIST, _loc1);
    } // end else if
} // End of the function
function setAvailableCounts()
{
    var _loc3 = getFurnitureList();
    var _loc4 = getPlayerIglooFurniture();
    var _loc6 = _loc3.length;
    var _loc5 = _loc4.length;
    var _loc2 = 0;
    var _loc1 = 0;
    while (_loc2 < _loc6)
    {
        for (var _loc1 = 0; _loc1 < _loc5; ++_loc1)
        {
            if (_loc3[_loc2].item_id == _loc4[_loc1].item_id)
            {
                --_loc3[_loc2].available;
            } // end if
        } // end of for
        ++_loc2;
    } // end while
} // End of the function
function sendBuyFurniture(id)
{
    if (!isNaN(id))
    {
        if (isFurnitureInCrumbs(id))
        {
            var _loc3 = getFurnitureCrumbsObject();
            var _loc4 = _loc3[id];
            if (!isMyPlayerMember())
            {
                var _loc2 = new Object();
                _loc2.item_id = id;
                _loc2.success = false;
                _loc2.player_id = SHELL.getMyPlayerId();
                updateListeners(BUY_FURNITURE, _loc2);
                $d("[shell] sendBuyFurniture() -> You have to be a member to buy furniture!");
            }
            else
            {
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.BUY_FURNITURE, [id], "str", getCurrentServerRoomId());
            } // end else if
        }
        else
        {
            $e("[shell] sendBuyFurniture() -> Inventory id was not found in the crumbs. Inventory Id: " + id);
        } // end else if
    }
    else
    {
        $e("[shell] sendBuyFurniture() -> Id was not a real number: " + id);
    } // end else if
} // End of the function
function getFurnitureTypeById(id)
{
    if (!isNaN(id))
    {
        var _loc1 = getFurnitureFromCrumbsById(id);
        if (_loc1 != undefined)
        {
            return (_loc1.type);
        }
        else
        {
            $e("[shell] getFurnitureTypeById() -> Furniture object is undefined! item_id: " + id);
            return;
        } // end else if
    }
    else
    {
        $e("[shell] getFurnitureTypeById() -> Not a real number for furniture ");
    } // end else if
} // End of the function
function getFurnitureByType(type)
{
    if (!isNaN(type))
    {
        var _loc2 = getSortedFurnitureList();
        var _loc3 = new Array();
        var _loc4 = _loc2.length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            if (_loc2[_loc1].sort == type)
            {
                _loc3.push(_loc2[_loc1]);
            } // end if
        } // end of for
        return (_loc3);
    }
    else
    {
        $e("[shell] getFurnitureByType() -> Not a real number for type! type: " + type);
    } // end else if
} // End of the function
function getFurnitureFromCrumbsById(id)
{
    if (!isNaN(id))
    {
        var _loc3 = getFurnitureCrumbsObject();
        var _loc2 = _loc3[id];
        if (_loc2 != undefined)
        {
            return (_loc2);
        }
        else
        {
            $e("[shell] getFurnitureFromCrumbsById() -> Could not find item in crumbs! item_id: " + id);
            return;
        } // end else if
    }
    else
    {
        $e("[shell] getFurnitureFromCrumbsById() -> Id is not a real number. item_id: " + id);
    } // end else if
} // End of the function
function getFurnitureObjectById(id)
{
    if (!isNaN(id))
    {
        var _loc3 = getFurnitureCrumbsObject();
        var _loc2 = _loc3[id];
        if (_loc2 != undefined)
        {
            return (_loc2);
        }
        else
        {
            $e("[shell] getFurnitureObjectById() -> Could not find item in crumbs! item_id: " + id);
            return;
        } // end else if
    }
    else
    {
        $e("[shell] getFurnitureObjectById() -> Id is not a real number. item_id: " + id);
    } // end else if
} // End of the function
function isFurnitureInCrumbs(id)
{
    var _loc1 = getFurnitureCrumbsObject();
    var _loc4 = _loc1[id];
    var _loc2;
    for (var _loc2 in _loc1)
    {
        if (_loc1[_loc2].item_id == id)
        {
            return (true);
        } // end if
    } // end of for...in
    return (false);
} // End of the function
function setFurnitureCrumbsObject(obj)
{
    var _loc3 = getLocalizedFurnitureCrumbs();
    var _loc1;
    for (var _loc1 in obj)
    {
        obj[_loc1].item_id = Number(_loc1);
        obj[_loc1].id = Number(_loc1);
        obj[_loc1].name = _loc3[_loc1].name;
    } // end of for...in
    deleteLocalizedFurnitureCrumbsObject();
    furniture_crumbs = obj;
} // End of the function
function getFurnitureCrumbsObject(obj)
{
    return (furniture_crumbs);
} // End of the function
function setLocalizedFurnitureCrumbs(obj)
{
    localized_furniture_crumbs = obj;
} // End of the function
function getLocalizedFurnitureCrumbs()
{
    return (localized_furniture_crumbs);
} // End of the function
function deleteLocalizedFurnitureCrumbsObject()
{
    localized_furniture_crumbs = undefined;
} // End of the function
function setAvailableInteractionTypes(types)
{
    if (types == undefined)
    {
        return;
    } // end if
    updateListeners(FURNITURE_INTERACTIVE_TYPES, types);
} // End of the function
function getSortedFurnitureList()
{
    return (getFurnitureList().sortOn(["type", "id"], [Array.CASEINSENSITIVE, Array.DESCENDING]));
} // End of the function
function getFurnitureList()
{
    return (furniture_list);
} // End of the function
function setFurnitureList(arr)
{
    furniture_list = arr;
} // End of the function
function sendBuyIglooFloor(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.UPDATE_FLOOR, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] saveRoomFloor() -> The floor id was not a valid number. floor_id: " + id);
    } // end else if
} // End of the function
function sendBuyIglooLocation(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + "ul", [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] saveRoomFloor() -> The locations id was not a valid number. floor_id: " + id);
    } // end else if
} // End of the function
function sendBuyIglooType(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.UPDATE_IGLOO_TYPE, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendBuyIglooType() -> Not a real number passed for id. id: " + id);
    } // end else if
} // End of the function
function sendGetOwnedIgloos()
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.GET_OWNED_IGLOOS, [], "str", getCurrentServerRoomId());
} // End of the function
function findPlayerByName(pName)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.BUDDY_HANDLER + "#xn", [pName], "str", getCurrentServerRoomId());
} // End of the function
function sendActivateIgloo(id)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.ACTIVATE_IGLOO, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendActivateIgloo() -> Not a real number passed for id. id: " + id);
    } // end else if
} // End of the function
function unlockIgloo()
{
    if (isIglooLocked())
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.UNLOCK_IGLOO, [getMyPlayerId(), getMyPlayerNickname()], "str", getCurrentServerRoomId());
        setIglooAsUnLocked();
        updateListeners(IGLOO_LOCK_STATUS, {is_locked: false});
    }
    else
    {
        $d("[shell] unlockIgloo() -> Trying to unlock an igloo which is already unlocked!");
    } // end else if
} // End of the function
function lockIgloo()
{
    if (!isIglooLocked())
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.LOCK_IGLOO, [getMyPlayerId()], "str", getCurrentServerRoomId());
        setIglooAsLocked();
        updateListeners(IGLOO_LOCK_STATUS, {is_locked: true});
    }
    else
    {
        $d("[shell] lockIgloo() -> Trying to lock an igloo which is already locked!");
    } // end else if
} // End of the function
function setIglooMusicById(music_id)
{
    if (music_id == getIglooMusicId())
    {
        return;
    } // end if
    if (!isNaN(music_id))
    {
        setIglooMusicId(music_id);
        startMusicById(music_id);
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.UPDATE_IGLOO_MUSIC, [music_id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] updatePlayerMusic() -> music id is not a real number. music_id: " + music_id);
    } // end else if
} // End of the function
function setIglooBackgroundById(background_id)
{
    if (background_id == getIglooBackgroundId())
    {
        return;
    } // end if
    if (!isNaN(background_id))
    {
        setIglooBackgroundId(background_id);
        startBackgroundById(background_id);
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#ub", [background_id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] updatePlayerMusic() -> background id is not a real number. background_id: " + background_id);
    } // end else if
} // End of the function
function sendJoinPlayerIgloo(player_id)
{
    $d("[shell] sendJoinPlayerIgloo(" + player_id + ")");
    if (!isNaN(player_id))
    {
        if (getCurrentRoomId() != player_id + 1000)
        {
            igloo_player_id = player_id;
            getPlayerIglooDetails(player_id);
            addListener(GET_IGLOO_DETAILS, joinPlayerIgloo);
        }
        else
        {
            $e("[shell] sendJoinPlayerIgloo() -> Your trying to join a room your already in! room_id: " + getCurrentRoomId());
        } // end else if
    }
    else
    {
        $e("[shell] sendJoinPlayerIgloo() -> Player id is not a real number. player_id: " + player_id);
    } // end else if
} // End of the function
function getPlayerIglooDetails()
{
    if (!isNaN(igloo_player_id))
    {
        showLoading(getLocalizedString("Joining Players Igloo"));
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.GET_IGLOO_DETAILS, [igloo_player_id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] getPlayerIgloo() -> Not a real number passed for player id. player_id: " + igloo_player_id);
    } // end else if
} // End of the function
function setMyStoredIglooObject(igloo)
{
    myStoredIglooObject = igloo;
} // End of the function
function getMyStoredIglooObject()
{
    return (myStoredIglooObject);
} // End of the function
function loadIgloo(igloo)
{
    setCurrentIglooType(igloo.type);
    setCurrentIglooFloorId(igloo.floor_id);
    startMusicById(igloo.music_id);
    setPlayerIglooFurniture(igloo.furniture);
    setPlayerIglooBackground(igloo.background_id);
    setPlayerIglooObject(igloo);
    puffleManager.getPufflesByPlayerId(igloo.player_id);
} // End of the function
function getDefaultIglooObject()
{
    var _loc1 = {};
    _loc1.type = DEFAULT_IGLOO_TYPE_ID;
    _loc1.music_id = DEFAULT_IGLOO_MUSIC_ID;
    _loc1.floor_id = DEFAULT_IGLOO_FLOOR_ID;
    _loc1.furniture = DEFAULT_IGLOO_FURNITURE;
    _loc1.background_id = 0;
    return (_loc1);
} // End of the function
function joinPlayerIgloo()
{
    var _loc1 = igloo_player_id + 1000;
    if (!isNaN(_loc1))
    {
        if (_loc1 != getPlayerIglooObject().player_id)
        {
            showLoading(getLocalizedString("Joining Players Igloo"));
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.NAVIGATION + "#" + AIRTOWER.JOIN_PLAYER_IGLOO, [_loc1], "str", getCurrentServerRoomId());
        }
        else
        {
            $e("[shell] joinPlayerIgloo() -> Trying to join an igloo youre already in! player_id: " + _loc1);
        } // end else if
    }
    else
    {
        $e("[shell] joinPlayerIgloo() -> Not a real number passed for player id. player_id: " + _loc1);
    } // end else if
    removeListener(GET_IGLOO_DETAILS, joinPlayerIgloo);
} // End of the function
function saveIglooFurniture(arr)
{
    if (arr != undefined)
    {
        var _loc3 = {};
        var _loc4 = arr.length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            _loc3[_loc1] = arr[_loc1];
        } // end of for
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.SAVE_IGLOO_FURNITURE, arr, "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] saveIglooFurniture() furniture array is undefined! furniture_arr: " + arr);
    } // end else if
} // End of the function
function loadPlayerIglooList()
{
    $d("[shell] loadPlayerIglooList()");
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGLOO_HANDLER + "#" + AIRTOWER.GET_IGLOO_LIST, [], "str", getCurrentServerRoomId());
} // End of the function
function getIglooFurnitureObjectById(id)
{
    var _loc2 = getFurnitureList();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].item_id == id)
        {
            return (_loc2[_loc1]);
        } // end if
    } // end of for
    $e("[shell] getIglooFurnitureObjectById() -> Could not find furniture object! id: " + id);
    return;
} // End of the function
function isMyIgloo()
{
    if (getPlayerIglooObject().player_id == getMyPlayerId())
    {
        return (true);
    } // end if
    return (false);
} // End of the function
function setIglooEditMode(enableEditMode, numActiveFurniture)
{
    if (enableEditMode == undefined)
    {
        return;
    } // end if
    var _loc1 = {active: enableEditMode, player_id: getPlayerIglooObject().player_id, furnitureCount: numActiveFurniture};
    updateListeners(IGLOO_EDIT_MODE, _loc1);
} // End of the function
function setIsRoomIgloo(is_igloo)
{
    is_room_igloo = is_igloo;
} // End of the function
function getIsRoomIgloo()
{
    return (is_room_igloo);
} // End of the function
function getCurrentIglooType()
{
    return (current_igloo_type);
} // End of the function
function setCurrentIglooType(id)
{
    current_igloo_type = id;
} // End of the function
function getCurrentIglooFloorId()
{
    return (current_igloo_floor_id);
} // End of the function
function setCurrentIglooFloorId(id)
{
    current_igloo_floor_id = id;
} // End of the function
function getCurrentIglooBackgroundId()
{
    return (current_igloo_background_id);
} // End of the function
function setCurrentIglooBackgroundId(id)
{
    current_igloo_background_id = id;
} // End of the function
function setIglooAsLocked()
{
    is_igloo_locked = true;
} // End of the function
function setIglooAsUnLocked()
{
    is_igloo_locked = false;
} // End of the function
function isIglooLocked()
{
    return (is_igloo_locked);
} // End of the function
function getIglooMusicId()
{
    return (getPlayerIglooObject().music_id);
} // End of the function
function getIglooBackgroundId()
{
    return (getPlayerIglooObject().background_id);
} // End of the function
function setIglooMusicId(id)
{
    getPlayerIglooObject().music_id = id;
} // End of the function
function setIglooBackgroundId(id)
{
    getPlayerIglooObject().background_id = id;
} // End of the function
function setPlayerIglooObject(obj)
{
    player_igloo = obj;
} // End of the function
function getPlayerIglooObject()
{
    return (player_igloo);
} // End of the function
function getPlayerIglooFurniture()
{
    return (player_igloo_furniture);
} // End of the function
function setPlayerIglooFurniture(arr)
{
    player_igloo_furniture = arr;
} // End of the function
function getPlayerIglooBackground()
{
    return (player_igloo_background);
} // End of the function
function setPlayerIglooBackground(id)
{
    player_igloo_background = id;
} // End of the function
function setIglooCrumbs(obj)
{
    var _loc3 = getLocalizedIglooCrumbs();
    var _loc1;
    for (var _loc1 in obj)
    {
        obj[_loc1].id = Number(_loc1);
        obj[_loc1].name = _loc3[_loc1].name;
    } // end of for...in
    deleteLocalizedIglooCrumbsObject();
    igloo_crumbs = obj;
} // End of the function
function getIglooCrumbs()
{
    return (igloo_crumbs);
} // End of the function
function getIglooCrumbById(id)
{
    for (n in igloo_crumbs)
    {
        if (igloo_crumbs[n].id == id)
        {
            return (igloo_crumbs[n]);
        } // end if
    } // end of for...in
} // End of the function
function setIglooOptions(options)
{
    iglooOptions = options;
} // End of the function
function getIglooOptions()
{
    return (iglooOptions);
} // End of the function
function setLocalizedIglooCrumbs(obj)
{
    localized_igloo_crumbs = obj;
} // End of the function
function getLocalizedIglooCrumbs()
{
    return (localized_igloo_crumbs);
} // End of the function
function deleteLocalizedIglooCrumbsObject()
{
    localized_igloo_crumbs = undefined;
} // End of the function
function getIglooCrumbById(id)
{
    if (!isNaN(id))
    {
        var _loc1 = getIglooCrumbs();
        for (var _loc3 in _loc1)
        {
            if (_loc1[_loc3].id == id)
            {
                return (_loc1[_loc3]);
            } // end if
        } // end of for...in
        $e("[shell] getIglooCrumbById() -> Could not find igloo in the crumbs file! id: " + id);
        return;
    }
    else
    {
        $e("[shell] getIglooCrumbById() -> ID is not a real number! id: " + id);
    } // end else if
    return;
} // End of the function
function setFloorCrumbs(obj)
{
    var _loc2 = getLocalizedFloorCrumbs();
    for (var _loc3 in obj)
    {
        obj[_loc3].id = Number(_loc3);
        obj[_loc3].name = _loc2[_loc3].name;
    } // end of for...in
    deleteLocalizedFloorCrumbsObject();
    floor_crumbs = obj;
} // End of the function
function getFloorCrumbs()
{
    return (floor_crumbs);
} // End of the function
function setLocalizedFloorCrumbs(obj)
{
    localized_floor_crumbs = obj;
} // End of the function
function getLocalizedFloorCrumbs()
{
    return (localized_floor_crumbs);
} // End of the function
function deleteLocalizedFloorCrumbsObject()
{
    localized_furniture_crumbs = undefined;
} // End of the function
function getFloorCrumbById(id)
{
    if (!isNaN(id))
    {
        var _loc1 = getFloorCrumbs();
        for (var _loc3 in _loc1)
        {
            if (_loc1[_loc3].id == id)
            {
                return (_loc1[_loc3]);
            } // end if
        } // end of for...in
        $e("[shell] getFloorCrumbById() -> Could not find floor in the crumbs file! id: " + id);
        return;
    }
    else
    {
        $e("[shell] getFloorCrumbById() -> ID is not a real number! id: " + id);
    } // end else if
    return;
} // End of the function
function isIglooContestRunning()
{
    var _loc1 = getIglooOptions();
    return (_loc1.contestRunning);
} // End of the function
function sendIglooContestEntry()
{
    if (isMyPlayerMember())
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SURVEY_HANDLER + "#" + AIRTOWER.SEND_IGLOO, [], "str", getCurrentServerRoomId());
    } // end if
} // End of the function
function areIgloosCached()
{
    return (igloosCached);
} // End of the function
function getOwnedIgloos()
{
    return (ownedIgloos != undefined ? (ownedIgloos) : ([]));
} // End of the function
function doesPlayerOwnIgloo(iglooId)
{
    for (var _loc1 = 0; _loc1 < ownedIgloos.length; ++_loc1)
    {
        if (ownedIgloos[_loc1].id == iglooId)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function addIglooToInventoryCache(iglooId)
{
    for (var _loc1 = 0; _loc1 < ownedIgloos.length; ++_loc1)
    {
        if (ownedIgloos[_loc1].id == iglooId)
        {
            return;
        } // end if
    } // end of for
    var _loc3 = {};
    _loc3.id = iglooId;
    _loc3.name = iglooCrumbs[iglooId].name;
    ownedIgloos.push(_loc3);
} // End of the function
function sendMessage(txt)
{
    if (txt != undefined && txt != "")
    {
        addToChatLog({player_id: getMyPlayerId(), nickname: getMyPlayerNickname(), message: txt, type: SEND_MESSAGE});
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MESSAGE_HANDLER + "#" + AIRTOWER.SEND_MESSAGE, [getMyPlayerId(), txt], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendMessage() -> Trying to send a undefined or blank message. text: " + txt);
    } // end else if
} // End of the function
function sendEmote(emote_id)
{
    if (getPlayersInRoomCount() > 1)
    {
        if (!isNaN(emote_id))
        {
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.SEND_EMOTE, [emote_id], "str", getCurrentServerRoomId());
        }
        else
        {
            $e("[shell] sendEmote() -> Trying to send a invalid emote id. emote_id: " + emote_id);
        } // end if
    } // end else if
} // End of the function
function sendJoke(joke_id)
{
    if (getPlayersInRoomCount() > 1)
    {
        if (!isNaN(joke_id))
        {
            if (getJokeById(joke_id) != undefined)
            {
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.SEND_JOKE, [joke_id], "str", getCurrentServerRoomId());
            }
            else
            {
                $e("[shell] sendJokeMessage() -> Joke message was not found. joke_id: " + joke_id);
            } // end else if
        }
        else
        {
            $e("[shell] sendJokeMessage() -> Trying to send a invalid joke id. joke_id: " + joke_id);
        } // end else if
    }
    else
    {
        var _loc1 = {player_id: getMyPlayerId(), joke_id: joke_id};
        updateListeners(SEND_JOKE, _loc1);
    } // end else if
} // End of the function
function sendQuickMessage(quick_id)
{
    if (getPlayersInRoomCount() > 1)
    {
        if (!isNaN(quick_id))
        {
            if (getQuickMessageById(quick_id) != undefined)
            {
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.SEND_QUICK_MESSAGE, [quick_id], "str", getCurrentServerRoomId());
            }
            else
            {
                $e("[shell] sendQuickMessage() -> Quick message was not found. quick_id: " + quick_id);
            } // end else if
        }
        else
        {
            $e("[shell] sendQuickMessage() -> Trying to send a invalid quick id. quick_id: " + quick_id);
        } // end if
    } // end else if
} // End of the function
function sendSafeMessage(safe_id)
{
    if (getPlayersInRoomCount() > 1)
    {
        if (!isNaN(safe_id))
        {
            if (getSafeMessageById(safe_id) != undefined)
            {
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.SEND_SAFE_MESSAGE, [safe_id], "str", getCurrentServerRoomId());
            }
            else
            {
                $e("[shell] sendSafeMessage() -> Safe message was not found. safe_id: " + safe_id);
            } // end else if
        }
        else
        {
            $e("[shell] sendSafeMessage() -> Trying to send a invalid safe id. safe_id: " + safe_id);
        } // end if
    } // end else if
} // End of the function
function sendLineMessage(line_id)
{
    if (getPlayersInRoomCount() > 1)
    {
        if (!isNaN(line_id))
        {
            if (getLineMessageById(line_id) != undefined)
            {
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.SEND_LINE_MESSAGE, [line_id], "str", getCurrentServerRoomId());
            }
            else
            {
                $e("[shell] sendLineMessage() -> Line message was not found. line_id: " + line_id);
            } // end else if
        }
        else
        {
            $e("[shell] sendLineMessage() -> Trying to send a invalid line id. line_id: " + line_id);
        } // end if
    } // end else if
} // End of the function
function sendMascotMessage(line_id)
{
    if (getPlayersInRoomCount() > 1)
    {
        if (!isNaN(line_id))
        {
            if (getMascotMessageById(line_id) != undefined)
            {
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.SEND_MASCOT_MESSAGE, [line_id], "str", getCurrentServerRoomId());
            }
            else
            {
                $e("[shell] sendMascotMessage() -> Mascot message was not found. line_id: " + line_id);
            } // end else if
        }
        else
        {
            $e("[shell] sendMascotMessage() -> Trying to send a invalid line id. line_id: " + line_id);
        } // end if
    } // end else if
} // End of the function
function sendTourGuideMessage(room_id)
{
    if (getPlayersInRoomCount() > 1)
    {
        if (!isNaN(room_id))
        {
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.SEND_TOUR_GUIDE_MESSAGE, [room_id], "str", getCurrentServerRoomId());
        }
        else
        {
            $e("[shell] sendTourGuideMessage() -> Not a real number passed for room id! room id: " + room_id);
        } // end if
    } // end else if
} // End of the function
function isPlayerMascotById(player_id)
{
    if (!isNaN(player_id))
    {
        if (getMascotCrumbs()[player_id] != undefined)
        {
            return (true);
        } // end if
        return (false);
    }
    else
    {
        $e("[shell] isPlayerMascotById() -> Player id is not a real number! player_id: " + player_id);
    } // end else if
    return (false);
} // End of the function
function getMascotGiftById(player_id)
{
    if (!isNaN(player_id))
    {
        var _loc1 = getMascotCrumbs()[player_id];
        if (_loc1 != undefined)
        {
            if (_loc1.gift_id != undefined)
            {
                return (_loc1.gift_id);
            } // end if
            $e("[shell] getMascotGiftById() -> Gift id is undefined! player_id: " + player_id + " gift id: " + _loc1.gift_id);
        }
        else
        {
            $e("[shell] getMascotGiftById() -> Could not find mascot in crumbs!: " + player_id);
        } // end else if
        return;
    }
    else
    {
        $e("[shell] getMascotGiftById() -> Player id is not a real number! player_id: " + player_id);
    } // end else if
    return;
} // End of the function
function sendToOasisExtension(args)
{
    ps.oasis.OasisLogger.debug("Sending to Extension\\asis.ext->Player->Set(\"PlayerAttributes\", +" + handler + ", ~VALS)");
    AIRTOWER.send(AIRTOWER.PLAY_EXT, "oasis#setpa", args, "str", getCurrentServerRoomId());
} // End of the function
function sendUpdatePlayercardValue(args)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, "oasis#setvalue", args, "str", getCurrentServerRoomId());
} // End of the function
function sendUpdatePlayercardHue(hue_id)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, "oasis#sethue", [hue_id], "str", getCurrentServerRoomId());
} // End of the function
function sendUpdatePlayercardFace(face_id)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, "oasis#setface", [face_id], "str", getCurrentServerRoomId());
} // End of the function
function sendUpdatePlayerStatus(status)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, "oasis#setstatus", [status], "str", getCurrentServerRoomId());
} // End of the function
function getMascotNicknameByID(id)
{
    if (isNaN(id))
    {
        $e("[shell] getMascotNameByID() -> ID is not a real number! id: " + id);
        return ("");
    } // end if
    if (getMascotCrumbs()[id] == undefined)
    {
        $e("[shell] getMascotNameByID() -> Could not find mascot with the ID \"" + id + "\" in the mascot crumbs!");
        return ("");
    } // end if
    return (getLocalizedString(getMascotCrumbs()[id].name));
} // End of the function
function isMigratorHere()
{
    var _loc1 = getMascotOptions();
    if (_loc1.migrator_active != undefined)
    {
        return (_loc1.migrator_active);
    } // end if
    return (false);
} // End of the function
function setMascotCrumbs(obj)
{
    mascot_crumbs = obj;
} // End of the function
function getMascotCrumbs(obj)
{
    return (mascot_crumbs);
} // End of the function
function setMascotOptions(obj)
{
    mascot_options = obj;
} // End of the function
function getMascotOptions()
{
    return (mascot_options);
} // End of the function
function checkHuntStatus()
{
    var _loc1 = getHuntCrumbs();
    var _loc2;
    for (var _loc2 in _loc1)
    {
        if (!_loc1[_loc2].is_found && _loc1[_loc2].is_required)
        {
            onHuntFailure();
            return;
        } // end if
    } // end of for...in
    onHuntSuccess();
} // End of the function
function setHuntItemAsFoundById(id)
{
    if (!isNaN(id))
    {
        var _loc2 = getHuntItemById(id);
        if (_loc2 != undefined)
        {
            _loc2.is_found = true;
            checkHuntStatus();
        }
        else
        {
            $e("[shell] setHuntItemAsFoundById() -> Could not find the id in the crumbs! id: " + id);
        } // end else if
    }
    else
    {
        $e("[shell] setHuntItemAsFoundById() -> Not a real number passed for id! id: " + id);
    } // end else if
} // End of the function
function setHuntItemAsNotFoundById(id)
{
    if (!isNaN(id))
    {
        var _loc2 = getHuntItemById(id);
        if (_loc2 != undefined)
        {
            _loc2.is_found = false;
            checkHuntStatus();
        }
        else
        {
            $e("[shell] setHuntItemAsNotFoundById() -> Could not find the id in the crumbs! id: " + id);
        } // end else if
    }
    else
    {
        $e("[shell] setHuntItemAsNotFoundById() -> Not a real number passed for id! id: " + id);
    } // end else if
} // End of the function
function onHuntSuccess()
{
    on_hunt_success_func(getHuntCrumbs());
} // End of the function
function onHuntFailure()
{
    on_hunt_failure_func(getHuntCrumbs());
} // End of the function
function setOnHuntSuccessFunction(func)
{
    if (func != undefined)
    {
        if (func != on_hunt_success_func)
        {
            on_hunt_success_func = func;
        }
        else
        {
            $d("[shell] setOnHuntSuccessFunction() -> The passed function is already set as the on_hunt_success_func!");
        } // end else if
        return (true);
    }
    else
    {
        $e("[shell] setOnHuntSuccessFunction() -> Function passed was undefined! function: " + func);
    } // end else if
    return (false);
} // End of the function
function setOnHuntFailureFunction(func)
{
    if (func != undefined)
    {
        if (func != on_hunt_failure_func)
        {
            on_hunt_failure_func = func;
        }
        else
        {
            $d("[shell] setOnHuntFailureFunction() -> The passed function is already set as the on_hunt_success_func!");
        } // end else if
        return (true);
    }
    else
    {
        $e("[shell] setOnHuntFailureFunction() -> Function passed was undefined! function: " + func);
    } // end else if
    return (false);
} // End of the function
function getHuntItemById(id)
{
    if (!isNaN(id))
    {
        var _loc1 = getHuntCrumbs();
        var _loc2;
        for (var _loc2 in _loc1)
        {
            if (_loc1[_loc2].id == id)
            {
                return (_loc1[_loc2]);
            } // end if
        } // end of for...in
        $e("[shell] getHuntItemById() -> Could not find the id in the crumbs! id: " + id);
    }
    else
    {
        $e("[shell] getHuntItemById() -> Not a real number passed for id! id: " + id);
    } // end else if
} // End of the function
function setHuntCrumbs(obj)
{
    var _loc1;
    for (var _loc1 in obj)
    {
        obj[_loc1].id = Number(_loc1);
    } // end of for...in
    hunt_crumbs = obj;
} // End of the function
function getHuntCrumbs()
{
    return (hunt_crumbs);
} // End of the function
function getAchievementGroupById(id)
{
    if (!isNaN(id))
    {
        var _loc2 = getAchievementCrumbs();
        if (_loc2[id] != undefined)
        {
            return (_loc2[id]);
        } // end if
        $e("[shell] getAchievementGroupById() -> Could not find group by ID in achievement crumbs! id: " + id);
    }
    else
    {
        $e("[shell] getAchievementGroupById() -> id is not a real number! id: " + id);
    } // end else if
    return;
} // End of the function
function getAchievementItemById(group_id, item_id)
{
    if (!isNaN(group_id))
    {
        if (!isNaN(item_id))
        {
            var _loc1 = getAchievementGroupById(group_id);
            if (_loc1 != undefined)
            {
                for (n in _loc1)
                {
                    if (_loc1[n].id == item_id)
                    {
                        return (_loc1[n]);
                    } // end if
                } // end of for...in
                $e("[shell] getAchievementItemById() -> Could not find item in group! group_id: " + group_id + " item_id: " + item_id);
            } // end if
        }
        else
        {
            $e("[shell] getAchievementItemById() -> Item id is not a real number! item_id: " + id);
        } // end else if
    }
    else
    {
        $e("[shell] getAchievementItemById() -> Group id is not a real number! group_id: " + id);
    } // end else if
    return;
} // End of the function
function getAchievementItemByName(group_id, ach_name)
{
    if (!isNaN(group_id))
    {
        if (isValidString(ach_name))
        {
            var _loc1 = getAchievementGroupById(group_id);
            if (_loc1 != undefined)
            {
                for (n in _loc1)
                {
                    if (_loc1[n].name == ach_name)
                    {
                        return (_loc1[n]);
                    } // end if
                } // end of for...in
                $e("[shell] getAchievementItemById() -> Could not find item in group! group_id: " + group_id + " item_id: " + item_id);
            } // end if
        }
        else
        {
            $e("[shell] getAchievementItemById() -> Item name is not a real string! name: " + ach_name);
        } // end else if
    }
    else
    {
        $e("[shell] getAchievementItemById() -> Group id is not a real number! group_id: " + id);
    } // end else if
    return;
} // End of the function
function setAchievementAsCompleteById(group_id, item_id)
{
    if (!isNaN(group_id))
    {
        if (!isNaN(item_id))
        {
            var _loc1 = getAchievementItemById(group_id, item_id);
            if (_loc1 != undefined)
            {
                _loc1.active = true;
            } // end if
            checkGroupCompleteById(group_id);
        }
        else
        {
            $e("[shell] setAchievementAsCompleteById() -> Item id is not a real number! item_id: " + id);
        } // end else if
    }
    else
    {
        $e("[shell] setAchievementAsCompleteById() -> Group id is not a real number! group_id: " + id);
    } // end else if
} // End of the function
function setAchievementAsIncompleteById(group_id, item_id)
{
    if (!isNaN(group_id))
    {
        if (!isNaN(item_id))
        {
            var _loc1 = getAchievementItemById(group_id, item_id);
            if (_loc1 != undefined)
            {
                _loc1.active = false;
            } // end if
        }
        else
        {
            $e("[shell] setAchievementAsIncompleteById() -> Item id is not a real number! item_id: " + id);
        } // end else if
    }
    else
    {
        $e("[shell] setAchievementAsIncompleteById() -> Group id is not a real number! group_id: " + id);
    } // end else if
} // End of the function
function setAchievementAsCompleteByName(group_id, ach_name)
{
    if (!isNaN(group_id))
    {
        if (isValidString(ach_name))
        {
            var _loc1 = getAchievementItemByName(group_id, ach_name);
            if (_loc1 != undefined)
            {
                _loc1.active = true;
            } // end if
            var _loc3 = checkGroupCompleteById(group_id);
            if (_loc3)
            {
                getAchievementGroupCompleteFunc()(group_id);
            } // end if
        }
        else
        {
            $e("[shell] setAchievementAsCompleteById() -> Item name is not a real string! name: " + ach_name);
        } // end else if
    }
    else
    {
        $e("[shell] setAchievementAsCompleteById() -> Group id is not a real number! group_id: " + id);
    } // end else if
} // End of the function
function setAchievementAsIncompleteByName(group_id, ach_name)
{
    if (!isNaN(group_id))
    {
        if (isValidString(ach_name))
        {
            var _loc1 = getAchievementItemByName(group_id, ach_name);
            if (_loc1 != undefined)
            {
                _loc1.active = false;
            } // end if
            var _loc3 = checkGroupCompleteById(group_id);
            if (_loc3)
            {
                getAchievementGroupCompleteFunc()(group_id);
            } // end if
        }
        else
        {
            $e("[shell] setAchievementAsIncompleteByName() -> Item name is not a real string! name: " + ach_name);
        } // end else if
    }
    else
    {
        $e("[shell] setAchievementAsIncompleteByName() -> Group id is not a real number! group_id: " + id);
    } // end else if
} // End of the function
function checkGroupCompleteById(id)
{
    if (!isNaN(id))
    {
        var _loc1 = getAchievementGroupById(id);
        if (_loc1 != undefined)
        {
            var _loc3 = new Array();
            var _loc2;
            for (var _loc2 in _loc1)
            {
                if (_loc1[_loc2].active)
                {
                    _loc3.push(_loc1[_loc2]);
                } // end if
            } // end of for...in
            if (_loc3.length == _loc1.length)
            {
                return (true);
            } // end if
        } // end if
    }
    else
    {
        $e("[shell] checkGroupCompleteById() -> Group id is not a real number! group_id: " + id);
    } // end else if
    return (false);
} // End of the function
function setAchievementGroupCompleteFunc(func)
{
    achievement_group_complete = func;
} // End of the function
function getAchievementGroupCompleteFunc()
{
    return (achievement_group_complete);
} // End of the function
function setAchievementCrumbs(obj)
{
    achievement_crumbs = obj;
} // End of the function
function getAchievementCrumbs()
{
    return (achievement_crumbs);
} // End of the function
function getBuddyListFromServer()
{
    if (buddyList != undefined)
    {
        $e("[shell] getBuddyList() -> Buddy list already fetched!");
        return;
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.BUDDY_HANDLER + "#" + AIRTOWER.GET_BUDDY_LIST, [], "str", getCurrentServerRoomId());
} // End of the function
function sendBuddyRequest(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] sendBuddyRequest() -> Not a real number passed for player id. playerID: " + playerID);
        return;
    } // end if
    if (hasMaxBuddies())
    {
        $e("[shell] sendBuddyRequest() -> Max amount of buddies! ", {error_code: BUDDY_LIMIT});
        return;
    } // end if
    if (isPlayerBuddyById(playerID))
    {
        $e("[shell] sendBuddyRequest() -> Player is already your buddy! playerID: " + playerID);
        return;
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.BUDDY_HANDLER + "#" + AIRTOWER.REQUEST_BUDDY, [playerID], "str", getCurrentServerRoomId());
} // End of the function
function sendBuddyAccept(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] sendBuddyRequest() -> Not a real number passed for player id. playerID: " + playerID);
        return;
    } // end if
    if (isPlayerBuddyById(playerID))
    {
        $e("[shell] sendBuddyRequest() -> Player is already our buddy! playerID: " + playerID);
        return;
    } // end if
    var _loc2 = buddyRequest[Number(playerID)];
    addPlayerToBuddyList(_loc2.player_id, _loc2.nickname, true);
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.BUDDY_HANDLER + "#" + AIRTOWER.ACCEPT_BUDDY, [playerID, _loc2.token], "str", getCurrentServerRoomId());
    delete buddyRequest[Number(playerID)];
} // End of the function
function sendRemoveBuddyPlayer(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] sendRemoveBuddyPlayer() -> Not a real number passed for player id. playerID: " + playerID);
        return;
    } // end if
    if (!removePlayerFromBuddyList(playerID))
    {
        $e("[shell] sendRemoveBuddyPlayer() -> Player was not successfully removed from the local list");
        return;
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.BUDDY_HANDLER + "#" + AIRTOWER.REMOVE_BUDDY, [playerID], "str", getCurrentServerRoomId());
    updateListeners(UPDATE_BUDDY_LIST, getSortedBuddyList());
} // End of the function
function addPlayerToBuddyList(playerID, nickname, isOnline)
{
    if (isNaN(playerID))
    {
        $e("[shell] addToBuddyList() -> Invalid player id: " + playerID);
    } // end if
    var _loc1 = new Object();
    _loc1.player_id = playerID;
    _loc1.nickname = nickname;
    _loc1.is_online = isOnline;
    getBuddyList().push(_loc1);
} // End of the function
function removePlayerFromBuddyList(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] removePlayerFromBuddyList() -> Invalid player id: " + playerID);
        return (false);
    } // end if
    if (!isPlayerBuddyById(playerID))
    {
        $e("[shell] removePlayerFromBuddyList() -> Trying to remove a player from our buddy list who doesnt exist: playerID: " + playerID);
        return (false);
    } // end if
    var _loc2 = getBuddyList();
    var _loc4 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
    {
        if (_loc2[_loc1].player_id == playerID)
        {
            _loc2.splice(_loc1, 1);
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function isBuddyOnlineById(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] isBuddyOnlineById() -> Invalid player id: " + playerID);
    } // end if
    var _loc2 = getBuddyList();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == playerID)
        {
            return (_loc2[_loc1].is_online);
        } // end if
    } // end of for
} // End of the function
function isPlayerBuddyById(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] isPlayerBuddyById() -> Invalid player id: " + playerID);
        return;
    } // end if
    var _loc2 = getBuddyList();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == playerID)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function setBuddyAsOnlineById(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] setBuddyAsOnline() -> Invalid player id: " + playerID);
        return;
    } // end if
    var _loc2 = getBuddyList();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == playerID)
        {
            _loc2[_loc1].is_online = true;
        } // end if
    } // end of for
} // End of the function
function setBuddyAsOfflineById(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] setBuddyAsOfflineById() -> Invalid player id: " + playerID);
        return;
    } // end if
    var _loc2 = getBuddyList();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == playerID)
        {
            _loc2[_loc1].is_online = false;
        } // end if
    } // end of for
} // End of the function
function getBuddyNicknameById(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] getBuddyNicknameById() -> Invalid player id: " + playerID);
        return;
    } // end if
    var _loc2 = getBuddyList();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == playerID)
        {
            return (_loc2[_loc1].nickname);
        } // end if
    } // end of for
    return;
} // End of the function
function setCurrentBuddyRequestObject(obj)
{
    buddyRequest[Number(obj.player_id)] = obj;
} // End of the function
function getCurrentBuddyRequestObject()
{
    return (buddyRequest);
} // End of the function
function clearCurrentBuddyRequestObject()
{
    buddyRequest = undefined;
} // End of the function
function getBuddyList()
{
    return (buddyList);
} // End of the function
function hasMaxBuddies()
{
    if (getBuddyList().length < MAX_BUDDY_COUNT)
    {
        return (false);
    } // end if
    return (true);
} // End of the function
function getSortedBuddyList()
{
    return (buddyList.sortOn(["is_online", "nickname"], [Array.DESCENDING, Array.CASEINSENSITIVE]));
} // End of the function
function getPlayerLocationById(playerID)
{
    if (isNaN(playerID))
    {
        $e("[shell] getPlayerLocationById() -> Not a real number passed for player id. playerID: " + playerID);
        return;
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.BUDDY_HANDLER + "#" + AIRTOWER.FIND_BUDDY, [playerID], "str", getCurrentServerRoomId());
} // End of the function
function getIgnoreListFromServer()
{
    if (ignore_list == undefined)
    {
        ignore_list = [];
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGNORE_HANDLER + "#" + AIRTOWER.GET_IGNORE_LIST, [], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] getIgnoreListFromServer() -> Ignore list already fetched!");
    } // end else if
} // End of the function
function addPlayerToIgnoreList(player_id, nickname)
{
    if (!isNaN(player_id))
    {
        if (!isPlayerIgnoredById(player_id))
        {
            var _loc2 = new Object();
            _loc2.player_id = Number(player_id);
            _loc2.nickname = nickname;
            getIgnoreList().push(_loc2);
            return (true);
        }
        else
        {
            $e("[shell] addPlayerToIgnoreList() -> Trying to add a duplicate player to our ignore list. player_id: " + player_id + " nickname: " + nickname);
        } // end else if
    }
    else
    {
        $e("[shell] addPlayerToIgnoreList() -> Invalid player id: " + player_id);
    } // end else if
    return (false);
} // End of the function
function removePlayerFromIgnoreList(player_id)
{
    if (!isNaN(player_id))
    {
        if (isPlayerIgnoredById(player_id))
        {
            var _loc2 = getIgnoreList();
            var _loc4 = _loc2.length;
            for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
            {
                if (_loc2[_loc1].player_id == player_id)
                {
                    _loc2.splice(_loc1, 1);
                    return (true);
                } // end if
            } // end of for
        }
        else
        {
            $e("[shell] removePlayerFromIgnoreList() -> Trying to remove a player from our ignore list who doesnt exist: player_id: " + player_id);
        } // end else if
    }
    else
    {
        $e("[shell] removePlayerFromIgnoreList() -> Invalid player id: " + player_id);
    } // end else if
    return (false);
} // End of the function
function isPlayerIgnoredById(player_id)
{
    if (!isNaN(player_id))
    {
        var _loc3 = getIgnoreList();
        var _loc2 = _loc3.length;
        var _loc1 = 0;
        if (_loc2 == 0 || isNaN(_loc2))
        {
            return (false);
        } // end if
        while (_loc1 < _loc2)
        {
            if (_loc3[_loc1].player_id == player_id)
            {
                return (true);
            } // end if
            ++_loc1;
        } // end while
    }
    else
    {
        $e("[shell] isPlayerIgnoredById() -> Not a real number passed for player id. player_id: " + player_id);
    } // end else if
    return (false);
} // End of the function
function sendAddIgnorePlayer(player_id, nickname)
{
    if (!isNaN(player_id))
    {
        if (isValidString(nickname))
        {
            var _loc2 = addPlayerToIgnoreList(player_id, nickname);
            if (_loc2)
            {
                AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGNORE_HANDLER + "#" + AIRTOWER.ADD_IGNORE, [player_id], "str", getCurrentServerRoomId());
            }
            else
            {
                $e("[shell] sendAddIgnorePlayer() -> Player was not successfully ignored in the local list");
            } // end else if
        }
        else
        {
            $e("[shell] sendAddIgnorePlayer() -> Invalid nickname: " + nickname);
        } // end else if
    }
    else
    {
        $e("[shell] sendAddIgnorePlayer() -> Not a real number passed for player id. player_id: " + player_id);
    } // end else if
} // End of the function
function sendRemoveIgnorePlayer(player_id)
{
    if (!isNaN(player_id))
    {
        var _loc2 = removePlayerFromIgnoreList(player_id);
        if (_loc2)
        {
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.IGNORE_HANDLER + "#" + AIRTOWER.REMOVE_IGNORE, [player_id], "str", getCurrentServerRoomId());
        }
        else
        {
            $e("[shell] sendRemoveIgnorePlayer() -> Player was not successfully removed from the local list");
        } // end else if
    }
    else
    {
        $e("[shell] sendRemoveIgnorePlayer() -> Not a real number passed for player id. player_id: " + player_id);
    } // end else if
} // End of the function
function getSortedIgnoreList()
{
    return (getIgnoreList().sortOn("nickname", Array.CASEINSENSITIVE));
} // End of the function
function getIgnoreList()
{
    return (ignore_list);
} // End of the function
function sendReportPlayer(player_id, reason_id, nickname)
{
    if (isNaN(player_id))
    {
        $e("[shell] sendReportPlayer() -> Player ID is not a real number. player_id: " + player_id);
        return (false);
    } // end if
    if (isNaN(reason_id))
    {
        $e("[shell] sendReportPlayer() -> Reason ID is not a real number. reason_id: " + reason_id);
        return (false);
    } // end if
    if (!isValidString(nickname))
    {
        $e("[shell] sendReportPlayer() -> Nickname is not a valid string. nickname: " + nickname);
        return (false);
    } // end if
    if (reason_id == REPORT_BAD_PENGUIN_NAME)
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MESSAGE_HANDLER + "#" + AIRTOWER.REPORT_PLAYER, [player_id, reason_id, nickname], "str", getCurrentServerRoomId());
    }
    else if (isPlayerInChatLog(player_id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MESSAGE_HANDLER + "#" + AIRTOWER.REPORT_PLAYER, [player_id], "str", getCurrentServerRoomId());
    }
    else
    {
        $d("[shell] sendReportPlayer() -> Player not reported because they were not in the chatlog");
    } // end else if
} // End of the function
function mutePlayerById(player_id)
{
    if (!isNaN(player_id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MODERATION_HANDLER + "#" + AIRTOWER.MUTE, [player_id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] mutePlayerById() -> Not a real number passed for player_id: " + player_id);
    } // end else if
} // End of the function
function kickPlayerByName(player_id)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MODERATION_HANDLER + "#kick_name", [player_id], "str", getCurrentServerRoomId());
} // End of the function
function kickPlayerById(player_id, reason)
{
    if (!isNaN(player_id))
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MODERATION_HANDLER + "#" + "kick", [player_id, reason], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] kickPlayerById() -> Not a real number passed for player_id: " + player_id);
    } // end else if
} // End of the function
function banPlayerById(player_id, ban_reason)
{
    if (!isNaN(player_id))
    {
        if (isValidString(ban_reason))
        {
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MODERATION_HANDLER + "#" + AIRTOWER.BAN, [player_id, ban_reason], "str", getCurrentServerRoomId());
        }
        else
        {
            $e("[shell] banPlayerById() -> Ban reason isnt a valid string: ban_reason: " + ban_reason);
        } // end else if
    }
    else
    {
        $e("[shell] banPlayerById() -> Not a real number passed for player_id: " + player_id);
    } // end else if
} // End of the function
function setupMailEngine()
{
    if (mail_engine == undefined)
    {
        $d("[MAIL] *** Mail Engine Initiated ***");
        mail_engine = {};
        mail_engine.mail = undefined;
        mail_engine.has_fetched = false;
        mail_engine.has_messages = false;
        mail_engine.on_response = undefined;
        mail_engine.on_details_response = undefined;
        mail_engine.on_next_set_response = undefined;
        mail_engine.on_delete_user_mail_response = undefined;
        mail_engine.total_mail = undefined;
        mail_engine.total_mail_listeners = undefined;
        mail_engine.new_mail_count = 0;
        mail_engine.new_mail_queue = undefined;
        mail_engine.new_mail_count_on_server = 0;
        mail_engine.new_mail_listeners = undefined;
        mail_engine.mail_recieved_listeners = undefined;
        mail_engine.messages_per_set = 12;
        mail_engine.last_set_fetched = 0;
        mail_engine.total_sets = undefined;
        mail_engine.last_recieved_id = 0;
    } // end if
} // End of the function
function showMail()
{
    if (getNewMailCount() > 0)
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MAIL_HANDLER + "#" + AIRTOWER.MAIL_CHECKED, [], "str", getCurrentServerRoomId());
    } // end if
    MAIL.showInbox();
    gotoState(MAIL_STATE);
} // End of the function
function hideMail()
{
    gotoState(PLAY_STATE);
} // End of the function
function closeMail()
{
    MAIL.closeInbox();
    gotoState(PLAY_STATE);
} // End of the function
function sendMailToUserById(player_id, nickname)
{
    if (!isNaN(player_id))
    {
        if (isValidString(nickname))
        {
            POSTCARDS.sendPostcardToPlayerById(player_id, nickname);
        }
        else
        {
            $e("[mail engine] sendMailToUserById() -> Invalid nickname! nickname: " + nickname);
        } // end else if
    }
    else
    {
        $e("[mail engine] sendMailToUserById() -> Invalid player id: " + player_id);
    } // end else if
} // End of the function
function attachMailListenersToAirtower()
{
} // End of the function
function startMailEngine()
{
    $d("[mail engine] startMailEngine()");
    setupMailEngine();
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MAIL_HANDLER + "#" + AIRTOWER.MAIL_START_ENGINE, [], "str", getCurrentServerRoomId());
} // End of the function
function showInbox()
{
    $d("[shell] showInbox();");
} // End of the function
function getNewMailCount()
{
    var _loc2;
    var _loc1;
    mail_engine.new_mail_count = 0;
    if (mail_engine.has_fetched == true)
    {
        _loc2 = mail_engine.mail.length;
        for (var _loc1 = 0; _loc1 < _loc2; ++_loc1)
        {
            if (mail_engine.mail[_loc1].read == 0)
            {
                ++mail_engine.new_mail_count;
            } // end if
        } // end of for
        return (mail_engine.new_mail_count);
    } // end if
    if (mail_engine.new_mail_queue != undefined)
    {
        _loc2 = mail_engine.new_mail_queue.length;
        for (var _loc1 = 0; _loc1 < _loc2; ++_loc1)
        {
            if (mail_engine.new_mail_queue[_loc1].read == 0)
            {
                ++mail_engine.new_mail_count;
            } // end if
        } // end of for
        return (mail_engine.new_mail_count + getNewMailCountOnServer());
    } // end if
    if (mail_engine.mail.length > 0 && getNewMailCountOnServer() == 0)
    {
        return (mail_engine.mail.length);
    } // end if
    return (getNewMailCountOnServer());
} // End of the function
function setAsRead(id)
{
    if (!isNaN(id))
    {
        $d("[mail engine] setAsRead(id) -> " + id);
        var _loc1 = 0;
        var _loc3 = mail_engine.mail.length;
        while (_loc1 < _loc3)
        {
            if (mail_engine.mail[_loc1].unq_id == id)
            {
                mail_engine.mail[_loc1].read = 1;
                break;
            } // end if
            ++_loc1;
        } // end while
        updateListeners(NEW_MAIL, getNewMailCount());
    }
    else
    {
        $e("[mail engine] setAsRead() -> Invalid id: " + id);
    } // end else if
} // End of the function
function deleteMailItem(id)
{
    if (!isNaN(id))
    {
        $d("[mail engine] deleteMailItem(id) -> " + id);
        var _loc1 = 0;
        var _loc4 = mail_engine.mail.length;
        var _loc3;
        while (_loc1 < _loc4)
        {
            if (mail_engine.mail[_loc1].unq_id == id)
            {
                _loc3 = _loc1;
                break;
            } // end if
            ++_loc1;
        } // end while
        if (!isNaN(_loc3))
        {
            mail_engine.mail.splice(_loc3, 1);
            --mail_engine.total_mail;
            updateListeners(TOTAL_MAIL, mail_engine.total_mail);
            updateListeners(NEW_MAIL, getNewMailCount());
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MAIL_HANDLER + "#" + AIRTOWER.DELETE_MAIL, [id], "str", getCurrentServerRoomId());
            return (true);
        }
        else
        {
            $e("[mail engine] deleteMailItem(id) -> " + id + " Trying to delete a mail item which did not exist.");
        } // end else if
    }
    else
    {
        $e("[mail engine] deleteMailItem(id) -> " + id);
    } // end else if
    return (false);
} // End of the function
function deleteMailFromUser(user_to_delete, on_response)
{
    if (!isNaN(user_to_delete))
    {
        $d("[mail engine] deleteMailFromUser(user_to_delete, on_response) -> " + user_to_delete + " " + on_response);
        var _loc1 = 0;
        var _loc3 = mail_engine.mail.length;
        while (_loc1 < _loc3)
        {
            if (mail_engine.mail[_loc1].user_id == user_to_delete)
            {
                mail_engine.mail.splice(_loc1, 1);
                continue;
            } // end if
            ++_loc1;
        } // end while
        if (on_response != undefined)
        {
            mail_engine.on_delete_user_mail_response = on_response;
        } // end if
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MAIL_HANDLER + "#" + AIRTOWER.DELETE_MAIL_FROM_PLAYER, [user_to_delete], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[mail engine] deleteMailFromUser(user_to_delete, on_response) user to delete is " + user_to_delete);
    } // end else if
} // End of the function
function debugMailList()
{
    var _loc1 = mail_engine.mail;
    var _loc3 = _loc1.length;
    var _loc2 = 0;
} // End of the function
function sendMail(recipient_id, postcard_id)
{
    if (getMyPlayerTotalCoins() >= POSTCARD_COST)
    {
        if (!isNaN(recipient_id) && !isNaN(postcard_id))
        {
            $d("[mail engine] sendMail(" + recipient_id + "," + postcard_id + ")");
            AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MAIL_HANDLER + "#" + AIRTOWER.SEND_MAIL, [recipient_id, postcard_id], "str", getCurrentServerRoomId());
            ++total_sent_messages;
        }
        else
        {
            $e("[mail engine] sendMail() -> " + recipient_id + " " + postcard_id);
            var _loc2 = {};
            _loc2.status_code = MAIL_SUCCESSFULLY_SENT;
            updateListeners(MAIL_SEND_STATUS, _loc2);
        } // end else if
    }
    else
    {
        $e("[mail engine] sendMail() -> Not enough coins to send message!");
        _loc2 = {};
        _loc2.status_code = MAIL_NOT_ENOUGH_COINS;
        updateListeners(MAIL_SEND_STATUS, _loc2);
    } // end else if
} // End of the function
function getMailFromEngine(on_response)
{
    if (on_response != undefined)
    {
        setMailResponseFunc(on_response);
    } // end if
    if (mail_engine.has_fetched == false && getHasMessages())
    {
        $d("[mail engine] getMailFromEngine() -> from SmartFox");
        var _loc2 = new Object();
        var _loc1 = getLastRecievedId();
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MAIL_HANDLER + "#" + AIRTOWER.GET_MAIL, [_loc1], "str", getCurrentServerRoomId());
    }
    else
    {
        $d("[mail engine] getMailFromEngine() -> from Engine");
        getMailResponseFunc()(mail_engine.mail);
    } // end else if
} // End of the function
function setTotalSets(total)
{
    mail_engine.total_sets = Math.ceil(total / mail_engine.messages_per_set - 1);
} // End of the function
function getTotalSets()
{
    return (mail_engine.total_sets);
} // End of the function
function setCurrentSet(last_fetched)
{
    mail_engine.last_set_fetched = last_fetched;
} // End of the function
function getCurrentSet()
{
    return (mail_engine.last_set_fetched);
} // End of the function
function nextSetAvailable()
{
    if (getCurrentSet() + 1 <= getTotalSets())
    {
        return (true);
    } // end if
    return (false);
} // End of the function
function getNextSet(on_response)
{
    $d("[mail engine] getNextSet(on_response) -> " + on_response);
    if (on_response != undefined)
    {
        mail_engine.on_next_set_response = on_response;
        var _loc2 = getLastRecievedId();
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MAIL_HANDLER + "#" + AIRTOWER.GET_MAIL, [_loc2], "str", getCurrentServerRoomId());
        setCurrentSet(getCurrentSet() + 1);
    }
    else
    {
        $e("[mail engine] getNextSet(on_response) -> " + on_response + " You must pass a onResponse function");
    } // end else if
} // End of the function
function setMailResponseFunc(func)
{
    mail_engine.on_response = func;
} // End of the function
function getMailResponseFunc()
{
    return (mail_engine.on_response);
} // End of the function
function getMailDetails(id, func)
{
    $d("[mail engine] getMailDetails(id, func) -> " + id + " " + func);
    if (!isNaN(id))
    {
        setOnDetailsFunc(func);
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MAIL_HANDLER + "#" + AIRTOWER.GET_MAIL_DETAILS, [id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[mail engine] getMailDetails() -> id is " + id + " You must have a valid ID");
    } // end else if
} // End of the function
function onMailDetails(csl)
{
    var _loc1 = csl.split("|");
    getOnDetailsFunc()(_loc1);
} // End of the function
function getOnDetailsFunc()
{
    return (mail_engine.on_details_response);
} // End of the function
function setOnDetailsFunc(func)
{
    mail_engine.on_details_response = func;
} // End of the function
function setActivePostcard(obj)
{
    active_postcard = obj;
} // End of the function
function getActivePostcard()
{
    return (active_postcard);
} // End of the function
function getMailArray()
{
    return (mail_engine.mail);
} // End of the function
function getMessagesPerSet()
{
    return (mail_engine.messages_per_set);
} // End of the function
function setHasMessages(has_messages)
{
    mail_engine.has_messages = has_messages;
} // End of the function
function getHasMessages()
{
    return (mail_engine.has_messages);
} // End of the function
function getTotalMessages()
{
    return (mail_engine.total_mail);
} // End of the function
function getLastRecievedId()
{
    return (mail_engine.last_recieved_id);
} // End of the function
function setLastRecievedId(id)
{
    mail_engine.last_recieved_id = id;
} // End of the function
function setTotalMessages(tot)
{
    mail_engine.total_mail = tot;
} // End of the function
function setNewMailCountOnServer(new_count)
{
    mail_engine.new_mail_count_on_server = new_count;
} // End of the function
function getNewMailCountOnServer()
{
    return (mail_engine.new_mail_count_on_server);
} // End of the function
function updateWorldPopulations(pop_list)
{
    var _loc6 = pop_list.split("|");
    var _loc1 = 0;
    var _loc7 = _loc6.length;
    var _loc3;
    var _loc2;
    var _loc5;
    var _loc4;
    while (_loc1 < _loc7)
    {
        _loc3 = _loc6[_loc1].split(",");
        _loc5 = Number(_loc3[0]);
        _loc4 = Number(_loc3[1]);
        _loc2 = getWorldById(_loc5);
        _loc2.population = _loc4;
        _loc2.has_buddies = false;
        _loc2.rank = _loc1;
        ++_loc1;
    } // end while
} // End of the function
function setWorldsWithBuddies(buddy_list)
{
    if (!isValidString(buddy_list))
    {
        return (false);
    } // end if
    var _loc4 = buddy_list.split("|");
    var _loc3 = 0;
    var _loc6 = _loc4.length;
    var _loc2 = getWorldList();
    var _loc1 = 0;
    var _loc5 = _loc2.length;
    while (_loc3 < _loc6)
    {
        for (var _loc1 = 0; _loc1 < _loc5; ++_loc1)
        {
            if (_loc4[_loc3] == _loc2[_loc1].id)
            {
                _loc2[_loc1].has_buddies = true;
                break;
            } // end if
        } // end of for
        ++_loc3;
    } // end while
} // End of the function
function getWorldById(id)
{
    if (!isNaN(id))
    {
        var _loc2 = getWorldCrumbs();
        if (_loc2[id] != undefined)
        {
            return (_loc2[id]);
        } // end if
        $e("getWorldById() -> No world with the id of " + id + " has been defined!");
    }
    else
    {
        $e("getWorldById() -> Not a real number passed for id! id: " + id);
    } // end else if
    return;
} // End of the function
function addWorld(world_id, world_name, world_ip, world_port, is_safe)
{
    var _loc1 = getWorldById(world_id);
    if (_loc1 == undefined)
    {
        _loc1 = new Object();
        _loc1.name = world_name;
        _loc1.ip = world_ip;
        _loc1.port = world_port;
        _loc1.is_safe = is_safe;
        _loc1.id = world_id;
        _loc1.buddies = 0;
        _loc1.population = -1;
        getWorldByIdList().push(_loc1);
    }
    else
    {
        $e("addWorld() -> World with the id of " + id + " has been already been added!");
    } // end else if
} // End of the function
function setWorldForConnection(world_id)
{
    world_id_holder = world_id;
    var _loc1 = getWorldById(world_id);
    if (Number(_loc1.typeOfServer) == 2)
    {
        isSnowball = true;
    } // end if
    if (_loc1.ip != undefined && _loc1.port != undefined)
    {
        gotoState(PLAY_STATE);
    }
    else
    {
        $e("setWorldForConnection() -> Invalid IP or Port. IP: " + _loc1.ip + " Port: " + _loc1.port);
    } // end else if
} // End of the function
function connectToWorld()
{
    var _loc1 = getWorldById(world_id_holder);
    showLoading(getLocalizedString("Joining") + " " + _loc1.name);
    AIRTOWER.connectToWorld(_loc1.ip, _loc1.port, connectToWorldResponse);
} // End of the function
function getCurrentIglooBot()
{
    return (current_bot_str);
} // End of the function
function setCurrentIglooBot(str)
{
    current_bot_str = str;
} // End of the function
function hideModeratorTools()
{
    MODERATOR_TOOLS._visible = false;
} // End of the function
function hidePromptPCPP()
{
    PROMPTS._visible = false;
} // End of the function
function removeBlockedArea()
{
    disabledArea = [];
    disabledAreaRoom = 0;
    var _loc2 = _global.getCurrentEngine().getRoomMovieClip();
    _loc2.disabledArea.removeMovieClip();
    clearInterval(disabledInt);
} // End of the function
function sendDisable(playerID, x, y)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MODERATION_HANDLER + "#disable", [playerID, x, y], "str", getCurrentServerRoomId());
} // End of the function
function disableAction(playerID, action)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MODERATION_HANDLER + "#alter_perm", [playerID, action], "str", getCurrentServerRoomId());
} // End of the function
function removePlayerName(playerID)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MODERATION_HANDLER + "#pname", [playerID], "str", getCurrentServerRoomId());
} // End of the function
function sendMovePlayer(playerID, x, y)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.MODERATION_HANDLER + "#move_player", [playerID, x, y], "str", getCurrentServerRoomId());
} // End of the function
function connectToWorldResponse(success, isAgent, isGuide, isModerator, hasModifiedStampCover)
{
    if (success)
    {
        updateListeners(WORLD_CONNECT_SUCCESS);
        LOGIN_HOLDER.removeMovieClip();
        MERCH_HOLDER.removeMovieClip();
        setupStampManager();
        NPCModule = new ps.oasis.NPC.NPC(this);
        var _loc3 = getStampManager();
        _loc3.setHasModifiedStampCover(hasModifiedStampCover);
        INTERFACE.is_moderator = isModerator;
        if (isModerator)
        {
            flashExternalCall("LoadModeratorScript", true);
            OasisModeration = new ps.oasis.OasisModeration();
            INTERFACE.setupModerationTools();
        } // end if
        if (isSnowball == false)
        {
            getMyInventoryList();
            getBuddyListFromServer();
            getIgnoreListFromServer();
            startMailEngine();
            setupMailInboxModel();
            setupFieldOp();
            puffleManager.getMyPuffles();
            getSocketServerRevision();
        }
        else
        {
            getMySnowballServerInfo();
            var _loc4 = new Object();
            setMyInventoryArray(_loc4);
            puffleManager.getMyPuffles();
            updateListeners(UPDATE_INVENTORY, undefined);
        } // end else if
        com.clubpenguin.login.LocalData.setLastWorldId(world_id_holder);
        startPlayerIdleCheck();
        var _loc2 = getWorldById(world_id_holder);
        setWorldSafe(_loc2.is_safe);
        setCurrentWorld(_loc2);
        cleanupWorlds();
        ContextManager.SetContext("world");
    }
    else
    {
        $e("[shell] connectToWorldResponse() -> Connection to world failed. Sending user back to login.", {error_code: CONNECTION_TIMEOUT});
    } // end else if
} // End of the function
function cleanupWorlds()
{
    world_id_holder = undefined;
    world_response_holder = undefined;
} // End of the function
function setWorldCrumbs(obj)
{
    var _loc2 = new Object();
    var _loc3 = getLocalizedWorldCrumbs();
    var _loc1;
    for (var _loc1 in obj)
    {
        if (_loc3[_loc1].name != undefined)
        {
            _loc2[_loc1] = obj[_loc1];
            _loc2[_loc1].id = _loc1;
            _loc2[_loc1].name = _loc3[_loc1].name;
        } // end if
    } // end of for...in
    world_crumbs = _loc2;
} // End of the function
function getWorldCrumbs()
{
    return (world_crumbs);
} // End of the function
function setLocalizedWorldCrumbs(obj)
{
    localized_world_crumbs = obj;
} // End of the function
function getLocalizedWorldCrumbs()
{
    return (localized_world_crumbs);
} // End of the function
function setLoginServer(obj)
{
    login_server = obj;
} // End of the function
function getLoginServer()
{
    return (login_server);
} // End of the function
function setRedemptionServer(obj)
{
    redemption_server = obj;
} // End of the function
function getRedemptionServer()
{
    return (redemption_server);
} // End of the function
function setWebService(obj)
{
    webService = obj;
} // End of the function
function getWebService()
{
    return (webService);
} // End of the function
function getSortedWorldList()
{
    var _loc1 = getWorldCrumbs();
    var _loc3 = new Array();
    var _loc2;
    for (var _loc2 in _loc1)
    {
        _loc3.push(_loc1[_loc2]);
    } // end of for...in
    _loc3.sortOn("rank", Array.NUMERIC);
    return (_loc3);
} // End of the function
function setWorldSafe(is_safe)
{
    is_world_safe = is_safe;
} // End of the function
function isWorldSafe()
{
    return (is_world_safe);
} // End of the function
function setCurrentWorld(obj)
{
    if (obj != undefined)
    {
        current_world_obj = duplicateObject(obj);
    }
    else
    {
        $e("[shell] setCurrentWorld() World object is undefined! obj: " + obj);
    } // end else if
} // End of the function
function getCurrentWorld()
{
    return (current_world_obj);
} // End of the function
function getWorldList()
{
    var _loc1 = getWorldCrumbs();
    var _loc3 = new Array();
    var _loc2;
    for (var _loc2 in _loc1)
    {
        _loc3.push(_loc1[_loc2]);
    } // end of for...in
    return (_loc3);
} // End of the function
function addState(state_type, show, hide)
{
    var _loc2 = getStateIndex(state_type);
    if (_loc2 == -1)
    {
        getStates().push({type: state_type, hideFunc: hide, showFunc: show});
        $d("addState() -> Type: " + state_type + " show func: " + show + " hide func: " + hide);
    }
    else
    {
        $d("addState() -> State already exists!");
    } // end else if
} // End of the function
function gotoState(state_type, options)
{
    var _loc2 = getStateIndex(state_type);
    if (_loc2 != -1)
    {
        hideAllStates();
        var _loc3 = getStates();
        _loc3[_loc2].showFunc(options);
        currentState = state_type;
        updateListeners(UPDATE_SHELL_STATE, {state: state_type});
    }
    else
    {
        $d("gotoState() -> Tried to goto a state which did not exist! state_type " + state_type);
    } // end else if
} // End of the function
function getState()
{
    return (currentState);
} // End of the function
function hideAllStates()
{
    var _loc2 = getStates();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        _loc2[_loc1].hideFunc();
    } // end of for
} // End of the function
function getStateIndex(state_type)
{
    var _loc2 = getStates();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].type == state_type)
        {
            return (_loc1);
        } // end if
    } // end of for
    return (-1);
} // End of the function
function removeState(state_type)
{
    var _loc1 = getStateIndex(state_type);
    if (_loc1 != -1)
    {
        getStates().splice(_loc1, 1);
        return (true);
    } // end if
    $d("removeState() -> Tried to remove a state which did not exist!");
    return (false);
} // End of the function
function getStates()
{
    return (states_holder);
} // End of the function
function showSetup()
{
    loadLocalCrumbsFile();
} // End of the function
function loadLocalCrumbsFile()
{
    var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onLocalCrumbsLoaded));
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, mx.utils.Delegate.create(this, onLocalCrumbsLoadProgress));
    _loc2.loadClip(getLocalContentPath() + CRUMBS_PATH + LOCAL_CRUMBS_FILE, LOCAL_CRUMBS);
} // End of the function
function onLocalCrumbsLoadProgress(event)
{
    showLoadingProgress("", event.bytesLoaded, event.bytesTotal);
} // End of the function
function onLocalCrumbsLoaded(event)
{
    parseLocalCrumbsFile();
} // End of the function
function parseLocalCrumbsFile()
{
    setLocalPathsObject(LOCAL_CRUMBS.local_paths);
    setLanguageObject(LOCAL_CRUMBS.lang);
    setLocalizedErrorObject(LOCAL_CRUMBS.error_lang);
    setLocalizedCrumbsObject(LOCAL_CRUMBS.paper_crumbs);
    setLocalizedFurnitureCrumbs(LOCAL_CRUMBS.furniture_crumbs);
    setLocalizedFloorCrumbs(LOCAL_CRUMBS.floor_crumbs);
    setLocalizedIglooCrumbs(LOCAL_CRUMBS.igloo_crumbs);
    setLocalizedWorldCrumbs(LOCAL_CRUMBS.servers);
    setJokeArray(LOCAL_CRUMBS.jokes);
    setSafeMessageArray(LOCAL_CRUMBS.safe_messages);
    setTreveresdSafeMessageObject(LOCAL_CRUMBS.treveresed_safe_message_obj);
    setMascotMessageArray(LOCAL_CRUMBS.mascot_messages);
    setLineMessageArray(LOCAL_CRUMBS.script_messages);
    setQuickMessageArray(LOCAL_CRUMBS.quick_messages);
    setTourGuideMessageArray(LOCAL_CRUMBS.tour_guide_messages);
    setPostcardCrumbs(LOCAL_CRUMBS.pc_crumbs);
    setHuntCrumbs(LOCAL_CRUMBS.hunt_crumbs);
    setAchievementCrumbs(LOCAL_CRUMBS.achievement_crumbs);
    loadGlobalCrumbsFile();
} // End of the function
function loadLocalJsonfile()
{
    var _loc1 = new com.clubpenguin.util.JSONLoader();
    _loc1.addEventListener(com.clubpenguin.util.JSONLoader.COMPLETE, onLocalJsonDone);
    _loc1.load("http://media.penguinoasis.com/play/oasis/local.json");
} // End of the function
function loadGlobalCrumbsFile()
{
    var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onGlobalCrumbsLoaded));
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, mx.utils.Delegate.create(this, onGlobalCrumbsLoadProgress));
    _loc2.loadClip(getGlobalContentPath() + CRUMBS_PATH + GLOBAL_CRUMBS_FILE, GLOBAL_CRUMBS);
} // End of the function
function onGlobalCrumbsLoadProgress(event)
{
    showLoadingProgress(getLocalizedString(GLOBAL_CRUMBS_LOADING_MESSAGE), event.bytesLoaded, event.bytesTotal);
} // End of the function
function onGlobalCrumbsLoaded(event)
{
    var _loc1;
    if (isRunningLocal())
    {
        _loc1 = "http://sandbox03.play.clubpenguin.com/";
    }
    else
    {
        _loc1 = "/";
    } // end else if
    setWebService({url: _loc1});
    setGlobalPathsObject(GLOBAL_CRUMBS.global_path);
    setFurnitureCrumbsObject(GLOBAL_CRUMBS.furniture_crumbs);
    setInventoryCrumbsObject(GLOBAL_CRUMBS.paper_crumbs);
    setPlayerColoursObject(GLOBAL_CRUMBS.player_colours);
    setRoomCrumbs(GLOBAL_CRUMBS.room_crumbs);
    setFrameHackCrumbs(GLOBAL_CRUMBS.frame_hacks);
    setWorldCrumbs(GLOBAL_CRUMBS.servers);
    setLoginServer(GLOBAL_CRUMBS.login_server);
    setRedemptionServer(GLOBAL_CRUMBS.redemption_server);
    setIglooCrumbs(GLOBAL_CRUMBS.igloo_crumbs);
    setIglooOptions(GLOBAL_CRUMBS.igloo_options);
    setFloorCrumbs(GLOBAL_CRUMBS.floor_crumbs);
    setMascotCrumbs(GLOBAL_CRUMBS.mascot_crumbs);
    setMascotOptions(GLOBAL_CRUMBS.mascot_options);
    loadNewspaperCrumbs();
    InitAllConfigs();
} // End of the function
function loadNewspaperCrumbs()
{
    var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onNewspaperCrumbsLoaded));
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, mx.utils.Delegate.create(this, onNewspaperCrumbsLoadProgress));
    _loc2.loadClip(getLocalContentPath() + NEWS_PATH + NEWSPAPER_CRUMBS_FILE, NEWS_CRUMBS);
} // End of the function
function onNewspaperCrumbsLoadProgress(event)
{
    showLoadingProgress(getLocalizedString(NEWS_CRUMBS_LOADING_MESSAGE), event.bytesLoaded, event.bytesTotal);
} // End of the function
function onNewspaperCrumbsLoaded(event)
{
    setNewspaperPaths(NEWS_CRUMBS.news_paths);
    setNewspaperCrumbs(NEWS_CRUMBS.news_crumbs);
    var _loc1 = new com.clubpenguin.net.WebServiceManager();
    setWebServiceManager(_loc1);
    _loc1.addEventListener(com.clubpenguin.net.WebServiceManager.EVENT_INIT_COMPLETE, webCrumbsInitComplete);
    _loc1.init();
} // End of the function
function webCrumbsInitComplete()
{
    var _loc1 = getWebServiceManager();
    setGameCrumbs(_loc1.getServiceData(com.clubpenguin.net.WebServiceType.GAMES));
    var _loc2 = _loc1.getServiceData(com.clubpenguin.net.WebServiceType.ANALYTICS);
    var _loc5 = _loc2.omniture;
    var _loc4 = omnitureAnalytics.getContext();
    _loc4.initFromConfig(_loc5);
    var _loc6 = _loc2.web_logger;
    var _loc3 = webLoggerAnalytics.getContext();
    _loc3.initFromConfig(_loc6);
    loadBootDependencies();
} // End of the function
function showLogin()
{
    if (login_init)
    {
        LOGIN_HOLDER._visible = true;
    }
    else
    {
        loadLoginDependencies();
    } // end else if
} // End of the function
function loadLoginDependencies()
{
    loginDepLoader = new com.clubpenguin.shell.DependencyLoader(getClientPath(), dependencyHolder);
    loginDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    loginDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onLoginDependencyLoaderComplete, this);
    loginDepLoader.load(loginDependencies);
} // End of the function
function onLoginDependencyLoaderComplete()
{
    LOGIN_HOLDER = this.dependencyHolder.login;
    if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3())
    {
    } // end if
    LOGIN_HOLDER.viewManager.shell = this;
    LOGIN_HOLDER.viewManager.setLanguageAbbreviation(getLanguageAbbriviation());
    LOGIN_HOLDER.viewManager.setStartScreenXmlPath(getStartScreenXMLPath());
    LOGIN_HOLDER.viewManager.setAccessToCreatePenguinFlow(com.clubpenguin.util.Delegate.create(this, getCreateFile));
    LOGIN_HOLDER.viewManager.initialize();
    loginDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    loginDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onLoginDependencyLoaderComplete, this);
    delete loginDepLoader;
} // End of the function
function startPropPolling()
{
    __pollInterval = setInterval(checkPropStatus, PROP_INTERVAL);
} // End of the function
function checkPropStatus()
{
    if (LOGIN_HOLDER.viewManager != undefined && typeof(LOGIN_HOLDER.viewManager) == "object")
    {
        stopPropPolling();
    } // end if
} // End of the function
function stopPropPolling()
{
    clearInterval(__pollInterval);
    LOGIN_HOLDER.viewManager.shell = this;
    LOGIN_HOLDER.viewManager.setLanguageAbbreviation(getLanguageAbbriviation());
    LOGIN_HOLDER.viewManager.setStartScreenXmlPath(getStartScreenXMLPath());
    LOGIN_HOLDER.viewManager.setAccessToCreatePenguinFlow(com.clubpenguin.util.Delegate.create(this, getCreateFile));
    LOGIN_HOLDER.viewManager.initialize();
    loginDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    loginDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onLoginDependencyLoaderComplete, this);
    delete loginDepLoader;
} // End of the function
function loginLoadComplete()
{
    updateListeners(LOAD_COMPLETE, undefined);
    login_init = true;
    hideLoading();
} // End of the function
function hideLogin()
{
    LOGIN_HOLDER._visible = false;
} // End of the function
function sendLogin(username, pass, on_response)
{
    username = username.split("\n").join("");
    username = username.split("\r").join("");
    pass = pass.split("\n").join("");
    pass = pass.split("\r").join("");
    AIRTOWER.connectToLogin(username, pass, on_response);
} // End of the function
function startChatLog()
{
    room_chat_log = new Array();
    chat_log = new Array();
    updateListeners(UPDATE_CHAT_LOG, getChatLog());
} // End of the function
function addToChatLog(obj)
{
    var _loc1 = getChatLog();
    var _loc2 = _loc1.length;
    if (_loc2 > MAX_CHAT_LOG_ENTRIES)
    {
        delete _loc1[_loc2];
        _loc1.shift();
    } // end if
    _loc1.push(obj);
    updateListeners(UPDATE_CHAT_LOG, getChatLog());
} // End of the function
function isPlayerInChatLog(player_id)
{
    var _loc2 = getChatLog();
    var _loc3 = _loc2.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if (_loc2[_loc1].player_id == player_id)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function getChatLog()
{
    return (chat_log);
} // End of the function
function setupPlay()
{
    if (!play_state_init)
    {
        loadJoinDependencies();
    }
    else
    {
        ENGINE._visible = true;
        INTERFACE._visible = true;
    } // end else if
} // End of the function
function hidePlay()
{
} // End of the function
function sendHitToVerify(id, ball_x, ball_y)
{
    if (!isNaN(id))
    {
        AIRTOWER.send(AIRTOWER.GAME_EXT, "hit", [ball_x, ball_y, id], "str", getCurrentServerRoomId());
    }
    else
    {
        $e("[shell] sendHitToVerify() -> NaN - id: " + id);
    } // end else if
} // End of the function
function loadJoinDependencies()
{
    OasisPermission = new ps.oasis.OasisPermission();
    if (_global.getCurrentShell().OasisPermission.hasPermission("a", AIRTOWER.login_data.split("|")[4], "ban"))
    {
        var _loc3 = new Object();
        _loc3.id = "moderator_tools";
        _loc3.title = "Moderator Tools";
        joinDependencies.push(_loc3);
    } // end if
    playDepLoader = new com.clubpenguin.shell.DependencyLoader(getClientPath(), dependencyHolder);
    playDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    playDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onJoinDependencyLoaderComplete, this);
    playDepLoader.load(joinDependencies, isSnowball);
} // End of the function
function onJoinDependencyLoaderComplete()
{
    joinDependencyLoaderCompleteRouter();
    playDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    playDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onJoinDependencyLoaderComplete, this);
    delete playDepLoader;
} // End of the function
function joinDependencyLoaderCompleteRouter()
{
    joinDependencyLoaderComplete();
} // End of the function
function joinDependencyLoaderComplete()
{
    POSTCARDS = this.dependencyHolder.book;
    MAIL = this.dependencyHolder.mail;
    GRIDVIEW = this.dependencyHolder.gridview;
    ENGINE = this.dependencyHolder.engine;
    INTERFACE = this.dependencyHolder.INTERFACE;
    PROMPTS = this.dependencyHolder.prompts;
    PROMPTS.swapDepths(INTERFACE.getDepth() + 1);
    PROMPTS._visible = false;
    MODERATOR_TOOLS = this.dependencyHolder.moderator_tools;
    MODERATOR_TOOLS._visible = false;
    ENGINE.setDependencies(this, INTERFACE);
    ENGINE.init();
    INTERFACE.setDependencies(this, ENGINE);
    INTERFACE.init();
    if (INTERFACE == undefined)
    {
        showErrorPrompt("MAX", "Oops! Please re-login! There was an error loading the interface!", "Okay", onErrorIntF, "e9");
        return;
    } // end if
    updateListeners(START_INTERFACE, {mc: INTERFACE});
    updateListeners(START_ENGINE, {mc: ENGINE});
    InitGameTuning();
    connectToWorld();
    play_state_init = true;
} // End of the function
function onErrorIntF()
{
    getURL("http://play.oasis.ps");
} // End of the function
function joinDependencyLoaderCompleteAS3()
{
    POSTCARDS = this.dependencyHolder.book;
    MAIL = this.dependencyHolder.mail;
    GRIDVIEW = this.dependencyHolder.gridview;
    ENGINE = this.dependencyHolder.engine;
    INTERFACE = this.dependencyHolder.INTERFACE;
    ENGINE.setDependencies(this, INTERFACE);
    ENGINE.init();
    if (this.dependencyHolder.INTERFACE.interface_mc.READY != true)
    {
        var classInstance = this;
        _root.onEnterFrame = function ()
        {
            if (classInstance.dependencyHolder.INTERFACE.interface_mc.READY == true)
            {
                classInstance.joinDependencyLoaderComplete();
                delete _root.onEnterFrame;
            } // end if
        };
        return;
    } // end if
    INTERFACE.setDependencies(this, ENGINE);
    INTERFACE.init();
    updateListeners(START_INTERFACE, {mc: INTERFACE});
    updateListeners(START_ENGINE, {mc: ENGINE});
    connectToWorld();
    play_state_init = true;
} // End of the function
function setupEdit()
{
    $d("[edit state] -> Setup edit state");
} // End of the function
function hideEdit()
{
    $d("[edit state] -> hide edit state");
} // End of the function
function showMerch()
{
    loadMerchDependencies();
} // End of the function
function loadMerchDependencies()
{
    merchDepLoader = new com.clubpenguin.shell.DependencyLoader(getClientPath(), dependencyHolder);
    merchDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    merchDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onMerchDependencyLoaderComplete, this);
    merchDepLoader.load(merchDependencies);
} // End of the function
function onMerchDependencyLoaderComplete()
{
    merchDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    merchDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onMerchDependencyLoaderComplete, this);
    delete merchDepLoader;
    MERCH_HOLDER = this.dependencyHolder.app;
    var _loc3 = getClientPath() + "merch/";
    if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3())
    {
        __delayInterval = setInterval(delayClassInstantiation, INTERVAL_RATE);
    }
    else
    {
        var _loc2 = new com.clubpenguin.merch.App(MERCH_HOLDER, _loc3, this, AIRTOWER);
        _loc2.init();
    } // end else if
} // End of the function
function delayClassInstantiation()
{
    var _loc3 = MERCH_HOLDER._parent._parent;
    var _loc2 = getClientPath() + "merch/";
    var _loc1 = new com.clubpenguin.merch.App(MERCH_HOLDER, _loc2, _loc3, AIRTOWER);
    if (_loc1 != undefined)
    {
        _loc1.init();
    } // end if
    clearInterval(__delayInterval);
} // End of the function
function hideMerch()
{
    MERCH_HOLDER._visible = false;
} // End of the function
function setupMailState()
{
    ENGINE._visible = false;
    INTERFACE._visible = false;
} // End of the function
function hideMailState()
{
    ENGINE._visible = true;
    INTERFACE._visible = true;
} // End of the function
function addCookie(type, key, value)
{
    if (!isValidCookieType(type))
    {
        $e("[shell] addCookie() -> Invalid cookie type! type: " + key);
        return (false);
    } // end if
    if (!isValidString(key))
    {
        $e("[shell] addCookie() -> Key is not a real string! key: " + key);
        return (false);
    } // end if
    if (value == undefined || value == null)
    {
        $e("[shell] addCookie() -> Value is not defined! value: " + value);
        return (false);
    } // end if
    var _loc3 = getCookieArray();
    var _loc4 = type + key;
    if (_loc3[_loc4] == undefined)
    {
        _loc3[_loc4] = duplicateObject(value);
    }
    else
    {
        var _loc1;
        for (var _loc1 in value)
        {
            _loc3[_loc4][_loc1] = value[_loc1];
        } // end of for...in
    } // end else if
    return (true);
} // End of the function
function getCookie(type, key)
{
    if (!isValidCookieType(type))
    {
        $e("[shell] getCookie() -> Invalid cookie type!. type: " + key);
        return;
    } // end if
    if (!isValidString(key))
    {
        $e("[shell] getCookie() -> Key is not a real string! key: " + key);
        return;
    } // end if
    var _loc2 = getCookieArray();
    if (_loc2[type + key] == undefined)
    {
        $e("[shell] getCookie() -> Could not find a cookie with that key! key: " + key);
        return;
    } // end if
    return (_loc2[type + key]);
} // End of the function
function deleteCookie(type, key)
{
    if (!isValidCookieType(type))
    {
        $e("[shell] deleteCookie() -> Invalid cookie type!. type: " + key);
        return;
    } // end if
    if (!isValidString(key))
    {
        $e("[shell] deleteCookie() -> Key is not a real string! key: " + key);
        return (false);
    } // end if
    var _loc2 = getCookieArray();
    if (_loc2[type + key] == undefined)
    {
        $e("[shell] deleteCookie() -> Tried to delete a cookie which did not exist! key: " + key);
        return (false);
    } // end if
    _loc2[type + key] = undefined;
    delete _loc2[type + key];
    return (true);
} // End of the function
function listCookies()
{
    var _loc2;
    var _loc1 = getCookieArray();
    for (var _loc2 in _loc1)
    {
        dumpObject(_loc1[_loc2]);
    } // end of for...in
} // End of the function
function isValidCookieType(type)
{
    switch (type)
    {
        case GAME_COOKIE:
        {
            return (true);
        } 
        case MISSION_COOKIE:
        {
            return (true);
        } 
        case CLIENT_COOKIE:
        {
            return (true);
        } 
        case PARTY_COOKIE:
        {
            return (true);
        } 
    } // End of switch
    return (false);
} // End of the function
function getCookieArray()
{
    if (client_cookies == undefined)
    {
        client_cookies = new Array();
    } // end if
    return (client_cookies);
} // End of the function
function setCookieArray(arr)
{
    client_cookies = arr;
} // End of the function
function donateToCharity(id, coin_amount)
{
    if (isNaN(id))
    {
        $d("[shell] donateToCharity() -> Id was not a real number! id: " + id);
        return (false);
    } // end if
    if (isNaN(coin_amount))
    {
        $d("[shell] donateToCharity() -> Coin amount was not a real number! coin_amount: " + coin_amount);
        return (false);
    } // end if
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.SURVEY_HANDLER + "#" + AIRTOWER.DONATE, [id, coin_amount], "str", getCurrentServerRoomId());
    return (true);
} // End of the function
function attachDonateListenersToAirtower()
{
} // End of the function
function trackEvent(eventName, data)
{
    debugTrace("shell.trackEvent(" + eventName + ", " + data + ")");
    for (var _loc1 = 0; _loc1 < analyticLoggers.length; ++_loc1)
    {
        analyticLoggers[_loc1].trackEvent(eventName, data);
    } // end of for
} // End of the function
function trackContent(itemName, data)
{
    debugTrace("shell.trackContent(" + itemName + ", " + data + ")");
    for (var _loc1 = 0; _loc1 < analyticLoggers.length; ++_loc1)
    {
        analyticLoggers[_loc1].trackContent(itemName, data);
    } // end of for
} // End of the function
function trackRoomJoin(roomName, data)
{
    debugTrace("shell.trackRoomJoin(" + roomName + ", " + data + ")");
    for (var _loc1 = 0; _loc1 < analyticLoggers.length; ++_loc1)
    {
        analyticLoggers[_loc1].trackRoomJoin(roomName, data);
    } // end of for
} // End of the function
function trackIglooJoin(data)
{
    debugTrace("shell.trackIglooJoin(" + data + ")");
    for (var _loc1 = 0; _loc1 < analyticLoggers.length; ++_loc1)
    {
        analyticLoggers[_loc1].trackIglooJoin(data);
    } // end of for
} // End of the function
function trackMiniGame(gameName, data)
{
    debugTrace("shell.trackMiniGame(" + gameName + ", " + data + ")");
    for (var _loc1 = 0; _loc1 < analyticLoggers.length; ++_loc1)
    {
        analyticLoggers[_loc1].trackMiniGame(gameName, data);
    } // end of for
} // End of the function
function debugTrace(msg)
{
    if (DEBUG_MODE)
    {
    } // end if
} // End of the function
function createTimeout(key, time, func, params, scope)
{
    if (!isValidString(key))
    {
        $d("[shell] createTimeout() -> Passed in key is not a valid string! key: " + key);
        return (false);
    } // end if
    if (getTimeoutByKey(key) != undefined)
    {
        $d("[shell] createTimeout() -> Timeout object already exists! key: " + key);
        return (false);
    } // end if
    if (isNaN(time) || time <= 0)
    {
        $d("[shell] createTimeout() -> Passed in time is not a valid number! time: " + time);
        return (false);
    } // end if
    if (func == undefined)
    {
        $d("[shell] createTimeout() -> Passed in func is not a valid function! func: " + func);
        return (false);
    } // end if
    var _loc2 = new com.clubpenguin.util.Timeout(time, func, params, scope);
    _loc2.__set__onStop(handleOnTimeoutStop);
    _loc2.start();
    timeouts[key] = _loc2;
} // End of the function
function stopTimeoutByKey(key)
{
    var _loc1 = getTimeoutByKey(key);
    if (_loc1 == undefined)
    {
        $d("[shell] stopTimeoutByKey() -> Timeout object is undefined! key: " + key);
        return (false);
    } // end if
    _loc1.stop();
} // End of the function
function getTimeoutByKey(key)
{
    if (!isValidString(key))
    {
        $d("[shell] getTimeoutByKey() -> Passed in key is not a valid string! key: " + key);
        return;
    } // end if
    return (timeouts[key]);
} // End of the function
function setupRootContextMenu()
{
    ContextManager = new ps.oasis.ContextManager();
    ContextManager.SetContext("login");
} // End of the function
function getSocketServerRevision()
{
    AIRTOWER.addListener(AIRTOWER.GET_LAST_REVISION, this.handleSocketServerRevision, this);
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.PLAYER_HANDLER + "#" + AIRTOWER.GET_LAST_REVISION, [], "str", getCurrentServerRoomId());
} // End of the function
function loadBootDependencies()
{
    bootDepLoader = new com.clubpenguin.shell.DependencyLoader(getClientPath(), dependencyHolder);
    bootDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    bootDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onBootDependencyLoaderComplete, this);
    bootDepLoader.load(bootDependencies);
} // End of the function
function onBootDependencyLoaderComplete(event)
{
    bootDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    bootDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onBootDependencyLoaderComplete, this);
    delete bootDepLoader;
    AIRTOWER = new com.clubpenguin.net.Airtower(this, getLoginServer());
    SENTRY = this.dependencyHolder.sentry;
    MUSIC = new com.clubpenguin.shell.Music(dependencyHolder.createEmptyMovieClip("music", dependencyHolder.getNextHighestDepth()));
    heartbeat = new com.clubpenguin.util.Heartbeat(SHELL, AIRTOWER);
    puffleModelManager = new com.clubpenguin.shell.PuffleModelManager(this);
    puffleManager = new com.clubpenguin.shell.PuffleManager(this, AIRTOWER, GLOBAL_CRUMBS.puffle_crumbs, puffleModelManager);
    puffleManager.init();
    MAX_PUFFLES = com.clubpenguin.shell.PuffleManager.MAX_PUFFLES;
    attachShellListenersToAirtower();
    setupServices();
    var _loc2 = getEnvironment();
    if (_loc2 == ENV_LIVE || _loc2 == ENV_STAGE)
    {
    } // end if
    InitLoginConfigs();
    hideLoading();
    gotoState(LOGIN_STATE);
} // End of the function
function getCreateFile()
{
    createDepLoader = new com.clubpenguin.shell.DependencyLoader(getClientPath(), dependencyHolder);
    createDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    createDepLoader.addEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onCreateDependencyLoaderComplete, this);
    createDepLoader.load(createDependencies);
} // End of the function
function onCreateDependencyLoaderComplete()
{
    LOGIN_HOLDER.removeMovieClip();
    createDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.PROGRESS, onDependencyLoaderProgress, this);
    createDepLoader.removeEventListener(com.clubpenguin.shell.DependencyLoader.COMPLETE, onCreateDependencyLoaderComplete, this);
    delete createDepLoader;
    hideLoading();
    var _loc3 = dependencyHolder.create;
    var _loc2 = _loc3.mainView;
    _loc2.setDependencies(this, this.getLanguageAbbreviation(), this.getAffiliateID(), this.getPromotionID());
    _loc2.init();
} // End of the function
function onDependencyLoaderProgress(event)
{
    if (event.dependencyTitle == "Moderator Tools")
    {
        showLoadingProgress("Loading " + event.dependencyTitle, event.bytesLoaded, event.bytesTotal);
    }
    else
    {
        showLoadingProgress(getLocalizedString("Loading " + event.dependencyTitle), event.bytesLoaded, event.bytesTotal);
    } // end else if
} // End of the function
function setBootData(data)
{
    setAffilateId(data.affiliateID);
    setPromotionID(data.promotionID);
    setLanguageAbbreviation(data.language);
    setLocalizedFolder(data.language);
    setBootPaths(data);
    setFieldOpWeek(data.fieldOp);
    var _loc2 = new com.clubpenguin.util.JSONLoader();
    _loc2.addEventListener(com.clubpenguin.util.JSONLoader.COMPLETE, onJsonCompleteHandler);
    _loc2.load(getClientPath() + DEPENDENCIES_FILENAME);
} // End of the function
function onJsonCompleteHandler(event)
{
    bootDependencies = event.target.data.boot;
    loginDependencies = event.target.data.login;
    createDependencies = event.target.data.create;
    merchDependencies = event.target.data.merch;
    joinDependencies = event.target.data.join;
    gotoState(SETUP_STATE);
} // End of the function
function setCommunicationBridge(_swfBridge)
{
    swfBridge = _swfBridge;
} // End of the function
function sendOpenAS3Module(name, data)
{
    swfBridge.send(AS3_GATEWAY_METHOD, {type: MSG_OPEN_MODULE, name: name, data: data});
} // End of the function
function sendCloseDialog()
{
    swfBridge.send(AS3_GATEWAY_METHOD, {type: MSG_CLOSE_DIALOG});
} // End of the function
function sendMyPlayerData(myGenericPlayerObject)
{
    swfBridge.send(AS3_GATEWAY_METHOD, {type: MSG_MAKE_PLAYER_VO, myGenericPlayerObject: myGenericPlayerObject});
} // End of the function
function sendGetNinjaLevel()
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.NINJA_HANDLER + "#" + AIRTOWER.GET_NINJA_LEVEL, [], AIRTOWER.STRING_TYPE, getCurrentServerRoomId());
} // End of the function
function sendGetCards()
{
    if (!cardsRequested)
    {
        AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.NINJA_HANDLER + "#" + AIRTOWER.GET_CARDS, [], AIRTOWER.STRING_TYPE, getCurrentServerRoomId());
        cardsRequested = true;
    }
    else
    {
        $d("[SHELL] sendGetCards() -> Not sending request for cards as it has already been sent.");
        updateListeners(GET_CARDS, {cards: cardsCache});
    } // end else if
} // End of the function
function sendGetNinjaRanks(playerID)
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.NINJA_HANDLER + "#" + AIRTOWER.GET_NINJA_RANKS, [playerID], AIRTOWER.STRING_TYPE, getCurrentServerRoomId());
} // End of the function
function sendSaveOutfit(outfitName, playerId)
{
    outfitName = outfitName.split("\n").join("");
    outfitName = outfitName.split("\r").join("");
    if (outfitName.length > 25)
    {
        return (showErrorPrompt("max", "Please enter a shorter outfit name (< 25)", "Okay", undefined, "EOUTFIT"));
    } // end if
    if (outfitName.length < 3)
    {
        return (showErrorPrompt("max", "Please enter a longer outfit name (> 3)", "Okay", undefined, "EOUTFIT"));
    } // end if
    var _loc1 = getPlayerObjectById(playerId);
    AIRTOWER.send(AIRTOWER.PLAY_EXT, "outfit#osave", [_loc1.colour_id, _loc1.head, _loc1.face, _loc1.neck, _loc1.body, _loc1.hand, _loc1.feet, _loc1.playercard_attributes.f, outfitName], AIRTOWER.STRING_TYPE, getCurrentServerRoomId());
} // End of the function
function sendGetFireLevel()
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.NINJA_HANDLER + "#" + AIRTOWER.GET_FIRE_LEVEL, [], AIRTOWER.STRING_TYPE, getCurrentServerRoomId());
} // End of the function
function sendGetWaterLevel()
{
    AIRTOWER.send(AIRTOWER.PLAY_EXT, AIRTOWER.NINJA_HANDLER + "#" + AIRTOWER.GET_WATER_LEVEL, [], AIRTOWER.STRING_TYPE, getCurrentServerRoomId());
} // End of the function
function setupServices()
{
    currentRoomService = new com.clubpenguin.services.CurrentRoomService(AIRTOWER.server);
    equipmentService = new com.clubpenguin.services.EquipmentService(AIRTOWER.server);
    epfService = new com.clubpenguin.services.EPFService(AIRTOWER.server);
    mailService = new com.clubpenguin.services.MailService(AIRTOWER.server);
} // End of the function
function getCurrentRoomService()
{
    return (currentRoomService);
} // End of the function
function getEquipmentService()
{
    return (equipmentService);
} // End of the function
function getEPFService()
{
    return (epfService);
} // End of the function
function getMailService()
{
    return (mailService);
} // End of the function
function setupMailInboxModel()
{
    mailService.__get__postCardReceived().add(onPostCardReceived, this);
    mailService.__get__inboxReceived().add(onInboxReceived, this);
    mailService.getInbox();
} // End of the function
function onInboxReceived(receivedInbox)
{
    if (!inbox)
    {
        inbox = receivedInbox;
    } // end if
} // End of the function
function onPostCardReceived(postCard)
{
    inbox.addPostCard(postCard);
} // End of the function
function getInbox()
{
    return (inbox);
} // End of the function
function setupFieldOp()
{
    var _loc2;
    if (isRunningLocal())
    {
        _loc2 = "http://sandbox03.play.clubpenguin.com/";
    }
    else
    {
        _loc2 = "/";
    } // end else if
    _loc2 = _loc2 + (getLanguageAbbreviation() + FIELD_OPS_SERVICE);
    if (SHELL.fieldOpWeek != "" && SHELL.fieldOpWeek != "undefined" && SHELL.fieldOpWeek != undefined)
    {
        _loc2 = _loc2 + ("?field_op=" + SHELL.fieldOpWeek);
    } // end if
    var _loc3 = new com.clubpenguin.util.JSONLoader();
    _loc3.addEventListener(com.clubpenguin.util.JSONLoader.COMPLETE, onJSONLoaded, this);
    _loc3.load(_loc2);
} // End of the function
function onJSONLoaded(event)
{
    jsonLoader.removeEventListener(com.clubpenguin.util.JSONLoader.COMPLETE, onJsonCompleteHandler, this);
    var _loc3 = event.target.data;
    var _loc2 = com.clubpenguin.fieldop.FieldOp.getFieldOpFromObject(_loc3);
    fieldOp.roomID = _loc2.roomID;
    fieldOp.description = _loc2.description;
    fieldOp.gameName = _loc2.gameName;
    fieldOp.hit = _loc2.hit;
    fieldOp.x = _loc2.x;
    fieldOp.y = _loc2.y;
    fieldOp.task = _loc2.task;
} // End of the function
function getFieldOp()
{
    return (fieldOp);
} // End of the function
function setInterfaceForStampNotifier(_interface)
{
    stampNotifier.__set___interface(_interface);
} // End of the function
function getStampManager()
{
    return (stampManager);
} // End of the function
function setupStampManager()
{
    stampManager = new com.clubpenguin.stamps.StampManager(this, AIRTOWER.server);
    com.clubpenguin.stamps.stampbook.StampBook.__set__shell(this);
    com.clubpenguin.stamps.stampbook.StampBook.__set__stampManager(stampManager);
} // End of the function
function stampIsOwnedByMe(stampID)
{
    return (stampManager.stampIsOwnedByMe(stampID));
} // End of the function
function setPauseStampNotification(pause)
{
    stampNotifier.__set__pauseNotification(pause);
} // End of the function
function stampEarned(stampID, isServerSide)
{
    if (isServerSide == undefined)
    {
        isServerSide = false;
    } // end if
    if (stampIsOwnedByMe(stampID))
    {
        return;
    } // end if
    var _loc1 = (com.clubpenguin.stamps.IStampItem)(stampManager.getStampBookItem(stampID, com.clubpenguin.stamps.StampBookItemType.STAMP.__get__value()));
    if (_loc1 != undefined)
    {
        stampManager.setRecentlyEarnedStamp(stampID, isServerSide);
        stampNotifier.add(_loc1);
    }
    else
    {
        $e("[SHELL] stampEarned() -> Was told that a stamp which does not exist has been earned. stampID: " + stampID);
    } // end else if
} // End of the function
function showJSError(errorId, _arg)
{
    flash.external.ExternalInterface.call("Oasis.Error.DisplayError", errorId, _arg);
} // End of the function
function InitAllConfigs()
{
    ps.oasis.OasisLogger.debug("Setting up InitAllConfigs");
    var conf = _global._configuration;
    if (conf.client.enabled == false)
    {
        return (showErrorPrompt(undefined, conf.client.message.msg, conf.client.message.btn, function ()
        {
            getURL(conf.client.message.url, "");
        }, conf.client.message.sl));
    } // end if
    if (_global.confContext == undefined)
    {
        _global.confContext = new ContextMenuItem("Version: " + _global._configuration.client.revision);
        _global.confContext.contextId = i;
        _global.confContext.onSelect = function (obj, contextItem)
        {
            _global.getCurrentShell().showJSError(401, _global._configuration.client.revision);
        };
        _global.confContext.enabled = true;
        var _loc6 = _root.menu.customItems.push(_global.confContext);
    } // end if
    for (var _loc4 in _global._configuration.tuning.banned_items)
    {
        banned_items[Number(_global._configuration.tuning.banned_items[_loc4])] = true;
    } // end of for...in
    if (client_rev != conf.client.revision)
    {
        showJSError(400);
    } // end if
    for (var _loc3 in conf.tuning.shell)
    {
        _global.getCurrentShell()[_loc3] = conf.tuning.shell[_loc3];
    } // end of for...in
    false;
    for (var _loc5 in conf.tuning.rooms)
    {
        room_crumbs[Number(_loc5)] = conf.tuning.rooms[Number(_loc5)];
    } // end of for...in
} // End of the function
function InitLoginConfigs()
{
    ps.oasis.OasisLogger.debug("Setting up InitLoginConfigs");
    var _loc2 = _global._configuration;
    for (var _loc3 in _loc2.tuning.airtower)
    {
        _global.getCurrentAirtower()[_loc3] = _loc2.tuning.airtower[_loc3];
    } // end of for...in
    false;
} // End of the function
function InitGameTuning()
{
    ps.oasis.OasisLogger.debug("Setting up InitGameTuning");
    var _loc2 = _global._configuration;
    for (var _loc3 in _loc2.tuning.engine)
    {
        _global.getCurrentEngine()[_loc3] = _loc2.tuning.engine[_loc3];
    } // end of for...in
    false;
    for (var _loc3 in _loc2.tuning.interface)
    {
        _global.getCurrentInterface()[_loc3] = _loc2.tuning.interface[_loc3];
    } // end of for...in
    false;
} // End of the function
function updateWorldsInfo(obj)
{
    var _loc6 = obj.split("|");
    var _loc2 = 0;
    var _loc7 = _loc6.length;
    var _loc1;
    var _loc3;
    var _loc5;
    var _loc4;
    while (_loc2 < _loc7)
    {
        _loc1 = _loc6[_loc2].split(",");
        _loc5 = Number(_loc1[0]);
        _loc4 = Number(_loc1[1]);
        _loc8 = _loc1[2];
        _loc9 = Number(_loc1[4]);
        _loc3 = getWorldById(_loc5);
        _loc3.onlineUsers = _loc4;
        _loc3.onlineBuds = _loc8;
        _loc3.rank = _loc2;
        ++_loc2;
    } // end while
} // End of the function
function updateWorldsList(obj)
{
    var _loc6 = obj.split("|");
    var _loc2 = 0;
    var _loc7 = _loc6.length;
    var _loc1;
    var _loc3;
    var _loc5;
    var _loc4;
    while (_loc2 < _loc7)
    {
        _loc1 = _loc6[_loc2].split(",");
        _loc5 = Number(_loc1[0]);
        _loc4 = Number(_loc1[1]);
        _loc8 = _loc1[2];
        _loc9 = Number(_loc1[4]);
        _loc3 = getWorldById(_loc5);
        _loc3.onlineUsers = _loc4;
        _loc3.onlineBuds = _loc8;
        _loc3.rank = _loc2;
        ++_loc2;
    } // end while
} // End of the function
function handleServerError(obj)
{
    var _loc1 = obj.concat();
    var _loc3 = Number(_loc1.shift());
    var _loc2 = Number(_loc1[0]);
    _loc1.type = SOCKET_ERROR;
    initErrorByCode(_loc2, _loc1);
} // End of the function
function handleConnectionLost()
{
    var _loc1 = new Object();
    _loc1.type = SOCKET_ERROR;
    _loc1.error_code = SOCKET_LOST_CONNECTION;
    initErrorByCode(_loc1.error_code, _loc1);
} // End of the function
function handleBlockSpace(obj)
{
    obj.shift();
    var _loc7 = obj.shift();
    var _loc5 = obj.shift();
    var _loc4 = obj.shift();
    var _loc6 = obj.shift();
    var _loc2 = _global.getCurrentEngine().getRoomMovieClip();
    disabledArea = [_loc5, _loc4];
    disabledAreaRoom = getCurrentRoomId();
    _loc2.disabledArea.removeMovieClip();
    _loc2.createEmptyMovieClip("disabledArea", 100);
    com.clubpenguin.util.DrawUtil.drawCircle(_loc2.disabledArea, new flash.geom.Point(0, 0), 50, 16711680, 16711680, 1);
    _loc2.disabledArea._alpha = 50;
    _loc2.disabledArea._x = _loc5;
    _loc2.disabledArea._y = _loc4;
    _loc2.disabledArea.onRelease = function ()
    {
        handleShowPrompt([-1, 2]);
        return (false);
    };
    _loc2.disabledArea.useHandCursor = false;
    disabledInt = setInterval(removeBlockedArea, _loc6);
} // End of the function
function handleWarning(obj)
{
    obj.shift();
    var _loc2 = obj.shift();
    _global.getCurrentShell().showErrorPrompt(WINDOW_SIZE[WINDOW_LARGE], "You have been warned for: " + _loc2, "Okay", undefined, "warn");
} // End of the function
function handleShowPrompt(obj)
{
    obj.shift();
    PROMPTS._visible = true;
    PROMPTS.gotoAndStop(obj.shift());
    PROMPTS.block_mc.onRelease = function ()
    {
    };
    PROMPTS.block_mc.useHandCursor = false;
    PROMPTS.actionButton.onRelease = function ()
    {
        _global.getCurrentShell().hidePromptPCPP();
    };
    PROMPTS.abuse_btn.onRelease = function ()
    {
        _global.getCurrentShell().hidePromptPCPP();
        _global.getCurrentShell().showErrorPrompt(undefined, "If you think this was abuse, open a ticket: https://account.oasis.ps/support - select the \"Moderator Abuse\" category.", "Okay", undefined, "abuse");
    };
} // End of the function
function handleJoinGame(obj)
{
    if (getCurrentGameRoomId() == undefined)
    {
        var _loc2 = Number(obj.shift());
        var _loc1 = Number(obj.shift());
        if (getCurrentRoomId() != _loc1)
        {
            setCurrentServerRoomId(_loc2);
            my_game = getGameCrumbsById(_loc1);
            my_game.smart_room_id = _loc2;
            setLastRoomId(getCurrentRoomId());
            setCurrentRoomId(_loc1);
            setIsRoomIgloo(false);
            if (my_game != undefined)
            {
                updateListeners(JOIN_GAME, null);
                trackMiniGame(my_game.name);
            }
            else
            {
                $e("[shell] handleJoinGame() -> Tried to join an invalid game: " + obj);
            } // end else if
        }
        else
        {
            $e("[shell] handleJoinGame() -> Tried to join a room while your already in it! room_id: " + _loc1);
        } // end else if
    }
    else
    {
        $e("[shell] handleJoinGame() -> Tried to join a room while in a game room!", {error_code: PLAYER_IN_ROOM});
    } // end else if
} // End of the function
function handleGameOver(params)
{
    var _loc13 = Number(params.shift());
    var _loc6 = Number(params.shift());
    var _loc10 = getMyPlayerTotalCoins();
    var _loc8 = _loc6 - _loc10;
    var _loc7 = params.shift();
    var _loc2 = _loc7.split("|");
    var _loc4 = new Array();
    if (_loc7.length > 0)
    {
        for (var _loc1 = 0; _loc1 < _loc2.length; ++_loc1)
        {
            _loc4.push(Number(_loc2[_loc1]));
        } // end of for
    } // end if
    var _loc11 = Number(params.shift());
    var _loc9 = Number(params.shift());
    var _loc12 = Number(params.shift());
    var _loc3 = new Object();
    _loc3.total = _loc6;
    _loc3.earned = _loc8;
    _loc3.is_table = false;
    _loc3.stampIds = _loc4;
    _loc3.totalNumberOfGameStampsEarned = _loc11;
    _loc3.numberOfGameStamps = _loc9;
    _loc3.totalNumberOfStamps = _loc12;
    if (getCurrentGameRoomId() != undefined)
    {
        _loc3.is_table = true;
    } // end if
    setMyPlayerTotalCoins(_loc6);
    updateListeners(GAME_OVER, _loc3);
} // End of the function
function handleUpdateTableById(obj)
{
    var _loc3 = obj.shift();
    var _loc1 = new Object();
    _loc1.table_id = Number(obj[0]);
    _loc1.num_players = Number(obj[1]);
    updateListeners(UPDATE_TABLE, _loc1);
} // End of the function
function handleGetTablesPopulationById(obj)
{
    var _loc7 = obj.shift();
    var _loc2;
    var _loc1;
    for (var _loc2 in obj)
    {
        _loc1 = obj[_loc2].split("|");
        handleUpdateTableById({smart_id: _loc7, table_id: _loc1[0], num_players: _loc1[1]});
    } // end of for...in
} // End of the function
function handleSendJoinTableById(obj)
{
    var _loc2 = obj.shift();
    setCurrentGameRoomId(_loc2);
    var _loc1 = new Object();
    _loc1.table_id = Number(obj[0]);
    _loc1.seat_id = Number(obj[1]);
    updateListeners(JOIN_TABLE, _loc1);
} // End of the function
function handleLeaveTable()
{
    updateListeners(LEAVE_TABLE, undefined);
} // End of the function
function handleJoinWaddle(obj)
{
    handleJoinGame(obj);
} // End of the function
function handleGetWaddlesPopulationById(obj)
{
    var _loc9 = obj.shift();
    var _loc5;
    var _loc3;
    var _loc2;
    var _loc1;
    var _loc4;
    for (var _loc5 in obj)
    {
        _loc1 = 0;
        _loc3 = obj[_loc5].split("|");
        _loc2 = _loc3[1].split(",");
        _loc4 = _loc2.length;
        while (_loc1 < _loc4)
        {
            if (!isValidString(_loc2[_loc1]))
            {
                _loc2[_loc1] = undefined;
            } // end if
            ++_loc1;
        } // end while
        handleUpdateWaddlePopulationById({waddle_id: _loc3[0], player_list: _loc2});
    } // end of for...in
} // End of the function
function handleUpdateWaddlePopulationById(obj)
{
    var _loc3 = obj.player_list.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        updateWaddleList(obj.waddle_id, _loc1, obj.player_list[_loc1]);
    } // end of for
    updateListeners(UPDATE_WADDLE, obj);
} // End of the function
function handleUpdateWaddle(obj)
{
    var _loc6 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    var _loc4 = obj[2];
    updateWaddleList(_loc2, _loc3, _loc4);
    var _loc5 = getWaddleById(_loc2);
    updateListeners(UPDATE_WADDLE, _loc5);
} // End of the function
function handleSendJoinWaddleById(obj)
{
    var _loc4 = obj.shift();
    var _loc1 = Number(obj[0]);
    updateListeners(JOIN_WADDLE, {seat_id: _loc1});
} // End of the function
function handleLeaveWaddle()
{
    updateListeners(LEAVE_WADDLE, undefined);
} // End of the function
function handleJoinRoom(obj)
{
    if (getCurrentGameRoomId() == undefined)
    {
        var _loc2 = obj[1];
        playerJoinedRoom.dispatch();
        if (_loc2 < PLAYER_ROOM_SMART_ID_CUTOFF)
        {
            handleJoinWorldRoom(obj);
        }
        else
        {
            handleJoinPlayerIgloo(obj);
        } // end else if
    }
    else
    {
        $e("[shell] sendJoinRoom() -> Tried to join a room while in a game room!", {error_code: PLAYER_IN_ROOM});
    } // end else if
    AIRTOWER.server.enableCommands();
} // End of the function
function handleRefreshRoom(obj)
{
    handleRefreshWorldRoom(obj);
} // End of the function
function handleJoinWorldRoom(obj)
{
    if (getCurrentGameRoomId() == undefined)
    {
        var _loc5 = obj.shift();
        var _loc4 = obj.shift();
        setCurrentServerRoomId(_loc5);
        my_room = getRoomCrumbsById(_loc4);
        if (my_room != undefined)
        {
            var _loc3 = new Array();
            var _loc2;
            setCurrentCrumbRoomId(my_room.room_id);
            for (var _loc2 in obj)
            {
                _loc3.push(makePlayerObjectFromString(obj[_loc2]));
            } // end of for...in
            if (getCurrentRoomId() == undefined)
            {
                setCurrentRoomId(_loc4);
            } // end if
            setLastRoomId(getCurrentRoomId());
            setCurrentRoomId(_loc4);
            setPlayerList(_loc3);
            startChatLog();
            setIsRoomIgloo(false);
            trackRoomJoin(my_room.name);
            updateListeners(JOIN_ROOM, null);
        }
        else
        {
            $e("[shell] handleJoinRoom() -> Tried to join a room which did not exist in crumbs. Obj: " + obj);
        } // end else if
    }
    else
    {
        $e("[shell] sendJoinRoom() -> Tried to join a room while in a game room!", {error_code: PLAYER_IN_ROOM});
    } // end else if
} // End of the function
function handleSetWantedPlayer(obj)
{
    obj.shift();
    var _loc2 = obj.shift();
    if (_loc2 == 0)
    {
        playerWanted = 0;
        return (false);
    } // end if
    var _loc4 = obj.shift();
    var _loc1 = obj.shift();
    playerWantedName = _loc4;
    playerWanted = _loc2;
    playerWantedCredits = _loc1;
    if (_loc2 == getMyPlayerId())
    {
        INTERFACE.notify("You\'re wanted!", "You are wanted for " + _loc1 + " credits. If you survive for five minutes, you keep the " + _loc1 + " credits.");
    }
    else
    {
        INTERFACE.notify("Wanted Player", _loc4 + " is wanted! Kill them for " + _loc1 + " credits!");
    } // end else if
} // End of the function
function handleSendNote(obj)
{
    obj.shift();
    var _loc1 = obj.shift();
    var _loc3 = obj.shift();
    INTERFACE.notify(_loc1, _loc3);
} // End of the function
function handleRefreshWorldRoom(obj)
{
    var _loc5 = obj.shift();
    var _loc4 = obj.shift();
    my_room = getRoomCrumbsById(_loc4);
    var _loc3 = new Array();
    var _loc2;
    for (var _loc2 in obj)
    {
        _loc3.push(makePlayerObjectFromString(obj[_loc2]));
    } // end of for...in
    setPlayerList(_loc3);
    updateListeners(REFRESH_ROOM, null);
} // End of the function
function handleAddPlayerToRoom(obj)
{
    var _loc4 = getRoomObject();
    var _loc3 = obj.shift();
    if (_loc3 == getCurrentServerRoomId())
    {
        var _loc2 = makePlayerObjectFromString(obj[0]);
        var _loc1 = _loc2.player_id;
        if (playerIndexInRoom(_loc1) == -1)
        {
            getPlayerList().push(_loc2);
            removePlayerFromCacheById(_loc1);
            _loc2.thrownSnowballInCurrentRoom = false;
            _loc2.emoteIDDisplayedInCurrentRoom = -1;
            updateListeners(ADD_PLAYER, _loc2);
            if (isPlayerBuddyById(_loc1))
            {
                setBuddyAsOnlineById(_loc1);
            } // end if
        }
        else if (_loc1 != getMyPlayerId())
        {
            $d("handleAddPlayerToRoom() -> Adding a duplicate player to the room. PlayerId: " + _loc1);
        } // end else if
    }
    else
    {
        $d("handleAddPlayerToRoom() -> Adding a player to the same room id we are currently in");
    } // end else if
} // End of the function
function handleRemovePlayerFromRoom(obj)
{
    var _loc5 = obj.shift();
    var _loc1 = Number(obj[0]);
    var _loc2 = playerIndexInRoom(_loc1);
    var _loc4 = getPlayerList();
    var _loc3 = getPlayerObjectById(_loc1);
    if (_loc2 != -1)
    {
        _loc4.splice(_loc2, 1);
        _loc3.thrownSnowballInCurrentRoom = false;
        _loc3.emoteIDDisplayedInCurrentRoom = -1;
        updateListeners(REMOVE_PLAYER, _loc1);
    } // end if
} // End of the function
function handleSendUpdatePlayerColour(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = obj[1];
    if (!isNaN(_loc2))
    {
        if (isMyPlayer(_loc2))
        {
            setMyPlayerHexById(_loc3);
        } // end if
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.colour_id = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
            if (isMyPlayer(_loc2))
            {
                com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
            } // end if
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerColour() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerColour() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePlayerHead(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc2))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.head = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
            if (isMyPlayer(_loc2))
            {
                com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
            } // end if
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerHead() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerHead() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePlayerFace(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc2))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.face = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
            if (isMyPlayer(_loc2))
            {
                com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
            } // end if
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerFace() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerFace() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePlayerNeck(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc2))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.neck = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
            if (isMyPlayer(_loc2))
            {
                com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
            } // end if
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerNeck() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerBody() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePlayerBody(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc2))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.body = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
            if (isMyPlayer(_loc2))
            {
                com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
            } // end if
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerBody() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerBody() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePlayerHand(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc2))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.hand = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
            if (isMyPlayer(_loc2))
            {
                com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
            } // end if
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerHand() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerHand() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePlayerFeet(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc2))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.feet = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
            if (isMyPlayer(_loc2))
            {
                com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
            } // end if
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerHand() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerHand() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePlayerFlag(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc2))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.flag_id = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerHand() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerHand() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePlayerPhoto(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc2))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc2);
        if (_loc1 != undefined)
        {
            _loc1.photo_id = _loc3;
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
        }
        else
        {
            $e("[shell] handleSendUpdatePlayerHand() -> Could not find player in room! player_id:" + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerHand() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSendUpdatePaperdoll(obj)
{
    var _loc4 = obj.shift();
    var _loc3 = Number(obj.shift());
    if (!isNaN(_loc3))
    {
        var _loc1 = getPlayerObjectFromRoomById(_loc3);
        if (_loc1 != undefined)
        {
            _loc1.feet = obj.shift();
            _loc1.head = obj.shift();
            _loc1.neck = obj.shift();
            _loc1.face = obj.shift();
            _loc1.hand = obj.shift();
            _loc1.body = obj.shift();
            _loc1.playercard_attributes.f = obj.shift();
            _loc1.colour_id = obj.shift();
            _loc1.frame_hack = buildFrameHacksString(_loc1);
            updateListeners(UPDATE_PLAYER, _loc1);
            if (isMyPlayer(_loc3))
            {
                com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
            } // end if
        }
        else
        {
            $e("[shell] handleSendClearPaperdoll() -> Could not find player in room! player_id:" + _loc3);
        } // end else if
    }
    else
    {
        $e("[shell] handleSendClearPaperdoll() -> Not a real number passed for player id! player_id:" + _loc3);
    } // end else if
} // End of the function
function handleSendClearPaperdoll(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc3 = Boolean(Number(obj[1]));
    if (!isNaN(_loc2))
    {
        if (_loc3)
        {
            var _loc1 = getPlayerObjectFromRoomById(_loc2);
            if (_loc1 != undefined)
            {
                _loc1.photo_id = 0;
                _loc1.flag_id = 0;
                _loc1.feet = 0;
                _loc1.head = 0;
                _loc1.neck = 0;
                _loc1.face = 0;
                _loc1.hand = 0;
                _loc1.body = 0;
                _loc1.frame_hack = buildFrameHacksString(_loc1);
                updateListeners(UPDATE_PLAYER, _loc1);
                if (isMyPlayer(_loc2))
                {
                    com.clubpenguin.login.LocalData.saveRoomPlayerObject(_loc1);
                } // end if
            }
            else
            {
                $e("[shell] handleSendClearPaperdoll() -> Could not find player in room! player_id:" + _loc2);
            } // end else if
        }
        else
        {
            $e("[shell] handleSendClearPaperdoll() -> Player was not successfully cleared!");
        } // end else if
    }
    else
    {
        $e("[shell] handleSendClearPaperdoll() -> Not a real number passed for player id! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleSetPermissions(obj)
{
    obj.shift();
    var _loc4 = obj.shift();
    var _loc1 = obj.shift();
    if (isNaN(_loc1))
    {
        return (false);
    } // end if
    var _loc3 = getPlayerObjectById(_loc4);
    _loc3.account_permissions = _loc1;
} // End of the function
function handleMovePlayer(obj)
{
    var _loc4 = obj.shift();
    var _loc3 = Number(obj[0]);
    var _loc1 = Number(obj[1]);
    ENGINE.sendPlayerMove(_loc3, _loc1);
} // End of the function
function handleSendPlayerMove(obj)
{
    var _loc8 = obj.shift();
    var _loc4 = Number(obj[0]);
    var _loc5 = Number(obj[1]);
    var _loc6 = Number(obj[2]);
    var _loc2 = playerIndexInRoom(_loc4);
    var _loc3 = getPlayerList();
    if (penguin_index != -1)
    {
        _loc3[_loc2].x = _loc5;
        _loc3[_loc2].y = _loc6;
        _loc3[_loc2].frame = 1;
        var _loc1 = new Object();
        _loc1.player_id = _loc4;
        _loc1.x = _loc5;
        _loc1.y = _loc6;
        updateListeners(PLAYER_MOVE, _loc1);
    }
    else
    {
        $d("[shell] Trying to move a penguin who was not found in the room. player_id: " + _loc4);
    } // end else if
} // End of the function
function handleSendPlayerFrame(obj)
{
    var _loc7 = obj.shift();
    var _loc1 = new Object();
    _loc1.player_id = Number(obj[0]);
    _loc1.frame = Number(obj[1]);
    var _loc3 = getPlayerObjectFromRoomById(Number(obj[0]));
    _loc1.x = _loc3.x;
    _loc1.y = _loc3.y;
    var _loc5 = playerIndexInRoom(_loc1.player_id);
    var _loc6 = getPlayerList();
    if (penguin_index != -1)
    {
        _loc6[_loc5].frame = _loc1.frame;
        if (isMyPlayer(_loc1.player_id))
        {
            var _loc2 = getMyPlayerObject();
            _loc2.frame = _loc1.frame;
            updateListeners(UPDATE_PLAYER, _loc2);
        } // end if
        updateListeners(PLAYER_FRAME, _loc1);
    }
    else
    {
        $d("[shell] updatePlayerAction() -> Trying to update a penguin frame who was not found in the room. player_id: " + player_id);
    } // end else if
} // End of the function
function handleUpdateMood(obj)
{
    var _loc1 = obj.shift();
    var _loc2 = obj.shift();
    INTERFACE.getPlayerObject(_loc1).data[19] = _loc2;
    if (INTERFACE.getActivePlayerId() == _loc1)
    {
        INTERFACE.updatePlayerWidget();
    } // end if
} // End of the function
function handleGetCoinReward(serverEventData)
{
    var _loc5 = Number(serverEventData.shift());
    var _loc2 = Number(serverEventData[0]);
    var _loc1 = Number(serverEventData[1]);
    if (isNaN(_loc2))
    {
        return;
    } // end if
    if (!isNaN(_loc1) && _loc1 > 0)
    {
        setMyPlayerTotalCoins(_loc1);
    } // end if
    var _loc4 = {numCoins: _loc2, totalCoins: _loc1};
    updateListeners(COIN_DIG_UPDATE, _loc4);
} // End of the function
function handleUpdatePlayer(player)
{
    if (isMyPlayer(player.player_id))
    {
        var _loc2 = getMyPlayerObject();
        for (var _loc3 in player)
        {
            _loc2[_loc3] = player[_loc3];
        } // end of for...in
    } // end if
} // End of the function
function handleSendNewLike(obj)
{
    var _loc5 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc4 = Number(obj[1]);
    var _loc1 = getPlayerObjectFromRoomById(_loc2);
    if (_loc1 != undefined)
    {
        _loc1.playercard_attributes.l = _loc4;
        updateListeners(UPDATE_PLAYER, _loc1);
    }
    else
    {
        $e("[shell] handleSendUpdatePlayerStatus() -> Could not find player in room! player_id:" + _loc2);
    } // end else if
} // End of the function
function handleLoadPlayer(result)
{
    var _loc12 = String(result[1]);
    var _loc6 = Number(result[2]);
    var _loc7 = Boolean(Number(result[3]));
    var _loc10 = Number(result[4]);
    var _loc8 = Number(result[5]);
    var _loc13 = Number(result[6]);
    var _loc11 = Number(result[7]);
    var _loc3 = -1;
    if (!isNaN(result[8]))
    {
        _loc3 = Number(result[8]);
    } // end if
    var _loc2 = -1;
    if (!isNaN(result[9]))
    {
        _loc2 = Number(result[9]);
    } // end if
    var _loc4 = Number(result[10]) || DEFAULT_TIMEZONE_OFFSET;
    var _loc15 = result[11].split(",");
    var _loc9 = result[12];
    var _loc14 = Number(result[13]);
    var _loc5 = new Array();
    INTERFACE.whoILiked = _loc5;
    updatePlayerObjectFromString(my_player, _loc12);
    setMyPlayerTotalCoins(_loc6);
    setMyPlayerTotalCredits(Number(_loc9));
    setMyPlayerSafemode(_loc7);
    setEggTimerMinutesRemaining(_loc10);
    startEggTimer();
    setMyPlayerDaysOld(Math.round((new Date().getTime() / 1000 - _loc13) / 86400));
    setMyPlayerBannedAge(_loc11);
    setMinutesPlayed(_loc3);
    setSecondsPlayed(_loc14);
    setMembershipDaysRemaining(_loc2);
    serverTimezoneOffset = _loc4;
    setupPenguinStandardTime(_loc8);
    com.clubpenguin.login.LocalData.savePlayerObject();
    setupEPFPlayerData();
    setPlayerMembershipStatusCookie();
    SHELL.sendMyPlayerData(my_player);
    flash.external.ExternalInterface.call("setMyKey", result[14], getMyPlayerId());
} // End of the function
function consoledebug(msg)
{
    flash.external.ExternalInterface.call("console.debug", msg);
} // End of the function
function handleStartNPC(obj)
{
    obj.shift();
    _global.getCurrentShell().NPCModule.NPCScript.haltNow = true;
    var _loc2 = obj.shift();
    if (_loc2 >= 1000)
    {
        botName = getCurrentIglooBot().split("|")[1].toLowerCase();
        _global.getCurrentShell().NPCModule.addNPC(getCurrentIglooBot());
    }
    else
    {
        consoledebug("NPCModule: " + _global.getCurrentShell().NPCModule);
        consoledebug("joinRoom: " + _global.getCurrentShell().NPCModule.joinRoom);
        _global.getCurrentShell().NPCModule.joinRoom(_loc2);
    } // end else if
} // End of the function
function handleSetNewNPC(obj)
{
    obj.shift();
    var _loc1 = obj.shift();
    if (_loc1.indexOf("|") == -1)
    {
        return (false);
    } // end if
    botName = _loc1.split("|")[1].toLowerCase();
    setCurrentIglooBot(_loc1);
} // End of the function
function handleOpenPlayerBook(obj)
{
    var _loc2 = obj.shift();
    var _loc1 = Number(obj[0]);
    if (!isNaN(_loc2) && !isNaN(_loc1))
    {
        updateListeners(OPEN_BOOK, _loc1);
    }
    else
    {
        $e("[shell] handleOpenPlayerBook() -> Did not receive a valid player id or smart room id. player_id: " + _loc1 + " smart_room_id: " + _loc2);
    } // end else if
} // End of the function
function handleNewPm(obj)
{
    INTERFACE.newPM();
} // End of the function
function handleClosePlayerBook(obj)
{
    var _loc2 = obj.shift();
    var _loc1 = Number(obj[0]);
    if (!isNaN(_loc2) && !isNaN(_loc1))
    {
        updateListeners(CLOSE_BOOK, _loc1);
    }
    else
    {
        $e("[shell] handleClosePlayerBook() -> Did not receive a valid player id or smart room id. player_id: " + _loc1 + " smart_room_id: " + _loc2);
    } // end else if
} // End of the function
function handleLoadMyAmmo(obj)
{
    return (INTERFACE.handleLoadMyAmmo(obj));
} // End of the function
function handleHitByBall(obj)
{
    return (INTERFACE.handleHitBySnowball(obj));
} // End of the function
function handleSetScore(obj)
{
    obj.shift();
    INTERFACE.myScore = Number(obj.shift());
    if (isNaN(INTERFACE.myScore))
    {
        INTERFACE.myScore = 0;
    } // end if
    INTERFACE.interface_mc.icons_mc.scoreBox.scoreTxt.text = "Score: " + INTERFACE.myScore;
    INTERFACE.interface_mc.icons_mc.creditBox.creditsTxt.text = "Credits: " + Math.round(INTERFACE.myScore / 2);
} // End of the function
function handleNewKill(obj)
{
    return (INTERFACE.handleNewKill(obj));
} // End of the function
function handleSetDead(obj)
{
    obj.shift();
    INTERFACE.gotKilled(obj.shift());
} // End of the function
function handleSetMySnowball(obj)
{
    obj.shift();
    INTERFACE.myCurrentSnowball = obj.shift();
} // End of the function
function handleSetMyHealth(obj)
{
    obj.shift();
    INTERFACE.myHealthTotal = obj.shift();
    INTERFACE.updateHealthBar();
} // End of the function
function handlePlayerThrowSnowball(obj)
{
    var _loc4 = obj.shift();
    var _loc3 = Number(obj[0]);
    var _loc5 = Number(obj[1]);
    var _loc6 = Number(obj[2]);
    var _loc7 = Number(obj[3]);
    if (!isNaN(_loc4) && !isNaN(_loc3))
    {
        if (!isNaN(_loc5) && !isNaN(_loc6))
        {
            var _loc1 = {};
            _loc1.player_id = _loc3;
            _loc1.x = _loc5;
            _loc1.y = _loc6;
            _loc1.type = _loc7;
            updateListeners(THROW_BALL, _loc1);
        }
        else
        {
            $e("[shell] handlePlayerThrowBall() -> The snowballs xpos or ypos was NaN. xpos: " + xpos + " ypos: " + ypos);
        } // end else if
    }
    else
    {
        $e("[shell] handlePlayerThrowBall() -> Did not receive a valid player id or smart room id. player_id: " + _loc3 + " smart_room_id: " + _loc4);
    } // end else if
} // End of the function
function handlePlayerThrowBall(obj)
{
    var _loc3 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc4 = Number(obj[1]);
    var _loc5 = Number(obj[2]);
    if (!isNaN(_loc3) && !isNaN(_loc2))
    {
        if (!isNaN(_loc4) && !isNaN(_loc5))
        {
            var _loc1 = {};
            _loc1.player_id = _loc2;
            _loc1.x = _loc4;
            _loc1.y = _loc5;
            updateListeners(THROW_BALL, _loc1);
        }
        else
        {
            $e("[shell] handlePlayerThrowBall() -> The snowballs xpos or ypos was NaN. xpos: " + xpos + " ypos: " + ypos);
        } // end else if
    }
    else
    {
        $e("[shell] handlePlayerThrowBall() -> Did not receive a valid player id or smart room id. player_id: " + _loc2 + " smart_room_id: " + _loc3);
    } // end else if
} // End of the function
function handleUpdateCoin(obj)
{
    var _loc2 = obj.shift();
    var _loc1 = obj[0];
    if (isNaN(_loc1))
    {
        return (false);
    } // end if
    setMyPlayerTotalCoins(_loc1);
} // End of the function
function handleLoadPlayerObject(obj)
{
    var _loc3 = obj.shift();
    var _loc1 = obj[0];
    if (isValidString(_loc1))
    {
        var _loc2 = makePlayerObjectFromString(_loc1);
        addPlayerToCache(_loc2);
        updateListeners(LOAD_PLAYER_OBJECT, _loc2);
    }
    else
    {
        $e("[shell] handleLoadPlayerObject() -> A valid player string was not returned: " + _loc1);
    } // end else if
} // End of the function
function handleMyGetInventoryList(obj)
{
    var _loc5 = obj.shift();
    var _loc4 = new Array();
    var _loc3;
    $d("[shell] handleMyGetInventoryList() -> Parsing player inventory");
    for (var _loc3 in obj)
    {
        var _loc1 = getInventoryObjectById(Number(obj[_loc3]));
        if (_loc1 != undefined)
        {
            _loc4.push(_loc1);
            continue;
        } // end if
        $e("[shell] handleGetInventoryList() -> Trying to add a inventory item which did not exist in crumbs. id: " + obj[_loc3]);
    } // end of for...in
    setMyInventoryArray(_loc4);
    updateListeners(UPDATE_INVENTORY, undefined);
} // End of the function
function handleBuyInventory(obj)
{
    var _loc8 = obj.shift();
    var _loc2 = Number(obj[0]);
    var _loc5 = 8009;
    var _loc7 = 800;
    if (_loc2 == _loc5)
    {
        removeItemFromInventory(_loc7);
    } // end if
    var _loc3 = Number(obj[1]);
    if (isNaN(_loc3))
    {
        _loc3 = 0;
    } // end if
    setMyPlayerTotalCoins(_loc3);
    var _loc4 = getInventoryObjectById(_loc2);
    var _loc6 = getMyInventoryArray();
    if (!isItemInMyInventory(_loc2))
    {
        obj = new Object();
        obj.item_id = _loc2;
        obj.player_id = getMyPlayerId();
        obj.success = true;
        updateListeners(BUY_INVENTORY, obj);
        _loc6.push(_loc4);
    }
    else
    {
        obj = new Object();
        obj.item_id = _loc2;
        obj.player_id = getMyPlayerId();
        obj.success = false;
        updateListeners(BUY_INVENTORY, obj);
        $d("[shell] handleBuyInventory() -> trying to add a duplicate item to player inventory");
    } // end else if
} // End of the function
function handleCheckInventory(serverEventData)
{
    var _loc6 = Number(serverEventData.shift());
    var _loc4 = Number(serverEventData[0]);
    var _loc3 = Number(serverEventData[1]);
    var _loc5 = Number(serverEventData[2]) == 1;
    if (isNaN(_loc3))
    {
        return;
    } // end if
    if (isNaN(_loc4))
    {
        return;
    } // end if
    var _loc1 = {};
    _loc1.playerID = _loc3;
    _loc1.itemID = _loc4;
    _loc1.isOwned = _loc5;
    updateListeners(CHECK_INVENTORY, _loc1);
} // End of the function
function handleUpdatePlayerAction(obj)
{
    var _loc3 = obj.shift();
    var _loc1 = new Object();
    _loc1.player_id = Number(obj[0]);
    _loc1.frame = Number(obj[1]);
    var _loc4 = playerIndexInRoom(_loc1.player_id);
    var _loc5 = getPlayerList();
    if (penguin_index != -1)
    {
        updateListeners(PLAYER_ACTION, _loc1);
    }
    else
    {
        $d("[shell] updatePlayerAction() -> Trying to update a penguin action who was not found in the room");
    } // end else if
} // End of the function
function handleGetFurnitureListFromServer(obj)
{
    var _loc8 = obj.shift();
    var _loc7 = new Array();
    var _loc1;
    var _loc3;
    var _loc5;
    var _loc2;
    var _loc4;
    for (var _loc4 in obj)
    {
        _loc3 = obj[_loc4].split("|");
        _loc5 = Number(_loc3[0]);
        _loc2 = Number(_loc3[1]);
        _loc1 = getFurnitureFromCrumbsById(_loc5);
        if (_loc1 != undefined)
        {
            _loc1.total = _loc2 + 25;
            _loc1.available = _loc2 + 25;
            _loc1.frame_1 = 1;
            _loc1.frame_2 = 1;
            _loc7.push(_loc1);
            continue;
        } // end if
        $e("[shell] handleGetFurnitureListFromServer() -> Could not find the furniture in the crumbs!");
    } // end of for...in
    setFurnitureList(_loc7);
    setAvailableCounts();
    updateListeners(GET_FURNITURE_LIST, undefined);
    AIRTOWER.removeListener(AIRTOWER.GET_FURNITURE_LIST, handleGetFurnitureListFromServer);
} // End of the function
function handleSendBuyFurniture(obj)
{
    var _loc10 = Number(obj.shift());
    var _loc2 = Number(obj[0]);
    var _loc8 = Number(obj[1]);
    setMyPlayerTotalCoins(_loc8);
    var _loc6 = getFurnitureFromCrumbsById(_loc2);
    if (_loc6 != undefined)
    {
        ++_loc6.available;
        var _loc3 = getFurnitureList();
        var _loc4 = false;
        var _loc5 = _loc3.length;
        for (var _loc1 = 0; _loc1 < _loc5; ++_loc1)
        {
            if (_loc3[_loc1].item_id == _loc2)
            {
                _loc4 = true;
                break;
            } // end if
        } // end of for
        if (!_loc4)
        {
            _loc6.available = 25;
            _loc6.total = 25;
            _loc3.push(_loc6);
        } // end if
        var _loc7 = new Object();
        _loc7.item_id = _loc2;
        _loc7.success = true;
        _loc7.player_id = SHELL.getMyPlayerId();
        updateListeners(BUY_FURNITURE, _loc7);
    }
    else
    {
        $e("[shell] handleSendBuyFurniture() -> Furniture was not found in the crumbs! item_id: " + _loc2);
    } // end else if
} // End of the function
function handleSendBuyIglooFloor(obj)
{
    var _loc5 = obj.shift();
    var _loc1 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc1))
    {
        setMyPlayerTotalCoins(_loc3);
        setCurrentIglooFloorId(_loc1);
        var _loc2 = {};
        _loc2.success = true;
        _loc2.floor_id = _loc1;
        updateListeners(BUY_IGLOO_FLOOR, _loc2);
    }
    else
    {
        $e("[shell] handleSendBuyIglooFloor() -> Floor id is not a real number. floor_id: " + _loc1);
        _loc2 = {};
        _loc2.success = false;
        updateListeners(BUY_IGLOO_FLOOR, _loc2);
    } // end else if
} // End of the function
function handleSendBuyIglooLocation(obj)
{
    var _loc5 = obj.shift();
    var _loc1 = Number(obj[0]);
    var _loc3 = Number(obj[1]);
    if (!isNaN(_loc1))
    {
        setMyPlayerTotalCoins(_loc3);
        setCurrentIglooBackgroundId(_loc1);
        var _loc2 = {};
        _loc2.success = true;
        _loc2.background_id = _loc1;
        updateListeners("ul", _loc2);
    }
    else
    {
        $e("[shell] handleSendBuyIglooFloor() -> Location id is not a real number. floor_id: " + _loc1);
        _loc2 = {};
        _loc2.success = false;
        updateListeners("ul", _loc2);
    } // end else if
} // End of the function
function handleSendBuyIglooType(obj)
{
    var _loc6 = obj[0];
    var _loc1 = Number(obj[1]);
    var _loc4 = Number(obj[2]);
    var _loc5 = Number(obj[3]);
    if (!isNaN(_loc1))
    {
        setMyPlayerTotalCoins(_loc4);
        var _loc2 = {};
        _loc2.success = true;
        _loc2.type_id = _loc1;
        addIglooToInventoryCache(_loc1);
        updateListeners(BUY_IGLOO_TYPE, _loc2);
    }
    else
    {
        $e("[shell] handleSendBuyIglooType() -> Type id is not a real number! type_id: " + _loc1);
        _loc2 = {};
        _loc2.success = false;
        _loc2.error = _loc5;
        updateListeners(BUY_IGLOO_TYPE, _loc2);
    } // end else if
} // End of the function
function handleGetOwnedIgloos(obj)
{
    var _loc7 = Number(obj[0]);
    var _loc5 = String(obj[1]);
    ownedIgloos = [];
    var _loc6 = getDefaultIglooObject();
    var _loc3 = _loc5.split("|");
    for (var _loc1 = 0; _loc1 < _loc3.length; ++_loc1)
    {
        var _loc4 = {};
        var _loc2 = Number(_loc3[_loc1]);
        addIglooToInventoryCache(_loc2);
    } // end of for
    igloosCached = true;
    updateListeners(GET_OWNED_IGLOOS, ownedIgloos);
} // End of the function
function handleGetPlayerIgloo(event)
{
    var _loc17 = Number(event[0]);
    var _loc9 = Number(event[1]);
    var _loc10 = Number(event[2]);
    var _loc16 = Number(event[3]);
    var _loc14 = Number(event[4]);
    var _loc15 = String(event[5]);
    var _loc11 = Number(event[6]);
    var _loc4 = {};
    _loc4.type = _loc10;
    _loc4.music_id = _loc16;
    _loc4.floor_id = _loc14;
    if (isNaN(_loc11))
    {
        _loc11 = 0;
    } // end if
    _loc4.background_id = _loc11;
    var _loc5 = [];
    var _loc6 = _loc15.split(",");
    var _loc7 = _loc6.length;
    var _loc2;
    var _loc1;
    for (var _loc3 = 0; _loc3 < _loc7; ++_loc3)
    {
        _loc2 = _loc6[_loc3].split("|");
        if (_loc2.length > 1)
        {
            _loc1 = {};
            _loc1 = duplicateObject(getFurnitureFromCrumbsById(Number(_loc2[0])));
            _loc1.x = Number(_loc2[1]);
            _loc1.y = Number(_loc2[2]);
            _loc1.frame_1 = Number(_loc2[3]);
            _loc1.frame_2 = Number(_loc2[4]);
            _loc1.type = getFurnitureTypeById(_loc1.item_id);
            if (isNaN(_loc1.frame_1))
            {
                _loc1.frame_1 = 1;
            } // end if
            if (isNaN(_loc1.frame_2))
            {
                _loc1.frame_2 = 1;
            } // end if
            if (isFurnitureInCrumbs(_loc1.item_id))
            {
                _loc5.push(_loc1);
            } // end if
        } // end if
    } // end of for
    _loc4.furniture = _loc5;
    var _loc13 = getDefaultIglooObject();
    var _loc12 = _loc10 > 1 || _loc5.length > 0 || _loc14 > 0 || _loc4.music_id != _loc13.music_id;
    if (_loc12 && _loc10 == 0)
    {
        _loc4.type = 1;
    } // end if
    if (isMyPlayer(_loc9) && _loc12)
    {
        setMyStoredIglooObject(_loc4);
    } // end if
    if (isMyPlayer(_loc9) && !isMyPlayerMember() || _loc4.type == 0)
    {
        _loc4 = _loc13;
    } // end if
    _loc4.name = "igloo";
    _loc4.path = getClientPath() + "" + IGLOO_PATH + ".swf";
    _loc4.player_id = _loc9;
    if (_loc9 == 0)
    {
        removeListener(GET_IGLOO_DETAILS, joinPlayerIgloo);
        hideLoading();
        return;
    }
    else
    {
        loadIgloo(_loc4);
    } // end else if
} // End of the function
function handleJoinPlayerIgloo(obj)
{
    var _loc4 = Number(obj.shift());
    var _loc5 = Number(obj.shift());
    if (my_room != undefined)
    {
        last_known_room_name = getRoomNameById(my_room.room_id);
    } // end if
    setCurrentServerRoomId(_loc4);
    var _loc3 = [];
    var _loc2;
    for (var _loc2 in obj)
    {
        _loc3.push(makePlayerObjectFromString(obj[_loc2]));
    } // end of for...in
    setLastRoomId(getCurrentRoomId());
    setCurrentRoomId(_loc5 - 1000);
    setPlayerList(_loc3);
    startChatLog();
    setIsRoomIgloo(true);
    trackIglooJoin();
    updateListeners(JOIN_PLAYER_IGLOO, null);
} // End of the function
function handleLoadPlayerIglooList(obj)
{
    var _loc6 = obj.shift();
    var _loc5 = [];
    var _loc3;
    var _loc1;
    var _loc2;
    for (var _loc3 in obj)
    {
        _loc2 = obj[_loc3].split("|");
        _loc1 = {};
        _loc1.player_id = Number(_loc2[0]);
        _loc1.nickname = _loc2[1];
        _loc1.igloo_id = 0;
        _loc5.push(_loc1);
    } // end of for...in
    updateListeners(LOAD_PLAYER_IGLOO_LIST, _loc5);
} // End of the function
function handleSendMessage(obj)
{
    var _loc2 = obj[0];
    if (_loc2 == getCurrentServerRoomId())
    {
        var _loc1 = new Object();
        _loc1.message = obj[2];
        _loc1.player_id = Number(obj[1]);
        _loc1.nickname = getNicknameById(_loc1.player_id);
        _loc1.type = SEND_MESSAGE;
        if (!isPlayerIgnoredById(_loc1.player_id))
        {
            if (isValidString(_loc1.message))
            {
                if (!isMyPlayerSafeMode())
                {
                    if (!isMyPlayer(_loc1.player_id))
                    {
                        addToChatLog(_loc1);
                    } // end if
                    updateListeners(SEND_MESSAGE, _loc1);
                } // end if
            }
            else
            {
                $e("[shell] handleSendMessage() -> Received an improperly formated message: " + _loc1.message);
            } // end if
        } // end else if
    }
    else
    {
        $e("[shell] handleSendMessage() -> Recieved a message from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc2);
    } // end else if
} // End of the function
function handleBlockedMessage(obj)
{
    var _loc2 = obj[0];
    if (_loc2 == getCurrentServerRoomId())
    {
        var _loc1 = new Object();
        _loc1.message = obj[1];
        _loc1.player_id = Number(obj[2]);
        _loc1.nickname = getNicknameById(_loc1.player_id);
        _loc1.type = SEND_BLOCKED_MESSAGE;
        if (!isPlayerIgnoredById(_loc1.player_id))
        {
            if (isValidString(_loc1.message))
            {
                addToChatLog(_loc1);
                updateListeners(SEND_BLOCKED_MESSAGE, _loc1);
            }
            else
            {
                $e("[shell] handleBlockedMessage() -> Received an improperly formated message: " + _loc1.message);
            } // end if
        } // end else if
    }
    else
    {
        $e("[shell] handleBlockedMessage() -> Recieved a message from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc2);
    } // end else if
} // End of the function
function handleSendEmote(obj)
{
    var _loc2 = obj[0];
    if (_loc2 == getCurrentServerRoomId())
    {
        var _loc1 = new Object();
        _loc1.player_id = Number(obj[1]);
        _loc1.emote_id = Number(obj[2]);
        if (!isPlayerIgnoredById(_loc1.player_id))
        {
            if (!isNaN(_loc1.emote_id))
            {
                updateListeners(SEND_EMOTE, _loc1);
            }
            else
            {
                $e("[shell] handleSendEmote() -> received an invalid id for a emote: emote_id: " + _loc1.emote_id);
            } // end if
        } // end else if
    }
    else
    {
        $e("[shell] handleSendEmote() -> Recieved an emote from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc2);
    } // end else if
} // End of the function
function handleSendJoke(obj)
{
    var _loc2 = obj[0];
    if (_loc2 == getCurrentServerRoomId())
    {
        var _loc1 = new Object();
        _loc1.player_id = Number(obj[1]);
        _loc1.joke_id = Number(obj[2]);
        if (!isPlayerIgnoredById(_loc1.player_id))
        {
            if (!isNaN(_loc1.joke_id))
            {
                if (getJokeById(_loc1.joke_id) != undefined)
                {
                    updateListeners(SEND_JOKE, _loc1);
                }
                else
                {
                    $e("[shell] handleSendJoke() -> Received a joke id which was not found: " + _loc1.joke_id);
                } // end else if
            }
            else
            {
                $e("[shell] handleSendJoke() -> Received a joke id which is not a valid number. joke_id: " + _loc1.joke_id);
            } // end if
        } // end else if
    }
    else
    {
        $e("[shell] handleSendJoke() -> Recieved an joke from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc2);
    } // end else if
} // End of the function
function handleSendQuickMessage(obj)
{
    var _loc6 = obj[0];
    if (_loc6 == getCurrentServerRoomId())
    {
        var _loc2 = Number(obj[1]);
        var _loc3 = Number(obj[2]);
        if (!isPlayerIgnoredById(_loc2))
        {
            if (!isNaN(quick_obj.quick_id))
            {
                var _loc5 = getQuickMessageById(quick_obj.quick_id);
                if (isValidString(_loc5))
                {
                    var _loc1 = new Object();
                    _loc1.player_id = _loc2;
                    _loc1.nickname = getNicknameById(_loc2);
                    _loc1.message = _loc5;
                    _loc1.type = SEND_QUICK_MESSAGE;
                    addToChatLog(_loc1);
                    var _loc4 = new Object();
                    _loc4.player_id = _loc2;
                    _loc4.safe_id = _loc3;
                    updateListeners(SEND_QUICK_MESSAGE, _loc4);
                }
                else
                {
                    $e("[shell] handleSendQuickMessage() -> Quick message was not found in quick message list. quick_id: " + _loc3);
                } // end else if
            }
            else
            {
                $e("[shell] handleSendQuickMessage() -> Quick ID was not a real number. quick_id: " + _loc3);
            } // end if
        } // end else if
    }
    else
    {
        $e("[shell] handleSendQuickMessage() -> Received a quick message from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc6);
    } // end else if
} // End of the function
function handleSafeMessage(obj)
{
    var _loc5 = obj[0];
    if (_loc5 == getCurrentServerRoomId())
    {
        var _loc4 = Number(obj[1]);
        var _loc2 = Number(obj[2]);
        if (getSafeMessageById(_loc2) != undefined)
        {
            var _loc1 = new Object();
            _loc1.player_id = _loc4;
            _loc1.nickname = getNicknameById(_loc4);
            _loc1.type = SEND_SAFE_MESSAGE;
            _loc1.message = getSafeMessageById(_loc2);
            if (!isPlayerIgnoredById(_loc1.player_id))
            {
                if (isValidString(_loc1.message))
                {
                    addToChatLog(_loc1);
                    var _loc3 = new Object();
                    _loc3.player_id = _loc4;
                    _loc3.safe_id = _loc2;
                    updateListeners(SEND_SAFE_MESSAGE, _loc3);
                }
                else
                {
                    $e("[shell] handleSafeMessage() -> Invalid safe message text: safe_message_id: " + _loc2 + " safe_message_text: " + _loc1.message);
                } // end if
            } // end else if
        }
        else
        {
            $e("[shell] handleSafeMessage() -> Received a safe message id which did not exist in the safe message list. safe_id: " + _loc2);
        } // end else if
    }
    else
    {
        $e("[shell] handleSafeMessage() -> Received a safe message from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc5);
    } // end else if
} // End of the function
function handleLineMessage(obj)
{
    var _loc6 = obj[0];
    if (_loc6 == getCurrentServerRoomId())
    {
        var _loc3 = Number(obj[1]);
        var _loc1 = Number(obj[2]);
        var _loc4 = getLineMessageById(_loc1);
        if (!isPlayerIgnoredById(_loc3))
        {
            if (!isNaN(_loc1))
            {
                if (isValidString(_loc4))
                {
                    var _loc2 = new Object();
                    _loc2.player_id = _loc3;
                    _loc2.nickname = getNicknameById(_loc3);
                    _loc2.type = SEND_LINE_MESSAGE;
                    _loc2.message = _loc4;
                    addToChatLog(_loc2);
                    var _loc5 = new Object();
                    _loc5.player_id = _loc3;
                    _loc5.line_id = _loc1;
                    updateListeners(SEND_LINE_MESSAGE, _loc5);
                }
                else
                {
                    $e("[shell] handleLineMessage() -> Received an invalid line message text. message text: " + _loc4 + " line_message_id: " + _loc1);
                } // end else if
            }
            else
            {
                $e("[shell] handleLineMessage() -> Received an invalid line id. line_message_id: " + _loc1);
            } // end if
        } // end else if
    }
    else
    {
        $e("[shell] handleLineMessage() -> Received a line message from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc6);
    } // end else if
} // End of the function
function handleMascotMessage(obj)
{
    var _loc8 = obj[0];
    if (_loc8 == getCurrentServerRoomId())
    {
        var _loc3 = Number(obj[1]);
        var _loc5 = Number(obj[2]);
        var _loc6 = getMascotMessageById(_loc5);
        if (!isPlayerIgnoredById(_loc3))
        {
            if (!isNaN(_loc5))
            {
                if (isValidString(_loc6))
                {
                    var _loc4 = _loc6.split("|");
                    for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
                    {
                        var _loc1 = new Object();
                        _loc1.player_id = _loc3;
                        _loc1.nickname = getNicknameById(_loc3);
                        _loc1.type = SEND_MASCOT_MESSAGE;
                        _loc1.message = _loc4[_loc2];
                        addToChatLog(_loc1);
                    } // end of for
                    var _loc7 = new Object();
                    _loc7.player_id = _loc3;
                    _loc7.mascot_message_id = _loc5;
                    updateListeners(SEND_MASCOT_MESSAGE, _loc7);
                }
                else
                {
                    $e("[shell] handleMascotMessage() -> Received invalid mascot message text. message text: " + _loc6 + " mascot_message_id: " + _loc5);
                } // end else if
            }
            else
            {
                $e("[shell] handleMascotMessage() -> Received an invalid mascot message id. mascot_message_id: " + _loc5);
            } // end if
        } // end else if
    }
    else
    {
        $e("[shell] handleMascotMessage() -> Received a mascot message from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc8);
    } // end else if
} // End of the function
function handleTourGuideMessage(obj)
{
    var _loc3 = obj[0];
    if (_loc3 == getCurrentServerRoomId())
    {
        var _loc4 = Number(obj[1]);
        var _loc1 = Number(obj[2]);
        if (!isPlayerIgnoredById(_loc4))
        {
            if (!isNaN(_loc1))
            {
                var _loc2 = new Object();
                _loc2.player_id = _loc4;
                _loc2.room_id = _loc1;
                updateListeners(SEND_TOUR_GUIDE_MESSAGE, _loc2);
            }
            else
            {
                $e("[shell] handleTourGuideMessage() -> Received an invalid room id. room_id: " + _loc1);
            } // end if
        } // end else if
    }
    else
    {
        $e("[shell] handleTourGuideMessage() -> Received a tour guide message from the wrong server room id: current room id: " + getCurrentServerRoomId() + " received room id: " + _loc3);
    } // end else if
} // End of the function
function handleGetBuddyListFromServer(list)
{
    var _loc7 = Number(list.shift());
    buddyList = new Array();
    var _loc1;
    var _loc2;
    var _loc4;
    var _loc5;
    var _loc3;
    for (var _loc3 in list)
    {
        _loc1 = list[_loc3].split("|");
        _loc2 = Number(_loc1[0]);
        _loc4 = String(_loc1[1]);
        _loc5 = Boolean(Number(_loc1[2]));
        if (isNaN(_loc2))
        {
            continue;
        } // end if
        addPlayerToBuddyList(_loc2, _loc4, _loc5);
    } // end of for...in
    AIRTOWER.removeListener(AIRTOWER.GET_BUDDY_LIST, handleGetBuddyListFromServer);
} // End of the function
function handleBuddyOnline(playerDetails)
{
    var _loc1 = Number(playerDetails[1]);
    if (isNaN(_loc1))
    {
        $e("[shell] handleBuddyOnline() -> Not a real number received for playerID! playerID: " + _loc1);
        return;
    } // end if
    setBuddyAsOnlineById(_loc1);
    updateListeners(BUDDY_ONLINE, {player_id: _loc1, nickname: getBuddyNicknameById(_loc1)});
    updateListeners(UPDATE_BUDDY_LIST, getSortedBuddyList());
} // End of the function
function handleBuddyOffline(playerDetails)
{
    var _loc1 = Number(playerDetails[1]);
    if (isNaN(_loc1))
    {
        $e("[shell] handleBuddyOffline() -> Not a real number received for playerID! playerID: " + _loc1);
        return;
    } // end if
    setBuddyAsOfflineById(_loc1);
    updateListeners(UPDATE_BUDDY_LIST, getSortedBuddyList());
} // End of the function
function handleBuddyRequest(playerDetails)
{
    var _loc1 = Number(playerDetails[1]);
    var _loc2 = String(playerDetails[2]);
    var _loc3 = String(playerDetails[3]);
    if (isNaN(_loc1))
    {
        $e("[shell] handleBuddyRequest() -> Not a real number passed for player id. playerID: " + _loc1);
        return;
    } // end if
    if (isPlayerBuddyById(_loc1))
    {
        $e("[shell] handleBuddyRequest() -> Player is already our buddy! playerID: " + _loc1);
        return;
    } // end if
    flash.external.ExternalInterface.call("console.debug", "player2Id: " + _loc1);
    buddyRequest[Number(_loc1)] = {player_id: _loc1, nickname: _loc2, token: _loc3};
    updateListeners(SEND_BUDDY_REQUEST, {player_id: _loc1, nickname: _loc2, token: _loc3});
} // End of the function
function handleBuddyAccept(playerDetails)
{
    var _loc1 = new Object();
    _loc1.player_id = Number(playerDetails[1]);
    _loc1.nickname = String(playerDetails[2]);
    if (isNaN(_loc1.player_id))
    {
        $e("[shell] handleBuddyAccept() -> Not a real number passed for player id. playerID: " + playerID);
        return;
    } // end if
    if (isPlayerBuddyById(_loc1.player_id))
    {
        $e("[shell] handleBuddyAccept() -> Player is already a buddy! playerID: " + playerID);
        return;
    } // end if
    setBuddyAsOnlineById(_loc1.player_id);
    updateListeners(BUDDY_ONLINE, {player_id: _loc1.player_id, nickname: _loc1.nickname});
    addPlayerToBuddyList(_loc1.player_id, _loc1.nickname, true);
    updateListeners(SEND_BUDDY_ACCEPT, _loc1);
} // End of the function
function handleRemoveBuddyPlayer(playerDetails)
{
    var _loc1 = Number(playerDetails[1]);
    var _loc2 = String(playerDetails[2]);
    if (!removePlayerFromBuddyList(_loc1))
    {
        $e("[shell] handleRemoveBuddyPlayer() -> Player was not successfully removed from the buddy list");
        return;
    } // end if
    updateListeners(UPDATE_BUDDY_LIST, getSortedBuddyList());
} // End of the function
function handleGetPlayerLocationById(playerDetails)
{
    updateListeners(GET_PLAYER_LOCATION, {room_id: Number(playerDetails[1])});
} // End of the function
function handleRealTimeNameglow(obj)
{
    obj.shift();
    var _loc1 = obj.shift();
    if (isNaN(_loc1))
    {
        return (false);
    } // end if
    var _loc3 = obj.shift();
    var _loc2 = obj.shift();
    if (_loc3 == "" || _loc3 == undefined)
    {
        return (false);
    } // end if
    if (_loc2 == "" || _loc2 == undefined)
    {
        return (false);
    } // end if
    if (INTERFACE.nicknames_mc["p" + _loc1] == undefined)
    {
        return (false);
    } // end if
    if (String(_loc2) == "0" || _loc2 == "")
    {
        INTERFACE.nicknames_mc["p" + _loc1].name_txt.textColor = 0;
    }
    else
    {
        INTERFACE.nicknames_mc["p" + _loc1].name_txt.textColor = "0x" + _loc2;
    } // end else if
    if (String(_loc3) == "0" || _loc3 == "")
    {
        INTERFACE.nicknames_mc["p" + _loc1].name_txt.filters = undefined;
    }
    else
    {
        var _loc5 = new flash.filters.GlowFilter("0x" + _loc3, 10, 1.700000, 1.700000, 15, 3, false, false);
        INTERFACE.nicknames_mc["p" + _loc1].name_txt.filters = [_loc5];
    } // end else if
} // End of the function
function handleRealTimeNickChange(obj)
{
    obj.shift();
    var _loc1 = obj.shift();
    if (isNaN(_loc1))
    {
        return (false);
    } // end if
    var _loc2 = obj.shift();
    if (_loc2 == "" || _loc2 == undefined)
    {
        return (false);
    } // end if
    if (INTERFACE.nicknames_mc["p" + _loc1] == undefined)
    {
        return (false);
    } // end if
    INTERFACE.nicknames_mc["p" + _loc1].name_txt.text = _loc2;
    var _loc3 = INTERFACE.getPlayerObject(_loc1);
    _loc3.nickname = _loc2;
} // End of the function
function handleRealTimeTransform(obj)
{
    obj.shift();
    var _loc3 = obj.shift();
    if (isNaN(_loc3))
    {
        return (false);
    } // end if
    var _loc4 = obj.shift();
    if (transformations[_loc4] == undefined)
    {
        return (false);
    } // end if
    var _loc7 = INTERFACE.getPlayerObject(_loc3);
    _loc7.characterId = _loc4;
    var _loc5 = ENGINE.getPlayerMovieClip(_loc3);
    var _loc8 = com.clubpenguin.util.URLUtils.getCacheResetURL(_global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + "/play/v2/content/global/avatar/sprites/" + _loc4 + ".swf");
    if (_loc4 == "penguin")
    {
        _loc8 = com.clubpenguin.util.URLUtils.getCacheResetURL(_global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + "/play/v2/content/global/penguin/penguin.swf");
    } // end if
    if (SHELL.transformations[_loc4] == false)
    {
        _loc5._xscale = 60;
        _loc5._yscale = 60;
    }
    else
    {
        _loc5._xscale = 100;
        _loc5._yscale = 100;
    } // end else if
    var _loc6 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    _loc6.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, ENGINE.onPlayerLoadInitTransform, _loc7, _loc3, INTERFACE.nicknames_mc["p" + _loc3]._x, INTERFACE.nicknames_mc["p" + _loc3]._y));
    _loc6.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, ENGINE.onPlayerLoadStart, target_mc));
    _loc6.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, ENGINE.onPlayerLoadProgress, target_mc));
    _loc6.loadClip(_loc8, _loc5.art_mc);
} // End of the function
function handleSetCurrentClothes(obj)
{
    obj.shift();
    currentSavedClothes = new Object();
    for (var _loc13 in obj)
    {
        var _loc1 = obj[_loc13].split("|");
        if (_loc1[6] == undefined)
        {
            continue;
        } // end if
        currentSavedClothes[Number(_loc1[0])] = {uniqueID: _loc1[0], outfitName: _loc1[9], mood: _loc1[8], color: _loc1[1], head: _loc1[2], face: _loc1[3], neck: _loc1[4], body: _loc1[5], hand: _loc1[6], feet: _loc1[7]};
    } // end of for...in
    return (false);
} // End of the function
function handleSaveOutfit(obj)
{
    obj.shift();
    var _loc1 = obj.shift().split("|");
    currentSavedClothes[Number(_loc1[0])] = {uniqueID: _loc1[0], outfitName: _loc1[1], mood: _loc1[8], color: _loc1[9], head: _loc1[3], face: _loc1[5], neck: _loc1[4], body: _loc1[7], hand: _loc1[6], feet: _loc1[2]};
} // End of the function
function handleDivorceRelationship(obj)
{
    obj.shift();
    var _loc2 = obj.shift();
    var _loc1 = INTERFACE.getPlayerObject(_loc2);
    _loc1.playercard_attributes.r = new Array(0, 0, "");
} // End of the function
function handleAcceptRelationship(obj)
{
    obj.shift();
    var _loc4 = obj.shift();
    var _loc6 = obj.shift();
    var _loc2 = obj.shift();
    var _loc5 = obj.shift();
    if (isNaN(_loc2))
    {
        return (false);
    } // end if
    var _loc3 = INTERFACE.getPlayerObject(_loc4);
    _loc3.playercard_attributes.r = new Array(_loc6, _loc2, _loc5);
} // End of the function
function handleSetPlayercardValue(obj)
{
    obj.shift();
    var _loc4 = obj.shift();
    var _loc3 = obj.shift();
    var _loc5 = obj.shift();
    if (isNaN(_loc4))
    {
        return (false);
    } // end if
    var _loc1 = INTERFACE.getPlayerObject(_loc4);
    if (_loc3 == "scg")
    {
        _loc1.playercard_attributes.sc = _loc5;
        _loc1.playercard_attributes.sg = obj.shift();
    }
    else
    {
        _loc1.playercard_attributes[_loc3] = _loc5;
    } // end else if
} // End of the function
function handleRealTimeBubbleColor(obj)
{
    obj.shift();
    var _loc3 = obj.shift();
    if (isNaN(_loc3))
    {
        return (false);
    } // end if
    var _loc1 = obj.shift();
    var _loc2 = obj.shift();
    if (_loc1 == "" || _loc1 == undefined)
    {
        return (false);
    } // end if
    if (_loc2 == "" || _loc2 == undefined)
    {
        return (false);
    } // end if
    var _loc5 = INTERFACE.getPlayerObject(_loc3);
    _loc5.player_attributes.b = [_loc1, _loc2];
} // End of the function
function handleRealTimePenguinSize(obj)
{
    obj.shift();
    var _loc2 = obj.shift();
    if (isNaN(_loc2))
    {
        return (false);
    } // end if
    var _loc3 = obj.shift();
    if (_loc3 == "" || _loc3 == undefined)
    {
        return (false);
    } // end if
    var _loc1 = ENGINE.getPlayerMovieClip(_loc2);
    if (transformations[_loc1.characterId] != undefined && _loc1.characterId != "penguin")
    {
        return (false);
    } // end if
    var _loc6 = _loc1.scaleXO;
    _loc1.player_attributes.x = _loc3;
    switch (_loc1.player_attributes.x)
    {
        case 0:
        case "0":
        {
            _loc1._xscale = 100;
            _loc1._yscale = 100;
            var _loc4 = new TextFormat();
            _loc4.size = 12;
            INTERFACE.nicknames_mc["p" + _loc2].name_txt.setTextFormat(_loc4);
            break;
        } 
        case 1:
        case "1":
        {
            _loc1._xscale = 60;
            _loc1._yscale = 60;
            _loc4 = new TextFormat();
            _loc4.size = 8;
            INTERFACE.nicknames_mc["p" + _loc2].name_txt.setTextFormat(_loc4);
            break;
        } 
        case 2:
        case "2":
        {
            _loc1._xscale = 40;
            _loc1._yscale = 40;
            _loc4 = new TextFormat();
            _loc4.size = 8;
            INTERFACE.nicknames_mc["p" + _loc2].name_txt.setTextFormat(_loc4);
            break;
        } 
    } // End of switch
} // End of the function
function handleRealTimePenguinSpeed(obj)
{
    obj.shift();
    var _loc2 = obj.shift();
    if (isNaN(_loc2))
    {
        return (false);
    } // end if
    var _loc1 = obj.shift();
    if (_loc1 == "" || _loc1 == undefined)
    {
        return (false);
    } // end if
    var _loc4 = ENGINE.getPlayerMovieClip(_loc2);
    _loc4.player_attributes.s = _loc1;
} // End of the function
function handleRealTimeSnowballColor(obj)
{
    obj.shift();
    var _loc2 = obj.shift();
    if (isNaN(_loc2))
    {
        return (false);
    } // end if
    var _loc1 = obj.shift();
    if (_loc1 == "" || _loc1 == undefined)
    {
        return (false);
    } // end if
    var _loc4 = ENGINE.getPlayerMovieClip(_loc2);
    _loc4.player_attributes.sc = _loc1;
} // End of the function
function handleRealTimeRingColor(obj)
{
    obj.shift();
    var _loc3 = obj.shift();
    if (isNaN(_loc3))
    {
        return (false);
    } // end if
    var _loc2 = obj.shift();
    if (_loc2 == "" || _loc2 == undefined)
    {
        return (false);
    } // end if
    var _loc1 = ENGINE.getPlayerMovieClip(_loc3);
    _loc1.player_attributes.r = _loc2;
    if (_loc2 == "0")
    {
        _loc1.art_mc.ring._visible = false;
    }
    else
    {
        _loc1.art_mc.ring._visible = true;
        var _loc4 = new Color(_loc1.art_mc.ring);
        _loc4.setRGB("0x" + _loc1.player_attributes.r);
    } // end else if
} // End of the function
function handleRealTimeStatusColor(obj)
{
    obj.shift();
    var _loc3 = obj.shift();
    if (isNaN(_loc3))
    {
        return (false);
    } // end if
    var _loc2 = obj.shift();
    var _loc1 = obj.shift();
    if (_loc2 == "" || _loc2 == undefined)
    {
        return (false);
    } // end if
    if (_loc1 == "" || _loc1 == undefined)
    {
        return (false);
    } // end if
    var _loc5 = INTERFACE.getPlayerObject(_loc3);
    _loc5.data[33] = _loc2 + "-" + _loc1;
} // End of the function
function handleRealTimePenguinMood(obj)
{
    obj.shift();
    var _loc2 = obj.shift();
    if (isNaN(_loc2))
    {
        return (false);
    } // end if
    var _loc1 = obj.shift();
    if (_loc1 == "" || _loc1 == undefined)
    {
        return (false);
    } // end if
    var _loc3 = INTERFACE.getPlayerObject(_loc2);
    _loc3.data[32] = _loc1;
} // End of the function
function handleGetIgnoreListFromServer(obj)
{
    var _loc6 = obj.shift();
    ignore_list = new Array();
    var _loc1;
    var _loc5;
    var _loc3;
    var _loc2;
    for (var _loc2 in obj)
    {
        _loc1 = obj[_loc2].split("|");
        _loc5 = Number(_loc1[0]);
        _loc3 = _loc1[1];
        addPlayerToIgnoreList(_loc5, _loc3);
    } // end of for...in
    AIRTOWER.removeListener(AIRTOWER.GET_IGNORE_LIST, handleGetIgnoreListFromServer);
} // End of the function
function handleModeratorAction(obj)
{
    var _loc7 = obj[0];
    var _loc2 = obj[1];
    var _loc6 = Number(obj[2]);
    var _loc5 = obj[3];
    var _loc3;
    if (_loc2 == AIRTOWER.BAN)
    {
        _loc3 = getLocalizedString("ban_player_hint");
    }
    else if (_loc2 == AIRTOWER.KICK)
    {
        _loc3 = getLocalizedString("kick_player_hint");
    }
    else if (_loc2 == AIRTOWER.MUTE)
    {
        _loc3 = getLocalizedString("mute_player_hint");
    } // end else if
    var _loc1 = {};
    _loc1.mod_action = _loc2;
    _loc1.message = _loc3;
    _loc1.player_id = _loc6;
    _loc1.nickname = _loc5;
    _loc1.type = SEND_BLOCKED_MESSAGE;
    addToChatLog(_loc1);
} // End of the function
function handleStartMailEngine(obj)
{
    var _loc4 = obj.shift();
    $d("[mail engine] handleStartMailEngine() -> " + obj);
    var _loc3 = Number(obj[0]);
    var _loc1 = Number(obj[1]);
    setTotalMessages(_loc1);
    setTotalSets(_loc1);
    if (_loc3 > 0)
    {
        setNewMailCountOnServer(_loc3);
        updateListeners(NEW_MAIL, getNewMailCount());
    } // end if
    if (_loc1 > 0)
    {
        setHasMessages(true);
    } // end if
} // End of the function
function handleDeleteMailFromUser(obj)
{
    var _loc2 = obj.shift();
    mail_engine.total_mail = Number(obj[0]);
    if (mail_engine.mail.length < getMessagesPerSet())
    {
        if (nextSetAvailable())
        {
            getNextSet(debugMailList);
        } // end if
    } // end if
    updateListeners(TOTAL_MAIL, mail_engine.total_mail);
    updateListeners(NEW_MAIL, getNewMailCount());
    mail_engine.on_delete_user_mail_response();
    mail_engine.on_delete_user_mail_response = undefined;
} // End of the function
function handleSendMailItem(result)
{
    var _loc5 = Number(result[0]);
    var _loc3 = Number(result[1]);
    var _loc4 = Number(result[2]);
    var _loc1 = {};
    switch (_loc4)
    {
        case MAIL_SUCCESSFULLY_SENT:
        {
            _loc1.status_code = MAIL_SUCCESSFULLY_SENT;
            break;
        } 
        case MAIL_NOT_ENOUGH_COINS:
        {
            _loc1.status_code = MAIL_NOT_ENOUGH_COINS;
            break;
        } 
        case MAIL_INBOX_FULL:
        {
            _loc1.status_code = MAIL_INBOX_FULL;
            break;
        } 
        default:
        {
            _loc1.status_code = MAIL_SUCCESSFULLY_SENT;
            break;
        } 
    } // End of switch
    updateListeners(MAIL_SEND_STATUS, _loc1);
    setMyPlayerTotalCoins(_loc3);
} // End of the function
function handleRecieveMailItem(obj)
{
    var _loc4 = obj.shift();
    if (obj[0] == undefined || obj[1] == undefined || obj[2] == undefined || obj[3] == undefined)
    {
        $e("[mail engine] handleRecieveMailItem() We received a malformed mail item.");
        return (false);
    } // end if
    $d("[mail engine] handleRecieveMailItem() -> " + obj);
    ++mail_engine.new_mail_count;
    var _loc3 = getPenguinStandardTime(Number(crumb[4]) * ONE_SECOND_IN_MILLISECONDS);
    var _loc2 = {from: obj[0], user_id: Number(obj[1]), pc_id: Number(obj[2]), details: obj[3], date: _loc3, unq_id: Number(obj[5]), read: 0};
    if (mail_engine.has_fetched == true)
    {
        mail_engine.mail.splice(0, 0, _loc2);
    }
    else if (getHasMessages())
    {
        if (mail_engine.new_mail_queue == undefined)
        {
            mail_engine.new_mail_queue = new Array();
        } // end if
        mail_engine.new_mail_queue.splice(0, 0, _loc2);
    }
    else
    {
        if (mail_engine.mail == undefined)
        {
            mail_engine.mail = new Array();
        } // end if
        mail_engine.mail.splice(0, 0, _loc2);
    } // end else if
    setLastRecievedId(_loc2.unq_id);
    mail_engine.total_mail = mail_engine.total_mail + 1;
    updateListeners(RECIEVE_MAIL, getNewMailCount());
    updateListeners(TOTAL_MAIL, mail_engine.total_mail);
    updateListeners(NEW_MAIL, getNewMailCount());
} // End of the function
function handleGetMail(obj)
{
    var _loc2 = obj.shift();
    if (!mail_engine.has_fetched)
    {
        handleGetFirstMail(obj);
    }
    else
    {
        handleGetNextSet(obj);
    } // end else if
} // End of the function
function handleGetFirstMail(obj)
{
    var _loc6 = new Array();
    if (obj.length > 0)
    {
        var _loc1;
        var _loc15 = obj.length;
        var _loc2 = 0;
        var _loc3 = 0;
        var _loc5 = getNewMailCountOnServer();
        while (_loc2 < _loc15)
        {
            _loc3 = 1;
            if (_loc5 > 0)
            {
                _loc3 = 0;
                --_loc5;
            } // end if
            _loc1 = obj[_loc2].split("|");
            var _loc4 = getPenguinStandardTime(Number(_loc1[4]) * ONE_SECOND_IN_MILLISECONDS);
            _loc6.push({from: _loc1[0], user_id: Number(_loc1[1]), pc_id: Number(_loc1[2]), details: _loc1[3], date: _loc4, unq_id: Number(_loc1[5]), read: _loc3});
            ++_loc2;
        } // end while
        if (mail_engine.new_mail_queue.length > 0)
        {
            _loc6 = mail_engine.new_mail_queue.concat(_loc6);
            mail_engine.new_mail_queue = undefined;
        }
        else
        {
            setLastRecievedId(_loc6[_loc6.length - 1].unq_id);
        } // end else if
        mail_engine.mail = _loc6;
        if (getNewMailCountOnServer() > 0)
        {
            setNewMailCountOnServer(_loc5);
        } // end if
    } // end if
    mail_engine.has_fetched = true;
    getMailResponseFunc()(mail_engine.mail);
} // End of the function
function handleGetNextSet(obj)
{
    $d("[mail engine] onNextSetResponse() -> " + obj);
    if (obj.length > 0)
    {
        var _loc13 = new Array();
        if (obj.length > 0)
        {
            var _loc1;
            var _loc15 = obj.length;
            var _loc2 = 0;
            var _loc5 = getNewMailCountOnServer();
            var _loc3;
            var _loc16 = 12;
            var _loc17 = getCurrentSet() * _loc16;
            while (_loc2 < _loc15)
            {
                _loc3 = 1;
                if (_loc5 > 0)
                {
                    _loc3 = 0;
                    --_loc5;
                } // end if
                _loc1 = obj[_loc2].split("|");
                var _loc4 = getPenguinStandardTime(Number(_loc1[4]) * ONE_SECOND_IN_MILLISECONDS);
                _loc13.push({from: _loc1[0], user_id: Number(_loc1[1]), pc_id: Number(_loc1[2]), details: _loc1[3], date: _loc4, unq_id: Number(_loc1[5]), read: _loc3});
                ++_loc2;
            } // end while
            mail_engine.mail = mail_engine.mail.concat(_loc13);
            if (getNewMailCountOnServer() > 0)
            {
                setNewMailCountOnServer(_loc5);
            } // end if
        } // end if
        setLastRecievedId(_loc13[_loc13.length - 1].unq_id);
        mail_engine.on_next_set_response(mail_engine.mail);
    } // end if
} // End of the function
function handleDonateToCharity(arr)
{
    var _loc3 = Number(arr[0]);
    var _loc1 = Number(arr[1]);
    setMyPlayerTotalCoins(_loc1);
} // End of the function
function handleOnTimeoutStop(timeout)
{
    var _loc1;
    for (var _loc1 in timeouts)
    {
        if (timeouts[_loc1] == timeout)
        {
            timeouts[_loc1] = undefined;
            return (delete timeouts[_loc1]);
        } // end if
    } // end of for...in
    return (false);
} // End of the function
function handleRelationshipRequest(obj)
{
    obj.shift();
    REL = new Array();
    REL.relationshipType = obj.shift();
    REL.requestID = obj.shift();
    REL.requestName = obj.shift();
    REL.dataKey = obj.shift();
    INTERFACE.handleNewRequest({type: REL.relationshipType});
} // End of the function
function handleReceivedCredits(obj)
{
    obj.shift();
    var _loc1 = obj.shift();
    if (isNaN(_loc1))
    {
        return;
    } // end if
    setMyPlayerTotalCredits(Number(getMyPlayerTotalCredits()) + Number(_loc1));
} // End of the function
function handleGetMySnowballInfo(result)
{
    result.shift();
    snowballInfo.health_maximum = Number(result.shift());
    snowballInfo.is_accurate = Boolean(Number(result.shift()));
    snowballInfo.white_snowball = Number(result.shift());
    snowballInfo.yellow_snowball = Number(result.shift());
    snowballInfo.red_snowball = Number(result.shift());
    snowballInfo.healing_supply = Number(result.shift());
    snowballInfo.alpha = Number(result.shift());
    snowballInfo.size_decrease = Number(result.shift());
} // End of the function
function handleSocketServerRevision(result)
{
    AIRTOWER.removeListener(AIRTOWER.GET_LAST_REVISION, this.handleSocketServerRevision, this);
    if (!isNaN(result[1]))
    {
    } // end if
} // End of the function
function handleGetNinjaLevel(result)
{
    var _loc1 = {};
    _loc1.currentNinjaLevel = result[1];
    _loc1.percentageToNextLevel = result[2];
    updateListeners(GET_NINJA_LEVEL, _loc1);
} // End of the function
function handleGetCards(result)
{
    var _loc7 = result[1];
    var _loc3 = _loc7.split("|");
    var _loc6 = {};
    _loc6.cards = [];
    var _loc2;
    for (var _loc1 = 0; _loc1 < _loc3.length; ++_loc1)
    {
        _loc2 = _loc3[_loc1].split(",");
        _loc6.cards.push({id: _loc2[0], quantity: _loc2[1]});
    } // end of for
    cardsCache = _loc6.cards;
    updateListeners(GET_CARDS, _loc6);
} // End of the function
function handleGetNinjaRanks(result)
{
    var _loc2 = {};
    _loc2.playerID = result[1];
    _loc2.cardJitsuRank = isNaN(result[2]) ? (-1) : (result[2]);
    _loc2.firePathRank = isNaN(result[3]) ? (-1) : (result[3]);
    _loc2.waterPathRank = isNaN(result[4]) ? (-1) : (result[4]);
    _loc2.snowPathRank = isNaN(result[5]) ? (-1) : (result[5]);
    updateListeners(GET_NINJA_RANKS, _loc2);
} // End of the function
function handleGetFireLevel(result)
{
    var _loc1 = {};
    _loc1.currentNinjaLevel = result[1];
    _loc1.percentageToNextLevel = result[2];
    updateListeners(GET_FIRE_LEVEL, _loc1);
} // End of the function
function handleGetWaterLevel(result)
{
    var _loc1 = {};
    _loc1.currentNinjaLevel = result[1];
    _loc1.percentageToNextLevel = result[2];
    updateListeners(GET_WATER_LEVEL, _loc1);
} // End of the function
function attachShellListenersToAirtower()
{
    AIRTOWER.addListener(AIRTOWER.HANDLE_ERROR, handleServerError);
    AIRTOWER.addListener(AIRTOWER.CONNECTION_LOST, handleConnectionLost);
    enableAirtower();
} // End of the function
function quietAirtower()
{
    AIRTOWER.removeListener("osave", handleSaveOutfit);
    AIRTOWER.removeListener("setoufits", handleSetCurrentClothes);
    AIRTOWER.removeListener("transform", handleRealTimeTransform);
    AIRTOWER.removeListener("rtnc", handleRealTimeNickChange);
    AIRTOWER.removeListener("rtpsz", handleRealTimePenguinSize);
    AIRTOWER.removeListener("rtstc", handleRealTimeStatusColor);
    AIRTOWER.removeListener("setvalue", handleSetPlayercardValue);
    AIRTOWER.removeListener("rtpm", handleRealTimePenguinMood);
    AIRTOWER.removeListener("rtng", handleRealTimeNameglow);
    AIRTOWER.removeListener("rtbc", handleRealTimeBubbleColor);
    AIRTOWER.removeListener("rtsc", handleRealTimeSnowballColor);
    AIRTOWER.removeListener("rtrc", handleRealTimeRingColor);
    AIRTOWER.removeListener("rtps", handleRealTimePenguinSpeed);
    AIRTOWER.removeListener("setperm", handleSetPermissions);
    AIRTOWER.removeListener("moveplayer", handleMovePlayer);
    AIRTOWER.removeListener("da", handleBlockSpace);
    AIRTOWER.removeListener("gmsi", handleGetMySnowballInfo);
    AIRTOWER.removeListener("gcfm", handleReceivedCredits);
    AIRTOWER.removeListener("accept", handleAcceptRelationship);
    AIRTOWER.removeListener("request", handleRelationshipRequest);
    AIRTOWER.removeListener("divorce", handleDivorceRelationship);
    AIRTOWER.removeListener("like", handleSendNewLike);
    AIRTOWER.removeListener("throw", handlePlayerThrowSnowball);
    AIRTOWER.removeListener("setball", handleSetMySnowball);
    AIRTOWER.removeListener("health", handleSetMyHealth);
    AIRTOWER.removeListener("dead", handleSetDead);
    AIRTOWER.removeListener("kill", handleNewKill);
    AIRTOWER.removeListener("score", handleSetScore);
    AIRTOWER.removeListener("setwanted", handleSetWantedPlayer);
    AIRTOWER.removeListener("note", handleSendNote);
    AIRTOWER.removeListener("transmit", handleNewPm);
    AIRTOWER.removeListener("warn", handleWarning);
    AIRTOWER.removeListener(AIRTOWER.SEND_MESSAGE, handleSendMessage);
    AIRTOWER.removeListener(AIRTOWER.SEND_BLOCKED_MESSAGE, handleBlockedMessage);
    AIRTOWER.removeListener(AIRTOWER.SEND_SAFE_MESSAGE, handleSafeMessage);
    AIRTOWER.removeListener(AIRTOWER.SEND_LINE_MESSAGE, handleLineMessage);
    AIRTOWER.removeListener(AIRTOWER.SEND_QUICK_MESSAGE, handleSendQuickMessage);
    AIRTOWER.removeListener(AIRTOWER.SEND_TOUR_GUIDE_MESSAGE, handleTourGuideMessage);
    AIRTOWER.removeListener(AIRTOWER.SEND_EMOTE, handleSendEmote);
    AIRTOWER.removeListener(AIRTOWER.SEND_JOKE, handleSendJoke);
    AIRTOWER.removeListener(AIRTOWER.SEND_MASCOT_MESSAGE, handleMascotMessage);
    AIRTOWER.removeListener(AIRTOWER.COIN_DIG_UPDATE, handleGetCoinReward);
    AIRTOWER.removeListener(AIRTOWER.GET_INVENTORY_LIST, handleMyGetInventoryList);
    AIRTOWER.removeListener(AIRTOWER.GET_BUDDY_LIST, handleGetBuddyListFromServer);
    AIRTOWER.removeListener(AIRTOWER.GET_IGNORE_LIST, handleGetIgnoreListFromServer);
    AIRTOWER.removeListener(AIRTOWER.REMOVE_BUDDY, handleRemoveBuddyPlayer);
    AIRTOWER.removeListener(AIRTOWER.REQUEST_BUDDY, handleBuddyRequest);
    AIRTOWER.removeListener(AIRTOWER.ACCEPT_BUDDY, handleBuddyAccept);
    AIRTOWER.removeListener(AIRTOWER.BUDDY_ONLINE, handleBuddyOnline);
    AIRTOWER.removeListener(AIRTOWER.BUDDY_OFFLINE, handleBuddyOffline);
    AIRTOWER.removeListener(AIRTOWER.FIND_BUDDY, handleGetPlayerLocationById);
    AIRTOWER.removeListener(AIRTOWER.GAME_OVER, handleGameOver);
    AIRTOWER.removeListener(AIRTOWER.BUY_INVENTORY, handleBuyInventory);
    AIRTOWER.removeListener(AIRTOWER.CHECK_INVENTORY, handleCheckInventory);
    AIRTOWER.removeListener(AIRTOWER.GET_PLAYER_OBJECT, handleLoadPlayerObject);
    AIRTOWER.removeListener(AIRTOWER.GET_FURNITURE_LIST, handleGetFurnitureListFromServer);
    AIRTOWER.removeListener(AIRTOWER.GET_IGLOO_DETAILS, handleGetPlayerIgloo);
    AIRTOWER.removeListener(AIRTOWER.GET_IGLOO_LIST, handleLoadPlayerIglooList);
    AIRTOWER.removeListener(AIRTOWER.GET_OWNED_IGLOOS, handleGetOwnedIgloos);
    AIRTOWER.removeListener(AIRTOWER.BUY_FURNITURE, handleSendBuyFurniture);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_FLOOR, handleSendBuyIglooFloor);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_IGLOO_TYPE, handleSendBuyIglooType);
    AIRTOWER.removeListener(AIRTOWER.MODERATOR_ACTION, handleModeratorAction);
    AIRTOWER.removeListener(AIRTOWER.LOAD_PLAYER, handleLoadPlayer);
    AIRTOWER.removeListener(AIRTOWER.JOIN_ROOM, handleJoinRoom);
    AIRTOWER.removeListener(AIRTOWER.JOIN_GAME, handleJoinGame);
    AIRTOWER.removeListener("snpc", handleStartNPC);
    AIRTOWER.removeListener("snbnpc", handleSetNewNPC);
    AIRTOWER.removeListener("uc", handleUpdateCoin);
    AIRTOWER.removeListener(AIRTOWER.REFRESH_ROOM, handleRefreshRoom);
    AIRTOWER.removeListener(AIRTOWER.ADD_PLAYER, handleAddPlayerToRoom);
    AIRTOWER.removeListener(AIRTOWER.REMOVE_PLAYER, handleRemovePlayerFromRoom);
    AIRTOWER.removeListener(AIRTOWER.PLAYER_MOVE, handleSendPlayerMove);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_COLOUR, handleSendUpdatePlayerColour);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_HEAD, handleSendUpdatePlayerHead);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_FACE, handleSendUpdatePlayerFace);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_NECK, handleSendUpdatePlayerNeck);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_BODY, handleSendUpdatePlayerBody);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_HAND, handleSendUpdatePlayerHand);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_FEET, handleSendUpdatePlayerFeet);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_FLAG, handleSendUpdatePlayerFlag);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_PHOTO, handleSendUpdatePlayerPhoto);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_PLAYER_REMOVE, handleSendClearPaperdoll);
    AIRTOWER.removeListener("oset", handleSendUpdatePaperdoll);
    AIRTOWER.removeListener(AIRTOWER.PLAYER_FRAME, handleSendPlayerFrame);
    AIRTOWER.removeListener(AIRTOWER.PLAYER_ACTION, handleUpdatePlayerAction);
    AIRTOWER.removeListener(AIRTOWER.OPEN_BOOK, handleOpenPlayerBook);
    AIRTOWER.removeListener(AIRTOWER.CLOSE_BOOK, handleClosePlayerBook);
    AIRTOWER.removeListener(AIRTOWER.THROW_BALL, handlePlayerThrowBall);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_TABLE, handleUpdateTableById);
    AIRTOWER.removeListener(AIRTOWER.GET_TABLE_POPULATION, handleGetTablesPopulationById);
    AIRTOWER.removeListener(AIRTOWER.JOIN_TABLE, handleSendJoinTableById);
    AIRTOWER.removeListener(AIRTOWER.LEAVE_TABLE, handleLeaveTable);
    AIRTOWER.removeListener(AIRTOWER.UPDATE_WADDLE, handleUpdateWaddle);
    AIRTOWER.removeListener(AIRTOWER.GET_WADDLE_POPULATION, handleGetWaddlesPopulationById);
    AIRTOWER.removeListener(AIRTOWER.JOIN_WADDLE, handleSendJoinWaddleById);
    AIRTOWER.removeListener(AIRTOWER.LEAVE_WADDLE, handleLeaveWaddle);
    AIRTOWER.removeListener(AIRTOWER.START_WADDLE, startWaddle);
    AIRTOWER.removeListener(AIRTOWER.SEND_WADDLE, handleJoinWaddle);
    AIRTOWER.removeListener(AIRTOWER.MAIL_START_ENGINE, handleStartMailEngine);
    AIRTOWER.removeListener(AIRTOWER.GET_MAIL, handleGetMail);
    AIRTOWER.removeListener(AIRTOWER.RECEIVE_MAIL, handleRecieveMailItem);
    AIRTOWER.removeListener(AIRTOWER.SEND_MAIL, handleSendMailItem);
    AIRTOWER.removeListener(AIRTOWER.DELETE_MAIL_FROM_PLAYER, handleDeleteMailFromUser);
    AIRTOWER.removeListener(AIRTOWER.DONATE, handleDonateToCharity);
    AIRTOWER.removeListener(AIRTOWER.GET_CARDS, handleGetCards);
    AIRTOWER.removeListener(AIRTOWER.GET_NINJA_LEVEL, handleGetNinjaLevel);
    AIRTOWER.removeListener(AIRTOWER.GET_FIRE_LEVEL, handleGetFireLevel);
    AIRTOWER.removeListener(AIRTOWER.GET_NINJA_RANKS, handleGetNinjaRanks);
} // End of the function
function enableAirtower()
{
    AIRTOWER.addListener("osave", handleSaveOutfit);
    AIRTOWER.addListener("setoufits", handleSetCurrentClothes);
    AIRTOWER.addListener("transform", handleRealTimeTransform);
    AIRTOWER.addListener("rtnc", handleRealTimeNickChange);
    AIRTOWER.addListener("rtpsz", handleRealTimePenguinSize);
    AIRTOWER.addListener("rtstc", handleRealTimeStatusColor);
    AIRTOWER.addListener("setvalue", handleSetPlayercardValue);
    AIRTOWER.addListener("rtpm", handleRealTimePenguinMood);
    AIRTOWER.addListener("rtng", handleRealTimeNameglow);
    AIRTOWER.addListener("rtbc", handleRealTimeBubbleColor);
    AIRTOWER.addListener("rtsc", handleRealTimeSnowballColor);
    AIRTOWER.addListener("rtrc", handleRealTimeRingColor);
    AIRTOWER.addListener("rtps", handleRealTimePenguinSpeed);
    AIRTOWER.addListener("setperm", handleSetPermissions);
    AIRTOWER.addListener("moveplayer", handleMovePlayer);
    AIRTOWER.addListener("da", handleBlockSpace);
    AIRTOWER.addListener("gmsi", handleGetMySnowballInfo);
    AIRTOWER.addListener("gcfm", handleReceivedCredits);
    AIRTOWER.addListener("accept", handleAcceptRelationship);
    AIRTOWER.addListener("request", handleRelationshipRequest);
    AIRTOWER.addListener("divorce", handleDivorceRelationship);
    AIRTOWER.addListener("like", handleSendNewLike);
    AIRTOWER.addListener("throw", handlePlayerThrowSnowball);
    AIRTOWER.addListener("setball", handleSetMySnowball);
    AIRTOWER.addListener("health", handleSetMyHealth);
    AIRTOWER.addListener("dead", handleSetDead);
    AIRTOWER.addListener("kill", handleNewKill);
    AIRTOWER.addListener("score", handleSetScore);
    AIRTOWER.addListener("setwanted", handleSetWantedPlayer);
    AIRTOWER.addListener("note", handleSendNote);
    AIRTOWER.addListener("transmit", handleNewPm);
    AIRTOWER.addListener("warn", handleWarning);
    AIRTOWER.addListener(AIRTOWER.SEND_MESSAGE, handleSendMessage);
    AIRTOWER.addListener(AIRTOWER.SEND_BLOCKED_MESSAGE, handleBlockedMessage);
    AIRTOWER.addListener(AIRTOWER.SEND_SAFE_MESSAGE, handleSafeMessage);
    AIRTOWER.addListener(AIRTOWER.SEND_LINE_MESSAGE, handleLineMessage);
    AIRTOWER.addListener(AIRTOWER.SEND_QUICK_MESSAGE, handleSendQuickMessage);
    AIRTOWER.addListener(AIRTOWER.SEND_TOUR_GUIDE_MESSAGE, handleTourGuideMessage);
    AIRTOWER.addListener(AIRTOWER.SEND_EMOTE, handleSendEmote);
    AIRTOWER.addListener(AIRTOWER.SEND_JOKE, handleSendJoke);
    AIRTOWER.addListener(AIRTOWER.SEND_MASCOT_MESSAGE, handleMascotMessage);
    AIRTOWER.addListener(AIRTOWER.COIN_DIG_UPDATE, handleGetCoinReward);
    AIRTOWER.addListener(AIRTOWER.GET_INVENTORY_LIST, handleMyGetInventoryList);
    AIRTOWER.addListener(AIRTOWER.GET_BUDDY_LIST, handleGetBuddyListFromServer);
    AIRTOWER.addListener(AIRTOWER.GET_IGNORE_LIST, handleGetIgnoreListFromServer);
    AIRTOWER.addListener(AIRTOWER.REMOVE_BUDDY, handleRemoveBuddyPlayer);
    AIRTOWER.addListener(AIRTOWER.REQUEST_BUDDY, handleBuddyRequest);
    AIRTOWER.addListener(AIRTOWER.ACCEPT_BUDDY, handleBuddyAccept);
    AIRTOWER.addListener(AIRTOWER.BUDDY_ONLINE, handleBuddyOnline);
    AIRTOWER.addListener(AIRTOWER.BUDDY_OFFLINE, handleBuddyOffline);
    AIRTOWER.addListener(AIRTOWER.FIND_BUDDY, handleGetPlayerLocationById);
    AIRTOWER.addListener(AIRTOWER.GAME_OVER, handleGameOver);
    AIRTOWER.addListener(AIRTOWER.BUY_INVENTORY, handleBuyInventory);
    AIRTOWER.addListener(AIRTOWER.CHECK_INVENTORY, handleCheckInventory);
    AIRTOWER.addListener(AIRTOWER.GET_PLAYER_OBJECT, handleLoadPlayerObject);
    AIRTOWER.addListener(AIRTOWER.GET_FURNITURE_LIST, handleGetFurnitureListFromServer);
    AIRTOWER.addListener(AIRTOWER.GET_IGLOO_DETAILS, handleGetPlayerIgloo);
    AIRTOWER.addListener(AIRTOWER.GET_IGLOO_LIST, handleLoadPlayerIglooList);
    AIRTOWER.addListener(AIRTOWER.GET_OWNED_IGLOOS, handleGetOwnedIgloos);
    AIRTOWER.addListener(AIRTOWER.BUY_FURNITURE, handleSendBuyFurniture);
    AIRTOWER.addListener(AIRTOWER.UPDATE_FLOOR, handleSendBuyIglooFloor);
    AIRTOWER.addListener("ul", handleSendBuyIglooLocation);
    AIRTOWER.addListener("snpc", handleStartNPC);
    AIRTOWER.addListener("snbnpc", handleSetNewNPC);
    AIRTOWER.addListener("uc", handleUpdateCoin);
    AIRTOWER.addListener(AIRTOWER.UPDATE_IGLOO_TYPE, handleSendBuyIglooType);
    AIRTOWER.addListener(AIRTOWER.MODERATOR_ACTION, handleModeratorAction);
    AIRTOWER.addListener(AIRTOWER.LOAD_PLAYER, handleLoadPlayer);
    AIRTOWER.addListener(AIRTOWER.JOIN_ROOM, handleJoinRoom);
    AIRTOWER.addListener(AIRTOWER.JOIN_GAME, handleJoinGame);
    AIRTOWER.addListener(AIRTOWER.REFRESH_ROOM, handleRefreshRoom);
    AIRTOWER.addListener(AIRTOWER.ADD_PLAYER, handleAddPlayerToRoom);
    AIRTOWER.addListener(AIRTOWER.REMOVE_PLAYER, handleRemovePlayerFromRoom);
    AIRTOWER.addListener(AIRTOWER.PLAYER_MOVE, handleSendPlayerMove);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_COLOUR, handleSendUpdatePlayerColour);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_HEAD, handleSendUpdatePlayerHead);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_FACE, handleSendUpdatePlayerFace);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_NECK, handleSendUpdatePlayerNeck);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_BODY, handleSendUpdatePlayerBody);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_HAND, handleSendUpdatePlayerHand);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_FEET, handleSendUpdatePlayerFeet);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_FLAG, handleSendUpdatePlayerFlag);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_PHOTO, handleSendUpdatePlayerPhoto);
    AIRTOWER.addListener(AIRTOWER.UPDATE_PLAYER_REMOVE, handleSendClearPaperdoll);
    AIRTOWER.addListener("oset", handleSendUpdatePaperdoll);
    AIRTOWER.addListener(AIRTOWER.PLAYER_FRAME, handleSendPlayerFrame);
    AIRTOWER.addListener(AIRTOWER.PLAYER_ACTION, handleUpdatePlayerAction);
    AIRTOWER.addListener(AIRTOWER.OPEN_BOOK, handleOpenPlayerBook);
    AIRTOWER.addListener(AIRTOWER.CLOSE_BOOK, handleClosePlayerBook);
    AIRTOWER.addListener(AIRTOWER.THROW_BALL, handlePlayerThrowBall);
    AIRTOWER.addListener(AIRTOWER.UPDATE_TABLE, handleUpdateTableById);
    AIRTOWER.addListener(AIRTOWER.GET_TABLE_POPULATION, handleGetTablesPopulationById);
    AIRTOWER.addListener(AIRTOWER.JOIN_TABLE, handleSendJoinTableById);
    AIRTOWER.addListener(AIRTOWER.LEAVE_TABLE, handleLeaveTable);
    AIRTOWER.addListener(AIRTOWER.UPDATE_WADDLE, handleUpdateWaddle);
    AIRTOWER.addListener(AIRTOWER.GET_WADDLE_POPULATION, handleGetWaddlesPopulationById);
    AIRTOWER.addListener(AIRTOWER.JOIN_WADDLE, handleSendJoinWaddleById);
    AIRTOWER.addListener(AIRTOWER.LEAVE_WADDLE, handleLeaveWaddle);
    AIRTOWER.addListener(AIRTOWER.START_WADDLE, startWaddle);
    AIRTOWER.addListener(AIRTOWER.SEND_WADDLE, handleJoinWaddle);
    AIRTOWER.addListener(AIRTOWER.MAIL_START_ENGINE, handleStartMailEngine);
    AIRTOWER.addListener(AIRTOWER.GET_MAIL, handleGetMail);
    AIRTOWER.addListener(AIRTOWER.RECEIVE_MAIL, handleRecieveMailItem);
    AIRTOWER.addListener(AIRTOWER.SEND_MAIL, handleSendMailItem);
    AIRTOWER.addListener(AIRTOWER.DELETE_MAIL_FROM_PLAYER, handleDeleteMailFromUser);
    AIRTOWER.addListener(AIRTOWER.DONATE, handleDonateToCharity);
    AIRTOWER.addListener(AIRTOWER.GET_CARDS, handleGetCards);
    AIRTOWER.addListener(AIRTOWER.GET_NINJA_LEVEL, handleGetNinjaLevel);
    AIRTOWER.addListener(AIRTOWER.GET_FIRE_LEVEL, handleGetFireLevel);
    AIRTOWER.addListener(AIRTOWER.GET_WATER_LEVEL, handleGetWaterLevel);
    AIRTOWER.addListener(AIRTOWER.GET_NINJA_RANKS, handleGetNinjaRanks);
} // End of the function
var client_rev = 10;
var currentContext = {};
var banned_items = new Object();
var globalVolume = new Sound();
var isMuted = false;
var browsingItem = -1;
var seconds_played = 0;
flash.external.ExternalInterface.addCallback("sendNewPM", null, sendNewPM);
var REL = new Object();
System.security.allowDomain("*");
var isSnowball = false;
var current_bot_str;
var disabledArea = [];
var disabledAreaRoom = 0;
var NPCModule;
var OasisModeration;
var OasisPermission;
var PROMPTS;
var ContextManager;
var heartbeat;
var send_local_connection;
var listen_local_connection;
var saved_game;
var SAVED_GAME_LOCATION = "/";
var SAVED_GAME_NAME = "SaveGame";
var SAVED_GAME_VERSION = 1;
var MAX_SAVED_PLAYERS = 6;
var player_to_save;
var last_world_id;
var dependencyHolder = this.createEmptyMovieClip("dependencyHolder", this.getNextHighestDepth());
setupLightbox(this);
setupLoading(this);
setupErrorScreen(this);
var WHITE_FRAME = this.attachMovie("whiteFrame", "whiteFrame", this.getNextHighestDepth());
var AIRTOWER;
var SENTRY;
var POSTCARDS;
var MAIL;
var GRIDVIEW;
var MUSIC;
var MERCH_HOLDER;
var LOGIN_HOLDER;
var ENGINE;
var INTERFACE;
var SHELL = this;
var IGLOO_HOLDER;
var LOCAL_CRUMBS = local_crumbs_mc;
var GLOBAL_CRUMBS = global_crumbs_mc;
var NEWS_CRUMBS = news_crumbs_mc;
var WEB_CRUMBS_SERVICE;
var INVENTORY_TYPE_COLOUR = 0;
var INVENTORY_TYPE_HEAD = 1;
var INVENTORY_TYPE_FACE = 2;
var INVENTORY_TYPE_NECK = 3;
var INVENTORY_TYPE_BODY = 4;
var INVENTORY_TYPE_HAND = 5;
var INVENTORY_TYPE_FEET = 6;
var INVENTORY_TYPE_FLAG = 7;
var INVENTORY_TYPE_PHOTO = 8;
var INVENTORY_TYPE_OTHER = 9;
var INVENTORY_EXCLUSIVE = 1;
var INVENTORY_SUPER_EXCLUSIVE = 2;
var PAPERDOLLDEPTH_TOP_LAYER = 7500;
var PAPERDOLLDEPTH_HAND_LAYER = 7000;
var PAPERDOLLDEPTH_BETWEEN_HAND_AND_HEAD = 6500;
var PAPERDOLLDEPTH_HEAD_LAYER = 6000;
var PAPERDOLLDEPTH_BETWEEN_HEAD_AND_FACE = 5500;
var PAPERDOLLDEPTH_FACE_LAYER = 5000;
var PAPERDOLLDEPTH_BETWEEN_FACE_AND_NECK = 4500;
var PAPERDOLLDEPTH_NECK_LAYER = 4000;
var PAPERDOLLDEPTH_BETWEEN_NECK_AND_BODY = 3500;
var PAPERDOLLDEPTH_BODY_LAYER = 3000;
var PAPERDOLLDEPTH_BETWEEN_BODY_AND_FEET = 2500;
var PAPERDOLLDEPTH_FEET_LAYER = 2000;
var PAPERDOLLDEPTH_BETWEEN_FEET_AND_BACK = 1500;
var PAPERDOLLDEPTH_BACK_LAYER = 1000;
var PAPERDOLLDEPTH_BOTTOM_LAYER = 500;
var PAPERDOLL_DEFAULT_LAYER_DEPTHS = {hand: PAPERDOLLDEPTH_HAND_LAYER, head: PAPERDOLLDEPTH_HEAD_LAYER, face: PAPERDOLLDEPTH_FACE_LAYER, neck: PAPERDOLLDEPTH_NECK_LAYER, body: PAPERDOLLDEPTH_BODY_LAYER, feet: PAPERDOLLDEPTH_FEET_LAYER, back: PAPERDOLLDEPTH_BACK_LAYER};
var FURNITURE_TYPE_ROOM = 0;
var FURNITURE_TYPE_WALL = 1;
var FURNITURE_TYPE_FLOOR = 2;
var FURNITURE_SORT_ROOM = 0;
var FURNITURE_SORT_WALL = 1;
var FURNITURE_SORT_FLOOR = 2;
var FURNITURE_SORT_PET = 3;
var PLAYER_ROOM_SMART_ID_CUTOFF = 1000;
_global.getCurrentShell = function ()
{
    return (SHELL);
};
_global.getCurrentAirtower = function ()
{
    return (SHELL.AIRTOWER);
};
_global.getCurrentIgloo = function ()
{
    return (IGLOO_HOLDER);
};
_global.getCurrentEngine = function ()
{
    return (SHELL.dependencyHolder.engine);
};
_global.getCurrentInterface = function ()
{
    return (SHELL.dependencyHolder.INTERFACE);
};
var is_running_local = undefined;
var server_switch = false;
var domain_name = getDomainName();
var puffleModelManager;
var puffleManager;
var MAX_PUFFLES;
var ENV_SANDBOX_01 = "sandbox01";
var ENV_SANDBOX_02 = "sandbox02";
var ENV_SANDBOX_03 = "sandbox03";
var ENV_SANDBOX_04 = "sandbox04";
var ENV_SANDBOX_05 = "sandbox05";
var ENV_SANDBOX_06 = "sandbox06";
var ENV_SANDBOX_07 = "sandbox07";
var ENV_SANDBOX_08 = "sandbox08";
var ENV_SANDBOX_09 = "sandbox09";
var ENV_QA_01 = "qa01";
var ENV_QA_02 = "qa02";
var ENV_QA_03 = "qa03";
var ENV_QA_04 = "qa04";
var ENV_LIVE = "live";
var ENV_LOCAL = "local";
var ENV_STAGE = "stage";
var PROTOCOL_FILE = "file";
var PROTOCOL_HTTP = "http";
var PROTOCOL_HTTPS = "https";
var current_environment = ENV_LIVE;
parseEnvironment();
var DEFAULT_AFFILIATE_ID = 0;
var DEFAULT_PROMOTION_ID = -1;
var localized_folder;
var local_paths_object;
var global_paths_object;
var affiliateID = DEFAULT_AFFILIATE_ID;
var promotionID = DEFAULT_PROMOTION_ID;
var LOCAL_CRUMBS_PATH = "content/local/";
var GLOBAL_CRUMBS_PATH = "content/global/crumbs/";
var LOCAL_CRUMBS_FILE = "local_crumbs.swf";
var GLOBAL_CRUMBS_FILE = "global_crumbs.swf";
var NEWSPAPER_CRUMBS_FILE = "news_crumbs.swf";
var START_SCREEN_XML = "login/startscreen.xml";
var START_SCREEN_ICONS = "login/messages/icons/";
var START_SCREEN_POPUPS = "login/messages/popups/";
var START_SCREEN_BACKGROUNDS = "login/backgrounds/";
var IGLOO_PATH = "igloo";
var basePath;
var clientPath;
var globalContentPath;
var localContentPath;
var gamesPath;
var fieldOpWeek;
var getAffiliateID = getAffilateId;
var language_obj = new Object();
var joke_arr = new Array();
var safe_message_arr = new Array();
var mascot_message_arr = new Array();
var line_message_arr = new Array();
var quick_message_arr = new Array();
var tour_guide_message_arr = new Array();
var treveresed_safe_message_obj = new Object();
var treveresed_mascot_message_obj = new Object();
var EN_ABBR = "en";
var PT_ABBR = "pt";
var FR_ABBR = "fr";
var ES_ABBR = "es";
var EN_FRAME = 1;
var PT_FRAME = 2;
var FR_FRAME = 3;
var ES_FRAME = 4;
var EN_BITMASK = 1;
var PT_BITMASK = 2;
var FR_BITMASK = 4;
var ES_BITMASK = 8;
var currentLanguageAbbreviation = EN_ABBR;
var currentLanguageFrame = EN_FRAME;
var currentLanguageBitmask = EN_BITMASK;
var getLanguageAbbriviation = getLanguageAbbreviation;
var errors = new Array();
var e_func = new Object();
var window_size = new Object();
var STAGE_URL = "http://stage.play.clubpenguin.com/";
var WINDOW_SMALL = 1;
var WINDOW_MEDIUM = 2;
var WINDOW_LARGE = 3;
var WINDOW_EXTRA_LARGE = 4;
window_size[WINDOW_SMALL] = {w: 354, h: 200};
window_size[WINDOW_MEDIUM] = {w: 354, h: 240};
window_size[WINDOW_LARGE] = {w: 354, h: 260};
window_size[WINDOW_EXTRA_LARGE] = {w: 460, h: 280};
var DEFAULT_ERROR_TYPE = "d";
var DEFAULT_ERROR_CODE = -1;
var DEFAULT_ERROR = DEFAULT_ERROR_CODE;
var NO_CONNECTION = 0;
var CONNECTION_LOST = 1;
var TIME_OUT = 2;
var MULTI_CONNECTIONS = 3;
var DISCONNECT = 4;
var KICK = 5;
var NAME_NOT_FOUND = 100;
var PASSWORD_WRONG = 101;
var SERVER_FULL = 103;
var PASSWORD_REQUIRED = 130;
var PASSWORD_SHORT = 131;
var PASSWORD_LONG = 132;
var NAME_REQUIRED = 140;
var NAME_SHORT = 141;
var NAME_LONG = 142;
var LOGIN_FLOODING = 150;
var PLAYER_IN_ROOM = 200;
var ROOM_FULL = 210;
var GAME_FULL = 211;
var ROOM_CAPACITY_RULE = 212;
var ITEM_IN_HOUSE = 400;
var NOT_ENOUGH_COINS = 401;
var ITEM_NOT_EXIST = 402;
var NOT_ENOUGH_MEDALS = 405;
var NAME_NOT_ALLOWED = 441;
var PUFFLE_LIMIT_M = 440;
var PUFFLE_LIMIT_NM = 442;
var ALREADY_OWN_IGLOO = 500;
var BAN_DURATION = 601;
var BAN_AN_HOUR = 602;
var BAN_FOREVER = 603;
var AUTO_BAN = 610;
var HACKING_AUTO_BAN = 611;
var GAME_CHEAT = 800;
var ACCOUNT_NOT_ACTIVATE = 900;
var BUDDY_LIMIT = 901;
var NO_PLAY_TIME = 910;
var OUT_PLAY_TIME = 911;
var GROUNDED = 913;
var PLAY_TIME_OVER = 914;
var SYSTEM_REBOOT = 990;
var NOT_MEMBER = 999;
var NO_DB_CONNECTION = 1000;
var TIME_WARNING = 10001;
var TIMEOUT = 10002;
var PASSWORD_SAVE_PROMPT = 10003;
var SOCKET_LOST_CONNECTION = 10004;
var LOAD_ERROR = 10005;
var MAX_IGLOO_FURNITURE_ERROR = 10006;
var MULTIPLE_CONNECTIONS = 10007;
var CONNECTION_TIMEOUT = 10008;
var MAX_STAMPBOOK_COVER_ITEMS = 10009;
var REDEMPTION_CONNECTION_LOST = 20001;
var REDEMPTION_ALREADY_HAVE_ITEM = 20002;
var REDEMPTION_SERVER_FULL = 20103;
var REDEMPTION_BOOK_ID_NOT_EXIST = 20710;
var REDEMPTION_BOOK_ALREADY_REDEEMED = 20711;
var REDEMPTION_WRONG_BOOK_ANSWER = 20712;
var REDEMPTION_BOOK_TOO_MANY_ATTEMPTS = 20713;
var REDEMPTION_CODE_NOT_FOUND = 20720;
var REDEMPTION_CODE_ALREADY_REDEEMED = 20721;
var REDEMPTION_TOO_MANY_ATTEMPTS = 20722;
var REDEMPTION_CATALOG_NOT_AVAILABLE = 20723;
var REDEMPTION_NO_EXCLUSIVE_REDEEMS = 20724;
var REDEMPTION_CODE_GROUP_REDEEMED = 20725;
var REDEMPTION_CODE_EXPIRED = 20726;
var REDEMPTION_PUFFLES_MAX = 20730;
var REDEMPTION_PUFFLE_INVALID = 21700;
var REDEMPTION_PUFFLE_CODE_MAX = 21701;
var REDEMPTION_CODE_TOO_SHORT = 21702;
var REDEMPTION_CODE_TOO_LONG = 21703;
var GOLDEN_CODE_NOT_READY = 21704;
e_func[DEFAULT_ERROR] = e_default;
e_func[NO_CONNECTION] = e_noConnection;
e_func[CONNECTION_LOST] = e_connectionLost;
e_func[TIME_OUT] = e_timeOut;
e_func[MULTI_CONNECTIONS] = e_multiConnections;
e_func[DISCONNECT] = e_disconnect;
e_func[KICK] = e_kick;
e_func[876] = e_relationshipErrorOne;
e_func[877] = e_relationshipErrorTwo;
e_func[NAME_NOT_FOUND] = e_nameNotFound;
e_func[PASSWORD_WRONG] = e_passwordWrong;
e_func[SERVER_FULL] = e_serverFull;
e_func[PASSWORD_REQUIRED] = e_passwordRequired;
e_func[PASSWORD_SHORT] = e_passwordShort;
e_func[PASSWORD_LONG] = e_passwordLong;
e_func[NAME_REQUIRED] = e_nameRequired;
e_func[NAME_SHORT] = e_nameShort;
e_func[NAME_LONG] = e_nameLong;
e_func[LOGIN_FLOODING] = e_loginFlooding;
e_func[PLAYER_IN_ROOM] = e_playerInRoom;
e_func[ROOM_FULL] = e_roomFull;
e_func[GAME_FULL] = e_gameFull;
e_func[ROOM_CAPACITY_RULE] = e_roomCapacityRule;
e_func[ITEM_IN_HOUSE] = e_itemInHouse;
e_func[NOT_ENOUGH_COINS] = e_notEnoughCoins;
e_func[NOT_ENOUGH_MEDALS] = e_notEnoughMedals;
e_func[ITEM_NOT_EXIST] = e_itemNotExist;
e_func[NAME_NOT_ALLOWED] = e_nameNotAllowed;
e_func[PUFFLE_LIMIT_M] = e_puffleLimitMember;
e_func[PUFFLE_LIMIT_NM] = e_puffleLimitNonMember;
e_func[ALREADY_OWN_IGLOO] = e_alreadyOwnIgloo;
e_func[BAN_DURATION] = e_banDuration;
e_func[BAN_AN_HOUR] = e_banAnHour;
e_func[BAN_FOREVER] = e_banForever;
e_func[AUTO_BAN] = e_autoBan;
e_func[HACKING_AUTO_BAN] = e_hackingAutoBan;
e_func[GAME_CHEAT] = e_gameCheat;
e_func[ACCOUNT_NOT_ACTIVATE] = e_accountNotActive;
e_func[BUDDY_LIMIT] = e_buddyLimit;
e_func[NO_PLAY_TIME] = e_noPlayTime;
e_func[OUT_PLAY_TIME] = e_outPlayTime;
e_func[GROUNDED] = e_grounded;
e_func[PLAY_TIME_OVER] = e_playTimeOver;
e_func[SYSTEM_REBOOT] = e_systemReboot;
e_func[NOT_MEMBER] = e_notMember;
e_func[NO_DB_CONNECTION] = e_noDatabaseConnection;
e_func[TIME_WARNING] = e_timeWarning;
e_func[TIMEOUT] = e_timeout;
e_func[PASSWORD_SAVE_PROMPT] = e_passwordSavePrompt;
e_func[SOCKET_LOST_CONNECTION] = e_connectionLost;
e_func[LOAD_ERROR] = e_loadError;
e_func[MAX_IGLOO_FURNITURE_ERROR] = e_maxFurniture;
e_func[CONNECTION_TIMEOUT] = e_connectionAttemptTimedOut;
e_func[MAX_STAMPBOOK_COVER_ITEMS] = e_maxStampBookCoverItems;
var error_cover;
var error_window;
var error_window_on_close;
var local_error_obj = new Object();
var SOCKET_ERROR = "SOCKET ERROR";
var CLIENT_ERROR = "CLIENT ERROR";
var shell_errors_active = true;
var idle_interval = 0;
var last_update = getLocalEpoch();
var idle_timeout = 600000;
var idle_timeout_freq = 60000;
var key_listener;
var currentSavedClothes = new Object();
var mouse_listener;
var DEBUG_MODE = true;
var loading;
var isLoadingScreenVisible = false;
var lightbox;
var close_func_holder;
var shell_listener_container = new Object();
var SEND_MESSAGE = "sendMessage";
var SEND_BLOCKED_MESSAGE = "sendBlockedMessage";
var SEND_SAFE_MESSAGE = "sendSafeMessage";
var SEND_LINE_MESSAGE = "sendLineMessage";
var SEND_QUICK_MESSAGE = "sendQuickMessage";
var SEND_TOUR_GUIDE_MESSAGE = "sendTourGuideMessage";
var SEND_MASCOT_MESSAGE = "sendMascotMessage";
var SEND_EMOTE = "sendEmote";
var SEND_JOKE = "sendJoke";
var SHOW_EMOTE = "showEmote";
var GAME_OVER = "gameOver";
var BUY_INVENTORY = "buyInventory";
var CHECK_INVENTORY = "checkInventory";
var GET_INVENTORY_LIST = "getInventoryList";
var ADD_PLAYER = "addPlayer";
var REMOVE_PLAYER = "removePlayer";
var UPDATE_PLAYER = "updatePlayer";
var PLAYER_MOVE = "playerMove";
var PLAYER_FRAME = "playerFrame";
var PLAYER_ACTION = "playerAction";
var OPEN_BOOK = "openBook";
var CLOSE_BOOK = "closeBook";
var THROW_BALL = "throwBall";
var BALL_LAND = "ballLand";
var JOIN_ROOM = "joinRoom";
var REFRESH_ROOM = "refreshRoom";
var JOIN_GAME = "joinGame";
var BROWSER_CLOSE = "browserClose";
var COIN_DIG_UPDATE = "coinDigUpdate";
var ACHIEVEMENT_EVENT = "achievement";
var ACHIEVEMENT_EARNED_EVENT = "achievementEarned";
var GEOCACHE_EVENT = "geocache";
var STAMP_EARNED_ANIM_DONE = "stampEarnedAnimDone";
var ACHIEVEMENT_DONE = "achievementDone";
var PLAYERS_STAMP_BOOK_CATEGORIES = "playersStampBookCategories";
var PLAYERS_STAMPS = "playersStamps";
var MY_RECENTLY_EARNED_STAMPS = "myRecentlyEarnedStamps";
var STAMP_BOOK_COVER_DETAILS = "stampBookCoverDetails";
var LOAD_COMPLETE = "slc";
var ROOM_INITIATED = "sri";
var ROOM_DESTROYED = "srd";
var GET_PLAYER_INVENTORY = "gpi";
var UPDATE_CHAT_LOG = "ucl";
var START_ENGINE = "sten";
var START_INTERFACE = "stin";
var NEW_MAIL = "nm";
var TOTAL_MAIL = "tm";
var RECIEVE_MAIL = "rm";
var GAME_OVER;
var BUY_INVENTORY;
var UPDATE_COINS = "upc";
var UPDATE_CREDITS = "upcr";
var UPDATE_INVENTORY = "upi";
var FURNITURE_INTERACTIVE_TYPES = "fit";
var UPDATE_BUDDY_LIST = "ubl";
var SEND_BUDDY_REQUEST = "sbr";
var SEND_BUDDY_ACCEPT = "abr";
var BUDDY_ONLINE = "buo";
var LOAD_PLAYER_OBJECT = "spo";
var UPDATE_EGG_TIMER = "uet";
var GET_PLAYER_LOCATION = "gpl";
var GET_FURNITURE_LIST = "gfl";
var UPDATE_IGLOO_FLOOR = "uif";
var UPDATE_IGLOO_TYPE = "uit";
var IGLOO_LOCK_STATUS = "ils";
var GET_IGLOO_DETAILS = "gid";
var JOIN_PLAYER_IGLOO = "jpi";
var LOAD_PLAYER_IGLOO_LIST = "lpil";
var GET_OWNED_IGLOOS = "getOwnedIgloos";
var BUY_IGLOO_FLOOR = "buyIglooFloor";
var BUY_IGLOO_BG = "buyIglooBG";
var BUY_IGLOO_TYPE = "buyIglooType";
var BUY_FURNITURE = "buyFurniture";
var IGLOO_INIT_COMPLETE = "iglooInitComplete";
var IGLOO_FURNITURE_COMPLETE = "iglooFurnitureComplete";
var IGLOO_EDIT_MODE = "iglooEditMode";
var ADD_PUFFLE = "addPuffle";
var REQUEST_PUFFLE_MOVE = "requestPuffleMove";
var PUFFLE_MOVE = "puffleMove";
var PUFFLE_FRAME = "puffleFrame";
var PUFFLE_WALK = "puffleWalk";
var ADOPT_PUFFLE = "adoptPuffle";
var PUFFLE_INTERACTION = "puffleInteraction";
var REQUEST_PUFFLE_INTERACTION = "requestPuffleInteration";
var UPDATE_TABLE = "upt";
var JOIN_TABLE = "jt";
var LEAVE_TABLE = "lt";
var UPDATE_WADDLE = "uw";
var JOIN_WADDLE = "jw";
var LEAVE_WADDLE = "lw";
var START_WADDLE = "sw";
var MAIL_SEND_STATUS = "mss";
var PLAYER_MOVE_DONE = "pmd";
var GET_CARDS = "getCards";
var GET_NINJA_LEVEL = "getNinjaLevel";
var GET_FIRE_LEVEL = "getFireLevel";
var GET_WATER_LEVEL = "getWaterLevel";
var GET_NINJA_RANKS = "getNinjaRanks";
var WORLD_CONNECT_SUCCESS = "worldConnectSuccess";
var currently_loading_path;
var current_load_attempt;
var load_queue = new Array();
var FREEZE_CODE_HASH = "theultimatesupermonkeycomicbooks";
var MAX_LOAD_ATTEMPS = 3;
var SWF = ".swf";
var __loadInterval = null;
var __holder = null;
var INTERVAL_RATE = 10;
var __initFunction = null;
var __path = null;
var __options = null;
var __delayInterval = null;
var __itemsLoaded = null;
var __onLoadInPostCard = null;
var __clipList = null;
var server_time;
var serverTimezoneOffset;
var local_time;
var calculated_time_difference;
var calculated_timezone_offset;
var DEFAULT_TIMEZONE_OFFSET = 7;
var MINUTES_IN_DAY = 1440;
var ONE_MINUTE_IN_MILLISECONDS = 60000;
var TWO_MINUTES_IN_MILLISECONDS = 120000;
var THREE_MINUTES_IN_MILLISECONDS = 180000;
var FOUR_MINUTES_IN_MILLISECONDS = 240000;
var FIVE_MINUTES_IN_MILLISECONDS = 300000;
var ONE_SECOND_IN_MILLISECONDS = 1000;
var TWO_SECONDS_IN_MILLISECONDS = 2000;
var ONE_DAY_IN_MILLISECONDS = 86400000;
var is_egg_timer_active = false;
var egg_timer_milliseconds_remaining = 0;
var egg_timer_interval;
var my_game = new Object();
var MAX_GAME_SCORE = 999999999;
var game_crumbs = {};
var phoneGameCrumbs = {};
var game_room_smart_id = undefined;
var waddle_list = new Object();
var my_room;
var room_player_list;
var last_known_room_name;
var last_known_xpos;
var last_known_ypos;
var current_server_room_id = undefined;
var current_crumb_room_id = undefined;
var room_crumbs = new Object();
var current_room_id;
var last_room_id;
var roomIds_visited = [];
var playerJoinedRoom = new org.osflash.signals.Signal();
var news_crumbs;
var postcard_flat_arr;
var postcard_category_list;
var postcard_crumbs;
var postcard_count;
var SET_COOKIE_METHOD = "setCookie";
var MEMBERSHIP_STATUS_COOKIE_NAME = "cpvisitor";
var MEMBERSHIP_STATUS_COOKIE_EXPIRY_IN_DAYS = 730;
var MEMBER_COOKIE_VALUE = "returnpaid";
var NON_MEMBER_COOKIE_VALUE = "returnfree";
var my_player = {};
var epfPhoneRequested = false;
var player_cache = [];
var MAX_PLAYERS_IN_CACHE = 20;
var minutes_played = -1;
var membership_days_remaining = -1;
addListener(UPDATE_PLAYER, handleUpdatePlayer);
var playerAgentStatusChanged = playerAgentStatusChanged = new org.osflash.signals.Signal(Boolean);
var EPFSystemPostCardID = 112;
var EPFPlayerPostCardID = 47;
var inventory_crumbs = undefined;
var localized_inventory_crumbs = undefined;
var inventory_arr = [];
var player_colours = new Object();
var frame_hacks;
var furniture_crumbs = new Object();
var localized_furniture_crumbs = undefined;
var furniture_list;
var INTERACTIVE_PLAY = 0;
var INTERACTIVE_REST = 1;
var INTERACTIVE_FEED = 2;
var is_igloo_locked = true;
var player_igloo;
var igloo_player_id;
var player_igloo_furniture;
var ownedIgloos;
var igloosCached = false;
var current_igloo_type;
var current_igloo_floor_id;
var current_igloo_background_id;
var current_igloo_location_id;
var is_room_igloo = false;
var iglooOptions = {};
var igloo_crumbs = {};
var floor_crumbs = {};
var myStoredIglooObject = null;
var localized_igloo_crumbs = undefined;
var MAX_IGLOO_ITEMS = 120;
var DEFAULT_IGLOO_TYPE_ID = 1;
var DEFAULT_IGLOO_MUSIC_ID = 0;
var DEFAULT_IGLOO_FLOOR_ID = 0;
var DEFAULT_IGLOO_FURNITURE = [];
var mascot_crumbs;
var mascot_options;
var hunt_crumbs;
var on_hunt_success_func;
var on_hunt_failure_func;
var achievement_crumbs;
var achievement_group_complete;
var buddyList = undefined;
var buddyRequest = new Object();
var MAX_BUDDY_COUNT = 200;
var ignore_list = undefined;
var REPORT_SWEARING = 0;
var REPORT_SEXUAL_LANGUAGE = 1;
var REPORT_RACIAL_WORDS = 2;
var REPORT_PERSONAL_INFO = 3;
var REPORT_EMAIL_ADDRESS = 4;
var REPORT_REAL_NAME = 5;
var REPORT_NAME_CALLING = 6;
var REPORT_BAD_PENGUIN_NAME = 7;
var mail_engine = undefined;
var total_sent_messages = 0;
var MAX_MAIL_MESSAGES = 250;
var POSTCARD_COST = 10;
var MAIL_INBOX_FULL = 0;
var MAIL_SUCCESSFULLY_SENT = 1;
var MAIL_NOT_ENOUGH_COINS = 2;
var active_postcard;
var world_id_holder;
var world_crumbs;
var localized_world_crumbs;
var login_server;
var redemption_server;
var webService;
var world_list = new Array();
var is_world_safe = false;
var current_world_obj;
var UPDATE_SHELL_STATE = "updateShellState";
var SETUP_STATE = 0;
var LOGIN_STATE = 1;
var PLAY_STATE = 2;
var GAME_STATE = 3;
var EDIT_STATE = 4;
var MERCH_STATE = 5;
var MAIL_STATE = 6;
var currentState;
var states_holder = new Array();
var GLOBAL_CRUMBS_LOADING_MESSAGE = "Loading Global Files";
var NEWS_CRUMBS_LOADING_MESSAGE = "Loading Content";
var CRUMBS_PATH = "crumbs/";
var NEWS_PATH = "news/";
addState(SETUP_STATE, showSetup, hideSetup);
addState(LOGIN_STATE, showLogin, hideLogin);
var login_init = false;
var __pollInterval = null;
var PROP_INTERVAL = 40;
var loginDepLoader;
var chat_log;
var room_chat_log;
var MAX_CHAT_LOG_ENTRIES = 20;
addState(PLAY_STATE, setupPlay, hidePlay);
var play_state_init = false;
var playDepLoader;
addState(EDIT_STATE, setupEdit, hideEdit);
addState(MERCH_STATE, showMerch, hideMerch);
var merchDepLoader;
var merchApp;
var __delayInterval = null;
var INTERVAL_RATE = 500;
addState(MAIL_STATE, setupMailState, hideMailState);
var client_cookies = new Array();
var MISSION_COOKIE = "missionCookie_";
var GAME_COOKIE = "gameCookie_";
var CLIENT_COOKIE = "clientCookie_";
var PARTY_COOKIE = "clientCookie_";
var omnitureAnalytics = new com.clubpenguin.shell.analytics.OmnitureAnalytics(this);
var webLoggerAnalytics = new com.clubpenguin.shell.analytics.WebLoggerAnalytics(this);
var analyticLoggers = [omnitureAnalytics, webLoggerAnalytics];
var timeouts = {};
setupRootContextMenu();
var bootDepLoader;
var createDepLoader;
var bootDependencies;
var loginDependencies;
var createDependencies;
var merchDependencies;
var joinDependencies;
var DEPENDENCIES_FILENAME = "dependencies.json";
var AS3_GATEWAY_METHOD = "messageFromAS2";
var MSG_OPEN_NEWSPAPER = "openNewspaper";
var MSG_OPEN_MODULE = "openModule";
var MSG_CLOSE_DIALOG = "closeDialog";
var MSG_MAKE_PLAYER_VO = "buildPlayerVO";
var swfBridge;
var isLag = false;
var cardsRequested = false;
var cardsCache;
var MAX_FIRE_PATH_LEVEL = 4;
var MAX_WATER_PATH_LEVEL = 4;
var currentRoomService;
var equipmentService;
var epfService;
var mailService;
var inbox;
var FIELD_OPS_SERVICE = "/web_service/epf.php";
var fieldOp = new com.clubpenguin.fieldop.FieldOp();
var stampNotifier = new com.clubpenguin.stamps.StampNotifier(this);
var stampManager;
var transformations = {puffle_blue: true, puffle_black: true, puffle_brown: true, puffle_green: true, puffle_orange: true, puffle_pink: true, puffle_green: true, puffle_purple: true, puffle_red: true, puffle_yellow: true, puffle_rainbow: true, puffle_gold: true, puffle_white: true, puffle_purple_trex: true, puffle_black_trex: true, puffle_blue_triceratops: true, puffle_pink_stegosaurus: true, puffle_yellow_stegosaurus: true, puffle_dog: true, puffle_cat: true, Werewolf_A: true, Werewolf_B: true, Werewolf_C: true, Zombie_A: true, Zombie_B: true, Zombie_C: true, merrywalrus: false, sasquatch: false, crabHatC: true, crabHatB: true, crabHatA: true, dragon: false, Vampire_A: true, Vampire_B: true, Vampire_C: true, penguin: true};
InitAllConfigs();
var disabledInt;
var playerWantedName = false;
var playerWanted = false;
var playerWantedCredits = false;
var liked_players = new Array();
var snowballInfo = new Object();
