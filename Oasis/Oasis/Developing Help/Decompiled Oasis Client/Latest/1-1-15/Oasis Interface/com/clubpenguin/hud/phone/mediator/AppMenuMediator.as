class com.clubpenguin.hud.phone.mediator.AppMenuMediator
{
    var toolTipChanged, languageCrumbs, iconPressed, view;
    function AppMenuMediator(view, toolTipChanged, player, languageCrumbs)
    {
        this.toolTipChanged = toolTipChanged;
        this.languageCrumbs = languageCrumbs;
        this.initView(view);
        iconPressed = new org.osflash.signals.Signal(String);
    } // End of the function
    function initView(view)
    {
        this.view = view;
        if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3())
        {
            clearInterval(delayInterval);
            delayInterval = setInterval(this, "delaySetupIcons", com.clubpenguin.hud.phone.mediator.AppMenuMediator.DELAY_AMOUNT);
        }
        else
        {
            this.setupIcons();
        } // end else if
    } // End of the function
    function delaySetupIcons()
    {
        clearInterval(delayInterval);
        this.setupIcons();
    } // End of the function
    function setupIcons()
    {
        icons = [view.agentStatus, view.fieldOps, view.teleport, view.puffle, view.recruit];
        for (var _loc3 = 0; _loc3 < icons.length; ++_loc3)
        {
            var _loc4 = com.clubpenguin.util.Delegate.create(this, timeoutFunction);
            var _loc5 = _global.setTimeout(_loc4, 0, [_loc3]);
        } // end of for
    } // End of the function
    function timeoutFunction(iterator)
    {
        var _loc2 = icons[iterator];
        _loc2.rollOverSignal.add(onIconRollOver, this);
        _loc2.rollOutSignal.add(onIconRollOut, this);
        _loc2.rollOutSignal.add(onIconRollOut, this);
        if (_loc2.__get__active())
        {
            _loc2.pressSignal.add(onIconPress, this);
            _loc2.title = languageCrumbs[_loc2._name];
        }
        else
        {
            _loc2.title = languageCrumbs["Coming Soon"];
        } // end else if
    } // End of the function
    function onIconPress(icon)
    {
        iconPressed.dispatch(icon._name);
        this.onIconRollOut(icon);
    } // End of the function
    function onIconRollOver(icon)
    {
        toolTipChanged.dispatch(icon.title);
    } // End of the function
    function onIconRollOut(icon)
    {
        toolTipChanged.dispatch("");
    } // End of the function
    static var DELAY_AMOUNT = 250;
    var icons = new Array();
    var delayInterval = null;
} // End of Class
