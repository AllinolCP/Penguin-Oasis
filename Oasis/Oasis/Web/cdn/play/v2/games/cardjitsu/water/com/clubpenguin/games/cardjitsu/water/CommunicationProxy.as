class com.clubpenguin.games.cardjitsu.water.CommunicationProxy implements com.clubpenguin.lib.event.IEventDispatcher, com.clubpenguin.game.engine.IEngineUpdateable
{
    var __uid, __init, __players, __msgQueue, __netClient, __gameEngine;
    static var $_instance;
    function CommunicationProxy()
    {
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.CommunicationProxy.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.CommunicationProxy.$_instanceCount;
        __init = true;
        __players = new Array();
        __msgQueue = new Array();
        this.initNetClient();
    } // End of the function
    function initNetClient()
    {
        __netClient = new com.clubpenguin.games.cardjitsu.water.net.NetClientWater();
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.ServerRequestEvent.SERVER_REQUEST, handleRequest, this);
    } // End of the function
    function testLatency(_player)
    {
        _player.latencyCheck(getTimer());
        __msgQueue.push(_player.latencyRequest());
        this.sendGameUpdateCommands(this.getMessage());
    } // End of the function
    function registerLatency(_pid)
    {
        var _loc2;
        _loc2 = __players[_pid];
        _loc2.latencyDiff(getTimer());
        if (_loc2.__get__latency() < 0)
        {
            this.testLatency(_loc2);
            
        } // end if
    } // End of the function
    function start()
    {
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.games.cardjitsu.water.CommunicationProxy.$_instance == null)
        {
            $_instance = new com.clubpenguin.games.cardjitsu.water.CommunicationProxy();
        } // end if
        return (com.clubpenguin.games.cardjitsu.water.CommunicationProxy.$_instance);
    } // End of the function
    function registerTo(_timer)
    {
        __gameEngine = _timer;
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.KeyEvent.PRESSED, keyPressHandler, this);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.KeyEvent.RELEASED, keyReleaseHandler, this);
    } // End of the function
    function handleRequest(_eventObj)
    {
        var _loc4;
        var _loc2;
        var _loc3;
        _loc4 = String(_eventObj.__get__data());
        _loc2 = _loc4.split(":");
        while (_loc2.length > 0)
        {
            _loc3 = String(_loc2.shift());
            this.processRequest(_loc3);
        } // end while
    } // End of the function
    function processRequest(_currCommandString)
    {
        var _loc2;
        var _loc3;
        _loc2 = _currCommandString.split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM);
        _loc3 = String(_loc2.shift());
        var _loc5;
        var _loc7;
        var _loc6;
        switch (_loc3)
        {
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_TIME.toString():
            {
                this.requestGameUpdateCommands(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_TIME.toString());
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_INIT.toString():
            {
                this.requestGameUpdateCommands(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_INIT.toString());
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_PLAYER_INIT.toString():
            {
                this.requestGameUpdateCommands(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_PLAYER_INIT.toString());
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_START.toString():
            {
                this.requestGameUpdateCommands(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_GAME_START.toString());
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_PLAYER_MOVE.toString():
            {
                this.requestGameUpdateCommands(_loc3, _loc2[0]);
                return;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_PLAYER_THROW.toString():
            {
                this.requestGameUpdateCommands(_loc3, _loc2[0]);
                return;
                break;
            } 
            case com.clubpenguin.games.cardjitsu.water.CommunicationConstants.REQ_CARD_SELECT.toString():
            {
                this.requestGameUpdateCommands(_loc3, _loc2[0]);
                break;
            } 
        } // End of switch
    } // End of the function
    function update(_tick, _currUpdate)
    {
    } // End of the function
    function requestGameUpdateCommands(_requestType, _data)
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.game.net.event.NetClientEvent(this, com.clubpenguin.game.net.event.NetClientEvent.NET_REQUEST, _requestType, _data));
    } // End of the function
    function sendGameUpdateCommands(_msg)
    {
        if (_msg != "")
        {
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.AirtowerEvent(this, com.clubpenguin.lib.event.AirtowerEvent.SIMULATOR, _msg));
        } // end if
    } // End of the function
    function getMessage()
    {
        var _loc5;
        _loc5 = "";
        var _loc4;
        var _loc3;
        var _loc6;
        var _loc2;
        while (__msgQueue.length > 0)
        {
            _loc4 = String(__msgQueue.shift());
            _loc3 = _loc4.split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_COMMAND);
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                _loc6 = String(_loc3[_loc2]).split(com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_PARAM);
            } // end of for
            _loc5 = _loc5 + _loc4;
            _loc5 = _loc5 + (__msgQueue.length > 0 ? (com.clubpenguin.games.cardjitsu.water.CommunicationConstants.DELIMITER_COMMAND) : (""));
        } // end while
        return (_loc5);
    } // End of the function
    function keyPressHandler(_eventObj)
    {
    } // End of the function
    function keyReleaseHandler(_eventObj)
    {
    } // End of the function
    function toString()
    {
        var _loc1;
        _loc1 = "[CommunicationProxy]";
        return (_loc1);
    } // End of the function
    function getUniqueName()
    {
        return ("[CommunicationProxy<" + __uid + ">]");
    } // End of the function
    function sendGetGameRequest(_mode)
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.game.net.event.NetClientEvent(this, com.clubpenguin.game.net.event.NetClientEvent.NET_REQUEST, com.clubpenguin.game.net.event.NetClientEvent.REQ_GAME_CONNECT, _mode));
    } // End of the function
    function sendLeaveGame()
    {
        __netClient.sendLeaveGameMessage();
    } // End of the function
    function destroy()
    {
        __netClient.destroy();
    } // End of the function
    static var DEV_PLAYER_COUNT = 2;
    static var $_updateInterval = com.clubpenguin.games.cardjitsu.water.ProjectConstants.TICKS_PER_UPDATE;
    static var $_instanceCount = 0;
} // End of Class
