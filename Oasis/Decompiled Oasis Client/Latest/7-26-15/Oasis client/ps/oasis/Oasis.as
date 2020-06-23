class ps.oasis.Oasis
{
    function Oasis()
    {
        _global._oasis = this;
        if (_root._url.substr(0, 5) == "https")
        {
            $httpType = "https";
        } // end if
        System.security.allowDomain("*");
        System.security.allowDomain("*.oasis.ps");
        System.security.allowDomain("*.oasis.private");
        ps.oasis.OasisLogger.info("Oasis starting...");
        var _loc4 = new LoadVars();
        ps.oasis.OasisLogger.debug("var configurationFetcher:LoadVars = " + _loc4);
        _loc4.onLoad = function (success)
        {
            if (!success)
            {
                ps.oasis.OasisLogger.error("Failed to load configuration");
                return (this.DisplayLoadError());
            } // end if
        };
        _loc4.onData = function (configurationData)
        {
            if (configurationData == "" || configurationData == undefined)
            {
                return (this.DisplayLoadError());
            } // end if
            try
            {
                var _loc3 = ps.oasis.JSON.parse(configurationData);
            } // End of try
            catch (ex)
            {
                trace (ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
                return (this.DisplayLoadError());
            } // End of catch
            ps.oasis.OasisLogger.success("Configuration loaded...clientver=" + _loc3.client.revision);
            _global._configuration = _loc3;
            _global.GetConfiguration = function ()
            {
                return (_global._configuration);
            };
            _global._oasis.LoadLatestTuning();
        };
        _loc4.load($httpType + "://app.oasis.ps/service/config?newDate=" + new Date().getTime());
        ps.oasis.OasisLogger.debug("Loading from OCloud app service module...");
    } // End of the function
    function LoadLatestTuning()
    {
        var _loc3 = new LoadVars();
        ps.oasis.OasisLogger.debug("var tuningFetcher:LoadVars = " + _loc3);
        _loc3.onLoad = function (success)
        {
            if (!success)
            {
                ps.oasis.OasisLogger.error("Failed to load configuration");
                return (this.DisplayLoadError());
            } // end if
        };
        _loc3.onData = function (tuningData)
        {
            if (tuningData == "" || tuningData == undefined)
            {
                return (this.DisplayLoadError());
            } // end if
            try
            {
                var _loc3 = ps.oasis.JSON.parse(tuningData);
            } // End of try
            catch (ex)
            {
                trace (ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
                return (this.DisplayLoadError());
            } // End of catch
            ps.oasis.OasisLogger.success("Tuning loaded...tuning.shell=" + _loc3.shell);
            _global._configuration.tuning = _loc3;
            ps.oasis.OasisLogger.debug("InitiateClubPenguin...now: " + _global._oasis.InitiateClubPenguin);
            _global._oasis.InitiateClubPenguin();
        };
        _loc3.load($httpType + "://app.oasis.ps/service/tuning?newDate=" + new Date().getTime());
    } // End of the function
    function InitiateClubPenguin()
    {
        var _loc13 = _global.GetConfiguration();
        ps.oasis.OasisLogger.debug("config...oasisConf: " + _loc13);
        ps.oasis.OasisLogger.debug("config...oasisConf.client.language: " + _loc13.client.language);
        ps.oasis.OasisLogger.debug("config...oasisConf.client.media: " + _loc13.client.media);
        ps.oasis.OasisLogger.debug("config...oasisConf.client.media.directories.cdn_base: " + _loc13.client.media.directories.cdn_base);
        ps.oasis.OasisLogger.debug("Loading Club Penguin: " + $httpType + _loc13.client.media.directories.cdn_base + _loc13.client.media.directories.client + "load.swf");
        loadMovieNum($httpType + _loc13.client.media.directories.cdn_base + _loc13.client.media.directories.client + "load.swf", 1);
        _root.onEnterFrame = function ()
        {
            for (var _loc13 in _level1)
            {
                if (typeof(_level1[_loc13]) == "movieclip")
                {
                    var _loc3 = new Object();
                    _loc3 = {type: "setEnvironmentData", data: {clientPath: _global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + _global.GetConfiguration().client.media.directories.client, contentPath: _global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + _global.GetConfiguration().client.media.directories.content, gamesPath: _global._oasis.$httpType + _global.GetConfiguration().client.media.directories.cdn_base + _global.GetConfiguration().client.media.directories.games, connectionID: "oasis" + random(10000), lanugage: _global.GetConfiguration().client.language, basePath: "", affiliateID: "0"}};
                    _loc3.data.language = _global.GetConfiguration().client.language;
                    ps.oasis.OasisLogger.debug("as3Message.data.language..." + _loc3.data.language);
                    ps.oasis.OasisLogger.debug("_global.GetConfiguration().client.language..." + _global.GetConfiguration().client.language);
                    _level1.bootLoader.messageFromAS3(_loc3);
                    _root.onEnterFrame = function ()
                    {
                        if (_level1.shellContainer.DEPENDENCIES_FILENAME)
                        {
                            _level1.bootLoader.messageFromAS3({type: "showLogin"});
                        } // end if
                        _root.onEnterFrame = undefined;
                        delete _root.onEnterFrame;
                    };
                } // end if
            } // end of for...in
        };
    } // End of the function
    function DisplayLoadError()
    {
        ps.oasis.OasisLogger.error("***DisplayLoadError***");
        flash.external.ExternalInterface.call("OasisPs.DisplayError", 0);
    } // End of the function
    var $httpType = "http";
} // End of Class
