class com.clubpenguin.games.cardjitsu.water.event.TsunamiEvent extends com.clubpenguin.lib.event.Event
{
    function TsunamiEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var KILL_ROW = "tsunamiKillRowEvent";
    static var SWING_GONG = "tsunamiSwingGongEvent";
} // End of Class
