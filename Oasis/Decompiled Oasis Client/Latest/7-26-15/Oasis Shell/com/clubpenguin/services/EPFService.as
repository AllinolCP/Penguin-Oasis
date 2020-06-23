class com.clubpenguin.services.EPFService extends com.clubpenguin.services.AbstractService
{
    var _agentStatusReceived, _fieldOpStatusReceived, _pointsReceived, _itemBought, messageFormat, extension, connection, __get__agentStatusReceived, __get__fieldOpStatusReceived, __get__itemBought, __get__pointsReceived;
    function EPFService(connection)
    {
        super(connection);
        _agentStatusReceived = new org.osflash.signals.Signal(Boolean);
        _fieldOpStatusReceived = new org.osflash.signals.Signal(Number);
        _pointsReceived = new org.osflash.signals.Signal(Number, Number);
        _itemBought = new org.osflash.signals.Signal(Number);
        connection.getResponded().add(onResponded, this);
    } // End of the function
    function get agentStatusReceived()
    {
        return (_agentStatusReceived);
    } // End of the function
    function get fieldOpStatusReceived()
    {
        return (_fieldOpStatusReceived);
    } // End of the function
    function get pointsReceived()
    {
        return (_pointsReceived);
    } // End of the function
    function get itemBought()
    {
        return (_itemBought);
    } // End of the function
    function onResponded(responseType, responseData)
    {
        switch (responseType)
        {
            case com.clubpenguin.services.EPFService.SET_AGENT_STATUS:
            {
                this.dispatchAgentStatusReceived("1");
                break;
            } 
            case com.clubpenguin.services.EPFService.GET_AGENT_STATUS:
            {
                this.dispatchAgentStatusReceived(responseData[1]);
                break;
            } 
            case com.clubpenguin.services.EPFService.GET_FIELD_OP_STATUS:
            case com.clubpenguin.services.EPFService.SET_FIELD_OP_STATUS:
            {
                this.dispatchFieldOpStatusReceived(responseData[1]);
                break;
            } 
            case com.clubpenguin.services.EPFService.GET_POINTS:
            {
                this.dispatchPointsReceived(responseData[1], responseData[2]);
                break;
            } 
            case com.clubpenguin.services.EPFService.BUY_ITEM:
            {
                this.dispatchItemBought(responseData[1]);
            } 
        } // End of switch
    } // End of the function
    function dispatchAgentStatusReceived(agentStatus)
    {
        _agentStatusReceived.dispatch(Boolean(Number(agentStatus)));
    } // End of the function
    function dispatchFieldOpStatusReceived(fieldOpStatus)
    {
        _fieldOpStatusReceived.dispatch(Number(fieldOpStatus));
    } // End of the function
    function dispatchItemBought(unusedPoints)
    {
        _itemBought.dispatch(Number(unusedPoints));
    } // End of the function
    function dispatchPointsReceived(totalPoints, unusedPoints)
    {
        _pointsReceived.dispatch(Number(unusedPoints), Number(totalPoints));
    } // End of the function
    function getAgentStatus()
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.GET_AGENT_STATUS, [], messageFormat, -1);
        return (_agentStatusReceived);
    } // End of the function
    function setAgentStatus()
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.SET_AGENT_STATUS, [], messageFormat, -1);
        return (_agentStatusReceived);
    } // End of the function
    function getFieldOpStatus()
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.GET_FIELD_OP_STATUS, [], messageFormat, -1);
        return (_fieldOpStatusReceived);
    } // End of the function
    function setFieldOpStatus(fieldOpStatus)
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.SET_FIELD_OP_STATUS, [fieldOpStatus], messageFormat, -1);
        return (_fieldOpStatusReceived);
    } // End of the function
    function getPoints()
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.GET_POINTS, [], messageFormat, -1);
        return (_pointsReceived);
    } // End of the function
    function buyItem(itemID)
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.BUY_ITEM, [itemID], messageFormat, -1);
        return (_itemBought);
    } // End of the function
    static var EPF_HANDLER = "f#";
    static var GET_AGENT_STATUS = "epfga";
    static var SET_AGENT_STATUS = "epfsa";
    static var GET_FIELD_OP_STATUS = "epfgf";
    static var SET_FIELD_OP_STATUS = "epfsf";
    static var GET_POINTS = "epfgr";
    static var BUY_ITEM = "epfai";
} // End of Class
