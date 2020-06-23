class com.clubpenguin.services.AwardsService extends com.clubpenguin.services.AbstractService
{
    var _awardsListReceived, messageFormat, extension, connection, __get__awardsListReceived;
    function AwardsService(connection)
    {
        super(connection);
        _awardsListReceived = new org.osflash.signals.Signal(Array);
        connection.getResponded().add(onResponded, this);
    } // End of the function
    function get awardsListReceived()
    {
        return (_awardsListReceived);
    } // End of the function
    function onResponded(responseType, responseData)
    {
        if (responseType !== com.clubpenguin.services.AwardsService.QUERY_PLAYERS_AWARDS)
        {
        }
        else
        {
            _awardsListReceived.dispatch(responseData);
        } // end else if
        return;
    } // End of the function
    function queryPlayersAwards(playerID)
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.AwardsService.ITEM_HANDLER + com.clubpenguin.services.AwardsService.QUERY_PLAYERS_AWARDS, [playerID], messageFormat, -1);
        return (_awardsListReceived);
    } // End of the function
    static var ITEM_HANDLER = "i#";
    static var QUERY_PLAYERS_AWARDS = "qpa";
} // End of Class
