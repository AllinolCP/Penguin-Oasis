class com.clubpenguin.engine.tweener.SpecialProperty
{
    var getValue, setValue, parameters, preProcess;
    function SpecialProperty(p_getFunction, p_setFunction, p_parameters, p_preProcessFunction)
    {
        getValue = p_getFunction;
        setValue = p_setFunction;
        parameters = p_parameters;
        preProcess = p_preProcessFunction;
    } // End of the function
    function toString()
    {
        var _loc2 = "";
        _loc2 = _loc2 + "[SpecialProperty ";
        _loc2 = _loc2 + ("getValue:" + getValue.toString());
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("setValue:" + setValue.toString());
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("parameters:" + parameters.toString());
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("preProcess:" + preProcess.toString());
        _loc2 = _loc2 + "]";
        return (_loc2);
    } // End of the function
} // End of Class
