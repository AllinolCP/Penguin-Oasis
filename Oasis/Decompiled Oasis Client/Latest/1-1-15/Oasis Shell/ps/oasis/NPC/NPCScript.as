class ps.oasis.NPC.NPCScript
{
    var $shell, $NPCModule, currentScript, currentScriptId;
    function NPCScript($AHP_This, $AHP_Shell)
    {
        $shell = $AHP_Shell;
        $NPCModule = $AHP_This;
    } // End of the function
    function processLoadedScript(event)
    {
        var _loc5 = event.target.data;
        if (_loc5.id == undefined)
        {
            return (false);
        } // end if
        currentScript = _loc5;
        var _loc4 = _loc5;
        currentScriptId = _loc5.id;
        _global.getCurrentShell().NPCModule.NPCScript.haltNow = false;
        if (_loc4.listeners != undefined)
        {
            if (_loc4.listeners.emote != undefined)
            {
                _global.getCurrentShell().NPCModule.NPCScript.emotes = _loc4.listeners.emote;
                _global.getCurrentShell().addListener(_global.getCurrentShell().SEND_EMOTE, _global.getCurrentShell().NPCModule.handleSendEmote);
            } // end if
            if (_loc4.listeners.message != undefined)
            {
                for (var _loc3 = 0; _loc3 <= _loc4.listeners.message.length; ++_loc3)
                {
                    if (_loc4.listeners.message[_loc3].regExpStr == undefined)
                    {
                        continue;
                    } // end if
                    flash.external.ExternalInterface.call("OasisPs.NPC.AddRegExp", _loc4.listeners.message[_loc3].regExpStr, _loc4.listeners.message[_loc3].regExpFlag, _loc3);
                } // end of for
                _global.getCurrentShell().NPCModule.NPCScript.messages = _loc4.listeners.message;
                _global.getCurrentShell().addListener(_global.getCurrentShell().SEND_MESSAGE, _global.getCurrentShell().NPCModule.handleSendMessage);
            } // end if
        } // end if
        _global.getCurrentShell().NPCModule.runScript(_loc5.id);
    } // End of the function
    function runScript()
    {
        clearInterval(_global.getCurrentShell().NPCModule.NPCScript.npcInterval);
        var _loc3 = _global.getCurrentShell().NPCModule;
        if (_loc3.NPCScript.haltNow == true)
        {
            return (false);
        } // end if
        if (_loc3.NPCScript.currentScript.events[_loc3.NPCScript.currentScript.event] == undefined)
        {
            return (false);
        } // end if
        ++_loc3.NPCScript.currentEvent.event;
        var _loc4 = _loc3.NPCScript.currentScript.events[_loc3.NPCScript.currentScript.event];
        switch (_loc4.evt)
        {
            case "sendMessage":
            {
                if (typeof(_loc4.evtArg) == "object")
                {
                    var _loc5 = _loc4.evtArg[random(_loc4.evtArg.length) - 1];
                }
                else
                {
                    _loc5 = _loc4.evtArg;
                } // end else if
                _loc5 = _loc5.split("~name").join(_global.getCurrentInterface().getPlayerNickname());
                _global.getCurrentShell().addToChatLog({player_id: _loc3.NPCScript.currentScript.botID, message: _loc5, nickname: _loc3.NPCScript.currentScript.botName, type: _global.getCurrentShell().SEND_MESSAGE});
                _global.getCurrentInterface().showBalloon(_loc3.NPCScript.currentScript.botID, _loc5);
                return (_loc3.runScript());
            } 
            case "moveTo":
            {
                _loc3.NPCScript.currentScript.botID;
                if (_loc4.evtArg == "~x")
                {
                    var _loc6 = _global.getCurrentEngine().getPlayerMovieClip(_global.getCurrentInterface().getPlayerId());
                    _loc3.NPCScript.currentScript.botID;
                    (_loc4.evtArg = _loc6._x + 25);
                    _loc3.NPCScript.currentScript.botID;
                    (_loc4.evtArg2 = _loc6._y + 25);
                } // end if
                _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), _loc3.NPCScript.currentScript.botID, _loc4.evtArg, _loc4.evtArg2]);
                return (_loc3.runScript());
            } 
            case "setName":
            {
                _loc4.evtArg = _loc4.evtArg.split("~name").join(_global.getCurrentInterface().getPlayerNickname());
                _global.getCurrentInterface().nicknames_mc["p" + _loc3.NPCScript.currentScript.botID].name_txt.text = _loc4.evtArg;
                return (_loc3.runScript());
            } 
            case "setProperty":
            {
                _global.getCurrentEngine().getPlayerMovieClip(_loc3.NPCScript.currentScript.botID)[_loc4.evtArg] = _loc4.evtArg2;
                return (_loc3.runScript());
            } 
            case "updateNamecolor":
            {
                _global.getCurrentInterface().nicknames_mc["p" + _loc3.NPCScript.currentScript.botID].name_txt.textColor = _loc4.evtArg;
                return (_loc3.runScript());
            } 
            case "sendEmote":
            {
                _global.getCurrentShell().handleSendEmote([_global.getCurrentShell().getCurrentServerRoomId(), _loc3.NPCScript.currentScript.botID, _loc4.evtArg]);
                return (_loc3.runScript());
            } 
            case "setFrame":
            {
                _global.getCurrentShell().handleSendPlayerFrame([_global.getCurrentShell().getCurrentServerRoomId(), _loc3.NPCScript.currentScript.botID, _loc4.evtArg]);
                return (_loc3.runScript());
            } 
            case "waitFor":
            {
                _loc3.npcInterval = setInterval(runScript, _loc4.evtArg);
                return (true);
            } 
            case "stop":
            {
                clearInterval(_loc3.npcInterval);
                return (true);
            } 
        } // End of switch
        return (true);
    } // End of the function
    function runCustomScript(scriptObj, whoSent, pID)
    {
        var _loc3 = _global.getCurrentShell().NPCModule;
        switch (scriptObj.evt)
        {
            case "sendMessage":
            {
                if (typeof(scriptObj.evtArg) == "object")
                {
                    var _loc5 = scriptObj.evtArg[random(scriptObj.evtArg.length) - 1];
                }
                else
                {
                    _loc5 = scriptObj.evtArg;
                } // end else if
                _loc5 = _loc5.split("~name_of_sender").join(whoSent);
                _loc5 = _loc5.split("~name").join(_global.getCurrentInterface().getPlayerNickname());
                _global.getCurrentShell().addToChatLog({player_id: _loc3.NPCScript.currentScript.botID, message: _loc5, nickname: _loc3.NPCScript.currentScript.botName, type: _global.getCurrentShell().SEND_MESSAGE});
                _global.getCurrentInterface().showBalloon(_loc3.NPCScript.currentScript.botID, _loc5);
                return (_loc3.runScript());
            } 
            case "moveTo":
            {
                if (scriptObj.evtArg == "~x")
                {
                    var _loc7 = _global.getCurrentEngine().getPlayerMovieClip(_global.getCurrentInterface().getPlayerId());
                    var _loc9 = _loc7._x + 25;
                    var _loc8 = _loc7._y + 25;
                } // end if
                _loc3.NPCScript.currentScript.botID;
                if (scriptObj.evtArg == "~sender_x")
                {
                    _loc7 = _global.getCurrentShell().playerModel.getPlayerObjectById(pID);
                    _loc9 = _loc7.x + 25;
                    _loc8 = _loc7.y + 25;
                } // end if
                _global.getCurrentShell().handleSendPlayerMove([_global.getCurrentShell().getCurrentServerRoomId(), _loc3.NPCScript.currentScript.botID, _loc9, _loc8]);
                return (_loc3.runScript());
            } 
            case "setName":
            {
                var _loc6 = scriptObj.evtArg;
                _loc6 = scriptObj.evtArg.split("~name_of_sender").join(whoSent);
                _loc6 = scriptObj.evtArg.split("~name").join(_global.getCurrentInterface().getPlayerNickname());
                _global.getCurrentInterface().nicknames_mc["p" + _loc3.NPCScript.currentScript.botID].name_txt.text = _loc6;
                return (_loc3.runScript());
            } 
            case "setProperty":
            {
                _global.getCurrentEngine().getPlayerMovieClip(_loc3.NPCScript.currentScript.botID)[scriptObj.evtArg] = scriptObj.evtArg2;
                return (_loc3.runScript());
            } 
            case "updateNamecolor":
            {
                _global.getCurrentInterface().nicknames_mc["p" + _loc3.NPCScript.currentScript.botID].name_txt.textColor = scriptObj.evtArg;
                return (_loc3.runScript());
            } 
            case "sendEmote":
            {
                _global.getCurrentShell().handleSendEmote([_global.getCurrentShell().getCurrentServerRoomId(), _loc3.NPCScript.currentScript.botID, scriptObj.evtArg]);
                return (_loc3.runScript());
            } 
            case "setFrame":
            {
                _global.getCurrentShell().handleSendPlayerFrame([_global.getCurrentShell().getCurrentServerRoomId(), _loc3.NPCScript.currentScript.botID, scriptObj.evtArg]);
                return (_loc3.runScript());
            } 
            case "waitFor":
            {
                _loc3.npcInterval = setInterval(runScript, scriptObj.evtArg);
                return (true);
            } 
            case "stop":
            {
                clearInterval(_loc3.npcInterval);
                return (true);
            } 
        } // End of switch
        return (true);
    } // End of the function
    function loadScript(scriptName)
    {
        var _loc3 = new com.clubpenguin.util.JSONLoader();
        _loc3.addEventListener(com.clubpenguin.util.JSONLoader.COMPLETE, processLoadedScript);
        _loc3.load(_global._configuration.tuning.npc.script_service + scriptName);
    } // End of the function
} // End of Class
