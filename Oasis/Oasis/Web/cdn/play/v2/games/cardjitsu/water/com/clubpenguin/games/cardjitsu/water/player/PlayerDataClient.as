class com.clubpenguin.games.cardjitsu.water.player.PlayerDataClient extends com.clubpenguin.games.cardjitsu.water.player.PlayerData
{
    var __selectTimes, __playTimes, __actionTimes, __currPlay, __isDropping, __darkMode, __currentSummon, __currentCellRef;
    function PlayerDataClient(_uid)
    {
        super(_uid);
        __selectTimes = new Array();
        __playTimes = new Array();
        __actionTimes = new Array();
        __currPlay = 0;
        __isDropping = false;
        __darkMode = false;
    } // End of the function
    function setupListeners()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_THROW_START, handlePlayerThrowStart, this);
    } // End of the function
    function handleCardSelect(_gcDef)
    {
        var _loc2;
        _loc2 = _gcDef.element;
        __currentSummon = _loc2.type;
        __currentCellRef.player.summonElement(_loc2.__get__type());
    } // End of the function
    function unsummon()
    {
        __currentSummon = -1;
        __currentCellRef.player.unsummon();
    } // End of the function
    function handlePlayerThrowStart(_eventObj)
    {
        __currentSummon = -1;
        var _loc2;
        _loc2 = (flash.geom.Point)(_eventObj.__get__data());
        __currentCellRef.player.throwElement(_loc2);
    } // End of the function
    function update(_tick, _currUpdate)
    {
        var _loc2;
        var _loc3;
        var _loc5;
        super.update(_tick);
    } // End of the function
    function handlePlayerDropStart(_eventObj)
    {
    } // End of the function
    function drop()
    {
        super.drop();
        __isDropping = true;
    } // End of the function
    function logSelect()
    {
        __currPlay = getTimer();
        this.logAction("S:", __currPlay);
        __selectTimes.push(__currPlay);
    } // End of the function
    function logPlay()
    {
        var _loc2;
        _loc2 = getTimer();
        this.logAction("T:", _loc2);
        _loc2 = _loc2 - __currPlay;
        __playTimes.push(_loc2);
    } // End of the function
    function logAction(_actionCode, _override)
    {
        var _loc2;
        if (_override == undefined)
        {
            _loc2 = getTimer();
        }
        else
        {
            _loc2 = _override;
        } // end else if
        __actionTimes.push(_actionCode + _loc2);
    } // End of the function
    function infoLog()
    {
        return (__actionTimes + "\n" + __selectTimes + "\n" + __playTimes);
    } // End of the function
} // End of Class
