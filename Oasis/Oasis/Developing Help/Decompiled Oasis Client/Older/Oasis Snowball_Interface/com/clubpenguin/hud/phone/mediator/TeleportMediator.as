class com.clubpenguin.hud.phone.mediator.TeleportMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
{
    var baseView, _context, teleportView, _teleported, appClosed, teleportRooms, currentRoomService, roomCrumbs, languageCrumbs, roomButtonMediators, roomListMediator, joinRoomTimeoutID;
    function TeleportMediator(view, context)
    {
        super(view, context.appClosed, context.languageCode);
        baseView = view;
        _context = context;
        teleportView = (com.clubpenguin.hud.phone.view.TeleportView)(view);
        _teleported = new org.osflash.signals.Signal();
        appClosed.add(resetView, this);
        teleportRooms = new com.clubpenguin.hud.phone.model.TeleportRooms();
        currentRoomService = context.currentRoomService;
        roomCrumbs = context.roomCrumbs;
        languageCrumbs = context.languageCrumbs;
        roomButtonMediators = [];
        this.setupRoomsList();
        this.resetView();
        view.cancelTeleportButton.onPress = com.clubpenguin.util.Delegate.create(this, cancelTeleport);
    } // End of the function
    function setupRoomsList()
    {
        if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3())
        {
            teleportView = baseView;
        } // end if
        var _loc8 = teleportView.roomList;
        roomListMediator = new com.clubpenguin.scrollinglist.ScrollingList(_loc8);
        var _loc5 = 0;
        var _loc9 = 0;
        var _loc7 = this.getTeleportRooms();
        var _loc2;
        var _loc6;
        for (var _loc3 = 0; _loc3 < _loc7.length; ++_loc3)
        {
            var _loc4 = (com.clubpenguin.hud.phone.model.TeleportRoom)(_loc7[_loc3]);
            _loc2 = _loc8.content.attachMovie("roomButton", _loc4.key, _loc3);
            _loc2._x = _loc9;
            _loc2._y = _loc5;
            _loc5 = _loc5 + _loc2._height;
            _loc6 = new com.clubpenguin.hud.phone.mediator.RoomButtonMediator(_loc2, _loc4);
            _loc6.__get__pressed().add(onRoomButtonPressed, this);
            roomButtonMediators.push(_loc6);
        } // end of for
    } // End of the function
    function getTeleportRooms()
    {
        var _loc6 = [];
        var _loc5 = teleportRooms.IDs;
        for (var _loc4 = 0; _loc4 < _loc5.length; ++_loc4)
        {
            var _loc2 = _loc5[_loc4];
            var _loc3 = new com.clubpenguin.hud.phone.model.TeleportRoom(_loc2, roomCrumbs[_loc2].room_id, languageCrumbs[_loc2]);
            if (!_loc3.localizedName.length)
            {
                continue;
            } // end if
            _loc6.push(_loc3);
        } // end of for
        _loc6.sortOn(["localizedName"]);
        return (_loc6);
    } // End of the function
    function onRoomButtonPressed(teleportRoom)
    {
        if (_isTeleporting)
        {
            return;
        } // end if
        _isTeleporting = true;
        teleportView.roomList._visible = false;
        teleportView.destination.text = teleportRoom.localizedName.toUpperCase();
        this.showTeleportCountDown();
        joinRoomTimeoutID = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, teleportTo, teleportRoom), TELEPORT_TIMEOUT);
    } // End of the function
    function teleportTo(teleportRoom)
    {
        if (_context.isUserCurrentlyInRoom(teleportRoom.serverID))
        {
            this.cancelTeleport();
        }
        else
        {
            _teleported.dispatch();
            teleportView.close();
            currentRoomService.joinRoom(teleportRoom.serverID);
        } // end else if
        _isTeleporting = false;
    } // End of the function
    function onClosed()
    {
        this.cancelTeleport();
        super.onClosed();
    } // End of the function
    function cancelTeleport()
    {
        _isTeleporting = false;
        _global.clearTimeout(joinRoomTimeoutID);
        this.resetView();
    } // End of the function
    function resetView()
    {
        teleportView.reset();
    } // End of the function
    function showTeleportCountDown()
    {
        teleportView.showTeleportCountDown();
    } // End of the function
    static var DELAY_AMOUNT = 250;
    var TELEPORT_TIMEOUT = 1800;
    var DEFAULT_SPAWN_X = 100;
    var DEFAULT_SPAWN_Y = 500;
    var _isTeleporting = false;
    var delayInterval = null;
} // End of Class
