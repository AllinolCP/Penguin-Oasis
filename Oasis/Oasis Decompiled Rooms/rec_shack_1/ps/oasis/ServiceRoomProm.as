class ps.oasis.ServiceRoomProm
{
    var _stage, _airtower, _shell, _engine, _destroyDelegate;
    function ServiceRoomProm(_CPP_Shop_Stage)
    {
        _stage = _CPP_Shop_Stage;
        _airtower = _global.getCurrentAirtower();
        _shell = _global.getCurrentShell();
        _engine = _global.getCurrentEngine();
        _global.getCurrentShell().serviceRoom = this;
    } // End of the function
    function SetupPlusRoom()
    {
        _stage.spotlight._alpha = 0;
        this.handleSetValue([0, "vote_text", "Vote Now"]);
        var _loc2 = com.clubpenguin.util.Delegate.create(this, handleSetValue);
        var _loc3 = com.clubpenguin.util.Delegate.create(this, handleSetWinner);
        _airtower.addListener(_handler_SetValue, _loc2);
        _airtower.addListener(_handler_SetWinner, _loc3);
        this.loadNodeTestData();
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _shell.addListener(_shell.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    function toggleLights()
    {
        _shell.developerModule.setPlusValue("toggleLights", 1);
    } // End of the function
    function loadNodeTestData()
    {
        var _loc2 = new com.clubpenguin.util.JSONLoader();
        _loc2.addEventListener("complete", handleNodeResponse);
        _loc2.load("http://service-authx1.oasis.ps/event/" + eventId + "?no-cache=Oasis_" + new Date().getTime());
    } // End of the function
    function handleNodeResponse(event)
    {
        if (event.target.data.event == undefined)
        {
            return (false);
        } // end if
        for (var _loc3 in event.target.data.event.value)
        {
            _global.getCurrentShell().serviceRoom.handleSetValue([0, _loc3, event.target.data.event.value[_loc3]]);
        } // end of for...in
    } // End of the function
    function setTextAgain()
    {
        var _loc3 = this;
        if (_loc3._roomSettings == undefined)
        {
            _loc3 = _global.getCurrentShell().serviceRoom;
        } // end if
        _loc3._stage.background_mc.tv_mc.tv_txt.stage_txt.text = _global.winnerName;
        _loc3._stage.confShow.gotoAndStop(1);
        _loc3._stage.confShow2.gotoAndStop(1);
        _loc3._stage.confShow.gotoAndStop(2);
        _loc3._stage.confShow2.gotoAndStop(2);
    } // End of the function
    function handleSetWinner(event)
    {
        event.shift();
        var _loc3 = this;
        if (_loc3._roomSettings == undefined)
        {
            _loc3 = _global.getCurrentShell().serviceRoom;
        } // end if
        _loc3._stage.background_mc.tv_mc.tv_txt.gotoAndPlay(1);
        var _loc4 = event.shift();
        if (_loc4 == undefined)
        {
            return (false);
        } // end if
        _global.winnerName = _loc4;
        _loc3._stage.background_mc.tv_mc.tv_txt.stage_txt.text = _loc4;
    } // End of the function
    function handleSetValue(Event)
    {
        Event.shift();
        var _loc4 = Event.shift();
        var _loc3 = Event.shift();
        var env = this;
        if (env._roomSettings == undefined)
        {
            env = _global.getCurrentShell().serviceRoom;
        } // end if
        if (_loc4 != "toggleLights")
        {
            env._roomSettings[_loc4] = _loc3;
        } // end if
        switch (_loc4)
        {
            case "l1":
            case "l2":
            case "l3":
            case "l4":
            case "l5":
            case "l6":
            case "l7":
            case "l8":
            case "l9":
            {
                if (_loc3 == 0)
                {
                    return (env._stage.background_mc.bgBitmap.lighting[_loc4]._alpha = 0);
                } // end if
                env._stage.background_mc.bgBitmap.lighting[_loc4]._alpha = 100;
                var _loc6 = new Color(env._stage.background_mc.bgBitmap.lighting[_loc4].lcolor);
                _loc6.setRGB("0x" + String(_loc3));
                return (true);
            } 
            case "conf":
            {
                env._stage.confShow.gotoAndStop(1);
                env._stage.confShow2.gotoAndStop(1);
                env._stage.confShow.gotoAndStop(2);
                env._stage.confShow2.gotoAndStop(2);
                break;
            } 
            case "vote_text":
            {
                env._stage.background_mc.tv_mc.tv_txt.gotoAndStop(56);
                env._stage.background_mc.tv_mc.tv_txt.stage_txt.text = _loc3;
                break;
            } 
            case "board":
            {
                _loc3 = _loc3.split("|");
                env._stage.background_mc.bgBitmap.todaysTopic.board_txt.text = _loc3[0];
                env._stage.background_mc.bgBitmap.todaysTopic.board_txt_two.text = _loc3[1];
                break;
            } 
            case "board_line_1":
            {
                env._stage.background_mc.bgBitmap.todaysTopic.board_txt.text = _loc3;
                break;
            } 
            case "board_line_2":
            {
                env._stage.background_mc.bgBitmap.todaysTopic.board_txt_two.text = _loc3;
                break;
            } 
            case "spotLightColor":
            {
                _loc6 = new Color(env._stage.spotlight);
                _loc6.setRGB("0x" + String(_loc3));
                return (true);
            } 
            case "spotLight":
            {
                env._stage.spotlight.gotoAndStop(_loc3);
                return (true);
            } 
            case "meeting":
            {
                if (Boolean(Number(_loc3)) == true || _loc3 == 1)
                {
                    env._stage.foreground_mc.screen.gotoAndStop(2);
                }
                else
                {
                    env._stage.foreground_mc.screen.gotoAndStop(1);
                } // end else if
                break;
            } 
            case "toggleLights":
            {
                if (env._roomSettings.lightsOff == true)
                {
                    env._stage.background_mc.background_props.lightSwitch.gotoAndStop(2);
                    var brightnessColor = -65;
                    var stopAt = 0;
                    env._stage.background_mc.background_props.bg_light.onEnterFrame = function ()
                    {
                        if (stopAt == brightnessColor)
                        {
                            delete env._stage.background_mc.background_props.bg_light.onEnterFrame;
                        } // end if
                        var _loc2 = [1, 0, 0, 0, brightnessColor, 0, 1, 0, 0, brightnessColor, 0, 0, 1, 0, brightnessColor, 0, 0, 0, 1, 0];
                        var _loc1 = new flash.filters.ColorMatrixFilter(_loc2);
                        env._stage.background_mc.background_props.bg_light.filters = [_loc1];
                        ++brightnessColor;
                    };
                    env._roomSettings.lightsOff = false;
                }
                else
                {
                    env._stage.background_mc.background_props.lightSwitch.gotoAndStop(1);
                    var brightnessColor = 0;
                    var stopAt = -65;
                    env._stage.background_mc.background_props.bg_light.onEnterFrame = function ()
                    {
                        if (stopAt == brightnessColor)
                        {
                            delete env._stage.background_mc.background_props.bg_light.onEnterFrame;
                        } // end if
                        var _loc2 = [1, 0, 0, 0, brightnessColor, 0, 1, 0, 0, brightnessColor, 0, 0, 1, 0, brightnessColor, 0, 0, 0, 1, 0];
                        var _loc1 = new flash.filters.ColorMatrixFilter(_loc2);
                        env._stage.background_mc.background_props.bg_light.filters = [_loc1];
                        --brightnessColor;
                    };
                    env._roomSettings.lightsOff = true;
                } // end else if
                return (true);
            } 
            case "darkenRoomCompletely":
            {
                env._stage.background_mc.background_props.lightone_color._alpha = 0;
                env._stage.background_mc.background_props.lighttwo_color._alpha = 0;
                env._stage.background_mc.background_props.lightthree_color._alpha = 0;
                env._stage.background_mc.background_props.lightfour_color._alpha = 0;
                return (true);
            } 
            case "playMusic":
            {
                env._stage.background_mc.background_props.speakers.play();
                return (true);
            } 
            case "stopMusic":
            {
                env._stage.background_mc.background_props.speakers.stop();
                return (true);
            } 
            default:
            {
                flash.external.ExternalInterface.call("console.warn", "[CP+][DynRoom] -> unknown action: " + _loc4 + " --> " + _loc3);
                return (false);
            } 
        } // End of switch
    } // End of the function
    function destroy()
    {
        _global.getCurrentShell().removeListener(_global.getCurrentShell().ROOM_DESTROYED, _destroyDelegate);
        var _loc3 = com.clubpenguin.util.Delegate.create(this, handleSetValue);
        var _loc4 = com.clubpenguin.util.Delegate.create(this, handleSetWinner);
        _airtower.removeListener(_handler_SetValue, _loc3);
        _airtower.removeListener(_handler_SetWinner, _loc4);
        false;
    } // End of the function
    var eventId = "4f6adb84-f118-11e4-b9b2-1697f925ec7b";
    var _handler_RunFunction = "runfunc";
    var _handler_SetValue = "pvalue";
    var _handler_SetWinner = "winner";
    var _handler_RunSpotLight = "spotlight";
    var _handler_SetLighting = "lighting";
    var _roomSettings = {};
    var colorToFlash = "00ff00";
} // End of Class
