class com.clubpenguin.login.Tools
{
    function Tools()
    {
    } // End of the function
    static function isValidPassword(pass)
    {
        var _loc2 = _global.getCurrentShell();
        pass = String(pass);
        var _loc4 = pass.length;
        if (!_loc2.isValidString(pass))
        {
            _loc2.$e("[login] isValidPassword() -> No password passed to login", {error_code: _loc2.PASSWORD_REQUIRED});
            return (false);
        } // end if
        if (_loc4 < com.clubpenguin.login.Tools.MIN_PASS_LENGTH)
        {
            _loc2.$e("[login] isValidPassword() -> Password too short", {error_code: _loc2.PASSWORD_SHORT});
            return (false);
        } // end if
        if (_loc4 > com.clubpenguin.login.Tools.MAX_PASS_LENGTH)
        {
            _loc2.$e("[login] isValidPassword() -> Password too long", {error_code: _loc2.PASSWORD_LONG});
            return (false);
        } // end if
        return (true);
    } // End of the function
    static function isValidUsername(username)
    {
        var _loc2 = _global.getCurrentShell();
        username = String(username);
        var _loc4 = username.length;
        if (!_loc2.isValidString(username))
        {
            _loc2.$e("[login] isValidUsername() -> No username passed to login", {error_code: _loc2.NAME_REQUIRED});
            return (false);
        } // end if
        if (_loc4 < com.clubpenguin.login.Tools.MIN_USERNAME_LENGTH)
        {
            _loc2.$e("[login] isValidUsername() -> Username too short", {error_code: _loc2.NAME_SHORT});
            return (false);
        } // end if
        if (_loc4 > com.clubpenguin.login.Tools.MAX_USERNAME_LENGTH)
        {
            _loc2.$e("[login] isValidUsername() -> Username too long", {error_code: _loc2.NAME_LONG});
            return (false);
        } // end if
        return (true);
    } // End of the function
    static function getTrackingAppend()
    {
        var _loc2 = _global.getCurrentShell();
        var _loc4 = _loc2.getLanguageAbbriviation();
        var _loc3 = "";
        if (_loc2.getAffilateId() != 1)
        {
            _loc3 = "?playhome_" + _loc4;
        } // end if
        return (_loc3);
    } // End of the function
    static function makeCheckboxToggle(mc)
    {
        if (mc._currentframe == mc._totalframes)
        {
            mc.gotoAndStop(1);
            return (false);
        } // end if
        mc.gotoAndStop(mc._totalframes);
        return (true);
    } // End of the function
    static function ResizeTextToFit(txt)
    {
        if (txt.maxscroll > 1)
        {
            var _loc3 = txt.text;
            txt.text = "A";
            var _loc4 = txt.textHeight;
            txt.text = _loc3;
            while (txt.maxscroll > 1)
            {
                var _loc2 = txt.getTextFormat();
                --_loc2.size;
                txt.setTextFormat(_loc2);
            } // end while
            txt._y = txt._y + (_loc4 - txt.textHeight);
        } // end if
    } // End of the function
    static var MIN_PASS_LENGTH = 4;
    static var MAX_PASS_LENGTH = 32;
    static var MIN_USERNAME_LENGTH = 4;
    static var MAX_USERNAME_LENGTH = 12;
} // End of Class
