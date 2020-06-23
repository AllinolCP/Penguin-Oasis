class com.clubpenguin.hud.phone.EPFContext
{
    var layoutChanged, baseURL, gamesURL, phoneLayer, iconLayer, currentRoomService, equipmentService, epfService, roomCrumbs, languageCode, languageCrumbs, inventory, player, fieldOp, fieldOpTriggered, cancelFieldOpTrigger, INTERFACE, SHELL, ENGINE, inventoryCrumbs, roomViewPaused, appClosed, _loader, _phoneContainer, phoneOpened, phoneClosed, phoneMediator, hudIconMediator;
    function EPFContext(baseURL, gamesURL, phoneLayer, iconLayer, currentRoomService, equipmentService, epfService, roomCrumbs, languageCode, languageCrumbs, inventory, player, fieldOp, fieldOpTriggered, cancelFieldOpTrigger, _interface, _shell, _engine, inventoryCrumbs)
    {
        layoutChanged = new org.osflash.signals.Signal(com.clubpenguin.hud.phone.model.PhoneLayout);
        this.baseURL = baseURL;
        this.gamesURL = gamesURL;
        this.phoneLayer = phoneLayer;
        this.iconLayer = iconLayer;
        this.currentRoomService = currentRoomService;
        this.equipmentService = equipmentService;
        this.epfService = epfService;
        this.roomCrumbs = roomCrumbs;
        this.languageCode = languageCode;
        this.languageCrumbs = languageCrumbs;
        this.inventory = inventory;
        this.player = player;
        this.fieldOp = fieldOp;
        this.fieldOpTriggered = fieldOpTriggered;
        this.cancelFieldOpTrigger = cancelFieldOpTrigger;
        INTERFACE = _interface;
        SHELL = _shell;
        ENGINE = _engine;
        this.inventoryCrumbs = inventoryCrumbs;
        roomViewPaused = false;
        appClosed = new org.osflash.signals.Signal(String);
        _loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onPhoneViewLoaded));
        _phoneContainer = phoneLayer.createEmptyMovieClip("phoneHolder", phoneLayer.getNextHighestDepth());
        _loader.loadClip(baseURL + com.clubpenguin.hud.phone.EPFContext.PHONE_ASSET_FILE_NAME, _phoneContainer);
    } // End of the function
    function isUserCurrentlyInRoom(roomID)
    {
        return (roomID == SHELL.getCurrentRoomId());
    } // End of the function
    function pauseRoomView()
    {
        SHELL.quietAirtower();
        roomViewPaused = true;
        ENGINE.hideAndUnloadRoomMovieClip();
    } // End of the function
    function unpauseRoomView()
    {
        SHELL.enableAirtower();
        ENGINE.removeRoomBitmap();
        currentRoomService.refreshRoom();
        roomViewPaused = false;
    } // End of the function
    function onPhoneViewLoaded(event)
    {
        phoneOpened = new org.osflash.signals.Signal();
        phoneClosed = new org.osflash.signals.Signal();
        var _loc2 = event.target.phone;
        phoneMediator = new com.clubpenguin.hud.phone.PhoneMediator(_loc2, this);
        hudIconMediator = new com.clubpenguin.hud.phone.mediator.HUDIconMediator(iconLayer.hudIconView, this);
    } // End of the function
    static var PHONE_ASSET_FILE_NAME = "phone.swf";
} // End of Class
