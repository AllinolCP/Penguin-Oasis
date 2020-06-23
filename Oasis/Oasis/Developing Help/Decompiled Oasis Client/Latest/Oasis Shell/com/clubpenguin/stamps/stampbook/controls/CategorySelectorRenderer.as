class com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer extends MovieClip
{
    var _shell, _stampLookUp, _data, __get__data, _categoryID, labelField, arrow, bg, stampIconLoader, stampIconHolder, load_mc, _rendererHeight, _rendererWidth, dispatchEvent, __set__data;
    function CategorySelectorRenderer()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
        _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
        _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
    } // End of the function
    function onLoad()
    {
    } // End of the function
    function get data()
    {
        return (_data);
    } // End of the function
    function set data(value)
    {
        _data = value;
        this.setText();
        this.setIcon();
        null;
        //return (this.data());
        null;
    } // End of the function
    function setText(value)
    {
        _categoryID = _data.getID() ? (_data.getID()) : (com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID);
        var _loc2 = _shell.getLocalizedString(_categoryID == com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID ? ("all_stamps_category_title") : (_data.getName()));
        labelField.text = _loc2;
        if (_stampLookUp.isCategorySelected(_categoryID))
        {
            labelField._alpha = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.CATEGORY_SELECTED_ALPHA;
        } // end if
        labelField._width = labelField.textWidth + com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING;
        arrow._x = labelField._x + labelField._width + com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING;
        bg._width = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.STAMP_ICON_WIDTH + labelField._width + arrow._width + com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING * com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING_MULTIPLIER;
        arrow._visible = _data.getSubCategories().length > 0 ? (true) : (false);
    } // End of the function
    function setIcon()
    {
        stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        load_mc = stampIconHolder.createEmptyMovieClip("load_mc", stampIconHolder.getNextHighestDepth());
        var _loc2 = _shell.getPath("stampbook_category");
        stampIconLoader.loadClip(_loc2 + _categoryID + ".swf", load_mc);
    } // End of the function
    function onLoadInit(event)
    {
        load_mc._xscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OUT;
        load_mc._yscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OUT;
    } // End of the function
    function setHeight(h)
    {
        _rendererHeight = h;
        bg._height = _rendererHeight;
    } // End of the function
    function setWidth(w)
    {
        _rendererWidth = w;
        arrow._x = _rendererWidth - com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING - arrow._width;
        bg._width = _rendererWidth;
    } // End of the function
    function onPress()
    {
        this.dispatchEvent({type: "onPress", data: _data});
    } // End of the function
    function onRollOver()
    {
        load_mc._xscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OVER;
        load_mc._yscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OVER;
        this.dispatchEvent({type: "onRollOver", data: _data});
    } // End of the function
    function onRollOut()
    {
        load_mc._xscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OUT;
        load_mc._yscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OUT;
        this.dispatchEvent({type: "onRollOut", data: _data});
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer;
    static var LINKAGE_ID = "CategorySelectorRenderer";
    static var ICON_SCALE_OVER = 105;
    static var ICON_SCALE_OUT = 70;
    static var STAMP_ICON_WIDTH = 22;
    static var PADDING = 5;
    static var PADDING_MULTIPLIER = 4;
    static var CATEGORY_SELECTED_ALPHA = 50;
} // End of Class
