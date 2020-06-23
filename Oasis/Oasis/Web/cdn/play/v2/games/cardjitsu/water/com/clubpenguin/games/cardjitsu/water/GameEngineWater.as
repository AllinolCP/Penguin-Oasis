class com.clubpenguin.games.cardjitsu.water.GameEngineWater extends com.clubpenguin.game.engine.GenericGameEngine
{
    var __uid, __dialogsReady, __boardReady, __playerReady, __gameState, __shell, __dLearningManager, __commProxy, releaseDateField, __displayMgr, __actionMgr, __dialogManager, __cards, __cursor, __players, __background, __bridge, __foreground, __userinterface, __btnClose, __panelQuality, __player, __board, __endOfGameStampObject, __get__engineRunning, startEngine, __gameCompleteToken, stopEngine, __gameTime, __stampInfoAbort, __hide, onEnterFrame;
    static var $_instanceCount, $_instance, releaseDate;
    function GameEngineWater()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.GameEngineWater.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.GameEngineWater.$_instanceCount;
        __dialogsReady = false;
        __boardReady = false;
        __playerReady = false;
        __gameState = com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_RUNNING;
        this.connectToServer();
        $_instance = this;
    } // End of the function
    function preconfig()
    {
        super.preconfig();
    } // End of the function
    function init()
    {
        this.setupGameManagement();
        __dLearningManager = new com.disney.dlearning.games.cardjitsu.water.DLearning(__shell.getMyPlayerId());
        this.setupServerListeners(__commProxy);
        this.startServer();
        releaseDateField._visible = com.clubpenguin.games.cardjitsu.water.GameEngineWater.ENGINE_DEBUG;
        if (releaseDateField != null)
        {
            releaseDateField.text = com.clubpenguin.games.cardjitsu.water.GameEngineWater.releaseDate;
        } // end if
        com.clubpenguin.games.cardjitsu.water.SoundManager.getInstance().add("sfx_ambient_water", 9999, 75);
        __dLearningManager.startGame();
    } // End of the function
    function connectToServer()
    {
        __commProxy = new com.clubpenguin.games.cardjitsu.water.CommunicationProxy();
    } // End of the function
    function handleGameConnect()
    {
        this.setupGameSimulationKeyListeners();
    } // End of the function
    function setupGameManagement()
    {
        __shell = com.clubpenguin.ProjectGlobals.shell;
        __shell.startGameMusic();
        __displayMgr = com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance();
        __displayMgr.initalize(this);
        __displayMgr.registerTo(this);
        __actionMgr = com.clubpenguin.games.cardjitsu.water.ActionManager.getInstance();
        __dialogManager = new com.clubpenguin.games.cardjitsu.water.DialogManager();
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_READY, handleDialogReady, this);
        __cards = new com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater();
        __cursor = new com.clubpenguin.games.cardjitsu.water.cursor.CursorData();
        __players = new Array();
        __background = __displayMgr.getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_BACKGROUND);
        __bridge = (com.clubpenguin.games.cardjitsu.water.layers.BridgeLayer)(__displayMgr.getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_BRIDGE));
        __foreground = __displayMgr.getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_FOREGROUND);
        __userinterface = __displayMgr.getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_UI);
        __btnClose = __userinterface.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_BTN_CLOSE, "userinterface", __userinterface.getNextHighestDepth());
        __btnClose._x = 760 - (__btnClose._width + 10);
        __btnClose._y = 20;
        __btnClose.onRelease = com.clubpenguin.util.Delegate.create(this, handleCloseButton);
        __panelQuality = (com.clubpenguin.games.cardjitsu.water.uielements.uipanel.UIPanelGameQuality)(__userinterface.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_PANEL_QUALITY, "uipanel_quality", __userinterface.getNextHighestDepth()));
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_VACATED, cellVacatedHandler, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_MOVE_FINISH, cellOccupiedHandler, this);
        this.setupServerRequestListeners();
    } // End of the function
    function handleDialogReady(_eventObj)
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_READY, handleDialogReady, this);
        __dialogsReady = true;
        this.checkStatus();
    } // End of the function
    function cellVacatedHandler(_eventObj)
    {
        if ((com.clubpenguin.games.cardjitsu.water.player.PlayerData)(_eventObj.__get__data()) == __player)
        {
            __board.cellVacatedHandler(__player.__get__currentCell());
        } // end if
    } // End of the function
    function cellOccupiedHandler(_eventObj)
    {
        if (_eventObj.__get__target() == __player)
        {
            __board.getSurroundingCells(__player.__get__currentCell());
        } // end if
    } // End of the function
    function setupServerListeners(_context)
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.game.net.event.NetClientEvent.NET_RECEIVE, serverMessageReceived, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.game.net.event.NetClientEvent.REC_STAMP_INFORMATION, handleGetStampInformation, this);
    } // End of the function
    function setupServerRequestListeners()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.TsunamiEvent.KILL_ROW, onTsunamiKillRow, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_MOVE_START, handlePlayerMoveStart, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_THROW_START, handlePlayerThrowStart, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_SUMMON_CANCEL, handlePlayerUnsummon, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_SELECT, handleCardSelect, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.BoardEvent.BOARD_INIT_COMPLETE, handleBoardInitDone, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_INIT_COMPLETE, handleCardInitDone, this);
    } // End of the function
    function onTsunamiKillRow(_eventObj)
    {
        var _loc2;
        _loc2 = Number(_eventObj.__get__data());
        if (_loc2 == 2)
        {
            __bridge.killLaunchers();
        } // end if
        __board.killRow(_loc2);
    } // End of the function
    function handlePlayerUnsummon(_eventObj)
    {
        __player.unsummon();
    } // End of the function
    function dispatchServerMessage(_msg)
    {
        var _loc2;
        _loc2 = _msg.split("&")[0];
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.ServerRequestEvent(this, com.clubpenguin.games.cardjitsu.water.event.ServerRequestEvent.SERVER_REQUEST, _msg));
    } // End of the function
    function handlePlayerMoveStart(_eventObj)
    {
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellDisplay)(_eventObj.__get__target());
        __player.logAction("M:");
        var _loc3;
        _loc3 = com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_PLAYER_MOVE + com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM + _loc2.__get__data().__get__id();
        this.dispatchServerMessage(_loc3);
    } // End of the function
    function handlePlayerThrowStart(_eventObj)
    {
        __player.logPlay();
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.cell.CellDisplay)(_eventObj.__get__target());
        var _loc3;
        _loc3 = com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_PLAYER_THROW + com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM + _loc2.__get__data().__get__id();
        this.dispatchServerMessage(_loc3);
    } // End of the function
    function handleCardSelect(_eventObj)
    {
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.card.GameCardDefinition)(_eventObj.__get__data());
        __player.logSelect();
        __player.handleCardSelect(_loc2);
        var _loc3;
        _loc3 = com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_CARD_SELECT + com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM + _loc2.__get__handID();
        this.dispatchServerMessage(_loc3);
    } // End of the function
    function handleBoardInitDone(_eventObj)
    {
        __boardReady = true;
        this.checkStatus();
    } // End of the function
    function handleCardInitDone(_eventObj)
    {
        __playerReady = true;
        this.checkStatus();
    } // End of the function
    function startServer()
    {
        var _loc2;
        var _loc3;
        _loc3 = com.clubpenguin.ProjectGlobals.__get__shell().getCookie(com.clubpenguin.ProjectGlobals.__get__shell().GAME_COOKIE, "game_water");
        _loc2 = _loc3.mode;
        __dLearningManager.setMode(_loc2);
        __commProxy.sendGetGameRequest(_loc2.toString());
    } // End of the function
    function updateEngine(_overrideElapsed)
    {
        var _loc3;
        var _loc4;
        _loc3 = getTimer();
        _loc4 = _loc3 - com.clubpenguin.game.engine.GenericGameEngine.$_lastTime;
        if (!isNaN(_overrideElapsed))
        {
            _loc4 = _overrideElapsed;
        } // end if
        super.updateEngine(_overrideElapsed);
    } // End of the function
    function serverMessageReceived(_eventObj)
    {
        var _loc8;
        var _loc3;
        var _loc5;
        var _loc2;
        var _loc4;
        var _loc6;
        _loc6 = _eventObj.message;
        if (_loc6 != com.clubpenguin.game.net.event.NetClientEvent.REC_GAME_ACTION)
        {
            this.processCommand(_loc6, _eventObj.__get__data().split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM));
        }
        else
        {
            _loc8 = String(_eventObj.__get__data());
            _loc3 = _loc8.split(":");
            while (_loc3.length > 0)
            {
                _loc5 = String(_loc3.shift());
                _loc2 = _loc5.split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM);
                _loc4 = String(_loc2.shift());
                this.processCommand(_loc4, _loc2);
            } // end while
        } // end else if
    } // End of the function
    function handleGetStampInformation(_eventObj)
    {
        var _loc5 = _eventObj.__get__data();
        __endOfGameStampObject = new Object();
        __endOfGameStampObject.isCardJitsu = true;
        __endOfGameStampObject.is_table = false;
        __endOfGameStampObject.numberOfGameStamps = parseInt(String(_loc5.pop()));
        __endOfGameStampObject.totalNumberOfGameStampsEarned = parseInt(String(_loc5.pop()));
        var _loc4 = new Array();
        var _loc3 = String(_loc5[0]).split("|");
        while (_loc3.length > 0)
        {
            var _loc2 = parseInt(String(_loc3.pop()));
            if (_loc2 && !isNaN(_loc2))
            {
                _loc4.push(_loc2);
            } // end if
        } // end while
        __endOfGameStampObject.stampIds = _loc4;
        if (__closeBtnClicked)
        {
            this.dispose();
        } // end if
    } // End of the function
    function processCommand(_currCommand, _params)
    {
        var _loc28;
        var _loc3;
        var _loc13;
        var _loc9;
        var _loc2;
        var _loc14;
        var _loc5;
        var _loc30;
        var _loc17;
        var _loc26;
        var _loc7;
        if (_currCommand != com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_GAME_TIME)
        {
        } // end if
        switch (_currCommand)
        {
            case com.clubpenguin.game.net.event.NetClientEvent.REC_GAME_CONNECT:
            {
                if (_params[0] == "-1")
                {
                    if (!this.__get__engineRunning())
                    {
                        __gameState = com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_ABORT;
                        this.startEngine();
                        this.onGameComplete();
                    } // end if
                } // end if
            } 
            case com.clubpenguin.game.net.event.NetClientEvent.REC_GAME_JOIN:
            {
                this.handleGameConnect();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_GAME_TIME:
            {
                _loc26 = com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_TIME.toString();
                this.dispatchServerMessage(_loc26);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_BOARD_INIT:
            {
                __board = new com.clubpenguin.games.cardjitsu.water.Board(parseInt(String(_params.shift())));
                __board.build(String(_params.shift()));
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_BOARD_VELOCITY:
            {
                var _loc23 = Number(String(_params.shift()));
                var _loc21 = Number(String(_params.shift()));
                _loc17 = new flash.geom.Point(_loc23, _loc21);
                __board.setVelocity(_loc17);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_PLAYER_INDEX:
            {
                _loc13 = parseInt(String(_params.shift()));
                __player = new com.clubpenguin.games.cardjitsu.water.player.PlayerDataClient(_loc13);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_CARD_INIT:
            {
                __cards.build(String(_params.shift()));
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_CARD_VELOCITY:
            {
                _loc23 = Number(String(_params.shift()));
                _loc21 = Number(String(_params.shift()));
                _loc17 = new flash.geom.Point(_loc23, _loc21);
                __cards.setVelocity(_loc17);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_GAME_PAUSE:
            {
                if (__gameCompleteToken != null && !__gameCompleteToken.__get__processed())
                {
                    this.startEngine();
                }
                else
                {
                    this.stopEngine();
                } // end else if
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_PLAYER_INIT:
            {
                var _loc8;
                var _loc15;
                var _loc11;
                var _loc12;
                _loc11 = _params.concat();
                for (var _loc8 = 0; _loc8 < _loc11.length; ++_loc8)
                {
                    _loc2 = _loc11[_loc8].split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_GROUP);
                    _loc7 = parseInt(_loc2[0]);
                    _loc15 = _loc2[1];
                    _loc12 = parseInt(_loc2[2]);
                    _loc2 = _loc2[3].split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_VAL);
                    _loc9 = new flash.geom.Point(_loc2[0], _loc2[1]);
                    _loc5 = __board.getCellAt(_loc9.x, _loc9.y);
                    if (_loc7 == __player.__get__id())
                    {
                        _loc3 = __player;
                    }
                    else
                    {
                        _loc3 = new com.clubpenguin.games.cardjitsu.water.player.PlayerData(_loc7);
                    } // end else if
                    _loc3.__set__name(_loc15);
                    _loc3.__set__penguinColor(com.clubpenguin.games.cardjitsu.water.ProjectConstants.PENGUIN_COLOURS[Math.min(_loc12, com.clubpenguin.games.cardjitsu.water.ProjectConstants.TOTAL_PENGUIN_COLORS)]);
                    _loc3.placeIn(_loc5);
                    __players[_loc7] = _loc3;
                } // end of for
                __dLearningManager.setNumberOfPlayers(_loc11.length);
                this.handleGameStart(null);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_BOARD_UPDATE:
            {
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_CARD_PLAY:
            {
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_COUNT_DOWN_TICK:
            {
                __dialogManager.setData(com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_START, _params[0]);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_CARD_ADD:
            {
                _loc2 = String(_params[0]).split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PROP);
                var _loc27;
                var _loc22;
                _loc27 = String(_loc2.shift());
                _loc22 = String(_loc2.shift());
                __cards.newCard(_loc27, _loc22, false);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_CARD_MOVE:
            {
                com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CardEvent(this, com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARDS_MOVE, _loc30));
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_BOARD_NEWROW:
            {
                __board.newRow(String(_params.shift()));
                __bridge.triggerLaunch(__board.getRowAt(1));
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_PLAYER_INVALID_THROW:
            {
                _loc2 = _params[0].split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PROP);
                cellID = parseInt(_loc2[1]);
                _loc5 = __board.getCellByID(cellID);
                _loc5.fizzle();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_PLAYER_THROW:
            {
                var _loc18;
                var _loc16;
                var cellID;
                _loc13 = parseInt(_params[0]);
                _loc2 = _params[1].split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PROP);
                _loc16 = parseInt(_loc2[0]);
                _loc2 = _loc2[1].split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_VAL);
                cellID = parseInt(_loc2[0]);
                _loc5 = __board.getCellByID(cellID);
                _loc18 = __players[_loc13];
                _loc18.summonAndThrowElement(_loc16, _loc5);
                var _loc10;
                var _loc6;
                _loc10 = _params[2].split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_GROUP);
                var _loc20 = _loc10.length > 1;
                while (_loc10.length > 0)
                {
                    _loc2 = _loc10.shift().split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PROP);
                    _loc14 = _loc2[0].split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_VAL);
                    cellID = parseInt(_loc14[0]);
                    _loc6 = __board.getCellByID(cellID);
                    _loc6.validateElement(_loc2[1], _loc2[2]);
                    if (_loc6.__get__location().y > 1)
                    {
                        _loc5.charge(_loc6.indexOf(_loc5), com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENTS_BY_INDEX[_loc16]);
                    } // end if
                    __board.updateInSurround(_loc6, __player.__get__currentCell());
                } // end while
                if (_loc20)
                {
                    _loc5.ignite();
                } // end if
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_PLAYER_MOVE:
            {
                _loc28 = 1;
                if (_params.length != _loc28)
                {
                } // end if
                _loc2 = _params[0].split("-");
                _loc13 = parseInt(_loc2[0]);
                _loc2 = _loc2[1].split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_VAL);
                cellID = parseInt(_loc2[0]);
                _loc5 = __board.getCellByID(cellID);
                var _loc19 = __players[_loc13];
                var _loc25;
                _loc25 = _loc19.currentCell;
                _loc19.moveStart(_loc5);
                __board.updateInSurround(_loc25, __player.__get__currentCell());
                __board.updateInSurround(_loc5, __player.__get__currentCell());
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_PLAYER_KILL:
            {
                _loc13 = parseInt(String(_params.shift()));
                _loc3 = __players[_loc13];
                if (_loc3 == __player)
                {
                    this.disableInputs();
                    __gameCompleteToken = new com.clubpenguin.games.cardjitsu.water.player.GameCompleteToken();
                    __gameCompleteToken.__set__nickname(__player.name);
                    __gameCompleteToken.__set__position(parseInt(String(_params.shift())));
                    __gameCompleteToken.__set__amulet(String(_params.shift()));
                    __gameCompleteToken.__set__vsSensei(String(_params.shift()) == "true");
                } // end if
                _loc3.drop();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_PLAYER_DROWN:
            {
                _loc13 = parseInt(String(_params.shift()));
                _loc3 = __players[_loc13];
                if (_loc3 == __player)
                {
                    __gameCompleteToken = new com.clubpenguin.games.cardjitsu.water.player.GameCompleteToken();
                    __gameCompleteToken.__set__nickname(__player.name);
                    __gameCompleteToken.__set__position(parseInt(String(_params.shift())));
                    __gameCompleteToken.__set__amulet(String(_params.shift()));
                    __gameCompleteToken.__set__vsSensei(String(_params.shift()) == "true");
                } // end if
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_PLAYER_XP:
            {
                var _loc29 = parseInt(String(_params.shift()));
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_GAME_WON:
            {
                this.disableInputs();
                __gameState = com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_COMPLETE;
                _loc13 = parseInt(String(_params.shift()));
                _loc3 = __players[_loc13];
                if (_loc3 == __player)
                {
                    __gameCompleteToken = new com.clubpenguin.games.cardjitsu.water.player.GameCompleteToken();
                    __gameCompleteToken.__set__nickname(__player.name);
                    __gameCompleteToken.__set__position(parseInt(String(_params.shift())));
                    __gameCompleteToken.__set__amulet(String(_params.shift()));
                    __gameCompleteToken.__set__vsSensei(String(_params.shift()) == "true");
                    __dLearningManager.ringGong();
                } // end if
                _loc3.prepVictory(__bridge.winnerCell);
                __board.setVelocity(new flash.geom.Point(0, 0));
                __cards.setVelocity(new flash.geom.Point(0, 0));
                __bridge.abortLaunch();
                __board.abortNewRow();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_GAME_FAILED:
            {
                this.disableInputs();
                __gameState = com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_COMPLETE;
                __board.setVelocity(new flash.geom.Point(0, 0));
                __cards.setVelocity(new flash.geom.Point(0, 0));
                __bridge.abortLaunch();
                __board.abortNewRow();
                if (!this.__get__engineRunning())
                {
                    __gameState = com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_ABORT;
                    this.startEngine();
                    this.onGameComplete();
                } // end if
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_GAME_CONNECTION_ERROR:
            {
                this.disableInputs();
                this.onGameConnectionError();
                break;
            } 
        } // End of switch
    } // End of the function
    function disableInputs()
    {
        __cursor.disableInput();
        __cards.disableInput();
        __board.disableInput();
    } // End of the function
    function checkStatus()
    {
        if (__boardReady && __dialogsReady && __playerReady)
        {
            __dialogManager.show(com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_START);
            this.dispatchReadyMessage();
        } // end if
    } // End of the function
    function dispatchReadyMessage()
    {
        var _loc2;
        _loc2 = com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_START;
        this.dispatchServerMessage(_loc2.toString());
    } // End of the function
    function handleBoardStartMessage()
    {
        __dialogManager.hideAll();
    } // End of the function
    function handleGameStart(_eventObj)
    {
        __dialogManager.hideAll();
        __gameTime = getTimer();
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_DROP_COMPLETE, onDropComplete, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.GameEvent.GAME_OVER_LOSE_COMPLETE, onGameComplete, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.GameEvent.GAME_OVER_WIN_COMPLETE, onGameOverWin, this);
        if (!__debugStep)
        {
            this.startEngine();
        } // end if
        __bridge.triggerLaunch(__board.getRowAt(1));
    } // End of the function
    function onDropComplete(_eventObj)
    {
        var _loc2;
        _loc2 = "A PENGUIN DROPPED OFF THE WATERFALL ->";
        if (__gameState == com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_COMPLETE)
        {
            _loc2 = _loc2 + "\tGAME STATE IS COMPLETE, SO SHOW GAME OVER LOSE";
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_DROP_COMPLETE, onDropComplete);
            this.onGameComplete();
        }
        else if (_eventObj.__get__target() == __player)
        {
            _loc2 = _loc2 + "\tYOU FELL OFF THE EDGE";
            __dialogManager.show(com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_OVER_RESULT, __gameCompleteToken);
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_CONTINUE, onGameDialogContinue, this, __dialogManager);
            __dLearningManager.sendScore(true, __gameCompleteToken.__get__position(), __player.numberOfJumps);
            this.stopEngine();
        } // end else if
    } // End of the function
    function onGameComplete()
    {
        if (__gameState == com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_COMPLETE || __gameState == com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_ABORT)
        {
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_CONTINUE, onGameDialogContinue, this, __dialogManager);
            if (__gameState == com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_COMPLETE)
            {
                __dialogManager.show(com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_OVER_RESULT, __gameCompleteToken);
                __dLearningManager.sendScore(true, __gameCompleteToken.__get__position(), __player.numberOfJumps);
            } // end if
            if (__gameState == com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_ABORT)
            {
                __dialogManager.show(com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_OVER_RESULT, __gameCompleteToken);
                __dLearningManager.sendScore(false, __gameCompleteToken.__get__position(), __player.numberOfJumps);
            } // end if
            this.stopEngine();
        } // end if
    } // End of the function
    function onGameConnectionError()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_CONTINUE, onGameDialogContinue, this, __dialogManager);
        __dLearningManager.quitGame(__player.numberOfJumps);
        __dialogManager.show(com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_DICSONNECT);
    } // End of the function
    function onGameOverWin(_eventObj)
    {
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.player.PlayerData)(_eventObj.__get__data());
        if (_loc2 == __player)
        {
            __dialogManager.show(com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_OVER_RESULT, __gameCompleteToken);
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_CONTINUE, onGameDialogContinue, this, __dialogManager);
            __dLearningManager.sendScore(true, __gameCompleteToken.__get__position(), __player.numberOfJumps);
            this.stopEngine();
        }
        else
        {
            this.onGameComplete();
        } // end else if
    } // End of the function
    function handleCloseButton(Void)
    {
        __closeBtnClicked = true;
        __dLearningManager.quitGame(__player.numberOfJumps);
        var _loc2;
        __btnClose.onRelease = null;
        delete __btnClose.onRelease;
        __btnClose.enabled = false;
        __btnClose._visible = false;
        this.onGameDialogContinue(null);
    } // End of the function
    function onGameDialogContinue(_eventObj)
    {
        __dialogManager.hideAll();
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_CONTINUE, onGameDialogContinue, this, __dialogManager);
        if (__gameCompleteToken != null && !__gameCompleteToken.__get__processed() && __gameCompleteToken.__get__rankAward() > 0)
        {
            __dialogManager.show(com.clubpenguin.games.cardjitsu.water.ProjectConstants.DIALOG_GAME_OVER_AWARD, __gameCompleteToken);
            this.stopEngine();
        }
        else
        {
            if (__gameCompleteToken != null && __gameCompleteToken.__get__rankAward() != 0 && __gameCompleteToken.__get__rankAward() < com.clubpenguin.games.cardjitsu.water.ProjectConstants.WATER_MAX_RANK)
            {
                __dLearningManager.earnedSuit(__gameCompleteToken.__get__rankAward());
                com.clubpenguin.ProjectGlobals.__get__shell().addItemToInventory(com.clubpenguin.games.cardjitsu.water.ProjectConstants.WATER_AWARD_ITEM[__gameCompleteToken.__get__rankAward()]);
            } // end if
            var _loc2;
            _loc2 = com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_ABORT;
            this.dispatchServerMessage(_loc2.toString());
            __dLearningManager.quitGame(__player.numberOfJumps);
            this.dispose();
        } // end else if
    } // End of the function
    function onRequestGameWatch(_eventObj)
    {
        __dialogManager.hideAll();
    } // End of the function
    static function registerElement(_element, _frequency)
    {
        com.clubpenguin.games.cardjitsu.water.GameEngineWater.$_instance.register(_element, _frequency);
    } // End of the function
    function setupGameSimulationKeyListeners()
    {
    } // End of the function
    function keyPressHandler(_eventObj)
    {
        var _loc3;
        _loc3 = _eventObj.char;
        var _loc1;
        _loc1 = _eventObj.code;
    } // End of the function
    function dispose()
    {
        __dialogsReady = false;
        __boardReady = false;
        __playerReady = false;
        __gameState = com.clubpenguin.games.cardjitsu.water.ProjectConstants.GAME_STATE_RUNNING;
        __panelQuality.dispose();
        if (__endOfGameStampObject != null)
        {
            clearInterval(__stampInfoAbort);
            if (!__closeBtnClicked)
            {
                __commProxy.sendLeaveGame();
            } // end if
            this.stopServer();
            this.removeServerListeners();
            this.disconnectFromServer();
            this.destroyGameManagement();
            this.leaveGame();
        }
        else
        {
            clearInterval(__stampInfoAbort);
            __stampInfoAbort = setInterval(com.clubpenguin.util.Delegate.create(this, abortStampInfoRequest), 1000);
            __commProxy.sendLeaveGame();
        } // end else if
    } // End of the function
    function abortStampInfoRequest()
    {
        ++__stampAbortCount;
        if (__stampAbortCount >= 3)
        {
            clearInterval(__stampInfoAbort);
            __endOfGameStampObject = new Object();
            __endOfGameStampObject.stampIds = new Array();
            this.dispose();
        } // end if
    } // End of the function
    function destroyGameManagement()
    {
        __shell = null;
        __displayMgr.dispose();
        __displayMgr = null;
        __dialogManager.dispose();
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.DialogEvent.DIALOG_READY, handleDialogReady, this);
        __cards = null;
        __cursor = null;
        __players = null;
        __hide.removeMovieClip();
        __background = null;
        __foreground = null;
        __userinterface = null;
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_VACATED, cellVacatedHandler, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_MOVE_FINISH, cellOccupiedHandler, this);
        this.destroyServerRequestListeners();
        com.clubpenguin.lib.event.EventManager.dispose();
        onEnterFrame = onStillHere;
    } // End of the function
    function onStillHere()
    {
    } // End of the function
    function destroyServerRequestListeners()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_MOVE_START, handlePlayerMoveStart, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_THROW_START, handlePlayerThrowStart, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_SELECT, handleCardSelect, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.BoardEvent.BOARD_INIT_COMPLETE, handleBoardInitDone, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_INIT_COMPLETE, handleCardInitDone, this);
    } // End of the function
    function disconnectFromServer()
    {
        __commProxy.destroy();
        __commProxy = null;
    } // End of the function
    function removeServerListeners()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.game.net.event.NetClientEvent.NET_RECEIVE, serverMessageReceived, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.game.net.event.NetClientEvent.REC_STAMP_INFORMATION, handleGetStampInformation, this);
    } // End of the function
    function stopServer()
    {
        __commProxy.destroy();
    } // End of the function
    function leaveGame()
    {
        if (__endOfGameStampObject.stampIds.length > 0)
        {
            var _loc3 = _global.getCurrentInterface();
            _loc3.showEndGameScreen(__endOfGameStampObject, null, com.clubpenguin.games.cardjitsu.water.ProjectConstants.ROOM_WATER_DOJO, true);
        }
        else
        {
            com.clubpenguin.ProjectGlobals.__get__shell().sendJoinRoom(com.clubpenguin.games.cardjitsu.water.ProjectConstants.ROOM_WATER_DOJO, 380 + Math.floor(Math.random() * 30) - 15, 285 + Math.floor(Math.random() * 30));
        } // end else if
    } // End of the function
    function getUniqueName()
    {
        return ("[GameEngineWater<" + __uid + ">]");
    } // End of the function
    static var ENGINE_DEBUG = true;
    var __stampAbortCount = 0;
    var __debugStep = false;
    var __closeBtnClicked = false;
} // End of Class
