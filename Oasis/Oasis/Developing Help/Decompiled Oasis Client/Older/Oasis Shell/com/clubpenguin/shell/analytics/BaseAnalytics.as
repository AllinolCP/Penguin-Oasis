class com.clubpenguin.shell.analytics.BaseAnalytics implements com.clubpenguin.shell.analytics.IAnalytics
{
    var _shell, _context;
    function BaseAnalytics(shell, context)
    {
        _shell = shell;
        _context = context;
    } // End of the function
    function trackEvent(eventName, data)
    {
        if (this.isBlocked(eventName))
        {
            return (false);
        } // end if
        return (this.logItem(eventName, data));
    } // End of the function
    function trackContent(itemName, data)
    {
        if (this.isBlocked(itemName))
        {
            return (false);
        } // end if
        return (this.logItem(itemName, data));
    } // End of the function
    function trackMiniGame(gameName, data)
    {
        if (this.isBlocked(gameName))
        {
            return (false);
        } // end if
        return (this.logItem(gameName, data));
    } // End of the function
    function trackRoomJoin(roomName, data)
    {
        if (this.isBlocked(com.clubpenguin.shell.analytics.BaseAnalytics.ROOM_JOIN_PREFIX + roomName))
        {
            return (false);
        } // end if
        return (this.logItem(com.clubpenguin.shell.analytics.BaseAnalytics.ROOM_JOIN_PREFIX + roomName, data));
    } // End of the function
    function trackIglooJoin(data)
    {
        if (this.isBlocked(com.clubpenguin.shell.analytics.BaseAnalytics.IGLOO_JOIN_PREFIX))
        {
            return (false);
        } // end if
        return (this.logItem(com.clubpenguin.shell.analytics.BaseAnalytics.IGLOO_JOIN_PREFIX, data));
    } // End of the function
    function getContext()
    {
        return (_context);
    } // End of the function
    function setContext(context)
    {
        _context = context;
    } // End of the function
    function containsSuffix(itemName, suffix)
    {
        var _loc1 = itemName.lastIndexOf(suffix);
        if (_loc1 == -1)
        {
            return (false);
        } // end if
        var _loc2 = suffix.length;
        if (_loc1 + _loc2 == itemName.length)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function containsPrefix(itemName, prefix)
    {
        if (itemName.indexOf(prefix) == 0)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function containsSubString(itemName, subString)
    {
        return (itemName.indexOf(subString) != -1);
    } // End of the function
    function isItemOverriden(itemName, override)
    {
        return (this.containsPrefix(itemName, override));
    } // End of the function
    function isBlocked(itemName)
    {
        if (!this.getContext().__get__isEnabled())
        {
            return (true);
        } // end if
        var _loc3 = _context.__get__blockedOverrides().length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (this.isItemOverriden(itemName, this.getContext().__get__blockedOverrides()[_loc2]))
            {
                return (false);
            } // end if
        } // end of for
        if (this.getContext().__get__isBlockingAll())
        {
            return (true);
        } // end if
        _loc3 = this.getContext().__get__blockedPrefixes().length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (this.containsPrefix(itemName, this.getContext().__get__blockedPrefixes()[_loc2]))
            {
                return (true);
            } // end if
        } // end of for
        _loc3 = this.getContext().__get__blockedSuffixes().length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (this.containsSuffix(itemName, this.getContext().__get__blockedSuffixes()[_loc2]))
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    function logItem(itemName, data)
    {
        throw new Error("BaseAnalytics: Inheriting classes must implement logItem(itemName:String, data:Array):Boolean");
        return (false);
    } // End of the function
    function toString()
    {
        return ("[BaseAnalytics]");
    } // End of the function
    static var ROOM_JOIN_PREFIX = "room_";
    static var IGLOO_JOIN_PREFIX = "igloo";
} // End of Class
