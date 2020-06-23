class com.clubpenguin.games.cardjitsu.water.cursor.CursorData implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.games.cardjitsu.water.cursor.ICursor
{
    var __uid, __cursorLocation, __cursorPosition, __isSelected, __isEnabled, __playerRef, __displayMgr, __gameRoot, __cursorRoot, __selectedCard, __elementRef, __get__enabled, __get__selected, __get__element, __set__enabled, __get__location, __set__selected;
    static var $_instance, __get__instance, __get__activeElement;
    function CursorData(Void)
    {
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.cursor.CursorData.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.cursor.CursorData.$_instanceCount;
        $_instance = this;
        this.init();
    } // End of the function
    function getUniqueName()
    {
        return ("[CursorData<" + __uid + ">]");
    } // End of the function
    static function get instance()
    {
        if (com.clubpenguin.games.cardjitsu.water.cursor.CursorData.$_instance == null)
        {
            return (null);
        }
        else
        {
            return (com.clubpenguin.games.cardjitsu.water.cursor.CursorData.$_instance);
        } // end else if
    } // End of the function
    function init(Void)
    {
        var _loc2;
        __cursorLocation = new flash.geom.Point();
        __cursorPosition = new flash.geom.Point();
        __isSelected = false;
        __isEnabled = true;
        __playerRef = null;
        __displayMgr = com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance();
        __gameRoot = __displayMgr.getGameRoot();
        __cursorRoot = __displayMgr.getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CURSOR);
        _loc2 = __cursorRoot.getNextHighestDepth();
        this.setupListeners();
    } // End of the function
    function setupListeners()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_SELECT, handleCardSelect, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_DROP_COMPLETE, handleCardDrop, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_SELECT, handleCellSelect, this);
    } // End of the function
    function handleCursorMovement(_eventObj)
    {
    } // End of the function
    function setLocation(_locY, _locX)
    {
        this.updatePosition(true);
    } // End of the function
    function updatePosition(_immediate)
    {
    } // End of the function
    function disableInput()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_SELECT, handleCardSelect, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_DROP_COMPLETE, handleCardDrop, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CellEvent.CELL_SELECT, handleCellSelect, this);
    } // End of the function
    function handleCardSelect(_eventObj)
    {
        var _loc2;
        __selectedCard = (com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater)(_eventObj.__get__target());
        _loc2 = (com.clubpenguin.games.cardjitsu.water.card.GameCardDefinition)(_eventObj.__get__data());
        this.setElement(_loc2.__get__element());
    } // End of the function
    function handleCardDrop(_eventObj)
    {
        var _loc2;
        if (__selectedCard == (com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater)(_eventObj.__get__target()))
        {
            this.setElement(null);
        } // end if
    } // End of the function
    function handleCellSelect(_eventObj)
    {
        var _loc2;
        if (_loc2.__get__element() != null)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CursorEvent(this, com.clubpenguin.games.cardjitsu.water.event.CursorEvent.CURSOR_APPLY_ELEMENT, __elementRef));
            this.setElement(null);
            __selectedCard.consume();
        } // end if
    } // End of the function
    function getGameRoot(Void)
    {
        return (__gameRoot);
    } // End of the function
    function getElement(Void)
    {
        return (__elementRef);
    } // End of the function
    function setElement(_elementRef)
    {
        __elementRef = _elementRef;
        if (_elementRef == null && __selectedCard != null)
        {
            __selectedCard.consume();
            __selectedCard = null;
        } // end if
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
        //return (this.selected());
        null;
    } // End of the function
    function get location()
    {
        return (__cursorLocation.clone());
    } // End of the function
    function dispose()
    {
    } // End of the function
    static function get activeElement()
    {
        //return (com.clubpenguin.games.cardjitsu.water.cursor.CursorData.instance().__get__element());
    } // End of the function
    static function useElement(_bool)
    {
        if (_bool)
        {
            com.clubpenguin.games.cardjitsu.water.cursor.CursorData.__get__instance().setElement(null);
        } // end if
    } // End of the function
    function toString(Void)
    {
        //return (__elementRef.type() + "-" + (__elementRef.__get__amount() < 10 ? ("0") : ("")) + __elementRef.__get__amount());
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
