class com.clubpenguin.engine.tweener.SpecialPropertySplitter
{
    var parameters;
    function SpecialPropertySplitter(p_splitFunction, p_parameters)
    {
        splitValues = p_splitFunction;
        parameters = p_parameters;
    } // End of the function
    function splitValues(p_value, p_parameters)
    {
        return ([]);
    } // End of the function
    function toString()
    {
        var _loc2 = "";
        _loc2 = _loc2 + "[SpecialPropertySplitter ";
        _loc2 = _loc2 + ("splitValues:" + splitValues.toString());
        _loc2 = _loc2 + ", ";
        _loc2 = _loc2 + ("parameters:" + parameters.toString());
        _loc2 = _loc2 + "]";
        return (_loc2);
    } // End of the function
} // End of Class
