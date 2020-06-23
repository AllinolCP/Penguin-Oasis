class com.clubpenguin.games.cardjitsu.waterserver.WaterGameCard
{
    var __uid, __id, __suit, __value, __colour, __special, __get__serialized, __get__id, __get__isSpecial, __get__suit, __get__suitValue, __get__value;
    function WaterGameCard(_cardID)
    {
        var _loc3;
        _loc3 = com.clubpenguin.game.cardjitsu.data.CardData.getCardData()[_cardID];
        if (_loc3 == null || _loc3 == "")
        {
        } // end if
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.waterserver.WaterGameCard.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.waterserver.WaterGameCard.$_instanceCount;
        var _loc2;
        _loc2 = _loc3.split("|");
        __id = parseInt(_loc2[0]);
        __suit = _loc2[1];
        __value = parseInt(_loc2[2]);
        __colour = _loc2[3];
        __special = _loc2[4] != "0";
    } // End of the function
    function get id()
    {
        return (__id);
    } // End of the function
    function get suit()
    {
        return (__suit);
    } // End of the function
    function get suitValue()
    {
        var _loc2;
        switch (__suit)
        {
            case "f":
            {
                _loc2 = 0;
                break;
            } 
            case "w":
            {
                _loc2 = 1;
                break;
            } 
            case "s":
            {
                _loc2 = 2;
                break;
            } 
            default:
            {
                _loc2 = 3;
            } 
        } // End of switch
        return (_loc2);
    } // End of the function
    function get value()
    {
        return (__value);
    } // End of the function
    function get isSpecial()
    {
        return (__special);
    } // End of the function
    function get serialized()
    {
        var _loc2;
        _loc2 = __id + "|" + __suit + "|" + __value + "|" + __colour + "|" + __special;
        return (_loc2);
    } // End of the function
    function getUniqueName()
    {
        return ("[WaterGameCard<" + __uid + ">]");
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "[" + this.__get__serialized() + "]";
        return (_loc2);
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
