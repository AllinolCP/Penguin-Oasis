class com.clubpenguin.services.EquipmentService extends com.clubpenguin.services.AbstractService
{
    var _handItemEquipped, messageFormat, extension, connection, __get__handItemEquipped;
    function EquipmentService(connection)
    {
        super(connection);
        _handItemEquipped = new org.osflash.signals.Signal(Number, Number);
        connection.getResponded().add(onResponded, this);
    } // End of the function
    function get handItemEquipped()
    {
        return (_handItemEquipped);
    } // End of the function
    function onResponded(responseType, responseData)
    {
        if (responseType !== com.clubpenguin.services.EquipmentService.UPDATE_PLAYER_HAND)
        {
        }
        else
        {
            this.onHandItemEquipped(responseData);
        } // end else if
    } // End of the function
    function equipHandItem(handItemID)
    {
        connection.sendXtMessage(extension, com.clubpenguin.services.EquipmentService.SETTING_HANDLER + com.clubpenguin.services.EquipmentService.UPDATE_PLAYER_HAND, [handItemID], messageFormat, -1);
        return (_handItemEquipped);
    } // End of the function
    function onHandItemEquipped(responseData)
    {
        var _loc2 = Number(responseData[1]);
        var _loc3 = Number(responseData[2]);
        _handItemEquipped.dispatch(_loc2, _loc3);
    } // End of the function
    static var SETTING_HANDLER = "s#";
    static var UPDATE_PLAYER_HAND = "upa";
} // End of Class
