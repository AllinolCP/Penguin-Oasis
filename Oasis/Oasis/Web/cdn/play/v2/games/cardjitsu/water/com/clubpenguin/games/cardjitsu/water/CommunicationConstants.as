class com.clubpenguin.games.cardjitsu.water.CommunicationConstants
{
    function CommunicationConstants()
    {
    } // End of the function
    static var CMD_BOARD_INIT = "bi";
    static var CMD_BOARD_NEWROW = "br";
    static var CMD_BOARD_MOVE = "bm";
    static var CMD_BOARD_UPDATE = "bu";
    static var CMD_BOARD_VELOCITY = "bv";
    static var CMD_COUNT_DOWN_TICK = "tt";
    static var CMD_CARD_ADD = "ca";
    static var CMD_CARD_PLAY = "cp";
    static var CMD_CARD_INIT = "ci";
    static var CMD_CARD_MOVE = "cm";
    static var CMD_CARD_VELOCITY = "cv";
    static var CMD_PLAYER_INDEX = "po";
    static var CMD_PLAYER_KILL = "pk";
    static var CMD_PLAYER_DROWN = "pd";
    static var CMD_PLAYER_INIT = "pi";
    static var CMD_PLAYER_MOVE = "pm";
    static var CMD_PLAYER_THROW = "pt";
    static var CMD_PLAYER_INVALID_THROW = "pf";
    static var CMD_PLAYER_XP = "px";
    static var CMD_GAME_INIT = "gi";
    static var CMD_GAME_WON = "gw";
    static var CMD_GAME_COMPLETE = "gc";
    static var CMD_GAME_FAILED = "gf";
    static var CMD_GAME_CONNECTION_ERROR = "ge";
    static var CMD_GAME_TIME = "gt";
    static var CMD_GAME_PAUSE = "gp";
    static var REQ_GAME_TIME = 100;
    static var REQ_GAME_INIT = 101;
    static var REQ_PLAYER_INIT = 102;
    static var REQ_GAME_START = 103;
    static var REQ_GAME_ABORT = 104;
    static var REQ_CARD_SELECT = 110;
    static var REQ_PLAYER_MOVE = 120;
    static var REQ_PLAYER_THROW = 121;
    static var DELIMITER_COMMAND = ":";
    static var DELIMITER_PARAM = "&";
    static var DELIMITER_GROUP = "|";
    static var DELIMITER_PROP = "-";
    static var DELIMITER_VAL = ",";
} // End of Class
