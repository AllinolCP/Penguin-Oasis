class com.clubpenguin.services.MailService extends com.clubpenguin.services.AbstractService
{
    var _inboxReceived, _postCardReceived, messageFormat, extension, connection, __get__inboxReceived, __get__postCardReceived;
    function MailService(connection)
    {
        super(connection);
        _inboxReceived = new org.osflash.signals.Signal(com.clubpenguin.mail.Inbox);
        _postCardReceived = new org.osflash.signals.Signal(com.clubpenguin.mail.Postcard);
        connection.getResponded().add(onResponded, this);
    } // End of the function
    function get inboxReceived()
    {
        return (_inboxReceived);
    } // End of the function
    function get postCardReceived()
    {
        return (_postCardReceived);
    } // End of the function
    function onResponded(responseType, responseData)
    {
        switch (responseType)
        {
            case GET_MAIL:
            {
                this.onInboxReceived(responseData);
                break;
            } 
            case RECEIVE_MAIL:
            {
                this.onPostCardReceived(responseData);
                break;
            } 
        } // End of switch
    } // End of the function
    function getInbox()
    {
        connection.sendXtMessage(extension, MAIL_HANDLER + GET_MAIL, [], messageFormat, -1);
        return (_inboxReceived);
    } // End of the function
    function onInboxReceived(responseData)
    {
        var _loc2 = responseData.splice(1);
        var _loc3 = com.clubpenguin.mail.Inbox.getInboxFromRawArray(_loc2);
        _inboxReceived.dispatch(_loc3);
    } // End of the function
    function onPostCardReceived(responseData)
    {
        var _loc2 = responseData.splice(1);
        var _loc3 = com.clubpenguin.mail.Postcard.getPostCardFromRawArray(_loc2);
        _postCardReceived.dispatch(_loc3);
    } // End of the function
    var MAIL_HANDLER = "l#";
    var GET_MAIL = "mg";
    var RECEIVE_MAIL = "mr";
} // End of Class
