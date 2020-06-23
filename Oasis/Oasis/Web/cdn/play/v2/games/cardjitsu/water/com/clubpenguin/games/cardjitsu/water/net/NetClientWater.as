class com.clubpenguin.games.cardjitsu.water.net.NetClientWater extends com.clubpenguin.game.net.NetClient
{
    var __uid, game, __abortInterval, __get__roomID, AIRTOWER;
    function NetClientWater(_localClient)
    {
        super.init();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.net.NetClientWater.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.net.NetClientWater.$_instanceCount;
        game = _localClient;
        this.setupNetClientRequestListeners();
    } // End of the function
    function setupNetClientRequestListeners()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.game.net.event.NetClientEvent.NET_REQUEST, handleRequest, this);
    } // End of the function
    function handleRequest(_eventObj)
    {
        var _loc3;
        var _loc2;
        if (_eventObj.__get__data() != null)
        {
            _loc2 = _eventObj.__get__data().split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM);
        }
        else
        {
            _loc2 = new Array();
        } // end else if
        _loc3 = _eventObj.message;
        switch (_loc3)
        {
            case com.clubpenguin.game.net.event.NetClientEvent.REQ_GAME_CONNECT:
            {
                this.sendGetGameMessage(_loc2, 2000);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_START.toString():
            {
                this.sendPlayerActionMessage([_loc3, _loc2]);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_TIME.toString():
            {
                this.sendPlayerActionMessage([_loc3, _loc2]);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_CARD_SELECT.toString():
            {
                this.sendPlayerActionMessage([_loc3, _loc2]);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_PLAYER_THROW.toString():
            {
                this.sendPlayerActionMessage([_loc3, _loc2]);
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_PLAYER_MOVE.toString():
            {
                this.sendPlayerActionMessage([_loc3, _loc2]);
                break;
            } 
        } // End of switch
    } // End of the function
    function abortTest()
    {
        clearInterval(__abortInterval);
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.game.net.event.NetClientEvent(this, com.clubpenguin.game.net.event.NetClientEvent.NET_RECEIVE, com.clubpenguin.game.net.event.NetClientEvent.REC_GAME_ACTION, com.clubpenguin.games.cardjitsu.water.CommunicationConstants.CMD_GAME_CONNECTION_ERROR));
    } // End of the function
    function sendGetGameMessage(mode, _maxWait)
    {
        AIRTOWER.send(com.clubpenguin.game.net.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.game.net.NetClient.MESSAGE_GET_GAME, mode, com.clubpenguin.game.net.NetClient.SERVER_SIDE_MESSAGE_TYPE, this.__get__roomID());
        __abortInterval = setInterval(com.clubpenguin.util.Delegate.create(this, abortTest), _maxWait);
    } // End of the function
    function sendJoinGameMessage(resArray)
    {
    } // End of the function
    function sendAbortGameMessage(resArray)
    {
        super.sendAbortGameMessage(resArray);
    } // End of the function
    function sendLeaveGameMessage(resArray)
    {
        super.sendLeaveGameMessage(resArray);
    } // End of the function
    function sendUpdateGameMessage(resArray)
    {
    } // End of the function
    function sendCloseGameMessage(resArray)
    {
    } // End of the function
    function sendPlayerActionMessage(resArray)
    {
        super.sendPlayerActionMessage(resArray);
    } // End of the function
    function sendGameOverMessage(resArray)
    {
    } // End of the function
    function sendErrorMessage(resArray)
    {
    } // End of the function
    function handleGetGameMessage(resArray)
    {
        clearInterval(__abortInterval);
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.game.net.event.NetClientEvent(this, com.clubpenguin.game.net.event.NetClientEvent.NET_RECEIVE, com.clubpenguin.game.net.event.NetClientEvent.REC_GAME_CONNECT, resArray));
    } // End of the function
    function handleJoinGameMessage(resArray)
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.game.net.event.NetClientEvent(this, com.clubpenguin.game.net.event.NetClientEvent.NET_RECEIVE, com.clubpenguin.game.net.event.NetClientEvent.REC_GAME_JOIN, resArray));
    } // End of the function
    function handleAbortGameMessage(resArray)
    {
    } // End of the function
    function handleUpdateGameMessage(resArray)
    {
    } // End of the function
    function handleStartGameMessage(resArray)
    {
    } // End of the function
    function handleCloseGameMessage(resArray)
    {
    } // End of the function
    function handlePlayerActionMessage(resArray)
    {
        var _loc3 = Number(parseInt(String(resArray.shift())));
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.game.net.event.NetClientEvent(this, com.clubpenguin.game.net.event.NetClientEvent.NET_RECEIVE, com.clubpenguin.game.net.event.NetClientEvent.REC_GAME_ACTION, resArray));
    } // End of the function
    function handleStampInformationMessage(resArray)
    {
        resArray.shift();
        resArray.pop();
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.game.net.event.NetClientEvent(this, com.clubpenguin.game.net.event.NetClientEvent.REC_STAMP_INFORMATION, null, resArray));
    } // End of the function
    function handleGameOverMessage(resArray)
    {
    } // End of the function
    function handleErrorMessage(resArray)
    {
    } // End of the function
    function destroy()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.game.net.event.NetClientEvent.NET_REQUEST, handleRequest, this, game);
        game = null;
        super.destroy();
    } // End of the function
    function getUniqueName()
    {
        return ("[NetClientWater<" + __uid + ">]");
    } // End of the function
    function toString()
    {
        return (this.getUniqueName());
    } // End of the function
    static var $_instanceCount = 0;
    static var LAUNCH_GAME = "launch_game";
    static var DEBUG_LOGGING = false;
} // End of Class
