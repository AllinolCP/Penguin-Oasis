class com.clubpenguin.hud.phone.PhoneMediator
{
    var view, context, commandRoomTip, currentRoomService, epfService, layoutChanged, roomCrumbs, toolTipChanged, closeTweenCompleteDelegate, delayedServiceCall, appMenuMediator, fieldOpsMediator, agentStatusMediator, teleportMediator, puffleMediator, recruitMediator, fieldOpObjectiveMediator, currentApp, _state, fieldOpStatus, gameName, _layout;
    function PhoneMediator(view, context)
    {
        this.view = view;
        this.view.body.onPress = null;
        this.view.body.useHandCursor = false;
        view.toolTip.text = "";
        this.context = context;
        commandRoomTip = context.languageCrumbs.agentcom;
        currentRoomService = context.currentRoomService;
        currentRoomService.__get__roomJoined().add(closePhone, this);
        epfService = context.epfService;
        epfService.__get__fieldOpStatusReceived().add(onFieldOpStatusReceived, this);
        context.SHELL.addListener(context.SHELL.WORLD_CONNECT_SUCCESS, com.clubpenguin.util.Delegate.create(this, getFieldOpStatus));
        layoutChanged = context.layoutChanged;
        context.fieldOpTriggered.add(onFieldOpTriggered, this);
        context.phoneOpened.add(openPhone, this);
        context.ENGINE.getPlayerMoved().add(onPlayerMoved, this);
        roomCrumbs = context.roomCrumbs;
        toolTipChanged = new org.osflash.signals.Signal(String);
        toolTipChanged.add(onToolTipChanged, this);
        this.setupAppMenu(context.player, context.languageCrumbs);
        this.setupApps(context);
        com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED.x = view._x;
        com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED.y = view._y;
        com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED.scale = view._xscale;
        this.setupListeners();
        closeTweenCompleteDelegate = com.clubpenguin.util.Delegate.create(this, onCloseTweenComplete);
        this.changeState(com.clubpenguin.hud.phone.model.PhoneState.CLOSED);
    } // End of the function
    function getFieldOpStatus()
    {
        _global.clearTimeout(delayedServiceCall);
        delayedServiceCall = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, delayedGetFieldOpStatusServiceCall), com.clubpenguin.hud.phone.PhoneMediator.DELAYED_SERVICE_CALL_DURATION);
    } // End of the function
    function delayedGetFieldOpStatusServiceCall()
    {
        _global.clearTimeout(delayedServiceCall);
        epfService.getFieldOpStatus();
    } // End of the function
    function setupAppMenu(player, languageCrumbs)
    {
        appMenuMediator = new com.clubpenguin.hud.phone.mediator.AppMenuMediator(view.__get__appMenu(), toolTipChanged, player, languageCrumbs);
        appMenuMediator.iconPressed.add(onIconPressed, this);
    } // End of the function
    function setupApps(context)
    {
        context.appClosed.add(onAppClosed, this);
        fieldOpsMediator = new com.clubpenguin.hud.phone.mediator.FieldOpsMediator(view.fieldOps, com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_KEY, com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_SPAWN_X, com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_SPAWN_Y, context);
        agentStatusMediator = new com.clubpenguin.hud.phone.mediator.AgentStatusMediator(view.__get__agentStatus(), context);
        teleportMediator = new com.clubpenguin.hud.phone.mediator.TeleportMediator(view.teleport, context);
        puffleMediator = new com.clubpenguin.hud.phone.mediator.PuffleMediator(view.puffle, context);
        puffleMediator.__get__puffleEquipped().add(closePhone, this);
        recruitMediator = new com.clubpenguin.hud.phone.mediator.AppMediator(view.recruit, context.appClosed, context.languageCode);
        fieldOpObjectiveMediator = new com.clubpenguin.hud.phone.mediator.FieldOpObjectiveMediator(view.__get__fieldOpObjective(), context);
        fieldOpObjectiveMediator.__get__agentStatusPresed().add(openAgentStatus, this);
    } // End of the function
    function setupListeners()
    {
        view.rightCloseButton.onPress = view.leftCloseButton.onPress = com.clubpenguin.util.Delegate.create(this, onCloseButtonPress);
        view.homeButton.onPress = com.clubpenguin.util.Delegate.create(this, onHomeButtonPressed);
        view.homeButton.onRollOver = com.clubpenguin.util.Delegate.create(this, onToolTipChanged, commandRoomTip);
        view.homeButton.onRollOut = com.clubpenguin.util.Delegate.create(this, onToolTipChanged, "");
        view.bezel.onPress = com.clubpenguin.util.Delegate.create(this, onBezelPress);
        view.bezel.onRelease = view.bezel.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, onBezelRelease);
    } // End of the function
    function onIconPressed(iconID)
    {
        this.changeState(com.clubpenguin.hud.phone.model.PhoneState.getStateByIconID(iconID));
    } // End of the function
    function openApp(appID)
    {
        currentApp.close();
        currentApp = view[appID];
        currentApp.open();
    } // End of the function
    function openAgentStatus()
    {
        this.changeState(com.clubpenguin.hud.phone.model.PhoneState.AGENT_STATUS);
    } // End of the function
    function onAppClosed(appID)
    {
        this.changeState(com.clubpenguin.hud.phone.model.PhoneState.APP_MENU);
    } // End of the function
    function onToolTipChanged(toolTip)
    {
        view.toolTip.text = toolTip;
    } // End of the function
    function onHomeButtonPressed()
    {
        if (!isHomeButtonEnabled)
        {
            return;
        } // end if
        isHomeButtonEnabled = false;
        if (context.isUserCurrentlyInRoom(roomCrumbs[com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_KEY].room_id))
        {
        }
        else
        {
            teleportMediator.cancelTeleport();
            view.hideAllViews();
            this.changeState(com.clubpenguin.hud.phone.model.PhoneState.CLOSING);
            if (_state == com.clubpenguin.hud.phone.model.PhoneState.FIELD_OPS_OBJECTIVE)
            {
                context.ENGINE.forceReloadRoomOnRefresh = false;
            } // end if
            currentRoomService.joinRoom(roomCrumbs[com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_KEY].room_id, com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_SPAWN_X, com.clubpenguin.hud.phone.PhoneMediator.COMMAND_ROOM_SPAWN_Y);
        } // end else if
    } // End of the function
    function closePhone()
    {
        view.hideAllViews();
        this.changeState(com.clubpenguin.hud.phone.model.PhoneState.CLOSING);
    } // End of the function
    function onCloseButtonPress()
    {
        this.closePhone();
    } // End of the function
    function openPhone()
    {
        epfService.getFieldOpStatus();
        if (fieldOpStatus == com.clubpenguin.hud.phone.model.FieldOpStatus.PENDING)
        {
            this.changeState(com.clubpenguin.hud.phone.model.PhoneState.FIELD_OPS);
        }
        else if (context.ENGINE.isPlayerOnFieldOpTrigger() && fieldOpStatus != com.clubpenguin.hud.phone.model.FieldOpStatus.DONE)
        {
            fieldOpObjectiveMediator.initView(view.__get__fieldOpObjective());
            fieldOpObjectiveMediator.onFieldOpTriggered(gameName);
            this.changeState(com.clubpenguin.hud.phone.model.PhoneState.FIELD_OPS_OBJECTIVE);
        }
        else
        {
            this.changeState(com.clubpenguin.hud.phone.model.PhoneState.APP_MENU);
        } // end else if
    } // End of the function
    function onPlayerMoved()
    {
        fieldOpFound = false;
    } // End of the function
    function onCloseTweenComplete()
    {
        this.changeState(com.clubpenguin.hud.phone.model.PhoneState.CLOSED);
        context.phoneClosed.dispatch();
    } // End of the function
    function onFieldOpStatusReceived(fieldOpStatus)
    {
        this.fieldOpStatus = fieldOpStatus;
    } // End of the function
    function onFieldOpTriggered(gameName)
    {
        if (fieldOpStatus == com.clubpenguin.hud.phone.model.FieldOpStatus.IN_PROGRESS)
        {
            this.gameName = gameName;
            fieldOpFound = true;
        } // end if
    } // End of the function
    function animatePhoneTo(newLayout)
    {
        if (_layout == newLayout)
        {
            return;
        } // end if
        _layout = newLayout;
        view._visible = true;
        switch (_layout)
        {
            case com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE:
            {
                view.hideDistortion();
                view.leftCloseButton._visible = true;
                view.rightCloseButton._visible = false;
            } 
            case com.clubpenguin.hud.phone.model.PhoneLayout.LANDSCAPE_LARGE:
            {
                view.toolTip._visible = false;
                view.hideDistortion();
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT:
            {
                if (context.roomViewPaused)
                {
                    context.unpauseRoomView();
                } // end if
                view.toolTip._visible = true;
                view.showDistortion();
                view.leftCloseButton._visible = false;
                view.rightCloseButton._visible = true;
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneLayout.CLOSED:
            {
                break;
            } 
        } // End of switch
        if (_layout.draggable)
        {
            this.enableDrag();
        }
        else
        {
            this.disableDrag();
        } // end else if
        layoutChanged.dispatch(_layout);
        var _loc2 = _layout.__get__tweenProperties();
        if (_state == com.clubpenguin.hud.phone.model.PhoneState.CLOSING)
        {
            _loc2.onComplete = closeTweenCompleteDelegate;
        } // end if
        com.clubpenguin.engine.tweener.Tweener.removeTweens(view);
        com.clubpenguin.engine.tweener.Tweener.addTween(view, _loc2);
    } // End of the function
    function changeState(newState)
    {
        if (_state == newState)
        {
            return;
        } // end if
        switch (newState)
        {
            case com.clubpenguin.hud.phone.model.PhoneState.CLOSING:
            {
                if (context.roomViewPaused)
                {
                    context.unpauseRoomView();
                } // end if
                if (_state == com.clubpenguin.hud.phone.model.PhoneState.CLOSED)
                {
                    return;
                } // end if
                currentApp.close();
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneState.CLOSED:
            {
                view.hideAllViews();
                view._visible = false;
                currentApp.close();
                currentApp = view[com.clubpenguin.hud.phone.model.PhoneState.APP_MENU.viewID];
                this.onToolTipChanged("");
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneState.APP_MENU:
            {
                appMenuMediator.initView(view.__get__appMenu());
                isHomeButtonEnabled = true;
                this.openApp(newState.viewID);
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneState.FIELD_OPS_OBJECTIVE:
            {
                context.pauseRoomView();
                fieldOpObjectiveMediator.initView(view.__get__fieldOpObjective());
                view.hideAppMenu();
                isHomeButtonEnabled = true;
                this.openApp(newState.viewID);
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneState.AGENT_STATUS:
            {
                agentStatusMediator.initView(view.__get__agentStatus());
                view.hideAppMenu();
                isHomeButtonEnabled = true;
                this.openApp(newState.viewID);
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneState.TELEPORT:
            case com.clubpenguin.hud.phone.model.PhoneState.RECRUIT:
            case com.clubpenguin.hud.phone.model.PhoneState.FIELD_OPS:
            {
                view.hideAppMenu();
                isHomeButtonEnabled = true;
                this.openApp(newState.viewID);
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneState.PUFFLE:
            {
                if (!context.player.is_member)
                {
                    context.INTERFACE.showContent("oops_puffle_whistle");
                    return;
                }
                else if (!this.playerHasItem(com.clubpenguin.hud.phone.PhoneMediator.PUFFLE_WHISTLE_ID))
                {
                    context.INTERFACE.showContent("puffle_whistle");
                    return;
                } // end else if
                isHomeButtonEnabled = true;
                this.openApp(newState.viewID);
                break;
            } 
            case com.clubpenguin.hud.phone.model.PhoneState.TELEPORTING:
            {
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
        _state = newState;
        if (_state != com.clubpenguin.hud.phone.model.PhoneState.CLOSED)
        {
            this.animatePhoneTo(_state.layout);
        } // end if
    } // End of the function
    function onSoftwareCloseButtonPress()
    {
        this.changeState(com.clubpenguin.hud.phone.model.PhoneState.APP_MENU);
    } // End of the function
    function enableDrag()
    {
        view.bezel._visible = true;
    } // End of the function
    function disableDrag()
    {
        view.bezel._visible = false;
    } // End of the function
    function onBezelPress()
    {
        view.startDrag();
        view.onMouseMove = function ()
        {
            updateAfterEvent();
        };
    } // End of the function
    function onBezelRelease()
    {
        com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT.x = view._x;
        com.clubpenguin.hud.phone.model.PhoneLayout.PORTRAIT.y = view._y;
        view.stopDrag();
        delete view.onMouseMove;
    } // End of the function
    function playerHasItem(itemID)
    {
        for (var _loc2 = 0; _loc2 < context.inventory.length; ++_loc2)
        {
            if (context.inventory[_loc2].id == itemID)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static var DELAYED_SERVICE_CALL_DURATION = 2000;
    static var COMMAND_ROOM_KEY = "agentcom";
    static var COMMAND_ROOM_SPAWN_X = 570;
    static var COMMAND_ROOM_SPAWN_Y = 150;
    static var PUFFLE_WHISTLE_ID = 5060;
    var fieldOpFound = false;
    var isHomeButtonEnabled = true;
} // End of Class
