class com.clubpenguin.login.OverlayManager extends MovieClip
{
    var _loader, _modal, createEmptyMovieClip, _containerClip, _contentURL, _loadingAnimClip, __get__contentURL, __set__contentURL;
    function OverlayManager()
    {
        super();
        _loader = new MovieClipLoader();
        _loader.addListener(this);
        _modal.useHandCursor = false;
        _modal.onPress = undefined;
        _modal._visible = false;
        this.hideLoadingAnimation();
    } // End of the function
    function load()
    {
        this.showModal();
        this.showLoadingAnimation();
        _containerClip = this.createEmptyMovieClip("_containerClip", 0);
        var _loc3 = com.clubpenguin.util.URLUtils.getCacheResetURL(_contentURL);
        var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onLoadInit));
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, mx.utils.Delegate.create(this, onLoadError));
        _loc2.loadClip(_loc3, _containerClip);
    } // End of the function
    function onLoadInit(event)
    {
        this.hideLoadingAnimation();
    } // End of the function
    function onLoadError(event)
    {
        this.hideModal();
    } // End of the function
    function close()
    {
        this.hideModal();
        _containerClip.removeMovieClip();
    } // End of the function
    function showModal()
    {
        _modal._visible = true;
        com.clubpenguin.util.Tools.disableAutoTabbing();
    } // End of the function
    function hideModal()
    {
        _modal._visible = false;
        this.hideLoadingAnimation();
        com.clubpenguin.util.Tools.enableAutoTabbing();
    } // End of the function
    function showLoadingAnimation()
    {
        _loadingAnimClip._visible = true;
        _loadingAnimClip.gotoAndPlay("play");
    } // End of the function
    function hideLoadingAnimation()
    {
        _loadingAnimClip._visible = false;
        _loadingAnimClip.gotoAndStop("park");
    } // End of the function
    function set contentURL(url)
    {
        _contentURL = url;
        //return (this.contentURL());
        null;
    } // End of the function
    static var LINKAGE_ID = "OverlayManagerSymbol";
} // End of Class
