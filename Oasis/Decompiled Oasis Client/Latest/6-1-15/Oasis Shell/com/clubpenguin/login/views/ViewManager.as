class com.clubpenguin.login.views.ViewManager extends com.clubpenguin.ui.views.AbstractViewManager
{
    var _shell, __get__shell, _mc, _startScreenHolderClip, _queryStringParent, _startScreen, _views, _languageAbbreviation, getView, _startScreenXmlPath, _accessToCreatePenguinFlow, showView, addView, __set__shell;
    function ViewManager(mc)
    {
        super(mc);
        com.clubpenguin.login.views.ViewManager.debugTrace("View manager instantiated - mc:" + mc);
    } // End of the function
    function set shell(target)
    {
        _shell = target;
        //return (this.shell());
        null;
    } // End of the function
    function get shell()
    {
        return (_shell);
    } // End of the function
    function initialize()
    {
        if (_shell == null)
        {
            com.clubpenguin.login.views.ViewManager.debugTrace("initialize() - Shell not injected into ViewManager");
        } // end if
        _startScreenHolderClip = _mc.createEmptyMovieClip("startScreenHolderClip", _mc.getNextHighestDepth());
        var _loc3 = com.clubpenguin.util.URLUtils.getCacheResetURL(_shell.getClientPath() + "startscreen.swf");
        _queryStringParent = String(flash.external.ExternalInterface.call("parent.window.location.search.substring", 1));
        var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onStartScreenClassLoaded));
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
        _loc2.loadClip(_loc3, _startScreenHolderClip);
    } // End of the function
    function onLoadError(event)
    {
        _shell.$e("ViewManager -> onLoadError()", {error_code: event.errorCode});
    } // End of the function
    function onStartScreenClassLoaded(event)
    {
        _startScreen = _global.com.clubpenguin.login.views.StartScreen;
        this.initViews();
        this.showInitialView();
    } // End of the function
    function addStartScreenView(viewClass)
    {
        var _loc2;
        if (viewClass == null)
        {
            com.clubpenguin.login.views.ViewManager.debugTrace("addStartScreenView() viewClass parameter undefined!");
            _loc2 = null;
        }
        else
        {
            var _loc3 = _mc.startScreenHolderClip;
            _loc2 = (com.clubpenguin.ui.views.IView)(_loc3.attachMovie(viewClass.LINKAGE_ID, viewClass.LINKAGE_ID, _loc3.getNextHighestDepth()));
            _loc2.hide();
            _loc2.setViewManager(this);
            _views.push(_loc2);
        } // end else if
        return (_loc2);
    } // End of the function
    function setLanguageAbbreviation(abbr)
    {
        _languageAbbreviation = abbr;
    } // End of the function
    function setStartScreenXmlPath(path)
    {
        if (this.getView(_startScreen) != null)
        {
            Object(this.getView(_startScreen)).setXmlPath(path);
            _startScreenXmlPath = null;
            return;
        } // end if
        _startScreenXmlPath = path;
    } // End of the function
    function getRedemptionStatus()
    {
        return (_redemptionActive);
    } // End of the function
    function setRedemptionStatus(status)
    {
        _redemptionActive = status;
    } // End of the function
    function setAccessToCreatePenguinFlow(access)
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("setAccessToCreatePenguinFlow:" + access);
        _accessToCreatePenguinFlow = access;
    } // End of the function
    function hideAllWindows()
    {
        for (var _loc2 in _views)
        {
            _views[_loc2].hide();
        } // end of for...in
    } // End of the function
    function gotoStart()
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("-> gotoStart:" + this.getView(_startScreen));
        this.hideAllWindows();
        this.getView(_startScreen).show();
    } // End of the function
    function gotoPlayerSelection()
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("-> gotoPlayerSelection");
        this.hideAllWindows();
        var _loc2 = (com.clubpenguin.login.views.PlayerSelection)(this.getView(com.clubpenguin.login.views.PlayerSelection));
        _loc2.setupPlayerSelection();
        _loc2.show();
    } // End of the function
    function gotoPlayerLogin(obj)
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("-> gotoPlayerLogin");
        this.hideAllWindows();
        var _loc2 = (com.clubpenguin.login.views.PlayerLogin)(this.getView(com.clubpenguin.login.views.PlayerLogin));
        _loc2.setup(obj);
        _loc2.show();
    } // End of the function
    function gotoWorldSelection()
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("-> gotoWorldSelection");
        this.hideAllWindows();
        var _loc2 = (com.clubpenguin.login.views.WorldSelection)(this.getView(com.clubpenguin.login.views.WorldSelection));
        _loc2.setupWorldSelection();
        _loc2.show();
    } // End of the function
    function gotoMoreServers()
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("-> gotoMoreServers");
        this.hideAllWindows();
        var _loc2 = (com.clubpenguin.login.views.MoreServers)(this.getView(com.clubpenguin.login.views.MoreServers));
        _loc2.show();
        if (moreServersTracked)
        {
            return;
        } // end if
        _shell.trackContent("moreServers");
        moreServersTracked = true;
    } // End of the function
    function gotoNewPlayer()
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("-> gotoNewPlayer");
        this.hideAllWindows();
        var _loc2 = (com.clubpenguin.login.views.NewPlayer)(this.getView(com.clubpenguin.login.views.NewPlayer));
        _loc2.setup({});
        _loc2.show();
    } // End of the function
    function gotoCreatePenguin()
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("-> gotoCreatePenguin");
        this.hideAllWindows();
        this._accessToCreatePenguinFlow();
    } // End of the function
    function isMoreServersActive()
    {
        var _loc2 = (com.clubpenguin.login.views.MoreServers)(this.getView(com.clubpenguin.login.views.MoreServers));
        return (_loc2.isActive());
    } // End of the function
    function showInitialView()
    {
        var _loc3 = this.getQueryParams(_queryStringParent);
        var _loc5 = _loc3.create;
        var _loc4 = _loc3.login;
        if (_loc4 == "true")
        {
            var _loc6 = _global.com.clubpenguin.login.LocalData;
            if (_loc6.getSavedPlayers().length > 0)
            {
                this.gotoPlayerSelection();
            }
            else
            {
                this.gotoNewPlayer();
            } // end else if
            return;
        } // end if
        if (_loc5 == "true")
        {
            this.gotoCreatePenguin();
            com.clubpenguin.login.views.ViewManager.debugTrace("showInitialView: Create Account");
            return;
        } // end if
        this.showView(_startScreen);
        com.clubpenguin.login.views.ViewManager.debugTrace("showInitialView: " + this.getView(_startScreen));
    } // End of the function
    function initViews()
    {
        com.clubpenguin.login.views.ViewManager.debugTrace("initViews");
        var _loc3;
        _loc3 = this.addStartScreenView(_startScreen);
        _loc3.setLanguageAbbr(_languageAbbreviation);
        _loc3.setShell(_shell);
        var _loc4 = Object(_loc3);
        _loc4.tools = _global.com.clubpenguin.login.Tools;
        _loc4.localData = _global.com.clubpenguin.login.LocalData;
        if (_startScreenXmlPath != null)
        {
            _loc4.setXmlPath(_startScreenXmlPath);
            _startScreenXmlPath = null;
        } // end if
        var _loc5 = _global.com.clubpenguin.login.StartUI;
        _loc4.ui.addEventListener(_loc5.REDEMPTION_RELEASE, _loc4.startRedemptionRelease, _loc3);
        _loc4.ui.addEventListener(_loc5.START_RELEASE, _loc4.startRelease, _loc3);
        _loc4.ui.addEventListener(_loc5.MEMBERSHIP_RELEASE, _loc4.membershipRelease, _loc3);
        _loc4.ui.addEventListener(_loc5.CREATE_PENGUIN_RELEASE, _loc4.createPenguinRelease, _loc3);
        _loc3 = this.addView(com.clubpenguin.login.views.NewPlayer);
        _loc3.setLanguageAbbr(_languageAbbreviation);
        _loc3.setShell(_shell);
        var _loc7 = (com.clubpenguin.login.views.NewPlayer)(_loc3);
        _loc7._x = com.clubpenguin.login.views.ViewManager.NEWPLAYER_X;
        _loc7._y = com.clubpenguin.login.views.ViewManager.NEWPLAYER_Y;
        _loc3 = this.addView(com.clubpenguin.login.views.PlayerSelection);
        _loc3.setLanguageAbbr(_languageAbbreviation);
        _loc3.setShell(_shell);
        _loc3 = this.addView(com.clubpenguin.login.views.PlayerLogin);
        _loc3.setLanguageAbbr(_languageAbbreviation);
        _loc3.setShell(_shell);
        var _loc8 = (com.clubpenguin.login.views.PlayerLogin)(_loc3);
        _loc8._x = com.clubpenguin.login.views.ViewManager.PLAYERLOGIN_X;
        _loc8._y = com.clubpenguin.login.views.ViewManager.PLAYERLOGIN_Y;
        _loc3 = this.addView(com.clubpenguin.login.views.WorldSelection);
        _loc3.setLanguageAbbr(_languageAbbreviation);
        _loc3.setShell(_shell);
        _loc3 = this.addView(com.clubpenguin.login.views.MoreServers);
        _loc3.setLanguageAbbr(_languageAbbreviation);
        _loc3.setShell(_shell);
        var _loc6 = (com.clubpenguin.login.views.MoreServers)(_loc3);
        _loc6._x = com.clubpenguin.login.views.ViewManager.MORESERVERS_X;
        _loc6._y = com.clubpenguin.login.views.ViewManager.MORESERVERS_Y;
    } // End of the function
    function getQueryParams(queryString)
    {
        if (flash.external.ExternalInterface.available != false)
        {
            if (queryString)
            {
                var _loc7 = {};
                var _loc6 = queryString.split("&");
                var _loc3 = 0;
                var _loc4 = -1;
                while (_loc3 < _loc6.length)
                {
                    var _loc1 = _loc6[_loc3];
                    _loc4 = _loc1.indexOf("=");
                    if (_loc1.indexOf("=") > 0)
                    {
                        var _loc2 = _loc1.substring(0, _loc4);
                        _loc2.toLowerCase();
                        var _loc5 = _loc1.substring(_loc4 + 1);
                        _loc7[_loc2] = _loc5;
                    } // end if
                    ++_loc3;
                } // end while
                return (_loc7);
            } // end if
        } // end if
    } // End of the function
    static function debugTrace(msg)
    {
        if (!com.clubpenguin.login.views.ViewManager._debugTracesActive)
        {
            return;
        } // end if
    } // End of the function
    static var NEWPLAYER_X = 129;
    static var NEWPLAYER_Y = 90;
    static var PLAYERLOGIN_X = 118;
    static var PLAYERLOGIN_Y = 47;
    static var MORESERVERS_X = 54;
    static var MORESERVERS_Y = 18;
    static var PROP_INTERVAL = 10;
    static var _debugTracesActive = true;
    var _redemptionActive = false;
    var moreServersTracked = false;
    var __propInterval = null;
} // End of Class
