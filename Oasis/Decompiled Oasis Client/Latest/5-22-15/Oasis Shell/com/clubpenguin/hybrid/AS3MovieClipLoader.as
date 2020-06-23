class com.clubpenguin.hybrid.AS3MovieClipLoader
{
    function AS3MovieClipLoader(host, load_clip, path, init_function, start_function, progress_function, error_function, options)
    {
        __host = host;
        __loadClip = load_clip;
        __path = path;
        __options = options;
        __useIterations = __options.useIterations != undefined ? (__options.useIterations) : (false);
        __skipLoadChecking = __options.skipLoadChecking != undefined ? (__options.skipLoadChecking) : (false);
        __initFunction = init_function;
        __startFunction = start_function != undefined ? (start_function) : (null);
        __progressFunction = progress_function != undefined ? (progress_function) : (null);
        __errorFunction = error_function != undefined ? (error_function) : (null);
        this.init();
    } // End of the function
    function init()
    {
        __trace = com.clubpenguin.hybrid.TraceOutput.getInstance();
        __iterations = 0;
        __instance = this;
        __loadClip.unloadMovie();
        __loadClip.loadMovie(__path);
        if (!__skipLoadChecking)
        {
            __loadInterval = setInterval(__instance, "checkLoadProgress", com.clubpenguin.hybrid.AS3MovieClipLoader.INTERVAL_RATE);
        } // end if
        if (__startFunction != null)
        {
            this.__startFunction(__loadClip);
        } // end if
    } // End of the function
    function checkLoadProgress()
    {
        ++__iterations;
        var _loc3 = __loadClip.getBytesLoaded();
        var _loc2 = __loadClip.getBytesTotal();
        var _loc4 = false;
        if (__useIterations)
        {
            _loc4 = _loc3 == _loc2 && (_loc2 > com.clubpenguin.hybrid.AS3MovieClipLoader.MIN_BYTES || __iterations > com.clubpenguin.hybrid.AS3MovieClipLoader.MIN_ITERATIONS) ? (true) : (false);
        }
        else
        {
            _loc4 = _loc3 == _loc2 && _loc2 > 4 ? (true) : (false);
        } // end else if
        if (__progressFunction != null)
        {
            this.__progressFunction(__loadClip, _loc3, _loc2);
        } // end if
        if (_loc4)
        {
            this.stopLoadListening();
        } // end if
        if (!__useIterations && __iterations >= com.clubpenguin.hybrid.AS3MovieClipLoader.TIME_OUT_THRESHOLD)
        {
            clearInterval(__loadInterval);
            var _loc5 = "Could not load: " + __path;
            if (__errorFunction != null)
            {
                this.__errorFunction(__loadClip);
            } // end if
            throw new Error("Time out error, AS3MovieClipLodaer exceeded its iteration limit checking for: " + __path);
        } // end if
    } // End of the function
    function stopLoadListening()
    {
        clearInterval(__loadInterval);
        this.__initFunction(__loadClip);
    } // End of the function
    static var INTERVAL_RATE = 10;
    static var TIME_OUT_THRESHOLD = 200;
    static var MIN_ITERATIONS = 20;
    static var MIN_BYTES = 4;
    static var AS3_ERROR = "AS3_error";
    var __instance = null;
    var __loadInterval = null;
    var __initFunction = null;
    var __loadClip = null;
    var __path = null;
    var __host = null;
    var __iterations = null;
    var __trace = null;
    var __options = null;
    var __useIterations = null;
    var __skipLoadChecking = null;
    var __startFunction = null;
    var __progressFunction = null;
    var __errorFunction = null;
} // End of Class
