class com.clubpenguin.stamps.stampbook.controls.ContentList extends com.clubpenguin.stamps.stampbook.controls.List
{
    var _listWidth, _rendererWidth, _padding, _listHeight, _rendererHeight, _selectedIndex, _totalRenderersPerPage, _dataProvider, _height, _scrollBarWidth, scrollBar, _gridHolder, _scrollBarPadding, dispatchEvent, _initialized, _itemRendererList, _itemRendererLinkage;
    function ContentList()
    {
        super();
    } // End of the function
    function drawGrid()
    {
        var _loc2 = Math.floor(_listWidth / (_rendererWidth + _padding));
        var _loc3 = Math.floor(_listHeight / (_rendererHeight + _padding));
        _selectedIndex = 0;
        _totalRenderersPerPage = _loc2 * _loc3;
        if (_dataProvider.length > 0)
        {
            this.loadContent();
        } // end if
        this.onListInitiated();
    } // End of the function
    function onListInitiated()
    {
        scrollBar.setSize(_scrollBarWidth, _height);
        scrollBar._x = _gridHolder._x + _gridHolder._width + _scrollBarPadding;
        scrollBar._y = 0;
        this.dispatchEvent({type: "loadInit"});
    } // End of the function
    function onItemClick(event)
    {
        var _loc3 = com.clubpenguin.stamps.stampbook.controls.ListButton(event.target);
        var _loc2 = event.data;
        this.dispatchEvent({type: "itemClick", category: _loc2.getName(), index: _loc3.indexNumber});
    } // End of the function
    function loadContent()
    {
        if (!_initialized)
        {
            return;
        } // end if
        var _loc6 = Math.floor(_listWidth / (_rendererWidth + _padding));
        var _loc10 = Math.floor(_listHeight / (_rendererHeight + _padding));
        var _loc8 = _selectedIndex + 1;
        var _loc9 = Math.ceil(_dataProvider.length / _totalRenderersPerPage);
        scrollBar.downBtn.__set__enabled(_loc8 < _loc9);
        scrollBar.upBtn.__set__enabled(_loc8 > 1);
        scrollBar._visible = _dataProvider.length > _totalRenderersPerPage;
        var _loc5 = _dataProvider.slice(_selectedIndex * _totalRenderersPerPage, _selectedIndex * _totalRenderersPerPage + _totalRenderersPerPage);
        if (_itemRendererList != undefined)
        {
            var _loc7 = _itemRendererList.length;
            for (var _loc2 = 0; _loc2 < _loc7; ++_loc2)
            {
                _itemRendererList[_loc2].removeEventListener("press", onItemClick, this);
            } // end of for
        } // end if
        _itemRendererList = [];
        for (var _loc2 = 0; _loc2 < _totalRenderersPerPage; ++_loc2)
        {
            var _loc4 = _gridHolder["itemRenderer" + _loc2];
            if (_loc4)
            {
                _loc4.removeMovieClip();
            } // end if
            _loc4 = _gridHolder.attachMovie(_itemRendererLinkage, "itemRenderer" + _loc2, _gridHolder.getNextHighestDepth());
            var _loc3 = com.clubpenguin.stamps.stampbook.controls.ListButton(_loc4);
            _loc3.addEventListener("press", onItemClick, this);
            _loc3._x = _loc2 % _loc6 * (_rendererWidth + _padding);
            _loc3._y = Math.floor(_loc2 / _loc6) * (_rendererHeight + _padding);
            if (_loc5[_loc2] == undefined)
            {
                _loc3._visible = false;
                continue;
            } // end if
            _loc3._visible = true;
            _loc3.setModel(_loc5[_loc2]);
            _loc3.indexNumber = _totalRenderersPerPage * _selectedIndex + _loc2;
            _itemRendererList.push(_loc3);
        } // end of for
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ContentList;
    static var LINKAGE_ID = "ContentList";
} // End of Class
