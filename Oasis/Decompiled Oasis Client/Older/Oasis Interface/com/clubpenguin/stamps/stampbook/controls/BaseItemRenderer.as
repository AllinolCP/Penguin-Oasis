class com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer extends MovieClip
{
    var _shell, _data, _initialized, _filePath, _iconHolderClip, _scaleX, _scaleY, _x, _y, loader, loader_mc, attachMovie, enabled, hitArea, dispatchEvent, __get__data;
    function BaseItemRenderer()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
        _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
    } // End of the function
    function onLoad()
    {
        this.configUI();
    } // End of the function
    function get data()
    {
        return (_data);
    } // End of the function
    function setModel(data)
    {
        _data = data;
        if (!_initialized)
        {
            this.configUI();
        } // end if
        _filePath = this.getPath(_data.getType());
        this.load();
    } // End of the function
    function showShadow()
    {
        _iconHolderClip.stamp.shadow._visible = true;
    } // End of the function
    function hideShadow()
    {
        _iconHolderClip.stamp.shadow._visible = false;
    } // End of the function
    function setScale(scaleX, scaleY)
    {
        _scaleX = scaleX;
        _scaleY = scaleY;
    } // End of the function
    function move(x, y)
    {
        _x = x;
        _y = y;
    } // End of the function
    function getPath(type)
    {
        var _loc2;
        switch (type)
        {
            case com.clubpenguin.stamps.StampBookItemType.STAMP:
            {
                _loc2 = _shell.getPath("stampbook_stamps");
                break;
            } 
            case com.clubpenguin.stamps.StampBookItemType.AWARD:
            case com.clubpenguin.stamps.StampBookItemType.PIN:
            {
                _loc2 = _shell.getPath("clothing_icons");
                break;
            } 
        } // End of switch
        return (_loc2);
    } // End of the function
    function configUI()
    {
        loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
        _initialized = true;
    } // End of the function
    function load()
    {
        loader_mc.gotoAndStop("loading");
        if (_data)
        {
            var _loc2 = _data.getID();
            if (_data.getType() == com.clubpenguin.stamps.StampBookItemType.AWARD)
            {
                _loc2 = com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[_data.getID()];
            } // end if
            if (_iconHolderClip)
            {
                _iconHolderClip.removeMovieClip();
            } // end if
            _iconHolderClip = this.attachMovie(com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer.BLANK_CLIP_LINKAGE_ID, "iconHolderClip", 1, {_x: 0, _y: 0});
            _iconHolderClip._xscale = _scaleX;
            _iconHolderClip._yscale = _scaleY;
            loader.loadClip(_filePath + _loc2 + ".swf", _iconHolderClip);
        } // end if
    } // End of the function
    function onLoadInit(event)
    {
        var _loc2 = event.target;
        enabled = true;
        _loc2._parent.loader_mc.gotoAndStop("complete");
        if (_loc2.stamp)
        {
            _loc2.stamp.shadow._alpha = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer.DROPSHADOW_ALPHA;
        } // end if
        if (_loc2.hitArea_mc)
        {
            hitArea = _loc2.hitArea_mc;
            _loc2.hitArea_mc._alpha = 0;
        } // end if
        this.dispatchEvent({type: "loadInit"});
    } // End of the function
    function onLoadError(event)
    {
        var _loc2 = event.target;
        _loc2._parent._parent.loader_mc.gotoAndStop("loading");
        enabled = false;
        this.dispatchEvent({type: "loadError"});
    } // End of the function
    function onMouseMove()
    {
        this.dispatchEvent({type: "mouseMove"});
    } // End of the function
    function onMouseUp()
    {
        this.dispatchEvent({type: "mouseUp"});
    } // End of the function
    function onMouseDown()
    {
        this.dispatchEvent({type: "mouseDown"});
    } // End of the function
    function onPress()
    {
        this.dispatchEvent({type: "press", data: _data});
    } // End of the function
    function onRelease()
    {
        this.dispatchEvent({type: "release"});
    } // End of the function
    function onRollOver()
    {
        this.dispatchEvent({type: "over", data: _data});
    } // End of the function
    function onRollOut()
    {
        this.dispatchEvent({type: "out"});
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer;
    static var LINKAGE_ID = "BaseItemRenderer";
    static var BLANK_CLIP_LINKAGE_ID = "Blank";
    static var DROPSHADOW_ALPHA = 30;
} // End of Class
