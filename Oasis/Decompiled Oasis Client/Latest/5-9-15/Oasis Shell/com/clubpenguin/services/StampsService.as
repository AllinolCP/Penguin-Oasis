class com.clubpenguin.services.StampsService extends com.clubpenguin.services.AbstractService
{
    var _playersStampsReceived, _recentlyEarnedStampsReceived, _playersStampBookCoverDetailsReceived, _playerEarnedStampReceived, messageFormat, extension, connection, __get__playerEarnedStampReceived, __get__playersStampBookCoverDetailsReceived, __get__playersStampsReceived, __get__recentlyEarnedStampsReceived;
    function StampsService(connection)
    {
        super(connection);
        _playersStampsReceived = new org.osflash.signals.Signal(Array);
        _recentlyEarnedStampsReceived = new org.osflash.signals.Signal(Array);
        _playersStampBookCoverDetailsReceived = new org.osflash.signals.Signal(Array);
        _playerEarnedStampReceived = new org.osflash.signals.Signal(Array);
        connection.getResponded().add(onResponded, this);
    } // End of the function
    function get playersStampsReceived()
    {
        return (_playersStampsReceived);
    } // End of the function
    function get recentlyEarnedStampsReceived()
    {
        return (_recentlyEarnedStampsReceived);
    } // End of the function
    function get playersStampBookCoverDetailsReceived()
    {
        return (_playersStampBookCoverDetailsReceived);
    } // End of the function
    function get playerEarnedStampReceived()
    {
        return (_playerEarnedStampReceived);
    } // End of the function
    function onResponded(responseType, responseData)
    {
        switch (responseType)
        {
            case com.clubpenguin.services.StampsService.GET_PLAYERS_STAMPS:
            {
                _playersStampsReceived.dispatch(responseData);
                break;
            } 
            case com.clubpenguin.services.StampsService.GET_MY_RECENTLY_EARNED_STAMPS:
            {
                _recentlyEarnedStampsReceived.dispatch(responseData);
                break;
            } 
            case com.clubpenguin.services.StampsService.GET_STAMP_BOOK_COVER_DETAILS:
            {
                _playersStampBookCoverDetailsReceived.dispatch(responseData);
                break;
            } 
            case com.clubpenguin.services.StampsService.RECEIVE_STAMP_EARNED:
            {
                _playerEarnedStampReceived.dispatch(responseData);
            } 
            default:
            {
                return;
            } 
        } // End of switch
    } // End of the function
    function sendStampEarned(stampID)
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.SEND_STAMP_EARNED, [stampID], messageFormat, -1);
        return (_recentlyEarnedStampsReceived);
    } // End of the function
    function getPlayersStamps(playerID)
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.GET_PLAYERS_STAMPS, [playerID], messageFormat, -1);
        return (_playersStampsReceived);
    } // End of the function
    function getMyRecentlyEarnedStamps()
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.GET_MY_RECENTLY_EARNED_STAMPS, [], messageFormat, -1);
        return (_recentlyEarnedStampsReceived);
    } // End of the function
    function getStampBookCoverDetails(playerID)
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.GET_STAMP_BOOK_COVER_DETAILS, [playerID], messageFormat, -1);
        return (_playersStampBookCoverDetailsReceived);
    } // End of the function
    function setStampBookCoverDetails(colourID, highlightID, patternID, claspID, coverItemDetails)
    {
        var _loc3 = [];
        var _loc4 = coverItemDetails.length;
        _loc3.push(colourID);
        _loc3.push(highlightID);
        _loc3.push(patternID);
        _loc3.push(claspID);
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            _loc3.push(coverItemDetails[_loc2]);
        } // end of for
        connection.sendXtMessage(extension, com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.SET_STAMP_BOOK_COVER_DETAILS, _loc3, messageFormat, -1);
        return (_playersStampBookCoverDetailsReceived);
    } // End of the function
    static var STAMPS_HANDLER = "st#";
    static var SEND_STAMP_EARNED = "sse";
    static var GET_PLAYERS_STAMPS = "gps";
    static var GET_MY_RECENTLY_EARNED_STAMPS = "gmres";
    static var GET_STAMP_BOOK_COVER_DETAILS = "gsbcd";
    static var SET_STAMP_BOOK_COVER_DETAILS = "ssbcd";
    static var RECEIVE_STAMP_EARNED = "aabs";
} // End of Class
