class com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
    var _renderers, _dividers, rollOverBg, placeHolder, bg, _data, mask, dispatchEvent;
    function CategorySelectorMenu()
    {
        super();
    } // End of the function
    function configUI()
    {
        _renderers = [];
        _dividers = [];
        super.configUI();
    } // End of the function
    function cleanUI()
    {
        var _loc5 = _renderers.length > _dividers.length ? (_renderers.length) : (_dividers.length);
        for (var _loc3 = 0; _loc3 < _loc5; ++_loc3)
        {
            var _loc4 = MovieClip(_renderers.pop());
            if (_loc4)
            {
                _loc4.removeMovieClip();
            } // end if
            var _loc2 = MovieClip(_dividers.pop());
            if (_loc2)
            {
                _loc2.removeMovieClip();
            } // end if
        } // end of for
    } // End of the function
    function populateUI()
    {
        this.cleanUI();
        _maxWidth = 0;
        rollOverBg._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
        rollOverBg._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
        placeHolder._visible = false;
        bg._visible = false;
        var _loc8 = _data.length;
        var _loc3;
        var _loc2;
        for (var _loc4 = 0; _loc4 < _loc8; ++_loc4)
        {
            var _loc5 = _data[_loc4];
            if (_loc5.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID)
            {
                continue;
            } // end if
            if (includeBlankTopSpace)
            {
                _loc3 = placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.DIVIDER_RENDERER, com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.DIVIDER_RENDERER + "-1", placeHolder.getNextHighestDepth());
                _loc3._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT;
                _dividers.push(_loc3);
            } // end if
            _loc2 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer(placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.ITEM_RENDERER, com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.ITEM_RENDERER + _loc4, placeHolder.getNextHighestDepth()));
            _loc2.addEventListener("onRollOver", onItemRollOver, this);
            _loc2.addEventListener("onRollOut", onItemRollOut, this);
            _loc2.addEventListener("onPress", onItemPress, this);
            _loc2.__set__data(_data[_loc4]);
            var _loc6 = includeBlankTopSpace ? (_loc4 + 1) : (_loc4);
            _loc2._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT * _loc6;
            _loc2._x = 0;
            _renderers.push(_loc2);
            _maxWidth = _loc2._width > _maxWidth ? (_loc2._width) : (_maxWidth);
            if (!includeAllCategoriesButton && _loc4 == _loc8 - 1)
            {
                continue;
            } // end if
            _loc3 = placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.DIVIDER_RENDERER, com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.DIVIDER_RENDERER + _loc4, placeHolder.getNextHighestDepth());
            _loc3._y = _loc2._y + com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT;
            _dividers.push(_loc3);
        } // end of for
        if (includeAllCategoriesButton)
        {
            var _loc11 = _loc8 - 1;
            _loc2 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer(placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.ITEM_RENDERER, com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.ITEM_RENDERER + _loc11, placeHolder.getNextHighestDepth()));
            _loc2.addEventListener("onRollOver", onItemRollOver, this);
            _loc2.addEventListener("onRollOut", onItemRollOut, this);
            _loc2.addEventListener("onPress", onItemPress, this);
            _loc2.__set__data(_data);
            var _loc14 = includeBlankTopSpace ? (_loc11 + 1) : (_loc11);
            _loc2._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT * _loc14;
            _loc2._x = 0;
            _renderers.push(_loc2);
            _maxWidth = _loc2._width > _maxWidth ? (_loc2._width) : (_maxWidth);
        } // end if
        var _loc7 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING * 2;
        var _loc12 = _dividers.length;
        var _loc10 = _renderers.length;
        var _loc9 = _loc10 > _loc12 ? (_loc10) : (_loc12);
        for (var _loc4 = 0; _loc4 < _loc9; ++_loc4)
        {
            _loc2 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer(_renderers[_loc4]);
            if (_loc2)
            {
                _loc2.setWidth(_maxWidth);
            } // end if
            _loc3 = MovieClip(_dividers[_loc4]);
            if (_loc3)
            {
                _loc3._width = _maxWidth - _loc7;
                _loc3._x = _loc7;
            } // end if
        } // end of for
        rollOverBg._width = _maxWidth + _loc7;
        rollOverBg._height = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT;
        var _loc13 = includeBlankTopSpace ? (com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT * (_loc10 + 1)) : (com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT * _loc10);
        bg._width = _maxWidth + _loc7;
        bg._height = _loc13 + _loc7;
        bg._visible = true;
        mask._width = _maxWidth;
        mask._height = _loc13;
        mask._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
        mask._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
        placeHolder._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
        placeHolder._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
        placeHolder._visible = true;
    } // End of the function
    function onItemRollOver(event)
    {
        var _loc2 = MovieClip(event.target);
        _loc2.swapDepths(placeHolder.getNextHighestDepth());
        rollOverBg._y = _loc2._y + com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
        rollOverBg._x = 0;
        var _loc4 = event.data;
        var _loc3 = _loc4.getSubCategories();
        this.dispatchEvent({type: "showMenu", data: _loc3, currentTarget: _loc2});
    } // End of the function
    function onItemRollOut(event)
    {
        rollOverBg._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
        rollOverBg._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
    } // End of the function
    function onItemPress(event)
    {
        var _loc3 = MovieClip(event.target);
        var _loc2 = event.data;
        var _loc5 = _loc2.getSubCategories();
        rollOverBg._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
        rollOverBg._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
        this.dispatchEvent({type: "onItemPress", data: _loc2, currentTarget: _loc3});
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu;
    static var LINKAGE_ID = "CategorySelectorMenu";
    static var OFF_STAGE_POSITION = -1000;
    static var DIVIDER_RENDERER = "CategorySelectorDivider";
    static var ITEM_RENDERER = "CategorySelectorRenderer";
    static var RENDERER_HEIGHT = 25;
    static var PADDING = 1;
    static var DIVIDER_HEIGHT = 1;
    var _maxWidth = 0;
    var includeBlankTopSpace = false;
    var includeAllCategoriesButton = false;
} // End of Class
