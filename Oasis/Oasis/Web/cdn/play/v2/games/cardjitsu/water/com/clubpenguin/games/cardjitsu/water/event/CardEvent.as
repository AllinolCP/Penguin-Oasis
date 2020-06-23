class com.clubpenguin.games.cardjitsu.water.event.CardEvent extends com.clubpenguin.lib.event.Event
{
    function CardEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var CARD_INIT_COMPLETE = "cardInitComplete";
    static var CARD_DROP_COMPLETE = "cardDropComplete";
    static var CARD_SELECT = "cardSelectEvent";
    static var CARD_DESELECT = "cardDeselectEvent";
    static var CARDS_MOVE = "cardMoveEvent";
} // End of Class
