class ps.oasis.NPCScene
{
    var _destroyDelegate, _stage;
    function NPCScene(_npcSceneStage)
    {
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _global.getCurrentShell().addListener(_global.getCurrentShell().ROOM_DESTROYED, _destroyDelegate);
        _stage = _npcSceneStage;
        _global.getCurrentShell().npcScene = this;
    } // End of the function
    function newScene(playerId)
    {
        if (currentlySceneing != -1)
        {
            return (false);
        } // end if
        var _loc4 = _global.getCurrentShell().getPlayerObjectById(playerId);
        var _loc3 = _global.getCurrentEngine().getPlayerMovieClip(playerId);
        _loc4.character_permissions = 2047;
        _loc3.character_permissions = 2047;
        _loc4.player_attributes.s = 0;
        _loc3.player_attributes.s = 0;
        if (_loc4.nickname == undefined)
        {
            return (flash.external.ExternalInterface.call("console.debug", "newScene: nickname == undefined" + _loc4 + ";" + playerId + ";" + _loc4.player_id));
        } // end if
        _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), 10000000, _loc3._x + 10, _loc3._y + 20]);
        _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), 10000001, _loc3._x - 10, _loc3._y - 20]);
        _global.getCurrentShell().addListener("pmd", handleMoveFinished);
        currentlySceneing = playerId;
    } // End of the function
    function handleMoveFinished(playerObj)
    {
        if (playerObj.player_id == 10000000)
        {
            var _loc2 = 10000000;
        } // end if
        if (playerObj.player_id == 10000001)
        {
            _loc2 = 10000001;
        } // end if
        if (_loc2 == undefined || _global.getCurrentShell().npcScene._movedAlready == true)
        {
            if (playerObj.player_id == _global.getCurrentShell().npcScene.currentlySceneing)
            {
                _global.getCurrentShell().removeListener("pmd", _global.getCurrentShell().npcScene.handleMoveFinished);
                _global.getCurrentShell().handleRemovePlayerFromRoom([_global.getCurrentShell().getCurrentServerRoomId(), _global.getCurrentShell().npcScene.currentlySceneing]);
                _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), 10000000, 86, 336]);
                _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), 10000001, 676, 340]);
                _global.getCurrentShell().npcScene._saidAlready = false;
                _global.getCurrentShell().npcScene.currentlySceneing = -1;
                _global.getCurrentShell().npcScene._movedAlready = false;
            } // end if
            return (false);
        } // end if
        if (_global.getCurrentShell().npcScene._saidAlready == false)
        {
            _global.getCurrentShell().addToChatLog({player_id: _loc2, message: "You\'re outta here!", nickname: "Bouncer", type: _global.getCurrentShell().SEND_MESSAGE});
            _global.getCurrentInterface().showBalloon(_loc2, "You\'re outta here!");
            _global.getCurrentShell().npcScene._saidAlready = true;
        }
        else
        {
            _global.getCurrentShell().npcScene._movedAlready = true;
            _global.getCurrentShell().npcScene._npcInterval = setInterval(_global.getCurrentShell().npcScene, "handleMovePlayerOut", 1000);
        } // end else if
    } // End of the function
    function handleMovePlayerOut()
    {
        clearInterval(_npcInterval);
        _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), _global.getCurrentShell().npcScene.currentlySceneing, 670, 372]);
        _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), 10000000, 670, 365]);
        _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), 10000001, 670, 377]);
    } // End of the function
    function destroy()
    {
        clearInterval(_npcInterval);
        _global.getCurrentShell().removeListener(_global.getCurrentShell().ROOM_DESTROYED, _destroyDelegate);
        false;
    } // End of the function
    var npcIds = new Array(10000000, 10000001);
    var currentlySceneing = -1;
    var caughtNpcCount = 0;
    var _npcInterval = 0;
    var _saidAlready = false;
    var _movedAlready = false;
    var messageArray = new Array("You\'re outta here!", "It\'s time for you to leave.", "Get out!", "You need to come with us");
} // End of Class
