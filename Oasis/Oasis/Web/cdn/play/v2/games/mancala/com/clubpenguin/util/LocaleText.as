class com.clubpenguin.util.LocaleText
{
    static var eventSource, locale, localeDataMC, dataArray, localeDirectoryURL;
    function LocaleText()
    {
    } // End of the function
    static function init($parent, $languageID, $movieLocation, $versionNumber, $useLoader)
    {
        com.clubpenguin.util.LocaleText.debugTrace("initialise locale text");
        ready = false;
        if (com.clubpenguin.util.LocaleText.eventSource == undefined)
        {
            eventSource = new Object();
            mx.events.EventDispatcher.initialize(com.clubpenguin.util.LocaleText.eventSource);
        } // end if
        if ($useLoader == undefined)
        {
            $useLoader = false;
        } // end if
        if ($languageID == undefined)
        {
            $languageID = com.clubpenguin.util.LocaleText.getLocaleID();
        } // end if
        localeID = $languageID;
        var _loc1 = com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.localeID);
        locale = com.clubpenguin.util.LocaleText.getLocale(com.clubpenguin.util.LocaleText.localeID);
        if ($versionNumber == undefined)
        {
            if (com.clubpenguin.util.LocaleText.localeVersion == undefined)
            {
                _loc1 = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1 + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
            }
            else
            {
                _loc1 = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1 + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.util.LocaleText.localeVersion + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
            } // end else if
        }
        else
        {
            _loc1 = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1 + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + $versionNumber + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
        } // end else if
        localeDataMC = $parent.createEmptyMovieClip("localeDataMC", $parent.getNextHighestDepth());
        var _loc2 = new Object();
        var _loc3 = new MovieClipLoader();
        if ($languageID == com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR)
        {
            _loc2.onLoadError = function ($targetMC, $errorMessage)
            {
                com.clubpenguin.util.LocaleText.debugTrace("load error: " + $errorMessage, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
            };
        }
        else
        {
            _loc2.onLoadError = function ($targetMC)
            {
                com.clubpenguin.util.LocaleText.init($targetMC, com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR);
            };
        } // end else if
        if ($movieLocation != undefined)
        {
            _loc1 = $movieLocation + _loc1;
        } // end if
        if ($useLoader)
        {
            _loc2.onLoadProgress = function ($targetMC, $loadProgress, $loadTotal)
            {
                com.clubpenguin.util.Loader.handleLoadProgress($targetMC, $loadProgress, $loadTotal);
            };
            _loc2.onLoadInit = function ($targetMC)
            {
                com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
                com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
            };
            com.clubpenguin.util.LocaleText.debugTrace("load filename " + _loc1 + " using Loader class");
            _loc3.addListener(_loc2);
            _loc3.loadClip(_loc1, com.clubpenguin.util.LocaleText.localeDataMC);
            com.clubpenguin.util.Loader.addProgressObject(_loc3.getProgress(com.clubpenguin.util.LocaleText.localeDataMC));
        }
        else
        {
            _loc2.onLoadInit = function ($targetMC)
            {
                com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
            };
            com.clubpenguin.util.LocaleText.debugTrace("load filename " + _loc1 + " standalone");
            _loc3.addListener(_loc2);
            _loc3.loadClip(_loc1, com.clubpenguin.util.LocaleText.localeDataMC);
        } // end else if
    } // End of the function
    static function handleLoadComplete($data)
    {
        com.clubpenguin.util.LocaleText.debugTrace("locale text loaded OK!");
        dataArray = new Array();
        for (var _loc2 in $data.localeText)
        {
            com.clubpenguin.util.LocaleText.dataArray[$data.localeText[_loc2].id] = $data.localeText[_loc2].value;
            com.clubpenguin.util.LocaleText.debugTrace("dataArray[" + $data.localeText[_loc2].id + "] = " + $data.localeText[_loc2].value);
        } // end of for...in
        var _loc3 = new Object();
        _loc3.target = com.clubpenguin.util.LocaleText;
        _loc3.type = com.clubpenguin.util.LocaleText.EVENT_LOAD_COMPLETED;
        ready = true;
        com.clubpenguin.util.LocaleText.eventSource.dispatchEvent(_loc3);
        com.clubpenguin.util.LocaleText.debugTrace("dispatched LOAD_COMPLETED event");
    } // End of the function
    static function addEventListener($listener)
    {
        if (com.clubpenguin.util.LocaleText.eventSource == undefined)
        {
            eventSource = new Object();
            mx.events.EventDispatcher.initialize(com.clubpenguin.util.LocaleText.eventSource);
        } // end if
        com.clubpenguin.util.LocaleText.eventSource.addEventListener(com.clubpenguin.util.LocaleText.EVENT_LOAD_COMPLETED, $listener);
    } // End of the function
    static function removeEventListener($listener)
    {
        com.clubpenguin.util.LocaleText.eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED, $listener);
    } // End of the function
    static function getText($stringID)
    {
        if (!com.clubpenguin.util.LocaleText.ready)
        {
            com.clubpenguin.util.LocaleText.debugTrace("getText called when not ready", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return ("[id:" + $stringID + " not ready]");
        }
        else if (com.clubpenguin.util.LocaleText.dataArray[$stringID] == undefined)
        {
            com.clubpenguin.util.LocaleText.debugTrace("load error for string: " + $stringID, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            return ("[id:" + $stringID + " undefined]");
        } // end else if
        return (com.clubpenguin.util.LocaleText.dataArray[$stringID]);
    } // End of the function
    static function getTextReplaced($stringID, $replacements)
    {
        var _loc2 = com.clubpenguin.util.LocaleText.getText($stringID);
        var _loc3 = $replacements.length;
        for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
        {
            _loc2 = _loc2.split("%" + _loc1).join($replacements[_loc1]);
        } // end of for
        return (_loc2);
    } // End of the function
    static function getLocale($localeID)
    {
        switch ($localeID)
        {
            case com.clubpenguin.util.LocaleText.LANG_ID_EN:
            {
                return (com.clubpenguin.util.LocaleText.LANG_LOC_EN);
            } 
            case com.clubpenguin.util.LocaleText.LANG_ID_PT:
            {
                return (com.clubpenguin.util.LocaleText.LANG_LOC_PT);
            } 
            case com.clubpenguin.util.LocaleText.LANG_ID_FR:
            {
                return (com.clubpenguin.util.LocaleText.LANG_LOC_FR);
            } 
            case com.clubpenguin.util.LocaleText.LANG_ID_ES:
            {
                return (com.clubpenguin.util.LocaleText.LANG_LOC_ES);
            } 
            case com.clubpenguin.util.LocaleText.LANG_ID_DE:
            {
                return (com.clubpenguin.util.LocaleText.LANG_LOC_DE);
            } 
            case com.clubpenguin.util.LocaleText.LANG_ID_IT:
            {
                return (com.clubpenguin.util.LocaleText.LANG_LOC_IT);
            } 
            case com.clubpenguin.util.LocaleText.LANG_ID_ZH:
            {
                return (com.clubpenguin.util.LocaleText.LANG_LOC_ZH);
            } 
            case com.clubpenguin.util.LocaleText.LANG_ID_JA:
            {
                return (com.clubpenguin.util.LocaleText.LANG_LOC_JA);
            } 
            case com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR:
            {
                com.clubpenguin.util.LocaleText.debugTrace("load error occurred! reload using default language", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
                return (com.clubpenguin.util.LocaleText.LANG_LOC_EN);
            } 
        } // End of switch
        com.clubpenguin.util.LocaleText.debugTrace("unknown language id: " + $localeID + ", using default language instead", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        return (com.clubpenguin.util.LocaleText.LANG_LOC_EN);
        return (com.clubpenguin.util.LocaleText.LANG_LOC_EN);
    } // End of the function
    static function setLocaleVersion($localeVersion)
    {
        localeVersion = $localeVersion;
    } // End of the function
    static function setLocaleID($localeID)
    {
        localeID = $localeID;
    } // End of the function
    static function getLocaleID()
    {
        return (com.clubpenguin.util.LocaleText.localeID);
    } // End of the function
    static function isReady()
    {
        return (com.clubpenguin.util.LocaleText.ready);
    } // End of the function
    static function attachLocaleClip($stringID, $target)
    {
        var _loc1 = com.clubpenguin.util.LocaleText.localeDataMC.attachMovie($stringID, $stringID + "_mc", com.clubpenguin.util.LocaleText.localeDataMC.getNextHighestDepth());
        var _loc2 = new flash.display.BitmapData(_loc1._width, _loc1._height, true, 0);
        _loc2.draw(_loc1, new flash.geom.Matrix(), new flash.geom.ColorTransform(), "normal");
        $target.attachBitmap(_loc2, $target.getNextHighestDepth());
        _loc1.removeMovieClip();
    } // End of the function
    static function getGameDirectory($url)
    {
        if ($url == undefined)
        {
            if (com.clubpenguin.util.LocaleText.localeDirectoryURL == undefined)
            {
                com.clubpenguin.util.LocaleText.debugTrace("using cached locale directory url that hasn\'t been set yet!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            } // end if
            return (com.clubpenguin.util.LocaleText.localeDirectoryURL);
        } // end if
        var _loc2 = $url.split("/");
        var _loc3 = "";
        for (var _loc1 = 0; _loc1 < _loc2.length - 1; ++_loc1)
        {
            _loc3 = _loc3 + (_loc2[_loc1] + "/");
        } // end of for
        localeDirectoryURL = _loc3;
        return (com.clubpenguin.util.LocaleText.localeDirectoryURL);
    } // End of the function
    static function debugTrace($message, $priority)
    {
        if ($priority == undefined)
        {
            $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG_LOCALE)
        {
            com.clubpenguin.util.Reporting.debugTrace("(LocaleText) " + $message, $priority);
        } // end if
    } // End of the function
    static var EVENT_LOAD_COMPLETED = "onLoadComplete";
    static var LANG_ID_DEFAULT = com.clubpenguin.util.LocaleText.LANG_ID_EN;
    static var LANG_ID_LOADERROR = 0;
    static var LANG_ID_EN = 1;
    static var LANG_ID_PT = 2;
    static var LANG_ID_FR = 3;
    static var LANG_ID_ES = 4;
    static var LANG_ID_DE = 5;
    static var LANG_ID_IT = 6;
    static var LANG_ID_ZH = 8;
    static var LANG_ID_JA = 9;
    static var LANG_LOC_FILENAME = "locale";
    static var LANG_LOC_FILETYPE = ".swf";
    static var LANG_LOC_DIRECTORY = "lang";
    static var LANG_LOC_EN = "en";
    static var LANG_LOC_PT = "pt";
    static var LANG_LOC_FR = "fr";
    static var LANG_LOC_ES = "es";
    static var LANG_LOC_DE = "de";
    static var LANG_LOC_IT = "it";
    static var LANG_LOC_ZH = "zh";
    static var LANG_LOC_JA = "ja";
    static var localeVersion = undefined;
    static var localeID = 0;
    static var ready = false;
} // End of Class
