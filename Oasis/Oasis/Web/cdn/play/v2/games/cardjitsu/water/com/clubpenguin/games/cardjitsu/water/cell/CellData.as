class com.clubpenguin.games.cardjitsu.water.cell.CellData implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.games.cardjitsu.water.cell.ICell
{
    var __uid, __cid, __get__id, __cellLocation, __cellPosition, __isSelected, __isEnabled, __state, __playerRef, __displayRef, __get__renderer, __set__enabled, __set__selected, __cellRoot, __elementRef, __get__enabled, __get__selected, __get__location, __get__element, __set__id, __get__position, __set__renderer;
    function CellData()
    {
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.cell.CellData.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.cell.CellData.$_instanceCount;
        this.init();
    } // End of the function
    function get id()
    {
        return (__cid);
    } // End of the function
    function set id(_val)
    {
        __cid = _val;
        //return (this.id());
        null;
    } // End of the function
    function getUniqueName()
    {
        return ("[CellData<" + __uid + ">]");
    } // End of the function
    function init(Void)
    {
        __cellLocation = new flash.geom.Point();
        __cellPosition = new flash.geom.Point();
        __isSelected = false;
        __isEnabled = false;
        __state = com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_STATE_APPEARING;
        __playerRef = null;
        this.setupListeners();
    } // End of the function
    function set renderer(_dref)
    {
        __displayRef = _dref;
        __displayRef.__set__selected(false);
        if (!__displayRef.rendered)
        {
            com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.ClipEvent.RENDERED, onRender, this, __displayRef);
        }
        else
        {
            this.onRender();
        } // end else if
        //return (this.renderer());
        null;
    } // End of the function
    function onRender(_eventObj)
    {
        if (_eventObj.__get__target() != undefined && _eventObj.__get__target().getUniqueName() == __displayRef.getUniqueName())
        {
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.event.ClipEvent.RENDERED, onRender, this);
        } // end if
        __displayRef.updateElement();
    } // End of the function
    function setupListeners()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CursorEvent.CURSOR_APPLY_ELEMENT, handleApplyElement, this);
    } // End of the function
    function handleApplyElement(_eventObj)
    {
        this.applyElement((com.clubpenguin.games.cardjitsu.water.ElementData)(_eventObj.__get__data()));
    } // End of the function
    function applyElement(_applyElement)
    {
    } // End of the function
    function setLocation(_locY, _locX)
    {
        var _loc3;
        var _loc2;
        __cellLocation = new flash.geom.Point(_locX, _locY);
        _loc3 = _loc3 + __cellLocation.y * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_PADDINGW;
        _loc2 = _loc2 + __cellLocation.y * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CELL_PADDINGH;
        _loc3 = _loc3 + com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_LEFT;
        _loc2 = _loc2 + com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_TOP;
        __cellPosition = new flash.geom.Point(_loc3, _loc2);
        this.updatePosition(true);
    } // End of the function
    function updatePosition(_immediate)
    {
        __displayRef._x = __cellPosition.x;
        __displayRef._y = __cellPosition.y;
    } // End of the function
    function getPlayer(Void)
    {
        return (__playerRef);
    } // End of the function
    function addPlayer(_playerRef)
    {
        if (!_playerRef)
        {
            return;
        } // end if
        __playerRef = _playerRef;
        __displayRef.player.show(__playerRef);
    } // End of the function
    function removePlayer(Void)
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CellEvent(this, com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_VACATED, __playerRef));
        __playerRef = null;
        __displayRef.player.hide();
    } // End of the function
    function drop(Void)
    {
        __cellLocation = null;
        __cellPosition = null;
        this.__set__enabled(false);
        this.__set__selected(false);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_DROP_COMPLETE, dropComplete, this, __displayRef);
        __displayRef.drop();
    } // End of the function
    function dropComplete(_eventObj)
    {
        if (_eventObj.__get__target() == __displayRef)
        {
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_DROP_COMPLETE, dropComplete, this, __displayRef);
            __displayRef._visible = false;
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CellEvent(this, com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_DROP_COMPLETE, __cellRoot));
            __playerRef.onPlayerDropComplete();
            this.dispose();
        } // end if
    } // End of the function
    function getElement(Void)
    {
        return (__elementRef);
    } // End of the function
    function setElement(_elementRef)
    {
        if (_elementRef == undefined)
        {
            return;
        } // end if
        __elementRef = _elementRef;
        __displayRef.updateElement();
    } // End of the function
    function getDisplay()
    {
        return (__displayRef);
    } // End of the function
    function setDisplay(_displayRef)
    {
        if (_displayRef == undefined)
        {
            return;
        } // end if
        __displayRef = __displayRef;
    } // End of the function
    function get enabled()
    {
        return (__isEnabled);
    } // End of the function
    function set enabled(_state)
    {
        if (_state == undefined)
        {
            return;
        } // end if
        __isEnabled = _state;
        //return (this.enabled());
        null;
    } // End of the function
    function get element()
    {
        return (__elementRef);
    } // End of the function
    function get selected()
    {
        return (__isSelected);
    } // End of the function
    function set selected(_state)
    {
        if (_state == undefined)
        {
            return;
        } // end if
        __isSelected = _state;
        __displayRef.__set__selected(_state);
        //return (this.selected());
        null;
    } // End of the function
    function get location()
    {
        //return (__displayRef.location().clone());
    } // End of the function
    function get position()
    {
        return (__cellPosition.clone());
    } // End of the function
    function dispose()
    {
    } // End of the function
    function toString(Void)
    {
        return ("[CellData] " + __displayRef._name);
    } // End of the function
    function showPlayer()
    {
        __displayRef.showPlayer(__playerRef);
    } // End of the function
    function getApplyModifier(_element)
    {
        var _loc2;
        _loc2 = _element.__get__amount() - __elementRef.__get__amount();
        return (_loc2 == 0 ? (0) : (_loc2 / Math.abs(_loc2)));
    } // End of the function
    function oppositeElement(_element)
    {
        var _loc2;
        switch (_element.__get__type())
        {
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_FIRE:
            {
                _loc2 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_WATER;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_WATER:
            {
                _loc2 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_SNOW;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_SNOW:
            {
                _loc2 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_FIRE;
                break;
            } 
        } // End of switch
        //return (__elementRef.type() == _loc2);
    } // End of the function
    function validateElement(_type, _value)
    {
        var _loc5;
        var _loc3;
        var _loc8;
        var _loc6;
        var _loc4;
        _loc5 = parseInt(_type);
        if (_value.indexOf("P") != -1)
        {
            _loc8 = _value.substr(_value.length - 1);
            _loc3 = 0;
        }
        else
        {
            _loc4 = new com.clubpenguin.games.cardjitsu.water.ElementData(parseInt(_type), parseInt(_value));
            _loc6 = this.getApplyModifier(_loc4);
            __displayRef.showEffect(_loc6);
            _loc3 = parseInt(_value);
        } // end else if
        __elementRef.__set__type(_loc5);
        __elementRef.__set__amount(_loc3);
        __displayRef.updateElement();
    } // End of the function
    function charge(_index, _element)
    {
        __displayRef.charge(_index, _element);
    } // End of the function
    function ignite()
    {
        __displayRef.ignite();
    } // End of the function
    function isEmpty()
    {
        //return (__playerRef == null && __elementRef.type() == com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY);
    } // End of the function
    function isOccupied()
    {
        return (__playerRef != null);
    } // End of the function
    function setHitArea(_currRow, _currCol)
    {
        var _loc2;
        var _loc3;
        switch (_currRow)
        {
            case -1:
            {
                _loc2 = "bot";
                break;
            } 
            case 0:
            {
                _loc2 = "mid";
                break;
            } 
            case 1:
            {
                _loc2 = "top";
                break;
            } 
        } // End of switch
        switch (_currCol)
        {
            case -1:
            {
                _loc3 = "right";
                break;
            } 
            case 0:
            {
                _loc3 = "mid";
                break;
            } 
            case 1:
            {
                _loc3 = "left";
                break;
            } 
        } // End of switch
        __displayRef.setHitArea(_loc2 + _loc3);
    } // End of the function
    function indexOf(_cell)
    {
        var _loc6;
        var _loc5;
        var _loc3;
        var _loc4;
        var _loc2;
        _loc2 = "Affected cell \'aCell\' at ";
        _loc6 = this.__get__location().x - _cell.__get__location().x;
        _loc5 = this.__get__location().y - _cell.__get__location().y;
        switch (_loc5)
        {
            case -1:
            {
                _loc3 = 1;
                _loc2 = _loc2 + "top ";
                break;
            } 
            case 0:
            {
                _loc3 = 4;
                _loc2 = _loc2 + "mid ";
                break;
            } 
            case 1:
            {
                _loc3 = 7;
                _loc2 = _loc2 + "bottom ";
                break;
            } 
        } // End of switch
        switch (_loc6)
        {
            case -1:
            {
                _loc4 = 0;
                _loc2 = _loc2 + "left ";
                break;
            } 
            case 0:
            {
                _loc4 = 1;
                _loc2 = _loc2 + "mid ";
                break;
            } 
            case 1:
            {
                _loc4 = 2;
                _loc2 = _loc2 + "right ";
                break;
            } 
        } // End of switch
        return (_loc3 + _loc4);
    } // End of the function
    function config(cellComponents)
    {
        this.__set__selected(false);
        __cid = parseInt(cellComponents[0]);
        this.setElement(new com.clubpenguin.games.cardjitsu.water.ElementData(parseInt(cellComponents[1]), parseInt(cellComponents[2])));
    } // End of the function
    function fizzle()
    {
        __displayRef.showEffect(0);
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
