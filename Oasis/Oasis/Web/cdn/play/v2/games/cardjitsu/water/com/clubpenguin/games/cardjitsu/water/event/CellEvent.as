class com.clubpenguin.games.cardjitsu.water.event.CellEvent extends com.clubpenguin.lib.event.Event
{
    function CellEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var CELL_DROP_START = "cellDropStart";
    static var CELL_DROP_COMPLETE = "cellDropComplete";
    static var CELL_IDLE_COMPLETE = "cellIdleComplete";
    static var CELL_SELECT = "cellSelectEvent";
    static var CELL_VACATED = "cellVacatedEvent";
    static var GONG_SWING = "cellSwingGongEvent";
} // End of Class
