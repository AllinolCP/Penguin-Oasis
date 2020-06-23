class com.clubpenguin.shell.analytics.WebLoggerAnalytics extends com.clubpenguin.shell.analytics.BaseAnalytics
{
    var _context, _webLoggerContext, _shell, containsPrefix;
    function WebLoggerAnalytics(shell)
    {
        super(shell, new com.clubpenguin.shell.analytics.WebLoggerContext());
        _webLoggerContext = (com.clubpenguin.shell.analytics.WebLoggerContext)(_context);
    } // End of the function
    function getContext()
    {
        return (_webLoggerContext);
    } // End of the function
    function setContext(context)
    {
        super.setContext(context);
        _webLoggerContext = (com.clubpenguin.shell.analytics.WebLoggerContext)(context);
    } // End of the function
    function logItem(itemName, data)
    {
        if (!_shell.isValidString(itemName))
        {
            return (false);
        } // end if
        var _loc3 = this.getItemCategory(itemName);
        if (_loc3 == undefined || _loc3.length == 0)
        {
            return (false);
        } // end if
        var _loc4 = _shell.getMyPlayerObject().player_id;
        var _loc5 = _loc4 == undefined ? ("0") : (String(_loc4));
        var _loc2 = new LoadVars();
        _loc2.land = "1";
        _loc2.user = _loc5;
        _loc2.event = _loc3;
        _loc2.data = itemName + "|" + _shell.getLanguageAbbriviation() + this.parseCustomDataToString(data);
        _loc2.debug = 0;
        _loc2.onLoad = function (success)
        {
        };
        if (_shell.getEnvironment() != _shell.ENV_LOCAL)
        {
            _loc2.sendAndLoad(LOGGER_URL, _loc2, "POST");
            return (true);
        } // end if
        return (false);
    } // End of the function
    function getItemCategory(itemName)
    {
        if (this.containsPrefix(itemName, "oops"))
        {
            itemName = "oops";
        } // end if
        //return (_webLoggerContext.categoryIndexMap()[_webLoggerContext.__get__categoryMap()[itemName]]);
    } // End of the function
    function parseCustomDataToString(customData)
    {
        var _loc2 = "";
        if (customData == null || customData.length == 0)
        {
            return (_loc2);
        } // end if
        for (var _loc1 = 0; _loc1 < customData.length; ++_loc1)
        {
            _loc2 = _loc2 + ("|" + String(customData[_loc1]));
        } // end of for
        return (_loc2);
    } // End of the function
    function toString()
    {
        return ("[WebLoggerAnalytics]");
    } // End of the function
    var LOGGER_URL = "http://play.oasis.ps/en/web_service/analytics_log.php";
} // End of Class
