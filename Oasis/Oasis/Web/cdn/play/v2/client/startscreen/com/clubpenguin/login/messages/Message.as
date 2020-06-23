class com.clubpenguin.login.messages.Message extends com.clubpenguin.util.EventDispatcher
{
    var _id, _title, _iconURL, _contentURL, _contentType, _loader, _iconClip, updateListeners, _container, __get__id, __get__container, __set__container, __get__contentType, __get__contentURL, __get__iconClip, __get__loaded, __get__title;
    function Message(id, title, iconURL, contentURL, contentType)
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
        _id = id;
        _title = title;
        _iconURL = iconURL;
        _contentURL = contentURL;
        _contentType = contentType;
        _loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
    } // End of the function
    function load()
    {
        if (_loaded)
        {
            this.onLoadInit();
            return;
        } // end if
        var _loc2 = com.clubpenguin.util.URLUtils.getCacheResetURL(_iconURL);
        _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
        _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_UNLOAD, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        _loader.loadClip(_loc2, _iconClip);
    } // End of the function
    function showIcon()
    {
        _iconClip._visible = true;
    } // End of the function
    function hideIcon()
    {
        _iconClip._visible = false;
    } // End of the function
    function onLoadInit()
    {
        _loaded = true;
        _iconClip._visible = false;
        _iconClip.onPress = com.clubpenguin.util.Delegate.create(this, handleIconPress);
        this.updateListeners(com.clubpenguin.login.messages.Message.LOAD_COMPLETE, {target: this});
    } // End of the function
    function onLoadError()
    {
        _iconClip._visible = false;
        this.updateListeners(com.clubpenguin.login.messages.Message.LOAD_COMPLETE, {target: this});
    } // End of the function
    function handleIconPress()
    {
        this.updateListeners(com.clubpenguin.login.messages.Message.ICON_PRESS, {target: this});
    } // End of the function
    function set container(container)
    {
        _container = container;
        _iconClip = _container.createEmptyMovieClip("iconClip" + this.__get__id(), _container.getNextHighestDepth());
        //return (this.container());
        null;
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function get iconClip()
    {
        return (_iconClip);
    } // End of the function
    function get title()
    {
        return (_title);
    } // End of the function
    function get contentURL()
    {
        return (_contentURL);
    } // End of the function
    function get contentType()
    {
        return (_contentType);
    } // End of the function
    function get loaded()
    {
        return (_loaded);
    } // End of the function
    static var LOAD_COMPLETE = "loadComplete";
    static var ICON_PRESS = "iconPress";
    static var TYPE_URL = "url";
    static var TYPE_POPUP = "popup";
    var _loaded = false;
} // End of Class
