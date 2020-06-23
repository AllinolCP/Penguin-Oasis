class com.clubpenguin.games.cardjitsu.water.layers.PlayerActionLayer extends MovieClip
{
    var __playerPool, __activePlayers, __apuid, getNextHighestDepth, attachMovie;
    function PlayerActionLayer()
    {
        super();
        __playerPool = new Array();
        __activePlayers = new Array();
        __apuid = 0;
        this.createActionSet();
    } // End of the function
    function createActionSet()
    {
        var _loc4;
        var _loc3;
        for (var _loc2 = 0; _loc2 < com.clubpenguin.games.cardjitsu.water.layers.PlayerActionLayer.MAX_PLAYERS; ++_loc2)
        {
            _loc3 = __apuid++;
            this.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_PLAYER, "actionPlayer_" + _loc3, this.getNextHighestDepth());
            _loc4 = this["actionPlayer_" + _loc3];
            __playerPool.push(_loc4);
        } // end of for
    } // End of the function
    function checkoutPlayer(_formerLocation, _vector)
    {
        var _loc2;
        var _loc4;
        if (__playerPool.length > 0)
        {
            _loc2 = (com.clubpenguin.games.cardjitsu.water.player.PlayerDisplay)(__playerPool.shift());
            __activePlayers[_loc2._name] = _loc2;
        }
        else
        {
            _loc4 = __apuid++;
            this.attachMovie(com.clubpenguin.games.cardjitsu.water.ProjectConstants.LIBRARY_NAME_PLAYER, "actionPlayer_" + _loc4, this.getNextHighestDepth());
            _loc2 = this["actionPlayer_" + _loc4];
        } // end else if
        var _loc3;
        _loc3 = new flash.geom.Point(0, 0);
        _formerLocation.localToGlobal(_loc3);
        _loc3 = _loc3.subtract(_vector);
        _loc2._x = _loc3.x;
        _loc2._y = _loc3.y;
        return (_loc2);
    } // End of the function
    function checkinPlayer(_displayRef)
    {
        __activePlayers[_displayRef._name] = null;
        __playerPool.push(_displayRef);
    } // End of the function
    static var MAX_PLAYERS = 4;
} // End of Class
