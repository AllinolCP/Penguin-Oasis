class com.clubpenguin.stamps.stampbook.controls.ToolBar extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
    var _shell, _coverCrumbs, _changingCategory, _stampLookUp, _masterList, categorySelectorBtn, colourTool, highlightTool, patternTool, iconTool, selectionMenu, colourLabel, highlightLabel, patternLabel, iconLabel, specificCategoryBG, specificCategoryArrow, _data, dispatchEvent, _editing, categorySelectorTier1, categoryMenuHolder, categorySelectorTier2, _currentBtnPressed, __get__changingCategory;
    function ToolBar()
    {
        super();
        _coverCrumbs = _shell.getStampManager().stampBookCoverCrumbs;
    } // End of the function
    function get changingCategory()
    {
        return (_changingCategory);
    } // End of the function
    function closeCategorySelector()
    {
        this.hideCategorySelector();
    } // End of the function
    function configUI()
    {
        _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
        _masterList = _stampLookUp.getMasterList();
        categorySelectorBtn.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.TOP_LEVEL + 1);
        categorySelectorBtn.addEventListener("press", onCategorySelectorPress, this);
        colourTool.addEventListener("press", onToolItemPressed, this);
        highlightTool.addEventListener("press", onToolItemPressed, this);
        patternTool.addEventListener("press", onToolItemPressed, this);
        iconTool.addEventListener("press", onToolItemPressed, this);
        selectionMenu.addEventListener("onItemClick", onSelectionChange, this);
        selectionMenu.addEventListener("close", onSelectionMenuClose, this);
        super.configUI();
    } // End of the function
    function populateUI()
    {
        colourLabel.text = _shell.getLocalizedString("colour");
        highlightLabel.text = _shell.getLocalizedString("highlight");
        patternLabel.text = _shell.getLocalizedString("pattern");
        iconLabel.text = _shell.getLocalizedString("icon");
        _stampLookUp.setCategorySelected(com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID);
        specificCategoryBG._visible = false;
        specificCategoryArrow._visible = false;
        categorySelectorBtn.setModel(_data);
        var _loc2 = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
        _loc2.setColourIndex(_data.getColourID());
        _loc2.setHighlightIndex(_data.getHighlightID());
        _loc2.setPatternIndex(_data.getPatternID());
        _loc2.setIconIndex(_data.getClaspIconArtID());
        colourTool.setModel(_data.getColourID());
        highlightTool.setModel(_data.getHighlightID());
        patternTool.setModel(_data.getPatternID());
        iconTool.setModel(_data.getClaspIconArtID());
    } // End of the function
    function onSelectionMenuClose(event)
    {
        this.hideSelectionMenu();
    } // End of the function
    function onSelectionChange(event)
    {
        var _loc3 = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
        var _loc2 = event.data;
        switch (event.dataType)
        {
            case com.clubpenguin.stamps.stampbook.controls.ToolBar.COLOUR:
            {
                _loc3.setColourIndex(_loc2);
                var _loc6 = _coverCrumbs.getHighlightByColourID(_loc2);
                var _loc4 = _loc6[0];
                _loc3.setHighlightIndex(_loc4);
                highlightTool.setModel(_loc4);
                break;
            } 
            case com.clubpenguin.stamps.stampbook.controls.ToolBar.HIGHLIGHT:
            {
                _loc3.setHighlightIndex(_loc2);
                highlightTool.setModel(_loc2);
                break;
            } 
            case com.clubpenguin.stamps.stampbook.controls.ToolBar.PATTERN:
            {
                _loc2 = _loc2 == _loc3.getPatternIndex() ? (undefined) : (_loc2);
                _loc3.setPatternIndex(_loc2);
                patternTool.setModel(_loc2);
                break;
            } 
            case com.clubpenguin.stamps.stampbook.controls.ToolBar.ICON:
            {
                _loc3.setIconIndex(_loc2);
                iconTool.setModel(_loc2);
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
        this.hideSelectionMenu();
        this.dispatchEvent({type: "change", data: _loc2, dataType: event.dataType});
    } // End of the function
    function onCategorySelectorPress(event)
    {
        if (_editing)
        {
            this.hideSelectionMenu();
        } // end if
        if (!_changingCategory)
        {
            if (!categorySelectorTier1)
            {
                categorySelectorTier1 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu(categoryMenuHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_LINKAGE, com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_LINKAGE, categoryMenuHolder.getNextHighestDepth(), {includeAllCategoriesButton: true, includeBlankTopSpace: true}));
                categorySelectorTier1.addEventListener("onItemPress", onCategorySelected, this);
                categorySelectorTier1.addEventListener("showMenu", showSubCategories, this);
            } // end if
            categorySelectorTier1.setModel(_masterList);
            categorySelectorTier1._x = com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_TIER1_X;
            categorySelectorTier1._y = com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_TIER1_Y;
            _changingCategory = !_changingCategory;
        }
        else
        {
            this.hideCategorySelector();
        } // end else if
        categoryMenuHolder.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.TOP_LEVEL);
        colourTool.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
        highlightTool.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
        patternTool.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
        iconTool.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
    } // End of the function
    function onCategorySelected(event)
    {
        var _loc2 = event.data;
        var _loc3 = _loc2.getID() ? (_loc2.getID()) : (com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID);
        specificCategoryBG._visible = _loc3 == com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID ? (false) : (true);
        specificCategoryArrow._visible = _loc3 == com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID ? (false) : (true);
        categorySelectorBtn.setModel(_loc2);
        com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance().setCategorySelected(_loc3);
        this.dispatchEvent({type: "filter", data: _loc2});
        this.hideCategorySelector();
    } // End of the function
    function showSubCategories(event)
    {
        var _loc2 = event.data;
        if (_loc2.length <= 0)
        {
            categorySelectorTier2._x = -1000;
            categorySelectorTier2._y = -1000;
            return;
        } // end if
        if (!categorySelectorTier2)
        {
            categorySelectorTier2 = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu(categoryMenuHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_LINKAGE, com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_LINKAGE + 1, categoryMenuHolder.getNextHighestDepth()));
            categorySelectorTier2.addEventListener("onItemPress", onCategorySelected, this);
        } // end if
        var _loc5 = MovieClip(event.target);
        var _loc4 = MovieClip(event.currentTarget);
        categorySelectorTier2.setModel(_loc2);
        categorySelectorTier2._x = categorySelectorTier1._x + categorySelectorTier1._width - com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_OFFSET;
        categorySelectorTier2._y = _loc5._y + _loc4._y;
    } // End of the function
    function onToolItemPressed(event)
    {
        var _loc2 = event.target;
        var _loc3;
        var _loc4;
        selectionMenu.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
        switch (_loc2)
        {
            case colourTool:
            {
                _loc3 = com.clubpenguin.stamps.stampbook.controls.ToolBar.COLOUR;
                _loc4 = _coverCrumbs.colour;
                break;
            } 
            case highlightTool:
            {
                _loc3 = com.clubpenguin.stamps.stampbook.controls.ToolBar.HIGHLIGHT;
                _loc4 = _coverCrumbs.getHighlightByColourID(com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance().getColourIndex());
                break;
            } 
            case patternTool:
            {
                _loc3 = com.clubpenguin.stamps.stampbook.controls.ToolBar.PATTERN;
                _loc4 = _coverCrumbs.pattern;
                break;
            } 
            case iconTool:
            {
                _loc3 = com.clubpenguin.stamps.stampbook.controls.ToolBar.ICON;
                _loc4 = _coverCrumbs.clasp;
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
        if (_changingCategory)
        {
            this.hideCategorySelector();
        } // end if
        if (!_editing)
        {
            selectionMenu._x = com.clubpenguin.stamps.stampbook.controls.ToolBar.SELECTION_MENU_X;
            selectionMenu._y = _loc2._y - com.clubpenguin.stamps.stampbook.controls.ToolBar.TOOLBAR_BTN_HEIGHT / 2;
            selectionMenu.setType(_loc3);
            selectionMenu.setModel(_loc4);
            selectionMenu._visible = true;
            _editing = true;
            _currentBtnPressed = _loc2;
        }
        else if (_editing && _loc2 != _currentBtnPressed)
        {
            selectionMenu._x = com.clubpenguin.stamps.stampbook.controls.ToolBar.SELECTION_MENU_X;
            selectionMenu._y = _loc2._y - com.clubpenguin.stamps.stampbook.controls.ToolBar.TOOLBAR_BTN_HEIGHT / 2;
            selectionMenu.setType(_loc3);
            selectionMenu.setModel(_loc4);
            _currentBtnPressed = _loc2;
        }
        else if (_editing)
        {
            this.hideSelectionMenu();
        } // end else if
        _loc2.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.TOP_LEVEL);
    } // End of the function
    function hideSelectionMenu()
    {
        selectionMenu._visible = false;
        _editing = false;
        _currentBtnPressed = null;
    } // End of the function
    function hideCategorySelector()
    {
        categorySelectorTier1._x = -1000;
        categorySelectorTier1._y = -1000;
        categorySelectorTier2._x = -1000;
        categorySelectorTier2._y = -1000;
        _changingCategory = false;
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ToolBar;
    static var LINKAGE_ID = "ToolBar";
    static var COLOUR = "Colour";
    static var HIGHLIGHT = "Highlight";
    static var PATTERN = "Pattern";
    static var ICON = "Icon";
    static var CATEGORY_SELECTOR_MENU_LINKAGE = "CategorySelectorMenu";
    static var CATEGORY_SELECTOR_MENU_OFFSET = 4;
    static var TOP_LEVEL = 10001;
    static var BOTTOM_LEVEL = 10000;
    static var SELECTION_MENU_X = 61.850000;
    static var TOOLBAR_BTN_HEIGHT = 70;
    static var CATEGORY_SELECTOR_TIER1_X = 36;
    static var CATEGORY_SELECTOR_TIER1_Y = 42;
} // End of Class
