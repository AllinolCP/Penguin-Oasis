class com.clubpenguin.net.WebServiceManager extends com.clubpenguin.util.EventDispatcher
{
    var _shell, _isLoading, _servicesData, _arrServicesToLoad, _jsonLoader, dispatchEvent, _loadingServiceType;
    function WebServiceManager()
    {
        super();
        _shell = _global.getCurrentShell();
        _isLoading = false;
    } // End of the function
    function getServiceData(type)
    {
        var _loc2 = _servicesData[type.__get__name()];
        if (_loc2 == null)
        {
            _shell.$e("[WebCrumbsManager] getServiceData could not find a loaded crumb object for \'" + type + "\'");
        } // end if
        return (_loc2);
    } // End of the function
    function init()
    {
        if (_isLoading)
        {
            _shell.$e("[WebCrumbsManager] Initialization called while init already in progress.");
            return;
        } // end if
        _isLoading = true;
        _arrServicesToLoad = com.clubpenguin.net.WebServiceType.getServiceTypes();
        _jsonLoader = new com.clubpenguin.util.JSONLoader();
        _jsonLoader.addEventListener(com.clubpenguin.util.JSONLoader.COMPLETE, onJsonLoadCompleteHandler, this);
        _jsonLoader.addEventListener(com.clubpenguin.util.JSONLoader.FAIL, onJsonLoadFailHandler, this);
        _servicesData = {};
        this.loadNextService();
    } // End of the function
    function loadNextService()
    {
        if (_arrServicesToLoad.length == 0)
        {
            _jsonLoader.removeEventListener(com.clubpenguin.util.JSONLoader.COMPLETE, onJsonLoadCompleteHandler, this);
            _jsonLoader.removeEventListener(com.clubpenguin.util.JSONLoader.FAIL, onJsonLoadFailHandler, this);
            this.dispatchEvent({type: com.clubpenguin.net.WebServiceManager.EVENT_INIT_COMPLETE, target: this});
            return;
        } // end if
        _loadingServiceType = (com.clubpenguin.net.WebServiceType)(_arrServicesToLoad.shift());
        var _loc2 = "";
        if (_loadingServiceType.__get__isLocalized())
        {
            _loc2 = _shell.getWebService().url + _shell.getLanguageAbbreviation() + "/" + _loadingServiceType.__get__webServiceCrumbPath();
        }
        else
        {
            _loc2 = _shell.getWebService().url + _loadingServiceType.__get__webServiceCrumbPath();
        } // end else if
        this.debugTrace("Loading crumb from web service: Name=" + _loadingServiceType + " url=" + _loc2);
        _jsonLoader.load(_loc2);
    } // End of the function
    function onJsonLoadCompleteHandler(event)
    {
        var _loc2 = _jsonLoader.data;
        if (_loc2 == null)
        {
            _shell.$e("[WebCrumbsManager] Failed to load crumbs json: " + _loadingServiceType);
        }
        else
        {
            _servicesData[_loadingServiceType.__get__name()] = _loc2;
        } // end else if
        _loadingServiceType = null;
        this.loadNextService();
    } // End of the function
    function onJsonLoadFailHandler()
    {
        _shell.$e("[WebCrumbsManager] Failed to load crumbs json: " + _loadingServiceType);
        _loadingServiceType = null;
        this.loadNextService();
    } // End of the function
    function debugTrace(msg)
    {
        if (debugTracesEnabled)
        {
        } // end if
    } // End of the function
    var debugTracesEnabled = true;
    static var EVENT_INIT_COMPLETE = "initComplete";
} // End of Class
