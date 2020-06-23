class com.clubpenguin.games.cardjitsu.water.event.CursorEvent extends com.clubpenguin.lib.event.Event
{
    function CursorEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var CURSOR_APPLY_ELEMENT = "cursorEventApplyElement";
    static var CURSOR_APPLY_COMPLETE = "cursorEventApplyComplete";
    static var CURSOR_MOVE_PLAYER = "cursorEventMovePlayer";
} // End of Class
