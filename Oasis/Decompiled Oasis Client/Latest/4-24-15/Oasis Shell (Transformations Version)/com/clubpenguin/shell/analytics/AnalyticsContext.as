class com.clubpenguin.shell.analytics.AnalyticsContext
{
    var _blockedPrefixes, _blockedSuffixes, _blockedOverrides, _isEnabled, _isBlockingAll, __set__isEnabled, __set__isBlockingAll, __get__isEnabled, __get__isBlockingAll, __get__blockedPrefixes, __get__blockedSuffixes, __get__blockedOverrides, __set__blockedOverrides, __set__blockedPrefixes, __set__blockedSuffixes;
    function AnalyticsContext()
    {
        _blockedPrefixes = [];
        _blockedSuffixes = [];
        _blockedOverrides = [];
        _isEnabled = true;
        _isBlockingAll = false;
    } // End of the function
    function initFromConfig(config)
    {
        this.appendBlockedPrefixes(config.blockedPrefixes);
        this.appendBlockedSuffixes(config.blockedSuffixes);
        this.appendBlockedOverrides(config.blockedOverrides);
        this.__set__isEnabled(config.enabled != undefined ? (config.enabled) : (false));
        this.__set__isBlockingAll(config.blockAll);
    } // End of the function
    function get isEnabled()
    {
        return (_isEnabled);
    } // End of the function
    function set isEnabled(isEnabled)
    {
        _isEnabled = isEnabled != undefined ? (isEnabled) : (false);
        //return (this.isEnabled());
        null;
    } // End of the function
    function get isBlockingAll()
    {
        return (_isBlockingAll);
    } // End of the function
    function set isBlockingAll(isBlockingAll)
    {
        _isBlockingAll = isBlockingAll != undefined ? (isBlockingAll) : (false);
        //return (this.isBlockingAll());
        null;
    } // End of the function
    function get blockedPrefixes()
    {
        return (_blockedPrefixes);
    } // End of the function
    function set blockedPrefixes(prefixes)
    {
        _blockedPrefixes = prefixes != undefined ? (prefixes) : ([]);
        //return (this.blockedPrefixes());
        null;
    } // End of the function
    function get blockedSuffixes()
    {
        return (_blockedSuffixes);
    } // End of the function
    function set blockedSuffixes(suffixes)
    {
        _blockedSuffixes = suffixes != undefined ? (suffixes) : ([]);
        //return (this.blockedSuffixes());
        null;
    } // End of the function
    function get blockedOverrides()
    {
        return (_blockedOverrides);
    } // End of the function
    function set blockedOverrides(overrides)
    {
        _blockedOverrides = overrides != undefined ? (overrides) : ([]);
        //return (this.blockedOverrides());
        null;
    } // End of the function
    function appendBlockedPrefixes(arr)
    {
        if (arr == undefined)
        {
            return;
        } // end if
        _blockedPrefixes = _blockedPrefixes.concat(arr);
    } // End of the function
    function appendBlockedSuffixes(arr)
    {
        if (arr == undefined)
        {
            return;
        } // end if
        _blockedSuffixes = _blockedSuffixes.concat(arr);
    } // End of the function
    function appendBlockedOverrides(arr)
    {
        if (arr == undefined)
        {
            return;
        } // end if
        _blockedOverrides = _blockedOverrides.concat(arr);
    } // End of the function
    function toString()
    {
        var _loc2 = "AnalyticsContext:";
        _loc2 = _loc2 + ("\n   isEnabled=" + this.__get__isEnabled());
        _loc2 = _loc2 + ("\n   isBlockingAll=" + this.__get__isBlockingAll());
        _loc2 = _loc2 + ("\n   _blockedPrefixes=" + _blockedPrefixes);
        _loc2 = _loc2 + ("\n   _blockedSuffixes=" + _blockedSuffixes);
        _loc2 = _loc2 + ("\n   _blockedOverrides=" + _blockedOverrides);
        return (_loc2);
    } // End of the function
} // End of Class
