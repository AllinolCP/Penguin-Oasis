function getPlayerId()
{
    return (shell.getMyPlayerId());
} // End of the function
function sendBotMessage(msg)
{
    shell.addToChatLog({player_id: 0, message: msg, nickname: "Oasis", type: shell.SEND_BLOCKED_MESSAGE});
    showBalloon(0, msg);
} // End of the function
function getPlayerNickname()
{
    return (shell.getMyPlayerNickname());
} // End of the function
function getCoins()
{
    return (shell.getMyPlayerTotalCoins());
} // End of the function
function isMember()
{
    return (shell.isMyPlayerMember());
} // End of the function
function isModerator()
{
    return (is_moderator);
} // End of the function
function isSafeMode()
{
    return (shell.isMyPlayerSafeMode());
} // End of the function
function isSecretAgent()
{
    return (shell.isMyPlayerSecretAgent());
} // End of the function
function isTourGuide()
{
    return (shell.isMyPlayerTourGuide());
} // End of the function
function isItemInInventory(item_id)
{
    return (shell.isItemInMyInventory(item_id));
} // End of the function
function isEggTimerActive()
{
    return (shell.isEggTimerActive());
} // End of the function
function getEggTimerMinutesRemaining()
{
    return (shell.getEggTimerMinutesRemaining());
} // End of the function
function getPlayerObject(player_id, isBuddyList)
{
    if (playerCache[Number(player_id)] != undefined && isBuddyList == true)
    {
        return (playerCache[Number(player_id)]);
    } // end if
    var _loc2 = shell.getPlayerObjectById(player_id);
    playerCache[Number(player_id)] = _loc2;
    return (_loc2);
} // End of the function
function getPlayerRelationship(player_id, isBuddyList)
{
    if (isLocalPlayer(player_id))
    {
        return ("Player");
    } // end if
    if (isBuddy(player_id))
    {
        if (isBuddyOnline(player_id))
        {
            return ("Online");
        }
        else
        {
            return ("Offline");
        } // end else if
    }
    else if (isIgnored(player_id))
    {
        return ("Ignore");
    }
    else if (shell.isPlayerMascotById(player_id))
    {
        return ("Mascot");
    }
    else
    {
        return ("None");
    } // end else if
} // End of the function
function isLocalPlayer(player_id)
{
    return (shell.isMyPlayer(player_id));
} // End of the function
function isBuddy(player_id)
{
    return (shell.isPlayerBuddyById(player_id));
} // End of the function
function isBuddyOnline(player_id)
{
    return (shell.isBuddyOnlineById(player_id));
} // End of the function
function isIgnored(player_id)
{
    return (shell.isPlayerIgnoredById(player_id));
} // End of the function
function getBuddyList()
{
    var _loc2 = shell.getSortedBuddyList();
    var _loc1 = 0;
    var _loc3 = _loc2.length;
    while (_loc1 < _loc3)
    {
        _loc2[_loc1].is_buddy = true;
        _loc2[_loc1].is_ignored = false;
        ++_loc1;
    } // end while
    return (_loc2);
} // End of the function
function getIgnoreList()
{
    var _loc2 = shell.getSortedIgnoreList();
    var _loc1 = 0;
    var _loc3 = _loc2.length;
    while (_loc1 < _loc3)
    {
        _loc2[_loc1].is_buddy = false;
        _loc2[_loc1].is_ignored = true;
        _loc2[_loc1].is_online = true;
        ++_loc1;
    } // end while
    return (_loc2);
} // End of the function
function getPlayerList()
{
    var _loc2 = shell.getSortedPlayerList();
    var _loc1 = 0;
    var _loc3 = _loc2.length;
    while (_loc1 < _loc3)
    {
        _loc2[_loc1].is_online = true;
        ++_loc1;
    } // end while
    return (_loc2);
} // End of the function
function getItemList()
{
    return (shell.getMyInventoryArray());
} // End of the function
function handleRoomDestroyed()
{
    resetRoomBalloonManager();
} // End of the function
function getLocalizedString(message)
{
    return (shell.getLocalizedString(message));
} // End of the function
function isInventoryEmptyByType(type)
{
    var _loc1 = getItemList();
    if (type == "ALL" && _loc1.length > 0)
    {
        return (false);
    }
    else
    {
        for (var _loc3 in _loc1)
        {
            if (_loc1[_loc3].type == shell[type])
            {
                return (false);
            } // end if
        } // end of for...in
    } // end else if
    return (true);
} // End of the function
function showItemGridview(type, clickFunction)
{
    var _loc1 = getItemList();
    var _loc5 = getFilePath("clothing_icons");
    var _loc2 = new Array();
    if (type != "ALL")
    {
        for (var _loc4 in _loc1)
        {
            if (_loc1[_loc4].type == shell[type])
            {
                _loc2.push(_loc1[_loc4]);
            } // end if
        } // end of for...in
    }
    else
    {
        _loc2 = _loc1;
    } // end else if
    if (_loc2.length > 0)
    {
        shell.gotoState(shell.EDIT_STATE);
        _loc2.sortOn("id", Array.NUMERIC);
        shell.startGridview(_loc2, _loc5, clickFunction, {on_close: closeItemGridView});
    } // end if
} // End of the function
function closeItemGridView()
{
    shell.gotoState(shell.PLAY_STATE);
    closeWindow();
} // End of the function
function getInventoryObjectById(item_id)
{
    return (shell.getInventoryObjectById(item_id));
} // End of the function
function getColourHex(colour_id)
{
    return (shell.getPlayerHexFromId(colour_id));
} // End of the function
function getLog()
{
    return (shell.getChatLog());
} // End of the function
function getRoomObject()
{
    return (shell.getRoomObject());
} // End of the function
function getFilePath(name)
{
    return (shell.getPath(name));
} // End of the function
function getShellConstant(name)
{
    return (shell[name]);
} // End of the function
function isInventoryMemberOnly(item_id)
{
    return (shell.isInventoryMemberOnly(item_id));
} // End of the function
function getCurrentNews()
{
    return (shell.news_crumbs[0].issue);
} // End of the function
function getEggTimerRemaining()
{
    var _loc1 = myPlayer.start_time;
    var _loc2 = myPlayer.EggTimer;
    var _loc3 = getTimer();
    return (_loc2 - (_loc3 - _loc1));
} // End of the function
function isEggTimer()
{
    var _loc1 = shell.getMyPlayerObject();
    return (_loc1.IsEggTimer);
} // End of the function
function getScript()
{
    return (shell.getLineMessageArray());
} // End of the function
function getSafeMessages()
{
    return (shell.getSafeMessageArray());
} // End of the function
function getPuffleObjectById(puffle_id)
{
    return (shell.getPuffleObjectById(puffle_id));
} // End of the function
function handleUpdateShellState(ob)
{
    traceObject(ob);
    if (ob.state == shell.PLAY_STATE)
    {
        startQuickKeys();
    }
    else
    {
        stopQuickKeys();
    } // end else if
} // End of the function
function handleUpdateInventory()
{
    showPhoneIcon();
} // End of the function
function handleUpdateCoins()
{
    if (isPlayerWidgetOpen() && isActivePlayer(getPlayerId()))
    {
        updatePlayerWidgetCoins();
    } // end if
} // End of the function
function handleUpdateCredits()
{
    if (isPlayerWidgetOpen() && isActivePlayer(getPlayerId()))
    {
        updatePlayerWidgetCredits();
    } // end if
} // End of the function
function handleUpdateLog(log_ob)
{
    showLog();
} // End of the function
function notify(title, msg)
{
    flash.external.ExternalInterface.call("sendNotify", title, msg);
} // End of the function
function sendMessage(message)
{
    message = message.split("\r").join("");
    message = message.split("\n").join("");
    message = removeExtraSpaces(message);
    if (message.length)
    {
        if (message == "<3")
        {
            return (sendEmote(30));
        } // end if
        if (message == "no.")
        {
            return (sendEmote(43));
        } // end if
        if (message == "LOL")
        {
            return (sendEmote(48));
        } // end if
        if (message == "$TEST_DE")
        {
            return (sendEmote(52));
        } // end if
        if (message == "$TEST_ME")
        {
            return (sendEmote(51));
        } // end if
        if (message.toLowerCase() == ":d")
        {
            return (sendEmote(1));
        } // end if
        if (message.toLowerCase().indexOf("bot") != -1)
        {
            var _loc4 = message.toLowerCase();
            if (_loc4.indexOf("smile") != -1)
            {
                return (showEmoteBalloon(0, 1));
            } // end if
            if (_loc4.indexOf("heart") != -1)
            {
                return (showEmoteBalloon(0, 48));
            } // end if
            if (_loc4.indexOf("wave") != -1)
            {
                return (ENGINE.handlePlayerAction({player_id: 0, frame: 25}));
            } // end if
            if (_loc4.indexOf("dance") != -1)
            {
                return (ENGINE.handlePlayerAction({player_id: 0, frame: 26}));
            } // end if
            if (_loc4.indexOf("hide") != -1)
            {
                return (ENGINE.removePlayer(0));
            } // end if
        } // end if
        if (message.substr(0, 1) == "!")
        {
            if (message.substr(0, 8).toLowerCase() == "!penguin")
            {
                return (SHELL.sendTransform("penguin"));
            } // end if
            if (message.substr(0, 10).toLowerCase() == "!transform")
            {
                if (SHELL.transformations[message.substr(11)] != undefined)
                {
                    return (SHELL.sendTransform(message.substr(11)));
                } // end if
            } // end if
            if (message.substr(0, 7).toLowerCase() == "!action")
            {
                var _loc3 = message.split(" ");
                if (isModerator())
                {
                    sendPlayerAction(_loc3[1]);
                } // end if
            } // end if
            if (message.substr(0, 2).toLowerCase() == "!x")
            {
                return (sendBotMessage(ENGINE.getPlayerMovieClip(getPlayerId()).x + ":" + ENGINE.getPlayerMovieClip(getPlayerId()).y));
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!open")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#open", [], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!conf")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#conf", [], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!vote")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                var _loc7 = message.split(" ");
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#vote", [message.substr(6)], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!perm")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                _loc7 = message.split(" ");
                if (isNaN(_loc7[1]))
                {
                    sendBotMessage("Please enter a numeric value for !perm (" + _loc7[1] + ")");
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#perm", [_loc7[1]], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 4).toLowerCase() == "!win")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                _loc7 = message.split(" ");
                if (isNaN(_loc7[1]))
                {
                    sendBotMessage("Please enter a numeric value for !win (" + _loc7[1] + ")");
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#win", [_loc7[1]], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 10).toLowerCase() == "!tevent_on")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#tstart", [], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 11).toLowerCase() == "!tevent_off")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#tstop", [], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 9).toLowerCase() == "!event_on")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#start", [], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 10).toLowerCase() == "!event_off")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "event#stop", [], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!temp")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                var _loc11 = message.substr(6).split("|");
                var _loc9 = _loc11[0];
                var _loc10 = _loc11[1];
                sendBotMessage("Temp: " + _loc9 + " as " + _loc10);
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "service#setvalue", [_loc9, _loc10], "str", SHELL.getCurrentServerRoomId());
                return (true);
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!data")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                _loc11 = message.substr(6).split("|");
                _loc9 = _loc11[0];
                _loc10 = _loc11[1];
                sendBotMessage("Setting: " + _loc9 + " as " + _loc10);
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "service#setvalue", [_loc9, _loc10], "str", SHELL.getCurrentServerRoomId());
                flash.external.ExternalInterface.call("OasisAdmin.SetEventValue", _global.getCurrentShell().serviceRoom.eventId, _loc9, _loc10);
                flash.external.ExternalInterface.call("OasisAdmin.UpdateEvent", _global.getCurrentShell().serviceRoom.eventId);
                return (true);
            } // end if
            if (message.substr(0, 6).toLowerCase() == "!board")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                SHELL.AIRTOWER.send(SHELL.AIRTOWER.PLAY_EXT, "service#setvalue", ["board", message.substr(6)], "str", SHELL.getCurrentServerRoomId());
                flash.external.ExternalInterface.call("OasisAdmin.SetEventValue", _global.getCurrentShell().serviceRoom.eventId, "board", message.substr(6));
                flash.external.ExternalInterface.call("OasisAdmin.UpdateEvent", _global.getCurrentShell().serviceRoom.eventId);
                return (true);
            } // end if
            if (message.substr(0, 2).toLowerCase() == "!y")
            {
                return (sendBotMessage(ENGINE.getPlayerMovieClip(getPlayerId())._x + ":" + ENGINE.getPlayerMovieClip(getPlayerId())._y));
            } // end if
            if (message.substr(0, 6).toLowerCase() == "!frame")
            {
                return (sendBotMessage(ENGINE.getPlayerMovieClip(getPlayerId())._currentframe));
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!info")
            {
                var _loc14 = shell.getMyPlayerObject();
                var _loc13 = ENGINE.getPlayerMovieClip(_loc14.player_id);
                sendBotMessage("x: " + _loc13._x + " y: " + _loc13._y + " f: " + _loc14.frame);
                return (true);
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!id")
            {
                return (sendBotMessage("Your ID is: " + getPlayerId()));
            } // end if
            if (message.substr(0, 4).toLowerCase() == "!hue")
            {
                _loc7 = message.split(" ");
                if (isNaN(_loc7[1]))
                {
                    return (false);
                } // end if
                shell.sendUpdatePlayercardHue(_loc7[1]);
                return (false);
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!mood")
            {
                _loc7 = message.split(" ");
                if (isNaN(_loc7[1]))
                {
                    return (false);
                } // end if
                shell.sendUpdatePlayercardFace(_loc7[1]);
                return (false);
            } // end if
            if (message.substr(0, 7).toLowerCase() == "!setval")
            {
                _loc7 = message.split(" ");
                if (_loc7[1] != "i" && _loc7[1] != "ca" && _loc7[1] != "ac")
                {
                    return (false);
                } // end if
                if (isNaN(_loc7[2]))
                {
                    return (false);
                } // end if
                shell.sendUpdatePlayercardValue([_loc7[1], _loc7[2]]);
                return (false);
            } // end if
            if (message.substr(0, 4).toLowerCase() == "!stc")
            {
                _loc7 = message.split(" ");
                if (_loc7[1].length != 3 && _loc7[1].length != 6)
                {
                    return (false);
                } // end if
                if (_loc7[2].length != 3 && _loc7[2].length != 6)
                {
                    return (false);
                } // end if
                shell.sendUpdatePlayercardValue(["scg", _loc7[1], _loc7[2]]);
                return (false);
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!ng")
            {
                var _loc18 = SHELL.getMyPlayerObject();
                if (_global.getCurrentShell().OasisPermission.hasPermission("char", _loc18.char_permissions, "nameglow") == false)
                {
                    return (false);
                } // end if
                _loc7 = message.split(" ");
                if (_loc7[1].length != 3 && _loc7[1].length != 6)
                {
                    if (_loc7[1] != "0")
                    {
                        return (false);
                    } // end if
                } // end if
                if (_loc7[2].length != 3 && _loc7[2].length != 6)
                {
                    return (false);
                } // end if
                shell.sendToOasisExtension(["n", _loc7[1], _loc7[2]]);
                return (false);
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!bc")
            {
                _loc18 = SHELL.getMyPlayerObject();
                if (_global.getCurrentShell().OasisPermission.hasPermission("char", _loc18.char_permissions, "bubble_color") == false)
                {
                    return (false);
                } // end if
                _loc7 = message.split(" ");
                if (_loc7[1].length != 3 && _loc7[1].length != 6)
                {
                    if (_loc7[1] != "0")
                    {
                        return (false);
                    } // end if
                } // end if
                if (_loc7[2].length != 3 && _loc7[2].length != 6)
                {
                    return (false);
                } // end if
                shell.sendToOasisExtension(["b", _loc7[1], _loc7[2]]);
                return (false);
            } // end if
            if (message.substr(0, 6).toLowerCase() == "!speed")
            {
                _loc18 = SHELL.getMyPlayerObject();
                if (_global.getCurrentShell().OasisPermission.hasPermission("char", _loc18.char_permissions, "character_speed") == false)
                {
                    return (false);
                } // end if
                _loc7 = message.split(" ");
                if (isNaN(_loc7[1]))
                {
                    return (false);
                } // end if
                if (Number(_loc7[1]) > 3 || Number(_loc7[1]) < 0)
                {
                    return (false);
                } // end if
                shell.sendToOasisExtension(["s", _loc7[1]]);
                return (false);
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!size")
            {
                _loc7 = message.split(" ");
                if (isNaN(_loc7[1]))
                {
                    sendBotMessage("Please enter a numeric value for !size (" + _loc7[1] + ")");
                    return (false);
                } // end if
                if (_loc7[1] > 2 || _loc7[1] < 0)
                {
                    sendBotMessage("Please enter 0, 1, or 2 for !size (" + _loc7[1] + ")");
                    return (false);
                } // end if
                sendBotMessage("Your size has been updated!");
                shell.sendToOasisExtension(["x", _loc7[1]]);
                return (false);
            } // end if
            if (message.substr(0, 6).toLowerCase() == "!emote")
            {
                if (!isModerator())
                {
                    return (false);
                } // end if
                _loc7 = message.split(" ");
                if (isNaN(_loc7[1]))
                {
                    sendBotMessage("Please enter a numeric value for !emote (" + _loc7[1] + ")");
                    return (false);
                } // end if
                sendEmote(_loc7[1]);
                return (false);
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!sc")
            {
                _loc18 = SHELL.getMyPlayerObject();
                if (_global.getCurrentShell().OasisPermission.hasPermission("char", _loc18.char_permissions, "snowball_color") == false)
                {
                    return (false);
                } // end if
                _loc7 = message.split(" ");
                if (_loc7[1].length != 3 && _loc7[1].length != 6)
                {
                    return (false);
                } // end if
                shell.sendToOasisExtension(["sc", _loc7[1]]);
                return (false);
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!rc")
            {
                _loc18 = SHELL.getMyPlayerObject();
                _loc7 = message.split(" ");
                if (_loc7[1].length != 3 && _loc7[1].length != 6)
                {
                    if (_loc7[1] != "0")
                    {
                        return (false);
                    } // end if
                } // end if
                shell.sendToOasisExtension(["rc", _loc7[1]]);
                return (false);
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!wave")
            {
                return (sendPlayerAction(25));
            } // end if
            if (message.substr(0, 10).toLowerCase() == "!roomcount")
            {
                return (sendBotMessage("Room Count: " + SHELL.getPlayerList().length));
            } // end if
            if (message.substr(0, 7).toLowerCase() == "!roomid")
            {
                return (sendBotMessage("Room ID: " + SHELL.getCurrentRoomId()));
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!jr")
            {
                _loc3 = message.split(" ");
                var _loc5 = _loc3[1];
                if (isNaN(_loc5))
                {
                    _loc5 = _loc5.toLowerCase();
                    return (sendJoinRoom(_loc5, 0, 0));
                } // end if
                var _loc12 = shell.getRoomCrumbsById(_loc5);
                if (_loc12 == undefined)
                {
                    return (shell.showErrorPrompt("max", "<strong>Oops!</strong><br/>Sorry, that room doesn\'t exist!", "Okay", undefined, "RDNE"));
                } // end if
                return (sendJoinRoom(_loc12.name, 0, 0));
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!find")
            {
                if (isModerator() == false)
                {
                    return (false);
                } // end if
                _loc3 = message.split(" ");
                if (isNaN(message.substr(6)))
                {
                    return (sendBotMessage("Invalid ID: " + message.substr(6)));
                } // end if
                return (findPlayer(message.substr(6)));
            } // end if
            if (message.substr(0, 5).toLowerCase() == "!npcr")
            {
                if (isModerator() == false)
                {
                    return (false);
                } // end if
                _loc3 = message.split(" ");
                if (isNaN(message.substr(6)))
                {
                    return (sendBotMessage("Invalid ID: " + message.substr(6)));
                } // end if
                return (SHELL.startNpcScene(message.substr(6)));
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!ai")
            {
                _loc3 = message.split(" ");
                var _loc8 = _loc3[1];
                if (isNaN(_loc8))
                {
                    return (false);
                } // end if
                var _loc15 = getInventoryObjectById(_loc8);
                if (_loc15 == undefined)
                {
                    return (shell.showErrorPrompt("max", "<strong>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                } // end if
                return (buyInventory(_loc8));
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!af")
            {
                _loc3 = message.split(" ");
                _loc8 = _loc3[1];
                if (isNaN(_loc8))
                {
                    return (false);
                } // end if
                _loc15 = shell.getFurnitureObjectById(_loc8);
                if (_loc15 == undefined)
                {
                    return (shell.showErrorPrompt("max", "<strong>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                } // end if
                return (buyFurniture(_loc8));
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!ui")
            {
                _loc3 = message.split(" ");
                _loc8 = _loc3[1];
                if (isNaN(_loc8))
                {
                    return (false);
                } // end if
                _loc15 = shell.getIglooCrumbById(_loc8);
                if (_loc15 == undefined)
                {
                    return (shell.showErrorPrompt("max", "<strong>Oops!</strong><br/>Sorry, that igloo doesn\'t exist!", "Okay", undefined, "RDNE"));
                } // end if
                return (buyIglooUpgrade(_loc8));
            } // end if
        } // end if
        if (message.substr(0, 3).toLowerCase() == "!up")
        {
            _loc3 = message.split(" ");
            switch (_loc3[1].toLowerCase())
            {
                case "0":
                {
                    return (shell.sendRemoveClothes());
                    break;
                } 
                case "a":
                {
                    if (isNaN(_loc3[2]))
                    {
                        return (false);
                    } // end if
                    _loc15 = getInventoryObjectById(_loc3[2]);
                    if (_loc15 == undefined && Number(_loc3[2]) != 0)
                    {
                        return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                    } // end if
                    return (shell.sendUpdatePlayerHand(_loc3[2]));
                    break;
                } 
                case "b":
                {
                    if (isNaN(_loc3[2]))
                    {
                        return (false);
                    } // end if
                    _loc15 = getInventoryObjectById(_loc3[2]);
                    if (_loc15 == undefined && Number(_loc3[2]) != 0)
                    {
                        return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                    } // end if
                    return (shell.sendUpdatePlayerBody(_loc3[2]));
                    break;
                } 
                case "e":
                {
                    if (isNaN(_loc3[2]))
                    {
                        return (false);
                    } // end if
                    _loc15 = getInventoryObjectById(_loc3[2]);
                    if (_loc15 == undefined && Number(_loc3[2]) != 0)
                    {
                        return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                    } // end if
                    return (shell.sendUpdatePlayerFeet(_loc3[2]));
                    break;
                } 
                case "n":
                {
                    if (isNaN(_loc3[2]))
                    {
                        return (false);
                    } // end if
                    _loc15 = getInventoryObjectById(_loc3[2]);
                    if (_loc15 == undefined && Number(_loc3[2]) != 0)
                    {
                        return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                    } // end if
                    return (shell.sendUpdatePlayerNeck(_loc3[2]));
                    break;
                } 
                case "f":
                {
                    if (isNaN(_loc3[2]))
                    {
                        return (false);
                    } // end if
                    _loc15 = getInventoryObjectById(_loc3[2]);
                    if (_loc15 == undefined && Number(_loc3[2]) != 0)
                    {
                        return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                    } // end if
                    return (shell.sendUpdatePlayerFace(_loc3[2]));
                    break;
                } 
                case "h":
                {
                    if (isNaN(_loc3[2]))
                    {
                        return (false);
                    } // end if
                    _loc15 = getInventoryObjectById(_loc3[2]);
                    if (_loc15 == undefined && Number(_loc3[2]) != 0)
                    {
                        return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                    } // end if
                    return (shell.sendUpdatePlayerHead(_loc3[2]));
                    break;
                } 
                case "c":
                {
                    var _loc6 = String(_loc3[2]);
                    if (_loc6.length == 2 || _loc6.length == 1)
                    {
                        return (shell.showErrorPrompt("max", "<string>Attention!</strong><br/>Oasis uses color codes now instead of color IDs! Example: !UP C 00FF00", "Okay", undefined, "www.colorpicker.com"));
                    } // end if
                    if (_loc6.length != 6 && _loc6.length != 3)
                    {
                        return (shell.showErrorPrompt("max", "<string>Attention!</strong><br/>Oasis uses color codes now instead of color IDs! Example: !UP C 00FF00", "Okay", undefined, "www.colorpicker.com"));
                    } // end if
                    return (shell.sendUpdatePlayerColour(_loc3[2]));
                    break;
                } 
            } // End of switch
        } // end if
        showBalloon(getPlayerId(), message);
        if (isAlone())
        {
            if (message.substr(0, 1) == "!")
            {
                return (shell.sendMessage(message));
            } // end if
            return;
        }
        else
        {
            shell.sendMessage(message);
        } // end if
    } // end else if
} // End of the function
function isAlone()
{
    if (SHELL.getIsRoomIgloo() == true)
    {
        if (SHELL.getPlayerList().length == 1)
        {
            return (true);
        } // end if
        return (false);
    } // end if
    if (SHELL.getPlayerList().length < 3)
    {
        return (true);
    } // end if
    return (false);
} // End of the function
function checkForAdvertising(msg)
{
    var _loc2 = msg.toLowerCase();
    for (var _loc1 = 0; _loc1 <= badURLS.length; ++_loc1)
    {
        if (_loc2.indexOf(badURLS[_loc1]) != -1 && badURLS[_loc1] != undefined)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function handleSendMessage(event)
{
    if (!isLocalPlayer(event.player_id))
    {
        if (isIgnored(event.player_id))
        {
            return (false);
        } // end if
        showBalloon(event.player_id, event.message);
    } // end if
} // End of the function
function handleSendBlockedMessage(event)
{
    showBannedBalloon(event.player_id, event.message);
} // End of the function
function sendSafeMessage(safe_id)
{
    var _loc1 = shell.getSafeMessageById(safe_id);
    shell.addToChatLog({player_id: getPlayerId(), message: _loc1, nickname: getPlayerNickname(), type: shell.SEND_MESSAGE});
    showBalloon(getPlayerId(), _loc1);
    if (!isAlone())
    {
        shell.sendSafeMessage(safe_id);
    } // end if
} // End of the function
function handleSendSafeMessage(ob)
{
    var _loc1 = ob.player_id;
    var _loc2 = ob.safe_id;
    var _loc3 = shell.getSafeMessageById(_loc2);
    if (!isLocalPlayer(_loc1))
    {
        if (isIgnored(_loc1))
        {
            return (false);
        } // end if
        showBalloon(_loc1, _loc3);
    } // end if
} // End of the function
function sendLineMessage(line_id)
{
    var _loc1 = shell.getLineMessageById(line_id);
    showBalloon(getPlayerId(), _loc1);
    shell.addToChatLog({player_id: getPlayerId(), message: _loc1, nickname: getPlayerNickname(), type: shell.SEND_MESSAGE});
    if (!isAlone())
    {
        shell.sendLineMessage(line_id);
    } // end if
} // End of the function
function handleSendLineMessage(ob)
{
    var _loc1 = ob.player_id;
    var _loc2 = ob.line_id;
    var _loc3 = shell.getLineMessageById(_loc2);
    if (!isLocalPlayer(_loc1))
    {
        if (isIgnored(_loc1))
        {
            return (false);
        } // end if
        showBalloon(_loc1, _loc3);
    } // end if
} // End of the function
function sendMascotMessage(line_id)
{
    var _loc1 = shell.getMascotMessageById(line_id);
    showBalloon(getPlayerId(), _loc1);
    shell.addToChatLog({player_id: getPlayerId(), message: _loc1, nickname: getPlayerNickname(), type: shell.SEND_MESSAGE});
    if (!isAlone())
    {
        shell.sendMascotMessage(line_id);
    } // end if
} // End of the function
function handleSendMascotMessage(ob)
{
    traceObject(ob);
    var _loc1 = ob.player_id;
    var _loc3 = ob.mascot_message_id;
    var _loc4 = shell.getMascotMessageById(_loc3);
    if (!isLocalPlayer(_loc1))
    {
        if (isIgnored(_loc1))
        {
            return (false);
        } // end if
        showBalloon(_loc1, _loc4);
    } // end if
} // End of the function
function sendTourGuideMessage()
{
    var _loc2 = shell.getCurrentRoomId();
    var _loc3 = shell.getRoomNameById(_loc2);
    var _loc1 = shell.getTourGuideMessageByRoomName(_loc3);
    showBalloon(getPlayerId(), _loc1);
    shell.addToChatLog({player_id: getPlayerId(), message: _loc1, nickname: getPlayerNickname(), type: shell.SEND_MESSAGE});
    if (!isAlone())
    {
        shell.sendTourGuideMessage(_loc2);
    } // end if
} // End of the function
function handleSendTourGuideMessage(ob)
{
    var _loc1 = ob.player_id;
    var _loc2 = shell.getCurrentRoomId();
    var _loc3 = shell.getRoomNameById(_loc2);
    var _loc4 = shell.getTourGuideMessageByRoomName(_loc3);
    if (!isLocalPlayer(_loc1))
    {
        if (isIgnored(_loc1))
        {
            return (false);
        } // end if
        showBalloon(_loc1, _loc4);
    } // end if
} // End of the function
function sendJoke()
{
    var _loc1 = shell.getRandomJokeId();
    var _loc2 = shell.getJokeById(_loc1);
    showBalloon(getPlayerId(), _loc2);
    if (!isAlone())
    {
        shell.sendJoke(_loc1);
    } // end if
} // End of the function
function handleSendJoke(ob)
{
    var _loc1 = ob.player_id;
    var _loc2 = ob.joke_id;
    var _loc3 = shell.getJokeById(_loc2);
    if (!isLocalPlayer(_loc1))
    {
        if (isIgnored(_loc1))
        {
            return (false);
        } // end if
        showBalloon(_loc1, _loc3);
    } // end if
} // End of the function
function sendPlayerAction(frame)
{
    ENGINE.sendPlayerAction(frame);
} // End of the function
function sendPlayerFrame(frame)
{
    ENGINE.sendPlayerFrame(frame);
} // End of the function
function sendPlayerSitDown()
{
    ENGINE.sendPlayerSitDown();
} // End of the function
function sendThrowBall(x, y)
{
    ENGINE.sendThrowBall(x, y);
} // End of the function
function sendEmote(emote_id)
{
    shell.sendEmote(emote_id);
    showEmoteBalloon(getPlayerId(), emote_id);
} // End of the function
function handleSendEmote(ob)
{
    var _loc1 = ob.player_id;
    var _loc2 = ob.emote_id;
    if (!isLocalPlayer(_loc1))
    {
        if (isIgnored(_loc1))
        {
            return (false);
        } // end if
        showEmoteBalloon(_loc1, _loc2);
    } // end if
} // End of the function
function sendJoinRoom(name, x, y)
{
    shell.sendJoinRoom(name, x, y);
} // End of the function
function sendJoinGame(name)
{
    shell.sendJoinGame(name);
} // End of the function
function sendJoinPlayerIgloo(player_id)
{
    shell.sendJoinPlayerIgloo(player_id);
} // End of the function
function sendUpdatePlayerRemoveAll()
{
    shell.sendUpdatePlayerRemoveAll(item_id);
} // End of the function
function handleUpdatePlayer(ob)
{
    traceObject(ob);
    var _loc1 = ob.player_id;
    if (isActivePlayer(_loc1))
    {
        updatePlayerWidget();
    } // end if
} // End of the function
function sendBuyInventory()
{
    showPrompt("wait");
    var _loc1 = getActiveShopItem();
    shell.sendBuyInventory(_loc1);
} // End of the function
function handleBuyInventory(ob)
{
    var _loc3 = ob.item_id;
    if (_loc3 == 8009)
    {
        return;
    } // end if
    var _loc2 = getInventoryObjectById(_loc3);
    var _loc4 = _loc2.name;
    if (ob.success)
    {
        if (!_loc2.noPurchasePopup)
        {
            var _loc1 = getLocalizedString("buy_inventory_done");
            _loc1 = replaceString("%name%", _loc4, _loc1);
            showPrompt("ok", _loc1);
        }
        else
        {
            closePrompt();
        } // end else if
    }
    else
    {
        closePrompt();
    } // end else if
} // End of the function
function sendBuyFurniture(item_id)
{
    showPrompt("wait");
    item_id = getActiveShopItem();
    shell.sendBuyFurniture(item_id);
} // End of the function
function handleBuyFurniture(ob)
{
    traceObject(ob);
    var _loc5 = ob.item_id;
    var _loc3 = shell.getFurnitureObjectById(_loc5);
    var _loc4 = _loc3.name;
    if (ob.success)
    {
        var _loc1 = getLocalizedString("buy_furniture_done");
        _loc1 = replaceString("%name%", _loc4, _loc1);
        showPrompt("ok", _loc1);
    } // end if
} // End of the function
function sendBuyIglooType(item_id)
{
    showPrompt("wait");
    item_id = getActiveShopItem();
    shell.sendBuyIglooType(item_id);
} // End of the function
function handleBuyIglooUpgrade(ob)
{
    traceObject(ob);
    if (ob.success)
    {
        var _loc3 = shell.getIglooCrumbById(ob.type_id);
        var _loc1 = getLocalizedString("buy_furniture_done");
        _loc1 = replaceString("%name%", _loc3.name, _loc1);
        showPrompt("ok", _loc1);
    } // end if
} // End of the function
function sendBuyIglooBackground(item_id)
{
    showPrompt("wait");
    item_id = getActiveShopItem();
    shell.sendBuyIglooLocation(item_id);
} // End of the function
function sendBuyIglooFloor(item_id)
{
    showPrompt("wait");
    item_id = getActiveShopItem();
    shell.sendBuyIglooFloor(item_id);
} // End of the function
function handleBuyIglooFloor(ob)
{
    traceObject(ob);
    if (ob.success)
    {
        var _loc2 = "handleBuyIglooFloor Message";
        closePrompt();
        closeContent();
    } // end if
} // End of the function
function handleBuyIglooBackground(ob)
{
    traceObject(ob);
    if (ob.success)
    {
        var _loc2 = "handleBuyIglooFloor Message";
        closePrompt();
        closeContent();
    } // end if
} // End of the function
function sendBuddyRequest()
{
    var _loc2 = getActivePlayerId();
    var _loc1 = getLocalizedString("buddy_request_sent_prompt");
    showPrompt("ok", _loc1);
    shell.sendBuddyRequest(_loc2);
} // End of the function
function handleBuddyRequest(ob)
{
    traceObject(ob);
    var _loc3 = ob.player_id;
    var _loc2 = ob.nickname;
    addBuddyRequest(_loc3, _loc2);
} // End of the function
function sendBuddyAccept()
{
    var _loc1 = getActiveBuddyRequest();
    shell.sendBuddyAccept(_loc1);
} // End of the function
function handleBuddyAccept(ob)
{
    traceObject(ob);
    var _loc3 = ob.player_id;
    var _loc2 = ob.nickname;
    addBuddyAccepted(_loc3, _loc2);
    handleUpdateBuddyList();
} // End of the function
function sendBuddyRemove()
{
    var _loc2 = getActivePlayerId();
    var _loc1 = getLocalizedString("remove_done_prompt");
    showPrompt("ok", _loc1);
    shell.sendRemoveBuddyPlayer(_loc2);
    handleUpdateBuddyList();
} // End of the function
function handleUpdateBuddyList()
{
    if (isBuddyWidgetOpen())
    {
        updateBuddyWidget();
    } // end if
    if (isPlayerWidgetOpen())
    {
        updatePlayerWidget();
    } // end if
} // End of the function
function sendIgnoreRequest()
{
    var _loc3 = getActivePlayerId();
    var _loc1 = getActivePlayerNickname();
    var _loc2 = getLocalizedString("ignore_request_sent_prompt");
    showPrompt("ok", _loc2);
    shell.sendAddIgnorePlayer(_loc3, _loc1);
    handleUpdateBuddyList();
} // End of the function
function sendIgnoreRemove()
{
    var _loc2 = getActiveIgnore();
    var _loc1 = getLocalizedString("remove_done_prompt");
    showPrompt("ok", _loc1);
    shell.sendRemoveIgnorePlayer(_loc2);
    handleUpdateBuddyList();
} // End of the function
function handleLoadPlayerObject(ob)
{
    traceObject(ob);
    var _loc1 = ob.player_id;
    if (isActivePlayer(_loc1))
    {
        updatePlayerWidget();
    } // end if
} // End of the function
function sendReportPlayer(player_id, reason_id, nickname)
{
    var _loc4 = new LoadVars();
    _loc4.myID = getPlayerId();
    _loc4.me = getPlayerNickname();
    _loc4.player_id = player_id;
    _loc4.reason_id = reason_id;
    if (reason_id == 0)
    {
        return (false);
    } // end if
    _loc4.nickname = nickname;
    var _loc2 = getLog();
    var _loc3 = "";
    for (var _loc1 = 0; _loc1 <= _loc2.length; ++_loc1)
    {
        _loc3 = _loc3 + ("|" + _loc2[_loc1].nickname + "%" + _loc2[_loc1].player_id + "%" + _loc2[_loc1].message);
    } // end of for
    _loc4.chatlog = _loc3;
    lastReportID = _loc2[_loc1].player_id;
    _loc4.onLoad = function (success)
    {
        trace ("Reported player!");
    };
    _loc4.sendAndLoad("http://api.oasis.ps/team-public/new-report", _loc4, "POST");
    shell.sendReportPlayer(player_id, reason_id, nickname);
} // End of the function
function sendAdoptPuffle(puffle_name)
{
    showPrompt("wait");
    var _loc2 = getActiveShopItem();
    puffle_name = puffle_name.split("|").join("");
    puffle_name = puffle_name.split("%").join("");
    shell.sendAdoptPuffle(_loc2, puffle_name);
} // End of the function
function handleAdoptPuffle(ob)
{
    if (ob.success)
    {
        var _loc1 = getLocalizedString("adopt_puffle_done");
        showPrompt("ok", _loc1);
    }
    else
    {
        closePrompt();
    } // end else if
} // End of the function
function sendPufflePlay()
{
    var _loc1 = getActivePuffle();
    var _loc2 = getPuffleObjectById(_loc1);
    shell.sendPufflePlay(_loc1);
    closePuffleWidget();
} // End of the function
function sendPuffleRest()
{
    var _loc1 = getActivePuffle();
    shell.sendPuffleRest(_loc1);
    closePuffleWidget();
} // End of the function
function sendPuffleFood()
{
    var _loc1 = getActivePuffle();
    shell.sendPuffleFood(_loc1);
    closePuffleWidget();
} // End of the function
function sendPuffleBath()
{
    var _loc1 = getActivePuffle();
    shell.sendPuffleBath(_loc1);
    closePuffleWidget();
} // End of the function
function sendPuffleCookie()
{
    var _loc1 = getActivePuffle();
    shell.sendPuffleCookie(_loc1);
    closePuffleWidget();
} // End of the function
function sendPuffleGum()
{
    var _loc1 = getActivePuffle();
    shell.sendPuffleGum(_loc1);
    closePuffleWidget();
} // End of the function
function sendPuffleWalk()
{
    var _loc1 = getActivePuffle();
    shell.sendStartPuffleWalk(_loc1);
    closePuffleWidget();
} // End of the function
function findPlayer(playerID)
{
    showPrompt("wait");
    shell.getPlayerLocationById(playerID);
} // End of the function
function handleFindPlayer(ob)
{
    traceObject(ob);
    var _loc1 = ob.room_id;
    var _loc2;
    if (_loc1 > 999)
    {
        var _loc7 = 2000;
        var _loc4 = _loc1 - _loc7;
        var _loc5 = getActivePlayerId();
        if (_loc4 == shell.getMyPlayerId())
        {
            _loc2 = "igloo_yours";
        }
        else if (_loc4 == _loc5)
        {
            _loc2 = "igloo_theirs";
        }
        else
        {
            _loc2 = "igloo";
        } // end else if
    }
    else if (_loc1 > 899)
    {
        _loc2 = shell.getGameCrumbsKeyById(_loc1);
    }
    else
    {
        _loc2 = shell.getRoomNameById(_loc1);
    } // end else if
    var _loc6 = getActivePlayerNickname();
    var _loc3 = shell.getLocalizedString(_loc2 + "_find");
    _loc3 = replaceString("%name%", _loc6, _loc3);
    showPrompt("ok", _loc3);
} // End of the function
function mutePlayer()
{
    var _loc1 = getActivePlayerId();
    shell.mutePlayerById(_loc1);
} // End of the function
function kickPlayer()
{
    var _loc1 = getActivePlayerId();
    shell.kickPlayerById(_loc1);
} // End of the function
function banPlayer()
{
    var _loc2 = getActiveReport();
    var _loc1 = _loc2.player_id;
    var _loc3 = _loc2.message;
    if (_loc1 == getActivePlayerId())
    {
        shell.banPlayerById(_loc1, _loc3);
    } // end if
} // End of the function
function showInterface()
{
    showIcons();
    showDock();
    closeAllWidgets();
    LOG._visible = true;
    startQuickKeys();
} // End of the function
function closeInterface()
{
    closeIcons();
    closeDock();
    closeAllWidgets();
    closeLog();
    closeHint();
    closeContent();
    closeWindow();
    LOG._visible = false;
    stopQuickKeys();
} // End of the function
function showIcons()
{
    PM_ICON._visible = true;
    PM_ICON.new_mc._visible = false;
    ICONS._visible = true;
    BUDDY_ICON._visible = false;
    MANAGER_ICON._visible = true;
    RELATIONSHIP_ICON._visible = false;
    MANAGER_ICON.onRelease = function ()
    {
        showContent("reg_manager");
    };
    PM_ICON.mail_btn.onRelease = function ()
    {
        showOutsideContent("privateMessenger");
        updateNewMailIcon(0);
    };
    updateBuddyRequestIcon();
    NEWS_ICON.news_btn.onRelease = onNewsButtonRelease;
    showPhoneIcon();
    MAP_ICON.map_btn.onRelease = function ()
    {
        showContent("map");
    };
    MOD_ICON.shield_btn.onRelease = function ()
    {
        if (shell.isPlayerMascotById(shell.getMyPlayerId()))
        {
            var _loc1 = interface_mc.widgets_mc.mascotScriptClip;
            if (_loc1 == null)
            {
                _loc1 = interface_mc.widgets_mc.attachMovie("com.clubpenguin.ui.MascotScript", "mascotScriptClip", interface_mc.widgets_mc.getNextHighestDepth());
                centerWidget(_loc1);
            } // end if
            _loc1.show();
        }
        else
        {
            showContent("mod_help");
        } // end else if
    };
} // End of the function
function onNewsButtonRelease()
{
    stopQuickKeys();
    is_news_open = true;
    ENGINE.sendOpenBook();
    var _loc1 = SHELL.getPath("current_news");
    var _loc3 = _loc1.substr(_loc1.length - 4, 4);
    if (_loc3 == ".swf")
    {
        showContent("current_news");
    }
    else
    {
        var _loc2 = new Object();
        _loc2.currentPaperPath = _loc1;
        showContent("current_AS3_news", null, undefined, _loc2);
    } // end else if
    com.clubpenguin.login.LocalData.setLastNewspaperIssue(getCurrentNews());
    com.clubpenguin.login.LocalData.savePlayerObject();
    NEWS_ICON.new_mc._visible = false;
} // End of the function
function showPhoneIcon()
{
    if (SHELL.isEPFAgent())
    {
        return;
    } // end if
    if (isSecretAgent())
    {
        PHONE_ICON._visible = true;
        PHONE_ICON.phone_btn.onRelease = function ()
        {
            showPhoneWidget();
        };
    }
    else
    {
        PHONE_ICON._visible = false;
    } // end else if
} // End of the function
function bounceIcon(mc)
{
    if (mc.start_y == undefined)
    {
        mc.start_y = mc._y;
    } // end if
    var _loc2 = new mx.transitions.Tween(mc, "_y", mx.transitions.easing.Bounce.easeOut, mc.start_y - 50, mc.start_y, 5, false);
} // End of the function
function closeIcons()
{
    ICONS._visible = false;
} // End of the function
function showCrosshair()
{
    CROSSHAIR._visible = true;
    CROSSHAIR.startDrag(true, 20, 20, 740, 440);
    CROSSHAIR._x = this._xmouse;
    CROSSHAIR._y = this._ymouse;
    CROSSHAIR.target_btn.onRelease = mx.utils.Delegate.create(this, doCrossHairRelease);
} // End of the function
function doCrossHairRelease()
{
    var _loc1 = Math.round(CROSSHAIR._x + random(10) - 10);
    var _loc2 = Math.round(CROSSHAIR._y + random(10) - 10);
    sendThrowBall(_loc1, _loc2);
    stopDrag ();
    CROSSHAIR._y = -100;
    CROSSHAIR._visible = false;
    Selection.setFocus(null);
} // End of the function
function loadWidget(target_mc, file_path, load_message)
{
    loadFile(target_mc, file_path, load_message, closeWidget);
} // End of the function
function showWidget(mc, closeFunction)
{
    mc._visible = true;
    mc.swapDepths(99);
    mc.gotoAndStop(1);
    if (mc.load_mc != undefined)
    {
        var _loc3 = mc.load_mc;
    }
    else
    {
        _loc3 = mc.art_mc;
    } // end else if
    _loc3.close_btn.onRelease = function ()
    {
        closeFunction();
        closeWidget(this._parent._parent);
    };
    _loc3.background_mc.onPress = function ()
    {
        this._parent._parent.swapDepths(99);
        this._parent._parent.startDrag();
    };
    _loc3.background_mc.onRelease = function ()
    {
        this._parent._parent.stopDrag();
    };
    _loc3.background_mc.useHandCursor = false;
    setWidgetsActive(true);
} // End of the function
function centerWidget(mc)
{
    mc._x = Math.floor(Stage.width / 2 - mc._width / 2);
    mc._y = Math.floor(Stage.height / 2 - mc._height / 2) - 40;
    if (mc._y < 0)
    {
        mc._y = Math.floor(Stage.height / 2 - mc._height / 2);
    } // end if
} // End of the function
function closeWidget(mc)
{
    if (mc.load_mc != undefined)
    {
        mc.load_mc.removeMovieClip();
    } // end if
    setWidgetsActive(false);
    mc.gotoAndStop(2);
} // End of the function
function closeAllWidgets()
{
    for (var _loc1 in WIDGETS)
    {
        closeWidget(WIDGETS[_loc1]);
    } // end of for...in
} // End of the function
function getWidgetsActive()
{
    return (widgetActive);
} // End of the function
function setWidgetsActive(bool)
{
    widgetActive = bool;
} // End of the function
function startQuickKeys()
{
    if (!is_quick_keys_active)
    {
        myKeyListener = {};
        myKeyListener.is_emote = false;
        myKeyListener.onKeyDown = function ()
        {
            var _loc1 = Key.getCode();
            var _loc2 = DOCK.chat_mc.chat_input;
            if (Selection.getFocus() != null)
            {
                if (_loc1 == 13)
                {
                    var _loc3 = _loc2.text;
                    if (_loc3 != "")
                    {
                        sendMessage(_loc2.text);
                        _loc2.text = "";
                    }
                    else
                    {
                        Selection.setFocus(null);
                        processQuickKeyCode(_loc1);
                    } // end if
                } // end else if
            }
            else if (_loc1 == 13)
            {
                Selection.setFocus(_loc2);
                myKeyListener.is_emote = false;
            }
            else if (myKeyListener.is_emote)
            {
                processEmoteKeyCode(_loc1);
                myKeyListener.is_emote = false;
            }
            else
            {
                processQuickKeyCode(_loc1);
            } // end else if
        };
        Key.removeListener(myKeyListener);
        Key.addListener(myKeyListener);
        is_quick_keys_active = true;
    } // end if
} // End of the function
function processEmoteKeyCode(keyCode)
{
    switch (keyCode)
    {
        case 49:
        {
            sendEmote(1);
            break;
        } 
        case 50:
        {
            sendEmote(2);
            break;
        } 
        case 51:
        {
            sendEmote(3);
            break;
        } 
        case 52:
        {
            sendEmote(4);
            break;
        } 
        case 53:
        {
            sendEmote(5);
            break;
        } 
        case 54:
        {
            sendEmote(6);
            break;
        } 
        case 55:
        {
            sendEmote(7);
            break;
        } 
        case 56:
        {
            sendEmote(8);
            break;
        } 
        case 57:
        {
            sendEmote(9);
            break;
        } 
        case 48:
        {
            sendEmote(10);
            break;
        } 
        case 71:
        {
            sendEmote(18);
            break;
        } 
        case 76:
        {
            sendEmote(17);
            break;
        } 
        case 72:
        {
            sendEmote(30);
            break;
        } 
        case 67:
        {
            sendEmote(13);
            break;
        } 
        case 70:
        {
            sendEmote(16);
            break;
        } 
        case 68:
        {
            sendEmote(22);
            break;
        } 
        case 78:
        {
            sendEmote(23);
            break;
        } 
        case 84:
        {
            sendEmote(19);
            break;
        } 
        case 77:
        {
            sendEmote(20);
            break;
        } 
        case 80:
        {
            sendEmote(21);
            break;
        } 
        case 90:
        {
            sendEmote(24);
            break;
        } 
        case 73:
        {
            sendEmote(25);
            break;
        } 
        case 66:
        {
            sendEmote(12);
            break;
        } 
        case 75:
        {
            sendEmote(28);
            break;
        } 
        case 79:
        {
            sendEmote(29);
            break;
        } 
        case 81:
        {
            sendEmote(26);
            break;
        } 
        case 87:
        {
            sendEmote(27);
            break;
        } 
        case 85:
        {
            sendEmote(11);
            break;
        } 
        case 74:
        {
            sendEmote(34);
            break;
        } 
        case 82:
        {
            sendEmote(47);
            break;
        } 
        case 86:
        {
            sendEmote(62);
            break;
        } 
        case 65:
        {
            sendEmote(63);
            break;
        } 
    } // End of switch
} // End of the function
function processQuickKeyCode(keyCode)
{
    var _loc4 = this.interface_mc.crosshair_mc.target_btn;
    var _loc2 = String(Selection.getFocus());
    var _loc3 = String(_loc4);
    if (Selection.getFocus() != null && _loc2 != _loc3)
    {
        return;
    } // end if
    switch (keyCode)
    {
        case 69:
        {
            myKeyListener.is_emote = true;
            break;
        } 
        case 49:
        {
            sendEmote(15);
            break;
        } 
        case 191:
        {
            sendEmote(14);
            break;
        } 
        case 87:
        {
            sendPlayerAction(25);
            break;
        } 
        case 68:
        {
            sendPlayerFrame(26);
            break;
        } 
        case 74:
        {
            sendJoke();
            break;
        } 
        case 77:
        {
            if (lastMoonWalk > new Date().getTime())
            {
                return (false);
            } // end if
            lastMoonWalk = new Date().getTime() + 1000;
            ENGINE.sendPlayerWaddler();
            break;
        } 
        case 83:
        {
            sendPlayerSitDown();
            break;
        } 
        case 37:
        {
            sendPlayerFrame(19);
            break;
        } 
        case 39:
        {
            sendPlayerFrame(23);
            break;
        } 
        case 38:
        {
            sendPlayerFrame(21);
            break;
        } 
        case 40:
        {
            sendPlayerFrame(17);
            break;
        } 
        case 84:
        {
            showCrosshair();
            break;
        } 
        case 72:
        {
            sendSafeMessage(1);
            break;
        } 
        case 66:
        {
            sendSafeMessage(2);
            break;
        } 
        case 89:
        {
            sendSafeMessage(20);
            break;
        } 
        case 78:
        {
            sendSafeMessage(21);
            break;
        } 
        case 79:
        {
            sendSafeMessage(22);
            break;
        } 
        case 187:
        {
            toggleHighQuality ();
            break;
        } 
        case 189:
        {
            toggleHighQuality ();
            break;
        } 
    } // End of switch
} // End of the function
function stopQuickKeys()
{
    Key.removeListener(myKeyListener);
    is_quick_keys_active = false;
} // End of the function
function showContent(name, initFunction, filePath, data)
{
    stopQuickKeys();
    var _loc4 = getLocalizedString(name);
    if (name == "reg_manager")
    {
        _loc4 = "Oasis Manager";
        filePath = _global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + "/play/Oasis/manager.swf";
    } // end if
    if (filePath == undefined)
    {
        filePath = getFilePath(name);
        if (filePath == undefined)
        {
            shell.sendOpenAS3Module(name, data);
            return;
        } // end if
    } // end if
    loadFile(CONTENT, filePath, _loc4, closeContent, initFunction);
    shell.trackContent(name);
} // End of the function
function loadTourForm()
{
    CONTENT.load_mc.removeMovieClip();
    CONTENT.gotoAndStop(1);
    showContent(TOUR_FORM);
} // End of the function
function closeContent(biString)
{
    if (is_news_open)
    {
        is_news_open = false;
        ENGINE.sendCloseBook(biString);
    } // end if
    CONTENT.load_mc.removeMovieClip();
    CONTENT.gotoAndStop(1);
    startQuickKeys();
} // End of the function
function showWindow(name, initFunction, trackingName)
{
    stopQuickKeys();
    if (name == "News Form")
    {
        name = "news_form";
    } // end if
    var _loc4 = getLocalizedString(name);
    var _loc1 = getFilePath(name);
    var _loc5 = _loc1.substr(_loc1.length - 4, 4);
    if (_loc5 == ".swf")
    {
        loadFile(WINDOW, _loc1, _loc4, closeWindow, initFunction);
    }
    else
    {
        var _loc3 = new Object();
        _loc3.currentPaperPath = _loc1;
        showContent("current_AS3_news", null, undefined, _loc3);
    } // end else if
    shell.trackContent(trackingName || name);
} // End of the function
function showEmptyWindow()
{
    WINDOW.gotoAndStop("Done");
    WINDOW.block_mc.useHandCursor = false;
    WINDOW.block_mc.tabEnabled = false;
    WINDOW.block_mc.onRelease = null;
} // End of the function
function closeWindow()
{
    WINDOW.load_mc.removeMovieClip();
    WINDOW.gotoAndStop(1);
    startQuickKeys();
} // End of the function
function showMembershipRemaining()
{
    if (membership_window_requested)
    {
        return;
    } // end if
    var _loc2 = shell.getMembershipDaysRemaining();
    if (_loc2 == -1)
    {
        return;
    } // end if
    var _loc1 = getMembershipWindowType(_loc2);
    if (_loc1 != undefined)
    {
        if (_loc1 == 0)
        {
            showContent("login_membership_expired");
        }
        else
        {
            showContent("login_membership_" + _loc1.toString());
        } // end if
    } // end else if
    membership_window_requested = true;
} // End of the function
function getMembershipWindowType(days)
{
    if (days == undefined || days < 0)
    {
        return;
    } // end if
    if (days == 0)
    {
        return (0);
    } // end if
    if (days == 1)
    {
        return (1);
    } // end if
    if (days == 2)
    {
        return (2);
    } // end if
    if (days == 3)
    {
        return (3);
    } // end if
    if (days <= 7)
    {
        return (7);
    } // end if
    if (days <= 14)
    {
        return (14);
    } // end if
    return;
} // End of the function
function handleNewRequest(obj)
{
    if (obj.type == 1 || obj.type == "marriage")
    {
        RELATIONSHIP_ICON.gotoAndStop(1);
        RELATIONSHIP_ICON._visible = true;
        bounceIcon(RELATIONSHIP_ICON);
        RELATIONSHIP_ICON.onRelease = function ()
        {
            showPrompt("question", shell.REL.requestName + " has requested you to be marry them. Accept?", "", shell.acceptRelationshipRequest);
            RELATIONSHIP_ICON._visible = false;
        };
        return (true);
    } // end if
    if (obj.type == 2 || obj.type == "bff")
    {
        RELATIONSHIP_ICON.gotoAndStop(2);
        RELATIONSHIP_ICON._visible = true;
        bounceIcon(RELATIONSHIP_ICON);
        RELATIONSHIP_ICON.onRelease = function ()
        {
            showPrompt("question", shell.REL.requestName + " has requested you to be their BFF. Accept?", "", shell.acceptRelationshipRequest);
            RELATIONSHIP_ICON._visible = false;
        };
        return (true);
    } // end if
    RELATIONSHIP_ICON._visible = false;
} // End of the function
function showTutorialPrompt()
{
    if (!prompt_requested)
    {
        if (shell.getMinutesPlayed() == 0)
        {
            showContent("tutorial_prompts");
        } // end if
        prompt_requested = true;
    } // end if
} // End of the function
function showHint(mc, hint)
{
    var _loc2 = {x: mc._x, y: mc._y};
    mc._parent.localToGlobal(_loc2);
    HINT._x = _loc2.x;
    HINT._y = _loc2.y - 28;
    HINT.gotoAndStop(1);
    HINT._visible = true;
    if (hint == "marry_hint")
    {
        hint = "Marry User";
    }
    else if (hint == "bff_hint")
    {
        hint = "BFF User";
    }
    else if (hint == "save_outfit")
    {
        hint = "Save Outfit";
    }
    else if (hint == "send_pm")
    {
        hint = "Send Private Message";
    }
    else
    {
        hint = getLocalizedString(hint);
    } // end else if
    HINT.message_txt.text = hint;
    var message_width = HINT.message_txt.textWidth;
    HINT.message_txt._visible = false;
    HINT.box_mc._visible = false;
    var frame = 1;
    HINT.onEnterFrame = function ()
    {
        if (frame == 4)
        {
            HINT.box_mc._visible = true;
            HINT.box_mc._width = 66;
            HINT.box_mc._height = 16;
        }
        else if (frame == 5)
        {
            HINT.box_mc._width = 81;
            HINT.box_mc._height = 20;
        }
        else if (frame == 6)
        {
            HINT.box_mc._width = 96;
            HINT.box_mc._height = 24;
        }
        else if (frame > 6)
        {
            if (message_width > 72)
            {
                HINT.box_mc._width = message_width + 16;
            }
            else
            {
                HINT.box_mc._width = 88;
            } // end else if
            HINT.box_mc._height = 22;
            HINT.message_txt._visible = true;
            delete HINT.onEnterFrame;
        } // end else if
        ++frame;
    };
} // End of the function
function closeHint()
{
    delete HINT.onEnterFrame;
    HINT.gotoAndStop(2);
    HINT._visible = false;
} // End of the function
function showDock()
{
    var _loc2 = "nonmember";
    if (isMember())
    {
        _loc2 = "member";
    } // end if
    if (isSafeMode() || shell.isWorldSafe())
    {
        DOCK.chat_mc.gotoAndStop(2);
        DOCK.chat_mc._visible = false;
    }
    else
    {
        DOCK.chat_mc.chat_input.tabIndex = 1;
        DOCK.chat_mc.chat_input.onSetFocus = function ()
        {
            is_chat_focused = true;
        };
        DOCK.chat_mc.chat_input.onKillFocus = function ()
        {
            is_chat_focused = false;
        };
        DOCK.chat_mc.chat_input.restrict = "a-z A-Z z-A 0-9 !-} ?!.,;:`´-_/\\(){}=&$§\"=€@\'*+-ßäöüÄÖÜ#?<>\n\t";
        DOCK.chat_mc.send_btn.onRelease = function ()
        {
            var _loc1 = DOCK.chat_mc.chat_input;
            sendMessage(_loc1.text);
            _loc1.text = "";
            closeHint();
        };
        DOCK.chat_mc.send_btn.onRollOver = function ()
        {
            showHint(this, "send_hint");
        };
        DOCK.chat_mc.send_btn.onRollOut = closeHint;
    } // end else if
    DOCK.safe_btn.onRelease = function ()
    {
        showSafeMenu();
        closeHint();
    };
    DOCK.safe_btn.onRollOver = function ()
    {
        showHint(this, "safe_hint");
    };
    DOCK.safe_btn.onRollOut = closeHint;
    DOCK.emote_btn.onRelease = function ()
    {
        showEmoteMenu();
        closeHint();
    };
    DOCK.emote_btn.onRollOver = function ()
    {
        showHint(this, "emote_hint");
    };
    DOCK.emote_btn.onRollOut = closeHint;
    DOCK.action_btn.onRelease = function ()
    {
        showActionMenu();
        closeHint();
    };
    DOCK.action_btn.onRollOver = function ()
    {
        showHint(this, "action_hint");
    };
    DOCK.action_btn.onRollOut = closeHint;
    DOCK.throw_btn.onRelease = function ()
    {
        showCrosshair();
        closeHint();
    };
    DOCK.throw_btn.onRollOver = function ()
    {
        showHint(this, "throw_hint");
    };
    DOCK.throw_btn.onRollOut = closeHint;
    DOCK.player_btn.onRelease = function ()
    {
        showPlayerWidget(getPlayerId(), getPlayerNickname());
        closeHint();
    };
    DOCK.player_btn.onRollOver = function ()
    {
        showHint(this, "player_hint");
    };
    DOCK.player_btn.onRollOut = closeHint;
    DOCK_PLAYER_ICON.gotoAndStop(_loc2);
    DOCK.buddy_btn.onRelease = function ()
    {
        showBuddyWidget();
        closeHint();
    };
    DOCK.buddy_btn.onRollOver = function ()
    {
        showHint(this, "buddy_hint");
    };
    DOCK.buddy_btn.onRollOut = closeHint;
    DOCK.home_btn.onRelease = function ()
    {
        sendJoinPlayerIgloo(getPlayerId());
        closeHint();
    };
    DOCK.home_btn.onRollOver = function ()
    {
        showHint(this, "home_hint");
    };
    DOCK.home_btn.onRollOut = closeHint;
    DOCK.help_btn.onRelease = function ()
    {
        showContent("help");
        closeHint();
    };
    DOCK.help_btn.onRollOver = function ()
    {
        showHint(this, "help_hint");
    };
    DOCK.help_btn.onRollOut = closeHint;
    DOCK._visible = true;
    DOCK.buddy_online_mc._visible = false;
    DOCK.buddy_online_mc.gotoAndStop("park");
    if (DOCK.onMouseDown == undefined)
    {
        DOCK.onMouseDown = function ()
        {
            if (Selection.getFocus() != null)
            {
                Selection.setFocus(null);
            } // end if
        };
    } // end if
} // End of the function
function handleBuddyOnline(event)
{
    var _loc2 = event.nickname;
    var _loc1 = DOCK.buddy_online_mc;
    if (isValidString(_loc2))
    {
        var _loc3 = replaceString("%name%", _loc2, getLocalizedString("buddy_online"));
        if (_loc3.length > 18)
        {
            _loc1.gotoAndStop("long");
        }
        else
        {
            _loc1.gotoAndStop("short");
        } // end else if
        _loc1.message_txt.text = _loc3;
        _loc1._visible = true;
        if (_loc1.start_y == undefined)
        {
            _loc1.start_y = _loc1._y;
        } // end if
        var _loc4 = new mx.transitions.Tween(_loc1, "_y", mx.transitions.easing.Bounce.easeOut, _loc1.start_y + 20, _loc1.start_y, 5, false);
        clearInterval(buddy_online_interval);
        buddy_online_interval = setInterval(closeBuddyOnline, 10000);
    } // end if
} // End of the function
function closeBuddyOnline()
{
    clearInterval(buddy_online_interval);
    delete buddy_online_interval;
    DOCK.buddy_online_mc._visible = false;
    DOCK.buddy_online_mc.gotoAndStop("park");
} // End of the function
function closeDock()
{
    DOCK._visible = false;
} // End of the function
function buyInventory(itemID)
{
    if (isMember() || !isInventoryMemberOnly(itemID))
    {
        if (isItemInInventory(itemID))
        {
            showPrompt("warn", getLocalizedString("item_in_inventory_warn"));
            return;
        } // end if
        var _loc2 = getInventoryObjectById(itemID);
        if (_loc2.is_custom == true)
        {
            var _loc7 = _global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + "/play/v2/content/global/clothing/custom/icons/" + itemID + ".swf";
        }
        else
        {
            _loc7 = getFilePath("clothing_icons") + itemID + ".swf";
        } // end else if
        var _loc6 = getCoins();
        var _loc3;
        if (_loc6 >= _loc2.cost)
        {
            setActiveShopItem(itemID);
            if (_loc2.is_medal)
            {
                _loc3 = replaceString("%name%", _loc2.name, getLocalizedString("inventory_medal"));
            }
            else if (_loc2.is_gift)
            {
                _loc3 = replaceString("%name%", _loc2.name, getLocalizedString("inventory_gift"));
            }
            else if (_loc2.cost == 0)
            {
                _loc3 = replaceString("%name%", _loc2.name, getLocalizedString("inventory_free"));
            }
            else
            {
                var _loc5 = replaceString("%name%", _loc2.name, getLocalizedString("buy_inventory"));
                _loc5 = replaceString("%cost%", String(_loc2.cost), _loc5);
                var _loc8 = replaceString("%num%", String(_loc6), getLocalizedString("num_coins"));
                _loc3 = _loc5 + " " + _loc8;
            } // end else if
            showPrompt("shop", _loc3, _loc7, sendBuyInventory);
        }
        else
        {
            _loc3 = getLocalizedString("low_coin_warn");
            showPrompt("warn", _loc3);
        } // end else if
    }
    else
    {
        showWindow("oops_inventory", null, "oops_clothing_catalog");
    } // end else if
} // End of the function
function buyFurniture(item_id)
{
    if (isMember())
    {
        var _loc8 = shell.getFurnitureObjectById(item_id);
        var _loc5 = _loc8.name;
        var _loc2 = 0;
        var _loc7 = getFilePath("furniture_icons") + item_id + ".swf";
        var _loc4 = getCoins();
        if (_loc4 >= _loc2)
        {
            setActiveShopItem(item_id);
            if (_loc2 > 0)
            {
                var _loc1 = getLocalizedString("buy_furniture");
                var _loc3 = getLocalizedString("num_coins");
                _loc1 = replaceString("%name%", _loc5, _loc1);
                _loc1 = replaceString("%cost%", String(_loc2), _loc1);
                _loc3 = replaceString("%num%", String(_loc4), _loc3);
                var _loc9 = _loc1 + " " + _loc3;
            }
            else
            {
                _loc9 = getLocalizedString("furniture_free");
                _loc9 = replaceString("%name%", _loc5, _loc9);
            } // end else if
            showPrompt("shop", _loc9, _loc7, sendBuyFurniture);
        }
        else
        {
            _loc9 = getLocalizedString("low_coin_warn");
            showPrompt("warn", _loc9);
        } // end else if
    }
    else
    {
        showWindow("oops_furniture", null, "oops_furniture_catalogue");
    } // end else if
} // End of the function
function buyIglooUpgrade(igloo_id)
{
    if (shell.doesPlayerOwnIgloo(igloo_id))
    {
        showPrompt("warn", getLocalizedString("duplicate_igloo_warn"));
    }
    else if (isMember())
    {
        var _loc6 = shell.getIglooCrumbById(igloo_id);
        var _loc5 = _loc6.name;
        var _loc2 = 0;
        var _loc4 = getCoins();
        if (_loc4 >= _loc2)
        {
            setActiveShopItem(igloo_id);
            if (_loc2 > 0)
            {
                var _loc1 = getLocalizedString("buy_igloo_upgrade");
                var _loc3 = getLocalizedString("num_coins");
                _loc1 = replaceString("%name%", _loc5, _loc1);
                _loc1 = replaceString("%cost%", String(_loc2), _loc1);
                _loc3 = replaceString("%num%", String(_loc4), _loc3);
                var _loc7 = _loc1 + " " + _loc3;
            }
            else
            {
                _loc7 = getLocalizedString("igloo_upgrade_free");
                _loc7 = replaceString("%name%", _loc5, _loc7);
            } // end else if
            showPrompt("question", _loc7, file, sendBuyIglooType);
        }
        else
        {
            _loc7 = getLocalizedString("low_coin_warn");
            showPrompt("warn", _loc7);
        } // end else if
    }
    else
    {
        showWindow("oops_igloo", null, "oops_igloo_catalog");
    } // end else if
} // End of the function
function buyIglooFloor(floor_id)
{
    if (shell.getCurrentIglooFloorId() == floor_id)
    {
        showPrompt("warn", getLocalizedString("duplicate_floor_warn"));
    }
    else if (isMember())
    {
        var _loc7 = shell.getFloorCrumbById(floor_id);
        var _loc6 = _loc7.name;
        var _loc4 = 0;
        var _loc3 = getCoins();
        if (_loc3 >= _loc4)
        {
            setActiveShopItem(floor_id);
            var _loc1 = getLocalizedString("buy_igloo_floor");
            var _loc2 = getLocalizedString("num_coins");
            _loc1 = replaceString("%name%", _loc6, _loc1);
            _loc1 = replaceString("%cost%", String(_loc4), _loc1);
            _loc2 = replaceString("%num%", String(_loc3), _loc2);
            var _loc8 = _loc1 + " " + _loc2;
            showPrompt("question", _loc8, file, sendBuyIglooFloor);
        }
        else
        {
            _loc8 = getLocalizedString("low_coin_warn");
            showPrompt("warn", _loc8);
        } // end else if
    }
    else
    {
        showWindow("oops_igloo", null, "oops_igloo_catalog");
    } // end else if
} // End of the function
function buyIglooLocation(bg_id)
{
    showPrompt("warn", "Igloo locations are currently not available.");
} // End of the function
function adoptPuffle(type_id)
{
    var _loc5 = getFilePath("puffle" + type_id + "_icon");
    var _loc2 = getCoins();
    var _loc3 = shell.getMyPuffleCount();
    var _loc4 = getInventoryObjectById(type_id + 750);
    if (!isMember() && _loc4.is_member)
    {
        showWindow("oops_puffle", null, "oops_puffle_catalog");
    }
    else if (!isMember() && _loc3 >= 2)
    {
        showWindow("oops_puffle", null, "oops_puffle_catalog");
    }
    else if (_loc3 >= shell.MAX_PUFFLES)
    {
        var _loc7 = getLocalizedString("max_puffles_prompt");
        showPrompt("warn", _loc7);
    }
    else if (_loc2 >= 0)
    {
        setActiveShopItem(type_id);
        var _loc6 = getLocalizedString("adopt_puffle");
        var _loc1 = getLocalizedString("num_coins");
        _loc1 = replaceString("%num%", _loc2, _loc1);
        _loc7 = _loc6 + " " + _loc1;
        showPrompt("shop", _loc7, _loc5, adoptPuffleName);
    }
    else
    {
        _loc7 = getLocalizedString("low_coin_warn");
        showPrompt("warn", _loc7);
    } // end else if
} // End of the function
function adoptPuffleName()
{
    var _loc2 = getActiveShopItem();
    var _loc3 = getFilePath("puffle" + _loc2 + "_icon");
    var _loc1 = getLocalizedString("name_puffle");
    showPrompt("input", _loc1, _loc3, sendAdoptPuffle);
} // End of the function
function buyPuffleFood()
{
    var _loc2 = getFilePath("puffle_food");
    var _loc1 = getCoins();
    if (_loc1 >= 10)
    {
        var _loc3 = getPufflePromptMessage("buy_puffle_food");
        showPrompt("shop", _loc3, _loc2, sendPuffleFood);
    }
    else
    {
        _loc3 = getLocalizedString("low_coin_warn");
        showPrompt("warn", _loc3);
    } // end else if
} // End of the function
function buyPuffleBath()
{
    var _loc2 = getFilePath("puffle_bath");
    var _loc1 = getCoins();
    if (_loc1 >= 5)
    {
        var _loc3 = getPufflePromptMessage("buy_puffle_bath");
        showPrompt("shop", _loc3, _loc2, sendPuffleBath);
    }
    else
    {
        _loc3 = getLocalizedString("low_coin_warn");
        showPrompt("warn", _loc3);
    } // end else if
} // End of the function
function buyPuffleGum()
{
    var _loc2 = getFilePath("puffle_gum");
    var _loc1 = getCoins();
    if (_loc1 >= 5)
    {
        var _loc3 = getPufflePromptMessage("buy_puffle_gum");
        showPrompt("shop", _loc3, _loc2, sendPuffleGum);
    }
    else
    {
        _loc3 = getLocalizedString("low_coin_warn");
        showPrompt("warn", _loc3);
    } // end else if
} // End of the function
function buyPuffleCookie()
{
    var _loc2 = getFilePath("puffle_cookie");
    var _loc1 = getCoins();
    if (_loc1 >= 5)
    {
        var _loc3 = getPufflePromptMessage("buy_puffle_cookie");
        showPrompt("shop", _loc3, _loc2, sendPuffleCookie);
    }
    else
    {
        _loc3 = getLocalizedString("low_coin_warn");
        showPrompt("warn", _loc3);
    } // end else if
} // End of the function
function getPufflePromptMessage(message)
{
    var _loc2 = getCoins();
    var _loc3 = getLocalizedString(message);
    var _loc1 = getLocalizedString("num_coins");
    _loc1 = replaceString("%num%", _loc2, _loc1);
    return (_loc3 + " " + _loc1);
} // End of the function
function setActiveShopItem(item_id)
{
    active_shop_item = item_id;
} // End of the function
function getActiveShopItem()
{
    return (active_shop_item);
} // End of the function
function setActivePuffleAction(action)
{
    active_puffle_action = action;
} // End of the function
function getActivePuffleAction()
{
    return (active_puffle_action);
} // End of the function
function showPrompt(style, message, file, positiveSelectionCallback, negativeSelectionCallback)
{
    var _loc2 = com.clubpenguin.util.URLUtils.getCacheResetURL(file);
    enableTabLock();
    stopQuickKeys();
    if (style == "question")
    {
        PROMPT.gotoAndStop(2);
    }
    else if (style == "ok")
    {
        PROMPT.gotoAndStop(4);
    }
    else if (style == "ok_big")
    {
        PROMPT.gotoAndStop(11);
    }
    else if (style == "wait")
    {
        PROMPT.gotoAndStop(5);
    }
    else if (style == "game")
    {
        PROMPT.gotoAndStop(3);
    }
    else if (style == "igloo")
    {
        PROMPT.gotoAndStop(6);
        PROMPT.icon_mc.loadMovie(_loc2);
    }
    else if (style == "shop")
    {
        PROMPT.gotoAndStop(7);
        PROMPT.icon_mc.loadMovie(_loc2);
    }
    else if (style == "coin")
    {
        PROMPT.gotoAndStop(8);
    }
    else if (style == "input")
    {
        PROMPT.gotoAndStop(9);
        PROMPT.icon_mc.loadMovie(_loc2);
        PROMPT.text_input.restrict = getLocalizedString("chat_restrict");
        Selection.setFocus(PROMPT.text_input);
    }
    else if (style == "small_input")
    {
        PROMPT.gotoAndStop(11);
        PROMPT.text_input.restrict = getLocalizedString("chat_restrict");
        Selection.setFocus(PROMPT.text_input);
    }
    else if (style == "warn")
    {
        PROMPT.gotoAndStop(10);
    }
    else if (style == "AS3_error")
    {
        PROMPT.gotoAndStop(11);
    }
    else
    {
        PROMPT.gotoAndStop(1);
    } // end else if
    PROMPT.block_mc.useHandCursor = false;
    PROMPT.block_mc.tabEnabled = false;
    PROMPT.block_mc.onRelease = null;
    PROMPT.message_txt.text = message;
    PROMPT.continue_txt.text = getLocalizedString("Continue");
    PROMPT.yes_txt.text = getLocalizedString("Yes");
    PROMPT.no_txt.text = getLocalizedString("No");
    PROMPT.ok_txt.text = getLocalizedString("Ok");
    PROMPT.yes_btn.onRelease = function ()
    {
        closePrompt();
        positiveSelectionCallback();
        removeTabLock();
    };
    PROMPT.ok_btn.onRelease = function ()
    {
        closePrompt();
        positiveSelectionCallback();
        removeTabLock();
    };
    PROMPT.continue_btn.onRelease = function ()
    {
        var _loc1 = PROMPT.text_input.text;
        if (_loc1.length > 0)
        {
            closePrompt();
            positiveSelectionCallback(_loc1, getActivePlayerId());
        } // end if
        removeTabLock();
    };
    PROMPT.no_btn.onRelease = function ()
    {
        closePrompt();
        negativeSelectionCallback();
        removeTabLock();
    };
    PROMPT.close_btn.onRelease = function ()
    {
        closePrompt();
        negativeSelectionCallback();
        removeTabLock();
    };
} // End of the function
function enableTabLock()
{
    MovieClip.prototype.tabEnabled = false;
    Button.prototype.tabEnabled = false;
    Selection.setFocus(null);
} // End of the function
function removeTabLock()
{
    delete MovieClip.prototype.tabEnabled;
    delete Button.prototype.tabEnabled;
} // End of the function
function showScopedPrompt(style, message, file, sendFunction, scope)
{
    var _loc2 = com.clubpenguin.util.URLUtils.getCacheResetURL(file);
    enableTabLock();
    stopQuickKeys();
    if (style == "question")
    {
        PROMPT.gotoAndStop(2);
    }
    else if (style == "ok")
    {
        PROMPT.gotoAndStop(4);
    }
    else if (style == "wait")
    {
        PROMPT.gotoAndStop(5);
    }
    else if (style == "game")
    {
        PROMPT.gotoAndStop(3);
    }
    else if (style == "igloo")
    {
        PROMPT.gotoAndStop(6);
        PROMPT.icon_mc.loadMovie(_loc2);
    }
    else if (style == "shop")
    {
        PROMPT.gotoAndStop(7);
        PROMPT.icon_mc.loadMovie(_loc2);
    }
    else if (style == "coin")
    {
        PROMPT.gotoAndStop(8);
    }
    else if (style == "input")
    {
        PROMPT.gotoAndStop(9);
        PROMPT.icon_mc.loadMovie(_loc2);
        PROMPT.text_input.restrict = getLocalizedString("chat_restrict");
        Selection.setFocus(PROMPT.text_input);
    }
    else if (style == "warn")
    {
        PROMPT.gotoAndStop(10);
    }
    else
    {
        PROMPT.gotoAndStop(1);
    } // end else if
    PROMPT.block_mc.useHandCursor = false;
    PROMPT.block_mc.tabEnabled = false;
    PROMPT.block_mc.onRelease = null;
    PROMPT.message_txt.text = message;
    PROMPT.continue_txt.text = getLocalizedString("Continue");
    PROMPT.yes_txt.text = getLocalizedString("Yes");
    PROMPT.no_txt.text = getLocalizedString("No");
    PROMPT.ok_txt.text = getLocalizedString("Ok");
    PROMPT.yes_btn.onRelease = function ()
    {
        closePrompt();
        sendFunction.call(scope);
        removeTabLock();
    };
    PROMPT.ok_btn.onRelease = function ()
    {
        closePrompt();
        sendFunction.call(scope);
        removeTabLock();
    };
    PROMPT.continue_btn.onRelease = function ()
    {
        var _loc1 = PROMPT.text_input.text;
        if (_loc1.length > 0)
        {
            closePrompt();
            sendFunction.call(scope, _loc1);
        } // end if
        removeTabLock();
    };
    PROMPT.no_btn.onRelease = function ()
    {
        closePrompt.call(scope);
        removeTabLock();
    };
    PROMPT.close_btn.onRelease = function ()
    {
        closePrompt.call(scope);
        removeTabLock();
    };
} // End of the function
function showGamePrompt(name)
{
    setActiveGamePrompt(name);
    showPrompt(question);
} // End of the function
function clickGamePrompt()
{
    sendJoinGame(getActiveGamePrompt());
} // End of the function
function setActiveGamePrompt(name)
{
    active_game_prompt = name;
} // End of the function
function getActiveGamePrompt()
{
    return (active_game_prompt);
} // End of the function
function showEndGameScreen(objParams, promptClosedCallback, room_id, doJoinRoomFirst)
{
    objParams.gameRoomId = SHELL.getCurrentRoomId();
    if (doJoinRoomFirst)
    {
        onRoomInitiatedFunc = com.clubpenguin.util.Delegate.create(this, initEndGameScreen, objParams, promptClosedCallback, null);
        SHELL.addListener(SHELL.ROOM_INITIATED, onRoomInitiatedFunc);
        endGameClosedFunction = com.clubpenguin.util.Delegate.create(this, onEndGameClosed);
        ENGINE.setGameOverRoom(room_id);
        ENGINE.sendJoinGameOverRoom();
    }
    else
    {
        endGameClosedFunction = com.clubpenguin.util.Delegate.create(this, onEndGameClosedJoinRoom);
        initEndGameScreen(null, objParams, promptClosedCallback, room_id);
    } // end else if
} // End of the function
function initEndGameScreen(objEvent, objParams, promptClosedCallback, room_id)
{
    PROMPT.gotoAndStop(1);
    enableTabLock();
    stopQuickKeys();
    if (onRoomInitiatedFunc != null)
    {
        SHELL.removeListener(SHELL.ROOM_INITIATED, onRoomInitiatedFunc);
    } // end if
    if (endGameView == undefined)
    {
        ENGINE.setGameOverRoom(room_id);
        endGameSendFunction = promptClosedCallback;
        var _loc2 = new com.clubpenguin.endgame.model.EndGameParams();
        _loc2.totalCoins = objParams.total;
        _loc2.earnedCoins = objParams.earned;
        _loc2.numTotalStamps = objParams.numberOfGameStamps;
        _loc2.numCompletedStamps = objParams.totalNumberOfGameStampsEarned;
        _loc2.newStamps = objParams.stampIds;
        _loc2.isTable = objParams.is_table;
        _loc2.activeTable = objParams.activeTable;
        _loc2.gameRoomId = objParams.gameRoomId;
        var _loc5 = new com.clubpenguin.endgame.model.EndGameModel(this.SHELL, _loc2);
        var _loc4;
        if (objParams.isCardJitsu)
        {
            _loc4 = com.clubpenguin.endgame.view.CardJitsuEndGameView.LINKAGE_ID;
        }
        else
        {
            _loc4 = com.clubpenguin.endgame.view.CoinEndGameView.LINKAGE_ID;
        } // end else if
        endGameView = (com.clubpenguin.endgame.view.BaseEndGameView)(interface_mc.attachMovie(_loc4, "end_game_mc", interface_mc.getNextHighestDepth()));
        var _loc6 = new com.clubpenguin.endgame.mediator.EndGameMediator(endGameView, _loc5);
        _loc6.__get__endGameClosed().addOnce(endGameClosedFunction, this);
    } // end if
} // End of the function
function showScopedGameOverPrompt(total, earned, sendFunction, scope)
{
    var _loc2 = {total: total, earned: earned, numberOfGameStamps: 0, totalNumberOfGameStampsEarned: 0, stampIds: [], is_table: true, activeTable: ENGINE.getActiveTable()};
    endGameClosedFunction = com.clubpenguin.util.Delegate.create(this, onEndGameClosed);
    initEndGameScreen(null, _loc2, com.clubpenguin.util.Delegate.create(scope, sendFunction), null);
} // End of the function
function onEndGameClosedJoinRoom()
{
    startQuickKeys();
    endGameSendFunction();
    ENGINE.sendJoinGameOverRoom();
    removeTabLock();
    endGameView.removeMovieClip();
    endGameView = undefined;
    endGameSendFunction = undefined;
} // End of the function
function onEndGameClosed()
{
    startQuickKeys();
    endGameSendFunction();
    removeTabLock();
    endGameView.removeMovieClip();
    endGameView = undefined;
    endGameSendFunction = undefined;
} // End of the function
function closePrompt()
{
    PROMPT.gotoAndStop(1);
    startQuickKeys();
} // End of the function
function createBalloonByPlayerId(playerID, depth)
{
    BALLOONS.createMC(playerID, depth);
} // End of the function
function removeBalloonByPlayerId(playerID)
{
    BALLOONS.removeMC(playerID);
} // End of the function
function showBalloon(playerID, message, _isNormal)
{
    BALLOONS.showTextBalloon(playerID, message);
    if (SHELL.isLag != true)
    {
        var _loc1 = getPlayerObject(playerID);
        if (_loc1.player_attributes.b[0] != "0" && _loc1.player_attributes.b[0] != undefined && _loc1.player_attributes.b[0] != "")
        {
            _loc2 = new Color(BALLOONS["p" + playerID].balloon_mc);
            _loc2.setRGB("0x" + _loc1.player_attributes.b[0]);
            _loc2 = new Color(BALLOONS["p" + playerID].pointer_mc);
            _loc2.setRGB("0x" + _loc1.player_attributes.b[0]);
        } // end if
        if (_loc1.player_attributes.b[1] != "0" && _loc1.player_attributes.b[1] != undefined && _loc1.player_attributes.b[1] != "")
        {
            BALLOONS["p" + playerID].message_txt.textColor = "0x" + _loc1.player_attributes.b[1];
        } // end if
    } // end if
} // End of the function
function showBannedBalloon(playerID, message)
{
    BALLOONS.showTextBalloon(playerID, message, "BannedBalloon");
} // End of the function
function showEmoteBalloon(playerID, emoteFrame)
{
    BALLOONS.showEmoteBalloon(playerID, emoteFrame);
    if (SHELL.isLag != true)
    {
        var _loc1 = getPlayerObject(playerID);
        if (_loc1.player_attributes.b[0] != "0" && _loc1.player_attributes.b[0] != undefined && _loc1.player_attributes.b[0] != "")
        {
            _loc2 = new Color(BALLOONS["p" + playerID].balloon_mc);
            _loc2.setRGB("0x" + _loc1.player_attributes.b[0]);
            _loc2 = new Color(BALLOONS["p" + playerID].pointer_mc);
            _loc2.setRGB("0x" + _loc1.player_attributes.b[0]);
        } // end if
        if (_loc1.player_attributes.b[1] != "0" && _loc1.player_attributes.b[1] != undefined && _loc1.player_attributes.b[1] != "")
        {
            BALLOONS["p" + playerID].message_txt.textColor = "0x" + _loc1.player_attributes.b[1];
        } // end if
    } // end if
} // End of the function
function resetRoomBalloonManager()
{
    BALLOONS.reset();
} // End of the function
function LEGACY_showWindow(name, ob)
{
    if (name == "Found Item")
    {
        buyInventory(ob.ItemId);
    }
    else if (name == "News Form")
    {
        showWindow("news_form");
    }
    else if (name == "Game Over")
    {
        var _loc3 = ob.score;
        var _loc4 = ob.coins;
    } // end else if
} // End of the function
function dragLog()
{
    LOG.starty = LOG._y;
    LOG.startDrag(false, LOG._x, 6, LOG._x, 420);
} // End of the function
function updateLog()
{
    LOG.stopDrag();
    if (LOG._y == LOG.starty)
    {
        if (LOG._y > 40)
        {
            closeLog();
        }
        else
        {
            openLog();
        } // end else if
    }
    else
    {
        is_log_open = true;
        showLog();
    } // end else if
} // End of the function
function openLog()
{
    is_log_open = true;
    LOG.arrow_mc.gotoAndStop(2);
    LOG._y = 110;
    showLog();
} // End of the function
function closeLog()
{
    is_log_open = false;
    LOG.arrow_mc.gotoAndStop(1);
    LOG._y = 6;
    clearLog();
} // End of the function
function showLog()
{
    if (is_log_open)
    {
        var _loc9 = getLog();
        var _loc6 = LOG.menu_mc;
        clearLog();
        var _loc10 = Math.floor((LOG._y - 30) / 20);
        var _loc7 = _loc9.length - 1;
        var _loc3 = 0;
        var _loc5 = "";
        while (_loc3 < _loc10)
        {
            var _loc2 = _loc9[_loc7];
            _loc6.item_mc.duplicateMovieClip("item" + _loc3, _loc3 + 1);
            var _loc4 = _loc6["item" + _loc3];
            if (_loc2 != undefined)
            {
                if (_loc2.type == shell.SEND_BLOCKED_MESSAGE || _loc2.player_id == 1 || _loc2.player_id == 2)
                {
                    _loc4.gotoAndStop(2);
                }
                else
                {
                    _loc4.gotoAndStop(1);
                } // end else if
                _loc5 = _loc2.message.split(" ");
                if (_loc5.length == 0)
                {
                    if (message.substr(0, 7) == "http://")
                    {
                        message = "<u><a href=\"" + message + "\" target=\"_blank\">" + message + "</a></u>";
                    } // end if
                }
                else
                {
                    for (var _loc8 in _loc5)
                    {
                        if (_loc5[_loc8].substr(0, 7) == "http://")
                        {
                            _loc5[_loc8] = "<u><a href=\"" + _loc5[_loc8] + "\" target=\"_blank\">" + _loc5[_loc8] + "</a></u>";
                        } // end if
                    } // end of for...in
                    message = _loc5.join(" ");
                } // end else if
                if (_loc2.mod_action != undefined)
                {
                    _loc4.message_text.htmlText = "<font color=\'#FF0000\'>SERVER</font>" + message_separator + message + message_separator + _loc2.nickname;
                }
                else
                {
                    _loc4.message_text.htmlText = _loc2.nickname + message_separator + message;
                } // end else if
                nickname = _loc2.nickname;
                _loc4.player_id = _loc2.player_id;
                _loc4.nickname = _loc2.nickname;
                _loc4.message = message;
                _loc4.type = _loc2.type;
            }
            else
            {
                _loc4.message_text.htmlText = "";
            } // end else if
            _loc4._y = -20 * _loc3;
            _loc4.message_btn.onRelease = function ()
            {
                var _loc2 = this._parent.player_id;
                var _loc3 = this._parent.nickname;
                var _loc4 = this._parent.message;
                if (!isClickableLogItem(_loc2))
                {
                    return;
                } // end if
                if (_loc2 != undefined)
                {
                    setActiveReport(_loc2, _loc3, _loc4);
                    showPlayerWidget(_loc2, _loc3);
                } // end if
            };
            if (!isClickableLogItem(_loc2.player_id))
            {
                _loc4.message_btn.onRelease = undefined;
                delete _loc4.message_btn.onRelease;
            } // end if
            --_loc7;
            ++_loc3;
        } // end while
    } // end if
} // End of the function
function isClickableLogItem(player_id)
{
    return (true);
} // End of the function
function clearLog()
{
    var _loc1 = LOG.menu_mc;
    for (var _loc2 in _loc1)
    {
        if (_loc1[_loc2] != "item_mc")
        {
            removeMovieClip (_loc1[_loc2]);
        } // end if
    } // end of for...in
} // End of the function
function setActiveReport(player_id, nickname, message)
{
    active_report = new Object();
    active_report.player_id = player_id;
    active_report.nickname = nickname;
    active_report.message = message;
} // End of the function
function getActiveReport()
{
    return (active_report);
} // End of the function
function getActiveReportMessage()
{
    return (active_report.message);
} // End of the function
function addBuddyRequest(player_id, nickname)
{
    var _loc1 = new Object();
    _loc1.action = "request";
    _loc1.player_id = player_id;
    _loc1.nickname = nickname;
    buddy_request_list.push(_loc1);
    updateBuddyRequestIcon();
} // End of the function
function addBuddyAccepted(player_id, nickname)
{
    var _loc1 = new Object();
    _loc1.action = "accepted";
    _loc1.player_id = player_id;
    _loc1.nickname = nickname;
    buddy_request_list.push(_loc1);
    updateBuddyRequestIcon();
} // End of the function
function updateBuddyRequestIcon()
{
    if (buddy_request_list.length > 0)
    {
        BUDDY_ICON._visible = true;
        BUDDY_ICON.onRelease = showBuddyRequest;
        bounceIcon(BUDDY_ICON);
    }
    else
    {
        BUDDY_ICON._visible = false;
    } // end else if
} // End of the function
function showBuddyRequest()
{
    var _loc1 = buddy_request_list.pop();
    buddy_request_item = _loc1;
    setActiveBuddyRequest(_loc1.player_id);
    if (_loc1.action == "request")
    {
        var _loc2 = getLocalizedString("buddy_question_prompt");
        _loc2 = replaceString("%name%", _loc1.nickname, _loc2);
        showPrompt("question", _loc2, "", sendBuddyAccept);
    }
    else if (_loc1.action == "accepted")
    {
        _loc2 = getLocalizedString("buddy_accepted_prompt");
        _loc2 = replaceString("%name%", _loc1.nickname, _loc2);
        showPrompt("ok", _loc2);
    } // end else if
    updateBuddyRequestIcon();
} // End of the function
function setActiveBuddyRequest(player_id)
{
    active_buddy_request = player_id;
} // End of the function
function getActiveBuddyRequest()
{
    return (active_buddy_request);
} // End of the function
function updateNewMailIcon(t)
{
    PM_ICON.new_mc._visible = true;
    if (t > 999)
    {
        PM_ICON.new_mc.gotoAndStop(2);
        PM_ICON.new_mc.mail_count_txt.text = t;
    }
    else
    {
        PM_ICON.new_mc.gotoAndStop(1);
        PM_ICON.new_mc.mail_count_txt.text = t;
    } // end else if
    if (t < 1)
    {
        PM_ICON.new_mc._visible = false;
    } // end if
    if (t > last_new_total)
    {
        bounceIcon(PM_ICON);
    } // end if
    last_new_total = t;
} // End of the function
function showEmoteMenu()
{
    EMOTE_MENU.gotoAndStop(1);
    EMOTE_MENU.gotoAndStop(2);
    EMOTE_MENU.back_btn.onRelease = closeEmoteMenu;
    EMOTE_MENU.back_btn.onRollOver = closeEmoteMenu;
    EMOTE_MENU.close_btn.onRelease = closeEmoteMenu;
    EMOTE_MENU.back_btn.useHandCursor = false;
    EMOTE_MENU.safe_btn.useHandCursor = false;
    EMOTE_MENU.e1_btn.onRelease = function ()
    {
        clickEmote(1);
    };
    EMOTE_MENU.e2_btn.onRelease = function ()
    {
        clickEmote(2);
    };
    EMOTE_MENU.e3_btn.onRelease = function ()
    {
        clickEmote(3);
    };
    EMOTE_MENU.e4_btn.onRelease = function ()
    {
        clickEmote(4);
    };
    EMOTE_MENU.e5_btn.onRelease = function ()
    {
        clickEmote(5);
    };
    EMOTE_MENU.e6_btn.onRelease = function ()
    {
        clickEmote(6);
    };
    EMOTE_MENU.e7_btn.onRelease = function ()
    {
        clickEmote(7);
    };
    EMOTE_MENU.e8_btn.onRelease = function ()
    {
        clickEmote(8);
    };
    EMOTE_MENU.e9_btn.onRelease = function ()
    {
        clickEmote(9);
    };
    EMOTE_MENU.e10_btn.onRelease = function ()
    {
        clickEmote(10);
    };
    EMOTE_MENU.e11_btn.onRelease = function ()
    {
        clickEmote(11);
    };
    EMOTE_MENU.coffee_btn.onRelease = function ()
    {
        clickEmote(13);
    };
    EMOTE_MENU.game_btn.onRelease = function ()
    {
        clickEmote(18);
    };
    EMOTE_MENU.popcorn_btn.onRelease = function ()
    {
        clickEmote(29);
    };
    EMOTE_MENU.pizza_btn.onRelease = function ()
    {
        clickEmote(24);
    };
    EMOTE_MENU.icecream_btn.onRelease = function ()
    {
        clickEmote(26);
    };
    EMOTE_MENU.luck_btn.onRelease = function ()
    {
        clickEmote(17);
    };
    EMOTE_MENU.flower_btn.onRelease = function ()
    {
        clickEmote(16);
    };
    EMOTE_MENU.cake_btn.onRelease = function ()
    {
        clickEmote(28);
    };
    EMOTE_MENU.heart_btn.onRelease = function ()
    {
        clickEmote(30);
    };
    EMOTE_MENU.idea_btn.onRelease = function ()
    {
        clickEmote(12);
    };
    EMOTE_MENU.cookie_btn.onRelease = function ()
    {
        clickEmote(31);
    };
    EMOTE_MENU.ice_btn.onRelease = function ()
    {
        clickEmote(32);
    };
    EMOTE_MENU.music_btn.onRelease = function ()
    {
        clickEmote(33);
    };
    EMOTE_MENU.oO_button.onRelease = function ()
    {
        clickEmote(35);
    };
    EMOTE_MENU.skull_btn.onRelease = function ()
    {
        clickEmote(36);
    };
    EMOTE_MENU.caveman_btn.onRelease = function ()
    {
        clickEmote(37);
    };
    EMOTE_MENU.cheese_button.onRelease = function ()
    {
        clickEmote(38);
    };
    EMOTE_MENU.cool_button.onRelease = function ()
    {
        clickEmote(39);
    };
    EMOTE_MENU.cut_button.onRelease = function ()
    {
        clickEmote(40);
    };
    EMOTE_MENU.troll_button.onRelease = function ()
    {
        clickEmote(41);
    };
    EMOTE_MENU.furious_button.onRelease = function ()
    {
        clickEmote(42);
    };
    EMOTE_MENU.no__button.onRelease = function ()
    {
        clickEmote(43);
    };
    EMOTE_MENU.rpuff.onRelease = function ()
    {
        clickEmote(44);
    };
    EMOTE_MENU.rainbow_c.onRelease = function ()
    {
        clickEmote(45);
    };
    EMOTE_MENU.oberry.onRelease = function ()
    {
        clickEmote(46);
    };
    EMOTE_MENU.lol_button.onRelease = function ()
    {
        clickEmote(48);
    };
    EMOTE_MENU.buddy_button.onRelease = function ()
    {
        clickEmote(50);
    };
    EMOTE_MENU.moon_emoji.onRelease = function ()
    {
        clickEmote(51);
    };
    EMOTE_MENU.dolphin_emoji.onRelease = function ()
    {
        clickEmote(52);
    };
    EMOTE_MENU.heart_emoji.onRelease = function ()
    {
        clickEmote(53);
    };
    EMOTE_MENU.moon_2_emoji.onRelease = function ()
    {
        clickEmote(54);
    };
    EMOTE_MENU.sun_emoji.onRelease = function ()
    {
        clickEmote(55);
    };
    EMOTE_MENU.x_emoji.onRelease = function ()
    {
        clickEmote(56);
    };
    EMOTE_MENU.lol_emoji.onRelease = function ()
    {
        clickEmote(57);
    };
    EMOTE_MENU.wink_emoji.onRelease = function ()
    {
        clickEmote(58);
    };
    EMOTE_MENU.blush_emoji.onRelease = function ()
    {
        clickEmote(59);
    };
    EMOTE_MENU.smirk_emoji.onRelease = function ()
    {
        clickEmote(60);
    };
    EMOTE_MENU.mad_emoji.onRelease = function ()
    {
        clickEmote(61);
    };
} // End of the function
function clickEmote(n)
{
    sendEmote(n);
    closeEmoteMenu();
} // End of the function
function closeEmoteMenu()
{
    EMOTE_MENU.gotoAndStop(1);
} // End of the function
function showActionMenu()
{
    ACTION_MENU.gotoAndStop(1);
    ACTION_MENU.gotoAndStop(2);
    ACTION_MENU.back_btn.onRelease = closeActionMenu;
    ACTION_MENU.back_btn.onRollOver = closeActionMenu;
    ACTION_MENU.close_btn.onRelease = closeActionMenu;
    ACTION_MENU.back_btn.useHandCursor = false;
    ACTION_MENU.safe_btn.useHandCursor = false;
    ACTION_MENU.dance_btn.onRelease = function ()
    {
        sendPlayerFrame(26);
        closeActionMenu();
    };
    ACTION_MENU.wave_btn.onRelease = function ()
    {
        sendPlayerAction(25);
        closeActionMenu();
    };
    ACTION_MENU.sit1_btn.onRelease = function ()
    {
        sendPlayerFrame(18);
        closeActionMenu();
    };
    ACTION_MENU.sit2_btn.onRelease = function ()
    {
        sendPlayerFrame(20);
        closeActionMenu();
    };
    ACTION_MENU.sit3_btn.onRelease = function ()
    {
        sendPlayerFrame(22);
        closeActionMenu();
    };
    ACTION_MENU.sit4_btn.onRelease = function ()
    {
        sendPlayerFrame(24);
        closeActionMenu();
    };
    var _loc1 = SHELL.getPlayerObjectById(getPlayerId());
    ACTION_MENU.frame_num_txt.text = _loc1.frame;
    if (isNaN(_loc1.frame))
    {
        ACTION_MENU.frame_num_txt.text = "16";
    } // end if
    ACTION_MENU.update_frame.onRelease = function ()
    {
        if (isNaN(ACTION_MENU.frame_num_txt.text))
        {
            return (false);
        } // end if
        if (Number(ACTION_MENU.frame_num_txt.text) > 75)
        {
            return (false);
        } // end if
        if (Number(ACTION_MENU.frame_num_txt.text) < 0)
        {
            return (false);
        } // end if
        sendPlayerAction(ACTION_MENU.frame_num_txt.text);
        closeActionMenu();
    };
} // End of the function
function closeActionMenu()
{
    ACTION_MENU.gotoAndStop(1);
} // End of the function
function showSafeMenu()
{
    var _loc1 = getSafeMessages();
    SAFE_MENU.gotoAndStop(1);
    SAFE_MENU.gotoAndStop(2);
    SAFE_MENU.back_btn.onRelease = closeSafeMenu;
    SAFE_MENU.back_btn.onRollOver = startCloseSafeMenuDelay;
    SAFE_MENU.close_btn.onRelease = closeSafeMenu;
    SAFE_MENU.back_btn.useHandCursor = false;
    SAFE_MENU.safe_btn.useHandCursor = false;
    SAFE_MENU.master_mc._visible = false;
    showMenuList(_loc1, 0, 0, 0);
} // End of the function
function showMenuList(l, c, r, w)
{
    if (w == undefined)
    {
        w = 1;
    } // end if
    var _loc9 = SAFE_MENU.menu_mc;
    var _loc6 = _loc9.master_mc.item_mc._height + 2;
    var _loc13 = _loc9.master_mc.item_mc._width + 2;
    var _loc12 = "menu" + c;
    _loc9.master_mc.duplicateMovieClip(_loc12, 100 + c + 1);
    var _loc4 = _loc9[_loc12];
    _loc4.item_mc._visible = false;
    _loc4.c = c;
    var _loc10 = l.length * _loc6;
    if (c > 0)
    {
        var _loc11 = _loc9["menu" + (c - 1)];
        _loc4._y = _loc11._y + r * _loc6;
        _loc4._x = _loc11._x + _loc11._width + 2;
    }
    else
    {
        _loc4._y = _loc4._y - _loc10 + _loc6;
    } // end else if
    if (_loc4._y + _loc10 > _loc6)
    {
        _loc4._y = _loc4._y - (_loc4._y + _loc10 - _loc6);
    } // end if
    for (i = 0; i < l.length; i++)
    {
        var _loc2 = l[i];
        var _loc3 = "item" + i;
        _loc4.item_mc.duplicateMovieClip(_loc3, i + 1);
        var _loc1 = _loc4[_loc3];
        _loc1._y = _loc6 * i;
        _loc1.c = c;
        _loc1.r = i;
        _loc1.ob = _loc2;
        if (_loc2.menu)
        {
            if (w > 1)
            {
                _loc1.gotoAndStop(4);
            }
            else
            {
                _loc1.gotoAndStop(2);
            } // end else if
        }
        else if (w > 1)
        {
            _loc1.gotoAndStop(3);
        }
        else
        {
            _loc1.gotoAndStop(1);
        } // end else if
        _loc1.large_txt.text = _loc2.name;
        if (_loc1.large_txt.textWidth > _loc1.large_txt._width)
        {
            _loc1.large_txt.text = "";
            _loc1.small_txt.text = _loc2.name;
        } // end if
        _loc1.item_btn.onRollOver = handleMenuItemRollOver;
        _loc1.item_btn.onRelease = handleMenuItemRelease;
    } // end of for
} // End of the function
function closeMenuList(c)
{
    var _loc1 = SAFE_MENU.menu_mc;
    for (var _loc3 in _loc1)
    {
        if (_loc1[_loc3].c > c)
        {
            _loc1[_loc3].removeMovieClip();
        } // end if
    } // end of for...in
} // End of the function
function handleMenuItemRollOver()
{
    var _loc3 = this._parent._parent.c;
    var _loc4 = this._parent.r;
    var _loc2 = this._parent.ob;
    stopCloseSafeMenuDelay();
    closeMenuList(_loc3);
    if (_loc2.menu)
    {
        showMenuList(_loc2.menu, _loc3 + 1, _loc4, _loc2.wide);
    } // end if
} // End of the function
function handleMenuItemRelease()
{
    var _loc2 = this._parent;
    if (_loc2.ob.action == "joke")
    {
        sendJoke();
    }
    else if (_loc2.ob.action == "tour")
    {
        if (!shell.isItemOnMyPlayer(428))
        {
            var _loc3 = getLocalizedString("tour_guide_hat_required");
            showPrompt("warn", _loc3);
        }
        else
        {
            sendTourGuideMessage();
        } // end else if
    }
    else
    {
        sendSafeMessage(_loc2.ob.id);
    } // end else if
    closeSafeMenu();
} // End of the function
function startCloseSafeMenuDelay()
{
    var _loc1 = interface_mc.safe_menu_mc.menu_mc;
    var delay_counter = 12;
    _loc1.onEnterFrame = function ()
    {
        if (delay_counter < 1)
        {
            closeSafeMenu();
        }
        else
        {
            --delay_counter;
        } // end else if
    };
} // End of the function
function stopCloseSafeMenuDelay()
{
    var _loc1 = SAFE_MENU.menu_mc;
    delete _loc1.onEnterFrame;
} // End of the function
function closeSafeMenu()
{
    SAFE_MENU.gotoAndStop(1);
} // End of the function
function showBuddyWidget()
{
    showBuddyList();
    setupBuddyWidget();
} // End of the function
function showBuddyList()
{
    showWidget(BUDDY_WIDGET);
    updateBuddyWidget(0, "buddy");
} // End of the function
function showOnlineList()
{
    showWidget(BUDDY_WIDGET);
    updateBuddyWidget(0, "online");
} // End of the function
function showIgnoreList()
{
    showWidget(BUDDY_WIDGET);
    is_buddy_widget_open = true;
    updateBuddyWidget(0, "ignore");
} // End of the function
function updateBuddyWidget(page_id, list_name)
{
    var _loc4 = BUDDY_WIDGET.art_mc;
    var _loc9 = getPlayerId();
    if (page_id == undefined)
    {
        page_id = _loc4.page_id;
        list_name = _loc4.list_name;
    } // end if
    _loc4.page_id = page_id;
    _loc4.list_name = list_name;
    if (list_name == "buddy")
    {
        var _loc7 = getBuddyList();
        _loc4.title_txt.text = getLocalizedString("buddy_list");
    }
    else if (list_name == "ignore")
    {
        _loc7 = getIgnoreList();
        _loc4.title_txt.text = getLocalizedString("ignore_list");
    }
    else
    {
        _loc7 = getPlayerList();
        _loc4.title_txt.text = getLocalizedString("online_list");
    } // end else if
    var _loc6 = paginateArray(_loc7, page_id, MAX_BUDDIES_PER_PAGE);
    var _loc8 = getMaxPage(_loc7, MAX_BUDDIES_PER_PAGE);
    if (page_id < _loc8)
    {
        _loc4.next_btn.onRelease = function ()
        {
            updateBuddyWidget(page_id + 1, list_name);
        };
    }
    else
    {
        _loc4.next_btn.onRelease = null;
    } // end else if
    if (page_id > 0)
    {
        _loc4.back_btn.onRelease = function ()
        {
            updateBuddyWidget(page_id - 1, list_name);
        };
    }
    else
    {
        _loc4.back_btn.onRelease = null;
    } // end else if
    for (var _loc3 = 0; _loc3 < MAX_BUDDIES_PER_PAGE; ++_loc3)
    {
        var _loc1 = _loc4["item" + _loc3 + "_mc"];
        var _loc2 = _loc6[_loc3];
        if (_loc2 != undefined)
        {
            var _loc5 = getPlayerRelationship(_loc2.player_id, true);
            _loc1.icon_mc.gotoAndStop(1);
            _loc1.icon_mc.gotoAndStop(_loc5);
            _loc1.icon_mc._visible = true;
            _loc1.name_txt.text = _loc2.nickname;
            _loc1.player_id = _loc2.player_id;
            _loc1.nickname = _loc2.nickname;
            if (list_name == "ignore")
            {
                _loc1.item_btn.onRelease = clickIgnoreWidgetItem;
            }
            else
            {
                _loc1.item_btn.onRelease = clickBuddyWidgetItem;
            } // end else if
            continue;
        } // end if
        _loc1.icon_mc.gotoAndStop(1);
        _loc1.icon_mc._visible = false;
        _loc1.name_txt.text = "";
        _loc1.player_id = undefined;
        _loc1.item_btn.onRelease = null;
    } // end of for
    BUDDY_TOTAL_TEXT._visible = false;
    if (list_name == "buddy")
    {
        BUDDY_TOTAL_TEXT.text = _loc7.length + "/100";
        BUDDY_TOTAL_TEXT._visible = true;
    } // end if
} // End of the function
function clickBuddyWidgetItem()
{
    var _loc3 = this._parent.player_id;
    var _loc2 = this._parent.nickname;
    showPlayerWidget(_loc3, _loc2);
} // End of the function
function clickIgnoreWidgetItem()
{
    var _loc5 = this._parent.player_id;
    var _loc3 = this._parent.nickname;
    setActiveIgnore(_loc5);
    var _loc4 = getLocalizedString("ignore_remove_prompt");
    var _loc2 = replaceString("%name%", _loc3, _loc4);
    showPrompt("question", _loc2, "", sendIgnoreRemove);
} // End of the function
function setupBuddyWidget()
{
    var _loc2 = BUDDY_WIDGET.art_mc;
    _loc2.buddy_btn.onRelease = function ()
    {
        showBuddyList();
        closeHint();
    };
    _loc2.buddy_btn.onRollOver = function ()
    {
        showHint(this, "buddy_hint");
    };
    _loc2.buddy_btn.onRollOut = closeHint;
    _loc2.online_btn.onRelease = function ()
    {
        showOnlineList();
        closeHint();
    };
    _loc2.online_btn.onRollOver = function ()
    {
        showHint(this, "online_hint");
    };
    _loc2.online_btn.onRollOut = closeHint;
    _loc2.ignore_btn.onRelease = function ()
    {
        showIgnoreList();
        closeHint();
    };
    _loc2.ignore_btn.onRollOver = function ()
    {
        showHint(this, "ignore_hint");
    };
    _loc2.ignore_btn.onRollOut = closeHint;
} // End of the function
function setActiveIgnore(player_id)
{
    active_ignore = player_id;
} // End of the function
function getActiveIgnore()
{
    return (active_ignore);
} // End of the function
function isBuddyWidgetOpen()
{
    if (BUDDY_WIDGET._currentframe == 1)
    {
        return (true);
    }
    else
    {
        return (false);
    } // end else if
} // End of the function
function showScriptWidget()
{
    showWidget(SCRIPT_WIDGET);
    updateScriptWidget(0);
} // End of the function
function updateScriptWidget(page_id)
{
    var _loc5 = SCRIPT_WIDGET.art_mc;
    var _loc3 = getScript();
    var _loc6 = getMaxPage(_loc3, 4);
    if (page_id > 0)
    {
        _loc5.back_btn._visible = true;
        _loc5.back_btn.onRelease = function ()
        {
            updateScriptWidget(page_id - 1);
        };
    }
    else
    {
        _loc5.back_btn._visible = false;
    } // end else if
    if (page_id < _loc6)
    {
        _loc5.next_btn._visible = true;
        _loc5.next_btn.onRelease = function ()
        {
            updateScriptWidget(page_id + 1);
        };
    }
    else
    {
        _loc5.next_btn._visible = false;
    } // end else if
    if (_loc6 > 0)
    {
        var _loc7 = getLocalizedString("page");
        _loc5.page_txt.text = _loc7 + " " + (page_id + 1) + " / " + (_loc6 + 1);
    } // end if
    var _loc2 = page_id * 4;
    for (var _loc4 = 0; _loc4 < 4; ++_loc4)
    {
        var _loc1 = _loc5["item" + _loc4 + "_mc"];
        if (_loc3[_loc2].note != undefined)
        {
            _loc1._visible = true;
            _loc1.gotoAndStop(2);
            _loc1.message_txt.text = _loc3[_loc2].note;
        }
        else if (_loc3[_loc2].message != undefined)
        {
            _loc1._visible = true;
            _loc1.gotoAndStop(1);
            _loc1.line_id = _loc2;
            _loc1.name_txt.text = _loc3[_loc2].name;
            _loc1.message_txt.text = _loc3[_loc2].message;
            _loc1.send_btn.onRelease = clickScriptLine;
        }
        else
        {
            _loc1._visible = false;
        } // end else if
        ++_loc2;
    } // end of for
} // End of the function
function clickScriptLine()
{
    var _loc2 = this._parent.line_id;
    sendLineMessage(_loc2);
} // End of the function
function showMascotWidget()
{
    showWidget(MASCOT_WIDGET);
    updateMascotWidget(0);
} // End of the function
function updateMascotWidget(page_id)
{
    var _loc5 = MASCOT_WIDGET.art_mc;
    var _loc3 = shell.getMascotMessageArray();
    var _loc6 = getMaxPage(_loc3, 4);
    if (page_id > 0)
    {
        _loc5.back_btn._visible = true;
        _loc5.back_btn.onRelease = function ()
        {
            updateMascotWidget(page_id - 1);
        };
    }
    else
    {
        _loc5.back_btn._visible = false;
    } // end else if
    if (page_id < _loc6)
    {
        _loc5.next_btn._visible = true;
        _loc5.next_btn.onRelease = function ()
        {
            updateMascotWidget(page_id + 1);
        };
    }
    else
    {
        _loc5.next_btn._visible = false;
    } // end else if
    if (_loc6 > 0)
    {
        var _loc7 = getLocalizedString("page");
        _loc5.page_txt.text = _loc7 + " " + (page_id + 1) + " / " + (_loc6 + 1);
    } // end if
    var _loc2 = page_id * 4;
    for (var _loc4 = 0; _loc4 < 4; ++_loc4)
    {
        var _loc1 = _loc5["item" + _loc4 + "_mc"];
        if (_loc3[_loc2].note != undefined)
        {
            _loc1._visible = true;
            _loc1.gotoAndStop(2);
            _loc1.message_txt.text = _loc3[_loc2].note;
        }
        else if (_loc3[_loc2].message != undefined)
        {
            _loc1._visible = true;
            _loc1.gotoAndStop(1);
            _loc1.line_id = _loc2;
            _loc1.name_txt.text = _loc3[_loc2].name;
            _loc1.message_txt.text = _loc3[_loc2].message;
            _loc1.send_btn.onRelease = clickMascotLine;
        }
        else
        {
            _loc1._visible = false;
        } // end else if
        ++_loc2;
    } // end of for
} // End of the function
function clickMascotLine()
{
    var _loc2 = this._parent.line_id;
    sendMascotMessage(_loc2);
} // End of the function
function showGameWidget(game_name)
{
    var _loc6 = shell.getGameCrumbsByName(game_name);
    var _loc5 = _loc6.path;
    if (_loc6 == undefined || _loc5 == undefined)
    {
        shell.$e("Interface -> showGameWidget() -> ERROR", {error_code: shell.LOAD_ERROR, file_path: _loc5});
        return;
    } // end if
    var _loc7 = shell.getLocalizedString(game_name);
    var _loc12 = closeGameWidget;
    var _loc10 = GAME_WIDGET.load_mc.startGame;
    var _loc4 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    var _loc2 = {};
    GAME_WIDGET.load_mc.removeMovieClip();
    GAME_WIDGET.createEmptyMovieClip("load_mc", 1);
    WINDOW.gotoAndStop("Wait");
    WINDOW.close_btn.onRelease = closeWindow;
    WINDOW.progressbar_mc.message_txt.text = _loc7;
    WINDOW.block_mc.useHandCursor = false;
    WINDOW.block_mc.tabEnabled = false;
    WINDOW.block_mc.onRelease = null;
    _loc2.onLoadProgress = function (event)
    {
        target_mc._lockroot = true;
        var _loc1 = Math.floor(event.bytesLoaded / event.bytesTotal * 100);
        WINDOW.progressbar_mc.gotoAndStop(_loc1);
    };
    _loc2.onLoadInit = function (event)
    {
        var _loc1 = event.target;
        _loc1._lockroot = true;
        showWidget(_loc1._parent);
        centerWidget(_loc1._parent);
        closeWindow();
        _loc1.startGame();
    };
    _loc4.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, _loc2.onLoadInit));
    _loc4.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, _loc2.onLoadProgress));
    var _loc8 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc5);
    _loc4.loadClip(_loc8, GAME_WIDGET.load_mc);
} // End of the function
function closeGameWidget(widgetClip)
{
    if (widgetClip != undefined)
    {
        closeWidget(widgetClip);
    }
    else
    {
        closeWidget(GAME_WIDGET);
    } // end else if
} // End of the function
function showPhoneWidget()
{
    showContent("epfmessage");
} // End of the function
function updatePhoneWidget()
{
    var mc = PHONE_WIDGET.art_mc;
    mc.screen_mc.gotoAndStop(SHELL.getLocalizedFrame());
    mc.screen_mc.art_mc.gotoAndStop(1);
    mc.teleport_txt.text = getLocalizedString("teleport");
    mc.hq_txt.text = getLocalizedString("visit_hq");
    mc.secret_btn.onRelease = function ()
    {
        if (mc.gadget_mc._currentframe == mc.gadget_mc._totalframes)
        {
            mc.gadget_mc.gotoAndStop(2);
        }
        else
        {
            mc.gadget_mc.nextFrame();
        } // end else if
    };
    mc.teleport_btn.onRelease = function ()
    {
        var _loc1 = mc.screen_mc.art_mc._currentframe;
        sendJoinRoom(phone_list[_loc1 - 1], 0, 0);
    };
    mc.hq_btn.onRelease = function ()
    {
        sendJoinRoom("agent", 0, 0);
    };
    mc.scroll_mc.next_btn.onRelease = function ()
    {
        mc.scroll_mc.gotoAndPlay("up");
        if (mc.screen_mc.art_mc._currentframe == mc.screen_mc.art_mc._totalframes)
        {
            mc.screen_mc.art_mc.gotoAndStop(1);
        }
        else
        {
            mc.screen_mc.art_mc.nextFrame();
        } // end else if
    };
    mc.scroll_mc.back_btn.onRelease = function ()
    {
        mc.scroll_mc.gotoAndPlay("down");
        if (mc.screen_mc.art_mc._currentframe == 1)
        {
            mc.screen_mc.art_mc.gotoAndStop(mc.screen_mc.art_mc._totalframes);
        }
        else
        {
            mc.screen_mc.art_mc.prevFrame();
        } // end else if
    };
    mc.next_btn.onRelease = mc.scroll_mc.next_btn.onRelease;
} // End of the function
function showPuffleWidget(puffle_id)
{
    setActivePuffle(puffle_id);
    closePuffleWidget();
    shell.disablePuffleInteractionByID(puffle_id);
    showWidget(PUFFLE_WIDGET);
    updatePuffleWidget();
    closeFunction = closePuffleWidget;
} // End of the function
function updatePuffleWidget()
{
    var _loc8 = getActivePuffle();
    var _loc2 = PUFFLE_WIDGET.art_mc;
    var _loc3 = shell.getMyPuffleById(_loc8);
    var _loc5 = Math.round(_loc3.hunger / 10);
    var _loc7 = Math.round(_loc3.health / 10);
    var _loc6 = Math.round(_loc3.rest / 10);
    var _loc4 = _loc3.happy;
    if (_loc4 > 75)
    {
        var _loc9 = 1;
    }
    else if (_loc4 > 50)
    {
        _loc9 = 2;
    }
    else if (_loc4 > 25)
    {
        _loc9 = 3;
    }
    else
    {
        _loc9 = 4;
    } // end else if
    _loc2.paper_mc.gotoAndStop(_loc3.typeID + 1);
    _loc2.paper_mc.art_mc.gotoAndStop(_loc9);
    _loc2.name_txt.text = _loc3.name;
    _loc2.stats_mc.gotoAndStop(shell.getLocalizedFrame());
    _loc2.stats_mc.hunger_mc.gotoAndStop(_loc5);
    _loc2.stats_mc.health_mc.gotoAndStop(_loc7);
    _loc2.stats_mc.rest_mc.gotoAndStop(_loc6);
    _loc2.tab_btn.onRelease = openPuffleWidgetTab;
    _loc2.play_btn.onRelease = function ()
    {
        sendPufflePlay();
        closeHint();
    };
    _loc2.play_btn.onRollOver = function ()
    {
        showHint(this, "play_puffle_hint");
    };
    _loc2.play_btn.onRollOut = closeHint;
    _loc2.rest_btn.onRelease = function ()
    {
        sendPuffleRest();
        closeHint();
    };
    _loc2.rest_btn.onRollOver = function ()
    {
        showHint(this, "rest_puffle_hint");
    };
    _loc2.rest_btn.onRollOut = closeHint;
    _loc2.feed_btn.onRelease = function ()
    {
        openPuffleWidgetTab();
        closeHint();
    };
    _loc2.feed_btn.onRollOver = function ()
    {
        showHint(this, "feed_puffle_hint");
    };
    _loc2.feed_btn.onRollOut = closeHint;
    _loc2.walk_btn.onRelease = function ()
    {
        sendPuffleWalk();
        closeHint();
    };
    _loc2.walk_btn.onRollOver = function ()
    {
        showHint(this, "walk_puffle_hint");
    };
    _loc2.walk_btn.onRollOut = closeHint;
    _loc2.close_btn.onRelease = closePuffleWidget;
} // End of the function
function closePuffleWidget()
{
    shell.enablePuffleInteractionByID(PUFFLE_WIDGET.puffle_id);
    closeWidget(PUFFLE_WIDGET);
} // End of the function
function openPuffleWidgetTab()
{
    var _loc1 = PUFFLE_WIDGET.art_mc;
    _loc1.gotoAndStop(2);
    _loc1.tab_btn.onRelease = closePuffleWidgetTab;
    _loc1.gum_btn.onRelease = function ()
    {
        buyPuffleGum();
    };
    _loc1.cookie_btn.onRelease = function ()
    {
        buyPuffleCookie();
    };
    _loc1.food_btn.onRelease = function ()
    {
        buyPuffleFood();
    };
    _loc1.bath_btn.onRelease = function ()
    {
        buyPuffleBath();
    };
} // End of the function
function closePuffleWidgetTab()
{
    var _loc1 = PUFFLE_WIDGET.art_mc;
    _loc1.gotoAndStop(1);
    _loc1.tab_btn.onRelease = openPuffleWidgetTab;
} // End of the function
function setActivePuffle(puffle_id)
{
    PUFFLE_WIDGET.puffle_id = puffle_id;
} // End of the function
function getActivePuffle()
{
    return (PUFFLE_WIDGET.puffle_id);
} // End of the function
function isPuffleWidgetOpen()
{
    if (PUFFLE_WIDGET._currentframe == 1)
    {
        return (true);
    } // end if
    return (false);
} // End of the function
function initPlayerMenu()
{
    player_widget_menu_text = shell.getLocalizedString("all_items");
    player_widget_last_click = getTimer();
} // End of the function
function showPlayerWidget(playerID, nickname)
{
    _paperdoll = new com.clubpenguin.ui.PaperDoll();
    _paperdoll.__set__shell(shell);
    _paperdoll.__set__ui(this);
    _paperdoll.__set__fadeAfterLoad(true);
    var _loc2 = {};
    _loc2.player_id = playerID;
    _loc2.nickname = nickname;
    setActivePlayerObject(_loc2);
    showWidget(PLAYER_WIDGET, closePlayerWidget);
    updatePlayerWidget();
    SHELL.addListener(SHELL.LOAD_PLAYER_IGLOO_LIST, handlePlayerIglooList);
    SHELL.loadPlayerIglooList();
} // End of the function
function handlePlayerIglooList(list)
{
    SHELL.removeListener(SHELL.LOAD_PLAYER_IGLOO_LIST, handlePlayerIglooList);
    var _loc3 = getActivePlayerId();
    for (var _loc1 = 0; _loc1 < list.length; ++_loc1)
    {
        if (_loc3 == list[_loc1].player_id)
        {
            PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(2);
            showVisitIglooButton();
            break;
        } // end if
    } // end of for
} // End of the function
function closePlayerWidget()
{
    setActivePlayerObject(null);
    updateListeners(PLAYER_CARD_CLOSED);
} // End of the function
function createStatus($status, $player_id, $my_id)
{
    $meVars = $status.split("$me.");
    $youVars = $status.split("$you.");
    if ($meVars.length == 0 && $youVars.length == 0)
    {
        return ($status);
    } // end if
    if ($meVars.length > 0)
    {
        var _loc2 = getActivePlayerObject();
        $status = $status.split("$me.id").join(_loc2.player_id);
        $status = $status.split("$me.nickname").join(_loc2.nickname);
        $status = $status.split("$me.name").join(_loc2.nickname);
    } // end if
    if ($youVars.length > 0)
    {
        $status = $status.split("$you.id").join(getPlayerId());
        $status = $status.split("$you.name").join(getPlayerNickname());
        $status = $status.split("$you.nickname").join(getPlayerNickname());
        $status = $status.split("$you.coins").join(getCoins());
        $status = $status.split("$you.days_old").join(shell.getMyPlayerDaysOld());
    } // end if
    return ($status);
} // End of the function
function showModeratorCrosshair()
{
    CROSSHAIR_MOD._visible = true;
    CROSSHAIR_MOD.startDrag(true, 20, 20, 740, 440);
    CROSSHAIR_MOD._x = this._xmouse;
    CROSSHAIR_MOD._y = this._ymouse;
    CROSSHAIR_MOD.target_btn.onRelease = mx.utils.Delegate.create(this, doCrossHairModRelease);
} // End of the function
function showModeratorDisabler()
{
    MOD_DISABLER._visible = true;
    MOD_DISABLER.startDrag(true, 20, 20, 740, 440);
    MOD_DISABLER._x = this._xmouse;
    MOD_DISABLER._y = this._ymouse;
    MOD_DISABLER.target_btn.onRelease = mx.utils.Delegate.create(this, doModDisabler);
} // End of the function
function doCrossHairModRelease()
{
    var _loc1 = Math.round(CROSSHAIR_MOD._x);
    var _loc2 = Math.round(CROSSHAIR_MOD._y);
    shell.sendMovePlayer(modWorkingWith, _loc1, _loc2);
    stopDrag ();
    CROSSHAIR_MOD._y = -100;
    CROSSHAIR_MOD._visible = false;
    Selection.setFocus(null);
} // End of the function
function doModDisabler()
{
    var _loc1 = Math.round(MOD_DISABLER._x);
    var _loc2 = Math.round(MOD_DISABLER._y);
    shell.sendDisable(modWorkingWith, _loc1, _loc2);
    stopDrag ();
    MOD_DISABLER._y = -100;
    MOD_DISABLER._visible = false;
    Selection.setFocus(null);
    showModeratorCrosshair();
} // End of the function
function updatePlayerWidget()
{
    var _local2 = getActivePlayerId();
    var _loc1 = getPlayerObject(_local2);
    var _loc10 = _loc1.nickname;
    var _loc8 = getPlayerRelationship(_local2);
    var _loc9 = getMembershipBadgeChevronFrame(_loc1.total_membership_days);
    var _loc4 = PLAYER_WIDGET.art_mc.icon_mc;
    var _loc5 = _loc4.member_badge_mc.ribbon_mc;
    var _loc6 = _loc4.member_badge_mc.chevron_mc;
    PLAYER_WIDGET.art_mc.modBadge._visible = false;
    if (_loc1 == undefined)
    {
        PLAYER_WIDGET.art_mc.gotoAndStop(1);
    }
    else
    {
        PLAYER_WIDGET.art_mc.gotoAndStop(2);
        if (_local2 == getPlayerId())
        {
            if (is_player_widget_tab_open)
            {
                openPlayerWidgetTab();
            }
            else
            {
                closePlayerWidgetTab();
            } // end else if
            updatePlayerWidgetCoins();
            updatePlayerWidgetCredits();
        }
        else if (isModerator() && _local2 != 0)
        {
            flash.external.ExternalInterface.call("OasisModerator.showModTools", getActivePlayerNickname(), _local2);
        } // end else if
        if (_local2 == 0)
        {
            PLAYER_WIDGET.art_mc.gotoAndStop(5);
        } // end if
        var _loc3 = new flash.filters.ColorMatrixFilter();
        cm = new com.gskinner.geom.ColorMatrix();
        var _loc13 = 0;
        if (_loc1.playercard_attributes.h == undefined)
        {
            _loc1.playercard_attributes.h = 0;
        } // end if
        cm.adjustHue(_loc1.playercard_attributes.h);
        _loc3.matrix = cm;
        PLAYER_WIDGET.art_mc.background_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.ignore_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.buddy_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.home_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.report_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.ignore_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.profile_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.g_b.filters = [_loc3];
        PLAYER_WIDGET.art_mc.close_btn.filters = [_loc3];
        PLAYER_WIDGET.art_mc.tab_btn.filters = [_loc3];
        PLAYER_WIDGET.art_mc.mail_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.save_mc.filters = [_loc3];
        PLAYER_WIDGET.art_mc.likesArea.r_bg.filters = [_loc3];
        PLAYER_WIDGET.art_mc.status_txt.text = createStatus(_loc1.playercard_attributes.s, _loc1.player_id, getPlayerId());
        PLAYER_WIDGET.art_mc.status_txt.textColor = "0x" + _loc1.playercard_attributes.sc;
        var _loc12 = new flash.filters.GlowFilter("0x" + _loc1.playercard_attributes.sg, 1, 2, 2, 100, 3, false, false);
        PLAYER_WIDGET.art_mc.status_txt.filters = [_loc12];
        if (isLocalPlayer(_local2))
        {
            PLAYER_WIDGET.art_mc.status_txt.text = _loc1.playercard_attributes.s;
            PLAYER_WIDGET.art_mc.status_txt.type = "input";
            PLAYER_WIDGET.art_mc.status_txt.onKillFocus = function ()
            {
                if (this.text == _loc1.playercard_attributes.s)
                {
                    return;
                } // end if
                if (this.text.length > 50)
                {
                    this.text = this.text.substr(0, 50);
                } // end if
                _loc1.playercard_attributes.s = this.text;
                shell.sendUpdatePlayerStatus(this.text, _local2);
            };
            _paperdoll.__set__isInteractive(true);
        }
        else
        {
            _paperdoll.__set__isInteractive(false);
        } // end else if
        if (_paperdoll.__get__paperDollClip() == null)
        {
            _paperdoll.__set__paperDollClip(PLAYER_WIDGET.art_mc.paper_doll_mc);
        } // end if
        if (_paperdoll.__get__flagClip() == null)
        {
            _paperdoll.__set__flagClip(PLAYER_WIDGET.art_mc.flag_mc);
        } // end if
        if (_paperdoll.__get__backgroundClip() == null)
        {
            _paperdoll.__set__backgroundClip(PLAYER_WIDGET.art_mc.photo_mc);
        } // end if
        _paperdoll.__set__colourID(_loc1.colour_id);
        _paperdoll.__set__flagID(_loc1.flag_id);
        _paperdoll.__set__backgroundID(_loc1.photo_id);
        PLAYER_WIDGET.art_mc.paper_doll_mc.outline.o2.face_mc.gotoAndStop(_loc1.playercard_attributes.f);
        for (var _loc7 in shell.PAPERDOLL_DEFAULT_LAYER_DEPTHS)
        {
            _paperdoll.addItem(_loc7, _loc1[_loc7]);
        } // end of for...in
        updatePlayerWidgetMenu(_local2, _loc8, _loc1);
    } // end else if
    PLAYER_WIDGET.art_mc.name_txt.text = _loc10;
    if (!shell.isLag)
    {
        if (_loc1.player_attributes.n[1] != "0" && _loc1.player_attributes.n[1] != "" && _loc1.player_attributes.n[1] != undefined)
        {
            PLAYER_WIDGET.art_mc.name_txt.textColor = "0x" + _loc1.player_attributes.n[1];
        }
        else
        {
            PLAYER_WIDGET.art_mc.name_txt.textColor = 0;
        } // end else if
        var _loc11 = String("0x") + String(_loc1.player_attributes.n[0]);
        if (_loc1.player_attributes.n[0] != "0" && _loc1.player_attributes.n[0] != "" && _loc1.player_attributes.n[0] != undefined)
        {
            PLAYER_WIDGET.art_mc.name_txt.filters = [new flash.filters.GlowFilter(_loc11, 10, 1.700000, 1.700000, 15, 3, false, false)];
        }
        else
        {
            PLAYER_WIDGET.art_mc.name_txt.filters = [new flash.filters.DropShadowFilter(1, 45, 0, 0.400000, 0, 0, 2, 3)];
        } // end if
    } // end else if
    PLAYER_WIDGET.art_mc.modBadge.gotoAndStop(1);
    PLAYER_WIDGET.art_mc.away_mc._visible = false;
    if (_loc1.ia)
    {
        PLAYER_WIDGET.art_mc.away_mc._visible = true;
    } // end if
    PLAYER_WIDGET.art_mc.modBadge._visible = false;
    PLAYER_WIDGET.art_mc.modBadge.rate_mod._visible = false;
    if (Number(_loc1.playercard_attributes.r[0]) == 1 && _loc1.playercard_attributes.r[2] != "")
    {
        PLAYER_WIDGET.art_mc.relationshipArea.relationshipType.gotoAndStop(1);
        PLAYER_WIDGET.art_mc.relationshipArea.relationshipTxt.text = _loc1.playercard_attributes.r[2];
        if (isLocalPlayer(_local2))
        {
            PLAYER_WIDGET.art_mc.relationshipArea.onRelease = function ()
            {
                var _loc1 = "Are you sure you want to request a divorce?";
                showPrompt("question", _loc1, "", sendDivorceRequest);
            };
        }
        else
        {
            delete PLAYER_WIDGET.art_mc.relationshipArea.onRelease;
        } // end else if
    }
    else if (Number(_loc1.playercard_attributes.r[0]) == 2 && _loc1.playercard_attributes.r[2] != "")
    {
        PLAYER_WIDGET.art_mc.relationshipArea.relationshipType.gotoAndStop(2);
        PLAYER_WIDGET.art_mc.relationshipArea.relationshipTxt.text = _loc1.playercard_attributes.r[2];
        if (isLocalPlayer(_local2))
        {
            PLAYER_WIDGET.art_mc.relationshipArea.onRelease = function ()
            {
                var _loc1 = "Are you sure you want to request a divorce?";
                showPrompt("question", _loc1, "", sendDivorceRequest);
            };
        }
        else
        {
            delete PLAYER_WIDGET.art_mc.relationshipArea.onRelease;
        } // end else if
    }
    else
    {
        PLAYER_WIDGET.art_mc.relationshipArea.gotoAndStop(2);
        if (!isLocalPlayer(_local2))
        {
            PLAYER_WIDGET.art_mc.relationshipArea.requestMarry.onRelease = function ()
            {
                var _loc1 = "Are you sure you want to send a marriage request to " + getActivePlayerNickname() + "?";
                showPrompt("question", _loc1, "", sendMarriageRequest);
            };
            PLAYER_WIDGET.art_mc.relationshipArea.requestBFF.onRelease = function ()
            {
                var _loc1 = "Are you sure you want to send a BFF request to " + getActivePlayerNickname() + "?";
                showPrompt("question", _loc1, "", sendBFFRequest);
            };
        }
        else
        {
            PLAYER_WIDGET.art_mc.relationshipArea.requestMarry.onRelease = function ()
            {
                showPrompt("warn", "You can\'t marry yourself.", "");
            };
            PLAYER_WIDGET.art_mc.relationshipArea.requestBFF.onRelease = function ()
            {
                showPrompt("warn", "You can\'t BFF yourself.", "");
            };
        } // end else if
    } // end else if
    PLAYER_WIDGET.art_mc.relationshipArea.r_bg.filters = [_loc3];
    if (!isLocalPlayer(_local2) && whoILiked[Number(_local2)] == undefined && _local2 != 0)
    {
        PLAYER_WIDGET.art_mc.likesArea.likeBtn.gotoAndStop(1);
        PLAYER_WIDGET.art_mc.likesArea.likeBtn.likeBtn.player_id = getActivePlayerId();
        PLAYER_WIDGET.art_mc.likesArea.likeBtn.likeBtn.onRelease = function ()
        {
            shell.sendNewLike(this.player_id);
            whoILiked[Number(this.player_id)] = true;
        };
    }
    else
    {
        PLAYER_WIDGET.art_mc.likesArea.likeBtn.gotoAndStop(2);
        delete PLAYER_WIDGET.art_mc.likesArea.likeBtn.onRelease;
    } // end else if
    PLAYER_WIDGET.art_mc.likesArea.likesTxt.text = Number(_loc1.playercard_attributes.l) || "0";
    if (_global.getCurrentShell().OasisPermission.hasPermission("a", _loc1.account_permissions, "ban"))
    {
        PLAYER_WIDGET.art_mc.modBadge._visible = true;
        PLAYER_WIDGET.art_mc.modBadge.gotoAndStop(2);
    } // end if
    if (_global.getCurrentShell().OasisPermission.hasPermission("a", _loc1.account_permissions, "edit_superuser"))
    {
        PLAYER_WIDGET.art_mc.modBadge._visible = true;
        PLAYER_WIDGET.art_mc.modBadge.gotoAndStop(3);
    } // end if
    updateListeners(PLAYER_CARD_UPDATED);
    if (isLocalPlayer(_local2))
    {
        if (isMember())
        {
            _loc4.gotoAndStop(ICON_LABEL_ME_MEMBER);
            _loc5 = _loc4.member_badge_mc.ribbon_mc;
            _loc6 = _loc4.member_badge_mc.chevron_mc;
            _loc5.gotoAndStop(shell.getLocalizedFrame());
            _loc6.gotoAndStop(_loc9);
            return;
        } // end if
        _loc4.gotoAndStop(ICON_LABEL_ME_FREE);
        return;
    } // end if
    if (_loc8 == "Mascot")
    {
        _loc4.gotoAndStop(ICON_LABEL_MASCOT);
        _loc5 = _loc4.member_badge_mc.ribbon_mc;
        _loc6 = _loc4.member_badge_mc.chevron_mc;
        _loc5.gotoAndStop(shell.getLocalizedFrame());
        _loc6.gotoAndStop(FIVE_CHEVRON);
        return;
    } // end if
    var isMember = shell.isPlayerMemberById(_local2);
    if (isMember)
    {
        _loc4.gotoAndStop(ICON_LABEL_OTHER_MEMBER);
        _loc5 = _loc4.member_badge_mc.ribbon_mc;
        _loc6 = _loc4.member_badge_mc.chevron_mc;
        _loc5.gotoAndStop(shell.getLocalizedFrame());
        _loc6.gotoAndStop(_loc9);
        return;
    } // end if
    _loc4.gotoAndStop(ICON_LABEL_OTHER_FREE);
    return;
} // End of the function
function sendDivorceRequest()
{
    shell.sendDivorceRequest();
} // End of the function
function sendMarriageRequest()
{
    var _loc2 = getActivePlayerId();
    var _loc1 = shell.getMyPlayerObject();
    if (_loc1.playercard_attributes.r[0] == 1 || _loc1.playercard_attributes.r[0] == 2)
    {
        return (showPrompt("warn", "You are already in a relationship.", ""));
    } // end if
    shell.sendRelationshipRequest("marriage", _loc2);
    showPrompt("ok", "Your request has been sent!", "");
} // End of the function
function sendBFFRequest()
{
    var _loc2 = getActivePlayerId();
    var _loc1 = shell.getMyPlayerObject();
    if (_loc1.playercard_attributes.r[0] == 1 || _loc1.playercard_attributes.r[0] == 2)
    {
        return (showPrompt("warn", "You are already in a relationship.", ""));
    } // end if
    shell.sendRelationshipRequest("bff", _loc2);
    showPrompt("ok", "Your request has been sent!", "");
} // End of the function
function getMembershipBadgeChevronFrame(totalMembershipDays)
{
    if (isNaN(totalMembershipDays))
    {
        return (1);
    } // end if
    var _loc1 = Math.floor(totalMembershipDays / 30);
    if (_loc1 <= 6)
    {
        return (ONE_CHEVRON);
    } // end if
    if (_loc1 <= 12)
    {
        return (TWO_CHEVRON);
    } // end if
    if (_loc1 <= 18)
    {
        return (THREE_CHEVRON);
    } // end if
    if (_loc1 <= 24)
    {
        return (FOUR_CHEVRON);
    } // end if
    return (FIVE_CHEVRON);
} // End of the function
function updatePlayerWidgetCoins()
{
    var _loc1 = getLocalizedString("widget_coins");
    _loc1 = replaceString("%total%", getCoins(), _loc1);
    PLAYER_WIDGET.art_mc.coins_txt.text = _loc1;
} // End of the function
function getCredits()
{
    return (shell.getMyPlayerTotalCredits());
} // End of the function
function updatePlayerWidgetCredits()
{
    PLAYER_WIDGET.art_mc.credit_txt.text = "Credits: " + getCredits();
} // End of the function
function updatePlayerWidgetStamps()
{
    var _loc1 = getLocalizedString("widget_stamps");
    var _loc2 = shell.getStampManager();
    _loc1 = replaceString("%numerator%", String(_loc2.__get__myStamps().length), _loc1);
    _loc1 = replaceString("%denominator%", String(_loc2.__get__numClubPenguinStamps()), _loc1);
    PLAYER_WIDGET.art_mc.stamps_txt.text = _loc1;
} // End of the function
function setupModerationTools()
{
    flash.external.ExternalInterface.addCallback("runModerationAction", null, b4dc772657aff7aeba3688de21867026);
} // End of the function
function b4dc772657aff7aeba3688de21867026(runAct, playerID)
{
    switch (runAct)
    {
        case "getUsersOnline":
        {
            shell.sendAdminGetDictCount();
            break;
        } 
        case "removeName":
        {
            shell.removePlayerName(playerID);
            break;
        } 
        case "disableCommunication":
        {
            shell.mutePlayerById(playerID);
            break;
        } 
        case "disableActions":
        {
            shell.disableAction(playerID, "action");
            break;
        } 
        case "disableCharacters":
        {
            shell.disableAction(playerID, "transform");
            break;
        } 
        case "moveUser":
        {
            modWorkingWith = playerID;
            showModeratorCrosshair();
            break;
        } 
        case "disableArea":
        {
            modWorkingWith = playerID;
            showModeratorDisabler();
            break;
        } 
        case "warn":
        {
            shell.OasisModeration.PlayerId = playerID;
            shell.MODERATOR_TOOLS._visible = true;
            shell.MODERATOR_TOOLS.gotoAndStop(3);
            break;
        } 
    } // End of switch
} // End of the function
function updatePlayerWidgetMenu(player_id, playerRelationship, player_ob)
{
    var _loc2 = shell.isPlayerMascotById(shell.getMyPlayerId());
    PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(1);
    PLAYER_WIDGET.art_mc.profile_mc.gotoAndStop(1);
    PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(2);
    PLAYER_WIDGET.art_mc.ignore_mc.gotoAndStop(1);
    PLAYER_WIDGET.art_mc.mail_mc.gotoAndStop(2);
    PLAYER_WIDGET.art_mc.report_mc.gotoAndStop(1);
    PLAYER_WIDGET.art_mc.modPanel._visible = false;
    switch (playerRelationship)
    {
        case "Player":
        {
            PLAYER_WIDGET.art_mc.stamps_mc.gotoAndStop(2);
            showBuddyRequestButton();
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_add_friend") == false)
            {
                PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(1);
            } // end if
            showSaveOutfitButton();
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_clone_and_save_outfit") == false)
            {
                PLAYER_WIDGET.art_mc.save_mc.gotoAndStop(1);
            } // end if
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_visit_home") == false)
            {
                PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(1);
            }
            else
            {
                PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(2);
            } // end else if
            break;
        } 
        case "Mascot":
        {
            PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(4);
            PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(1);
            showMascotFreeItemButton();
            if (isModerator())
            {
                PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(2);
                showBuddyRequestButton();
            } // end if
            break;
        } 
        case "Online":
        {
            PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(3);
            PLAYER_WIDGET.art_mc.profile_mc.gotoAndStop(2);
            PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(2);
            if (lastReportID != player_id)
            {
                PLAYER_WIDGET.art_mc.report_mc.gotoAndStop(2);
            } // end if
            showSaveOutfitButton();
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_clone_and_save_outfit") == false)
            {
                PLAYER_WIDGET.art_mc.save_mc.gotoAndStop(1);
            } // end if
            showRemoveBuddyButton();
            break;
        } 
        case "Offline":
        {
            PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(3);
            PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(2);
            PLAYER_WIDGET.art_mc.report_mc.gotoAndStop(1);
            showRemoveBuddyButton();
            showSaveOutfitButton();
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_clone_and_save_outfit") == false)
            {
                PLAYER_WIDGET.art_mc.save_mc.gotoAndStop(1);
            } // end if
            break;
        } 
        case "Ignore":
        {
            PLAYER_WIDGET.art_mc.ignore_mc.gotoAndStop(3);
            showBuddyRequestButton();
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_add_friend") == false)
            {
                PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(1);
            } // end if
            break;
        } 
        default:
        {
            PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(2);
            PLAYER_WIDGET.art_mc.ignore_mc.gotoAndStop(2);
            if (lastReportID != player_id)
            {
                PLAYER_WIDGET.art_mc.report_mc.gotoAndStop(2);
            } // end if
            showBuddyRequestButton();
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_add_friend") == false)
            {
                PLAYER_WIDGET.art_mc.buddy_mc.gotoAndStop(1);
            } // end if
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_visit_home") == false)
            {
                PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(1);
            }
            else
            {
                PLAYER_WIDGET.art_mc.home_mc.gotoAndStop(2);
            } // end else if
            showSaveOutfitButton();
            if (_global.getCurrentShell().OasisPermission.hasPermission("user", player_ob.playercard_attributes.p, "can_clone_and_save_outfit") == false)
            {
                PLAYER_WIDGET.art_mc.save_mc.gotoAndStop(1);
            } // end if
        } 
    } // End of switch
    if (isLocalPlayer(player_ob.player_id))
    {
        showSaveOutfitButton();
    } // end if
    showMailButton();
    showProfileButton();
    showVisitIglooButton();
    showToggleIgnorePlayerButton(playerRelationship == "Ignore");
    showReportPlayerButton();
    showRemoveAllItemsButton();
    showStampBookButton();
    if (isModerator())
    {
        PLAYER_WIDGET.art_mc.modPanel._visible = true;
        PLAYER_WIDGET.art_mc.modPanel.snowball_mute.gotoAndStop(2);
        PLAYER_WIDGET.art_mc.modPanel.joke_mute.gotoAndStop(2);
        PLAYER_WIDGET.art_mc.modPanel.warn_user.gotoAndStop(2);
        PLAYER_WIDGET.art_mc.modPanel.pname_user.gotoAndStop(2);
        PLAYER_WIDGET.art_mc.ignore_mc.gotoAndStop(2);
        PLAYER_WIDGET.art_mc.modPanel.snowball_mute.button_btn.onRelease = function ()
        {
            sendMessage("!SM " + player_ob.player_id);
        };
        PLAYER_WIDGET.art_mc.modPanel.pname_user.button_btn.onRelease = function ()
        {
            sendMessage("!PNAME " + player_ob.player_id);
        };
        PLAYER_WIDGET.art_mc.modPanel.joke_mute.button_btn.onRelease = function ()
        {
            sendMessage("!JM " + player_ob.player_id);
        };
        PLAYER_WIDGET.art_mc.modPanel.warn_user.button_btn.onRelease = function ()
        {
            sendMessage("!WARN " + player_ob.player_id);
        };
        showBanAndKickPlayerButtons();
    }
    else if (_loc2)
    {
    } // end else if
} // End of the function
function showMailButton()
{
    PLAYER_WIDGET.art_mc.mail_mc.button_btn.onRelease = function ()
    {
        if (isPlayerWidgetClickReady(2500))
        {
            var _loc1 = getActivePlayerId();
            var _loc2 = getActivePlayerNickname();
            showOutsideContent("privateMessenger");
            updateNewMailIcon(0);
            flash.external.ExternalInterface.call("newPrivateMessageByID", _loc1, _loc2);
        } // end if
        closeHint();
    };
    PLAYER_WIDGET.art_mc.mail_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "send_pm");
    };
    PLAYER_WIDGET.art_mc.mail_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showRemoveBuddyButton()
{
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRelease = function ()
    {
        if (isPlayerWidgetClickReady(2000))
        {
            var _loc2 = getActivePlayerNickname();
            var _loc3 = getLocalizedString("buddy_remove_prompt");
            var _loc1 = replaceString("%name%", _loc2, _loc3);
            showPrompt("question", _loc1, "", sendBuddyRemove);
        } // end if
        closeHint();
    };
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "remove_buddy_hint");
    };
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showBuddyRequestButton()
{
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRelease = function ()
    {
        if (!shell.hasMaxBuddies())
        {
            if (isPlayerWidgetClickReady(2000))
            {
                var _loc2 = getActivePlayerNickname();
                var _loc3 = getLocalizedString("buddy_request_prompt");
                var _loc1 = replaceString("%name%", _loc2, _loc3);
                showPrompt("question", _loc1, "", sendBuddyRequest);
            } // end if
        }
        else
        {
            shell.$e("[INTERFACE] updatePlayerWidgetMenu() -> Max amount of buddies! ", {error_code: shell.BUDDY_LIMIT});
        } // end else if
        closeHint();
    };
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "add_buddy_hint");
    };
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showSaveOutfitButton()
{
    PLAYER_WIDGET.art_mc.save_mc.gotoAndStop(2);
    PLAYER_WIDGET.art_mc.save_mc.button_btn.onRelease = function ()
    {
        showPrompt("small_input", "Please name the outfit", "", shell.sendSaveOutfit);
        closeHint();
    };
    PLAYER_WIDGET.art_mc.save_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "save_outfit");
    };
    PLAYER_WIDGET.art_mc.save_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showMascotFreeItemButton()
{
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRelease = function ()
    {
        var _loc1 = getActivePlayerId();
        var _loc2 = shell.getMascotGiftById(_loc1);
        buyInventory(_loc2);
        closeHint();
    };
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "free_item_hint");
    };
    PLAYER_WIDGET.art_mc.buddy_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showProfileButton()
{
    PLAYER_WIDGET.art_mc.profile_mc.button_btn.onRelease = function ()
    {
        findPlayer(getActivePlayerId());
        closeHint();
    };
    PLAYER_WIDGET.art_mc.profile_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "profile_hint");
    };
    PLAYER_WIDGET.art_mc.profile_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showVisitIglooButton()
{
    PLAYER_WIDGET.art_mc.home_mc.button_btn.onRelease = function ()
    {
        sendJoinPlayerIgloo(getActivePlayerId());
        closeHint();
    };
    PLAYER_WIDGET.art_mc.home_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "visit_home_hint");
    };
    PLAYER_WIDGET.art_mc.home_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showToggleIgnorePlayerButton(isIgnoringPlayer)
{
    if (isIgnoringPlayer)
    {
        PLAYER_WIDGET.art_mc.ignore_mc.button_btn.onRelease = function ()
        {
            if (isPlayerWidgetClickReady(2000))
            {
                setActiveIgnore(getActivePlayerId());
                var _loc2 = getActivePlayerNickname();
                var _loc3 = getLocalizedString("ignore_remove_prompt");
                var _loc1 = replaceString("%name%", _loc2, _loc3);
                showPrompt("question", _loc1, "", sendIgnoreRemove);
            } // end if
            closeHint();
        };
        PLAYER_WIDGET.art_mc.ignore_mc.button_btn.onRollOver = function ()
        {
            showHint(this, "remove_ignore_hint");
        };
    }
    else
    {
        PLAYER_WIDGET.art_mc.ignore_mc.button_btn.onRelease = function ()
        {
            if (isPlayerWidgetClickReady(2000))
            {
                var _loc2 = getActivePlayerNickname();
                var _loc3 = getLocalizedString("ignore_request_prompt");
                var _loc1 = replaceString("%name%", _loc2, _loc3);
                showPrompt("question", _loc1, "", sendIgnoreRequest);
            } // end if
            closeHint();
        };
        PLAYER_WIDGET.art_mc.ignore_mc.button_btn.onRollOver = function ()
        {
            showHint(this, "add_ignore_hint");
        };
    } // end else if
    PLAYER_WIDGET.art_mc.ignore_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showReportPlayerButton()
{
    PLAYER_WIDGET.art_mc.report_mc.button_btn.onRelease = function ()
    {
        showContent("report_form");
        closeHint();
    };
    PLAYER_WIDGET.art_mc.report_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "report_player_hint");
    };
    PLAYER_WIDGET.art_mc.report_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showRemoveAllItemsButton()
{
    PLAYER_WIDGET.art_mc.remove_btn.onRelease = function ()
    {
        if (isPlayerWidgetClickReady(1000))
        {
            shell.sendClearPaperdoll();
        } // end if
        closeHint();
    };
    PLAYER_WIDGET.art_mc.remove_btn.onRollOver = function ()
    {
        showHint(this, "remove_hint");
    };
    PLAYER_WIDGET.art_mc.remove_btn.onRollOut = closeHint;
} // End of the function
function showBanAndKickPlayerButtons()
{
    PLAYER_WIDGET.art_mc.report_mc.gotoAndStop(2);
    PLAYER_WIDGET.art_mc.report_mc.button_btn.onRelease = function ()
    {
        shell.OasisModeration.PlayerId = getActivePlayerId();
        shell.MODERATOR_TOOLS._visible = true;
        shell.MODERATOR_TOOLS.gotoAndStop(2);
        closeHint();
    };
    PLAYER_WIDGET.art_mc.report_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "ban_player_hint");
    };
    PLAYER_WIDGET.art_mc.report_mc.button_btn.onRollOut = closeHint;
    PLAYER_WIDGET.art_mc.ignore_mc.button_btn.onRelease = function ()
    {
        shell.OasisModeration.PlayerId = getActivePlayerId();
        shell.MODERATOR_TOOLS._visible = true;
        shell.MODERATOR_TOOLS.gotoAndStop(1);
        closeHint();
    };
    PLAYER_WIDGET.art_mc.ignore_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "kick_player_hint");
    };
    PLAYER_WIDGET.art_mc.ignore_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showMutePlayerButton()
{
    PLAYER_WIDGET.art_mc.profile_mc.button_btn.onRelease = function ()
    {
        var _loc1 = getActivePlayerNickname();
        var _loc2 = shell.getLocalizedString("mute_player_hint") + message_separator + _loc1;
        showPrompt("question", _loc2, undefined, mutePlayer);
        closeHint();
    };
    PLAYER_WIDGET.art_mc.profile_mc.button_btn.onRollOver = function ()
    {
        showHint(this, "mute_player_hint");
    };
    PLAYER_WIDGET.art_mc.profile_mc.button_btn.onRollOut = closeHint;
} // End of the function
function showStampBookButton()
{
} // End of the function
function showStampBook()
{
    var _loc1 = getActivePlayerObject();
    if (_loc1.player_id == undefined)
    {
        _loc1 = SHELL.getMyPlayerObject();
    } // end if
    closeContent();
    com.clubpenguin.stamps.stampbook.StampBook.__set__activePlayer(_loc1);
    showContent("load_stampbook", null, SHELL.getClientPath() + com.clubpenguin.stamps.StampManager.STAMPBOOK_SWF_FILENAME);
} // End of the function
function handleYesToBanPlayerPopup()
{
    var _loc1 = PLAYER_WIDGET.art_mc;
    _loc1.report_mc.gotoAndStop(1);
    sendMessage("!BAN " + getActivePlayerNickname());
} // End of the function
function showPlayerWidgetMenu()
{
    var _loc10 = PLAYER_WIDGET.art_mc;
    var _loc4 = getItemList();
    var _loc5 = [];
    var _loc12 = PLAYER_WIDGET_MENU_MAX_ITEMS;
    var _loc11 = player_widget_menu_type;
    var _loc17 = player_widget_menu_text;
    _loc10.sort_mc.sort_txt.text = _loc17;
    if (_loc11 != undefined)
    {
        if (_loc11 == "INVENTORY_TYPE_ALL")
        {
            _loc5 = _loc4;
        }
        else if (_loc11 == "INVENTORY_TYPE_AWARD")
        {
            var _loc13 = shell.INVENTORY_TYPE_FLAG;
            var _loc16 = shell.INVENTORY_TYPE_OTHER;
            var _loc14 = shell.INVENTORY_TYPE_PHOTO;
            for (var _loc8 in _loc4)
            {
                var _loc6 = _loc4[_loc8].type;
                if (_loc6 == _loc13 || _loc6 == _loc16 || _loc6 == _loc14)
                {
                    traceOject(_loc4[_loc8]);
                    _loc5.push(_loc4[_loc8]);
                } // end if
            } // end of for...in
        }
        else
        {
            for (var _loc8 in _loc4)
            {
                if (_loc4[_loc8].type == shell[_loc11])
                {
                    _loc5.push(_loc4[_loc8]);
                } // end if
            } // end of for...in
        } // end else if
    }
    else
    {
        _loc5 = _loc4;
    } // end else if
    _loc5 = _loc5.slice();
    for (var _loc7 = 0; _loc7 < _loc5.length; ++_loc7)
    {
        if (_loc5[_loc7].hidden == true)
        {
            _loc5.splice(_loc7, 1);
        } // end if
    } // end of for
    _loc5.sortOn(["type", "id"], Array.NUMERIC);
    var _loc18 = Math.ceil(_loc5.length / _loc12) - 1;
    var _loc15 = paginateArray(_loc5, player_widget_menu_page, _loc12);
    if (player_widget_menu_page < _loc18)
    {
        _loc10.next_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onNextButtonReleased);
    }
    else
    {
        _loc10.next_btn.onRelease = undefined;
    } // end else if
    if (player_widget_menu_page > 0)
    {
        _loc10.back_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onBackButtonReleased);
    }
    else
    {
        _loc10.back_btn.onRelease = undefined;
    } // end else if
    if (_loc10.menu_mc_holder.menu_mc)
    {
        _loc10.menu_mc_holder.menu_mc.removeMovieClip();
    } // end if
    _loc10.menu_mc_holder.attachMovie(INVENTORY_LIST_LINKAGE_ID, "menu_mc", 1, {_x: 0, _y: 0});
    for (var _loc8 = 0; _loc8 < _loc12; ++_loc8)
    {
        var _loc3 = _loc15[_loc8];
        var _loc2 = _loc10.menu_mc_holder.menu_mc["item" + _loc8 + "_mc"];
        if (_loc3 != undefined && !_loc3.hidden)
        {
            var _loc9 = !_loc3.is_member || _loc3.is_member && isMember();
            if (_loc9)
            {
                _loc2.gotoAndStop(1);
                _loc2.button_btn.item_id = _loc3.id;
                _loc2.button_btn.onRelease = function ()
                {
                    clickPlayerWidgetItem(this.item_id);
                };
            }
            else
            {
                _loc2.gotoAndStop(2);
                _loc2.button_btn.onRelease = showMemberItemNotAvailablePrompt;
            } // end else if
            _loc2.loader_mc.gotoAndStop(1);
            _loc2.icon_mc._visible = false;
            loadPlayerWidgetMenuIcon(_loc2.icon_mc, _loc3.id);
            _loc2.iid_txt.text = "ID: " + _loc3.id;
            _loc2.delBtn.item_id = _loc3.id;
            _loc2.delBtn.onRelease = function ()
            {
                var id = this.item_id;
                showPrompt("question", "Are you sure you want to delete this item?", undefined, function ()
                {
                    SHELL.sendDeleteItem(id);
                });
            };
            continue;
        } // end if
        _loc2.loader_mc.gotoAndStop(3);
        _loc2.gotoAndStop(3);
        _loc2.button_btn.onRelease = undefined;
    } // end of for
} // End of the function
function deleteItem()
{
    if (!isNaN(currentItem))
    {
        SHELL.sendDeleteItem(currentItem);
    } // end if
} // End of the function
function onNextButtonReleased()
{
    ++player_widget_menu_page;
    showPlayerWidgetMenu();
} // End of the function
function onBackButtonReleased()
{
    --player_widget_menu_page;
    showPlayerWidgetMenu();
} // End of the function
function showMemberItemNotAvailablePrompt()
{
    showWindow("oops_inventory_equip");
} // End of the function
function loadPlayerWidgetMenuIcon(mc, id)
{
    var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    if (SHELL.getInventoryObjectById(id).is_custom == true)
    {
        var _loc5 = _global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + "/play/v2/content/global/clothing/custom/icons/" + id + ".swf";
    }
    else
    {
        _loc5 = getFilePath("clothing_icons") + "" + id + ".swf";
    } // end else if
    _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onPlayerWidgetMenuIconLoadInit));
    _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onPlayerWidgetMenuIconLoadError));
    var _loc6 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc5);
    _loc3.loadClip(_loc6, mc);
} // End of the function
function onPlayerWidgetMenuIconLoadInit(event)
{
    var _loc1 = event.target;
    if (_loc1)
    {
        _loc1._parent.loader_mc.gotoAndStop(3);
        _loc1._visible = true;
    } // end if
} // End of the function
function onPlayerWidgetMenuIconLoadError(event)
{
    var _loc1 = event.target;
    if (_loc1)
    {
        _loc1._parent.loader_mc.gotoAndStop(2);
    } // end if
} // End of the function
function openPlayerWidgetSortMenu()
{
    var sortMenuMC = PLAYER_WIDGET.art_mc.sort_mc;
    sortMenuMC.gotoAndStop(2);
    var _loc1 = {x: sortMenuMC._x, y: sortMenuMC._y};
    sortMenuMC._parent.localToGlobal(_loc1);
    sortMenuMC.back_btn._x = -_loc1.x;
    sortMenuMC.back_btn._y = -_loc1.y;
    sortMenuMC.sort_btn.onRelease = closePlayerWidgetSortMenu;
    sortMenuMC.back_btn.onRelease = closePlayerWidgetSortMenu;
    sortMenuMC.back_btn.onRollOver = closePlayerWidgetSortMenu;
    sortMenuMC.back_btn.useHandCursor = false;
    sortMenuMC.safe_btn.useHandCursor = false;
    sortMenuMC.head_txt.text = shell.getLocalizedString("head_items");
    sortMenuMC.head_btn.onRollOver = closePlayerWidgetSortOtherMenu;
    sortMenuMC.head_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.head_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_HEAD");
    };
    sortMenuMC.face_txt.text = shell.getLocalizedString("face_items");
    sortMenuMC.face_btn.onRollOver = closePlayerWidgetSortOtherMenu;
    sortMenuMC.face_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.face_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_FACE");
    };
    sortMenuMC.neck_txt.text = shell.getLocalizedString("neck_items");
    sortMenuMC.neck_btn.onRollOver = closePlayerWidgetSortOtherMenu;
    sortMenuMC.neck_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.neck_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_NECK");
    };
    sortMenuMC.body_txt.text = shell.getLocalizedString("body_items");
    sortMenuMC.body_btn.onRollOver = closePlayerWidgetSortOtherMenu;
    sortMenuMC.body_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.body_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_BODY");
    };
    sortMenuMC.hand_txt.text = shell.getLocalizedString("hand_items");
    sortMenuMC.hand_btn.onRollOver = closePlayerWidgetSortOtherMenu;
    sortMenuMC.hand_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.hand_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_HAND");
    };
    sortMenuMC.feet_txt.text = shell.getLocalizedString("feet_items");
    sortMenuMC.feet_btn.onRollOver = closePlayerWidgetSortOtherMenu;
    sortMenuMC.feet_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.feet_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_FEET");
    };
    sortMenuMC.colour_txt.text = shell.getLocalizedString("colour_items");
    sortMenuMC.colour_btn.onRollOver = closePlayerWidgetSortOtherMenu;
    sortMenuMC.colour_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.colour_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_COLOUR");
    };
    sortMenuMC.other_txt.text = shell.getLocalizedString("other_items");
    sortMenuMC.other_btn.onRollOver = openPlayerWidgetSortOtherMenu;
    sortMenuMC.other_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.other_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_AWARD");
    };
    sortMenuMC.all_txt.text = shell.getLocalizedString("all_items");
    sortMenuMC.all_btn.onRollOver = closePlayerWidgetSortOtherMenu;
    sortMenuMC.all_btn.onRelease = function ()
    {
        player_widget_menu_text = sortMenuMC.all_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_ALL");
    };
} // End of the function
function openPlayerWidgetSortOtherMenu()
{
    var mc = PLAYER_WIDGET.art_mc.sort_mc;
    mc.gotoAndStop(3);
    mc.award_txt.text = shell.getLocalizedString("award_items");
    mc.award_btn.onRelease = function ()
    {
        player_widget_menu_text = mc.award_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_OTHER");
    };
    mc.flag_txt.text = shell.getLocalizedString("flag_items");
    mc.flag_btn.onRelease = function ()
    {
        player_widget_menu_text = mc.flag_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_FLAG");
    };
    mc.photo_txt.text = shell.getLocalizedString("photo_items");
    mc.photo_btn.onRelease = function ()
    {
        player_widget_menu_text = mc.photo_txt.text;
        clickPlayerWidgetSortMenu("INVENTORY_TYPE_PHOTO");
    };
} // End of the function
function closePlayerWidgetSortOtherMenu()
{
    var _loc1 = PLAYER_WIDGET.art_mc.sort_mc;
    _loc1.gotoAndStop(2);
} // End of the function
function clickPlayerWidgetSortMenu(type)
{
    player_widget_menu_type = type;
    player_widget_menu_page = 0;
    closePlayerWidgetSortMenu();
    showPlayerWidgetMenu();
} // End of the function
function closePlayerWidgetSortMenu()
{
    var _loc1 = PLAYER_WIDGET.art_mc.sort_mc;
    _loc1.gotoAndStop(1);
    _loc1.sort_btn.onRelease = openPlayerWidgetSortMenu;
} // End of the function
function openPlayerWidgetTab()
{
    var _loc2 = PLAYER_WIDGET.art_mc;
    is_player_widget_tab_open = true;
    _loc2.gotoAndStop(4);
    _loc2.tab_btn.onRelease = closePlayerWidgetTab;
    _loc2.tab_mc.onRelease = undefined;
    _loc2.tab_mc.useHandCursor = false;
    showPlayerWidgetMenu(item_list);
    _loc2.sort_mc.sort_btn.onRelease = function ()
    {
        openPlayerWidgetSortMenu();
    };
    var _loc1 = new flash.filters.ColorMatrixFilter();
    cm = new com.gskinner.geom.ColorMatrix();
    var _loc4 = getActivePlayerId();
    var _loc3 = getPlayerObject(_loc4);
    if (_loc3.playercard_attributes.h == undefined)
    {
        _loc3.playercard_attributes.h = 0;
    } // end if
    cm.adjustHue(_loc3.playercard_attributes.h);
    _loc1.matrix = cm;
    PLAYER_WIDGET.art_mc.background_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.ignore_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.buddy_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.home_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.report_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.ignore_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.profile_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.g_b.filters = [_loc1];
    PLAYER_WIDGET.art_mc.close_btn.filters = [_loc1];
    PLAYER_WIDGET.art_mc.tab_btn.filters = [_loc1];
    PLAYER_WIDGET.art_mc.mail_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.save_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.relationshipArea.r_bg.filters = [_loc1];
    PLAYER_WIDGET.art_mc.likesArea.r_bg.filters = [_loc1];
} // End of the function
function closePlayerWidgetTab()
{
    var _loc3 = PLAYER_WIDGET.art_mc;
    is_player_widget_tab_open = false;
    _loc3.gotoAndStop(3);
    _loc3.tab_btn.onRelease = openPlayerWidgetTab;
    var _loc1 = new flash.filters.ColorMatrixFilter();
    cm = new com.gskinner.geom.ColorMatrix();
    var _loc4 = getActivePlayerId();
    var _loc2 = getPlayerObject(_loc4);
    if (_loc2.playercard_attributes.h == undefined)
    {
        _loc2.playercard_attributes.h = 0;
    } // end if
    cm.adjustHue(_loc2.playercard_attributes.h);
    _loc1.matrix = cm;
    PLAYER_WIDGET.art_mc.background_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.ignore_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.buddy_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.home_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.report_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.ignore_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.profile_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.g_b.filters = [_loc1];
    PLAYER_WIDGET.art_mc.close_btn.filters = [_loc1];
    PLAYER_WIDGET.art_mc.tab_btn.filters = [_loc1];
    PLAYER_WIDGET.art_mc.mail_mc.filters = [_loc1];
    PLAYER_WIDGET.art_mc.save_mc.filters = [_loc1];
} // End of the function
function clickPlayerWidgetItem(itemID)
{
    var _loc2 = getInventoryObjectById(itemID);
    if (isPlayerWidgetClickReady(1000))
    {
        if (itemID == SPY_PHONE_ICON_ID)
        {
            showPhoneWidget();
        }
        else if (itemID == CARD_DECK_ICON_ID)
        {
            showContent("ninjaprogress");
        }
        else if (isItemOnPlayer(itemID))
        {
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_OTHER"))
        {
            showContent(itemID + "_award");
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_COLOUR"))
        {
            shell.sendUpdatePlayerColourById(itemID);
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_PHOTO"))
        {
            shell.sendUpdatePlayerPhoto(itemID);
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_FLAG"))
        {
            shell.sendUpdatePlayerFlag(itemID);
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_HEAD"))
        {
            shell.sendUpdatePlayerHead(itemID);
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_FACE"))
        {
            shell.sendUpdatePlayerFace(itemID);
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_NECK"))
        {
            shell.sendUpdatePlayerNeck(itemID);
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_BODY"))
        {
            shell.sendUpdatePlayerBody(itemID);
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_HAND"))
        {
            shell.sendUpdatePlayerHand(itemID);
        }
        else if (_loc2.type == getShellConstant("INVENTORY_TYPE_FEET"))
        {
            shell.sendUpdatePlayerFeet(itemID);
        } // end else if
    } // end else if
    closeWindow();
} // End of the function
function clickPlayerWidgetRemoveItem(name)
{
    var _loc2 = PLAYER_WIDGET.art_mc;
    if (isPlayerWidgetClickReady(1000))
    {
        if (name == "colour_id")
        {
            shell.sendUpdatePlayerColour(0);
        }
        else if (name == "head")
        {
            shell.sendUpdatePlayerHead(0);
        }
        else if (name == "face")
        {
            shell.sendUpdatePlayerFace(0);
        }
        else if (name == "neck")
        {
            shell.sendUpdatePlayerNeck(0);
        }
        else if (name == "body")
        {
            shell.sendUpdatePlayerBody(0);
        }
        else if (name == "hand")
        {
            shell.sendUpdatePlayerHand(0);
        }
        else if (name == "feet")
        {
            shell.sendUpdatePlayerFeet(0);
        }
        else if (name == "flag_id")
        {
            shell.sendUpdatePlayerFlag(0);
        }
        else if (name == "photo_id")
        {
            shell.sendUpdatePlayerPhoto(0);
        } // end else if
    } // end else if
} // End of the function
function setActivePlayerObject(player)
{
    active_player_object = player;
} // End of the function
function getActivePlayerObject()
{
    return (active_player_object);
} // End of the function
function getActivePlayerId()
{
    var _loc1 = getActivePlayerObject();
    return (_loc1.player_id);
} // End of the function
function getActivePlayerNickname()
{
    var _loc1 = getActivePlayerObject();
    return (_loc1.nickname);
} // End of the function
function isActivePlayer(playerID)
{
    if (playerID == getActivePlayerId())
    {
        return (true);
    } // end if
    return (false);
} // End of the function
function isItemOnPlayer(itemID)
{
    var _loc3 = getPlayerId();
    var _loc1 = getPlayerObject(_loc3);
    if (_loc1.colour_id == itemID)
    {
        return (true);
    }
    else if (_loc1.head == itemID)
    {
        return (true);
    }
    else if (_loc1.face == itemID)
    {
        return (true);
    }
    else if (_loc1.neck == itemID)
    {
        return (true);
    }
    else if (_loc1.body == itemID)
    {
        return (true);
    }
    else if (_loc1.hand == itemID)
    {
        return (true);
    }
    else if (_loc1.feet == itemID)
    {
        return (true);
    }
    else if (_loc1.flag_id == itemID)
    {
        return (true);
    }
    else if (_loc1.photo_id == itemID)
    {
        return (true);
    }
    else
    {
        return (false);
    } // end else if
} // End of the function
function isPlayerWidgetOpen()
{
    if (PLAYER_WIDGET._currentframe == 1)
    {
        return (true);
    } // end if
    return (false);
} // End of the function
function isPlayerWidgetClickReady(delayTime)
{
    var _loc1 = getTimer();
    if (player_widget_last_click + delayTime < _loc1)
    {
        player_widget_last_click = _loc1;
        return (true);
    } // end if
    return (false);
} // End of the function
function showWaddleWidget(name, waddle_id)
{
    showWidget(WADDLE_WIDGET, closeWaddleWidget);
    active_waddle_name = name;
    active_waddle_id = waddle_id;
    updateWaddleWidget();
} // End of the function
function updateWaddleWidget()
{
    var _loc3 = WADDLE_WIDGET.art_mc;
    var _loc8 = active_waddle_id;
    var _loc6 = active_waddle_name;
    var _loc7 = shell.getWaddleById(_loc8);
    var _loc4 = _loc7.player_list;
    if (_loc3.load_mc.art_mc == undefined)
    {
        _loc3.load_mc.createEmptyMovieClip("art_mc", 1);
        var _loc9 = com.clubpenguin.util.URLUtils.getCacheResetURL(shell.getPath(_loc6 + "_bg"));
        _loc3.load_mc.art_mc.loadMovie(_loc9);
    } // end if
    _loc3.title_txt.text = getLocalizedString(_loc6);
    _loc3.item0_mc._visible = false;
    _loc3.item1_mc._visible = false;
    _loc3.item2_mc._visible = false;
    _loc3.item3_mc._visible = false;
    for (var _loc5 in _loc4)
    {
        var _loc1 = _loc3["item" + _loc5 + "_mc"];
        var _loc2 = _loc4[_loc5];
        _loc1._visible = true;
        if (_loc2 != undefined)
        {
            if (_loc2 == getPlayerNickname())
            {
                _loc1.icon_mc.gotoAndStop("Player");
            }
            else
            {
                _loc1.icon_mc.gotoAndStop("None");
            } // end else if
            _loc1.name_txt.text = _loc2;
            continue;
        } // end if
        _loc1.icon_mc.gotoAndStop("Wait");
        _loc1.name_txt.text = getLocalizedString("empty");
    } // end of for...in
} // End of the function
function handleUpdateWaddle(ob)
{
    traceObject(ob);
    var _loc2 = ob.waddle_id;
    var _loc3 = ob.player_list;
    if (_loc2 == active_waddle_id)
    {
        updateWaddleWidget();
    } // end if
} // End of the function
function closeWaddleWidget()
{
    ENGINE.sendLeaveWaddle();
} // End of the function
function setActiveWaddle(name)
{
    active_waddle = name;
} // End of the function
function getActiveWaddle()
{
    return (active_waddle);
} // End of the function
function loadFile(mc, file_path, load_message, closeFunction, initFunction)
{
    var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    mc.load_mc.removeMovieClip();
    mc.gotoAndStop("Wait");
    mc.createEmptyMovieClip("load_mc", 1);
    mc.block_mc.useHandCursor = false;
    mc.block_mc.tabEnabled = false;
    mc.block_mc.onRelease = null;
    mc.close = closeFunction;
    mc.close_btn.onRelease = closeFunction;
    mc.progressbar_mc.message_txt.text = load_message;
    var _loc4 = com.clubpenguin.util.URLUtils.getCacheResetURL(file_path);
    _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, onFileLoadStart));
    _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, onFileLoadProgress, mc));
    _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onFileLoadInit, mc, initFunction));
    _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onFileLoadError));
    _loc3.loadClip(_loc4, mc.load_mc);
} // End of the function
function onFileLoadStart(event)
{
    event.target._visible = false;
} // End of the function
function onFileLoadInit(event, mc, initFunction)
{
    event.target._visible = true;
    mc._lockroot = true;
    mc.buyItem = buyInventory;
    mc.buyFurniture = buyFurniture;
    mc.upgradeIgloo = buyIglooUpgrade;
    mc.upgradeIglooFloor = buyIglooFloor;
    mc.adoptPet = adoptPuffle;
    mc.showWindow = LEGACY_showWindow;
    mc.myPlayer = {};
    mc.myPlayer.Nickname = shell.getMyPlayerNickname();
    mc.gotoAndStop("Done");
    if (initFunction != undefined)
    {
        initFunction();
    } // end if
} // End of the function
function onFileLoadProgress(event, mc)
{
    var _loc1 = Math.floor(event.bytesLoaded / event.bytesTotal * 100);
    mc.progressbar_mc.gotoAndStop(_loc1);
} // End of the function
function onFileLoadError(event)
{
} // End of the function
function replaceString(target, word, message)
{
    return (message.split(target).join(word));
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
function convertToSafeCase(m)
{
    return (m);
} // End of the function
function convertToTitleCase(m)
{
    m = m.toLowerCase();
    var _loc4 = m.substr(0, 1).toUpperCase();
    var _loc2 = false;
    for (var _loc3 = 1; _loc3 < m.length; ++_loc3)
    {
        var _loc1 = m.substr(_loc3, 1);
        if (_loc1 == " ")
        {
            _loc2 = true;
        }
        else
        {
            if (_loc2)
            {
                _loc1 = _loc1.toUpperCase();
            } // end if
            _loc2 = false;
        } // end else if
        _loc4 = _loc4 + "" + _loc1;
    } // end of for
    return (_loc4);
} // End of the function
function convertToSentenceCase(m)
{
    m = m.toLowerCase();
    var _loc2 = m.substr(0, 1).toUpperCase() + m.substr(1);
    return (_loc2);
} // End of the function
function removeExtraSpaces(m)
{
    var _loc1 = "";
    var _loc3 = true;
    for (var _loc4 = 0; _loc4 < m.length; ++_loc4)
    {
        var _loc2 = m.substr(_loc4, 1);
        if (_loc2 != " ")
        {
            _loc1 = _loc1 + _loc2;
            _loc3 = false;
            continue;
        } // end if
        if (_loc2 == " " && !_loc3)
        {
            _loc1 = _loc1 + " ";
            _loc3 = true;
        } // end if
    } // end of for
    if (_loc1.substr(_loc1.length - 1) == " ")
    {
        _loc1 = _loc1.substr(0, _loc1.length - 1);
    } // end if
    return (_loc1);
} // End of the function
function removeSymbols(m)
{
    var _loc2 = "";
    for (var _loc3 = 0; _loc3 < m.length; ++_loc3)
    {
        var _loc1 = m.charCodeAt(_loc3);
        if (_loc1 > 96 && _loc1 < 123)
        {
            _loc2 = _loc2 + m.charAt(_loc3);
            continue;
        } // end if
        if (_loc1 == 32)
        {
            _loc2 = _loc2 + " ";
        } // end if
    } // end of for
    return (_loc2);
} // End of the function
function removeDuplicateLetters(m)
{
    var _loc4;
    var _loc1;
    var _loc3;
    for (var _loc2 = 0; _loc2 < m.length; ++_loc2)
    {
        _loc1 = m.substr(_loc2, 1);
        if (_loc1 != _loc4)
        {
            _loc3 = _loc3 + _loc1;
        } // end if
        _loc4 = _loc1;
    } // end of for
    return (_loc3);
} // End of the function
function traceObject(object)
{
    var _loc2 = [];
    for (var _loc3 in object)
    {
        _loc2.push(_loc3 + ":" + object[_loc3]);
    } // end of for...in
} // End of the function
function newPM()
{
    flash.external.ExternalInterface.call("newMsg");
    updateNewMailIcon(1);
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
function getMaxPage(in_array, items_on_page)
{
    return (Math.ceil(in_array.length / items_on_page) - 1);
} // End of the function
function myPlayerCard()
{
    showPlayerWidget(getPlayerId(), getPlayerNickname());
} // End of the function
function setCallbacks()
{
    addCallback("sendMessage", sendMessage);
    addCallback("showMyPlayerCard", myPlayerCard);
} // End of the function
function addCallback(methodName, method)
{
    flash.external.ExternalInterface.addCallback(methodName, null, method);
} // End of the function
function setupEPFPhoneLayer()
{
    var _loc4 = ENGINE.fieldOpTriggered;
    var _loc10 = SHELL.getClientPath();
    var _loc2 = SHELL.getGamesPath();
    var _loc8 = SHELL.getCurrentRoomService();
    var _loc6 = SHELL.getEquipmentService();
    var _loc12 = SHELL.getEPFService();
    var _loc5 = SHELL.getLanguageObject();
    var _loc9 = SHELL.getMyPlayerObject();
    var _loc13 = SHELL.getMyInventoryArray();
    var _loc11 = SHELL.getRoomCrumbs();
    var _loc7 = SHELL.getInventoryCrumbsObject();
    var _loc3 = SHELL.getFieldOp();
    epfContext = new com.clubpenguin.hud.phone.EPFContext(_loc10, _loc2, epfPhoneLayer, iconLayer, _loc8, _loc6, _loc12, _loc11, SHELL.getLanguageAbbreviation(), _loc5, _loc13, _loc9, _loc3, _loc4, cancelFieldOpTrigger, this, SHELL, ENGINE, _loc7);
    epfContext.layoutChanged.add(onLayoutChanged, this);
    iconLayer.hudIconView._visible = false;
    SHELL.getPlayerEPFStatusChanged().add(showEPFPhoneHUDIcon, this);
} // End of the function
function onLayoutChanged(layout)
{
    if (layout == com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE)
    {
        stopQuickKeys();
    }
    else
    {
        startQuickKeys();
    } // end else if
} // End of the function
function showEPFPhoneHUDIcon(newAgentStatus)
{
    iconLayer.hudIconView._visible = newAgentStatus;
    if (newAgentStatus)
    {
        iconLayer.phone_mc._visible = false;
        SHELL.getEPFStatusChanged().remove(showEPFPhoneHUDIcon, this);
    } // end if
} // End of the function
function setDependencies(shell, engine)
{
    SHELL = shell;
    ENGINE = engine;
    this.shell = SHELL;
} // End of the function
function init()
{
    setupEPFPhoneLayer();
    attachShellListeners();
    embeddedFontsClip._visible = false;
    BALLOONS = (com.clubpenguin.ui.balloons.BalloonManager)(balloons_mc);
    BALLOONS.setDependencies(SHELL, ENGINE, this);
    startEggTimer();
    initPlayerMenu();
    setCallbacks();
    SHELL.setInterfaceForStampNotifier(this);
    STAMP_EARNED.panelClip.mainTitleField.text = getLocalizedString("stamp_earned");
    showInterface();
    flash.external.ExternalInterface.addCallback("hideOutsideContent", null, hideOutsideContent);
} // End of the function
function attachShellListeners()
{
    SHELL.addListener(SHELL.UPDATE_SHELL_STATE, handleUpdateShellState);
    SHELL.addListener(SHELL.SEND_MESSAGE, handleSendMessage);
    SHELL.addListener(SHELL.SEND_BLOCKED_MESSAGE, handleSendBlockedMessage);
    SHELL.addListener(SHELL.SEND_SAFE_MESSAGE, handleSendSafeMessage);
    SHELL.addListener(SHELL.SEND_LINE_MESSAGE, handleSendLineMessage);
    SHELL.addListener(SHELL.SEND_MASCOT_MESSAGE, handleSendMascotMessage);
    SHELL.addListener(SHELL.SEND_TOUR_GUIDE_MESSAGE, handleSendTourGuideMessage);
    SHELL.addListener(SHELL.SEND_QUICK_MESSAGE, handleSendQuickMessage);
    SHELL.addListener(SHELL.SEND_JOKE, handleSendJoke);
    SHELL.addListener(SHELL.SEND_EMOTE, handleSendEmote);
    SHELL.addListener(SHELL.SEND_BUDDY_REQUEST, handleBuddyRequest);
    SHELL.addListener(SHELL.SEND_BUDDY_ACCEPT, handleBuddyAccept);
    SHELL.addListener(SHELL.BUDDY_ONLINE, handleBuddyOnline);
    SHELL.addListener(SHELL.BUY_INVENTORY, handleBuyInventory);
    SHELL.addListener(SHELL.BUY_FURNITURE, handleBuyFurniture);
    SHELL.addListener(SHELL.BUY_IGLOO_TYPE, handleBuyIglooUpgrade);
    SHELL.addListener(SHELL.BUY_IGLOO_FLOOR, handleBuyIglooFloor);
    SHELL.addListener("ul", handleBuyIglooBackground);
    SHELL.addListener(SHELL.ADOPT_PUFFLE, handleAdoptPuffle);
    SHELL.addListener(SHELL.UPDATE_PLAYER, handleUpdatePlayer);
    SHELL.addListener(SHELL.UPDATE_CHAT_LOG, handleUpdateLog);
    SHELL.addListener(SHELL.UPDATE_COINS, handleUpdateCoins);
    SHELL.addListener(SHELL.UPDATE_CREDITS, handleUpdateCredits);
    SHELL.addListener(SHELL.UPDATE_BUDDY_LIST, handleUpdateBuddyList);
    SHELL.addListener(SHELL.UPDATE_EGG_TIMER, handleUpdateEggTimer);
    SHELL.addListener(SHELL.UPDATE_INVENTORY, handleUpdateInventory);
    SHELL.addListener(SHELL.LOAD_PLAYER_OBJECT, handleLoadPlayerObject);
    SHELL.addListener(SHELL.GET_PLAYER_LOCATION, handleFindPlayer);
    SHELL.addListener(SHELL.NEW_MAIL, updateNewMailIcon);
    SHELL.addListener(SHELL.UPDATE_WADDLE, handleUpdateWaddle);
    SHELL.addListener(SHELL.ROOM_INITIATED, handleRoomInitiated);
    SHELL.addListener(SHELL.ROOM_DESTROYED, handleRoomDestroyed);
} // End of the function
function handleRoomInitiated()
{
    showInterface();
    showTutorialPrompt();
    showMembershipRemaining();
} // End of the function
function handleRoomDestroyed()
{
    closeInterface();
    resetRoomBalloonManager();
} // End of the function
function showOutsideContent(outsideName, arg)
{
    var _loc1 = flash.external.ExternalInterface.call("showOutsideContent", outsideName, arg);
    if (_loc1 == "unknown")
    {
        return (false);
    } // end if
    stopQuickKeys();
} // End of the function
function hideOutsideContent()
{
    startQuickKeys();
} // End of the function
var lastMoonWalk = 0;
var currentHue = 0;
var whoILiked = new Object();
var modWorkingWith = 0;
System.security.allowDomain("*");
var SHELL;
var ENGINE;
var BALLOONS;
var shell;
var updateListeners;
var addEventListener;
var removeEventListener;
var PLAYER_CARD_UPDATED = "playerCardUpdated";
var PLAYER_CARD_CLOSED = "playerCardClosed";
com.clubpenguin.util.EventDispatcher.initialize(this);
var active_player;
var active_ignore;
var is_moderator = false;
SHELL.addListener(SHELL.ROOM_DESTROYED, handleRoomDestroyed);
var ICONS = interface_mc.icons_mc;
var NEWS_ICON = interface_mc.icons_mc.news_mc;
var MAIL_ICON = interface_mc.icons_mc.mail_mc;
var BUDDY_ICON = interface_mc.icons_mc.buddy_btn;
var RELATIONSHIP_ICON = interface_mc.icons_mc.relationshipRequest;
var MANAGER_ICON = interface_mc.icons_mc.manage_btn;
var MAP_ICON = interface_mc.icons_mc.map_mc;
var CAM_ICON = interface_mc.icons_mc.cam_mc;
var MOD_ICON = interface_mc.icons_mc.mod_mc;
var PM_ICON = interface_mc.icons_mc.pm_btn;
var PHONE_ICON = interface_mc.icons_mc.phone_mc;
var EGG_TIMER_ICON = interface_mc.icons_mc.egg_timer_mc;
var CROSSHAIR = interface_mc.crosshair_mc;
CROSSHAIR._visible = false;
var CROSSHAIR_MOD = interface_mc.mod_crosshair;
CROSSHAIR_MOD._visible = false;
var MOD_DISABLER = interface_mc.mod_disabler;
MOD_DISABLER._visible = false;
var widgetActive = false;
var WIDGETS = interface_mc.widgets_mc;
var is_quick_keys_active = false;
var myKeyListener;
var CONTENT = interface_mc.content_mc;
var WINDOW = interface_mc.window_mc;
var is_news_open = false;
var prompt_requested = false;
var membership_window_requested = false;
var TOUR_FORM = "tour_form";
var HINT = interface_mc.hint_mc;
var DOCK = interface_mc.dock_mc;
var DOCK_PLAYER_ICON = DOCK.player_icon_mc;
var is_chat_focused = false;
var SHOP = interface_mc.shop_mc;
var active_shop_item = 0;
var active_puffle_action = undefined;
var PROMPT = interface_mc.prompt_mc;
var active_game_prompt = undefined;
var endGameView = undefined;
var endGameClosedFunction;
var endGameSendFunction;
var onRoomInitiatedFunc = null;
var LOG = interface_mc.log_mc;
var message_separator = ": ";
if (shell.getLanguageAbbriviation() == shell.FR_ABBR)
{
    message_separator = " : ";
} // end if
var active_report;
var is_log_open = false;
LOG.tab_btn.onRelease = updateLog;
LOG.tab_btn.onPress = dragLog;
LOG.menu_mc.item_mc._visible = false;
var mainCategoryIDToCategoryClipFrameName = {};
mainCategoryIDToCategoryClipFrameName.catgegory7 = "activities";
mainCategoryIDToCategoryClipFrameName.catgegory5 = "events";
mainCategoryIDToCategoryClipFrameName.catgegory8 = "games";
var STAMP_EARNED = stampEarnedClip;
STAMP_EARNED.stop();
var buddy_request_list = new Array();
var buddy_request_item = new Object();
var active_buddy_request;
var last_new_total = 0;
var lastReportID = 0;
MAIL_ICON.new_mc._visible = false;
var EMOTE_MENU = interface_mc.emote_menu_mc;
var ACTION_MENU = interface_mc.action_menu_mc;
var SAFE_MENU = interface_mc.safe_menu_mc;
var BUDDY_WIDGET = interface_mc.widgets_mc.buddy_mc;
var BUDDY_TOTAL_TEXT = BUDDY_WIDGET.art_mc.buddy_total_txt;
var MAX_BUDDIES_PER_PAGE = 8;
var SCRIPT_WIDGET = interface_mc.widgets_mc.script_mc;
var MASCOT_WIDGET = interface_mc.widgets_mc.script_mc;
var GAME_WIDGET = interface_mc.widgets_mc.game_mc;
var PHONE_WIDGET = interface_mc.widgets_mc.phone_mc;
var phone_list = ["town", "coffee", "book", "dance", "lounge", "shop", "village", "lodge", "attic", "mtn", "plaza", "pet", "stage", "pizza", "beach", "light", "beacon", "dock", "forts", "rink", "boiler", "berg", "cave", "mine", "shack", "forest", "cove"];
var PUFFLE_WIDGET = interface_mc.widgets_mc.puffle_mc;
var PLAYER_WIDGET = interface_mc.widgets_mc.player_mc;
var PLAYER_WIDGET_MENU_MAX_ITEMS = 12;
var INVENTORY_LIST_LINKAGE_ID = "InventoryMenu";
var CARD_DECK_ICON_ID = 821;
var SPY_PHONE_ICON_ID = 800;
var active_player_object = {};
var is_player_widget_tab_open = false;
var player_widget_menu_page = 0;
var player_widget_menu_type = "INVENTORY_TYPE_ALL";
var player_widget_menu_text;
var player_widget_last_click;
var ICON_LABEL_ME_MEMBER = "member";
var ICON_LABEL_ME_FREE = "player";
var ICON_LABEL_OTHER_MEMBER = "member";
var ICON_LABEL_OTHER_FREE = "free";
var ICON_LABEL_MASCOT = "member";
var ICON_LABEL_MODERATOR = "mod";
var ONE_CHEVRON = 1;
var TWO_CHEVRON = 2;
var THREE_CHEVRON = 3;
var FOUR_CHEVRON = 4;
var FIVE_CHEVRON = 5;
var _paperdoll;
var WADDLE_WIDGET = interface_mc.widgets_mc.waddle_mc;
var active_waddle_name = undefined;
var active_waddle_id = undefined;
var epfPhoneLayer = interface_mc.epfPhoneLayer;
var iconLayer = interface_mc.icons_mc;
var epfContext;
var currentItem = undefined;
