﻿class com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader extends mx.events.EventDispatcher
{
    var _SHELL, _ENGINE, _playerMC, _puffleMC, _playerID, _puffleID, _usesEvent, _puffleAnimationClip, dispatchEvent;
    function PuffleAnimationLoader(playerID, puffleID, shell_mc, engine_mc, usesEvent)
    {
        super();
        _SHELL = shell_mc;
        _ENGINE = engine_mc;
        _playerMC = _ENGINE.getPlayerMovieClip(playerID);
        _puffleMC = _ENGINE.puffleManager.getPuffleByID(puffleID).clip;
        _playerID = playerID;
        _puffleID = puffleID;
        _usesEvent = usesEvent;
    } // End of the function
    function playPuffleAnimation(animationURL, overPuffle)
    {
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, cleanup, this);
        var _loc3 = _ENGINE.puffleAvatarController.getPuffleClip(_puffleID);
        _puffleAnimationClip = _ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAnimationClip" + _puffleID, _loc3.getDepth() + com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_CLIP_DEPTH_PADDING);
        _puffleAnimationClip._x = _playerMC._x;
        _puffleAnimationClip._y = _playerMC._y;
        _puffleAnimationClip._xscale = _playerMC._xscale;
        _puffleAnimationClip._yscale = _playerMC._yscale;
        _puffleAnimationClip._visible = false;
        if (overPuffle && _puffleMC)
        {
            _puffleAnimationClip._x = _puffleMC._x;
            _puffleAnimationClip._y = _puffleMC._y;
        } // end if
        var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onAnimationLoaded));
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onAnimationLoadError));
        _loc2.loadClip(animationURL, _puffleAnimationClip, "PuffleAnimationLoader playPuffleAnimation()");
    } // End of the function
    function onAnimationLoaded(event)
    {
        com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationLoaded()");
        this.dispatchEvent({target: this, type: com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_LOADED_EVENT, playerID: _playerID, puffleID: _puffleID});
        _ENGINE.puffleAvatarController.hidePuffle(_puffleID);
        _puffleAnimationClip._visible = true;
        var scope = this;
        _puffleAnimationClip.onEnterFrame = function ()
        {
            if (scope._puffleAnimationClip.puffle._currentframe >= scope._puffleAnimationClip.puffle._totalframes)
            {
                scope.onAnimationFinished();
            } // end if
        };
    } // End of the function
    function onAnimationLoadError(event)
    {
        com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationLoadError()");
        _puffleAnimationClip.removeMovieClip();
        this.cleanup();
    } // End of the function
    function onAnimationFinished()
    {
        com.clubpenguin.util.Log.debug("PuffleAnimationLoader onAnimationFinished()");
        _puffleAnimationClip.onEnterFrame = null;
        _puffleAnimationClip.removeMovieClip();
        this.cleanup();
    } // End of the function
    function cleanup()
    {
        com.clubpenguin.util.Log.debug("PuffleAnimationLoader cleanup()");
        if (_usesEvent)
        {
            this.dispatchEvent({target: this, type: com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, playerID: _playerID, puffleID: _puffleID});
        } // end if
        _ENGINE.puffleAvatarController.showPuffle(_puffleID);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, cleanup, this);
    } // End of the function
    function cancelAndRemoveAnimation()
    {
        com.clubpenguin.util.Log.debug("PuffleAnimationLoader cancelAndRemoveAnimation()");
        this.onAnimationFinished();
    } // End of the function
    static var PUFFLE_ANIMATION_EVENT = "puffleAnimation";
    static var PUFFLE_ANIMATION_LOADED_EVENT = "puffleAnimationLoaded";
} // End of Class
