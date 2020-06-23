class com.clubpenguin.shell.analytics.OmnitureAnalytics extends com.clubpenguin.shell.analytics.BaseAnalytics
{
    var _shell;
    function OmnitureAnalytics(shell)
    {
        super(shell, new com.clubpenguin.shell.analytics.AnalyticsContext());
    } // End of the function
    function logItem(itemName, data)
    {
        if (!_shell.isValidString(itemName))
        {
            return (false);
        } // end if
        var _loc2 = Number(_shell.isMyPlayerMember());
        if (isNaN(_loc2))
        {
            _loc2 = -1;
        } // end if
        var _loc3 = this.buildOmnitureScript(itemName, _loc2);
        if (_shell.getEnvironment() != _shell.ENV_LOCAL)
        {
            getURL(_loc3, "");
            return (true);
        } // end if
        return (false);
    } // End of the function
    function buildOmnitureScript(itemName, membershipType)
    {
        var _loc2 = "javascript:cto=new CTO();";
        _loc2 = _loc2 + "cto.account=\"clubpenguin\";";
        _loc2 = _loc2 + "cto.category=\"dgame\";";
        _loc2 = _loc2 + "cto.site=\"clp\";";
        _loc2 = _loc2 + "cto.siteSection=\"play\";";
        _loc2 = _loc2 + ("cto.pageName=\"" + itemName + "_" + _shell.getLanguageAbbriviation() + "\";");
        _loc2 = _loc2 + "cto.contentType=\"activities\";";
        _loc2 = _loc2 + "cto.property=\"clp\";";
        _loc2 = _loc2 + ("cto.membershipType=\"" + membershipType + "\";");
        _loc2 = _loc2 + "cto.track();";
        return (_loc2);
    } // End of the function
    function toString()
    {
        return ("[OmnitureAnalytics]");
    } // End of the function
} // End of Class
