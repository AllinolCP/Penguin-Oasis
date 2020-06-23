class com.clubpenguin.stamps.stampbook.views.InsidePagesView extends com.clubpenguin.stamps.stampbook.views.BaseView
{
    var _shell, _contentsTitle, _navigation, contentView, subContentView, stampsView, pinsView, close_btn, start_btn, next_btn, prev_btn, bitmapLines, totalStamps1, totalStamps2, pageNumberOf, book_holder_mc, backgroundLoader, getNextHighestDepth, attachMovie, _currentView, dispatchEvent, _stampLookUp, _pageList, _model, _tabButtonList, tabBtnsHolder, load_mc;
    function InsidePagesView()
    {
        super();
        _contentsTitle = _shell.getLocalizedString("contents_category_title");
    } // End of the function
    function cleanUp()
    {
        _navigation.reset();
        contentView.cleanUp();
        subContentView.cleanUp();
        stampsView.cleanUp();
        pinsView.cleanUp();
        close_btn.removeEventListener("press", onCloseStampBook, this);
        start_btn.removeEventListener("press", onStartInsidePage, this);
        next_btn.removeEventListener("press", onNextInsidePage, this);
        prev_btn.removeEventListener("press", onPreviousInsidePage, this);
        contentView.removeEventListener("itemClick", onContentItemClick, this);
        subContentView.removeEventListener("itemClick", onContentItemClick, this);
    } // End of the function
    function showUI()
    {
        bitmapLines._visible = true;
        totalStamps1._visible = true;
        totalStamps2._visible = true;
        pageNumberOf._visible = true;
    } // End of the function
    function hideUI()
    {
        bitmapLines._visible = false;
        totalStamps1._visible = false;
        totalStamps2._visible = false;
        pageNumberOf._visible = false;
    } // End of the function
    function configUI()
    {
        start_btn = book_holder_mc.book_holder_mc.book_items_mc.book_mc.close_btn;
        backgroundLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        backgroundLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        contentView = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView(this.attachMovie("InsidePagesContentView", "insidePagesContentView", this.getNextHighestDepth()));
        subContentView = com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView(this.attachMovie("InsidePagesSubContentView", "insidePagesSubContentView", this.getNextHighestDepth()));
        stampsView = com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView(this.attachMovie("InsidePagesStampsView", "insidePagesStampsView", this.getNextHighestDepth()));
        pinsView = com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView(this.attachMovie("InsidePagesPinsView", "insidePagesPinsView", this.getNextHighestDepth()));
        pinsView._visible = stampsView._visible = subContentView._visible = contentView._visible = false;
        super.configUI();
    } // End of the function
    function onContentItemClick(event)
    {
        _navigation.addSection(event.index);
    } // End of the function
    function onLoadInit(event)
    {
        var _loc1 = event.target;
        _loc1._alpha = 100;
    } // End of the function
    function onStartInsidePage(event)
    {
        if (_navigation.__get__title() == _contentsTitle)
        {
            start_btn.gotoAndStop(1);
            _currentView._visible = false;
            this.dispatchEvent({type: "close"});
            return;
        } // end if
        _navigation.reset();
    } // End of the function
    function onNextInsidePage(event)
    {
        _navigation.next();
    } // End of the function
    function onPreviousInsidePage(event)
    {
        if (_navigation.__get__title() == _contentsTitle)
        {
            prev_btn.gotoAndStop(1);
            _currentView._visible = false;
            this.dispatchEvent({type: "close"});
            return;
        } // end if
        _navigation.previous();
    } // End of the function
    function onCloseStampBook(event)
    {
        this.dispatchEvent({type: "closeStampBook"});
    } // End of the function
    function populateUI()
    {
        _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
        _pageList = _stampLookUp.getPageList();
        if (!_navigation)
        {
            _navigation = new com.clubpenguin.stamps.stampbook.util.Navigation(_model);
            _navigation.addEventListener("change", onNagivationChange, this);
        } // end if
        if (!_tabButtonList)
        {
            _tabButtonList = [];
            var _loc5 = Array(_navigation.currentSection)[0];
            var _loc6 = _loc5.length;
            for (var _loc2 = 0; _loc2 < _loc6; ++_loc2)
            {
                var _loc4 = _loc5[_loc2];
                if (_loc4.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID)
                {
                    continue;
                } // end if
                var _loc3 = com.clubpenguin.stamps.stampbook.controls.IconTabButton(tabBtnsHolder.attachMovie("IconTabButton", "iconTabButton" + _loc2, tabBtnsHolder.getNextHighestDepth()));
                _loc3.addEventListener("press", onIconTabButtonPressed, this);
                _loc3._x = 0;
                _loc3._y = (_loc3._height + com.clubpenguin.stamps.stampbook.views.InsidePagesView.TAB_BUTTONS_PADDING) * _loc2;
                _loc3.__set__data(_loc5[_loc2]);
                _loc3.indexNumber = _loc2;
                _tabButtonList.push(_loc3);
            } // end of for
        } // end if
        close_btn.addEventListener("press", onCloseStampBook, this);
        start_btn.addEventListener("press", onStartInsidePage, this);
        next_btn.addEventListener("press", onNextInsidePage, this);
        prev_btn.addEventListener("press", onPreviousInsidePage, this);
        contentView.addEventListener("itemClick", onContentItemClick, this);
        subContentView.addEventListener("itemClick", onContentItemClick, this);
        this.loadContent();
    } // End of the function
    function onIconTabButtonPressed(event)
    {
        var _loc2 = com.clubpenguin.stamps.stampbook.controls.IconTabButton(event.target);
        _navigation.goToSection(_loc2.indexNumber);
    } // End of the function
    function onNagivationChange(event)
    {
        this.loadContent();
    } // End of the function
    function loadContent()
    {
        var _loc23;
        var _loc9;
        var _loc11;
        var _loc12;
        var _loc10;
        var _loc19;
        var _loc15;
        var _loc17;
        var _loc18;
        var _loc22 = _shell.getPath("stampbook_insidePagesBackground");
        var _loc14;
        _currentView._visible = false;
        _currentView.reset();
        load_mc._alpha = 0;
        var _loc7 = _navigation.currentSection;
        var _loc4 = _loc7.getID();
        var _loc16;
        var _loc8 = _tabButtonList.length;
        for (var _loc2 = 0; _loc2 < _loc8; ++_loc2)
        {
            var _loc3 = com.clubpenguin.stamps.stampbook.controls.IconTabButton(_tabButtonList[_loc2]);
            var _loc6 = _loc3.__get__data();
            var _loc5 = _loc6.getID();
            _loc3.__set__selected(_loc4 != undefined && _loc5 == _loc4 ? (true) : (false));
            _loc3.__set__enabled(_loc4 != undefined && _loc5 == _loc4 ? (false) : (true));
        } // end of for
        if (_navigation.__get__title() == _contentsTitle)
        {
            this.showUI();
            start_btn.__set__label(_shell.getLocalizedString("cover"));
            _loc11 = _stampLookUp.getNumberOfUserStampsForCategory(_model);
            _loc12 = _stampLookUp.getNumberOfTotalStampsForCategory(_model);
            _loc10 = _shell.getLocalizedString("numerator_over_denominator");
            _loc9 = _shell.replace_m(_loc10, [_loc11, _loc12]);
            totalStamps1.text = _shell.getLocalizedString("total_stamps_label");
            totalStamps2.text = _loc9;
            _loc19 = 1;
            _loc15 = _pageList.length;
            _loc17 = _shell.getLocalizedString("page_number");
            _loc18 = _shell.replace_m(_loc17, [_loc19, _loc15]);
            pageNumberOf.text = _loc18;
            _loc14 = 0;
            _currentView = contentView;
            _currentView.setModel(_model);
            _currentView._visible = true;
        }
        else if (_navigation.__get__title() == com.clubpenguin.stamps.StampManager.MYSTERY_PAGE_TITLE)
        {
            this.hideUI();
            start_btn.__set__label(_contentsTitle);
            _loc14 = com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID;
        }
        else
        {
            this.showUI();
            start_btn.__set__label(_contentsTitle);
            var _loc21 = _loc7.getItems();
            var _loc20 = _loc7.getSubCategories();
            if (_loc20 != undefined && _loc20.length > 0)
            {
                _loc11 = _stampLookUp.getNumberOfUserStampsForCategory(_loc7);
                _loc12 = _stampLookUp.getNumberOfTotalStampsForCategory(_loc7);
                _loc10 = _shell.getLocalizedString("numerator_over_denominator");
                _loc16 = _shell.getLocalizedString("category_stamps_label");
                totalStamps1.text = com.clubpenguin.util.StringUtils.replaceString("%name%", _loc7.getName(), _loc16);
                _loc9 = _shell.replace_m(_loc10, [_loc11, _loc12]);
                _currentView = subContentView;
            }
            else
            {
                switch (_loc4)
                {
                    case com.clubpenguin.stamps.StampManager.PIN_CATEGORY_ID:
                    {
                        totalStamps1.text = _shell.getLocalizedString("users_pins_label");
                        _loc9 = String(_loc21 != undefined ? (_loc21.length) : (0));
                        _currentView = pinsView;
                        break;
                    } 
                    default:
                    {
                        _loc11 = _stampLookUp.getNumberOfUserStampsForCategory(_loc7);
                        _loc12 = _stampLookUp.getNumberOfTotalStampsForCategory(_loc7);
                        _loc10 = _shell.replace_m(_shell.getLocalizedString("numerator_over_denominator"), [_loc11, _loc12]);
                        _loc16 = _shell.getLocalizedString("category_label");
                        totalStamps1.text = com.clubpenguin.util.StringUtils.replaceString("%name%", _loc7.getName(), _loc16);
                        _loc9 = _loc10;
                        _currentView = stampsView;
                    } 
                } // End of switch
            } // end else if
            _loc14 = _loc7.getID() != undefined ? (_loc7.getID()) : (1);
            _loc19 = this.getPageIndex(_loc7) + 2;
            _loc15 = _pageList.length;
            _loc17 = _shell.getLocalizedString("page_number");
            _loc18 = _shell.replace_m(_loc17, [_loc19, _loc15]);
            pageNumberOf.text = _loc18;
            totalStamps2.text = _loc9;
            _currentView.setModel(_loc7);
            _currentView._visible = true;
        } // end else if
        var _loc13 = book_holder_mc.book_holder_mc.book_items_mc.book_mc.paper_mc.background;
        if (_loc13.load_mc)
        {
            _loc13.load_mc.removeMovieClip();
        } // end if
        _loc13.createEmptyMovieClip("load_mc", 1);
        backgroundLoader.loadClip(_loc22 + _loc14 + ".swf", _loc13.load_mc);
    } // End of the function
    function getPageIndex(page)
    {
        var _loc3 = _pageList.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (_pageList[_loc2] == page)
            {
                return (_loc2);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesView;
    static var LINKAGE_ID = "InsidePagesView";
    static var BLANK_CLIP_LINKAGE_ID = "Blank";
    static var TAB_BUTTONS_PADDING = 2;
} // End of Class
