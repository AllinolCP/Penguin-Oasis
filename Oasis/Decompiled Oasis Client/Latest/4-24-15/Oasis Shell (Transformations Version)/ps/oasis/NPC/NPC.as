class ps.oasis.NPC.NPC
{
    var $shell, NPCScript;
    function NPC(_shell)
    {
        ps.oasis.OasisLogger.debug("Starting OasisNPC Engine...");
        $shell = _shell;
        NPCScript = new ps.oasis.NPC.NPCScript(this, $shell);
    } // End of the function
    function moveBotToPlayer(playerID)
    {
        var _loc2 = _global.getCurrentEngine().getPlayerMovieClip(playerID);
        if (_loc2 == undefined)
        {
            return (false);
        } // end if
        _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), 0, _loc2._x - _global._configuration.tuning.npc.personal_space, _loc2._y - _global._configuration.tuning.npc.personal_space]);
    } // End of the function
    function moveBackToPost()
    {
        var _loc2 = _global.getCurrentShell().getCurrentIglooBot().split("|");
        _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), 0, _loc2[12], _loc2[13]]);
    } // End of the function
    function botAction(frameID)
    {
        if (frameID == 25)
        {
            return (_global.getCurrentShell().handleUpdatePlayerAction([_global.getCurrentShell().getCurrentServerRoomId(), 0, 25]));
        } // end if
        return (_global.getCurrentShell().handleSendPlayerFrame([_global.getCurrentShell().getCurrentServerRoomId(), 0, frameID]));
    } // End of the function
    function sendEmote(emoteID)
    {
        return (_global.getCurrentShell().handleSendEmote([_global.getCurrentShell().getCurrentServerRoomId(), 0, emoteID]));
    } // End of the function
    function handleSendEmote(event)
    {
        if (_global.getCurrentShell().NPCModule.NPCScript.emotes[String(event.emote_id)] != undefined)
        {
            var _loc4 = _global.getCurrentShell().getNicknameById(event.player_id);
            for (var _loc2 = 0; _loc2 < _global.getCurrentShell().NPCModule.NPCScript.emotes[String(event.emote_id)].length; ++_loc2)
            {
                _global.getCurrentShell().NPCModule.NPCScript.runCustomScript(_global.getCurrentShell().NPCModule.NPCScript.emotes[String(event.emote_id)][_loc2], _loc4, event.player_id);
            } // end of for
        } // end if
    } // End of the function
    function handleSendMessage(event)
    {
        var _loc3 = flash.external.ExternalInterface.call("OasisPs.NPC.onEvent", "sm", event.message);
        if (_loc3 === false)
        {
            return (false);
        } // end if
        if (isNaN(_loc3))
        {
            return (false);
        } // end if
        var _loc5 = _global.getCurrentShell().getNicknameById(event.player_id);
        for (var _loc2 = 0; _loc2 < _global.getCurrentShell().NPCModule.NPCScript.messages[Number(_loc3)].events.length; ++_loc2)
        {
            _global.getCurrentShell().NPCModule.NPCScript.runCustomScript(_global.getCurrentShell().NPCModule.NPCScript.messages[Number(_loc3)].events[_loc2], _loc5, event.player_id);
        } // end of for
    } // End of the function
    function joinRoom(roomID)
    {
        flash.external.ExternalInterface.call("OasisPs.NPC.onEvent", "rmsgs");
        _global.getCurrentShell().NPCModule.NPCScript.messages = undefined;
        _global.getCurrentShell().NPCModule.NPCScript.emotes = undefined;
        _global.getCurrentShell().removeListener(_global.getCurrentShell().SEND_MESSAGE, _global.getCurrentShell().NPCModule.handleSendMessage);
        _global.getCurrentShell().removeListener(_global.getCurrentShell().SEND_EMOTE, _global.getCurrentShell().NPCModule.handleSendEmote);
        if (!_global._configuration.tuning.npc.enabled)
        {
            return (false);
        } // end if
        if (roomID >= 1000 && _global._configuration.tuning.npc.disable_for_igloos)
        {
            return (false);
        } // end if
        if (_global._configuration.tuning.npc.extras[roomID] != undefined)
        {
            for (var _loc4 in _global._configuration.tuning.npc.extras[roomID])
            {
                if (_global._configuration.tuning.npc.extras[roomID][_loc4].str.indexOf("|") == -1)
                {
                    continue;
                } // end if
                this.addNPC(_global._configuration.tuning.npc.extras[roomID][_loc4].str);
                if (_global._configuration.tuning.npc.extras[roomID][_loc4].script.indexOf(".json") != -1 && _global._configuration.tuning.npc.extras[roomID][_loc4].script != undefined)
                {
                    NPCScript.loadScript(_global._configuration.tuning.npc.extras[roomID][_loc4].script);
                } // end if
            } // end of for...in
        } // end if
        for (var _loc4 in _global._configuration.tuning.npc.disable_for_rooms)
        {
            if (_global._configuration.tuning.npc.disable_for_rooms[_loc4] == Number(roomID))
            {
                return (false);
            } // end if
        } // end of for...in
        if (_global._configuration.tuning.npc["npc_" + roomID] != undefined && _global._configuration.tuning.npc["npc_" + roomID].length > 10)
        {
            _global.getCurrentShell().handleAddPlayerToRoom([_global.getCurrentShell().getCurrentServerRoomId(), _global._configuration.tuning.npc["npc_" + roomID]]);
        }
        else
        {
            _global.getCurrentShell().handleAddPlayerToRoom([_global.getCurrentShell().getCurrentServerRoomId(), _global._configuration.tuning.npc.default_npc]);
        } // end else if
    } // End of the function
    function addNPC(botStr)
    {
        if (!_global._configuration.tuning.npc.enabled)
        {
            return (false);
        } // end if
        if (botStr == "" || botStr.indexOf("|") == -1)
        {
            botStr = _global._configuration.tuning.npc.default_npc;
        } // end if
        return (_global.getCurrentShell().handleAddPlayerToRoom([_global.getCurrentShell().getCurrentServerRoomId(), botStr]));
    } // End of the function
} // End of Class
