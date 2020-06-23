class com.clubpenguin.engine.tweener.AuxFunctions
{
    function AuxFunctions()
    {
    } // End of the function
    static function numberToR(p_num)
    {
        return ((p_num & 16711680) >> 16);
    } // End of the function
    static function numberToG(p_num)
    {
        return ((p_num & 65280) >> 8);
    } // End of the function
    static function numberToB(p_num)
    {
        return (p_num & 255);
    } // End of the function
    static function isInArray(p_string, p_array)
    {
        var _loc2 = p_array.length;
        for (var _loc1 = 0; _loc1 < _loc2; ++_loc1)
        {
            if (p_array[_loc1] == p_string)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function getObjectLength(p_object)
    {
        var _loc1 = 0;
        for (var _loc2 in p_object)
        {
            ++_loc1;
        } // end of for...in
        return (_loc1);
    } // End of the function
    static function concatObjects()
    {
        var _loc3 = {};
        var _loc2;
        for (var _loc4 = 0; _loc4 < arguments.length; ++_loc4)
        {
            _loc2 = arguments[_loc4];
            for (var _loc5 in _loc2)
            {
                if (_loc2[_loc5] == null)
                {
                    delete _loc3[_loc5];
                    continue;
                } // end if
                _loc3[_loc5] = _loc2[_loc5];
            } // end of for...in
        } // end of for
        return (_loc3);
    } // End of the function
} // End of Class
