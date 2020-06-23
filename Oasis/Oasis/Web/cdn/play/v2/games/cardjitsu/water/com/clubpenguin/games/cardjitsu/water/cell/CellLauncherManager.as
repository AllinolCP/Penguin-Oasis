class com.clubpenguin.games.cardjitsu.water.cell.CellLauncherManager implements com.clubpenguin.game.engine.IEngineUpdateable
{
    var __launchers, __previousLaunchTime, __launchOffset;
    function CellLauncherManager()
    {
        __launchers = new Array();
        com.clubpenguin.games.cardjitsu.water.GameEngineWater.registerElement(this, com.clubpenguin.games.cardjitsu.water.cell.CellLauncherManager.$_updateFrequency);
    } // End of the function
    function addLauncher(_launcherIndex, _launcher)
    {
        __launchers[_launcherIndex] = _launcher;
    } // End of the function
    function abortLaunch()
    {
        __active = false;
        __aborted = true;
        for (var _loc2 = 0; _loc2 < __launchers.length; ++_loc2)
        {
            __launchers[_loc2].abort();
        } // end of for
    } // End of the function
    function killLaunchers()
    {
        __active = false;
        __aborted = true;
        for (var _loc2 = 0; _loc2 < __launchers.length; ++_loc2)
        {
            __launchers[_loc2].killLauncher();
        } // end of for
    } // End of the function
    function triggerLaunch(_cells)
    {
        if (!__aborted)
        {
            var _loc6 = getTimer();
            if (__previousLaunchTime)
            {
                __totalLaunchTime = _loc6 - __previousLaunchTime;
            } // end if
            __previousLaunchTime = _loc6;
            var _loc3;
            var _loc5;
            __launchOffset = _cells.length == com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MIN ? (1) : (0);
            for (var _loc2 = 0; _loc2 < _cells.length; ++_loc2)
            {
                _loc5 = (com.clubpenguin.games.cardjitsu.water.cell.CellData)(_cells[_loc2]);
                _loc3 = (com.clubpenguin.games.cardjitsu.water.cell.CellLauncher)(__launchers[_loc2 + __launchOffset]);
                _loc3.setCell(_loc5);
                _loc3.triggerLaunch();
            } // end of for
            __elapsed = 0;
            __updates = 0;
            __active = true;
        } // end if
    } // End of the function
    function update(_tick, _currUpdate)
    {
        if (__active)
        {
            ++__updates;
            __elapsed = __updates * com.clubpenguin.games.cardjitsu.water.cell.CellLauncherManager.$_updateFrequency;
            if (__elapsed >= __totalLaunchTime)
            {
                if (__elapsed > __totalLaunchTime)
                {
                    __elapsed = __totalLaunchTime;
                } // end if
                __active = false;
            } // end if
            var _loc4 = __elapsed / __totalLaunchTime * 100;
            var _loc3 = __launchOffset == 1 ? (com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MIN) : (com.clubpenguin.games.cardjitsu.water.ProjectConstants.BOARD_COLS_MAX);
            for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
            {
                __launchers[_loc2 + __launchOffset].updateCellProgress(_loc4);
            } // end of for
        } // end if
    } // End of the function
    static var $_updateFrequency = 42;
    var __elapsed = 0;
    var __updates = 0;
    var __totalLaunchTime = 7000;
    var __active = false;
    var __aborted = false;
} // End of Class
