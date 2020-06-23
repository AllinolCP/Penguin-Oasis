class com.clubpenguin.games.cardjitsu.water.card.GameCardDefinition
{
    var __handID, __uid, __element, __color, __special, __template, __get__color, __get__element, __get__handID, __get__rgbColor, __get__rgbGlow, __get__special, __get__template, __get__uid;
    function GameCardDefinition(_template, _handID)
    {
        var _loc2;
        var _loc3;
        if (_template == undefined)
        {
            _loc3 = "ERROR: Template not specified for card definition";
        } // end if
        _loc2 = _template.split("|");
        __handID = _handID;
        if (_loc2.length < com.clubpenguin.game.cardjitsu.data.CardData.TOTAL_CARD_ATTRIBUTES)
        {
            _loc3 = "ERROR: Inproperly formatted template [" + _template + "]";
        } // end if
        if (_loc3 != undefined)
        {
            return;
        }
        else
        {
            __uid = _loc2[com.clubpenguin.game.cardjitsu.data.CardData.ATTRIBUTE_UID];
            __element = new com.clubpenguin.games.cardjitsu.water.ElementData(this.elementIndexMap(_loc2[com.clubpenguin.game.cardjitsu.data.CardData.ATTRIBUTE_ELEMENT]), _loc2[com.clubpenguin.game.cardjitsu.data.CardData.ATTRIBUTE_VALUE]);
            __color = _loc2[com.clubpenguin.game.cardjitsu.data.CardData.ATTRIBUTE_COLOR];
            __special = _loc2[com.clubpenguin.game.cardjitsu.data.CardData.ATTRIBUTE_SPECIAL];
            __template = _template;
        } // end else if
    } // End of the function
    function elementIndexMap(_elementString)
    {
        var _loc1;
        switch (_elementString)
        {
            case "w":
            {
                _loc1 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_WATER;
                break;
            } 
            case "s":
            {
                _loc1 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_SNOW;
                break;
            } 
            case "f":
            {
                _loc1 = com.clubpenguin.games.cardjitsu.water.ProjectConstants.ELEMENT_FIRE;
                break;
            } 
            default:
            {
                _loc1 = -1;
            } 
        } // End of switch
        return (_loc1);
    } // End of the function
    function get uid()
    {
        return (__uid);
    } // End of the function
    function get handID()
    {
        if (__handID == undefined)
        {
            return (__uid.toString());
        } // end if
        return (__handID);
    } // End of the function
    function get element()
    {
        return (__element);
    } // End of the function
    function get color()
    {
        return (__color);
    } // End of the function
    function get special()
    {
        return (__special);
    } // End of the function
    function get template()
    {
        return (__template);
    } // End of the function
    function get rgbColor()
    {
        return (com.clubpenguin.game.cardjitsu.data.CardData.getBorderColor(__color));
    } // End of the function
    function get rgbGlow()
    {
        return (com.clubpenguin.game.cardjitsu.data.CardData.getGlowColor(__color));
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "Card-Jitsu GameCardDefinition " + __handID + "(" + __template + ")";
        return (_loc2);
    } // End of the function
} // End of Class
