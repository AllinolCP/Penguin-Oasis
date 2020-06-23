class com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater extends com.clubpenguin.games.cardjitsu.water.card.GameCardCollection implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __type, __uid, __cardPool, __cardLayer, updateInterval, __cards, __cardCount, cardHolder, cardSlider, __selectedCard, cardMatrix, __orientation, cardData, def, __activeMotion, __get__uiLayout;
    static var $_instance, __get__WIGGLEPOP;
    function GameCardCollectionWater()
    {
        super();
        __type = 1;
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.$_instanceCount;
        $_instance = this;
        if (com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.cardLimitX == 0)
        {
            cardLimitX = (com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_WIDTH + com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_PADDING) * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_AMOUNT;
        } // end if
        __cardPool = new Array();
        __cardLayer = com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance().getLayer(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LAYER_CARDS);
        updateInterval = 0;
        __cards = new Array();
        __cardCount = 0;
        cardHolder = __cardLayer.createEmptyMovieClip("cardHolder", __cardLayer.getNextHighestDepth());
        cardHolder.attachMovie("dynaRect", "bg", -1);
        cardSlider = (com.clubpenguin.games.cardjitsu.water.layers.CardSlider)(cardHolder.attachMovie("lib_CardSlider", "cardSlider", cardHolder.getNextHighestDepth()));
        var _loc3;
        _loc3 = cardHolder.bg;
        _loc3._width = (com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_WIDTH + com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_PADDING) * (com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_AMOUNT + 1) + 10;
        _loc3._height = com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_HEIGHT * 2;
        _loc3._x = 0;
        _loc3._y = 0;
        this.changeUpBottom();
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_SELECT, selectCard, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_DROP_COMPLETE, reclaimCard, this);
    } // End of the function
    static function get WIGGLEPOP()
    {
        return (com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.$_instance.__wigglePop);
    } // End of the function
    function toggleWiggle()
    {
        __wigglePop = !__wigglePop;
    } // End of the function
    function selectCard(_eventObj)
    {
        __selectedCard = (com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater)(_eventObj.__get__target());
    } // End of the function
    function changeIt(_type)
    {
        __type = _type;
        switch (__type)
        {
            case com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.BOTTOM:
            {
                this.changeUpBottom();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.LEFT:
            {
                this.changeUpLeft();
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.TROUGH:
            {
                this.changeUpTrough();
                break;
            } 
        } // End of switch
    } // End of the function
    function get uiLayout()
    {
        return (__type);
    } // End of the function
    function changeUpTrough()
    {
        cardMatrix = new flash.geom.Matrix();
        cardMatrix.rotate(this.toRadian(45));
        cardMatrix.scale(1, 5.000000E-001);
        cardHolder.transform.matrix = cardMatrix;
        cardHolder._x = -70;
        cardHolder._y = 210;
        cardHolder.bg._visible = false;
        __orientation = com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.ORIENT_NORMAL;
        this.reposition();
    } // End of the function
    function changeUpLeft()
    {
        cardMatrix = new flash.geom.Matrix();
        cardMatrix.rotate(this.toRadian(90));
        cardMatrix.scale(6.000000E-001, 6.000000E-001);
        cardHolder.transform.matrix = cardMatrix;
        cardHolder._x = 65;
        cardHolder._y = 15;
        cardHolder.bg._visible = true;
        __orientation = com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.ORIENT_90;
        this.reposition();
    } // End of the function
    function changeUpBottom()
    {
        cardMatrix = new flash.geom.Matrix();
        cardMatrix.rotate(0);
        cardMatrix.scale(1, 1);
        cardHolder.transform.matrix = cardMatrix;
        cardHolder._x = 380 - cardHolder._width / 2;
        cardHolder._y = 425;
        cardHolder.bg._y = 5;
        cardHolder.bg._visible = true;
        __orientation = com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.ORIENT_NORMAL;
        this.reposition(true);
    } // End of the function
    function changeUpRight()
    {
        cardMatrix = new flash.geom.Matrix();
        cardMatrix.rotate(this.toRadian(270));
        cardMatrix.scale(1, 1);
        cardHolder.transform.matrix = cardMatrix;
        cardHolder._x = 680;
        cardHolder._y = 480;
        cardHolder.bg._visible = true;
    } // End of the function
    function changeUpTop()
    {
        cardMatrix = new flash.geom.Matrix();
        cardMatrix.rotate(0);
        cardMatrix.scale(8.000000E-001, 8.000000E-001);
        cardHolder.transform.matrix = cardMatrix;
        cardHolder._x = 25;
        cardHolder._y = 0;
        cardHolder.bg._visible = true;
    } // End of the function
    function reclaimCard(_eventObj)
    {
        var _loc2;
        _loc2 = (com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater)(_eventObj.__get__target());
        if (__selectedCard == _loc2)
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.PlayerEvent(_loc2, com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_SUMMON_CANCEL));
            __selectedCard = null;
        } // end if
        if (__cards[__cards.length - 1] == _loc2)
        {
            __cards.pop();
        } // end if
        __cardPool.push(_loc2);
    } // End of the function
    function toRadian(_deg)
    {
        return (_deg * 1.745329E-002);
    } // End of the function
    function addCard(_cardID, _uid, _immediate)
    {
        var _loc2;
        _loc2 = this.getCard();
        cardData = com.clubpenguin.game.cardjitsu.data.CardData.getCardData()[_cardID];
        def = new com.clubpenguin.games.cardjitsu.water.card.GameCardDefinition(cardData, _uid);
        _loc2.applyDefinition(def);
        __cards.unshift(_loc2);
        this.reposition(_immediate);
    } // End of the function
    function reposition(_immediate)
    {
        var _loc2;
        if (_immediate || !com.clubpenguin.games.cardjitsu.water.card.GameCardCollectionWater.__get__WIGGLEPOP())
        {
            this.repositionImmediate();
        }
        else
        {
            _loc2 = __cards[0];
            _loc2.setLocation(0, -(com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_WIDTH + com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_PADDING), _immediate);
            this.wigglePop();
        } // end else if
    } // End of the function
    function repositionImmediate()
    {
        var _loc2;
        var _loc3;
        for (var _loc2 = 0; _loc2 < __cards.length; ++_loc2)
        {
            _loc3 = __cards[_loc2];
            _loc3.setLocation(0, _loc2 * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_WIDTH + _loc2 * com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_PADDING, true);
        } // end of for
        cardSlider._x = 0;
    } // End of the function
    function wigglePop()
    {
        if (__activeMotion != null)
        {
            __activeMotion.dispose();
            __activeMotion = null;
        } // end if
        __activeMotion = new com.clubpenguin.games.cardjitsu.water.motion.WigglePop(cardSlider, 250, 250, cardSlider.getCoordinate(), new flash.geom.Point(com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_WIDTH + com.clubpenguin.games.cardjitsu.water.ProjectConstants.CARD_PADDING, 0));
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.PROGRESS, onWPProgress, this, __activeMotion);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.MotionEvent.COMPLETE, onWPComplete, this, __activeMotion);
        __activeMotion.startMotion();
    } // End of the function
    function onWPProgress()
    {
    } // End of the function
    function onWPComplete()
    {
        this.repositionImmediate();
    } // End of the function
    function getCard()
    {
        var _loc2;
        if (__cardPool.length == 0)
        {
            _loc2 = (com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater)(cardSlider.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_CARD, "card" + __cardCount++, cardSlider.getNextHighestDepth()));
        }
        else
        {
            _loc2 = (com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater)(__cardPool.shift());
        } // end else if
        return (_loc2);
    } // End of the function
    function build(_cardString)
    {
        var _loc3;
        var _loc2;
        var _loc5;
        var _loc4;
        _loc3 = _cardString.split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_GROUP);
        while (_loc3.length > 0)
        {
            _loc2 = String(_loc3.shift()).split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PROP);
            _loc5 = String(_loc2.shift());
            _loc4 = String(_loc2.shift());
            this.newCard(_loc5, _loc4, true);
        } // end while
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.CardEvent(this, com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_INIT_COMPLETE));
    } // End of the function
    function newCard(_cardData, _uid, _immediate)
    {
        var _loc2;
        _loc2 = parseInt(_cardData);
        this.addCard(_loc2, _uid, _immediate);
    } // End of the function
    function setVelocity(_vel)
    {
        com.clubpenguin.games.cardjitsu.water.card.GameCardArtworkWater.updateVector(_vel);
    } // End of the function
    function getUniqueName()
    {
        return ("[GameCardCollectionWater<" + __uid + ">]");
    } // End of the function
    function disableInput()
    {
        var _loc2;
        var _loc3;
        for (var _loc2 = 0; _loc2 < __cards.length; ++_loc2)
        {
            _loc3 = __cards[_loc2];
            _loc3.disableInput();
        } // end of for
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_SELECT, selectCard, this);
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.CardEvent.CARD_DROP_COMPLETE, reclaimCard, this);
    } // End of the function
    var __wigglePop = false;
    static var $_updateFrequency = 42;
    static var $_instanceCount = 0;
    static var cardLimitX = 0;
    static var TROUGH = 1;
    static var BOTTOM = 2;
    static var LEFT = 3;
    static var RIGHT = 4;
    static var TOP = 1;
    static var ORIENT_NORMAL = 0;
    static var ORIENT_90 = 1;
} // End of Class
