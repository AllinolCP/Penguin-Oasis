class com.clubpenguin.games.cardjitsu.water.player.PlayerData implements com.clubpenguin.game.engine.IEngineUpdateable, com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.games.cardjitsu.water.motion.IMoveable, com.clubpenguin.games.cardjitsu.water.player.IPlayer
{
    var __uid, __startVictory, __celebrateVictory, __nickname, __darkMode, __currentSummon, numberOfJumps, __get__name, __penguinColor, __get__penguinColor, __get__color, __pid, __get__id, __playerRoot, __playerWinner, __flagLanding, __set__id, __playerPosition, __playerLocation, __state, __jumpStartPoint, __jumpEndPoint, __jumpControlPoint, __isJumping, __timeBezier, __timeBezierStep, __ignoreInput, __currentCellRef, __newCellRef, __displayRef, __get__currentCell, __activeMotion, __victoryCell, __get__darkMode, __set__color, __get__currentSummon, __set__darkMode, __set__name, __set__penguinColor;
    function PlayerData(_pid)
    {
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.player.PlayerData.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.player.PlayerData.$_instanceCount;
        this.init(_pid);
        __startVictory = false;
        __celebrateVictory = false;
        __nickname = "Unknown Penguin";
        __darkMode = true;
        __currentSummon = -1;
        numberOfJumps = 0;
    } // End of the function
    function get currentSummon()
    {
        return (__currentSummon);
    } // End of the function
    function set name(_str)
    {
        __nickname = _str;
        //return (this.name());
        null;
    } // End of the function
    function get name()
    {
        return (__nickname);
    } // End of the function
    function set penguinColor(_val)
    {
        if (_val == com.clubpenguin.games.cardjitsu.water.ProjectConstants.SENSEI_COLOUR)
        {
        } // end if
        __penguinColor = _val;
        //return (this.penguinColor());
        null;
    } // End of the function
    function get color()
    {
        return (__penguinColor);
    } // End of the function
    function set color(_val)
    {
        __penguinColor = _val;
        //return (this.color());
        null;
    } // End of the function
    function get id()
    {
        return (__pid);
    } // End of the function
    function set id(_val)
    {
        __pid = _val;
        //return (this.id());
        null;
    } // End of the function
    function init(_pid)
    {
        com.clubpenguin.ProjectGlobals.__get__host().register(this, com.clubpenguin.games.cardjitsu.water.player.PlayerData.$_updateFrequency);
        __playerRoot = com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance().getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_PLAYERS);
        if (__playerRoot.winner_player != null)
        {
            __playerWinner = __playerRoot.winner_player;
        }
        else
        {
            __playerWinner = (com.clubpenguin.games.cardjitsu.water.player.PlayerDisplay)(__playerRoot.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_PLAYER, "winner_player", __playerRoot.getNextHighestDepth()));
            __playerWinner._x = 80;
            __playerWinner._y = 65;
            __playerWinner._visible = false;
            __playerWinner.gotoAndStop(com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY_LETTER);
        } // end else if
        __flagLanding = false;
        this.__set__id(_pid);
        __playerPosition = new flash.geom.Point();
        __playerLocation = new flash.geom.Point();
        __state = com.clubpenguin.games.cardjitsu.water.ProjectConstants.PLAYER_STATE_APPEARING;
        __jumpStartPoint = new flash.geom.Point();
        __jumpEndPoint = new flash.geom.Point();
        __jumpControlPoint = new flash.geom.Point();
        __isJumping = false;
        __timeBezier = 0;
        __timeBezierStep = 0;
        __ignoreInput = false;
    } // End of the function
    function get currentCell()
    {
        //return (__currentCellRef.data());
    } // End of the function
    function handlePlayerMoveFinish(_eventObj)
    {
        __currentCellRef = __newCellRef;
    } // End of the function
    function drop()
    {
        __ignoreInput = true;
        com.clubpenguin.games.cardjitsu.water.SoundManager.getInstance().add("sfx_falling", 1, 40);
        __currentCellRef.player.drop();
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CellEvent(__currentCellRef, com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_VACATED, this));
    } // End of the function
    function onPlayerDropComplete()
    {
        __currentCellRef.__get__data().removePlayer();
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_DROP_COMPLETE));
    } // End of the function
    function placeIn(_cellRef)
    {
        _cellRef.addPlayer(this);
        __newCellRef = (com.clubpenguin.games.cardjitsu.water.cell.CellDisplay)(_cellRef.getDisplay());
        __displayRef = __newCellRef.playerRef;
        __currentCellRef = __newCellRef;
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_MOVE_FINISH));
    } // End of the function
    function moveStart(_cellRef)
    {
        var _loc6;
        var _loc2;
        this.__get__currentCell().removePlayer();
        __currentCellRef = __newCellRef;
        __newCellRef = (com.clubpenguin.games.cardjitsu.water.cell.CellDisplay)(_cellRef.getDisplay());
        var _loc5;
        var _loc4;
        _loc5 = __currentCellRef.getCoordinate();
        _loc4 = __newCellRef.getCoordinate();
        _loc2 = _loc4.subtract(_loc5);
        _loc6 = __newCellRef.playerRef;
        if (__displayRef)
        {
            __displayRef.hide();
        } // end if
        var _loc3;
        _loc3 = (com.clubpenguin.games.cardjitsu.water.layers.PlayerActionLayer)(com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance().getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_PLAYERS));
        __displayRef = _loc3.checkoutPlayer(__newCellRef, _loc2);
        __displayRef.show(this);
        this.startJump(_loc2);
    } // End of the function
    function setCellRef(_cellRef)
    {
        if (!_cellRef)
        {
            return;
        } // end if
        __currentCellRef = _cellRef;
    } // End of the function
    function setLocation(_pointNew)
    {
        var _loc3;
        var _loc2;
        __playerLocation = _pointNew;
        _loc3 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_LEFT + __playerLocation.x * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_WIDTH + __playerLocation.y * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_WIDTH;
        _loc2 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_TOP + __playerLocation.y * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_HEIGHT - __playerLocation.x * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_HEIGHT;
        __playerPosition = new flash.geom.Point(_loc3, _loc2);
        this.updatePosition(_loc3, _loc2);
    } // End of the function
    function updatePosition()
    {
        __displayRef._x = __playerPosition.x;
        __displayRef._y = __playerPosition.y;
    } // End of the function
    function inMotion()
    {
        return (__isJumping);
    } // End of the function
    function startMotion()
    {
        __isJumping = true;
    } // End of the function
    function startJump(_direction)
    {
        var _loc4;
        var _loc3;
        if (!__isJumping)
        {
            __isJumping = true;
            ++numberOfJumps;
            __jumpEndPoint = new flash.geom.Point(__newCellRef.__get__playerRef()._x, __newCellRef.__get__playerRef()._y);
            __newCellRef.localToGlobal(__jumpEndPoint);
            __jumpStartPoint = __jumpEndPoint.subtract(_direction);
            _loc4 = Math.round(_direction.length);
            _direction.normalize(_direction.length / 2);
            _loc3 = __jumpStartPoint.add(_direction);
            __jumpControlPoint = _loc3;
            __jumpControlPoint.y = __jumpControlPoint.y - com.clubpenguin.games.cardjitsu.water.player.PlayerData.constrain(50 + _loc4 / 2, com.clubpenguin.games.cardjitsu.water.player.PlayerData.JUMP_HEIGHT_MIN, com.clubpenguin.games.cardjitsu.water.player.PlayerData.JUMP_HEIGHT_MAX);
            __activeMotion = new com.clubpenguin.games.cardjitsu.water.motion.BezierArc(this, com.clubpenguin.games.cardjitsu.water.player.PlayerData.JUMP_TIME, __jumpStartPoint, __jumpEndPoint, _loc3, __newCellRef.__get__playerRef(), __newCellRef);
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, onJumpMotionProgress, this, __activeMotion);
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, onJumpMotionComplete, this, __activeMotion);
            __displayRef.jump();
            __displayRef.setCoordinate(__jumpStartPoint);
            __activeMotion.startMotion();
            
        } // end if
    } // End of the function
    function onJumpMotionProgress(_eventObj)
    {
        var _loc2;
        _loc2 = Number(_eventObj.__get__data());
        if (com.clubpenguin.games.cardjitsu.water.player.PlayerData.JUMP_TIME - com.clubpenguin.games.cardjitsu.water.player.PlayerData.JUMP_TIME * _loc2 <= com.clubpenguin.games.cardjitsu.water.player.PlayerData.LAND_TRIGGER && !__flagLanding)
        {
            __flagLanding = true;
            __displayRef.land();
        } // end if
    } // End of the function
    function onJumpMotionComplete()
    {
        __flagLanding = false;
        __activeMotion.dispose();
        __activeMotion = null;
        __isJumping = false;
        __currentCellRef = __newCellRef;
        __currentCellRef.__get__data().addPlayer(this);
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.layers.PlayerActionLayer)(com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance().getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_PLAYERS));
        __displayRef.hide();
        _loc2.checkinPlayer(__displayRef);
        __displayRef = __currentCellRef.playerRef;
        if (__celebrateVictory)
        {
            this.startVictory();
        }
        else if (__startVictory)
        {
            __celebrateVictory = true;
            this.moveStart(__victoryCell.__get__data());
        }
        else
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_MOVE_FINISH));
        } // end else if
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, onJumpMotionProgress, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, onJumpMotionComplete, this);
    } // End of the function
    function startVictory()
    {
        __ignoreInput = true;
        (com.clubpenguin.games.cardjitsu.water.cell.CellDisplayGong)(__victoryCell).celebrateVictory();
        com.clubpenguin.ProjectGlobals.__get__shell().stopGameMusic();
    } // End of the function
    static function constrain(num, min, max)
    {
        return (Math.min(Math.max(num, min), max));
    } // End of the function
    function currentMotion()
    {
        return (__activeMotion);
    } // End of the function
    function setCoordinate(_pt)
    {
        __displayRef.setCoordinate(_pt);
    } // End of the function
    function getCoordinate()
    {
        return (__displayRef.getCoordinate());
    } // End of the function
    function toString()
    {
        return (this.getUniqueName() + ":" + __pid);
    } // End of the function
    function getUniqueName()
    {
        return ("[PlayerData<" + __uid + ">]");
    } // End of the function
    function update(_tick, _currUpdate)
    {
    } // End of the function
    function vacateCell()
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CellEvent(__currentCellRef, com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_VACATED, this));
    } // End of the function
    function prepVictory(_dest)
    {
        __victoryCell = _dest;
        __startVictory = true;
    } // End of the function
    function summonAndThrowElement(element)
    {
        __currentSummon = -1;
        __displayRef.summonAndThrowElement(element);
    } // End of the function
    function summonElement(_element)
    {
        __currentSummon = _element;
        __displayRef.summonElement(_element);
    } // End of the function
    function get darkMode()
    {
        return (__darkMode);
    } // End of the function
    function set darkMode(_darkMode)
    {
        __darkMode = _darkMode;
        //return (this.darkMode());
        null;
    } // End of the function
    static var $_updateFrequency = 42;
    static var $_instanceCount = 0;
    static var JUMP_HEIGHT_MAX = 200;
    static var JUMP_HEIGHT_MIN = 50;
    static var JUMP_TIME = 500;
    static var LAND_TRIGGER = 100;
} // End of Class
