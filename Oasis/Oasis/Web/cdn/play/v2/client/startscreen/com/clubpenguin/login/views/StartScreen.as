class com.clubpenguin.login.views.StartScreen extends com.clubpenguin.ui.views.AbstractView
{
    var _queryStringFrame, _queryStringParent, attachMovie, _backgroundManager, _startUi, _messageManager, _overlayManager, _xml, _xmlSourceURL, _shell, viewManager, _tools, getURL, _localData, __get__tools, __get__localData, __set__localData, __set__tools, __get__ui;
    function StartScreen()
    {
        super();
        com.clubpenguin.login.views.StartScreen.debugTrace("StartScreen says: instantiated");
        _queryStringFrame = String(flash.external.ExternalInterface.call("window.location.search.substring", 1));
        _queryStringParent = String(flash.external.ExternalInterface.call("parent.window.location.search.substring", 1));
        _backgroundManager = (com.clubpenguin.login.BackgroundManager)(this.attachMovie(com.clubpenguin.login.BackgroundManager.LINKAGE_ID, "_backgroundManager", 0));
        _startUi = (com.clubpenguin.login.StartUI)(this.attachMovie(com.clubpenguin.login.StartUI.LINKAGE_ID, "_startUi", 1, {_x: com.clubpenguin.login.views.StartScreen.UI_X, _y: com.clubpenguin.login.views.StartScreen.UI_Y}));
        _messageManager = (com.clubpenguin.login.messages.MessageManager)(this.attachMovie(com.clubpenguin.login.messages.MessageManager.LINKAGE_ID, "_messageManager", 2, {_x: com.clubpenguin.login.views.StartScreen.MESSAGE_MANAGER_X, _y: com.clubpenguin.login.views.StartScreen.MESSAGE_MANAGER_Y}));
        _messageManager.addEventListener(com.clubpenguin.login.messages.MessageManager.SHOW_CONTENT, handleShowContent, this);
        _overlayManager = (com.clubpenguin.login.OverlayManager)(this.attachMovie(com.clubpenguin.login.OverlayManager.LINKAGE_ID, "_overlayManager", 3));
    } // End of the function
    function show()
    {
        super.show();
    } // End of the function
    function setLanguageAbbr(abbr)
    {
        super.setLanguageAbbr(abbr);
    } // End of the function
    function handleShowContent(event)
    {
        _overlayManager.__set__contentURL(event.url);
        _overlayManager.load();
    } // End of the function
    function setXmlPath(path)
    {
        _xml = new XML();
        _xml.ignoreWhite = true;
        _xml.onLoad = com.clubpenguin.util.Delegate.create(this, handleLoadXML);
        _xmlSourceURL = path;
        _xml.load(_xmlSourceURL);
    } // End of the function
    function handleLoadXML(success)
    {
        if (success)
        {
            if (_xml.status == 0)
            {
                _backgroundManager.__set__parameters(this.getQueryParams(_queryStringParent));
                this.delegateXML();
            }
            else
            {
                com.clubpenguin.login.views.StartScreen.debugTrace("[StartScreen] Problem parsing XML.");
            } // end else if
        }
        else
        {
            _shell.$e("[StartScreen] Could not load startscreen.xml!", {error_code: _shell.LOAD_ERROR, file_path: _xmlSourceURL});
        } // end else if
    } // End of the function
    function delegateXML()
    {
        com.clubpenguin.login.views.StartScreen.debugTrace("delegateXML()");
        var _loc3 = this.getQueryParams(_queryStringFrame);
        for (var _loc2 = _xml.firstChild.firstChild; _loc2 != null; _loc2 = _loc2.nextSibling)
        {
            if (_loc2.nodeName == com.clubpenguin.login.messages.MessageManager.ROOT_NODE)
            {
                _messageManager.createMessagesFromXMLNode(_loc2);
            } // end if
            if (_loc2.nodeName == com.clubpenguin.login.BackgroundManager.ROOT_NODE)
            {
                _backgroundManager.createBackgroundsFromXMLNode(_loc2);
            } // end if
        } // end of for
    } // End of the function
    function getQueryParams(queryString)
    {
        if (flash.external.ExternalInterface.available == false)
        {
            return;
        } // end if
        if (queryString)
        {
            var _loc7 = {};
            var _loc6 = queryString.split("&");
            var _loc4 = 0;
            var _loc2 = -1;
            while (_loc4 < _loc6.length)
            {
                var _loc1 = _loc6[_loc4];
                _loc2 = _loc1.indexOf("=");
                if (_loc2 > 0)
                {
                    var _loc3 = _loc1.substring(0, _loc2);
                    _loc3.toLowerCase();
                    var _loc5 = _loc1.substring(_loc2 + 1);
                    _loc7[_loc3] = _loc5;
                } // end if
                ++_loc4;
            } // end while
            return (_loc7);
        } // end if
    } // End of the function
    function startRelease()
    {
        var _loc2 = this.getQueryParams(_queryStringFrame);
        var _loc3 = _loc2.redemption == "true";
        Object(viewManager).setRedemptionStatus(_loc3);
        this.chooseNextView();
    } // End of the function
    function startRedemptionRelease()
    {
        Object(viewManager).setRedemptionStatus(true);
        this.chooseNextView();
    } // End of the function
    function createPenguinRelease()
    {
        Object(viewManager).gotoCreatePenguin();
    } // End of the function
    function membershipRelease()
    {
        this.getURL(_shell.getPath("member_web") + _tools.getTrackingAppend(), "_parent");
    } // End of the function
    function chooseNextView()
    {
        if (_localData.getSavedPlayers().length > 0)
        {
            Object(viewManager).gotoPlayerSelection();
        }
        else
        {
            Object(viewManager).gotoNewPlayer();
        } // end else if
    } // End of the function
    static function debugTrace(msg)
    {
        if (com.clubpenguin.login.views.StartScreen._debugTracesActive)
        {
        } // end if
    } // End of the function
    function get ui()
    {
        return (_startUi);
    } // End of the function
    function set tools(obj)
    {
        _tools = obj;
        //return (this.tools());
        null;
    } // End of the function
    function get tools()
    {
        return (_tools);
    } // End of the function
    function set localData(obj)
    {
        _localData = obj;
        //return (this.localData());
        null;
    } // End of the function
    function get localData()
    {
        return (_localData);
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.login.views.StartScreen";
    static var MESSAGE_MANAGER_X = 94;
    static var MESSAGE_MANAGER_Y = 380;
    static var UI_X = 0;
    static var UI_Y = 0;
    static var _debugTracesActive = true;
} // End of Class
