class com.clubpenguin.games.cardjitsu.water.uielements.uipanel.UIPanelGameQuality extends com.clubpenguin.games.cardjitsu.water.uielements.UIPanel
{
    var __shell, __gameRoot, _x, _y, cacheAsBitmap, button_holder, tooltip_mc, hitArea_mc, hitArea, onEnterFrame, __qualityOriginal, _quality, hitTest, __sfsPlayerId, __qualitySettingMax, __saveData, __qualityIndex, gotoAndStop;
    function UIPanelGameQuality()
    {
        super();
        this.init();
    } // End of the function
    function init()
    {
        __shell = com.clubpenguin.ProjectGlobals.shell;
        __gameRoot = com.clubpenguin.games.cardjitsu.water.DisplayManager.getInstance().getGameRoot();
        _x = 380;
        _y = 0;
        cacheAsBitmap = true;
        this.show();
        this.closeState();
        this.setupDisplayQuality();
        button_holder.btn_low.onPress = com.clubpenguin.util.Delegate.create(this, handleOnRelease, 0);
        button_holder.btn_medium.onPress = com.clubpenguin.util.Delegate.create(this, handleOnRelease, 1);
        button_holder.btn_high.onPress = com.clubpenguin.util.Delegate.create(this, handleOnRelease, 2);
        button_holder.btn_low.onRollOver = com.clubpenguin.util.Delegate.create(this, handleButtonRollOver, com.clubpenguin.lib.locale.LocaleText.getText("ui_quality_low"), button_holder.btn_low);
        button_holder.btn_medium.onRollOver = com.clubpenguin.util.Delegate.create(this, handleButtonRollOver, com.clubpenguin.lib.locale.LocaleText.getText("ui_quality_medium"), button_holder.btn_medium);
        button_holder.btn_high.onRollOver = com.clubpenguin.util.Delegate.create(this, handleButtonRollOver, com.clubpenguin.lib.locale.LocaleText.getText("ui_quality_high"), button_holder.btn_high);
        button_holder.btn_low.onRollOut = com.clubpenguin.util.Delegate.create(this, handleButtonRollOut);
        button_holder.btn_medium.onRollOut = com.clubpenguin.util.Delegate.create(this, handleButtonRollOut);
        button_holder.btn_high.onRollOut = com.clubpenguin.util.Delegate.create(this, handleButtonRollOut);
        tooltip_mc._visible = false;
        tooltip_mc._alpha = 100;
        tooltip_mc._y = button_holder.btn_low._y + 12;
        tooltip_mc.tool_txt.multiline = false;
        tooltip_mc.tool_txt.selectable = false;
        tooltip_mc.tool_txt.autoSize = true;
        tooltip_mc.tool_txt.background = true;
        tooltip_mc.tool_txt.backgroundColor = 16772993;
        tooltip_mc.tool_txt.border = true;
        tooltip_mc.tool_txt.borderColor = 11372321;
        hitArea_mc._alpha = 0;
        hitArea = hitArea_mc;
        onEnterFrame = doUpdate;
    } // End of the function
    function dispose()
    {
        onEnterFrame = null;
        _quality = __qualityOriginal;
    } // End of the function
    function doUpdate()
    {
        var _loc2;
        _loc2 = this.hitTest(__gameRoot._xmouse, __gameRoot._ymouse, true);
        if (!__isPanelOpen && _loc2)
        {
            this.handlePanelRollOver();
            __isPanelOpen = true;
        }
        else if (__isPanelOpen && !_loc2)
        {
            this.handlePanelRollOut();
            __isPanelOpen = false;
        } // end else if
    } // End of the function
    function setupDisplayQuality()
    {
        __qualityOriginal = _quality;
        __sfsPlayerId = __shell.getMyPlayerId();
        __qualitySettingMax = __qualitySetting.length;
        __qualityOriginal = _quality;
        __saveData = new com.clubpenguin.lib.data.SaveGameData("CardJitsu_Water");
        __qualityIndex = parseInt(__saveData.request(__sfsPlayerId));
        if (isNaN(__qualityIndex))
        {
            __qualityIndex = __qualitySettingMax - 2;
            __saveData.send(__sfsPlayerId, String(com.clubpenguin.games.cardjitsu.water.ProjectConstants.QUALITY_MAX_DRAW_ATTENTION));
            this.openState();
        }
        else if (__qualityIndex < com.clubpenguin.games.cardjitsu.water.ProjectConstants.QUALITY_STOP_DRAW_ATTENTION)
        {
            if (__qualityIndex < com.clubpenguin.games.cardjitsu.water.ProjectConstants.QUALITY_MAX_DRAW_ATTENTION)
            {
                __qualityIndex = com.clubpenguin.games.cardjitsu.water.ProjectConstants.QUALITY_MAX_DRAW_ATTENTION;
            } // end if
            __qualityIndex = __qualityIndex + 1;
            if (__qualityIndex == com.clubpenguin.games.cardjitsu.water.ProjectConstants.QUALITY_STOP_DRAW_ATTENTION)
            {
                __qualityIndex = __qualitySettingMax - 2;
                this.closeState();
            }
            else
            {
                this.openState();
            } // end else if
            __saveData.send(__sfsPlayerId, String(__qualityIndex));
            __qualityIndex = __qualitySettingMax - 2;
        }
        else if (__qualityIndex >= __qualitySettingMax)
        {
            __qualityIndex = __qualitySettingMax - 1;
            __saveData.send(__sfsPlayerId, String(__qualityIndex));
        } // end else if
        _quality = __qualitySetting[__qualityIndex];
        button_holder.gotoAndStop(__qualityIndex + 1);
    } // End of the function
    function show()
    {
        super.show();
    } // End of the function
    function hide()
    {
        super.hide();
    } // End of the function
    function shown()
    {
        super.shown();
    } // End of the function
    function hidden()
    {
        super.hidden();
    } // End of the function
    function openState()
    {
        this.gotoAndStop("show");
    } // End of the function
    function closeState()
    {
        this.gotoAndStop("hide");
    } // End of the function
    function handlePanelRollOver()
    {
        this.openState();
    } // End of the function
    function handlePanelRollOut()
    {
        this.closeState();
    } // End of the function
    function handleButtonRollOver(_tooltipText, _btn)
    {
        tooltip_mc.tool_txt.text = _tooltipText;
        tooltip_mc._x = -button_holder._width / 2 - tooltip_mc.tool_txt._width / 2 + _btn._x;
        tooltip_mc._visible = true;
    } // End of the function
    function handleButtonRollOut()
    {
        tooltip_mc.tool_txt.text = "";
        tooltip_mc._visible = false;
    } // End of the function
    function handleOnRelease(_level)
    {
        __qualityIndex = _level;
        if (__qualityIndex < 0)
        {
            __qualityIndex = 0;
        }
        else if (__qualityIndex >= __qualitySettingMax)
        {
            __qualityIndex = __qualitySettingMax - 1;
        } // end else if
        button_holder.gotoAndStop(__qualityIndex + 1);
        _quality = __qualitySetting[__qualityIndex];
        __saveData.send(__sfsPlayerId, String(__qualityIndex));
    } // End of the function
    var __qualitySetting = ["LOW", "MEDIUM", "HIGH"];
    var __isPanelOpen = false;
} // End of Class
