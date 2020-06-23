﻿class com.clubpenguin.world.rooms.common.behaviors.RoomBehavior implements com.clubpenguin.world.rooms.common.behaviors.IRoomBehavior
{
    var _isShowStatsBarWidget, _SHELL, _handlePufflePerformingTrickDelegate, _loader;
    function RoomBehavior()
    {
        _isShowStatsBarWidget = true;
        _SHELL = _global.getCurrentShell();
        _handlePufflePerformingTrickDelegate = com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick);
        _SHELL.addListener(_SHELL.PUFFLE_PERFORMING_TRICK, _handlePufflePerformingTrickDelegate);
    } // End of the function
    function destroy()
    {
        _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, _handlePufflePerformingTrickDelegate);
    } // End of the function
    function applyEffect(playerId)
    {
    } // End of the function
    function handlePufflePerformingTrick(event)
    {
        if (event.playerId == _SHELL.getMyPlayerId())
        {
            _isShowStatsBarWidget = false;
            _loader.cancelAndRemoveAnimation();
            _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, _handlePufflePerformingTrickDelegate);
        } // end if
    } // End of the function
} // End of Class
