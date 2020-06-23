class com.clubpenguin.engine.tweener.SpecialPropertyModifier
{
    var modifyValues, getValue;
    function SpecialPropertyModifier(p_modifyFunction, p_getFunction)
    {
        modifyValues = p_modifyFunction;
        getValue = p_getFunction;
    } // End of the function
    function toString()
    {
        var _loc2 = "";
        _loc2 = _loc2 + "[SpecialPropertyModifier ";
        _loc2 = _loc2 + ("modifyValues:" + modifyValues.toString());
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("getValue:" + getValue.toString());
        _loc2 = _loc2 + "]";
        return (_loc2);
    } // End of the function
} // End of Class
