class com.clubpenguin.stamps.stampbook.controls.List extends MovieClip
{
    var _dataProvider, __get__dataProvider, _x, _y, _listWidth, _listHeight, _itemRendererLinkage, _rendererWidth, _rendererHeight, _padding, _useHandCursor, _selectedIndex, _shell, getNextHighestDepth, createEmptyMovieClip, _gridHolder, scrollBar, _rendererPaddedWidth, _rendererPaddedHeight, _numberOfColumns, _totalRenderersPerPage, _height, dispatchEvent, _itemRendererList, __set__dataProvider;
    function List()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
    } // End of the function
    function onLoad()
    {
        this.configUI();
    } // End of the function
    function get dataProvider()
    {
        return (_dataProvider);
    } // End of the function
    function set dataProvider(value)
    {
        _dataProvider = value;
        this.loadContent();
        null;
        //return (this.dataProvider());
        null;
    } // End of the function
    function move(x, y)
    {
        _x = x;
        _y = y;
    } // End of the function
    function init(w, h, renderer, rendererW, rendererH, padding, useHandCursor)
    {
        _listWidth = w;
        _listHeight = h;
        _itemRendererLinkage = renderer;
        _rendererWidth = rendererW;
        _rendererHeight = rendererH;
        _padding = padding;
        _useHandCursor = useHandCursor != undefined ? (useHandCursor) : (true);
        if (_initialized)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function reset()
    {
        _selectedIndex = 0;
    } // End of the function
    function configUI()
    {
        if (_dataProvider == null)
        {
            _dataProvider = [];
        } // end if
        _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
        _gridHolder = this.createEmptyMovieClip("gridHolder", this.getNextHighestDepth());
        scrollBar.addEventListener("down", onNextPage, this);
        scrollBar.addEventListener("up", onPreviousPage, this);
        _initialized = true;
        if (_itemRendererLinkage != undefined)
        {
            this.populateUI();
        } // end if
    } // End of the function
    function onPreviousPage(event)
    {
        --_selectedIndex;
        this.loadContent();
    } // End of the function
    function onNextPage(event)
    {
        ++_selectedIndex;
        this.loadContent();
    } // End of the function
    function populateUI()
    {
        this.drawGrid();
    } // End of the function
    function drawGrid()
    {
        _rendererPaddedWidth = _rendererWidth + _padding;
        _rendererPaddedHeight = _rendererHeight + _padding;
        _numberOfColumns = Math.floor(_listWidth / _rendererPaddedWidth);
        var _loc2 = Math.floor(_listHeight / _rendererPaddedHeight);
        _selectedIndex = 0;
        _totalRenderersPerPage = _numberOfColumns * _loc2;
        if (_dataProvider.length > 0)
        {
            this.loadContent();
        } // end if
        this.onListInitiated();
    } // End of the function
    function onListInitiated()
    {
        scrollBar.setSize(_scrollBarWidth, _height);
        scrollBar._x = _gridHolder._x + _gridHolder._width + _rendererWidth;
        scrollBar._y = 0;
        this.dispatchEvent({type: "loadInit"});
    } // End of the function
    function onItemRollOver(event)
    {
        this.dispatchEvent(event);
    } // End of the function
    function onItemRollOut(event)
    {
        this.dispatchEvent(event);
    } // End of the function
    function loadContent()
    {
        if (!_initialized)
        {
            return;
        } // end if
        var _loc7 = _selectedIndex + 1;
        var _loc8 = Math.ceil(_dataProvider.length / _totalRenderersPerPage);
        scrollBar.downBtn.__set__enabled(_loc7 < _loc8);
        scrollBar.downBtn._visible = _loc7 < _loc8;
        scrollBar.upBtn.__set__enabled(_loc7 > 1);
        scrollBar.upBtn._visible = _loc7 > 1;
        scrollBar._visible = _dataProvider.length > _totalRenderersPerPage;
        var _loc5 = _dataProvider.slice(_selectedIndex * _totalRenderersPerPage, _selectedIndex * _totalRenderersPerPage + _totalRenderersPerPage);
        if (_itemRendererList != undefined)
        {
            var _loc6 = _itemRendererList.length;
            for (var _loc3 = 0; _loc3 < _loc6; ++_loc3)
            {
                _itemRendererList[_loc3].removeEventListener("over", onItemRollOver, this);
                _itemRendererList[_loc3].removeEventListener("out", onItemRollOut, this);
            } // end of for
        } // end if
        _itemRendererList = [];
        for (var _loc3 = 0; _loc3 < _totalRenderersPerPage; ++_loc3)
        {
            var _loc2 = _gridHolder["itemRenderer" + _loc3];
            if (_loc2)
            {
                _loc2.removeMovieClip();
            } // end if
            _loc2 = _gridHolder.attachMovie(_itemRendererLinkage, "itemRenderer" + _loc3, _gridHolder.getNextHighestDepth());
            _loc2.useHandCursor = _useHandCursor;
            _loc2.addEventListener("over", onItemRollOver, this);
            _loc2.addEventListener("out", onItemRollOut, this);
            _loc2.move(_loc3 % _numberOfColumns * _rendererPaddedWidth + _rendererWidth / 2, Math.floor(_loc3 / _numberOfColumns) * _rendererPaddedHeight + _rendererHeight / 2);
            var _loc4 = _loc5[_loc3];
            if (_loc4.getID() == undefined && _loc4.id == undefined)
            {
                _loc2._visible = false;
                continue;
            } // end if
            _loc2._visible = true;
            _loc2.setModel(_loc4);
            _itemRendererList.push(_loc2);
        } // end of for
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.List;
    static var LINKAGE_ID = "List";
    var _initialized = false;
    var _scrollBarWidth = 30;
    var _scrollBarPadding = 5;
} // End of Class
