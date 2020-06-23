class com.clubpenguin.games.cardjitsu.water.event.PlayerEvent extends com.clubpenguin.lib.event.Event
{
    function PlayerEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var PLAYER_MOVE_START = "playerEventMoveStart";
    static var PLAYER_MOVE_FINISH = "playerEventMoveFinish";
    static var PLAYER_DROP_START = "playerEventDropStart";
    static var PLAYER_DROP_FINISH = "playerEventDropFinish";
    static var PLAYER_DROP_COMPLETE = "playerEventDropComplete";
    static var PLAYER_SUMMON_FINISH = "playerSummonFinishEvent";
    static var PLAYER_SUMMON_CANCEL = "playerSummonCancelEvent";
    static var PLAYER_THROW_START = "playerThrowStartEvent";
    static var PLAYER_THROW_FINISH = "playerThrowFinishEvent";
    static var PLAYER_ACTION_FINISH = "playerThrowFinishEvent";
    static var PLAYER_WIN_COMPLETE = "playerWinCompleteEvent";
    static var PLAYER_KICK_GONG = "playerKickGongEvent";
} // End of Class
