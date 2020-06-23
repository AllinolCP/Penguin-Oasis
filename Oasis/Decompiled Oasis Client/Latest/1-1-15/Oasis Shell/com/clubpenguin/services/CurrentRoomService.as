class com.clubpenguin.services.CurrentRoomService extends com.clubpenguin.services.AbstractService
{
    var _roomJoined, messageFormat, extension, connection, __get__roomJoined;
    function CurrentRoomService(connection)
    {
        super(connection);
        _roomJoined = new org.osflash.signals.Signal(Array);
        connection.getResponded().add(onResponded, this);
    } // End of the function
    function get roomJoined()
    {
        return (_roomJoined);
    } // End of the function
    function onResponded(responseType, responseData)
    {
        if (responseType !== com.clubpenguin.services.CurrentRoomService.JOIN_ROOM)
        {
        }
        else
        {
            this.onRoomJoined(responseData);
        } // end else if
    } // End of the function
    function joinRoom(targetRoomServerSideID, x, y)
    {
        if (x && y)
        {
            connection.sendXtMessage(extension, com.clubpenguin.services.CurrentRoomService.NAVIGATION_HANDLER + com.clubpenguin.services.CurrentRoomService.JOIN_ROOM, [targetRoomServerSideID, x, y], messageFormat, -1);
        }
        else
        {
            connection.sendXtMessage(extension, com.clubpenguin.services.CurrentRoomService.NAVIGATION_HANDLER + com.clubpenguin.services.CurrentRoomService.JOIN_ROOM, [targetRoomServerSideID, 0, 0], messageFormat, -1);
        } // end else if
        return (_roomJoined);
    } // End of the function
    function refreshRoom()
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.CurrentRoomService.NAVIGATION_HANDLER + com.clubpenguin.services.CurrentRoomService.REFRESH_ROOM, [], messageFormat, -1);
    } // End of the function
    function onRoomJoined(responseData)
    {
        _roomJoined.dispatch(responseData);
    } // End of the function
    static var NAVIGATION_HANDLER = "j#";
    static var JOIN_ROOM = "jr";
    static var REFRESH_ROOM = "grs";
} // End of Class
