class com.clubpenguin.engine.tweener.PropertyInfoObj
{
    var valueStart, valueComplete, originalValueComplete, arrayIndex, extra, isSpecialProperty, hasModifier, modifierFunction, modifierParameters;
    function PropertyInfoObj(p_valueStart, p_valueComplete, p_originalValueComplete, p_arrayIndex, p_extra, p_isSpecialProperty, p_modifierFunction, p_modifierParameters)
    {
        valueStart = p_valueStart;
        valueComplete = p_valueComplete;
        originalValueComplete = p_originalValueComplete;
        arrayIndex = p_arrayIndex;
        extra = p_extra;
        isSpecialProperty = p_isSpecialProperty;
        hasModifier = p_modifierFunction != undefined;
        modifierFunction = p_modifierFunction;
        modifierParameters = p_modifierParameters;
    } // End of the function
    function clone()
    {
        var _loc2 = new com.clubpenguin.engine.tweener.PropertyInfoObj(valueStart, valueComplete, originalValueComplete, arrayIndex, extra, isSpecialProperty, modifierFunction, modifierParameters);
        return (_loc2);
    } // End of the function
    function toString()
    {
        var _loc2 = "\n[PropertyInfoObj ";
        _loc2 = _loc2 + ("valueStart:" + String(valueStart));
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("valueComplete:" + String(valueComplete));
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("originalValueComplete:" + String(originalValueComplete));
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("arrayIndex:" + String(arrayIndex));
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("extra:" + String(extra));
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("isSpecialProperty:" + String(isSpecialProperty));
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("hasModifier:" + String(hasModifier));
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("modifierFunction:" + String(modifierFunction));
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("modifierParameters:" + String(modifierParameters));
        _loc2 = _loc2 + "]\n";
        return (_loc2);
    } // End of the function
} // End of Class
