class com.clubpenguin.login.BackgroundManager extends MovieClip
{
    var _shell, _loader, createEmptyMovieClip, _containerClip, _randomBackground, _params, _backgrounds, _backgroundProbabilityTotal, getURL, __get__parameters, __set__parameters;
    function BackgroundManager()
    {
        super();
        _shell = _global.getCurrentShell();
        _loader = new MovieClipLoader();
        _loader.addListener(this);
        _containerClip = this.createEmptyMovieClip("_containerClip", 0);
    } // End of the function
    function onLoadInit(targetClip)
    {
        _shell.loginLoadComplete();
        if (_randomBackground.link != undefined)
        {
            targetClip.clickable_mc.onRelease = com.clubpenguin.util.Delegate.create(this, handleBackgroundRelease);
        } // end if
    } // End of the function
    function onLoadError()
    {
        _shell.loginLoadError();
    } // End of the function
    function load()
    {
        var _loc4 = Number(_params.billboard) || Number(_params.Billboard);
        --_noLinkLength;
        if (_loc4 != 0 && _loc4 + _noLinkLength < _backgrounds.length)
        {
            _randomBackground = _backgrounds[_loc4 + _noLinkLength];
        }
        else
        {
            _randomBackground = _backgrounds[0];
            var _loc3 = Math.random() * _backgroundProbabilityTotal;
            for (var _loc2 = 0; _loc2 < _backgrounds.length; ++_loc2)
            {
                if (_loc3 < _backgrounds[_loc2].cumulativeFrequency)
                {
                    _randomBackground = _backgrounds[_loc2];
                    break;
                } // end if
            } // end of for
        } // end else if
        _shell.showLoading(_shell.getLocalizedString("Loading Content"), this);
        var _loc5 = com.clubpenguin.util.URLUtils.getCacheResetURL(_shell.getStartScreenBackgroundsPath() + _randomBackground.url);
        if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3())
        {
            _loader.loadClip(_loc5, _containerClip);
            this.addUnloadListener();
        }
        else
        {
            _loader.loadClip(_loc5, _containerClip);
        } // end else if
    } // End of the function
    function addUnloadListener()
    {
        var classInstance = this;
        _containerClip.onUnload = function ()
        {
            classInstance.onLoadInit(this);
        };
    } // End of the function
    function loadCompleteUnderAS3()
    {
        _shell.loginLoadComplete();
    } // End of the function
    function startLoadListening()
    {
        return;
        _containerClip.onEnterFrame = function ()
        {
        };
    } // End of the function
    function doLoadListening()
    {
        var _loc3 = _containerClip.getBytesLoaded();
        var _loc2 = _containerClip.getBytesTotal();
        var _loc4 = _loc3 == _loc2 && _loc2 > 4 ? (true) : (false);
        if (_loc4)
        {
            this.stopLoadListening();
        } // end if
    } // End of the function
    function stopLoadListening()
    {
        clearInterval(__loadInterval);
        this.onLoadInit(_containerClip);
    } // End of the function
    function createBackgroundsFromXMLNode(node)
    {
        _backgrounds = [];
        _backgroundProbabilityTotal = 0;
        var _loc8 = node.childNodes;
        for (var _loc6 = _loc8[0]; _loc6 != null; _loc6 = _loc6.nextSibling)
        {
            var _loc5 = _loc6.childNodes;
            var _loc2 = {};
            var _loc7 = _loc5.length;
            for (var _loc4 = 0; _loc4 < _loc7; ++_loc4)
            {
                var _loc3 = _loc5[_loc4];
                switch (_loc3.nodeName)
                {
                    case com.clubpenguin.login.BackgroundManager.XMLNODETYPE_URL:
                    {
                        _loc2.url = String(_loc3.firstChild);
                        break;
                    } 
                    case com.clubpenguin.login.BackgroundManager.XMLNODETYPE_LINK:
                    {
                        _loc2.link = String(_loc3.firstChild);
                        break;
                    } 
                    case com.clubpenguin.login.BackgroundManager.XMLNODETYPE_PROBABILITY:
                    {
                        _loc2.probability = Number(String(_loc3.firstChild));
                        break;
                    } 
                    case com.clubpenguin.login.BackgroundManager.XMLNODETYPE_NOLINK:
                    {
                        ++_noLinkLength;
                        break;
                    } 
                    default:
                    {
                        _shell.$e("[BackgroundManager] createBackgroundsFromXMLNode: An unrecognised XML tag \"" + _loc3.nodeName + "\" was encountered.");
                    } 
                } // End of switch
            } // end of for
            if (isNaN(_loc2.probability) || _loc2.probability < 0)
            {
                _loc2.probability = 1;
                _shell.$e("[BackgroundManager] createBackgroundsFromXMLNode: background with url \"" + _loc2.url + "\" did not have a probability specified. Defaulting to 1.");
            } // end if
            if (_loc2.url.length > 0)
            {
                _backgrounds.push(_loc2);
                _backgroundProbabilityTotal = _backgroundProbabilityTotal + _loc2.probability;
                _loc2.cumulativeFrequency = _backgroundProbabilityTotal;
            } // end if
        } // end of for
        if (_backgrounds.length > 0)
        {
            this.load();
        }
        else
        {
            _shell.loginLoadComplete();
        } // end else if
    } // End of the function
    function handleBackgroundRelease()
    {
        this.getURL(_randomBackground.link, "_parent");
    } // End of the function
    function set parameters(params)
    {
        _params = params;
        //return (this.parameters());
        null;
    } // End of the function
    static var LINKAGE_ID = "BackgroundManagerSymbol";
    static var ROOT_NODE = "backgrounds";
    static var XMLNODETYPE_URL = "url";
    static var XMLNODETYPE_LINK = "link";
    static var XMLNODETYPE_PROBABILITY = "probability";
    static var XMLNODETYPE_NOLINK = "nolink";
    static var PROP_INTERVAL = 10;
    var _noLinkLength = 0;
    var __loadInterval = null;
} // End of Class
