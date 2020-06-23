﻿class com.clubpenguin.world.rooms.Plaza extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, _SHELL, localize, setupNavigationButtons, _destroyDelegate;
    function Plaza(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms.Plaza.CLASS_NAME + "()");
        _stage.start_x = 380;
        _stage.start_y = 350;
        if (!_SHELL)
        {
            this.init();
        } // end if
        this.localize([_stage.background_mc.signs_mc, _stage.background_mc.parkGate.gateOn.signText, _stage.background_mc.parkGate.gateOff.signText]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 35, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.park_btn, 85, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pet_btn, 213, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.hotel_btn, 341, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 270, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stage01_btn, 429, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.stage02_btn, 519, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizza_btn, 627, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 720, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.policed_mc, 424.500000, 190)]);
        _stage.forts_btn.useHandCursor = false;
        _stage.forest_btn.useHandCursor = false;
        _stage.tickets_btn.useHandCursor = false;
        _stage.background_mc.cannon_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, cannonAnimate);
        _stage.background_mc.cannon_btn.useHandCursor = false;
        _stage.park_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, parkRollOver);
        _stage.park_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, parkRollOut);
        _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
        _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
        _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 655, 235);
        _stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 335, 145);
        _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
        _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
        _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
        _stage.triggers_mc.stage01_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mc_lobby", 105, 330);
        _stage.triggers_mc.stage02_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "stage", 105, 330);
        _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 365, 195);
        _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 135, 215);
    } // End of the function
    function cannonAnimate()
    {
        _stage.foreground_mc.cannonpuffle_mc.gotoAndPlay(2);
        _stage.background_mc.cannonsmoke_mc.gotoAndPlay(2);
        _stage.background_mc.cannon_mc.gotoAndPlay(2);
    } // End of the function
    function manholeRollOver()
    {
        _stage.manhole_mc.gotoAndPlay("lidOpen");
    } // End of the function
    function manholeRollOut()
    {
        _stage.manhole_mc.gotoAndPlay("lidClose");
    } // End of the function
    function parkRollOver()
    {
        _stage.background_mc.parkGate.gotoAndStop("on");
    } // End of the function
    function parkRollOut()
    {
        _stage.background_mc.parkGate.gotoAndStop("off");
    } // End of the function
    function exit(name, x, y)
    {
        trace (com.clubpenguin.world.rooms.Plaza.CLASS_NAME + ": exit()");
        if (name == "cave")
        {
            _SHELL.stampEarned(UNDERGROUND_STAMP_ID);
        } // end if
        _SHELL.sendJoinRoom(name, x, y);
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms.Plaza.CLASS_NAME + ": init()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    function destroy()
    {
        trace (com.clubpenguin.world.rooms.Plaza.CLASS_NAME + ": destroy()");
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    static var CLASS_NAME = "Plaza";
    var UNDERGROUND_STAMP_ID = 10;
} // End of Class
