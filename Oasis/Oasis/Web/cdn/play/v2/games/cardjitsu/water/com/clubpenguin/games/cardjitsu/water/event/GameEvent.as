class com.clubpenguin.games.cardjitsu.water.event.GameEvent extends com.clubpenguin.lib.event.Event
{
    function GameEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var GAME_OVER_LOSE_COMPLETE = "gameOverLoseEvent";
    static var GAME_OVER_WIN_COMPLETE = "gameOverWinEvent";
} // End of Class
