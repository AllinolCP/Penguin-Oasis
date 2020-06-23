function handleStartEngine()
{
} // End of the function
function handleUpdateShellState(event)
{
    if (event.state == SHELL.PLAY_STATE)
    {
        startMouse();
    }
    else
    {
        stopMouse();
    } // end else if
    if (event.state == SHELL.EDIT_STATE)
    {
        puffleManager.cancelAllPuffleInteractions();
    } // end if
} // End of the function
function handleAddPlayer(event)
{
    if (!SHELL.isMyPlayer(event.player_id) && isRoomReady())
    {
        addPlayer(event);
    } // end if
} // End of the function
function handleRemovePlayer(playerID)
{
    if (!SHELL.isMyPlayer(playerID))
    {
        removePlayer(playerID);
    } // end if
} // End of the function
function sendPlayerMove(x, y, is_trigger, frame)
{
    var _loc3 = SHELL.getMyPlayerId();
    var _loc5 = getPlayerMovieClip(_loc3);
    var _loc7 = Math.round(_loc5._x);
    var _loc9 = Math.round(_loc5._y);
    var _loc4 = findPlayerPath(_loc3, x, y);
    var _loc2 = _loc4.x;
    var _loc1 = _loc4.y;
    var _loc6 = findDistance(_loc7, _loc9, _loc2, _loc1);
    if (_loc6 > 10)
    {
        setPlayerAction("move");
        movePlayer(_loc3, _loc2, _loc1, is_trigger, frame);
        SHELL.sendPlayerMove(_loc2, _loc1);
    }
    else if (frame != undefined)
    {
        SHELL.sendPlayerFrame(frame);
    } // end else if
} // End of the function
function handlePlayerMove(player_ob)
{
    var _loc1 = player_ob.player_id;
    if (!SHELL.isMyPlayer(_loc1) || player_ob.externallyMoved == true)
    {
        var _loc4 = player_ob.x;
        var _loc5 = player_ob.y;
        var _loc3 = findPlayerPath(_loc1, _loc4, _loc5);
        var _loc7 = _loc3.x;
        var _loc6 = _loc3.y;
        movePlayer(_loc1, _loc7, _loc6);
    } // end if
} // End of the function
function handleRequestPuffleMove(event)
{
    var _loc1 = puffleManager.getRandomSafeZonePoint();
    SHELL.sendPuffleMove(event.id, _loc1.x, _loc1.y);
} // End of the function
function handlePuffleMove(event)
{
    var _loc2 = new flash.geom.Point(event.x, event.y);
    puffleManager.movePuffleToPointByID(event.id, _loc2, event.happy);
} // End of the function
function handlePuffleInteraction(event)
{
    if (event.id == undefined)
    {
        return;
    } // end if
    if (event.interactionType == undefined)
    {
        return;
    } // end if
    var _loc2 = IGLOO.getFurnitureOnPointByType(new flash.geom.Point(event.x, event.y), event.interactionType);
    if (_loc2 == undefined)
    {
        SHELL.sendPuffleInteraction(false, event.id, event.interactionType, event.x, event.y);
        return;
    } // end if
    puffleManager.makePuffleInteractWithFurnitureByID(event.id, _loc2);
} // End of the function
function handlePuffleWalk(event)
{
    if (event.isWalking)
    {
        puffleManager.walkPuffleByID(event.id);
    }
    else
    {
        puffleManager.stopWalkingPuffleByID(event.id);
    } // end else if
} // End of the function
function sendPlayerAction(frame)
{
    if (frame == 64)
    {
        return (false);
    } // end if
    if (frame == 73)
    {
        return (false);
    } // end if
    var _loc2 = SHELL.getMyPlayerId();
    updatePlayerFrame(_loc2, frame, true);
    setPlayerAction("custom");
    SHELL.sendPlayerAction(frame);
} // End of the function
function handlePlayerAction(ob)
{
    var _loc1 = ob.player_id;
    var _loc2 = ob.frame;
    if (!SHELL.isMyPlayer(_loc1))
    {
        updatePlayerFrame(_loc1, _loc2, true);
    } // end if
} // End of the function
function sendPlayerSitDown()
{
    sendPlayerFrame(getPlayerDirectionToMouse() + 16);
} // End of the function
function sendPlayerWaddler()
{
    sendPlayerFrame(getPlayerDirectionToMouse() + 8);
} // End of the function
function sendPlayerFrame(frame)
{
    if (frame == 64)
    {
        return (false);
    } // end if
    if (frame == 73)
    {
        return (false);
    } // end if
    var _loc2 = SHELL.getMyPlayerId();
    updatePlayerFrame(_loc2, frame);
    setPlayerAction("custom");
    SHELL.sendPlayerFrame(frame);
} // End of the function
function handlePlayerFrame(ob)
{
    var _loc1 = ob.player_id;
    var _loc2 = ob.frame;
    if (!SHELL.isMyPlayer(_loc1))
    {
        if (validateUpdateFrame(_loc1, _loc2))
        {
            updatePlayerFrame(_loc1, _loc2);
        }
        else
        {
            framesRequestedAfterMove[_loc1] = _loc2;
            SHELL.addListener(SHELL.PLAYER_MOVE_DONE, handleUpdateFrameAfterMove);
        } // end if
    } // end else if
} // End of the function
function handleUpdateFrameAfterMove(event)
{
    if (event == undefined)
    {
        return;
    } // end if
    updatePlayerFrame(event.player_id, framesRequestedAfterMove[event.player_id]);
    delete framesRequestedAfterMove[event.player_id];
    SHELL.removeListener(SHELL.PLAYER_MOVE_DONE, handleUpdateFrameAfterMove);
} // End of the function
function handlePuffleFrame(event)
{
    puffleManager.updatePuffleFrameByID(event.id, event.frame);
} // End of the function
function sendThrowBall(x, y)
{
    setPlayerAction("throw");
    throwBallOverride(SHELL.getMyPlayerId(), x, y, -6, -100, 20);
    SHELL.sendThrowBall(x, y);
} // End of the function
function handleThrowBall(ob)
{
    if (SHELL.disableSnowballs == true)
    {
        return (false);
    } // end if
    var _loc1 = ob.player_id;
    var _loc5 = SHELL.getPlayerObjectById(_loc1);
    _loc5.thrownSnowballInCurrentRoom = true;
    if (!SHELL.isMyPlayer(_loc1))
    {
        var _loc3 = ob.x;
        var _loc4 = ob.y;
        throwBallOverride(_loc1, _loc3, _loc4, -6, -100, 20);
    } // end if
} // End of the function
function handleUpdatePlayer(player_ob)
{
    updatePlayer(player_ob);
} // End of the function
function sendOpenBook(book_id)
{
    setPlayerAction("reading");
    loadPlayerBook(SHELL.getMyPlayerId(), book_id);
    SHELL.sendOpenBook(book_id);
} // End of the function
function handleOpenBook(player_id, book_id)
{
    if (!SHELL.isMyPlayer(player_id))
    {
        loadPlayerBook(player_id, book_id);
    } // end if
} // End of the function
function sendCloseBook(biString)
{
    setPlayerAction("wait");
    removePlayerBook(SHELL.getMyPlayerId());
    SHELL.sendCloseBook(biString);
} // End of the function
function handleCloseBook(player_id)
{
    if (!SHELL.isMyPlayer(player_id))
    {
        removePlayerBook(player_id);
    } // end if
} // End of the function
function sendJoinRoom(name, x, y)
{
    SHELL.sendJoinRoom(name, x, y);
} // End of the function
function sendGameOver(score, room)
{
    INTERFACE.showPrompt("wait");
    setGameOverRoom(room);
    SHELL.sendGameOver(score);
} // End of the function
function sendJoinGameOverRoom()
{
    var _loc1 = getGameOverRoom();
    if (_loc1 != undefined)
    {
        sendJoinRoom(_loc1, 0, 0);
    }
    else
    {
        sendJoinLastRoom();
    } // end else if
} // End of the function
function sendJoinLastRoom()
{
    SHELL.sendJoinLastRoom();
} // End of the function
function handleJoinRoom()
{
    var _loc1 = SHELL.getRoomObject();
    stopMouse();
    loadRoom(_loc1, false);
} // End of the function
function handleRefreshRoom()
{
    if (!forceReloadRoomOnRefresh)
    {
        return;
    } // end if
    var _loc1 = SHELL.getRoomObject();
    reloadRoom(_loc1);
    forceReloadRoomOnRefresh = true;
} // End of the function
function handleJoinPlayerIgloo()
{
    var _loc1 = SHELL.getPlayerIglooObject();
    stopMouse();
    loadRoom(_loc1, true);
} // End of the function
function handleJoinGame()
{
    var _loc1 = SHELL.getGameObject();
    stopMouse();
    loadGame(_loc1);
} // End of the function
function handleAddPuffle(event)
{
    puffleManager.addPuffleData(event);
} // End of the function
function loadRoom(room_ob, is_player_room)
{
    __isPlayerRoom = is_player_room;
    setRoomReady(false);
    if (is_player_room == undefined)
    {
        is_player_room = false;
    } // end if
    var _loc4 = room_ob.name;
    var _loc3 = room_ob.path;
    removeRoom();
    removeGame();
    this.createEmptyMovieClip("room_mc", 100);
    room_mc.createEmptyMovieClip("load_mc", 1);
    var _loc7 = SHELL.getLocalizedString("load_" + _loc4);
    SHELL.showLoading(_loc7, listener);
    var _loc6 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc3);
    var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, mx.utils.Delegate.create(this, onRoomLoadError));
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onRoomLoadInit));
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, mx.utils.Delegate.create(this, onRoomLoadProgress));
    _loc2.loadClip(_loc6, room_mc.load_mc);
} // End of the function
function reloadRoom(room_ob)
{
    setRoomReady(false);
    if (is_player_room == undefined)
    {
        is_player_room = false;
    } // end if
    var _loc4 = room_ob.name;
    var _loc3 = room_ob.path;
    this.createEmptyMovieClip("room_mc", 100);
    room_mc.createEmptyMovieClip("load_mc", 1);
    var _loc6 = SHELL.getLocalizedString("load_" + _loc4);
    SHELL.showLoading(_loc6, listener);
    var _loc5 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc3);
    var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, mx.utils.Delegate.create(this, onRoomLoadError));
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onRoomLoadInit));
    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, mx.utils.Delegate.create(this, onRoomLoadProgress));
    _loc2.loadClip(_loc5, room_mc.load_mc);
} // End of the function
function onRoomLoadError(event)
{
} // End of the function
function onRoomLoadProgress(event)
{
    var _loc2 = Math.floor(event.bytes_loaded / event.bytes_total * 100);
} // End of the function
function onRoomLoadInit(event)
{
    var _loc1 = event.target;
    _loc1._lockroot = true;
    if (!__isPlayerRoom)
    {
        setupRoom(_loc1);
    }
    else
    {
        IGLOO = _loc1;
        SHELL.setGlobalIgloo(IGLOO);
        IGLOO.setDependencies(SHELL, INTERFACE, ENGINE);
        IGLOO.init();
    } // end else if
} // End of the function
function setupRoom(mc)
{
    var _loc4;
    if (mc.room_mc != undefined)
    {
        _loc4 = mc.room_mc;
        _loc4.start_x = mc.start_x;
        _loc4.start_y = mc.start_y;
    }
    else
    {
        _loc4 = mc;
    } // end else if
    setRoomMovieClip(_loc4);
    for (var _loc6 in mc)
    {
        if (typeof(mc[_loc6]) == "movieclip")
        {
            var _loc2 = mc[_loc6];
            if (_loc2 == mc.block_mc)
            {
                setRoomBlockMovieClip(_loc2);
                _loc2._visible = false;
                continue;
            } // end if
            if (_loc2 == mc.triggers_mc)
            {
                setRoomTriggersMovieClip(_loc2);
                _loc2._visible = false;
                continue;
            } // end if
            if (_loc2 == mc.interface_mc)
            {
                setRoomInterfaceMovieClip(_loc2);
                _loc2.swapDepths(900002);
                continue;
            } // end if
            if (_loc2 == mc.foreground_mc)
            {
                _loc2.swapDepths(900001);
                continue;
            } // end if
            if (_loc2 == mc.background_mc)
            {
                _loc2._visible = true;
                continue;
            } // end if
            if (_loc2._x > 0 && _loc4._x < MAX_SCREEN_WIDTH)
            {
                if (_loc2._y > 0 && _loc4._y < MAX_SCREEN_HEIGHT)
                {
                    updateObjectDepth(_loc2);
                } // end if
            } // end if
        } // end if
    } // end of for...in
    setRoomReady(true);
    setupTables();
    setupWaddle();
    setupPlayer();
    SHELL.startRoomMusic();
    _loc4.startRoom();
    if (_global.getCurrentShell().disabledAreaRoom != 0 && _global.getCurrentShell().getCurrentRoomId() == _global.getCurrentShell().disabledAreaRoom)
    {
        var _loc5 = _loc6;
        _loc5.disabledArea.removeMovieClip();
        _loc5.createEmptyMovieClip("disabledArea", 100);
        com.clubpenguin.util.DrawUtil.drawCircle(_loc5.disabledArea, new flash.geom.Point(0, 0), 50, 16711680, 16711680, 1);
        _loc5.disabledArea._alpha = 50;
        _loc5.disabledArea._x = _global.getCurrentShell().disabledArea[0];
        _loc5.disabledArea._y = _global.getCurrentShell().disabledArea[1];
        _loc5.disabledArea.onRelease = function ()
        {
            _global.getCurrentShell().handleShowPrompt([-1, 2]);
            return (false);
        };
        _loc5.disabledArea.useHandCursor = false;
    } // end if
    SHELL.roomInitiated();
    puffleManager.setupPathEngine();
    puffleManager.clearPuffles();
} // End of the function
function removeRoom()
{
    room_mc.load_mc.destroyRoom();
    SHELL.roomDestroyed();
    room_mc.removeMovieClip();
    for (var _loc2 in INTERFACE.nicknames_mc)
    {
        var _loc1 = INTERFACE.nicknames_mc[_loc2];
        if (_loc1._parent == INTERFACE.nicknames_mc)
        {
            _loc1.removeMovieClip();
        } // end if
    } // end of for...in
} // End of the function
function checkTrigger(mc)
{
    var _loc2 = getRoomTriggersMovieClip();
    var _loc4 = mc._x;
    var _loc5 = mc._y;
    var _loc1;
    if (_loc2.hitTest(_loc4, _loc5, true))
    {
        for (var _loc6 in _loc2)
        {
            _loc1 = _loc2[_loc6];
            if (_loc1.hitTest(_loc4, _loc5, true))
            {
                if (_loc1._name.indexOf(EPF_TRIGGER_PREFIX) >= 0)
                {
                    var _loc3 = _loc1._name.split(TRIGGER_NAME_SEPARATOR);
                    fieldOpTriggered.dispatch(_loc3[1]);
                }
                else
                {
                    _loc2[_loc6].triggerFunction();
                } // end else if
                break;
            } // end if
        } // end of for...in
    } // end if
} // End of the function
function setRoomMovieClip(mc)
{
    my_room_movieclips.room_mc = mc;
} // End of the function
function hideRoomWithBitmap(depth)
{
    var _loc2 = new flash.display.BitmapData(Stage.width, Stage.height);
    _loc2.draw(getRoomMovieClip());
    bitmapClip = this.createEmptyMovieClip("bitmapClip", bitmapClip.getNextHighestDepth());
    bitmapClip.attachBitmap(_loc2, depth, "never", true);
} // End of the function
function removeRoomBitmap()
{
    bitmapClip.removeMovieClip();
    bitmapClip = null;
} // End of the function
function hideAndUnloadRoomMovieClip()
{
    if (my_room_movieclips.room_mc)
    {
        var _loc1 = my_room_movieclips.room_mc.getDepth();
        hideRoomWithBitmap(_loc1);
        my_room_movieclips.room_mc.removeMovieClip();
    } // end if
} // End of the function
function getRoomMovieClip()
{
    return (my_room_movieclips.room_mc);
} // End of the function
function getRoomWaypointsClip()
{
    return (getRoomMovieClip()._parent.waypointsClip);
} // End of the function
function getPuffleSafeZoneClip()
{
    return (getRoomMovieClip()._parent.pet_area);
} // End of the function
function setRoomInterfaceMovieClip(mc)
{
    my_room_movieclips.interface_mc = mc;
} // End of the function
function getRoomInterfaceMovieClip()
{
    return (my_room_movieclips.interface_mc);
} // End of the function
function setRoomTriggersMovieClip(mc)
{
    my_room_movieclips.triggers_mc = mc;
} // End of the function
function getRoomTriggersMovieClip()
{
    return (my_room_movieclips.triggers_mc);
} // End of the function
function setRoomBlockMovieClip(mc)
{
    my_room_movieclips.block_mc = mc;
} // End of the function
function getRoomBlockMovieClip()
{
    return (my_room_movieclips.block_mc);
} // End of the function
function setRoomBallMovieClip(mc)
{
    my_room_movieclips.ball_mc = mc;
    is_ball_moving = false;
} // End of the function
function getRoomBallMovieClip()
{
    return (my_room_movieclips.ball_mc);
} // End of the function
function setRoomReady(is_ready)
{
    is_room_ready = is_ready;
} // End of the function
function isRoomReady()
{
    return (is_room_ready);
} // End of the function
function LEGACY_showWindow(name, ob, room_id)
{
    if (name == "Found Item")
    {
        INTERFACE.buyInventory(ob.ItemId);
    }
    else if (room_id != undefined)
    {
        var _loc2 = SHELL.getRoomNameById(room_id);
        sendGameOver(ob.score, _loc2);
    }
    else
    {
        sendGameOver(ob.score);
    } // end else if
} // End of the function
function LEGACY_checkPlayerItem(item_id)
{
    return (SHELL.isItemInMyInventory(item_id));
} // End of the function
function LEGACY_joinRoom()
{
    SHELL.sendJoinLastRoom();
} // End of the function
function loadGame(game_ob)
{
    var _loc4 = game_ob.path;
    var _loc7 = game_ob.name;
    removeRoom();
    removeGame();
    setGameOverRoom(undefined);
    this.createEmptyMovieClip("game_mc", 100);
    game_mc.createEmptyMovieClip("load_mc", 1);
    game_mc._lockroot = true;
    game_mc.myCrumbs = new Object();
    game_mc.myCrumbs.colors = SHELL.getPlayerColoursObject();
    var _loc2 = SHELL.getPlayerObjectById(SHELL.getMyPlayerId());
    game_mc.myPlayer = new Object();
    game_mc.myPlayer.Colour = _loc2.colour_id;
    game_mc.myPlayer.Hand = _loc2.hand;
    game_mc.myMediaPath = SHELL.getGamesPath().split("/").slice(0, -2).join("/") + "/";
    game_mc.checkPlayerItem = LEGACY_checkPlayerItem;
    game_mc.showWindow = LEGACY_showWindow;
    game_mc.joinRoom = LEGACY_joinRoom;
    var loader = new MovieClipLoader();
    var _loc3 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc4);
    loader.loadClip(_loc3, game_mc.load_mc);
    var listener = new Object();
    listener.onLoadProgress = function (target_mc, bytes_loaded, bytes_total)
    {
        var _loc1 = Math.floor(bytes_loaded / bytes_total * 100);
        WINDOW.progressbar_mc.gotoAndStop(_loc1);
    };
    listener.onLoadInit = function (target_mc)
    {
        loader.removeListener(listener);
        SHELL.hideLoading();
        SHELL.startGameMusic();
    };
    var _loc5 = SHELL.getLocalizedString("load_" + SHELL.getGameCrumbsKeyById(SHELL.getCurrentRoomId()));
    SHELL.showLoading(_loc5, listener);
    loader.addListener(listener);
    __listener = listener;
    if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3())
    {
        clearInterval(__progressInterval);
        __progressInterval = setInterval(trackProgress, PROGRESS_RATE, this.game_mc.load_mc);
    } // end if
} // End of the function
function trackProgress(mc)
{
    if (mc.getBytesLoaded() == mc.getBytesTotal() && mc.getBytesTotal() > 4)
    {
        __listener.onLoadInit(mc);
        clearInterval(__progressInterval);
    } // end if
    __listener.onLoadProgress(mc, mc.getBytesLoaded(), mc.getBytesTotal());
} // End of the function
function sendJoinGame(name, is_prompt)
{
    if (is_prompt)
    {
        setActiveGame(name);
        var _loc2 = SHELL.getLocalizedString(name + "_prompt");
        INTERFACE.showPrompt("game", _loc2, undefined, clickJoinGamePrompt);
    }
    else
    {
        SHELL.sendJoinGame(name);
    } // end else if
} // End of the function
function clickJoinGamePrompt()
{
    var _loc1 = getActiveGame();
    sendJoinGame(_loc1, false);
} // End of the function
function handleGameOver(ob)
{
    traceObject(ob);
    var _loc2 = ob.is_table;
    if (_loc2)
    {
        ob.activeTable = getActiveTable();
        game_over_object = ob;
    }
    else
    {
        INTERFACE.showEndGameScreen(ob, null, null, false);
    } // end else if
} // End of the function
function showGameOver()
{
    INTERFACE.showEndGameScreen(game_over_object, null, null, false);
} // End of the function
function removeGame()
{
    game_mc.removeMovieClip();
} // End of the function
function setActiveGame(name)
{
    active_game = name;
} // End of the function
function getActiveGame()
{
    return (active_game);
} // End of the function
function setGameOverRoom(name)
{
    game_over_room = name;
} // End of the function
function getGameOverRoom()
{
    return (game_over_room);
} // End of the function
function setupPlayer()
{
    var _loc2 = SHELL.getMyPlayerId();
    var _loc1 = SHELL.getPlayerObjectById(_loc2);
    achievementManager.deleteAllEarnedAchievements();
    setupDepthList();
    add_more_players = true;
    addPlayer(_loc1, _loc1.x, _loc1.y);
    startMouse();
    SHELL.getStampManager().checkForEPFFieldOpsMedalStamps(null);
} // End of the function
function setupDepthList()
{
    if (speechBubbleDepths == null)
    {
        speechBubbleDepths = new Array(SPEECH_BUBBLE_DEPTH_ARRAY_SIZE);
        for (var _loc1 = 0; _loc1 < SPEECH_BUBBLE_DEPTH_ARRAY_SIZE; ++_loc1)
        {
            speechBubbleDepths[_loc1] = {playerID: SPEECH_BUBBLE_DEPTH_EMPTY_VALUE, depth: _loc1};
        } // end of for
    }
    else
    {
        for (var _loc1 = 0; _loc1 < SPEECH_BUBBLE_DEPTH_ARRAY_SIZE; ++_loc1)
        {
            speechBubbleDepths[_loc1].playerID = SPEECH_BUBBLE_DEPTH_EMPTY_VALUE;
            speechBubbleDepths[_loc1].depth = _loc1;
        } // end of for
    } // end else if
} // End of the function
function addPlayer(player_ob, targetX, targetY)
{
    var _loc5 = getRoomMovieClip();
    var _loc24 = getRoomBlockMovieClip();
    var _loc7 = player_ob.player_id;
    var _loc12 = player_ob.nickname;
    removePlayer(_loc7);
    var _loc13 = addPlayerDepth(_loc7);
    var _loc11 = "p" + String(_loc7);
    var _loc4 = INTERFACE.nicknames_mc.attachMovie("nickname", _loc11, _loc13, {_x: targetX, _y: targetY, _visible: false});
    var _loc9 = INTERFACE.nicknames_mc[_loc11].name_txt;
    _loc9.text = _loc12;
    _loc9.textColor = 0;
    _loc5.createEmptyMovieClip(_loc11, _loc13);
    var _loc3 = _loc5[_loc11];
    _loc3.createEmptyMovieClip("art_mc", 1);
    _loc3._visible = true;
    _loc3.mc.art_mc._visible = true;
    _loc3.createEmptyMovieClip("book_mc", 70);
    _loc3.createEmptyMovieClip("head_mc", 60);
    _loc3.createEmptyMovieClip("face_mc", 50);
    _loc3.createEmptyMovieClip("hand_mc", 40);
    _loc3.createEmptyMovieClip("neck_mc", 30);
    _loc3.createEmptyMovieClip("body_mc", 20);
    _loc3.createEmptyMovieClip("feet_mc", 10);
    _loc3.colour_id = 0;
    _loc3.head = 0;
    _loc3.face = 0;
    _loc3.neck = 0;
    _loc3.body = 0;
    _loc3.hand = 0;
    _loc3.feet = 0;
    _loc3.player_id = _loc7;
    _loc3.nickname = _loc12;
    _loc3.depth_id = _loc13;
    _loc3.frame = player_ob.frame;
    _loc3.is_moving = false;
    _loc3.is_ready = false;
    _loc3.is_reading = false;
    _loc3.is_table = false;
    _loc3.account_permissions = player_ob.account_permissions;
    _loc3.char_permissions = player_ob.char_permissions;
    _loc3.player_attributes = player_ob.player_attributes;
    _loc3.characterId = player_ob.characterId;
    _loc3.is_involved_in_event = player_ob.is_involved_in_event;
    _loc3.has_special_event_permission = player_ob.has_special_event_permission;
    if (!SHELL.isLag)
    {
        if (_loc3.player_attributes.x != 0 && SHELL.transformations[_loc3.characterId] == undefined)
        {
            switch (_loc3.player_attributes.x)
            {
                case 1:
                {
                    _loc3._xscale = 60;
                    _loc3._yscale = 60;
                    var _loc8 = new TextFormat();
                    _loc8.size = 8;
                    _loc4.name_txt.setTextFormat(_loc8);
                    _loc4._y = _loc4._y - 25;
                    break;
                } 
                case 2:
                {
                    _loc3._xscale = 40;
                    _loc3._yscale = 40;
                    _loc8 = new TextFormat();
                    _loc8.size = 8;
                    _loc4.name_txt.setTextFormat(_loc8);
                    _loc4._y = _loc4._y + 50;
                    break;
                } 
            } // End of switch
        } // end if
        if (_loc3.player_attributes.n[1] != "0" && _loc3.player_attributes.n[1] != "" && _loc3.player_attributes.n[1] != undefined)
        {
            _loc9.textColor = "0x" + _loc3.player_attributes.n[1];
        } // end if
        var _loc18 = String("0x") + String(_loc3.player_attributes.n[0]);
        if (_loc3.player_attributes.n[0] != "0" && _loc3.player_attributes.n[0] != "" && _loc3.player_attributes.n[0] != undefined)
        {
            _loc9.filters = [new flash.filters.GlowFilter(_loc18, 10, 1.700000, 1.700000, 15, 3, false, false)];
        } // end if
    } // end if
    if (_loc3.nickname == "SBNPC" || _loc3.nickname == "Monster")
    {
        _loc3._xscale = 300;
        _loc3._yscale = 300;
        _loc3.nickname = "Monster";
        _loc9.text = "Monster";
        var _loc15 = new flash.filters.ColorMatrixFilter();
        cm = new com.gskinner.geom.ColorMatrix();
        cm.adjustHue(88);
        _loc15.matrix = cm;
        _loc3.art_mc.filters = [_loc15];
        _loc3.art_mc.ring._visible = true;
        var _loc17 = new Color(_loc3.art_mc.ring);
        _loc17.setRGB(16711680);
    } // end if
    var _loc10 = null;
    if (_loc5.invertedPenguins)
    {
        _loc3._rotation = -180;
        _loc4._y = _loc4._y - 45;
    }
    else if (SHELL.isPlayerMascotById(_loc7) && _loc5.customMascotSize != undefined)
    {
        _loc10 = _loc5.customMascotSize;
    }
    else if (_loc5.isSmallPenguin)
    {
        _loc10 = SMALL_PENGUIN_SIZE;
    }
    else if (_loc5.isMediumPenguin)
    {
        _loc10 = MEDIUM_PENGUIN_SIZE;
    }
    else if (_loc5.customPenguinSize != undefined)
    {
        _loc10 = _loc5.customPenguinSize;
    } // end else if
    if (_loc10 != null)
    {
        _loc3._xscale = _loc10;
        _loc3._yscale = _loc10;
        if (_loc10 < 100)
        {
            _loc4._y = _loc4._y - 25;
        } // end if
    } // end if
    _loc3.onRelease = com.clubpenguin.util.Delegate.create(this, clickPlayer, _loc7, _loc12);
    if (SHELL.isMyPlayer(_loc7))
    {
        var _loc19 = SHELL.getLocalizedString("load_penguin");
        SHELL.showLoading(_loc19, listener);
    } // end if
    var _loc14 = SHELL.getPath("penguin");
    if (_loc3.characterId != "" && SHELL.isLag == false)
    {
        if (SHELL.transformations[_loc3.characterId] != undefined)
        {
            _loc14 = _global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + "/play/v2/content/global/avatar/sprites/" + _loc3.characterId + ".swf";
            if (SHELL.transformations[_loc3.characterId] == false)
            {
                _loc3._xscale = 60;
                _loc3._yscale = 60;
            } // end if
        } // end if
    } // end if
    var _loc16 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc14);
    _loc10 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    _loc10.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onPlayerLoadInit, player_ob, _loc7, targetX, targetY));
    _loc10.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, onPlayerLoadStart, target_mc));
    _loc10.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, onPlayerLoadProgress, target_mc));
    _loc10.loadClip(_loc16, _loc3.art_mc);
    _loc3.art_mc.ring._visible = false;
    if (!SHELL.isLag)
    {
        if (_loc3.player_attributes.r != undefined && _loc3.player_attributes.r != "" && _loc1.player_attributes.r.length >= 3)
        {
            _loc3.art_mc.ring._visible = true;
            _loc17 = new Color(_loc3.art_mc.ring);
            _loc17.setRGB("0x" + _loc3.player_attributes.r);
        }
        else
        {
            _loc3.art_mc.ring._visible = false;
        } // end if
    } // end else if
} // End of the function
function onPlayerLoadStart(event)
{
    event.target._visible = false;
} // End of the function
function onPlayerLoadProgress(event)
{
    var _loc1 = event.target;
    SHELL.loadingScreenLoadProgress(_loc1, _loc1.getBytesLoaded(), _loc1.getBytesTotal());
} // End of the function
function onPlayerLoadError(target_mc)
{
} // End of the function
function onPlayerLoadInitTransform(event, player_ob, player_id, targetX, targetY)
{
    var _loc1 = event.target;
    updatePlayerFromId(_loc1._parent.player_id);
    checkTablesForPlayer(_loc1._parent.player_id);
    _loc1._parent.is_ready = true;
    _loc1._visible = true;
    _loc1.stopAllSounds();
    var _loc2 = getNicknameMovieClip(player_id);
    _loc2._visible = true;
} // End of the function
function onPlayerLoadInit(event, player_ob, player_id, targetX, targetY)
{
    var _loc4 = event.target;
    updatePlayerFromId(_loc4._parent.player_id);
    checkTablesForPlayer(_loc4._parent.player_id);
    if (SHELL.isMyPlayer(player_id))
    {
        addAllPlayers();
    } // end if
    _loc4._parent.is_ready = true;
    _loc4._visible = true;
    if (SHELL.isMyPlayer(player_id))
    {
        if (!SHELL.getIsRoomIgloo())
        {
            SHELL.hideLoading();
        } // end if
    } // end if
    if (player_ob.x == 0 && player_ob.y == 0)
    {
        var _loc6 = getRoomMovieClip().start_x;
        var _loc7 = getRoomMovieClip().start_y;
        var _loc5 = getRandomPlayerPos(player_ob, _loc6, _loc7, RANDOM_RANGE_FOR_MAP_ENTRY);
        updatePlayerPosition(player_id, _loc5.x, _loc5.y);
    }
    else if (isPositionValid(player_ob.x, player_ob.y) || _global.getCurrentShell().OasisPermission.hasPermission("char", player_ob.char_permissions, "wall_hack") == true && _global.getCurrentShell().getCurrentRoomId() != 605 && _global.getCurrentShell().getCurrentRoomId() != 807)
    {
        updatePlayerPosition(player_id, player_ob.x, player_ob.y);
    }
    else if (_global.getCurrentShell().getCurrentRoomId() == 807)
    {
        if (player_ob.is_involved_in_event == true)
        {
            updatePlayerPosition(player_id, player_ob.x, player_ob.y);
        } // end if
    }
    else if (_global.getCurrentShell().getCurrentRoomId() == 605)
    {
        if (player_ob.has_special_event_permission == true)
        {
            updatePlayerPosition(player_id, player_ob.x, player_ob.y);
        } // end if
    }
    else
    {
        _loc6 = getRoomMovieClip().start_x;
        _loc7 = getRoomMovieClip().start_y;
        _loc5 = getRandomPlayerPos(player_ob, _loc6, _loc7, RANDOM_RANGE_FOR_MAP_ENTRY);
        updatePlayerPosition(player_id, _loc5.x, _loc5.y);
    } // end else if
    var _loc8 = getNicknameMovieClip(player_id);
    _loc8._visible = true;
} // End of the function
function removePlayer(player_id)
{
    var _loc3 = getPlayerMovieClip(player_id);
    var _loc2 = getNicknameMovieClip(player_id);
    _loc3.removeMovieClip();
    _loc2.removeMovieClip();
    INTERFACE.removeBalloonByPlayerId(player_id);
    removePlayerDepth(player_id);
} // End of the function
function getRandomPlayerPos(player, x, y, range)
{
    var _loc6 = getRoomBlockMovieClip();
    for (var _loc1 = 0; _loc1 < MAX_RANDOMIZE_ATTEMPTS; ++_loc1)
    {
        var _loc2 = findRandomLocation(x, range);
        var _loc3 = findRandomLocation(y, range);
        var _loc4 = isPositionValid(_loc2, _loc3);
        if (_loc4)
        {
            return ({x: _loc2, y: _loc3});
        } // end if
    } // end of for
    return ({x: x, y: y});
} // End of the function
function isPositionValid(testX, testY)
{
    var _loc1 = getRoomBlockMovieClip();
    var _loc2 = isValidXPosition(testX) && isValidYPosition(testY) && !_loc1.hitTest(testX, testY, true);
    return (_loc2);
} // End of the function
function randomizeNearPosition(player, x, y, range)
{
    var _loc6 = getRoomBlockMovieClip();
    for (var _loc1 = 0; _loc1 < MAX_RANDOMIZE_ATTEMPTS; ++_loc1)
    {
        var _loc2 = findRandomLocation(x, range);
        var _loc3 = findRandomLocation(y, range);
        var _loc4 = isValidXPosition(_loc2) && isValidYPosition(_loc3) && !_loc6.hitTest(_loc2, _loc3, true);
        if (_loc4)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function hideAllPlayers()
{
    var _loc3 = getRoomMovieClip();
    var _loc1 = SHELL.getPlayerList();
    for (var _loc2 in _loc1)
    {
        getPlayerMovieClip(_loc1[_loc2].player_id)._visible = false;
    } // end of for...in
    INTERFACE.nicknames_mc._visible = false;
    INTERFACE.balloons_mc._visible = false;
} // End of the function
function showAllPlayers()
{
    var _loc3 = getRoomMovieClip();
    var _loc1 = SHELL.getPlayerList();
    for (var _loc2 in _loc1)
    {
        getPlayerMovieClip(_loc1[_loc2].player_id)._visible = true;
    } // end of for...in
    INTERFACE.nicknames_mc._visible = true;
    INTERFACE.balloons_mc._visible = true;
} // End of the function
function hideAllPlayerNames()
{
    hidingAllPlayerNames = true;
    INTERFACE.nicknames_mc._visible = false;
} // End of the function
function showAllPlayerNames()
{
    hidingAllPlayerNames = false;
    INTERFACE.nicknames_mc._visible = true;
} // End of the function
function isHidingAllPlayerNames()
{
    return (hidingAllPlayerNames);
} // End of the function
function addAllPlayers()
{
    if (add_more_players)
    {
        add_more_players = false;
        var _loc3 = SHELL.getPlayerList();
        for (var _loc6 in _loc3)
        {
            var _loc2 = _loc3[_loc6].player_id;
            var _loc1 = SHELL.getPlayerObjectById(_loc2);
            var _loc4 = _loc1.x;
            var _loc5 = _loc1.y;
            if (_loc2 != SHELL.getMyPlayerId())
            {
                addPlayer(_loc3[_loc6]);
            } // end if
        } // end of for...in
    } // end if
} // End of the function
function removeAllPlayers()
{
    var _loc2 = SHELL.getPlayerList();
    for (var _loc3 in _loc2)
    {
        var _loc1 = _loc2[_loc3].player_id;
        if (_loc1 != SHELL.getMyPlayerId())
        {
            removePlayer(_loc1);
        } // end if
    } // end of for...in
} // End of the function
function updatePlayerFromId(player_id)
{
    var _loc1 = SHELL.getPlayerObjectById(player_id);
    updatePlayer(_loc1);
} // End of the function
function updatePlayer(player_ob)
{
    traceObject(player_ob);
    var _loc4 = player_ob.player_id;
    var _loc1 = getPlayerMovieClip(_loc4);
    if (_loc1.frame > 26)
    {
        _loc1.frame = 1;
    } // end if
    if (_loc1.colour_id != player_ob.colour_id)
    {
        updateColour(_loc1.art_mc.body, player_ob.colour_id);
        _loc1.colour_id = player_ob.colour_id;
    } // end if
    updatePlayerItem(_loc1, player_ob, "head", 60);
    updatePlayerItem(_loc1, player_ob, "face", 50);
    updatePlayerItem(_loc1, player_ob, "hand", 40);
    updatePlayerItem(_loc1, player_ob, "neck", 30);
    updatePlayerItem(_loc1, player_ob, "body", 20);
    updatePlayerItem(_loc1, player_ob, "feet", 10);
    updatePlayerFrame(_loc4, _loc1.frame);
    _loc1.art_mc.ring._visible = false;
    if (!SHELL.isLag)
    {
        if (_loc1.player_attributes.r != undefined && _loc1.player_attributes.r != "" && _loc1.player_attributes.r.length >= 3)
        {
            _loc1.art_mc.ring._visible = true;
            var _loc7 = new Color(_loc1.art_mc.ring);
            _loc7.setRGB("0x" + _loc1.player_attributes.r);
        }
        else
        {
            _loc1.art_mc.ring._visible = false;
        } // end if
    } // end else if
    var _loc3 = _loc1;
    if (_loc3.nickname == "SBNPC" || _loc3.nickname == "Monster")
    {
        _loc3._xscale = 300;
        _loc3._yscale = 300;
        _loc3.nickname = "Monster";
        var _loc5 = new flash.filters.ColorMatrixFilter();
        cm = new com.gskinner.geom.ColorMatrix();
        cm.adjustHue(88);
        _loc5.matrix = cm;
        _loc3.art_mc.filters = [_loc5];
        _loc3.art_mc.ring._visible = true;
        var _loc6 = new Color(_loc3.art_mc.ring);
        _loc6.setRGB(16711680);
    } // end if
} // End of the function
function testForPenguinRing(art_clip)
{
    if (art_clip.ring != undefined)
    {
        art_clip.ring._visible = false;
        delete art_clip.onEnterFrame;
    } // end if
} // End of the function
function updateColour(mc, colour_id)
{
    var _loc1 = new Color(mc);
    _loc1.setRGB(SHELL.getPlayerHexFromId(colour_id));
} // End of the function
function addPlayerDepth(playerID)
{
    var _loc3 = SPEECH_BUBBLE_DEPTH_EMPTY_VALUE;
    if (playerID == SHELL.getMyPlayerId())
    {
        speechBubbleDepths[SPEECH_BUBBLE_DEPTH_LOCAL_INDEX].playerID = playerID;
        _loc3 = speechBubbleDepths[SPEECH_BUBBLE_DEPTH_LOCAL_INDEX].depth;
    }
    else
    {
        var _loc5 = findPlayerDepth(playerID);
        if (_loc5 == SPEECH_BUBBLE_DEPTH_EMPTY_VALUE)
        {
            for (var _loc1 = 0; _loc1 < SPEECH_BUBBLE_DEPTH_ARRAY_SIZE; ++_loc1)
            {
                var _loc2 = speechBubbleDepths[_loc1].playerID;
                if (_loc2 == SPEECH_BUBBLE_DEPTH_EMPTY_VALUE)
                {
                    speechBubbleDepths[_loc1].playerID = playerID;
                    _loc3 = speechBubbleDepths[_loc1].depth;
                    break;
                } // end if
            } // end of for
        }
        else
        {
            _loc3 = _loc5;
        } // end else if
    } // end else if
    return (_loc3);
} // End of the function
function findPlayerDepth(playerID)
{
    var _loc3 = SPEECH_BUBBLE_DEPTH_EMPTY_VALUE;
    if (playerID == SHELL.getMyPlayerId())
    {
        _loc3 = speechBubbleDepths[SPEECH_BUBBLE_DEPTH_LOCAL_INDEX].playerID;
    }
    else
    {
        for (var _loc1 = 0; _loc1 < SPEECH_BUBBLE_DEPTH_ARRAY_SIZE; ++_loc1)
        {
            var _loc2 = speechBubbleDepths[_loc1].playerID;
            if (_loc2 == playerID)
            {
                _loc3 = speechBubbleDepths[_loc1].depth;
                break;
                continue;
            } // end if
            if (_loc2 == SPEECH_BUBBLE_DEPTH_EMPTY_VALUE)
            {
                break;
            } // end if
        } // end of for
    } // end else if
    return (_loc3);
} // End of the function
function removePlayerDepth(playerID)
{
    for (var _loc1 = 0; _loc1 < SPEECH_BUBBLE_DEPTH_ARRAY_SIZE; ++_loc1)
    {
        var _loc3 = speechBubbleDepths[_loc1].playerID;
        if (_loc3 == playerID)
        {
            var _loc4 = speechBubbleDepths.splice(_loc1, 1);
            var _loc2 = _loc4[0];
            _loc2.playerID = SPEECH_BUBBLE_DEPTH_EMPTY_VALUE;
            speechBubbleDepths.splice(SPEECH_BUBBLE_DEPTH_LOCAL_INDEX - 1, 0, _loc2);
            break;
            continue;
        } // end if
        if (_loc3 == SPEECH_BUBBLE_DEPTH_EMPTY_VALUE)
        {
            break;
        } // end if
    } // end of for
} // End of the function
function updatePlayerItem(mc, ob, name, depth)
{
    if (SHELL.banned_items[ob[name]] != undefined)
    {
        ob[name] = 0;
    } // end if
    if (SHELL.banned_items[String(ob[name])] != undefined)
    {
        ob[name] = 0;
    } // end if
    if (ob[name] != mc[name])
    {
        removeMovieClip (mc[name + "_mc"]);
        mc.createEmptyMovieClip(name + "_mc", depth);
        loadPlayerItem(mc[name + "_mc"], ob[name]);
        mc[name] = ob[name];
    } // end if
} // End of the function
function loadPlayerItem(mc, item_id)
{
    if (item_id > 0)
    {
        if (SHELL.getInventoryObjectById(item_id).is_custom == true)
        {
            var _loc5 = _global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + "/play/v2/content/global/clothing/custom/sprites/" + item_id + ".swf";
        }
        else
        {
            _loc5 = SHELL.getPath("clothing_sprites") + item_id + ".swf";
        } // end else if
        mc._visible = false;
        var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, mx.utils.Delegate.create(this, onPlayerItemLoadComplete));
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onPlayerItemLoadInit));
        _loc3.loadClip(_loc5, mc);
    } // end if
} // End of the function
function onPlayerItemLoadComplete(event)
{
    event.target._visible = false;
} // End of the function
function onPlayerItemLoadInit(event)
{
    updatePlayerFrame(event.target._parent.player_id);
    event.target._visible = true;
} // End of the function
function headTest(target, f)
{
    target.gotoAndStop(f);
    delete target.onEnterFrame;
} // End of the function
function loadPlayerBook(player_id, book_id)
{
    var _loc1 = getPlayerMovieClip(player_id);
    if (book_id == undefined)
    {
        book_id = 1;
    } // end if
    if (_loc1.is_ready && !_loc1.is_moving)
    {
        var _loc4 = SHELL.getPath("clothing_book" + book_id);
        _loc1.book_mc.createEmptyMovieClip("load_mc", 1);
        var _loc3 = com.clubpenguin.util.URLUtils.getCacheResetURL(_loc4);
        _loc1.book_mc.load_mc.loadMovie(_loc3);
        _loc1.is_reading = true;
        updatePlayerFrame(player_id, 1);
    } // end if
} // End of the function
function removePlayerBook(player_id)
{
    var _loc1 = getPlayerMovieClip(player_id);
    removeMovieClip (_loc1.book_mc.load_mc);
    _loc1.is_reading = false;
} // End of the function
function updatePlayerPosition(player_id, x, y)
{
    var _loc1 = getPlayerMovieClip(player_id);
    var _loc5 = getBalloonMovieClip(player_id);
    var _loc6 = getNicknameMovieClip(player_id);
    x = getValidXPosition(x);
    y = getValidYPosition(y);
    _loc1._x = x;
    _loc1._y = y;
    _loc5._x = x;
    _loc5._y = y;
    _loc6._x = x;
    _loc6._y = y;
    updatePlayerDepth(_loc1, _loc1.depth_id);
    if (SHELL.isMyPlayer(player_id))
    {
        player_x = x;
        player_y = y;
    } // end if
} // End of the function
function updatePlayerFrame(player_id, frame, is_action)
{
    var _loc1 = getPlayerMovieClip(player_id);
    if (frame == undefined)
    {
        frame = _loc1.frame;
    } // end if
    if (frame == 25 || frame == 26)
    {
        var _loc2 = SHELL.getSecretFrame(player_id, frame);
    }
    else
    {
        _loc2 = frame;
    } // end else if
    _loc1.art_mc.gotoAndStop(1);
    _loc1.art_mc.gotoAndStop(_loc2);
    updateColour(_loc1.art_mc.body, _loc1.colour_id);
    updatePlayerItemFrame(_loc1.face_mc, _loc2);
    updatePlayerItemFrame(_loc1.neck_mc, _loc2);
    updatePlayerItemFrame(_loc1.body_mc, _loc2);
    updatePlayerItemFrame(_loc1.hand_mc, _loc2);
    updatePlayerItemFrame(_loc1.feet_mc, _loc2);
    updatePlayerItemFrame(_loc1.head_mc, _loc2);
    if (is_action)
    {
        _loc1.frame = 1;
    }
    else
    {
        _loc1.frame = frame;
    } // end else if
} // End of the function
function clickPlayer(player_id, nickname)
{
    INTERFACE.showPlayerWidget(player_id, nickname);
} // End of the function
function setPlayerAction(action)
{
    player_action = action;
} // End of the function
function getPlayerAction()
{
    return (player_action);
} // End of the function
function validateUpdateFrame(player_id, frame)
{
    var _loc1 = getPlayerMovieClip(player_id);
    if (_loc1.is_reading || _loc1.is_table)
    {
        return (false);
    }
    else if (frame > 8 && frame < 17)
    {
        return (false);
    }
    else if (frame < 27)
    {
        return (true);
    }
    else
    {
        return (false);
    } // end else if
    return (true);
} // End of the function
function updatePlayerItemFrame(mc, frame)
{
    mc.gotoAndStop(1);
    mc.gotoAndStop(frame);
} // End of the function
function getValidXPosition(x)
{
    if (x < MAP_WIDTH_MIN)
    {
        return (MAP_WIDTH_MIN);
    }
    else if (x > MAP_WIDTH_MAX)
    {
        return (MAP_WIDTH_MAX);
    }
    else
    {
        return (Math.round(x));
    } // end else if
} // End of the function
function getValidYPosition(y)
{
    if (y < MAP_HEIGHT_MIN)
    {
        return (MAP_HEIGHT_MIN);
    }
    else if (y > MAP_HEIGHT_MAX)
    {
        return (MAP_HEIGHT_MAX);
    }
    else
    {
        return (Math.round(y));
    } // end else if
} // End of the function
function isValidXPosition(x)
{
    if (x < MAP_WIDTH_MIN)
    {
        return (false);
    }
    else if (x > MAP_WIDTH_MAX)
    {
        return (false);
    }
    else
    {
        return (true);
    } // end else if
} // End of the function
function isValidYPosition(y)
{
    if (y < MAP_HEIGHT_MIN)
    {
        return (false);
    }
    else if (y > MAP_HEIGHT_MAX)
    {
        return (false);
    }
    else
    {
        return (true);
    } // end else if
} // End of the function
function getPlayerMovieClip(player_id)
{
    var _loc1 = getRoomMovieClip();
    return (_loc1["p" + player_id]);
} // End of the function
function getBalloonMovieClip(player_id)
{
    return (INTERFACE.balloons_mc["p" + player_id]);
} // End of the function
function getNicknameMovieClip(player_id)
{
    return (INTERFACE.nicknames_mc["p" + player_id]);
} // End of the function
function findRandomLocation(n, d)
{
    return (Math.floor(n + (random(d) - d / 2)));
} // End of the function
function showAllPuffles()
{
    puffleManager.showAllPuffles();
} // End of the function
function hideAllPuffles()
{
    puffleManager.hideAllPuffles();
} // End of the function
function startMouse()
{
    is_mouse_active = true;
    this.onMouseMove = function ()
    {
        if (getPlayerAction() == "wait")
        {
            var _loc1 = getPlayerDirectionToMouse();
            if (_loc1 != current_direction_to_mouse)
            {
                current_direction_to_mouse = _loc1;
                updatePlayerFrame(SHELL.getMyPlayerId(), _loc1);
            } // end if
        } // end if
    };
    mouse_mc.useHandCursor = false;
    mouse_mc.tabEnabled = false;
    mouse_mc.onRelease = clickMouse;
} // End of the function
function clickMouse()
{
    if (getPlayerAction() != "busy")
    {
        var _loc1 = Math.round(_xmouse);
        var _loc2 = Math.round(_ymouse);
        if (!isMouseOverInterface(_loc1, _loc2))
        {
            sendPlayerMove(_loc1, _loc2);
        } // end if
    } // end if
} // End of the function
function getPlayerDirectionToMouse()
{
    var _loc2 = Math.round(_xmouse);
    var _loc3 = Math.round(_ymouse) + 40;
    var _loc1 = findAngle(player_x, player_y, _loc2, _loc3);
    return (findDirection(_loc1));
} // End of the function
function stopMouse()
{
    is_mouse_active = false;
    this.onMouseMove = null;
    this.onMouseDown = null;
    mouse_mc.onRelease = null;
} // End of the function
function isMouseActive()
{
    return (is_mouse_active);
} // End of the function
function isMouseOverInterface(x, y)
{
    if (INTERFACE.interface_mc.hitTest(x, y, true))
    {
        return (true);
    }
    else if (INTERFACE.debug_mc.hitTest(x, y, true))
    {
        return (true);
    }
    else if (getRoomInterfaceMovieClip().hitTest(x, y, true))
    {
        return (true);
    }
    else if (debug_mc.hitTest(x, y, true))
    {
        return (true);
    }
    else
    {
        return (false);
    } // end else if
} // End of the function
function disableMouseMovement()
{
    isMouseMovementEnabled = false;
} // End of the function
function enableMouseMovement()
{
    isMouseMovementEnabled = true;
} // End of the function
function isMouseActive()
{
    return (is_mouse_active);
} // End of the function
function isMovementEnabled()
{
    return (isMouseMovementEnabled);
} // End of the function
function movePlayer(player_id, target_x, target_y, is_trigger, frame)
{
    var _loc2 = getRoomMovieClip();
    if (is_trigger == undefined)
    {
        is_trigger = true;
    } // end if
    var mc = getPlayerMovieClip(player_id);
    var start_x = Math.round(mc._x);
    var start_y = Math.round(mc._y);
    if (mc.is_reading)
    {
        removePlayerBook(player_id);
    } // end if
    if (!mc.is_ready)
    {
        updatePlayerPosition(player_id, target_x, target_y);
    }
    else
    {
        var _loc3 = findDistance(start_x, start_y, target_x, target_y);
        if (_loc2.ease_method == "easeInOutQuad")
        {
            var easeFunction = mathEaseInOutQuad;
        }
        else
        {
            var easeFunction = mathLinearTween;
        } // end else if
        var _loc4 = findAngle(start_x, start_y, target_x, target_y);
        var d = findDirection(_loc4);
        var duration = _loc3 / 4;
        if (Number(mc.player_attributes.s) == 1)
        {
            duration = duration / 4.500000;
        }
        else if (Number(mc.player_attributes.s) == 2)
        {
            updatePlayerPosition(player_id, target_x, target_y);
            mc.is_moving = false;
            if (SHELL.isMyPlayer(player_id))
            {
                playerMoved.dispatch();
                setPlayerAction("wait");
                if (is_trigger && isMouseActive())
                {
                    checkTrigger(mc);
                    checkFieldOpTriggered(mc);
                } // end if
                if (frame != undefined)
                {
                    sendPlayerFrame(frame);
                } // end if
            } // end if
            return (true);
        } // end else if
        var change_x = target_x - start_x;
        var change_y = target_y - start_y;
        mc.is_moving = true;
        updatePlayerFrame(player_id, d + 8);
        var t = 0;
        mc.onEnterFrame = function ()
        {
            ++t;
            if (t < duration)
            {
                x = easeFunction(t, start_x, change_x, duration);
                y = easeFunction(t, start_y, change_y, duration);
                updatePlayerPosition(player_id, x, y);
            }
            else
            {
                mc.is_moving = false;
                updatePlayerPosition(player_id, target_x, target_y);
                updatePlayerFrame(player_id, d);
                SHELL.sendPlayerMoveDone(player_id);
                this.onEnterFrame = null;
                delete this.onEnterFrame;
                if (SHELL.isMyPlayer(player_id))
                {
                    playerMoved.dispatch();
                    setPlayerAction("wait");
                    if (is_trigger && isMouseActive())
                    {
                        checkTrigger(mc);
                        checkFieldOpTriggered(mc);
                    } // end if
                    if (frame != undefined)
                    {
                        sendPlayerFrame(frame);
                    } // end if
                } // end if
            } // end else if
        };
    } // end else if
} // End of the function
function findPlayerPath(player_id, x, y)
{
    var _loc5 = getPlayerMovieClip(player_id);
    var _loc9 = getRoomBlockMovieClip();
    var _loc16 = getValidXPosition(x);
    var _loc15 = getValidYPosition(y);
    var _loc13 = Math.round(_loc5._x);
    var _loc12 = Math.round(_loc5._y);
    var _loc17 = findDistance(_loc13, _loc12, _loc16, _loc15);
    var _loc8 = Math.round(_loc17);
    var _loc10 = (_loc16 - _loc13) / _loc8;
    var _loc11 = (_loc15 - _loc12) / _loc8;
    var _loc6 = _loc13;
    var _loc7 = _loc12;
    var _loc2 = new Object();
    _loc2.x = _loc13;
    _loc2.y = _loc12;
    var _loc14 = _loc9.hitTest(_loc13, _loc12, true);
    if (_global.getCurrentShell().getCurrentRoomId() == 807)
    {
        if (_loc5.is_involved_in_event == true)
        {
            _loc14 = 0;
        } // end if
    }
    else if (_global.getCurrentShell().getCurrentRoomId() == 605)
    {
        if (_loc5.has_special_event_permission == true)
        {
            _loc14 = 0;
        } // end if
    }
    else if (_global.getCurrentShell().OasisPermission.hasPermission("char", _loc5.char_permissions, "wall_hack") == true)
    {
        _loc14 = 0;
    } // end else if
    while (_loc8 > 0)
    {
        _loc6 = _loc6 + _loc10;
        _loc7 = _loc7 + _loc11;
        var _loc3 = Math.round(_loc6);
        var _loc4 = Math.round(_loc7);
        if (_loc9.hitTest(_loc3, _loc4, true))
        {
            if (_global.getCurrentShell().getCurrentRoomId() == 807)
            {
                if (_loc5.is_involved_in_event == true)
                {
                    _loc2.x = _loc3;
                    _loc2.y = _loc4;
                } // end if
            }
            else if (_global.getCurrentShell().getCurrentRoomId() == 605)
            {
                if (_loc5.has_special_event_permission == true)
                {
                    _loc2.x = _loc3;
                    _loc2.y = _loc4;
                } // end if
            }
            else if (_global.getCurrentShell().OasisPermission.hasPermission("char", _loc5.char_permissions, "wall_hack") == true)
            {
                _loc2.x = _loc3;
                _loc2.y = _loc4;
            }
            else
            {
                break;
            } // end else if
        }
        else
        {
            _loc2.x = _loc3;
            _loc2.y = _loc4;
        } // end else if
        --_loc8;
    } // end while
    return (_loc2);
} // End of the function
function throwBallOverride(player_id, target_x, target_y, start_height, max_height, wait)
{
    var _loc3 = getPlayerMovieClip(player_id);
    var room_mc = getRoomMovieClip();
    if (_loc3.is_reading)
    {
        removePlayerBook(player_id);
    } // end if
    if (_loc3.is_ready && !_loc3.is_moving)
    {
        if (throw_item_counter == undefined)
        {
            throw_item_counter = 0;
        } // end if
        if (throw_item_counter > 10)
        {
            throw_item_counter = 0;
        } // end if
        var start_x = _loc3._x;
        var start_y = _loc3._y;
        var c = throw_item_counter++;
        var _loc4 = "i" + c;
        if (room_mc[_loc4] != undefined)
        {
            room_mc[_loc4].removeMovieClip();
        } // end if
        room_mc.attachMovie("ball", _loc4, 1000200 + c);
        var mc = room_mc[_loc4];
        if (mc == undefined)
        {
            room_mc.attachMovie("ballNormal", _loc4, 1000200 + c);
            mc = room_mc[_loc4];
        } // end if
        flash.external.ExternalInterface.call("console.debug", mc + "-" + room_mc.ballNormal);
        if (_loc3.player_attributes.sc != "" && !SHELL.isLag && _global.getCurrentShell().getCurrentRoomId() != 605 && _global.getCurrentShell().getCurrentRoomId() != 807)
        {
            if (_loc3.player_attributes.sc.length == 6)
            {
                var _loc5 = new Color(mc);
                _loc5.setRGB("0x" + _loc3.player_attributes.sc);
            } // end if
        } // end if
        mc.player_id = player_id;
        mc.id = c;
        mc._x = start_x;
        mc._y = start_y;
        updateItemDepth(mc, c);
        var _loc6 = findDistance(start_x, start_y, target_x, target_y);
        var _loc7 = findAngle(start_x, start_y, target_x, target_y);
        var _loc8 = Math.round(findDirection(_loc7) / 2);
        updatePlayerFrame(player_id, 26 + _loc8);
        var duration = _loc6 / 15;
        var change_x = target_x - start_x;
        var change_y = target_y - start_y;
        if (_global.getCurrentShell().getCurrentRoomId() == 605)
        {
            duration = duration * 2.500000;
        } // end if
        var peak = duration / 2;
        var change_height1 = max_height - start_height;
        var change_height2 = -max_height;
        mc.art._y = start_height;
        mc._visible = false;
        var t = 0;
        var w = 0;
        mc.onEnterFrame = function ()
        {
            if (w > wait)
            {
                mc._visible = true;
                ++t;
                if (t < duration)
                {
                    mc._x = mathLinearTween(t, start_x, change_x, duration);
                    mc._y = mathLinearTween(t, start_y, change_y, duration);
                    updateItemDepth(mc, c);
                    if (t < peak)
                    {
                        mc.art._y = mathEaseOutQuad(t, start_height, change_height1, peak);
                    }
                    else
                    {
                        mc.art._y = mathEaseInQuad(t - peak, max_height, change_height2, peak);
                    } // end else if
                }
                else
                {
                    mc._x = target_x;
                    mc._y = target_y;
                    mc.art._y = 0;
                    mc.gotoAndStop(2);
                    room_mc.handleThrow(mc);
                    SHELL.updateListeners(SHELL.BALL_LAND, {id: mc.id, player_id: mc.player_id, x: mc._x, y: mc._y});
                    if (room_mc.snowballBlock != undefined)
                    {
                        if (room_mc.snowballBlock.hitTest(mc._x, mc._y, true))
                        {
                            mc._visible = false;
                        } // end if
                    } // end if
                    this.onEnterFrame = null;
                } // end else if
            }
            else
            {
                ++w;
            } // end else if
        };
    } // end if
} // End of the function
function setupTables()
{
    var _loc1 = getTableListFromRoom();
    if (_loc1 != undefined && _loc1.length > 0)
    {
        SHELL.getTablesPopulationById(_loc1);
    } // end if
} // End of the function
function sendJoinTable(name, table_id, is_prompt)
{
    if (is_prompt)
    {
        setActiveTable(name, table_id);
        var _loc1 = SHELL.getLocalizedString(name + "_prompt");
        INTERFACE.showPrompt("game", _loc1, undefined, clickJoinTablePrompt);
    }
    else
    {
        SHELL.sendJoinTableById(table_id);
    } // end else if
} // End of the function
function clickJoinTablePrompt()
{
    var _loc1 = getActiveTable();
    traceObject(_loc1);
    sendJoinTable(_loc1.name, _loc1.table_id, false);
} // End of the function
function handleJoinTable(ob)
{
    traceObject(ob);
    var _loc3 = ob.table_id;
    var _loc1 = ob.seat_id;
    setActiveTableSeat(_loc1);
    var _loc5 = getActiveTable();
    var _loc4 = _loc5.name;
    stopMouse();
    movePlayerToTableSeat(_loc3, _loc1);
    INTERFACE.showGameWidget(_loc4);
} // End of the function
function handleUpdateTable(table_ob)
{
    traceObject(table_ob);
    var _loc4 = table_ob.table_id;
    var _loc5 = table_ob.num_players;
    var _loc2 = _loc5 + 1;
    var _loc1 = getTableMovieClip(_loc4);
    if (_loc2 > _loc1._totalframes)
    {
        _loc1.gotoAndStop(_loc1._totalframes);
    }
    else
    {
        _loc1.gotoAndStop(_loc2);
    } // end else if
} // End of the function
function sendLeaveTable()
{
    SHELL.sendLeaveTable();
    movePlayerToTableDone();
    startMouse();
} // End of the function
function movePlayerToTableSeat(table_id, seat_id)
{
    var _loc2 = getTableSeatMovieClip(table_id, seat_id);
    var _loc5 = getTableSeatFrame(table_id, seat_id);
    var _loc1 = {x: _loc2._x, y: _loc2._y};
    _loc2._parent.localToGlobal(_loc1);
    var _loc3 = Math.round(_loc1.x);
    var _loc4 = Math.round(_loc1.y);
    sendPlayerMove(_loc3, _loc4, false, _loc5);
} // End of the function
function movePlayerToTableDone()
{
    var _loc3 = getActiveTable();
    var _loc6 = _loc3.table_id;
    var _loc7 = _loc3.seat_id;
    var _loc2 = getTableDoneMovieClip(_loc6, _loc7);
    var _loc1 = {x: _loc2._x, y: _loc2._y};
    _loc2._parent.localToGlobal(_loc1);
    var _loc4 = Math.round(_loc1.x);
    var _loc5 = Math.round(_loc1.y);
    sendPlayerMove(_loc4, _loc5, false);
} // End of the function
function setActiveTable(name, table_id, seat_id)
{
    active_table = {name: name, table_id: table_id, seat_id: seat_id};
} // End of the function
function setActiveTableSeat(seat_id)
{
    active_table.seat_id = seat_id;
} // End of the function
function getActiveTable()
{
    return (active_table);
} // End of the function
function getTableListFromRoom()
{
    var _loc1 = getRoomMovieClip();
    return (_loc1.table_list);
} // End of the function
function getTableSeatFrame(table_id, seat_id)
{
    var _loc2 = getTableMovieClip(table_id);
    var _loc1 = _loc2.seat_frames[seat_id - 1];
    return (_loc1);
} // End of the function
function getTableMovieClip(table_id)
{
    var _loc1 = getRoomMovieClip();
    return (_loc1["table" + table_id + "_mc"]);
} // End of the function
function getTableSeatMovieClip(table_id, seat_id)
{
    var _loc1 = getTableMovieClip(table_id);
    return (_loc1["seat" + seat_id + "_mc"]);
} // End of the function
function getTableDoneMovieClip(table_id, seat_id)
{
    var _loc1 = getTableMovieClip(table_id);
    return (_loc1["done" + seat_id + "_mc"]);
} // End of the function
function setupWaddle()
{
    var _loc1 = getWaddleListFromRoom();
    if (_loc1 != undefined && _loc1.length > 0)
    {
        SHELL.getWaddlePopulationById(_loc1);
    } // end if
} // End of the function
function handleUpdateWaddle(ob)
{
    traceObject(ob);
    var _loc6 = ob.waddle_id;
    var _loc3 = ob.player_list;
    for (var _loc7 in _loc3)
    {
        var _loc5 = Number(_loc7);
        var _loc2 = getWaddleSeatMovieClip(_loc6, _loc5);
        if (_loc3[_loc7] != undefined)
        {
            var _loc1 = SHELL.getPlayerObjectByNickname(_loc3[_loc7]);
            var _loc4 = SHELL.getCurrentRoomId();
            if (_loc1 != undefined)
            {
                if (_loc4 == 230 && (_loc1.hand == 5021 || _loc1.hand == 5046 || _loc1.hand == 5047))
                {
                    _loc2._visible = false;
                }
                else
                {
                    _loc2._visible = true;
                } // end else if
            }
            else
            {
                _loc2._visible = false;
            } // end else if
            continue;
        } // end if
        _loc2._visible = false;
    } // end of for...in
} // End of the function
function sendJoinWaddle(name, waddle_id, is_prompt)
{
    active_waddle_id = waddle_id;
    active_waddle_name = name;
    if (is_prompt)
    {
        var _loc6 = SHELL.getLocalizedString(name + "_prompt");
        INTERFACE.showPrompt("game", _loc6, undefined, clickJoinWaddlePrompt);
    }
    else
    {
        var _loc2 = true;
        var _loc4 = SHELL.getWaddleById(waddle_id);
        traceObject(_loc4);
        var _loc1 = _loc4.player_list;
        for (var _loc3 in _loc1)
        {
            if (_loc1[_loc3] == undefined)
            {
                _loc2 = false;
                break;
            } // end if
        } // end of for...in
        if (!_loc2)
        {
            SHELL.sendJoinWaddleById(waddle_id);
        } // end if
    } // end else if
} // End of the function
function clickJoinWaddlePrompt()
{
    sendJoinWaddle(active_waddle_name, active_waddle_id, false);
} // End of the function
function handleJoinWaddle(ob)
{
    traceObject(ob);
    var _loc1 = active_waddle_id;
    var _loc3 = active_waddle_name;
    var _loc2 = ob.seat_id;
    active_seat_id = _loc2;
    stopMouse();
    movePlayerToWaddleSeat(_loc1, _loc2);
    INTERFACE.showWaddleWidget(_loc3, _loc1);
} // End of the function
function sendLeaveWaddle()
{
    SHELL.sendLeaveWaddle();
    movePlayerToWaddleDone();
    startMouse();
    SHELL.sendLeaveWaddle();
} // End of the function
function movePlayerToWaddleSeat(waddle_id, seat_id)
{
    var _loc2 = getWaddleSeatMovieClip(waddle_id, seat_id);
    var _loc5 = getWaddleSeatFrame(waddle_id, seat_id);
    var _loc1 = {x: _loc2._x, y: _loc2._y};
    _loc2._parent.localToGlobal(_loc1);
    var _loc3 = Math.round(_loc1.x);
    var _loc4 = Math.round(_loc1.y);
    sendPlayerMove(_loc3, _loc4, false, _loc5);
} // End of the function
function movePlayerToWaddleDone()
{
    var _loc5 = active_waddle_id;
    var _loc6 = active_seat_id;
    var _loc2 = getWaddleDoneMovieClip(_loc5, _loc6);
    var _loc1 = {x: _loc2._x, y: _loc2._y};
    _loc2._parent.localToGlobal(_loc1);
    var _loc3 = Math.round(_loc1.x);
    var _loc4 = Math.round(_loc1.y);
    sendPlayerMove(_loc3, _loc4, false);
} // End of the function
function getWaddleMovieClip(waddle_id)
{
    var _loc1 = getRoomMovieClip();
    return (_loc1["waddle" + waddle_id + "_mc"]);
} // End of the function
function getWaddleSeatMovieClip(waddle_id, seat_id)
{
    var _loc1 = getWaddleMovieClip(waddle_id);
    return (_loc1["seat" + seat_id + "_mc"]);
} // End of the function
function getWaddleDoneMovieClip(waddle_id, seat_id)
{
    var _loc1 = getWaddleMovieClip(waddle_id);
    return (_loc1["done" + seat_id + "_mc"]);
} // End of the function
function getWaddleListFromRoom()
{
    var _loc1 = getRoomMovieClip();
    return (_loc1.waddle_list);
} // End of the function
function getWaddleSeatFrame(waddle_id, seat_id)
{
    var _loc2 = getWaddleMovieClip(waddle_id);
    var _loc1 = _loc2.seat_frames[seat_id];
    return (_loc1);
} // End of the function
function getActiveWaddleId()
{
    return (active_waddle_id);
} // End of the function
function checkFieldOpTriggered(avatar)
{
    var _loc1 = SHELL.getFieldOp();
    var _loc2 = 1;
    if (SHELL.getMyPlayerObject().fieldOpStatus == _loc2 && SHELL.getCurrentCrumbRoomId() == _loc1.roomID && _loc1.hit.contains(avatar._x, avatar._y))
    {
        fieldOpTriggered.dispatch(_loc1.gameName);
    } // end if
} // End of the function
function isPlayerOnFieldOpTrigger()
{
    var _loc2 = SHELL.getFieldOp();
    var _loc3 = 1;
    var _loc1 = getPlayerMovieClip(SHELL.getMyPlayerId());
    return (SHELL.getMyPlayerObject().fieldOpStatus == _loc3 && SHELL.getCurrentCrumbRoomId() == _loc2.roomID && _loc2.hit.contains(_loc1._x, _loc1._y));
} // End of the function
function getPlayerMoved()
{
    return (playerMoved);
} // End of the function
function updatePlayerDepth(clip, depth)
{
    var _loc2 = Math.floor(clip._y);
    var _loc1 = depth + 1 + 900 + 1000 * _loc2;
    clip.swapDepths(_loc1);
    return (_loc1);
} // End of the function
function updatePuffleDepth(clip, depth)
{
    return (updatePlayerDepth(clip, depth));
} // End of the function
function updateObjectDepth(clip)
{
    var _loc3 = Math.floor(clip._x);
    var _loc4 = Math.floor(clip._y);
    var _loc1 = _loc3 + 1000 * _loc4;
    clip.swapDepths(_loc1);
    return (_loc1);
} // End of the function
function updateItemDepth(clip, depth)
{
    var _loc4 = Math.floor(clip._x);
    var _loc3 = Math.floor(clip._y);
    var _loc1 = depth + 1 + 800 + 1000 * _loc3;
    clip.swapDepths(_loc1);
    return (_loc1);
} // End of the function
function findAngle(x1, y1, x2, y2)
{
    var _loc2 = x2 - x1;
    var _loc3 = y2 - y1;
    var _loc1 = int(Math.atan2(_loc3, _loc2) * 57.295780 - 90);
    if (_loc1 < 0)
    {
        return (_loc1 + 360);
    }
    else
    {
        return (_loc1);
    } // end else if
} // End of the function
function findDirection(angle)
{
    var _loc1 = Math.round(angle / 45) + 1;
    if (_loc1 > 8)
    {
        _loc1 = 1;
    } // end if
    return (_loc1);
} // End of the function
function findDistance(x1, y1, x2, y2)
{
    var _loc1 = x2 - x1;
    var _loc2 = y2 - y1;
    return (Math.sqrt(_loc1 * _loc1 + _loc2 * _loc2));
} // End of the function
function replaceString(target, word, message)
{
    return (message.split(target).join(word));
} // End of the function
function setDependencies(shell, _interface)
{
    SHELL = shell;
    INTERFACE = _interface;
} // End of the function
function init()
{
    attachShellListeners();
    puffleManager = new com.clubpenguin.engine.PuffleManager(SHELL, this, INTERFACE);
    achievementManager = new com.clubpenguin.achievements.AchievementManager(SHELL, this, INTERFACE);
} // End of the function
function attachShellListeners()
{
    SHELL.addListener(SHELL.START_ENGINE, handleStartEngine);
    SHELL.addListener(SHELL.UPDATE_SHELL_STATE, handleUpdateShellState);
    SHELL.addListener(SHELL.ADD_PLAYER, handleAddPlayer);
    SHELL.addListener(SHELL.REMOVE_PLAYER, handleRemovePlayer);
    SHELL.addListener(SHELL.UPDATE_PLAYER, handleUpdatePlayer);
    SHELL.addListener(SHELL.PLAYER_ACTION, handlePlayerAction);
    SHELL.addListener(SHELL.PLAYER_FRAME, handlePlayerFrame);
    SHELL.addListener(SHELL.PLAYER_MOVE, handlePlayerMove);
    SHELL.addListener(SHELL.THROW_BALL, handleThrowBall);
    SHELL.addListener(SHELL.ADD_PUFFLE, handleAddPuffle);
    SHELL.addListener(SHELL.REQUEST_PUFFLE_MOVE, handleRequestPuffleMove);
    SHELL.addListener(SHELL.PUFFLE_MOVE, handlePuffleMove);
    SHELL.addListener(SHELL.PUFFLE_FRAME, handlePuffleFrame);
    SHELL.addListener(SHELL.PUFFLE_WALK, handlePuffleWalk);
    SHELL.addListener(SHELL.PUFFLE_INTERACTION, handlePuffleInteraction);
    SHELL.addListener(SHELL.OPEN_BOOK, handleOpenBook);
    SHELL.addListener(SHELL.CLOSE_BOOK, handleCloseBook);
    SHELL.addListener(SHELL.JOIN_ROOM, handleJoinRoom);
    SHELL.addListener(SHELL.REFRESH_ROOM, handleRefreshRoom);
    SHELL.addListener(SHELL.JOIN_PLAYER_IGLOO, handleJoinPlayerIgloo);
    SHELL.addListener(SHELL.JOIN_GAME, handleJoinGame);
    SHELL.addListener(SHELL.JOIN_TABLE, handleJoinTable);
    SHELL.addListener(SHELL.JOIN_WADDLE, handleJoinWaddle);
    SHELL.addListener(SHELL.UPDATE_TABLE, handleUpdateTable);
    SHELL.addListener(SHELL.UPDATE_WADDLE, handleUpdateWaddle);
    SHELL.addListener(SHELL.GAME_OVER, handleGameOver);
} // End of the function
var isMouseMovementEnabled = true;
var framesRequestedAfterMove = {};
var forceReloadRoomOnRefresh = true;
MAX_SCREEN_WIDTH = 760;
MAX_SCREEN_HEIGHT = 480;
MAP_MARGIN = 20;
var INTERFACE_BAR_HEIGHT = 30;
MAP_WIDTH_MIN = MAP_MARGIN;
MAP_WIDTH_MAX = MAX_SCREEN_WIDTH - MAP_MARGIN;
MAP_HEIGHT_MIN = MAP_MARGIN;
MAP_HEIGHT_MAX = MAX_SCREEN_HEIGHT - MAP_MARGIN - INTERFACE_BAR_HEIGHT;
my_room_movieclips = new Object();
is_ball_moving = false;
is_room_ready = false;
var bitmapClip = new MovieClip();
var active_game = undefined;
var game_over_room = undefined;
var SMALL_PENGUIN_SIZE = 60;
var MEDIUM_PENGUIN_SIZE = 90;
var game_over_object = new Object();
var __listener = null;
var __progressInterval = null;
var PROGRESS_RATE = 10;
var player_action = "wait";
var MAX_RANDOMIZE_ATTEMPTS = 25;
var RANDOM_RANGE_FOR_DOOR_ENTRY = 40;
var RANDOM_RANGE_FOR_MAP_ENTRY = 80;
var SPEECH_BUBBLE_DEPTH_ARRAY_SIZE = 100;
var SPEECH_BUBBLE_DEPTH_EMPTY_VALUE = -1;
var SPEECH_BUBBLE_DEPTH_LOCAL_INDEX = SPEECH_BUBBLE_DEPTH_ARRAY_SIZE - 1;
var player_x = 0;
var player_y = 0;
var add_more_players = false;
var hidingAllPlayerNames = false;
var speechBubbleDepths = null;
var is_mouse_active = false;
var current_direction_to_mouse = 0;
var active_table = new Object();
var pending_table = new Object();
var active_waddle_id = undefined;
var active_waddle_name = undefined;
var active_seat_id = undefined;
list[waddle1] = ["name1", "name2"];
list[waddle2] = ["name1", "name2"];
list[waddle3] = ["name1", "name2"];
list[waddle4] = ["name1", "name2"];
list[waddle1][0] = "name";
var fieldOpTriggered = new org.osflash.signals.Signal(String);
var cancelFieldOpTrigger = new org.osflash.signals.Signal();
var playerMoved = new org.osflash.signals.Signal();
mathLinearTween = function (t, b, c, d)
{
    return (c * t / d + b);
};
mathEaseInQuad = function (t, b, c, d)
{
    t = t / d;
    return (c * t * t + b);
};
mathEaseOutQuad = function (t, b, c, d)
{
    t = t / d;
    return (-c * t * (t - 2) + b);
};
mathEaseInOutQuad = function (t, b, c, d)
{
    t = t / (d / 2);
    if (t < 1)
    {
        return (c / 2 * t * t + b);
    } // end if
    --t;
    return (-c / 2 * (t * (t - 2) - 1) + b);
};
var SHELL;
var INTERFACE;
var ENGINE = this;
var IGLOO;
var puffleManager;
var achievementManager;
