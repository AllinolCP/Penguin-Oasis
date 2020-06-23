class com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater extends MovieClip implements com.clubpenguin.games.cardjitsu.water.motion.IMoveable, com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.games.cardjitsu.water.card.IGameCard, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __uid, __active, __selected, __consumed, __get__consumed, __get__active, onPress, onMouseDown, __set__selected, _ymouse, _xmouse, card, gotoAndPlay, __gcDef, __get__selected, stop, hitArea, __cardPosition, __cardLocation, __activeMotion, _visible, _x, _y, onDragOut, __set__active, __set__consumed;
    static var $_vectorFragment;
    function GameCardArtworkWater()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_instanceCount;
        __active = false;
        __selected = true;
        com.clubpenguin.games.cardjitsu.water.GameEngineWater.registerElement(this, com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_updateFrequency);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.ClipEvent.RENDERED, refreshFirst, this);
        this.setupListeners();
        this.setupMouseListeners();
    } // End of the function
    function get consumed()
    {
        return (__consumed);
    } // End of the function
    function set consumed(_bool)
    {
        __consumed = _bool;
        //return (this.consumed());
        null;
    } // End of the function
    function get active()
    {
        return (__active);
    } // End of the function
    function set active(_bool)
    {
        __active = _bool;
        //return (this.active());
        null;
    } // End of the function
    function getUniqueName()
    {
        return ("[GameCardArtworkWater<" + __uid + ">]");
    } // End of the function
    static function updateVector(_controlVector)
    {
        $_vectorFragment = _controlVector.clone();
        var _loc1;
        var _loc2;
        _loc1 = com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_vectorFragment.length / com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND;
        _loc2 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND / com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_updateFrequency;
        com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_vectorFragment.normalize(_loc1);
        com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_vectorFragment.normalize(com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_vectorFragment.length / _loc2);
    } // End of the function
    function setupMouseListeners()
    {
        onPress = handleMouseDown;
        onMouseDown = com.clubpenguin.util.Delegate.create(this, handleMouseDownStage);
    } // End of the function
    function handleMouseDown()
    {
        if (!__selected)
        {
            this.__set__selected(true);
        } // end if
    } // End of the function
    function handleMouseDownStage()
    {
        var _loc2;
        _loc2 = new flash.geom.Point(_xmouse, _ymouse);
        if (card.hitArea.hitTest(_loc2.x, _loc2.y, false))
        {
            if (!__selected)
            {
                this.__set__selected(true);
            } // end if
        } // end if
    } // End of the function
    function set selected(_state)
    {
        if (__selected != _state)
        {
            if (!_state)
            {
                __selected = false;
                this.gotoAndPlay("deselect");
            }
            else
            {
                __selected = true;
                card.gotoAndStop(1);
                this.gotoAndPlay("select");
                com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CardEvent(this, com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_SELECT, __gcDef));
            } // end if
        } // end else if
        //return (this.selected());
        null;
    } // End of the function
    function get selected()
    {
        return (__selected);
    } // End of the function
    function selectComplete()
    {
        this.stop();
    } // End of the function
    function deselectComplete()
    {
        this.stop();
        card.gotoAndStop(2);
    } // End of the function
    function refreshFirst()
    {
        hitArea = card.hitarea;
        this.refresh();
    } // End of the function
    function refresh(_eventObj)
    {
        if (_eventObj.__get__target() != undefined && _eventObj.__get__target().getUniqueName() == card.getUniqueName())
        {
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.event.ClipEvent.RENDERED, refresh, this);
        } // end if
        card.applyDefinition(__gcDef);
    } // End of the function
    function setupListeners()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_SELECT, onCardSelect, this);
    } // End of the function
    function onCardSelect(_eventObj)
    {
        if (_eventObj.__get__target() != this && this.__get__selected())
        {
            this.__set__selected(false);
        } // end if
    } // End of the function
    function update(_tick, _currUpdate)
    {
        if (!com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.__get__WIGGLEPOP())
        {
            __cardPosition = __cardPosition.add(com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.$_vectorFragment);
        } // end if
        this.setPosition();
    } // End of the function
    function setLocation(_locY, _locX, _immediate)
    {
        var _loc3;
        var _loc2;
        __cardLocation = new flash.geom.Point(_locX, _locY);
        _loc3 = __cardLocation.x;
        _loc2 = __cardLocation.y;
        __cardPosition = new flash.geom.Point(_loc3, _loc2);
        this.setCoordinate(__cardLocation);
    } // End of the function
    function onWPProgress()
    {
    } // End of the function
    function onWPComplete()
    {
        __activeMotion.dispose();
        __activeMotion = null;
        this.setCoordinate(__cardLocation);
    } // End of the function
    function setPosition()
    {
        var _loc2;
        var _loc3;
        _loc2 = Math.round(__cardPosition.x * com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND) / com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND;
        _loc3 = Math.round(__cardPosition.y * com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND) / com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_SECOND;
        this.setCoordinate(new flash.geom.Point(_loc2, _loc3));
    } // End of the function
    function applyDefinition(_gcDef)
    {
        var _loc2;
        _loc2.text = String(__gcDef.__get__uid());
        this.__set__selected(false);
        __gcDef = _gcDef;
        __active = true;
        __consumed = false;
        _visible = true;
        this.refresh();
    } // End of the function
    function loadIcon()
    {
    } // End of the function
    function gotoAndStop(_frame)
    {
        switch (_frame)
        {
            case "idle":
            case "drop":
            {
                this.gotoAndStop(_frame);
                break;
            } 
            default:
            {
                card.gotoAndStop(_frame);
            } 
        } // End of switch
    } // End of the function
    function consume()
    {
        __consumed = true;
        _visible = false;
    } // End of the function
    function currentMotion()
    {
        return (null);
    } // End of the function
    function setCoordinate(_pt)
    {
        _x = _pt.x;
        _y = _pt.y;
        if (_x >= com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.cardLimitX && __active)
        {
            _visible = false;
            this.__set__selected(false);
            __active = false;
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CardEvent(this, com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_DROP_COMPLETE));
        } // end if
    } // End of the function
    function getCoordinate()
    {
        return (new flash.geom.Point(_x, _y));
    } // End of the function
    function toString()
    {
        return (this.getUniqueName());
    } // End of the function
    function disableInput()
    {
        delete this.onPress;
        delete this.onDragOut;
        this.__set__selected(false);
    } // End of the function
    static var $_updateFrequency = 50;
    static var $_instanceCount = 0;
} // End of Class
