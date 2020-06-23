class com.clubpenguin.games.cardjitsu.water.ElementData
{
    var __type, __amount, __get__type, __get__amount, __set__type, __set__amount, __get__displayAmount, __get__letter;
    static var __elementChar;
    function ElementData(_type, _amount)
    {
        if (!this.isValidType(_type))
        {
            return;
        } // end if
        if (!this.isValidAmount(_amount))
        {
            return;
        } // end if
        this.init(_type, _amount);
    } // End of the function
    function init(_type, _amount)
    {
        __elementChar = new Array();
        com.clubpenguin.games.cardjitsu.water.ElementData.__elementChar[com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_FIRE] = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_FIRE_LETTER;
        com.clubpenguin.games.cardjitsu.water.ElementData.__elementChar[com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_WATER] = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_WATER_LETTER;
        com.clubpenguin.games.cardjitsu.water.ElementData.__elementChar[com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_SNOW] = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_SNOW_LETTER;
        com.clubpenguin.games.cardjitsu.water.ElementData.__elementChar[com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY] = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY_LETTER;
        com.clubpenguin.games.cardjitsu.water.ElementData.__elementChar[com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_OBSTACLE] = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_OBSTACLE_LETTER;
        __type = _type;
        __amount = _amount;
    } // End of the function
    function get type()
    {
        return (__type);
    } // End of the function
    function set type(_type)
    {
        if (!this.isValidType(_type))
        {
            return;
        } // end if
        __type = _type;
        //return (this.type());
        null;
    } // End of the function
    function get amount()
    {
        return (__amount);
    } // End of the function
    function get displayAmount()
    {
        return (Math.min(com.clubpenguin.games.cardjitsu.water.ElementData.ELEMENT_STATES, Math.ceil(__amount / com.clubpenguin.games.cardjitsu.water.ElementData.ELEMENT_RATE)));
    } // End of the function
    function set amount(_amount)
    {
        if (!this.isValidAmount(_amount))
        {
            return;
        } // end if
        __amount = _amount;
        //return (this.amount());
        null;
    } // End of the function
    function get letter()
    {
        return (com.clubpenguin.games.cardjitsu.water.ElementData.__elementChar[__type]);
    } // End of the function
    function changeAmount(_change)
    {
        __amount = __amount + _change;
    } // End of the function
    function isValidType(_type)
    {
        switch (_type)
        {
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_EMPTY:
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_FIRE:
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_WATER:
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_SNOW:
            case com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_OBSTACLE:
            {
                return (true);
                break;
            } 
            default:
            {
                return (false);
                break;
            } 
        } // End of switch
    } // End of the function
    function isValidAmount(_amount)
    {
        if (_amount == undefined || _amount < 0 && _amount > com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_VALUE_MAX)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "[ElementData]: ";
        _loc2 = _loc2 + ("type: " + com.clubpenguin.games.cardjitsu.water.ElementData.__elementChar[__type] + "-" + com.clubpenguin.games.cardjitsu.water.ElementData.__elements[__type] + "(" + __type + "), value(" + __amount + ")");
        return (_loc2);
    } // End of the function
    function validate(_type, _amount)
    {
        this.__set__type(_type);
        this.__set__amount(_amount);
    } // End of the function
    static var ELEMENT_STATES = 20;
    static var ELEMENT_RATE = 1;
    static var __elements = ["FIRE", "WATER", "SNOW", "EMPTY", "OBSTACLE"];
} // End of Class
