class com.clubpenguin.services.PinsService extends com.clubpenguin.services.AbstractService
{
    var _pinsListReceived, messageFormat, extension, connection, __get__pinsListReceived;
    function PinsService(connection)
    {
        super(connection);
        _pinsListReceived = new org.osflash.signals.Signal(Array);
        connection.getResponded().add(onResponded, this);
    } // End of the function
    function get pinsListReceived()
    {
        return (_pinsListReceived);
    } // End of the function
    function onResponded(responseType, responseData)
    {
        if (responseType !== com.clubpenguin.services.PinsService.QUERY_PLAYERS_PINS)
        {
        }
        else
        {
            _pinsListReceived.dispatch(responseData);
        } // end else if
        return;
    } // End of the function
    function queryPlayersPins(playerID)
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.PinsService.ITEM_HANDLER + com.clubpenguin.services.PinsService.QUERY_PLAYERS_PINS, [playerID], messageFormat, -1);
        return (_pinsListReceived);
    } // End of the function
    static var ITEM_HANDLER = "i#";
    static var QUERY_PLAYERS_PINS = "qpp";
} // End of Class
