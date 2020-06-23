class com.clubpenguin.stamps.stampbook.controls.IconTabButton extends com.clubpenguin.stamps.stampbook.controls.BaseButton
{
    var _shell, _filePath, stampIconLoader, stampIconHolder, stampIconLoadMc, _initialized, _data, __get__data, _enabled, _toggle, _selected, gotoAndStop, dispatchEvent, useHandCursor, __get__enabled, __get__selected, __set__data, __set__enabled, __set__selected;
    static var ICON_SCALE_OUT, ICON_SCALE_OVER;
    function IconTabButton()
    {
        super();
        _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
    } // End of the function
    function configUI()
    {
        _filePath = _shell.getPath("stampbook_category");
        stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        stampIconLoadMc = stampIconHolder.createEmptyMovieClip("stampIconLoadMc", stampIconHolder.getNextHighestDepth());
        _initialized = true;
        if (_data != null)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function get data()
    {
        return (_data);
    } // End of the function
    function set data(value)
    {
        _data = value;
        if (_initialized)
        {
            this.populateUI();
        } // end if
        null;
        //return (this.data());
        null;
    } // End of the function
    function onLoadInit(event)
    {
        var _loc2 = event.target;
        _loc2._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_ART_SCALE;
        _loc2._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_ART_SCALE;
        ICON_SCALE_OUT = stampIconLoadMc._xscale + com.clubpenguin.stamps.stampbook.controls.IconTabButton._SCALE_OFFSET + (stampIconLoadMc._yscale + com.clubpenguin.stamps.stampbook.controls.IconTabButton._SCALE_OFFSET) >> 1;
        ICON_SCALE_OVER = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT + com.clubpenguin.stamps.stampbook.controls.IconTabButton._SCALE_OFFSET * 1.500000;
        stampIconLoadMc._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
        stampIconLoadMc._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
    } // End of the function
    function populateUI()
    {
        stampIconLoader.loadClip(_filePath + _data.getID() + ".swf", stampIconLoadMc);
    } // End of the function
    function onPress()
    {
        if (!_enabled)
        {
            return;
        } // end if
        this.gotoAndStop(_toggle ? (!_selected ? ("down") : ("selected_down")) : ("down"));
        this.dispatchEvent({type: "press", data: _data});
    } // End of the function
    function onRollOver()
    {
        if (!_enabled)
        {
            return;
        } // end if
        stampIconLoadMc._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OVER;
        stampIconLoadMc._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OVER;
        this.gotoAndStop(_toggle ? (!_selected ? ("over") : ("selected_over")) : ("over"));
        this.dispatchEvent({type: "over"});
    } // End of the function
    function onRollOut()
    {
        if (!_enabled)
        {
            return;
        } // end if
        stampIconLoadMc._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
        stampIconLoadMc._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
        this.gotoAndStop(_toggle ? (!_selected ? ("up") : ("selected_up")) : ("up"));
        this.dispatchEvent({type: "out"});
    } // End of the function
    function set enabled(value)
    {
        _enabled = value;
        useHandCursor = value;
        this.gotoAndStop(_selected ? ("selected_up") : ("up"));
        null;
        //return (this.enabled());
        null;
    } // End of the function
    function set selected(value)
    {
        _selected = value;
        stampIconLoadMc._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
        stampIconLoadMc._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
        this.gotoAndStop(_selected ? ("selected_up") : ("up"));
        null;
        //return (this.selected());
        null;
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.IconTabButton;
    static var LINKAGE_ID = "IconTabButton";
    static var ICON_ART_SCALE = 65;
    static var ICON_WIDTH = 21;
    static var ICON_HEIGHT = 21;
    static var _SCALE_OFFSET = 10;
} // End of Class
