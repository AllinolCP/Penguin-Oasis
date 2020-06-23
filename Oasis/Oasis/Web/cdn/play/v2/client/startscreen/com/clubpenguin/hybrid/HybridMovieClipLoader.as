class com.clubpenguin.hybrid.HybridMovieClipLoader extends mx.events.EventDispatcher
{
    var _movieClipLoader, _movieClipLoaderListener, _url, _container, _startTime, _loadProgressCheckInterval, _timeElapsed, dispatchEvent, _latencyDelegate, _latencyInterval;
    function HybridMovieClipLoader()
    {
        super();
        _movieClipLoader = new MovieClipLoader();
        _movieClipLoaderListener = new Object();
        _movieClipLoaderListener.onLoadStart = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadStart);
        _movieClipLoaderListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadComplete);
        _movieClipLoaderListener.onLoadError = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadError);
        _movieClipLoaderListener.onLoadProgress = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadProgress);
        _movieClipLoaderListener.onLoadInit = com.clubpenguin.util.Delegate.create(this, onMovieClipLoadInit);
        var _loc3 = _movieClipLoader.addListener(_movieClipLoaderListener);
    } // End of the function
    function loadClip(url, container)
    {
        _url = url;
        _container = container;
        _startTime = getTimer();
        com.clubpenguin.hybrid.AS3Manager.isRunningUnderAS2;
        _movieClipLoader.loadClip(_url, _container);
        clearInterval(_loadProgressCheckInterval);
        _loadProgressCheckInterval = setInterval(this, "checkLoadProgress", com.clubpenguin.hybrid.HybridMovieClipLoader.INTERVAL_RATE);
    } // End of the function
    function checkLoadProgress()
    {
        _timeElapsed = getTimer() - _startTime;
        if (_container.getBytesTotal() <= 0)
        {
            ++_noByteDataTimeout;
            if (_noByteDataTimeout >= com.clubpenguin.hybrid.HybridMovieClipLoader.NO_BYTES_ITERATION)
            {
                this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: "ERROR: file not found " + _url});
                clearInterval(_loadProgressCheckInterval);
                return;
            } // end if
        } // end if
        if (_container.getBytesLoaded() == undefined)
        {
            clearInterval(_loadProgressCheckInterval);
            return;
        } // end if
        if (_container.getBytesTotal() < 0 && _timeElapsed >= com.clubpenguin.hybrid.HybridMovieClipLoader.TIME_OUT_THRESHOLD)
        {
            clearInterval(_loadProgressCheckInterval);
            this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: "ERROR: HybridMovieClipLoader timed out loading " + _url});
            return;
        } // end if
        if (_container.getBytesLoaded() == _container.getBytesTotal() && _container.getBytesTotal() > com.clubpenguin.hybrid.HybridMovieClipLoader.MIN_BYTES)
        {
            clearInterval(_loadProgressCheckInterval);
            this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE});
            _latencyDelegate = com.clubpenguin.util.Delegate.create(this, onAS2MovieClipReady);
            _container.onEnterFrame = _latencyDelegate;
        }
        else
        {
            this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, bytesLoaded: _container.getBytesLoaded(), bytesTotal: _container.getBytesTotal()});
        } // end else if
    } // End of the function
    function onAS2MovieClipUnload()
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_UNLOAD});
    } // End of the function
    function onAS2MovieClipReady()
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        _timeElapsed = getTimer() - _startTime;
        delete _container.onEnterFrame;
        _latencyDelegate = null;
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT});
    } // End of the function
    function onMovieClipLoadStart()
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START});
    } // End of the function
    function onMovieClipLoadComplete()
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE});
    } // End of the function
    function onMovieClipLoadInit(target)
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        _movieClipLoader.removeListener(_movieClipLoaderListener);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT});
    } // End of the function
    function onMovieClipLoadProgress(target, bytesLoaded, bytesTotal)
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, bytesLoaded: bytesLoaded, bytesTotal: bytesTotal});
    } // End of the function
    function onMovieClipLoadError(target, errorCode, httpStatus)
    {
        clearInterval(_latencyInterval);
        clearInterval(_loadProgressCheckInterval);
        this.dispatchEvent({target: _container, type: com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, errorCode: errorCode, httpStatus: httpStatus});
    } // End of the function
    static var EVENT_ON_LOAD_START = "onLoadStart";
    static var EVENT_ON_LOAD_ERROR = "onLoadError";
    static var EVENT_ON_LOAD_COMPLETE = "onLoadComplete";
    static var EVENT_ON_LOAD_INIT = "onLoadInit";
    static var EVENT_ON_LOAD_PROGRESS = "onLoadProgress";
    static var EVENT_ON_UNLOAD = "onUnload";
    static var INTERVAL_RATE = 40;
    static var TIME_OUT_THRESHOLD = 2000;
    static var MIN_BYTES = 4;
    static var NO_BYTES_ITERATION = 10;
    var _noByteDataTimeout = 0;
} // End of Class
