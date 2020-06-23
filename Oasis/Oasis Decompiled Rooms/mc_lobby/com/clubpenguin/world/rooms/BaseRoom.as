﻿class com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, _SHELL, _ENGINE, _INTERFACE, _destroyFunc, roomEnvironmentManager, _invitationManager, soundManagerReady, __get__invitationManager, _soundManager, __set__invitationManager, __get__soundManager;
    static var _current, lastRoomInvitationManager, __get__current;
    function BaseRoom(stageReference)
    {
        com.clubpenguin.mock.Mock.init();
        _stage = stageReference;
        _SHELL = _global.getCurrentShell();
        _ENGINE = _global.getCurrentEngine();
        _INTERFACE = _global.getCurrentInterface();
        _current = this;
        _destroyFunc = com.clubpenguin.util.Delegate.create(this, onDestroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyFunc);
        _stage.block_mc._visible = false;
        _stage.triggers_mc._visible = false;
        roomEnvironmentManager = new com.clubpenguin.world.rooms.common.RoomEnvironmentManager(_stage, _SHELL, _ENGINE);
        _invitationManager = com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory.create();
        soundManagerReady = new org.osflash.signals.Signal();
        _ENGINE.avatarManager.effectManager.effectsLoaded.addOnce(onEffectLibsLoaded, this);
    } // End of the function
    static function get current()
    {
        return (com.clubpenguin.world.rooms.BaseRoom._current);
    } // End of the function
    function get invitationManager()
    {
        if (!_invitationManager)
        {
            _invitationManager = com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory.create();
        } // end if
        return (_invitationManager);
    } // End of the function
    function set invitationManager(invitationManager)
    {
        _invitationManager = invitationManager;
        null;
        //return (this.invitationManager());
        null;
    } // End of the function
    function onEffectLibsLoaded()
    {
        _soundManager = new com.clubpenguin.world.rooms.common.SoundManager(_stage[com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME]);
        soundManagerReady.dispatch();
    } // End of the function
    function onDestroy()
    {
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyFunc);
        roomEnvironmentManager.destroy();
        _soundManager.destroy();
        _current = null;
        if (_invitationManager)
        {
            _invitationManager.destroy();
            lastRoomInvitationManager = _invitationManager;
        } // end if
    } // End of the function
    function getStage()
    {
        return (_stage);
    } // End of the function
    function get soundManager()
    {
        return (_soundManager);
    } // End of the function
    function setupEnvironmentTriggers()
    {
        roomEnvironmentManager.setupEnvironmentTriggers();
    } // End of the function
    function hasQuestTarget(questTarget)
    {
        if (_stage.questTargets)
        {
            if (_stage.questTargets[questTarget])
            {
                return (true);
            } // end if
        } // end if
        return (false);
    } // End of the function
    function showQuestTarget(questTarget)
    {
        _stage.questTargets[questTarget].gotoAndStop(com.clubpenguin.world.rooms.BaseRoom.QUEST_TARGET_SHOW_FRAME);
    } // End of the function
    function localize(globalAssets)
    {
        var _loc4 = "en";
        if (_SHELL.getLanguageAbbreviation() != undefined)
        {
            _loc4 = _SHELL.getLanguageAbbreviation();
        } // end if
        for (var _loc2 = 0; _loc2 < globalAssets.length; ++_loc2)
        {
            com.clubpenguin.util.Log.info("globalAssets[" + _loc2 + "]: " + globalAssets[_loc2]);
            globalAssets[_loc2].gotoAndStop(_loc4);
        } // end of for
    } // End of the function
    function setupNavigationButtons(navigationButtons)
    {
        for (var _loc2 = 0; _loc2 < navigationButtons.length; ++_loc2)
        {
            com.clubpenguin.util.Log.info("setupNavigationButtons navigationButtons[" + _loc2 + "]: " + navigationButtons[_loc2].button);
            navigationButtons[_loc2].button.onRelease = com.clubpenguin.util.Delegate.create(this, navigationButtonClick, navigationButtons, _loc2);
        } // end of for
    } // End of the function
    function navigationButtonClick(navigationButtons, whichButton)
    {
        com.clubpenguin.util.Log.info("_ENGINE.isMovementEnabled(): " + _ENGINE.isMovementEnabled());
        if (_ENGINE.isMovementEnabled())
        {
            this.disablePuffleActivities();
            var _loc2 = Math.round(navigationButtons[whichButton].navigationX);
            var _loc3 = Math.round(navigationButtons[whichButton].navigationY);
            _ENGINE.sendPlayerMove(_loc2, _loc3);
            com.clubpenguin.util.Log.info("setupNavigationButtons.navigationButtonClick: _ENGINE.sendPlayerMove(" + _loc2 + ", " + _loc3 + ")");
        } // end if
    } // End of the function
    function disablePuffleActivities()
    {
        com.clubpenguin.util.Log.info("[BaseRoom] disablePuffleActivities");
        var _loc2 = _SHELL.getMyPlayerObject();
        var _loc3 = new Object();
        _loc3.playerId = _loc2.player_id;
        _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, _loc2.player_id);
        _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc3);
    } // End of the function
    function showContent(content)
    {
        for (var _loc2 = 0; _loc2 < content.length; ++_loc2)
        {
            com.clubpenguin.util.Log.info("showContent.content[" + _loc2 + "]: " + content[_loc2].button);
            content[_loc2].button.onRelease = com.clubpenguin.util.Delegate.create(this, showContentClick, content, _loc2);
        } // end of for
    } // End of the function
    function showContentClick(content, whichButton)
    {
        com.clubpenguin.util.Log.info("showContent.showContentClick: ");
        if (content[whichButton].condition)
        {
            com.clubpenguin.util.Log.info("\tshowing content: " + content[whichButton].content);
            _INTERFACE.showContent(content[whichButton].content, null, null, content[whichButton].data, null);
        }
        else
        {
            com.clubpenguin.util.Log.info("\tshowing elseContent: " + content[whichButton].elseContent);
            _INTERFACE.showContent(content[whichButton].elseContent, null, null, content[whichButton].data, null);
        } // end else if
    } // End of the function
    function setupHint(hints)
    {
        for (var _loc2 = 0; _loc2 < hints.length; ++_loc2)
        {
            com.clubpenguin.util.Log.info("setupHint.hints[" + _loc2 + "].button: " + hints[_loc2].button);
            com.clubpenguin.util.Log.info("\t\t\t\t   anchor: " + hints[_loc2].anchor);
            hints[_loc2].button.onRollOver = com.clubpenguin.util.Delegate.create(this, showHint, hints, _loc2);
            hints[_loc2].button.onRollOut = com.clubpenguin.util.Delegate.create(this, closeHint, hints, _loc2);
            hints[_loc2].button.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, closeHint, hints, _loc2);
        } // end of for
    } // End of the function
    function showHint(hints, whichButton)
    {
        com.clubpenguin.util.Log.info("showHint: " + hints[whichButton].hint);
        _INTERFACE.showHint(hints[whichButton].anchor, hints[whichButton].hint);
    } // End of the function
    function closeHint(hints, whichButton)
    {
        com.clubpenguin.util.Log.info("closeHint: " + hints[whichButton].hint);
        _INTERFACE.closeHint(hints[whichButton].anchor, hints[whichButton].hint);
    } // End of the function
    function setupTableGame(stage, tableObjects)
    {
        stage.table_list = [];
        for (var _loc2 = 0; _loc2 < tableObjects.length; ++_loc2)
        {
            com.clubpenguin.util.Log.info("setupTableGame.tableObjects[" + _loc2 + "]: " + tableObjects[_loc2].tableClip);
            stage.table_list.push(tableObjects[_loc2].tableID);
            tableObjects[_loc2].tableClip.seat_frames = tableObjects[_loc2].seatframes;
            tableObjects[_loc2].tableClip.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this, clickTable, tableObjects, _loc2);
            tableObjects[_loc2].tableClip.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, tableObjects, _loc2);
            tableObjects[_loc2].tableClip.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, tableObjects, _loc2);
            tableObjects[_loc2].triggerClip.triggerFunction = com.clubpenguin.util.Delegate.create(this, tableTrigger, tableObjects, _loc2);
        } // end of for
    } // End of the function
    function clickTable(tableObjects, whichClip)
    {
        var _loc2 = Math.round(tableObjects[whichClip].tableClip._x);
        var _loc3 = Math.round(tableObjects[whichClip].tableClip._y);
        _ENGINE.sendPlayerMove(_loc2, _loc3);
        com.clubpenguin.util.Log.info("setupTableGame.clickTable: _ENGINE.sendPlayerMove(" + _loc2 + ", " + _loc3 + ")");
    } // End of the function
    function tableRollOver(tableObjects, whichClip)
    {
        var _loc4 = 2;
        com.clubpenguin.util.Log.info("setupTableGame.tableRollOver: " + tableObjects[whichClip].tableClip);
        _INTERFACE.showHint(tableObjects[whichClip].tableClip.game_btn, tableObjects[whichClip].hintName);
        tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_loc4);
    } // End of the function
    function tableRollOut(tableObjects, whichClip)
    {
        var _loc2 = 1;
        com.clubpenguin.util.Log.info("setupTableGame.tableRollOut: " + tableObjects[whichClip].tableClip);
        _INTERFACE.closeHint();
        tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_loc2);
    } // End of the function
    function tableTrigger(tableObjects, whichClip)
    {
        com.clubpenguin.util.Log.info("setupTableGame.tableTrigger: " + tableObjects[whichClip].tableClip);
        _ENGINE.sendJoinTable(tableObjects[whichClip].gameName, tableObjects[whichClip].tableID, tableObjects[whichClip].is_prompt);
    } // End of the function
    static var QUEST_TARGET_PARK_FRAME = "park";
    static var QUEST_TARGET_SHOW_FRAME = "show";
} // End of Class
