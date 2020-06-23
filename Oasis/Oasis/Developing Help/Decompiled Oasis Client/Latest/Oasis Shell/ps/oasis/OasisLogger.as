class ps.oasis.OasisLogger
{
    function OasisLogger()
    {
    } // End of the function
    static function info(logMessage)
    {
        trace (ps.oasis.OasisLogger.getLevelAsString(1) + " " + ps.oasis.OasisLogger.getTimestamp() + ": " + logMessage);
    } // End of the function
    static function success(logMessage)
    {
        trace (ps.oasis.OasisLogger.getLevelAsString(6) + " " + ps.oasis.OasisLogger.getTimestamp() + ": " + logMessage);
    } // End of the function
    static function error(logMessage)
    {
        trace (ps.oasis.OasisLogger.getLevelAsString(4) + " " + ps.oasis.OasisLogger.getTimestamp() + ": " + logMessage);
    } // End of the function
    static function warn(logMessage)
    {
        trace (ps.oasis.OasisLogger.getLevelAsString(3) + " " + ps.oasis.OasisLogger.getTimestamp() + ": " + logMessage);
    } // End of the function
    static function warning(logMessage)
    {
        trace (ps.oasis.OasisLogger.getLevelAsString(3) + " " + ps.oasis.OasisLogger.getTimestamp() + ": " + logMessage);
    } // End of the function
    static function debug(logMessage)
    {
        trace (ps.oasis.OasisLogger.getLevelAsString(2) + " " + ps.oasis.OasisLogger.getTimestamp() + ": " + logMessage);
    } // End of the function
    static function getLevelAsString(level)
    {
        switch (level)
        {
            case 1:
            {
                return ("[INFO]");
            } 
            case 2:
            {
                return ("[DEBUG]");
            } 
            case 3:
            {
                return ("[WARNING]");
            } 
            case 4:
            {
                return ("[*ERROR*]");
            } 
            case 5:
            {
                return ("[***FATAL***]");
            } 
            case 6:
            {
                return ("[SUCCESS]");
            } 
        } // End of switch
        return ("[???]");
    } // End of the function
    static function getTimestamp()
    {
        var _loc1 = new Date();
        return (ps.oasis.OasisLogger.stringPadNumber(_loc1.getHours() + 1, 2) + ":" + ps.oasis.OasisLogger.stringPadNumber(_loc1.getMinutes(), 2) + ":" + ps.oasis.OasisLogger.stringPadNumber(_loc1.getSeconds(), 2) + "::" + ps.oasis.OasisLogger.stringPadNumber(_loc1.getMilliseconds(), 3));
    } // End of the function
    static function stringPadNumber(num, padding)
    {
        var _loc2 = "" + num;
        for (var _loc1 = 1; _loc1 <= padding - 1; ++_loc1)
        {
            if (num / Math.pow(10, _loc1) < 1)
            {
                _loc2 = "0" + _loc2;
            } // end if
        } // end of for
        return (_loc2);
    } // End of the function
} // End of Class
