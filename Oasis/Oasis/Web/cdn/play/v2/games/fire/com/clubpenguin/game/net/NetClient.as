class com.clubpenguin.game.net.NetClient implements com.clubpenguin.lib.event.IEventDispatcher
{
    var SHELL, __roomID, AIRTOWER, __get__roomID;
    function NetClient()
    {
    } // End of the function
    function get roomID()
    {
        __roomID = SHELL.getCurrentServerRoomId();
        return (__roomID);
    } // End of the function
    function init()
    {
        SHELL = _global.getCurrentShell();
        AIRTOWER = _global.getCurrentAirtower();
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_GET_GAME, handleGetGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_JOIN_GAME, handleJoinGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_LEAVE_GAME, handleAbortGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_UPDATE_PLAYERLIST, handleUpdateGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_START_GAME, handleStartGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_ABORT_GAME, handleCloseGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_PLAYER_ACTION, handlePlayerActionMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_STAMP_INFORMATION, handleStampInformationMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_GAME_OVER, handleGameOverMessage, this);
        AIRTOWER.addListener(com.clubpenguin.game.net.NetClient.MESSAGE_ERROR, handleErrorMessage, this);
        roomID = SHELL.getCurrentServerRoomId();
    } // End of the function
    function destroy()
    {
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_GET_GAME, handleGetGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_JOIN_GAME, handleJoinGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_LEAVE_GAME, handleAbortGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_UPDATE_PLAYERLIST, handleUpdateGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_START_GAME, handleStartGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_ABORT_GAME, handleCloseGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_PLAYER_ACTION, handlePlayerActionMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_STAMP_INFORMATION, handleStampInformationMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_GAME_OVER, handleGameOverMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.game.net.NetClient.MESSAGE_ERROR, handleErrorMessage, this);
    } // End of the function
    function sendGetGameMessage()
    {
        this.debugTrace("sendGetGameMessage");
        AIRTOWER.send(com.clubpenguin.game.net.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.game.net.NetClient.MESSAGE_GET_GAME, "", com.clubpenguin.game.net.NetClient.SERVER_SIDE_MESSAGE_TYPE, this.__get__roomID());
    } // End of the function
    function sendJoinGameMessage()
    {
        this.debugTrace("sendJoinGameMessage");
        AIRTOWER.send(com.clubpenguin.game.net.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.game.net.NetClient.MESSAGE_JOIN_GAME, "", com.clubpenguin.game.net.NetClient.SERVER_SIDE_MESSAGE_TYPE, this.__get__roomID());
    } // End of the function
    function sendLeaveGameMessage()
    {
        this.debugTrace("sendLeaveGameMessage");
        AIRTOWER.send(com.clubpenguin.game.net.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.game.net.NetClient.MESSAGE_LEAVE_GAME, "", com.clubpenguin.game.net.NetClient.SERVER_SIDE_MESSAGE_TYPE, this.__get__roomID());
    } // End of the function
    function sendAbortGameMessage()
    {
        this.debugTrace("sendAbortGameMessage");
        AIRTOWER.send(com.clubpenguin.game.net.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.game.net.NetClient.MESSAGE_ABORT_GAME, "", com.clubpenguin.game.net.NetClient.SERVER_SIDE_MESSAGE_TYPE, this.__get__roomID());
    } // End of the function
    function sendPlayerActionMessage(messageData)
    {
        this.debugTrace("sendPlayerActionMessage - messageData is...");
        for (var _loc3 in messageData)
        {
            this.debugTrace("messageData[" + _loc3 + "] = " + messageData[_loc3]);
        } // end of for...in
        AIRTOWER.send(com.clubpenguin.game.net.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.game.net.NetClient.MESSAGE_PLAYER_ACTION, messageData, com.clubpenguin.game.net.NetClient.SERVER_SIDE_MESSAGE_TYPE, this.__get__roomID());
    } // End of the function
    function handleGetGameMessage(resObj)
    {
        this.debugTrace("handleGetGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleJoinGameMessage(resObj)
    {
        this.debugTrace("handleJoinGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleStartGameMessage(resObj)
    {
        this.debugTrace("handleStartGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleUpdateGameMessage(resObj)
    {
        this.debugTrace("handleUpdateGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handlePlayerActionMessage(resObj)
    {
        this.debugTrace("handlePlayerActionMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleStampInformationMessage(resObj)
    {
        this.debugTrace("handleStampInformationMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleCloseGameMessage(resObj)
    {
        this.debugTrace("handleCloseGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleAbortGameMessage(resObj)
    {
        this.debugTrace("handleAbortGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleGameOverMessage(resObj)
    {
        this.debugTrace("handleGameOverMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleErrorMessage(resObj)
    {
        this.debugTrace("handleErrorMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function dispose()
    {
    } // End of the function
    function debugTrace(message, priority)
    {
    } // End of the function
    function getUniqueName()
    {
        return ("[NetClient]");
    } // End of the function
    static var MESSAGE_GET_GAME = "gz";
    static var MESSAGE_JOIN_GAME = "jz";
    static var MESSAGE_LEAVE_GAME = "lz";
    static var MESSAGE_PLAYER_ACTION = "zm";
    static var MESSAGE_STAMP_INFORMATION = "cjsi";
    static var MESSAGE_START_GAME = "sz";
    static var MESSAGE_UPDATE_PLAYERLIST = "uz";
    static var MESSAGE_ABORT_GAME = "cz";
    static var MESSAGE_GAME_OVER = "zo";
    static var MESSAGE_ERROR = "ez";
    static var SERVER_SIDE_EXTENSION_NAME = "z";
    static var SERVER_SIDE_MESSAGE_TYPE = "str";
} // End of Class
