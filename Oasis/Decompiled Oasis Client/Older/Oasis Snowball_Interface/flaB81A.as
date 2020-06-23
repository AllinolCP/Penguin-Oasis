function getPlayerId()
{
    return (shell.getMyPlayerId());
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
function getPlayerObject(player_id)
{
    return (shell.getPlayerObjectById(player_id));
} // End of the function
function getPlayerRelationship(player_id)
{
    if (isLocalPlayer(player_id))
    {
        return ("Player");
    }
    else if (shell.isPlayerMascotById(player_id))
    {
        return ("Mascot");
    }
    else if (isBuddy(player_id))
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
    var _loc3 = myPlayer.start_time;
    var _loc2 = myPlayer.EggTimer;
    var _loc1 = getTimer();
    return (_loc2 - (_loc1 - _loc3));
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
function handleUpdateLog(log_ob)
{
    showLog();
} // End of the function
function sendMessage(message)
{
    message = message.split("\r").join("");
    message = message.split("\n").join("");
    message = removeExtraSpaces(message);
    if (message.length)
    {
        if (message.substr(0, 1) == "!")
        {
            if (message.substr(0, 5).toLowerCase() == "!kick")
            {
                if (!isModerator())
                {
                    return (sendBotMessage("Invalid permissions!"));
                } // end if
                if (isNaN(message.substr(6)))
                {
                    return (sendBotMessage("Invalid player Id (use OasisBot !gid): " + message.substr(6)));
                } // end if
                sendBotMessage("Kicking player Id: " + message.substr(6));
                return (shell.kickPlayerById(message.substr(6), "Kicked on Snowball Server using !KICK"));
            } // end if
            if (message.substr(0, 7).toLowerCase() == "!wanted")
            {
                return (sendBotMessage("Currently wanted: " + SHELL.playerWantedName));
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!id")
            {
                return (sendBotMessage("Your ID is: " + getPlayerId()));
            } // end if
            if (message.substr(0, 10).toLowerCase() == "!roomcount")
            {
                return (sendBotMessage("Room Count: " + SHELL.getPlayerList().length));
            } // end if
            if (message.substr(0, 7).toLowerCase() == "!roomid")
            {
                return (sendBotMessage("Room ID: " + SHELL.getCurrentRoomId()));
            } // end if
            if (message.substr(0, 3).toLowerCase() == "!up")
            {
                var _loc1 = message.split(" ");
                switch (_loc1[1].toLowerCase())
                {
                    case "0":
                    {
                        return (shell.sendRemoveClothes());
                        break;
                    } 
                    case "a":
                    {
                        if (isNaN(_loc1[2]))
                        {
                            return (false);
                        } // end if
                        var _loc4 = getInventoryObjectById(_loc1[2]);
                        if (_loc4 == undefined && Number(_loc1[2]) != 0)
                        {
                            return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                        } // end if
                        return (shell.sendUpdatePlayerHand(_loc1[2]));
                        break;
                    } 
                    case "b":
                    {
                        if (isNaN(_loc1[2]))
                        {
                            return (false);
                        } // end if
                        _loc4 = getInventoryObjectById(_loc1[2]);
                        if (_loc4 == undefined && Number(_loc1[2]) != 0)
                        {
                            return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                        } // end if
                        return (shell.sendUpdatePlayerBody(_loc1[2]));
                        break;
                    } 
                    case "e":
                    {
                        if (isNaN(_loc1[2]))
                        {
                            return (false);
                        } // end if
                        _loc4 = getInventoryObjectById(_loc1[2]);
                        if (_loc4 == undefined && Number(_loc1[2]) != 0)
                        {
                            return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                        } // end if
                        return (shell.sendUpdatePlayerFeet(_loc1[2]));
                        break;
                    } 
                    case "n":
                    {
                        if (isNaN(_loc1[2]))
                        {
                            return (false);
                        } // end if
                        _loc4 = getInventoryObjectById(_loc1[2]);
                        if (_loc4 == undefined && Number(_loc1[2]) != 0)
                        {
                            return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                        } // end if
                        return (shell.sendUpdatePlayerNeck(_loc1[2]));
                        break;
                    } 
                    case "f":
                    {
                        if (isNaN(_loc1[2]))
                        {
                            return (false);
                        } // end if
                        _loc4 = getInventoryObjectById(_loc1[2]);
                        if (_loc4 == undefined && Number(_loc1[2]) != 0)
                        {
                            return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                        } // end if
                        return (shell.sendUpdatePlayerFace(_loc1[2]));
                        break;
                    } 
                    case "h":
                    {
                        if (isNaN(_loc1[2]))
                        {
                            return (false);
                        } // end if
                        _loc4 = getInventoryObjectById(_loc1[2]);
                        if (_loc4 == undefined && Number(_loc1[2]) != 0)
                        {
                            return (shell.showErrorPrompt("max", "<string>Oops!</strong><br/>Sorry, that item doesn\'t exist!", "Okay", undefined, "RDNE"));
                        } // end if
                        return (shell.sendUpdatePlayerHead(_loc1[2]));
                        break;
                    } 
                    case "c":
                    {
                        var _loc3 = String(_loc1[2]);
                        if (_loc3.length == 2 || _loc3.length == 1)
                        {
                            return (shell.showErrorPrompt("max", "<string>Attention!</strong><br/>Oasis uses color codes now instead of color IDs! Example: !UP C 00FF00", "Okay", undefined, "www.colorpicker.com"));
                        } // end if
                        if (_loc3.length != 6 && _loc3.length != 3)
                        {
                            return (shell.showErrorPrompt("max", "<string>Attention!</strong><br/>Oasis uses color codes now instead of color IDs! Example: !UP C 00FF00", "Okay", undefined, "www.colorpicker.com"));
                        } // end if
                        return (shell.sendUpdatePlayerColour(_loc1[2]));
                        break;
                    } 
                } // End of switch
            } // end if
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
function handleSendMessage(event)
{
    if (!isLocalPlayer(event.player_id))
    {
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
    showBalloon(getPlayerId(), _loc1);
    shell.sendSafeMessage(safe_id);
} // End of the function
function handleSendSafeMessage(ob)
{
    var _loc1 = ob.player_id;
    var _loc3 = ob.safe_id;
    var _loc2 = shell.getSafeMessageById(_loc3);
    if (!isLocalPlayer(_loc1))
    {
        showBalloon(_loc1, _loc2);
    } // end if
} // End of the function
function sendLineMessage(line_id)
{
    var _loc1 = shell.getLineMessageById(line_id);
    showBalloon(getPlayerId(), _loc1);
    if (!isAlone())
    {
        shell.sendLineMessage(line_id);
    } // end if
} // End of the function
function handleSendLineMessage(ob)
{
    var _loc1 = ob.player_id;
    var _loc3 = ob.line_id;
    var _loc2 = shell.getLineMessageById(_loc3);
    if (!isLocalPlayer(_loc1))
    {
        showBalloon(_loc1, _loc2);
    } // end if
} // End of the function
function sendMascotMessage(line_id)
{
    var _loc1 = shell.getMascotMessageById(line_id);
    showBalloon(getPlayerId(), _loc1);
    if (!isAlone())
    {
        shell.sendMascotMessage(line_id);
    } // end if
} // End of the function
function handleSendMascotMessage(ob)
{
    traceObject(ob);
    var _loc1 = ob.player_id;
    var _loc4 = ob.mascot_message_id;
    var _loc3 = shell.getMascotMessageById(_loc4);
    if (!isLocalPlayer(_loc1))
    {
        showBalloon(_loc1, _loc3);
    } // end if
} // End of the function
function sendTourGuideMessage()
{
    var _loc1 = shell.getCurrentRoomId();
    var _loc3 = shell.getRoomNameById(_loc1);
    var _loc2 = shell.getTourGuideMessageByRoomName(_loc3);
    showBalloon(getPlayerId(), _loc2);
    if (!isAlone())
    {
        shell.sendTourGuideMessage(_loc1);
    } // end if
} // End of the function
function handleSendTourGuideMessage(ob)
{
    var _loc1 = ob.player_id;
    var _loc4 = shell.getCurrentRoomId();
    var _loc3 = shell.getRoomNameById(_loc4);
    var _loc2 = shell.getTourGuideMessageByRoomName(_loc3);
    if (!isLocalPlayer(_loc1))
    {
        showBalloon(_loc1, _loc2);
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
    var _loc3 = ob.joke_id;
    var _loc2 = shell.getJokeById(_loc3);
    if (!isLocalPlayer(_loc1))
    {
        showBalloon(_loc1, _loc2);
    } // end if
} // End of the function
function sendPlayerAction(frame)
{
    if (!isAlone())
    {
        ENGINE.sendPlayerAction(frame);
    } // end if
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
    if (myCurrentSnowball == 1)
    {
        if (shell.snowballInfo.white_snowball <= 0)
        {
            myCurrentSnowball = 0;
            shell.setMyServerBall(0);
        } // end if
        shell.snowballInfo.white_snowball = shell.snowballInfo.white_snowball - 1;
    } // end if
    if (myCurrentSnowball == 2)
    {
        if (shell.snowballInfo.yellow_snowball <= 0)
        {
            myCurrentSnowball = 0;
            shell.setMyServerBall(0);
        } // end if
        shell.snowballInfo.yellow_snowball = shell.snowballInfo.yellow_snowball - 1;
    } // end if
    if (myCurrentSnowball == 3)
    {
        if (shell.snowballInfo.red_snowball <= 0)
        {
            myCurrentSnowball = 0;
            shell.setMyServerBall(0);
        } // end if
        shell.snowballInfo.red_snowball = shell.snowballInfo.red_snowball - 1;
    } // end if
    if (!isAlone())
    {
        ENGINE.sendThrowBall(x, y, myCurrentSnowball);
    } // end if
} // End of the function
function sendEmote(emote_id)
{
    if (!isAlone())
    {
        shell.sendEmote(emote_id);
    } // end if
    showEmoteBalloon(getPlayerId(), emote_id);
} // End of the function
function handleSendEmote(ob)
{
    var _loc1 = ob.player_id;
    var _loc2 = ob.emote_id;
    if (!isLocalPlayer(_loc1))
    {
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
    shell.sendReportPlayer(player_id, reason_id, nickname);
} // End of the function
function findPlayer(playerID)
{
    showPrompt("wait");
    shell.getPlayerLocationById(playerID);
} // End of the function
function handleFindPlayer(ob)
{
    traceObject(ob);
    var _loc2 = ob.room_id;
    var _loc1;
    if (_loc2 > 999)
    {
        var _loc5 = 2000;
        var _loc4 = _loc2 - _loc5;
        var _loc7 = getActivePlayerId();
        if (_loc4 == shell.getMyPlayerId())
        {
            _loc1 = "igloo_yours";
        }
        else if (_loc4 == _loc7)
        {
            _loc1 = "igloo_theirs";
        }
        else
        {
            _loc1 = "igloo";
        } // end else if
    }
    else if (_loc2 > 899)
    {
        _loc1 = shell.getGameCrumbsKeyById(_loc2);
    }
    else
    {
        _loc1 = shell.getRoomNameById(_loc2);
    } // end else if
    var _loc6 = getActivePlayerNickname();
    var _loc3 = shell.getLocalizedString(_loc1 + "_find");
    _loc3 = replaceString("%name%", _loc6, _loc3);
    showPrompt("ok", _loc3);
} // End of the function
function mutePlayer(reason)
{
    var _loc1 = getActivePlayerId();
    shell.mutePlayerById(_loc1, reason);
} // End of the function
function kickPlayer(reason)
{
    var _loc1 = getActivePlayerId();
    shell.kickPlayerById(_loc1, reason);
} // End of the function
function banPlayer(reason)
{
    var _loc1 = getActivePlayerId();
    shell.banPlayerById(_loc1, reason);
} // End of the function
function showInterface()
{
    SHELL.isLag = true;
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
    ICONS._visible = true;
    MAIL_ICON._visible = true;
    BUDDY_ICON._visible = false;
    var _loc1 = shell.getPath("extra_interface_icons");
    if (_loc1 != undefined)
    {
        if (ICONS.extra_mc)
        {
            ICONS.extra_mc.removeMovieClip();
        } // end if
        ICONS.createEmptyMovieClip("extra_mc", 1);
        var _loc2 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc1);
        ICONS.extra_mc.loadMovie(_loc2);
    } // end if
    MAP_ICON.map_btn.onRelease = function ()
    {
        showContent("map", undefined, "http://localhost/Oasis/Web/cdn/play/v2/content/global/content/map.swf");
    };
    STORE_ICON.store_btn.onRelease = function ()
    {
        showContent("store", undefined, "http://localhost/Oasis/Web/cdn/play/v2/content/global/content/store.swf?r" + new Date().getTime());
    };
    CAMERA_ICON.cam_btn.onRelease = function ()
    {
        showContent("cam");
    };
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
    var _loc2 = Math.round(CROSSHAIR._x + random(20) - 10);
    var _loc1 = Math.round(CROSSHAIR._y + random(20) - 10);
    if (amIAccurate)
    {
        _loc2 = CROSSHAIR._x;
        _loc1 = CROSSHAIR._y;
    } // end if
    sendThrowBall(_loc2, _loc1);
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
        var _loc2 = mc.load_mc;
    }
    else
    {
        _loc2 = mc.art_mc;
    } // end else if
    _loc2.close_btn.onRelease = function ()
    {
        closeFunction();
        closeWidget(this._parent._parent);
    };
    _loc2.background_mc.onPress = function ()
    {
        this._parent._parent.swapDepths(99);
        this._parent._parent.startDrag();
    };
    _loc2.background_mc.onRelease = function ()
    {
        this._parent._parent.stopDrag();
    };
    _loc2.background_mc.useHandCursor = false;
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
    } // End of switch
} // End of the function
function processQuickKeyCode(keyCode)
{
    var _loc2 = this.interface_mc.crosshair_mc.target_btn;
    var _loc4 = String(Selection.getFocus());
    var _loc3 = String(_loc2);
    if (Selection.getFocus() != null && _loc4 != _loc3)
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
    if (name == "store")
    {
        var _loc2 = "Snowball Store";
        var _loc4 = "http://localhost/Oasis/Web/cdn/play/v2/content/global/content/store.swf";
        return (loadFile(CONTENT, _loc4, _loc2, closeContent, undefined, true));
    } // end if
    _loc2 = getLocalizedString(name);
    if (filePath == undefined)
    {
        filePath = getFilePath(name);
        if (filePath == undefined)
        {
            shell.sendOpenAS3Module(name, data);
            return;
        } // end if
    } // end if
    loadFile(CONTENT, filePath, _loc2, closeContent, initFunction);
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
    var _loc5 = getLocalizedString(name);
    var _loc1 = getFilePath(name);
    var _loc4 = _loc1.substr(_loc1.length - 4, 4);
    if (_loc4 == ".swf")
    {
        loadFile(WINDOW, _loc1, _loc5, closeWindow, initFunction);
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
function showHint(mc, hint, isRaw)
{
    var _loc2 = {x: mc._x, y: mc._y};
    mc._parent.localToGlobal(_loc2);
    HINT._x = _loc2.x;
    HINT._y = _loc2.y - 28;
    if (isRaw)
    {
        HINT._y = _loc2.y;
    } // end if
    HINT.gotoAndStop(1);
    HINT._visible = true;
    if (hint == "send_pm")
    {
        msgHint = "Send Private Message";
    }
    else if (hint == "white_snowballs")
    {
        msgHint = shell.snowballInfo.white_snowball + " snowballs";
    }
    else if (hint == "yellow_snowballs")
    {
        msgHint = shell.snowballInfo.yellow_snowball + " snowballs";
    }
    else if (hint == "red_snowballs")
    {
        msgHint = shell.snowballInfo.red_snowball + " snowballs";
    }
    else if (hint == "health_snowballs")
    {
        msgHint = shell.snowballInfo.healing_supply + " healers";
    }
    else if (isRaw == true)
    {
        msgHint = hint;
    }
    else
    {
        msgHint = getLocalizedString(hint);
    } // end else if
    HINT.message_txt.text = msgHint;
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
    myHealthTotal = shell.snowballInfo.health_maximum;
    updateHealthBar();
    var _loc3 = "nonmember";
    if (isMember())
    {
        _loc3 = "member";
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
    whiteAmount = shell.snowballInfo.white_snowball;
    yellowAmount = shell.snowballInfo.yellow_snowball;
    redAmount = shell.snowballInfo.red_snowball;
    DOCK.health_btn.onRollOver = function ()
    {
        showHint(this, "health_snowballs");
    };
    DOCK.health_btn.onRollOut = closeHint;
    DOCK.yellow_sb_btn.onRollOver = function ()
    {
        showHint(this, "yellow_snowballs");
    };
    DOCK.yellow_sb_btn.onRollOut = closeHint;
    DOCK.red_sb_btn.onRollOver = function ()
    {
        showHint(this, "red_snowballs");
    };
    DOCK.red_sb_btn.onRollOut = closeHint;
    DOCK.white_sb_btn.onRollOver = function ()
    {
        showHint(this, "white_snowballs");
    };
    DOCK.white_sb_btn.onRollOut = closeHint;
    DOCK.white_sb_btn.onRelease = function ()
    {
        closeHint();
        if (shell.snowballInfo.white_snowball <= 0 || isNaN(shell.snowballInfo.white_snowball))
        {
            return (SHELL.showErrorPrompt("max", "You\'re all out of the white snowballs! Purchase more from the store.", "Okay", undefined, "EBALL"));
        } // end if
        SHELL.setMyServerBall(1);
        myCurrentSnowball = 1;
        showCrosshair();
    };
    DOCK.yellow_sb_btn.onRelease = function ()
    {
        closeHint();
        if (shell.snowballInfo.yellow_snowball <= 0 || isNaN(shell.snowballInfo.yellow_snowball))
        {
            return (SHELL.showErrorPrompt("max", "You\'re all out of the yellow snowballs! Purchase more from the store.", "Okay", undefined, "EBALL"));
        } // end if
        SHELL.setMyServerBall(2);
        myCurrentSnowball = 2;
        showCrosshair();
    };
    DOCK.health_btn.onRelease = function ()
    {
        closeHint();
        if (shell.snowballInfo.healing_supply <= 0 || isNaN(shell.snowballInfo.healing_supply))
        {
            return (SHELL.showErrorPrompt("max", "You\'re all out of healers! Purchase more from the store.", "Okay", undefined, "EBALL"));
        } // end if
        healMe();
    };
    DOCK.red_sb_btn.onRelease = function ()
    {
        closeHint();
        if (shell.snowballInfo.red_snowball <= 0 || isNaN(shell.snowballInfo.red_snowball))
        {
            return (SHELL.showErrorPrompt("max", "You\'re all out of the red snowballs! Purchase more from the store.", "Okay", undefined, "EBALL"));
        } // end if
        SHELL.setMyServerBall(3);
        myCurrentSnowball = 3;
        showCrosshair();
    };
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
        showAmmoMenu();
        closeHint();
    };
    DOCK.throw_btn.onRollOver = function ()
    {
        showHint(this, "throw_hint");
    };
    DOCK.throw_btn.onRollOut = closeHint;
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
function closeDock()
{
    DOCK._visible = false;
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
        Selection.setFocus(PROMPT.text_input);
    }
    else if (style == "input_small")
    {
        PROMPT.gotoAndStop(11);
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
            positiveSelectionCallback(_loc1);
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
        _loc2.isTable = objParams.is_table;
        _loc2.activeTable = objParams.activeTable;
        _loc2.gameRoomId = objParams.gameRoomId;
        var _loc6 = new com.clubpenguin.endgame.model.EndGameModel(this.SHELL, _loc2);
        var _loc4;
        if (objParams.isCardJitsu)
        {
            _loc4 = com.clubpenguin.endgame.view.CardJitsuEndGameView.LINKAGE_ID;
        }
        else
        {
            _loc4 = com.clubpenguin.endgame.view.CoinEndGameView.LINKAGE_ID;
        } // end else if
        endGameView = com.clubpenguin.endgame.view.BaseEndGameView(interface_mc.attachMovie(_loc4, "end_game_mc", interface_mc.getNextHighestDepth()));
        var _loc5 = new com.clubpenguin.endgame.mediator.EndGameMediator(endGameView, _loc6);
        _loc5.__get__endGameClosed().addOnce(endGameClosedFunction, this);
    } // end if
} // End of the function
function showScopedGameOverPrompt(total, earned, sendFunction, scope)
{
    var _loc2 = {total: total, earned: earned, is_table: true, activeTable: ENGINE.getActiveTable()};
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
function sendBotMessage(msg)
{
    shell.addToChatLog({player_id: 0, message: msg, nickname: "Oasis", type: shell.SEND_BLOCKED_MESSAGE});
    showBalloon(0, msg);
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
        var _loc4 = ob.score;
        var _loc3 = ob.coins;
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
        var _loc7 = getLog();
        var _loc6 = LOG.menu_mc;
        clearLog();
        var _loc8 = Math.floor((LOG._y - 30) / 20);
        var _loc5 = _loc7.length - 1;
        for (var _loc4 = 0; _loc4 < _loc8; ++_loc4)
        {
            var _loc3 = _loc7[_loc5];
            _loc6.item_mc.duplicateMovieClip("item" + _loc4, _loc4 + 1);
            var _loc2 = _loc6["item" + _loc4];
            if (_loc3 != undefined)
            {
                if (_loc3.type == shell.SEND_BLOCKED_MESSAGE)
                {
                    _loc2.gotoAndStop(2);
                }
                else
                {
                    _loc2.gotoAndStop(1);
                } // end else if
                if (_loc3.mod_action != undefined)
                {
                    _loc2.message_text.text = "SERVER" + message_separator + _loc3.message + message_separator + _loc3.nickname;
                }
                else
                {
                    _loc2.message_text.text = _loc3.nickname + message_separator + _loc3.message;
                } // end else if
                _loc2.player_id = _loc3.player_id;
                _loc2.nickname = _loc3.nickname;
                _loc2.message = _loc3.message;
                _loc2.type = _loc3.type;
            }
            else
            {
                _loc2.message_text.text = "";
            } // end else if
            _loc2._y = -20 * _loc4;
            _loc2.message_btn.onRelease = function ()
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
            if (!isClickableLogItem(_loc3.player_id))
            {
                _loc2.message_btn.onRelease = undefined;
                delete _loc2.message_btn.onRelease;
            } // end if
            --_loc5;
        } // end of for
    } // end if
} // End of the function
function isClickableLogItem(player_id)
{
    if (shell.playerIndexInRoom(player_id) == -1 && !shell.isPlayerBuddyById(player_id))
    {
        return (false);
    } // end if
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
function startEggTimer()
{
    var _loc1 = new Object();
    _loc1.minutes_remaining = getEggTimerMinutesRemaining();
    handleUpdateEggTimer(_loc1);
} // End of the function
function handleUpdateEggTimer(ob)
{
    traceObject(ob);
    var _loc1 = Math.ceil(ob.minutes_remaining);
    if (_loc1 > 999)
    {
        EGG_TIMER_ICON.message_mc.gotoAndStop(2);
        EGG_TIMER_ICON.message_mc.message_txt.text = _loc1;
    }
    else
    {
        EGG_TIMER_ICON.message_mc.gotoAndStop(1);
        EGG_TIMER_ICON.message_mc.message_txt.text = _loc1;
    } // end else if
    if (EGG_TIMER_ICON.minutes_remaining != _loc1)
    {
        EGG_TIMER_ICON.minutes_remaining = _loc1;
        if (_loc1 == 5)
        {
            EGG_TIMER_ICON.gotoAndStop(2);
        }
        else if (_loc1 == 4)
        {
            EGG_TIMER_ICON.gotoAndStop(3);
        }
        else if (_loc1 == 3)
        {
            EGG_TIMER_ICON.gotoAndStop(4);
        }
        else if (_loc1 == 2)
        {
            EGG_TIMER_ICON.gotoAndStop(5);
        }
        else if (_loc1 == 1)
        {
            EGG_TIMER_ICON.gotoAndStop(6);
        }
        else if (_loc1 == 0)
        {
        }
        else
        {
            EGG_TIMER_ICON.gotoAndStop(1);
        } // end else if
    } // end else if
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
    var _loc2 = buddy_request_list.pop();
    buddy_request_item = _loc2;
    setActiveBuddyRequest(_loc2.player_id);
    if (_loc2.action == "request")
    {
        var _loc1 = getLocalizedString("buddy_question_prompt");
        _loc1 = replaceString("%name%", _loc2.nickname, _loc1);
        showPrompt("question", _loc1, "", sendBuddyAccept);
    }
    else if (_loc2.action == "accepted")
    {
        _loc1 = getLocalizedString("buddy_accepted_prompt");
        _loc1 = replaceString("%name%", _loc2.nickname, _loc1);
        showPrompt("ok", _loc1);
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
    MAIL_ICON.new_mc._visible = true;
    if (t > 999)
    {
        MAIL_ICON.new_mc.gotoAndStop(2);
        MAIL_ICON.new_mc.mail_count_txt.text = t;
    }
    else
    {
        MAIL_ICON.new_mc.gotoAndStop(1);
        MAIL_ICON.new_mc.mail_count_txt.text = t;
    } // end else if
    if (t < 1)
    {
        MAIL_ICON.new_mc._visible = false;
    } // end if
    if (t > last_new_total)
    {
        bounceIcon(MAIL_ICON);
    } // end if
    last_new_total = t;
} // End of the function
function setupEmotesForPage(pageNum)
{
    switch (pageNum)
    {
        case 2:
        case "2":
        {
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
            return;
            break;
        } 
        case "4":
        case 4:
        {
            EMOTE_MENU.e1_btn.onRelease = function ()
            {
                clickEmote(36);
            };
            EMOTE_MENU.e2_btn.onRelease = function ()
            {
                clickEmote(35);
            };
            EMOTE_MENU.e3_btn.onRelease = function ()
            {
                clickEmote(34);
            };
            EMOTE_MENU.e4_btn.onRelease = function ()
            {
                clickEmote(31);
            };
            EMOTE_MENU.e5_btn.onRelease = function ()
            {
                clickEmote(32);
            };
            EMOTE_MENU.e6_btn.onRelease = function ()
            {
                clickEmote(33);
            };
            return;
            break;
        } 
        case 5:
        case "5":
        {
            EMOTE_MENU.e1_btn.onRelease = function ()
            {
                clickEmote(37);
            };
            EMOTE_MENU.e2_btn.onRelease = function ()
            {
                clickEmote(38);
            };
            EMOTE_MENU.e3_btn.onRelease = function ()
            {
                clickEmote(39);
            };
            EMOTE_MENU.e4_btn.onRelease = function ()
            {
                clickEmote(40);
            };
            EMOTE_MENU.e5_btn.onRelease = function ()
            {
                clickEmote(41);
            };
            EMOTE_MENU.e6_btn.onRelease = function ()
            {
                clickEmote(42);
            };
            EMOTE_MENU.e7_btn.onRelease = function ()
            {
                clickEmote(43);
            };
            EMOTE_MENU.e8_btn.onRelease = function ()
            {
                clickEmote(44);
            };
            EMOTE_MENU.e9_btn.onRelease = function ()
            {
                clickEmote(45);
            };
            return;
            break;
        } 
        default:
        {
            SHELL.showErrorPrompt("max", "There was an error displaying this emote pack!", "Okay", function ()
            {
                showEmoteMenu();
                SHELL.hideErrorPrompt();
            }, "E" + pageNum);
            break;
        } 
    } // End of switch
} // End of the function
function hideAllEmotePacks()
{
    EMOTE_MENU.emotePackName1._visible = false;
    EMOTE_MENU.emotePack1._visible = false;
    EMOTE_MENU.emotePackName2._visible = false;
    EMOTE_MENU.emotePack2._visible = false;
    EMOTE_MENU.emotePackName3._visible = false;
    EMOTE_MENU.emotePack3._visible = false;
    EMOTE_MENU.emotePackName4._visible = false;
    EMOTE_MENU.emotePack4._visible = false;
    EMOTE_MENU.emotePackName5._visible = false;
    EMOTE_MENU.emotePack5._visible = false;
    EMOTE_MENU.emotePackName6._visible = false;
    EMOTE_MENU.emotePack6._visible = false;
    EMOTE_MENU.emotePackName7._visible = false;
    EMOTE_MENU.emotePack7._visible = false;
    EMOTE_MENU.emotePackName8._visible = false;
    EMOTE_MENU.emotePack8._visible = false;
} // End of the function
function setupEmotePackPage()
{
    hideAllEmotePacks();
    if (SHELL.myOwnedPacks == undefined)
    {
        SHELL.myOwnedPacks = {};
    } // end if
    EMOTE_MENU.emotePack1.onRelease = function ()
    {
        EMOTE_MENU.gotoAndStop(2);
        EMOTE_MENU.back_btn.onRelease = closeEmoteMenu;
        EMOTE_MENU.back_btn.onRollOver = closeEmoteMenu;
        EMOTE_MENU.close_btn.onRelease = closeEmoteMenu;
        EMOTE_MENU.back_btn.useHandCursor = false;
        EMOTE_MENU.safe_btn.useHandCursor = false;
        setupEmotesForPage(2);
    };
    EMOTE_MENU.emotePackName1.text = "Normal Emotes";
    EMOTE_MENU.emotePackName1._visible = true;
    EMOTE_MENU.emotePack1._visible = true;
    var _loc1 = SHELL.myOwnedPacks;
    var _loc2 = "";
    for (var _loc3 in _loc1)
    {
        EMOTE_MENU["emotePackName" + (Number(_loc3) + 1)]._visible = true;
        EMOTE_MENU["emotePack" + (Number(_loc3) + 1)]._visible = true;
        EMOTE_MENU["emotePackName" + (Number(_loc3) + 1)].text = _loc1[_loc3].name;
        _loc2 = EMOTE_MENU["emotePack" + (Number(_loc3) + 1)];
        _loc2.button_btn.onRelease = createFunc(finishEmotePage, _loc1[_loc3].pageInt);
    } // end of for...in
} // End of the function
function createFunc(f, a)
{
    return (function ()
    {
        f(a);
    });
} // End of the function
function finishEmotePage(pageInt)
{
    EMOTE_MENU.gotoAndStop(Number(pageInt));
    EMOTE_MENU.back_btn.onRelease = closeEmoteMenu;
    EMOTE_MENU.back_btn.onRollOver = closeEmoteMenu;
    EMOTE_MENU.close_btn.onRelease = closeEmoteMenu;
    EMOTE_MENU.back_btn.useHandCursor = false;
    EMOTE_MENU.safe_btn.useHandCursor = false;
    setupEmotesForPage(pageInt);
} // End of the function
function showAmmoMenu()
{
    AMMO_MENU.gotoAndStop(1);
    AMMO_MENU.gotoAndStop(2);
    AMMO_MENU.back_btn.onRelease = closeAmmoMenu;
    AMMO_MENU.back_btn.onRollOver = closeAmmoMenu;
    AMMO_MENU.close_btn.onRelease = closeAmmoMenu;
    AMMO_MENU.back_btn.useHandCursor = false;
    AMMO_MENU.safe_btn.useHandCursor = false;
    whiteAmount = shell.snowballInfo.white_snowball;
    yellowAmount = shell.snowballInfo.yellow_snowball;
    redAmount = shell.snowballInfo.red_snowball;
    if (whiteAmount <= 0 || isNaN(whiteAmount))
    {
        AMMO_MENU.whiteAmount.text = "0";
        AMMO_MENU.white_mc.onRelease = function ()
        {
            SHELL.showErrorPrompt("max", "You\'re all out of the white snowballs! Purchase more from the store.", "Okay", undefined, "EBALL");
            closeAmmoMenu();
            return;
        };
    }
    else
    {
        AMMO_MENU.whiteAmount.text = whiteAmount;
        AMMO_MENU.white_mc.onRelease = function ()
        {
            myCurrentSnowball = 1;
            showCrosshair();
            closeAmmoMenu();
        };
    } // end else if
    if (yellowAmount <= 0 || isNaN(yellowAmount))
    {
        AMMO_MENU.yellowAmount.text = "0";
        AMMO_MENU.yellow_mc.onRelease = function ()
        {
            SHELL.showErrorPrompt("max", "You\'re all out of the yellow snowballs! Purchase more from the store.", "Okay", undefined, "EBALL");
            closeAmmoMenu();
            return;
        };
    }
    else
    {
        AMMO_MENU.yellowAmount.text = yellowAmount;
        AMMO_MENU.yellow_mc.onRelease = function ()
        {
            myCurrentSnowball = 2;
            showCrosshair();
            closeAmmoMenu();
        };
    } // end else if
    if (ammo.healer <= 0 || isNaN(ammo.healer))
    {
        AMMO_MENU.healerAmount.text = "0";
        AMMO_MENU.healer_mc.onRelease = function ()
        {
            SHELL.showErrorPrompt("max", "You\'re all out of the healers! Purchase more from the store.", "Okay", undefined, "EBALL");
            closeAmmoMenu();
            return;
        };
    }
    else
    {
        AMMO_MENU.healerAmount.text = ammo.healer;
        AMMO_MENU.healer_mc.onRelease = function ()
        {
            healMe();
            closeAmmoMenu();
        };
    } // end else if
    if (redAmount <= 0 || isNaN(redAmount))
    {
        AMMO_MENU.redAmount.text = "0";
        AMMO_MENU.red_mc.onRelease = function ()
        {
            SHELL.showErrorPrompt("max", "You\'re all out of the red snowballs! Purchase more from the store.", "Okay", undefined, "EBALL");
            closeAmmoMenu();
            return;
        };
    }
    else
    {
        AMMO_MENU.redAmount.text = redAmount;
        AMMO_MENU.red_mc.onRelease = function ()
        {
            myCurrentSnowball = 3;
            showCrosshair();
            closeAmmoMenu();
        };
    } // end else if
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
    setupEmotesForPage(2);
    EMOTE_MENU.emotePacks.onRelease = function ()
    {
        EMOTE_MENU.gotoAndStop(3);
        EMOTE_MENU.back_btn.onRelease = closeEmoteMenu;
        EMOTE_MENU.back_btn.onRollOver = closeEmoteMenu;
        EMOTE_MENU.close_btn.onRelease = closeEmoteMenu;
        EMOTE_MENU.back_btn.useHandCursor = false;
        EMOTE_MENU.safe_btn.useHandCursor = false;
        setupEmotePackPage();
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
function closeAmmoMenu()
{
    AMMO_MENU.gotoAndStop(1);
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
    var _loc3 = _loc9[_loc12];
    _loc3.item_mc._visible = false;
    _loc3.c = c;
    var _loc10 = l.length * _loc6;
    if (c > 0)
    {
        var _loc11 = _loc9["menu" + (c - 1)];
        _loc3._y = _loc11._y + r * _loc6;
        _loc3._x = _loc11._x + _loc11._width + 2;
    }
    else
    {
        _loc3._y = _loc3._y - _loc10 + _loc6;
    } // end else if
    if (_loc3._y + _loc10 > _loc6)
    {
        _loc3._y = _loc3._y - (_loc3._y + _loc10 - _loc6);
    } // end if
    for (i = 0; i < l.length; i++)
    {
        var _loc2 = l[i];
        var _loc4 = "item" + i;
        _loc3.item_mc.duplicateMovieClip(_loc4, i + 1);
        var _loc1 = _loc3[_loc4];
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
function clickBuddyWidgetItem()
{
    var _loc2 = this._parent.player_id;
    var _loc3 = this._parent.nickname;
    showPlayerWidget(_loc2, _loc3);
} // End of the function
function healMe()
{
    shell.healMe();
} // End of the function
function showGameWidget(game_name)
{
    var _loc6 = shell.getGameCrumbsByName(game_name);
    var _loc4 = _loc6.path;
    if (_loc6 == undefined || _loc4 == undefined)
    {
        shell.$e("Interface -> showGameWidget() -> ERROR", {error_code: shell.LOAD_ERROR, file_path: _loc4});
        return;
    } // end if
    var _loc8 = shell.getLocalizedString(game_name);
    var _loc11 = closeGameWidget;
    var _loc10 = GAME_WIDGET.load_mc.startGame;
    var _loc5 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    var _loc2 = {};
    GAME_WIDGET.load_mc.removeMovieClip();
    GAME_WIDGET.createEmptyMovieClip("load_mc", 1);
    WINDOW.gotoAndStop("Wait");
    WINDOW.close_btn.onRelease = closeWindow;
    WINDOW.progressbar_mc.message_txt.text = _loc8;
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
    _loc5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, _loc2.onLoadInit));
    _loc5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, _loc2.onLoadProgress));
    var _loc7 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc4);
    _loc5.loadClip(_loc7, GAME_WIDGET.load_mc);
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
    var _loc6 = getActivePuffle();
    var _loc2 = PUFFLE_WIDGET.art_mc;
    var _loc3 = shell.getMyPuffleById(_loc6);
    var _loc9 = Math.round(_loc3.hunger / 10);
    var _loc7 = Math.round(_loc3.health / 10);
    var _loc8 = Math.round(_loc3.rest / 10);
    var _loc5 = _loc3.happy;
    if (_loc5 > 75)
    {
        var _loc4 = 1;
    }
    else if (_loc5 > 50)
    {
        _loc4 = 2;
    }
    else if (_loc5 > 25)
    {
        _loc4 = 3;
    }
    else
    {
        _loc4 = 4;
    } // end else if
    _loc2.paper_mc.gotoAndStop(_loc3.typeID + 1);
    _loc2.paper_mc.art_mc.gotoAndStop(_loc4);
    _loc2.name_txt.text = _loc3.name;
    _loc2.stats_mc.gotoAndStop(shell.getLocalizedFrame());
    _loc2.stats_mc.hunger_mc.gotoAndStop(_loc9);
    _loc2.stats_mc.health_mc.gotoAndStop(_loc7);
    _loc2.stats_mc.rest_mc.gotoAndStop(_loc8);
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
function updatePlayerWidget()
{
    var _local2 = getActivePlayerId();
    var _loc8 = getActivePlayerNickname();
    var player_ob = getPlayerObject(_local2);
    var _loc7 = getPlayerRelationship(_local2);
    var _loc6 = getMembershipBadgeChevronFrame(player_ob.total_membership_days);
    var _loc9 = PLAYER_WIDGET.art_mc.moderatorButtonEditPlayer;
    var _loc2 = PLAYER_WIDGET.art_mc.icon_mc;
    var _loc4 = _loc2.member_badge_mc.ribbon_mc;
    var _loc3 = _loc2.member_badge_mc.chevron_mc;
    if (player_ob == undefined)
    {
        PLAYER_WIDGET.art_mc.gotoAndStop(1);
    }
    else
    {
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
        }
        else
        {
            PLAYER_WIDGET.art_mc.gotoAndStop(2);
        } // end else if
        if (isLocalPlayer(_local2))
        {
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
        _paperdoll.__set__colourID(player_ob.colour_id);
        _paperdoll.__set__flagID(player_ob.flag_id);
        _paperdoll.__set__backgroundID(player_ob.photo_id);
        for (var _loc5 in shell.PAPERDOLL_DEFAULT_LAYER_DEPTHS)
        {
            _paperdoll.addItem(_loc5, player_ob[_loc5]);
        } // end of for...in
        updatePlayerWidgetMenu(_local2, _loc7);
    } // end else if
    PLAYER_WIDGET.art_mc.name_txt.text = _loc8;
    PLAYER_WIDGET.art_mc.rateUser.onRelease = function ()
    {
        showOutsideContent("userRate", _local2);
    };
    PLAYER_WIDGET.art_mc.statusText.text = player_ob.mood;
    _loc9._visible = false;
    updateListeners(PLAYER_CARD_UPDATED);
    if (isLocalPlayer(_local2))
    {
        PLAYER_WIDGET.art_mc.statusText.onKillFocus = function ()
        {
            if (player_ob.mood == this.text)
            {
                return;
            } // end if
            player_ob.mood = this.text;
            shell.sendUpdatePlayerStatus(this.text);
        };
        if (isMember())
        {
            _loc2.gotoAndStop(ICON_LABEL_ME_MEMBER);
            _loc4 = _loc2.member_badge_mc.ribbon_mc;
            _loc3 = _loc2.member_badge_mc.chevron_mc;
            _loc4.gotoAndStop(shell.getLocalizedFrame());
            _loc3.gotoAndStop(_loc6);
            return;
        } // end if
        _loc2.gotoAndStop(ICON_LABEL_ME_FREE);
        return;
    }
    else if (isModerator())
    {
        PLAYER_WIDGET.art_mc.statusText.type = "input";
        PLAYER_WIDGET.art_mc.statusText.onKillFocus = function ()
        {
            shell.sendUpdatePlayerStatus(this.text, _local2);
        };
    } // end else if
    if (_loc7 == "Mascot")
    {
        _loc2.gotoAndStop(ICON_LABEL_MASCOT);
        _loc4 = _loc2.member_badge_mc.ribbon_mc;
        _loc3 = _loc2.member_badge_mc.chevron_mc;
        _loc4.gotoAndStop(shell.getLocalizedFrame());
        _loc3.gotoAndStop(FIVE_CHEVRON);
        return;
    } // end if
    var isMember = shell.isPlayerMemberById(_local2);
    if (isMember)
    {
        _loc2.gotoAndStop(ICON_LABEL_OTHER_MEMBER);
        _loc4 = _loc2.member_badge_mc.ribbon_mc;
        _loc3 = _loc2.member_badge_mc.chevron_mc;
        _loc4.gotoAndStop(shell.getLocalizedFrame());
        _loc3.gotoAndStop(_loc6);
        return;
    } // end if
    _loc2.gotoAndStop(ICON_LABEL_OTHER_FREE);
    return;
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
    var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    var _loc4 = getFilePath("clothing_icons") + "" + id + ".swf";
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onPlayerWidgetMenuIconLoadInit));
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onPlayerWidgetMenuIconLoadError));
    var _loc3 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc4);
    _loc2.loadClip(_loc3, mc);
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
    var _loc1 = PLAYER_WIDGET.art_mc;
    is_player_widget_tab_open = true;
    _loc1.gotoAndStop(4);
    _loc1.tab_btn.onRelease = closePlayerWidgetTab;
    _loc1.tab_mc.onRelease = undefined;
    _loc1.tab_mc.useHandCursor = false;
    showPlayerWidgetMenu(item_list);
    _loc1.sort_mc.sort_btn.onRelease = function ()
    {
        openPlayerWidgetSortMenu();
    };
} // End of the function
function closePlayerWidgetTab()
{
    var _loc1 = PLAYER_WIDGET.art_mc;
    is_player_widget_tab_open = false;
    _loc1.gotoAndStop(3);
    _loc1.tab_btn.onRelease = openPlayerWidgetTab;
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
            shell.sendUpdatePlayerColour(itemID);
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
    var _loc9 = shell.getWaddleById(_loc8);
    var _loc4 = _loc9.player_list;
    if (_loc3.load_mc.art_mc == undefined)
    {
        _loc3.load_mc.createEmptyMovieClip("art_mc", 1);
        var _loc7 = com.clubpenguin.util.URLUtils.getCacheResetURL(shell.getPath(_loc6 + "_bg"));
        _loc3.load_mc.art_mc.loadMovie(_loc7);
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
function loadFile(mc, file_path, load_message, closeFunction, initFunction, stopBlock)
{
    var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    mc.load_mc.removeMovieClip();
    mc.gotoAndStop("Wait");
    mc.createEmptyMovieClip("load_mc", 1);
    mc.block_mc.useHandCursor = false;
    mc.block_mc.tabEnabled = false;
    mc.block_mc.onRelease = null;
    if (stopBlock)
    {
        mc.block_mc._visible = false;
    } // end if
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
    m = m.split(" ");
    for (var _loc5 in m)
    {
        var _loc1 = m[_loc5];
        if (_loc1.length > 1)
        {
            var _loc2 = _loc1.charCodeAt(1);
            if (_loc2 > 64 && _loc2 < 91)
            {
                _loc1 = _loc1.toUpperCase();
            }
            else
            {
                var _loc3 = _loc1.charCodeAt(0);
                if (_loc3 > 64 && _loc3 < 91)
                {
                    _loc1 = _loc1.substr(0, 1).toUpperCase() + _loc1.substr(1).toLowerCase();
                }
                else
                {
                    _loc1 = _loc1.toLowerCase();
                } // end if
            } // end else if
        } // end else if
        m[_loc5] = _loc1;
    } // end of for...in
    return (m.join(" "));
} // End of the function
function convertToTitleCase(m)
{
    m = m.toLowerCase();
    var _loc5 = m.substr(0, 1).toUpperCase();
    var _loc3 = false;
    for (var _loc2 = 1; _loc2 < m.length; ++_loc2)
    {
        var _loc1 = m.substr(_loc2, 1);
        if (_loc1 == " ")
        {
            _loc3 = true;
        }
        else
        {
            if (_loc3)
            {
                _loc1 = _loc1.toUpperCase();
            } // end if
            _loc3 = false;
        } // end else if
        _loc5 = _loc5 + "" + _loc1;
    } // end of for
    return (_loc5);
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
    var _loc4 = true;
    for (var _loc2 = 0; _loc2 < m.length; ++_loc2)
    {
        var _loc3 = m.substr(_loc2, 1);
        if (_loc3 != " ")
        {
            _loc1 = _loc1 + _loc3;
            _loc4 = false;
            continue;
        } // end if
        if (_loc3 == " " && !_loc4)
        {
            _loc1 = _loc1 + " ";
            _loc4 = true;
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
    var _loc3 = "";
    for (var _loc1 = 0; _loc1 < m.length; ++_loc1)
    {
        var _loc2 = m.charCodeAt(_loc1);
        if (_loc2 > 96 && _loc2 < 123)
        {
            _loc3 = _loc3 + m.charAt(_loc1);
            continue;
        } // end if
        if (_loc2 == 32)
        {
            _loc3 = _loc3 + " ";
        } // end if
    } // end of for
    return (_loc3);
} // End of the function
function removeDuplicateLetters(m)
{
    var _loc4;
    var _loc2;
    var _loc3;
    for (var _loc1 = 0; _loc1 < m.length; ++_loc1)
    {
        _loc2 = m.substr(_loc1, 1);
        if (_loc2 != _loc4)
        {
            _loc3 = _loc3 + _loc2;
        } // end if
        _loc4 = _loc2;
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
function setupEPFPhoneLayer()
{
    var _loc7 = ENGINE.fieldOpTriggered;
    var _loc13 = SHELL.getClientPath();
    var _loc9 = SHELL.getGamesPath();
    var _loc12 = SHELL.getCurrentRoomService();
    var _loc5 = SHELL.getEquipmentService();
    var _loc10 = SHELL.getEPFService();
    var _loc6 = SHELL.getLanguageObject();
    var _loc3 = SHELL.getMyPlayerObject();
    var _loc11 = SHELL.getMyInventoryArray();
    var _loc2 = SHELL.getRoomCrumbs();
    var _loc4 = SHELL.getInventoryCrumbsObject();
    var _loc8 = SHELL.getFieldOp();
    epfContext = new com.clubpenguin.hud.phone.EPFContext(_loc13, _loc9, epfPhoneLayer, iconLayer, _loc12, _loc5, _loc10, _loc2, SHELL.getLanguageAbbreviation(), _loc6, _loc11, _loc3, _loc8, _loc7, cancelFieldOpTrigger, this, SHELL, ENGINE, _loc4);
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
    initPlayerMenu();
    interface_mc.blockArea._visible = false;
    showInterface();
} // End of the function
function updateHealthBar()
{
    interface_mc.dock_mc.healthBox.healthAmount.text = myHealthTotal + "/" + shell.snowballInfo.health_maximum;
    interface_mc.dock_mc.healthBox.healthBar.healthBar._xscale = myHealthTotal;
} // End of the function
function handleLoadMyAmmo(obj)
{
    str = obj.join("%");
    obj.shift();
    shell.snowballInfo.white_snowball = obj.shift();
    shell.snowballInfo.yellow_snowball = obj.shift();
    shell.snowballInfo.red_snowball = obj.shift();
    var _loc3 = obj.shift();
    var _loc2 = obj.shift();
    var _loc4 = obj.shift();
    var _loc5 = obj.shift();
    if (!isNaN(_loc2) && _loc2 != "" && _loc2 != undefined)
    {
        myScore = Number(_loc2);
        interface_mc.icons_mc.scoreBox.scoreTxt.text = "Score: " + myScore;
        interface_mc.icons_mc.creditBox.creditsTxt.text = "Credits: " + Math.round(Number(myScore) / 2);
    } // end if
    if (!isNaN(_loc3) && _loc3 != "" && _loc3 != undefined)
    {
        shell.snowballInfo.health_maximum = _loc3;
        myHealthTotal = shell.snowballInfo.health_maximum;
        updateHealthBar();
    } // end if
    if (!isNaN(_loc4) && _loc4 != "" && _loc4 != undefined)
    {
        shell.snowballInfo.healing_supply = _loc4;
    } // end if
    if (_loc5 == "1")
    {
        shell.snowballInfo.is_accurate = true;
    } // end if
} // End of the function
function addToScore(plus)
{
    myScore = myScore + Number(plus);
    interface_mc.icons_mc.scoreBox.scoreTxt.text = "Score: " + myScore;
    interface_mc.icons_mc.creditBox.creditsTxt.text = "Credits: " + Math.round(myScore / 2);
} // End of the function
function subtractFromScore(minus)
{
    myScore = myScore - Number(minus);
    interface_mc.icons_mc.scoreBox.scoreTxt.text = "Score: " + myScore;
    interface_mc.icons_mc.creditBox.creditsTxt.text = "Credits: " + Math.round(myScore / 2);
} // End of the function
function notify(title, msg)
{
    flash.external.ExternalInterface.call("sendNotify", title, msg);
} // End of the function
function handleNewKill(obj)
{
    obj.shift();
    var _loc5 = obj.shift();
    var _loc2 = obj.shift();
    var _loc4 = obj.shift();
    var _loc3 = obj.shift();
    var _loc6 = obj.shift();
    if (_loc5 == getPlayerId())
    {
        notify("Game Over", "You have been killed by " + _loc3);
        subtractFromScore(5);
        return (true);
    }
    else if (_loc4 == getPlayerId())
    {
        notify("Killed", "You have killed " + _loc2);
        addToScore(40);
        return (true);
    }
    else
    {
        notify("Killed", _loc3 + " has killed " + _loc2);
        return (true);
    } // end else if
} // End of the function
function closeKillBox()
{
    clearInterval(killedInt);
    interface_mc.icons_mc.killedBox._visible = false;
} // End of the function
function gotKilled(playerName)
{
    var _loc2 = [0.330000, 0.330000, 0.330000, 0, 0, 0.330000, 0.330000, 0.330000, 0, 0, 0.330000, 0.330000, 0.330000, 0, 0, 0.330000, 0.330000, 0.330000, 1, 0];
    var _loc1 = new flash.filters.ColorMatrixFilter(_loc2);
    ENGINE.getRoomMovieClip().filters = [_loc1];
    GAME_OVER.gotoAndStop(2);
    closeContent();
    GAME_OVER.killedBy.text = "You have been killed by " + playerName;
    stopQuickKeys();
    sendPlayerFrame(80);
    GAME_OVER.continueBtn.onRelease = function ()
    {
        GAME_OVER.gotoAndStop(1);
        startQuickKeys();
        ENGINE.getRoomMovieClip().filters = [];
        SHELL.sendJoinRoom("town", 0, 0);
    };
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
    SHELL.addListener(SHELL.UPDATE_PLAYER, handleUpdatePlayer);
    SHELL.addListener(SHELL.UPDATE_CHAT_LOG, handleUpdateLog);
    SHELL.addListener(SHELL.LOAD_PLAYER_OBJECT, handleLoadPlayerObject);
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
System.security.allowDomain("me.mirai.so");
System.security.allowDomain("media.mirai.so");
System.security.allowDomain("play.mirai.so");
System.security.allowDomain("mirai.so");
System.security.allowDomain("team.mirai.so");
System.security.allowDomain("play.team.mirai.so");
var SHELL;
var ENGINE;
var currentlyRemoving = undefined;
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
var MAP_ICON = interface_mc.icons_mc.map_mc;
var STORE_ICON = interface_mc.icons_mc.store_mc;
var CAMERA_ICON = interface_mc.icons_mc.camera_mc;
var TRANS_ICON = interface_mc.icons_mc.transform_mc;
var MOD_ICON = interface_mc.icons_mc.mod_mc;
var PHONE_ICON = interface_mc.icons_mc.phone_mc;
var EGG_TIMER_ICON = interface_mc.icons_mc.egg_timer_mc;
var CROSSHAIR = interface_mc.crosshair_mc;
CROSSHAIR._visible = false;
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
var enablePP = true;
var is_log_open = false;
LOG.tab_btn.onRelease = updateLog;
LOG.tab_btn.onPress = dragLog;
LOG.menu_mc.item_mc._visible = false;
var mainCategoryIDToCategoryClipFrameName = {};
mainCategoryIDToCategoryClipFrameName.catgegory7 = "activities";
mainCategoryIDToCategoryClipFrameName.catgegory5 = "events";
mainCategoryIDToCategoryClipFrameName.catgegory8 = "games";
var buddy_request_list = new Array();
var buddy_request_item = new Object();
var active_buddy_request;
var last_new_total = 0;
var killedInt = undefined;
MAIL_ICON.new_mc._visible = false;
interface_mc.icons_mc.killedBox._visible = false;
var GAME_OVER = interface_mc.gameOver;
var EMOTE_MENU = interface_mc.emote_menu_mc;
var ACTION_MENU = interface_mc.action_menu_mc;
var AMMO_MENU = interface_mc.ammo_menu_mc;
var SAFE_MENU = interface_mc.safe_menu_mc;
var BUDDY_WIDGET = interface_mc.widgets_mc.buddy_mc;
var BUDDY_TOTAL_TEXT = BUDDY_WIDGET.art_mc.buddy_total_txt;
var MAX_BUDDIES_PER_PAGE = 5;
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
var myCurrentSnowball = 0;
var ammo = {white: 0, yellow: 0, red: 0, healer: 0};
var amIAccurate = false;
var armour = 0;
var myHealthTotal = 100;
var myHealthOutOf = 100;
var myScore = 0;
