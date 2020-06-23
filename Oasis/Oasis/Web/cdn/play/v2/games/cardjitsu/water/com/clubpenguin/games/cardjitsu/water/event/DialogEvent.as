class com.clubpenguin.games.cardjitsu.water.event.DialogEvent extends com.clubpenguin.lib.event.Event
{
    function DialogEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var DIALOG_READY = "dialogReadyEvent";
    static var DIALOG_DISPATCH = "dialogDispatchEvent";
    static var DIALOG_CONTINUE = "dialogContinueEvent";
    static var GAME_START = "dialogGameStartEvent";
    static var GAME_WATCH = "dialogGameWatchEvent";
    static var GAME_ABORT = "dialogGameAbortEvent";
} // End of Class
