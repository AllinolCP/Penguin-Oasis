class com.clubpenguin.games.cardjitsu.water.player.GameCompleteToken
{
    var __rankAwarded, __nickname, __position, __vsSensei, __processed, __amuletState, __get__nickname, __get__position, __get__vsSensei, __get__amulet, __set__amulet, __get__amuletGems, __set__nickname, __set__position, __get__processed, __get__rankAward, __set__vsSensei;
    function GameCompleteToken()
    {
        __rankAwarded = 0;
        __nickname = "Noname";
        __position = 0;
        __vsSensei = false;
        __processed = false;
    } // End of the function
    function get rankAward()
    {
        __processed = true;
        return (__rankAwarded);
    } // End of the function
    function get amuletGems()
    {
        return (__amuletState);
    } // End of the function
    function get nickname()
    {
        return (__nickname);
    } // End of the function
    function get position()
    {
        return (__position);
    } // End of the function
    function get vsSensei()
    {
        return (__vsSensei);
    } // End of the function
    function set nickname(_str)
    {
        __nickname = _str;
        //return (this.nickname());
        null;
    } // End of the function
    function set position(_val)
    {
        __position = _val;
        //return (this.position());
        null;
    } // End of the function
    function set vsSensei(_bool)
    {
        __vsSensei = _bool;
        //return (this.vsSensei());
        null;
    } // End of the function
    function set amulet(_str)
    {
        __rankAwarded = parseInt(_str.substr(1, 1));
        __amuletState = parseInt(_str.substr(0, 1));
        //return (this.amulet());
        null;
    } // End of the function
    function get processed()
    {
        return (__processed);
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "[GameCompleteToken]\n";
        _loc2 = _loc2 + ("\tnickname     : " + __nickname);
        _loc2 = _loc2 + ("\tposition     : " + __position);
        _loc2 = _loc2 + ("\tvsSensei     : " + __vsSensei);
        _loc2 = _loc2 + ("\trankAwarded  : " + __rankAwarded);
        _loc2 = _loc2 + ("\tamuletState  : " + __amuletState);
        return (_loc2);
    } // End of the function
} // End of Class
