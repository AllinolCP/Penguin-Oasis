class com.clubpenguin.games.cardjitsu.water.layers.BridgeLayer extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, launcherManager, onEnterFrame, winnerCell, __winner;
    function BridgeLayer()
    {
        super();
        $_instanceCount = ++com.clubpenguin.games.cardjitsu.water.layers.BridgeLayer.$_instanceCount;
        __uid = com.clubpenguin.games.cardjitsu.water.layers.BridgeLayer.$_instanceCount;
        launcherManager = new com.clubpenguin.games.cardjitsu.water.cell.CellLauncherManager();
        onEnterFrame = config;
    } // End of the function
    function getUniqueName()
    {
        return ("[BridgeLayer<" + __uid + ">]");
    } // End of the function
    function config()
    {
        delete this.onEnterFrame;
        this.collectLaunchers();
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_WIN_COMPLETE, onPlayerWinComplete, this, winnerCell.player.character);
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.ClipEvent.COMPLETE, onTsunamiComplete, this, winnerCell.bg_tsunami);
    } // End of the function
    function collectLaunchers()
    {
        var _loc2;
        var _loc6;
        var _loc5;
        var _loc3;
        var _loc7;
        var _loc4;
        for (var _loc8 in this)
        {
            _loc6 = this[_loc8];
            if (_loc6 instanceof MovieClip)
            {
                _loc5 = (MovieClip)(_loc6);
                if (_loc5._name.indexOf("launch") != -1)
                {
                    _loc3 = (com.clubpenguin.games.cardjitsu.water.cell.CellLauncher)(_loc5);
                    _loc2 = _loc3._name;
                    _loc4 = _loc2.substring(_loc2.length - 1, _loc2.length);
                    _loc7 = parseInt(_loc4);
                    launcherManager.addLauncher(_loc7, _loc3);
                } // end if
            } // end if
        } // end of for...in
    } // End of the function
    function triggerLaunch(_cells)
    {
        launcherManager.triggerLaunch(_cells);
    } // End of the function
    function abortLaunch()
    {
        launcherManager.abortLaunch();
    } // End of the function
    function onPlayerWinComplete(_eventObj)
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.games.cardjitsu.water.event.PlayerEvent.PLAYER_WIN_COMPLETE, onPlayerWinComplete, this);
        __winner = (com.clubpenguin.games.cardjitsu.water.player.PlayerData)((com.clubpenguin.games.cardjitsu.water.player.PlayerDisplay)(_eventObj.__get__data()).__get__data());
        winnerCell.onPlayerWinComplete();
    } // End of the function
    function onTsunamiComplete(_eventObj)
    {
        if (_eventObj.__get__target() == winnerCell.bg_tsunami)
        {
            com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.event.ClipEvent.COMPLETE, onTsunamiComplete, this);
            com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.games.cardjitsu.water.event.GameEvent(this, com.clubpenguin.games.cardjitsu.water.event.GameEvent.GAME_OVER_WIN_COMPLETE, __winner));
        } // end if
    } // End of the function
    function killLaunchers()
    {
        launcherManager.killLaunchers();
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
