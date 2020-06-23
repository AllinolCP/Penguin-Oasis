class com.clubpenguin.games.fire.NetClientFire extends com.clubpenguin.game.net.NetClient
{
    var game, __get__roomID, AIRTOWER;
    function NetClientFire(ref_gameEngine)
    {
        if (ref_gameEngine)
        {
            game = ref_gameEngine;
            super.init();
            this.init();
        }
        else if (com.clubpenguin.games.fire.NetClientFire.DEBUG_LOGGING)
        {
            this.debugTrace("Fatal: Empty game reference passed to constructor");
        } // end else if
    } // End of the function
    function init()
    {
    } // End of the function
    function destroy()
    {
        if (com.clubpenguin.games.fire.NetClientFire.DEBUG_LOGGING)
        {
            this.debugTrace("\t super.destroy() called");
        } // end if
        super.destroy();
    } // End of the function
    function sendGetGameMessage(mode)
    {
        AIRTOWER.send(com.clubpenguin.game.net.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.game.net.NetClient.MESSAGE_GET_GAME, [mode], com.clubpenguin.game.net.NetClient.SERVER_SIDE_MESSAGE_TYPE, this.__get__roomID());
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
        game.getGameMessage(resArray);
    } // End of the function
    function handleJoinGameMessage(resArray)
    {
        game.joinGameMessage(resArray);
    } // End of the function
    function handleAbortGameMessage(resArray)
    {
        game.abortGameMessage(resArray);
    } // End of the function
    function handleUpdateGameMessage(resArray)
    {
        game.updateGameMessage(resArray);
    } // End of the function
    function handleStartGameMessage(resArray)
    {
        game.startGameMessage(resArray);
    } // End of the function
    function handleCloseGameMessage(resArray)
    {
        game.closeGameMessage(resArray);
    } // End of the function
    function handlePlayerActionMessage(resArray)
    {
        game.playerActionMessage(resArray);
    } // End of the function
    function handleGameOverMessage(resArray)
    {
        game.gameOverMessage(resArray);
    } // End of the function
    function handleErrorMessage(resArray)
    {
        game.errorMessage(resArray);
    } // End of the function
    function handleStampInformationMessage(resArray)
    {
        resArray.shift();
        resArray.pop();
        game.onStampInfoRecieved(resArray);
    } // End of the function
    function debugTrace(message)
    {
        if (com.clubpenguin.games.fire.NetClientFire.DEBUG_LOGGING)
        {
            game.debugTraceExternal("NetClientFire", message);
        } // end if
    } // End of the function
    function debugObject(strName, resArray)
    {
        var _loc4 = resArray.length;
        if (_loc4 == 0)
        {
            this.debugTrace("\t" + strName + " is empty");
        }
        else
        {
            for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
            {
                this.debugTrace("\t" + strName + "[" + _loc2 + "] = " + resArray[_loc2] + " (" + typeof(resArray[_loc2]) + ")");
            } // end of for
        } // end else if
    } // End of the function
    static var DEBUG_LOGGING = false;
} // End of Class
