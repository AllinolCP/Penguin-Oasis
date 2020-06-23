﻿class com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedList extends com.clubpenguin.stamps.stampbook.controls.List
{
    var bg, _gridHolder, _rendererWidth, _rendererHeight, _padding, scrollBar, dispatchEvent;
    function RecentlyEarnedList()
    {
        super();
    } // End of the function
    function drawGrid()
    {
        super.drawGrid();
        this.onListInitiated();
    } // End of the function
    function onListInitiated()
    {
        bg._x = 0;
        bg._y = 0;
        _gridHolder._x = _rendererWidth / 2 - 27;
        _gridHolder._y = _rendererHeight / 2 - 22;
        bg._width = _gridHolder._width + _rendererWidth + _padding;
        bg._height = _gridHolder._height + _rendererHeight + _padding;
        scrollBar.setSize(bg._width + _padding * 8, _scrollBarWidth);
        scrollBar._x = bg._width - scrollBar._width >> 1;
        scrollBar._y = bg._height - scrollBar._height >> 1;
        var _loc2 = Math.abs(scrollBar._x);
        scrollBar._x = scrollBar._x + _loc2;
        bg._x = bg._x + _loc2;
        _gridHolder._x = _gridHolder._x + _loc2;
        this.dispatchEvent({type: "loadInit"});
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedList;
    static var LINKAGE_ID = "RecentlyEarnedList";
    static var GRID_COLUMNS = 3;
    static var GRID_ROWS = 2;
    var _scrollBarWidth = 30;
    var _scrollBarPadding = 5;
} // End of Class
