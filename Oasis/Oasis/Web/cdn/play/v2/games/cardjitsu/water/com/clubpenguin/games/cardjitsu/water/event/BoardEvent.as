class com.clubpenguin.games.cardjitsu.water.event.BoardEvent extends com.clubpenguin.lib.event.Event
{
    function BoardEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var CELLS_MOVE = "boardCellsMoveEvent";
    static var CELL_VELOCITY = "boardCellVelocityEvent";
    static var PLAYER_MOVE = "boardPlayerMoveEvent";
    static var BOARD_INIT_COMPLETE = "boardInitCompleteEvent";
} // End of Class
