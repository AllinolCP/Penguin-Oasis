class com.clubpenguin.achievements.AchievementResult
{
    var _shell, _debug, _callbackFunc, _callbackParams, __get__shell, __get__debug, __set__debug, __set__shell;
    function AchievementResult(shell, descriptor, debug)
    {
        _shell = shell;
        _debug = debug;
        var _loc3 = String(descriptor.shift());
        this.debugTrace("Constructor - command:" + _loc3 + " params:\'" + descriptor + "\'");
        switch (_loc3)
        {
            case "trace":
            {
                _callbackFunc = trace;
                _callbackParams = [descriptor.join(" ")];
                break;
            } 
            case com.clubpenguin.achievements.AchievementResult.ACHIEVEMENTRESULT_CALLBACK:
            {
                _callbackFunc = descriptor[0];
                _callbackParams = [this];
                break;
            } 
            case com.clubpenguin.achievements.AchievementResult.ACHIEVEMENTRESULT_BROADCAST:
            {
                _callbackFunc = com.clubpenguin.util.Delegate.create(shell, shell.updateListeners);
                _callbackParams = descriptor;
                break;
            } 
            case com.clubpenguin.achievements.AchievementResult.ACHIEVEMENTRESULT_STAMPEARNED:
            {
                _callbackFunc = com.clubpenguin.util.Delegate.create(shell, shell.stampEarned);
                _callbackParams = [descriptor[0], false];
                break;
            } 
            default:
            {
                throw new com.clubpenguin.achievements.AchievementException("Result command not recognised:\"" + _loc3 + "\"");
                break;
            } 
        } // End of switch
    } // End of the function
    function fire()
    {
        _callbackFunc.apply(null, _callbackParams);
    } // End of the function
    function set shell(s)
    {
        _shell = s;
        //return (this.shell());
        null;
    } // End of the function
    function set debug(d)
    {
        _debug = d;
        //return (this.debug());
        null;
    } // End of the function
    function destroy()
    {
        _callbackFunc = null;
        _callbackParams = null;
    } // End of the function
    function debugTrace(msg)
    {
        if (_debug)
        {
        } // end if
    } // End of the function
    static var ACHIEVEMENTRESULT_CALLBACK = "callback";
    static var ACHIEVEMENTRESULT_BROADCAST = "broadcast";
    static var ACHIEVEMENTRESULT_STAMPEARNED = "stampEarned";
} // End of Class
