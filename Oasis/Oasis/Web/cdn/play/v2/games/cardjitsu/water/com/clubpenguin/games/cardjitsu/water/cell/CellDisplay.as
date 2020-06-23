class com.clubpenguin.games.cardjitsu.water.cell.CellDisplay extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.games.cardjitsu.water.motion.IMotionTarget
{
    var __uid, stop, _visible, rendered, __click, __init, cursor_start, cursor_end, hitarea, hitArea, player, boat, __isSelected, onEnterFrame, __gameRoot, __cellData, onPress, onRollOver, onRollOut, burst, __get__data, __get__location, hitTest, __cellRow, __index, gotoAndPlay, gotoAndStop, useHandCursor, __get__selected, _y, _x, __get__playerRef, __get__position, __set__selected;
    function CellDisplay(Void)
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.cell.CellDisplay.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.cell.CellDisplay.$_instanceCount;
        this.stop();
        _visible = false;
        rendered = false;
        __click = false;
        __init = true;
        cursor_start._visible = false;
        cursor_end._visible = false;
        hitArea = hitarea;
        hitarea._visible = false;
        player._visible = false;
        player.gotoAndStop(com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY_LETTER);
        boat.element.boat._xscale = 90;
        boat.element.boat._yscale = 90;
        __isSelected = false;
        this.setupMouseListeners();
        onEnterFrame = checkInit;
        __gameRoot = com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance().getGameRoot();
    } // End of the function
    function getUniqueName()
    {
        return ("[CellDisplay<" + __uid + ">]");
    } // End of the function
    function setHitArea(_label)
    {
        hitarea.gotoAndStop(_label);
    } // End of the function
    function checkInit()
    {
        if (__init)
        {
            rendered = true;
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.RENDERED));
            __init = false;
            delete this.onEnterFrame;
        } // end if
    } // End of the function
    function get data()
    {
        return (__cellData);
    } // End of the function
    function setupMouseListeners()
    {
        onPress = handleMouseDown;
        onRollOver = handleOnRollOver;
        onRollOut = handleOnRollOut;
    } // End of the function
    function charge(_index, _element)
    {
        burst.charge(_index, _element);
    } // End of the function
    function ignite()
    {
        burst.ignite();
    } // End of the function
    function handleMouseDown()
    {
        if (!__cellData.__get__enabled())
        {
            return;
        } // end if
        var _loc3;
        var _loc2;
        _loc3 = com.clubpenguin.games.cardjitsu.water.cursor.CursorData.__get__instance().element;
        _loc2 = __cellData.element;
        var _loc9 = _loc3 != null;
        var _loc7 = _loc2 != null;
        var _loc8 = _loc2.__get__type() < com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY;
        var _loc5 = _loc2.__get__type() == _loc3.__get__type();
        var _loc4 = this.__get__data().oppositeElement(_loc3);
        var _loc6 = _loc2.__get__amount() == com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_VALUE_MAX;
        if (_loc9 && _loc7 && _loc8 && !(_loc5 && _loc6) && !_loc4)
        {
            com.clubpenguin.games.cardjitsu.water.cursor.CursorData.useElement(true);
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_THROW_START, this.__get__location()));
        }
        else if (_loc5 && _loc6 || _loc4)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_THROW_START, this.__get__location()));
        } // end else if
        if (__cellData.__get__selected())
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CellEvent(__cellData, com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_SELECT, this.__get__location()));
            this.movePlayer();
        } // end if
    } // End of the function
    function handleOnRollOver()
    {
        if (__isSelected)
        {
            boat.element.boat._xscale = 110;
            boat.element.boat._yscale = 110;
        } // end if
    } // End of the function
    function handleOnRollOut()
    {
        if (__isSelected)
        {
            boat.element.boat._xscale = 90;
            boat.element.boat._yscale = 90;
        } // end if
    } // End of the function
    function handleOnMouseMove()
    {
        if (!__cellData.__get__enabled())
        {
            return;
        } // end if
        if (this.hitTest(__gameRoot._xmouse, __gameRoot._ymouse, true))
        {
            boat.element.boat._xscale = 110;
            boat.element.boat._yscale = 110;
        }
        else
        {
            boat.element.boat._xscale = 90;
            boat.element.boat._yscale = 90;
        } // end else if
    } // End of the function
    function setDataReference(_cellData, _row, _index)
    {
        if (_cellData == undefined)
        {
            return;
        } // end if
        __cellData = _cellData;
        __cellData.__set__renderer(this);
        __cellRow = _row;
        __index = _index;
        this.updateElement();
    } // End of the function
    function drop()
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CellEvent(this, com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_DROP_START));
        this.gotoAndPlay("drop");
    } // End of the function
    function dropComplete()
    {
        _visible = false;
        this.gotoAndStop("idle");
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CellEvent(this, com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_DROP_COMPLETE));
    } // End of the function
    function set selected(_state)
    {
        if (!_state)
        {
            boat.element.boat.gotoAndStop("off");
            hitarea._visible = false;
            boat.element.boat._xscale = 90;
            boat.element.boat._yscale = 90;
        }
        else
        {
            boat.element.boat.gotoAndStop("on");
        } // end else if
        __isSelected = _state;
        useHandCursor = _state;
        //return (this.selected());
        null;
    } // End of the function
    function getCoordinate()
    {
        return (new flash.geom.Point(_x + __cellRow._x, _y + __cellRow._y));
    } // End of the function
    function getRow()
    {
        return (__cellRow);
    } // End of the function
    function updateElement(Void)
    {
        _visible = true;
        var _loc3;
        var _loc2;
        _loc3 = __cellData.__get__element().letter;
        _loc2 = __cellData.__get__element().displayAmount;
        boat.gotoAndStop(_loc3);
        boat.element.gotoAndStop(_loc2);
    } // End of the function
    function get location()
    {
        //return (new flash.geom.Point(__index, __cellRow.location().y));
    } // End of the function
    function movePlayer(Void)
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(this, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_MOVE_START, this));
    } // End of the function
    function showEffect(_mod)
    {
        (com.clubpenguin.games.cardjitsu.water.layers.EffectLayer)(com.clubpenguin.games.cardjitsu.water.DisplayManager.getDisplayLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_EFFECT)).playEffect(_mod, this);
    } // End of the function
    function showPlayer(_playerData)
    {
        player.show(_playerData);
    } // End of the function
    function hidePlayer()
    {
        player.hide();
    } // End of the function
    function get position()
    {
        //return (__cellData.position());
    } // End of the function
    function get playerRef()
    {
        if (__cellData.__get__element().__get__type() < com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY)
        {
        } // end if
        return (player);
    } // End of the function
    function isAttainable()
    {
        //return (__cellData.enabled());
    } // End of the function
    function getCenter()
    {
        return (new flash.geom.Point(0, 0));
    } // End of the function
    function disableInput()
    {
        delete this.onPress;
        delete this.onRollOver;
        delete this.onRollOut;
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
