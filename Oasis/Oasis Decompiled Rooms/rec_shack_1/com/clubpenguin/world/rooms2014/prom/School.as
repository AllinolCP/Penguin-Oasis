class com.clubpenguin.world.rooms2014.prom.School extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, _destroyDelegate, _SHELL, _triggerWatcher, localize, setupNavigationButtons, _INTERFACE, _triggerWatcherInterval;
    function School(stageReference)
    {
        super(stageReference);
        _stage.start_x = 190;
        _stage.start_y = 360;
        this.init();
    } // End of the function
    function init()
    {
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
        this.localize([_stage.background_mc.itemContainer_mc.lang_mc, _stage.wallDivider_mc.cpu_mc]);
        _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 250, 240);
        _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rec_shack2", 360, 194);
        _stage.triggers_mc.rec_room_4_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rec_shack4", 135, 198);
        this.setFreeItems();
        _stage.triggers_mc.itemTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem);
        _stage.triggers_mc.bgTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeBG);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bob_mc.doorleft_btn, 44, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bob_mc.doorright_btn, 716, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker1_btn, 70, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker2_btn, 125, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker3_btn, 187, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker4_btn, 248, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker5_btn, 306, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker6_btn, 450, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker7_btn, 506, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker8_btn, 566, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker9_btn, 630, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker10_btn, 682, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.itemContainer_mc.item_btn, 200, 165), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.camera_mc.camerabutton_btn, 400, 170), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.podium_mc.podium_btn, 335, 145)]);
    } // End of the function
    function setFreeItems()
    {
        if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2014.prom.School.GRAD_HAT_ID))
        {
            _stage.background_mc.itemContainer_mc.gotoAndStop(2);
        } // end if
        if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2014.prom.School.PROM_BACKGROUND_ID))
        {
            _stage.camera_mc.gotoAndStop(2);
        } // end if
    } // End of the function
    function getFreeItem()
    {
        _INTERFACE.buyInventory(com.clubpenguin.world.rooms2014.prom.School.GRAD_HAT_ID);
    } // End of the function
    function getFreeBG()
    {
        _INTERFACE.buyInventory(com.clubpenguin.world.rooms2014.prom.School.PROM_BACKGROUND_ID);
    } // End of the function
    function openLocker(players, locker)
    {
        if (players.length > 0)
        {
            locker.openLocker();
        } // end if
    } // End of the function
    function closeLocker(players, trigger, locker)
    {
        if (trigger.getPlayerCount() == 0)
        {
            locker.closeLocker();
        } // end if
    } // End of the function
    function exit(roomName, x, y)
    {
        _SHELL.sendJoinRoom(roomName, x, y);
    } // End of the function
    function destroy()
    {
        clearInterval(_triggerWatcherInterval);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        false;
    } // End of the function
    static var CLASS_NAME = "School";
    static var GRAD_HAT_ID = 1880;
    static var PROM_BACKGROUND_ID = 9266;
} // End of Class
