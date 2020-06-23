class com.clubpenguin.stamps.stampbook.views.StampbookCoverView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
    var _shell, _stampManager, _coverCrumbs, _colourPath, _patternPath, _highlightPath, _iconPath, _wordmarkPath, _initialized, __get__toggleEditControls, _closeStampBookFunction, closeClip, __get__closeStampBookFunction, clasp, save_btn, edit_btn, toolBar, coverList, _renderers, colourLoader, patternLoader, highlightClaspLoader, iconLoader, wordmarkLoader, removeDropArea, _dropShadowFilter, stageArea, stageRect, claspRect, dropAreaRect, dispatchEvent, _selectedCategory, _stampLookUp, _model, _masterList, colourLoaderHolder, patternLoaderHolder, highlightClaspLoaderHolder, iconLoaderHolder, wordmarkLoaderHolder, penguinName, penguinStamps, nameRect, stampsHolder, stampRect, _ymouse, _xmouse, _currentID, _currentTarget, _mousexOffset, _mouseyOffset, _lastxPosition, _lastyPosition, rect, _isPlaceableOnCover, _removeStamp, help_btn, editBackground, background, __set__closeStampBookFunction, __set__toggleEditControls;
    function StampbookCoverView()
    {
        super();
        _stampManager = _shell.getStampManager();
        _coverCrumbs = _stampManager.stampBookCoverCrumbs;
        _colourPath = _shell.getPath("stampbook_colour");
        _patternPath = _shell.getPath("stampbook_pattern");
        _highlightPath = _shell.getPath("stampbook_highlight");
        _iconPath = _shell.getPath("stampbook_clasp");
        _wordmarkPath = _shell.getPath("stampbook_wordmark");
    } // End of the function
    function get toggleEditControls()
    {
        return (_toggleEditControls);
    } // End of the function
    function set toggleEditControls(value)
    {
        if (_toggleEditControls == value)
        {
            return;
        } // end if
        _toggleEditControls = value;
        if (_initialized)
        {
            this.toggleEditMode();
        } // end if
        null;
        //return (this.toggleEditControls());
        null;
    } // End of the function
    function set closeStampBookFunction(fcn)
    {
        _closeStampBookFunction = fcn;
        closeClip.onRelease = _closeStampBookFunction;
        null;
        //return (this.closeStampBookFunction());
        null;
    } // End of the function
    function cleanUp()
    {
        clasp.removeEventListener("press", onClaspClicked, this);
        save_btn.removeEventListener("release", onSaveStampbookCover, this);
        edit_btn.removeEventListener("release", onEditStampbookCover, this);
        toolBar.removeEventListener("change", onCoverSettingChange, this);
        toolBar.removeEventListener("filter", onFilterByCategory, this);
        coverList.removeEventListener("itemPress", onItemPressed, this);
        closeClip.removeEventListener("release", _closeStampBookFunction, this);
    } // End of the function
    function configUI()
    {
        _renderers = [];
        colourLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        colourLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
        patternLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        patternLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
        highlightClaspLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        highlightClaspLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
        iconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        iconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
        wordmarkLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        wordmarkLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        wordmarkLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadError));
        removeDropArea.gotoAndStop(_shell.getLanguageAbbreviation());
        _dropShadowFilter = new flash.filters.DropShadowFilter(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_DISTANCE, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_ANGLE, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_COLOR, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_ALPHA, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_BLUR_X, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_BLUR_Y, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_STRENGTH, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_QUALITY);
        stageRect = new flash.geom.Rectangle(stageArea._x + com.clubpenguin.stamps.stampbook.views.StampbookCoverView.PADDING, stageArea._y + com.clubpenguin.stamps.stampbook.views.StampbookCoverView.PADDING, stageArea._width, stageArea._height);
        claspRect = new flash.geom.Rectangle(clasp._x, clasp._y, clasp._width, clasp._height);
        dropAreaRect = new flash.geom.Rectangle(removeDropArea._x, removeDropArea._y, removeDropArea._width, removeDropArea._height);
        coverList._visible = false;
        removeDropArea._visible = false;
        super.configUI();
    } // End of the function
    function onClaspClicked()
    {
        this.dispatchEvent({type: "claspClicked"});
    } // End of the function
    function onFilterByCategory(event)
    {
        _selectedCategory = event.data;
        coverList.reset();
        coverList.dataProvider = _stampLookUp.getStampsForCategory(_selectedCategory);
    } // End of the function
    function attachClipToHolderClip(holderClip)
    {
        if (holderClip.clip)
        {
            holderClip.clip.removeMovieClip();
        } // end if
        holderClip.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x: 0, _y: 0});
    } // End of the function
    function populateUI()
    {
        var _loc7 = _model.getColourID();
        var _loc10 = _model.getPatternID();
        var _loc8 = _model.getHighlightID();
        var _loc11 = _model.getClaspIconArtID();
        var _loc9 = _coverCrumbs.getLogoByColourID(_loc7);
        var _loc12 = _coverCrumbs.getTextHighlightByHighlightID(_loc8);
        _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
        _masterList = _stampLookUp.getMasterList();
        toolBar.setModel(_model);
        _selectedCategory = _masterList;
        coverList.dataProvider = _stampLookUp.getStampsForCategory(_selectedCategory);
        if (_loc7 != undefined && _loc7 != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
        {
            this.attachClipToHolderClip(colourLoaderHolder);
            colourLoader.loadClip(_colourPath + _loc7 + ".swf", colourLoaderHolder.clip);
        } // end if
        if (_loc10 != undefined && _loc10 != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
        {
            this.attachClipToHolderClip(patternLoaderHolder);
            patternLoader.loadClip(_patternPath + _loc10 + ".swf", patternLoaderHolder.clip);
        } // end if
        if (_loc8 != undefined && _loc8 != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
        {
            this.attachClipToHolderClip(highlightClaspLoaderHolder);
            highlightClaspLoader.loadClip(_highlightPath + _loc8 + ".swf", highlightClaspLoaderHolder.clip);
        } // end if
        if (_loc11 != undefined && _loc11 != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
        {
            this.attachClipToHolderClip(iconLoaderHolder);
            iconLoader.loadClip(_iconPath + _loc11 + ".swf", iconLoaderHolder.clip);
        } // end if
        if (_loc9 != undefined && _loc9 != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
        {
            this.attachClipToHolderClip(wordmarkLoaderHolder);
            wordmarkLoader.loadClip(_wordmarkPath + _loc9 + ".swf", wordmarkLoaderHolder.clip);
        } // end if
        penguinName.__set__colorValue(_loc12);
        penguinName.__set__label(_stampLookUp.getPlayerNickname());
        penguinStamps._x = penguinName._x + penguinName._width;
        penguinStamps._x = penguinName._y + penguinName._height - com.clubpenguin.stamps.stampbook.views.StampbookCoverView.PADDING;
        penguinStamps.__set__colorValue(_loc12);
        var _loc13 = _shell.getLocalizedString("total_stamps");
        penguinStamps.__set__label(_shell.replace_m(_loc13, [_stampLookUp.getNumberOfUserStamps(), _stampLookUp.getNumberOfTotalStampsForCategory(_masterList)]));
        nameRect = new flash.geom.Rectangle(penguinName._x, penguinName._y, penguinName._width, penguinName._height);
        var _loc5 = _model.getCoverItems();
        var _loc6 = _loc5.length;
        for (var _loc4 = 0; _loc4 < _loc6; ++_loc4)
        {
            var _loc3 = _loc5[_loc4];
            var _loc2 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(stampsHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ITEM_RENDERER, "coverRenderer" + _loc4, _loc3.getItemDepth()));
            _loc2.addEventListener("loadInit", onStampLoaded, this);
            _loc2.addEventListener("press", onStampPressed, this);
            _loc2.setScale(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.STAMP_BOOK_ITEM_ART_SCALE, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.STAMP_BOOK_ITEM_ART_SCALE);
            _loc2.move(_loc3.getItemPosition().x, _loc3.getItemPosition().y);
            _loc2._rotation = _loc3.getItemRotation();
            _loc2.setModel(_loc3.getItem());
            _loc2.hitArea_mc._visible = false;
            _renderers.push(_loc2);
        } // end of for
        clasp.addEventListener("press", onClaspClicked, this);
        save_btn.addEventListener("release", onSaveStampbookCover, this);
        edit_btn.addEventListener("release", onEditStampbookCover, this);
        toolBar.addEventListener("change", onCoverSettingChange, this);
        toolBar.addEventListener("filter", onFilterByCategory, this);
        coverList.addEventListener("itemPress", onItemPressed, this);
        this.toggleEditMode();
    } // End of the function
    function onLoadError(event)
    {
    } // End of the function
    function onLoadInit(event)
    {
        var _loc3 = event.target;
        if (_loc3 == wordmarkLoaderHolder)
        {
            if (!stampRect)
            {
                var _loc2 = _loc3._parent;
                stampRect = new flash.geom.Rectangle(_loc2._x - (_loc2._width >> 1), _loc2._y - (_loc2._height >> 1), _loc2._width, _loc2._height);
            } // end if
        } // end if
    } // End of the function
    function onItemPressed(event)
    {
        if (toolBar.__get__changingCategory())
        {
            toolBar.closeCategorySelector();
            return;
        } // end if
        var _loc4 = _renderers.length;
        if (_loc4 >= com.clubpenguin.stamps.StampManager.MAX_STAMPBOOK_COVER_ITEMS)
        {
            _shell.$e("[stampbookCoverView] onItemPressed() You cant have more than " + com.clubpenguin.stamps.StampManager.MAX_STAMPBOOK_COVER_ITEMS + " items on your cover! ", {error_code: _shell.MAX_STAMPBOOK_COVER_ITEMS});
            return;
        } // end if
        var _loc3 = com.clubpenguin.stamps.IStampBookItem(event.data);
        var _loc2 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(stampsHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ITEM_RENDERER, "coverRendererNew" + new Date().getTime(), stampsHolder.getNextHighestDepth()));
        _loc2.setScale(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.STAMP_BOOK_ITEM_ART_SCALE, com.clubpenguin.stamps.stampbook.views.StampbookCoverView.STAMP_BOOK_ITEM_ART_SCALE);
        _loc2.move(_xmouse, _ymouse);
        _loc2.setModel(_loc3);
        _renderers.push(_loc2);
        _stampLookUp.addStampToCover(_loc3.getID());
        coverList.dataProvider = _stampLookUp.getStampsForCategory(_selectedCategory);
        var _loc5 = {type: "press", data: _loc3, target: _loc2, newStamp: true};
        this.onStampPressed(_loc5);
    } // End of the function
    function onCoverSettingChange(event)
    {
        var _loc3;
        var _loc2 = event.data;
        switch (event.dataType)
        {
            case com.clubpenguin.stamps.stampbook.controls.ToolBar.COLOUR:
            {
                this.attachClipToHolderClip(colourLoaderHolder);
                colourLoader.loadClip(_colourPath + _loc2 + ".swf", colourLoaderHolder.clip);
                var _loc4 = _coverCrumbs.getHighlightByColourID(_loc2);
                _loc3 = _coverCrumbs.getTextHighlightByHighlightID(_loc4[0]);
                penguinName.__set__colorValue(_loc3);
                penguinStamps.__set__colorValue(_loc3);
                this.attachClipToHolderClip(highlightClaspLoaderHolder);
                highlightClaspLoader.loadClip(_highlightPath + _loc4[0] + ".swf", highlightClaspLoaderHolder.clip);
                var _loc5 = _coverCrumbs.getLogoByColourID(_loc2);
                this.attachClipToHolderClip(wordmarkLoaderHolder);
                wordmarkLoader.loadClip(_wordmarkPath + _loc5 + ".swf", wordmarkLoaderHolder.clip);
                break;
            } 
            case com.clubpenguin.stamps.stampbook.controls.ToolBar.HIGHLIGHT:
            {
                _loc3 = _coverCrumbs.getTextHighlightByHighlightID(_loc2);
                penguinName.__set__colorValue(_loc3);
                penguinStamps.__set__colorValue(_loc3);
                this.attachClipToHolderClip(highlightClaspLoaderHolder);
                highlightClaspLoader.loadClip(_highlightPath + _loc2 + ".swf", highlightClaspLoaderHolder.clip);
                break;
            } 
            case com.clubpenguin.stamps.stampbook.controls.ToolBar.PATTERN:
            {
                if (_loc2 == undefined)
                {
                    patternLoaderHolder._visible = false;
                    break;
                } // end if
                this.attachClipToHolderClip(patternLoaderHolder);
                patternLoader.loadClip(_patternPath + _loc2 + ".swf", patternLoaderHolder.clip);
                patternLoaderHolder._visible = true;
                break;
            } 
            case com.clubpenguin.stamps.stampbook.controls.ToolBar.ICON:
            {
                this.attachClipToHolderClip(iconLoaderHolder);
                iconLoader.loadClip(_iconPath + _loc2 + ".swf", iconLoaderHolder.clip);
                break;
            } 
        } // End of switch
    } // End of the function
    function onStampLoaded(event)
    {
        var _loc3 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(event.target);
        var _loc2 = new flash.geom.Rectangle(_loc3._x - _loc3._width / 2, _loc3._y - _loc3._height / 2, _loc3._width, _loc3._height);
        var _loc4 = !this.intersects(_loc3, _loc2);
        if (!_loc4)
        {
            _loc3.move(Math.min(Math.max(_loc2.x + _loc2.width / 2, stageRect.x + _loc2.width / 2), stageRect.width - _loc2.width), Math.min(Math.max(_loc2.y + _loc2.height / 2, stageRect.y + _loc2.height / 2), stageRect.height - _loc2.height));
        } // end if
    } // End of the function
    function onStampPressed(event)
    {
        if (toolBar.__get__changingCategory())
        {
            toolBar.closeCategorySelector();
            return;
        } // end if
        var _loc3 = com.clubpenguin.stamps.IStampBookItem(event.data);
        _currentID = _loc3.getID();
        _currentTarget = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(event.target);
        _currentTarget.hideShadow();
        _currentTarget.swapDepths(stampsHolder.getNextHighestDepth());
        _currentTarget.removeEventListener("press", onStampPressed, this);
        _currentTarget.filters = [_dropShadowFilter];
        _mousexOffset = Math.round(_xmouse - _currentTarget._x);
        _mouseyOffset = Math.round(_ymouse - _currentTarget._y);
        _lastxPosition = Math.round(_currentTarget._x);
        _lastyPosition = Math.round(_currentTarget._y);
        if (event.newStamp)
        {
            _lastxPosition = Math.round(_currentTarget._x);
            _lastyPosition = Math.round(stageRect.y + (_currentTarget._height >> 1));
        } // end if
        Key.addListener(this);
        removeDropArea._visible = true;
        _currentTarget.addEventListener("mouseMove", handleDrag, this);
        _currentTarget.addEventListener("mouseUp", handleClick, this);
        _currentTarget.hitArea_mc._visible = true;
    } // End of the function
    function intersects(sourceMc, sourceRect)
    {
        var _loc8 = !stageRect.containsRectangle(sourceRect) || clasp.hitTest(sourceMc) || penguinName.hitTest(sourceMc) || wordmarkLoaderHolder.hitTest(sourceMc) || penguinStamps.hitTest(sourceMc) || closeClip.hitTest(sourceMc);
        if (!_loc8)
        {
            var _loc7 = _renderers.length;
            for (var _loc2 = 0; _loc2 < _loc7; ++_loc2)
            {
                var _loc3 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(_renderers[_loc2]);
                var _loc5 = com.clubpenguin.stamps.IStampBookItem(_loc3.__get__data());
                var _loc4 = com.clubpenguin.stamps.IStampBookItem(sourceMc.data);
                if (_loc5.getID() != _loc4.getID() && _loc3.hitTest(sourceMc))
                {
                    return (true);
                } // end if
            } // end of for
        }
        else
        {
            return (true);
        } // end else if
    } // End of the function
    function onKeyDown()
    {
        var _loc2 = Key.getCode();
        switch (_loc2)
        {
            case 39:
            {
                _currentTarget._rotation = _currentTarget._rotation + com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ROTATION_VALUE;
                _currentTarget._rotation = _currentTarget._rotation % com.clubpenguin.stamps.stampbook.views.StampbookCoverView.MAX_ROTATION;
                break;
            } 
            case 37:
            {
                _currentTarget._rotation = _currentTarget._rotation - com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ROTATION_VALUE;
                _currentTarget._rotation = _currentTarget._rotation % com.clubpenguin.stamps.stampbook.views.StampbookCoverView.MAX_ROTATION;
                break;
            } 
        } // End of switch
    } // End of the function
    function handleDrag(event)
    {
        _currentTarget._x = Math.round(_xmouse - _mousexOffset);
        _currentTarget._y = Math.round(_ymouse - _mouseyOffset);
        rect = new flash.geom.Rectangle(_currentTarget._x - _currentTarget._width / 2, _currentTarget._y - _currentTarget._height / 2, _currentTarget._width, _currentTarget._height);
        _isPlaceableOnCover = !this.intersects(_currentTarget, rect);
        _removeStamp = dropAreaRect.intersects(rect);
        if (_isPlaceableOnCover || _removeStamp)
        {
            _currentTarget._alpha = com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ACTIVE_RENDERER;
        }
        else if (!_removeStamp)
        {
            _currentTarget._alpha = com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INACTIVE_RENDERER;
        } // end else if
        if (!_isDragging)
        {
            _currentTarget.removeEventListener("mouseUp", handleClick, this);
            _currentTarget.addEventListener("mouseUp", handleDrop, this);
        } // end if
        _isDragging = true;
        _currentTarget.hitArea._visible = true;
    } // End of the function
    function handleDrop()
    {
        _isDragging = false;
        Key.removeListener(this);
        _currentTarget.hitArea_mc._visible = false;
        if (_removeStamp || !_isPlaceableOnCover)
        {
            var _loc2 = this.indexOf(_renderers, _currentTarget);
            _renderers.splice(_loc2, 1);
            _currentTarget.removeMovieClip();
            _stampLookUp.removeStampFromCover(_currentID);
            coverList.dataProvider = _stampLookUp.getStampsForCategory(_selectedCategory);
        }
        else
        {
            _lastxPosition = Math.round(_currentTarget._x);
            _lastyPosition = Math.round(_currentTarget._y);
        } // end else if
        removeDropArea._visible = false;
        _currentTarget.filters = [];
        _currentTarget.showShadow();
        _currentTarget.removeEventListener("mouseMove", handleDrag, this);
        _currentTarget.removeEventListener("mouseUp", handleDrop, this);
        _currentTarget.removeEventListener("press", handleDrop, this);
        _currentTarget.addEventListener("press", onStampPressed, this);
    } // End of the function
    function indexOf(array, searchElement)
    {
        var _loc2 = array.length;
        for (var _loc1 = 0; _loc1 < _loc2; ++_loc1)
        {
            if (array[_loc1] == searchElement)
            {
                return (_loc1);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    function handleClick()
    {
        _currentTarget.removeEventListener("mouseUp", handleClick, this);
        _currentTarget.addEventListener("press", handleDrop, this);
    } // End of the function
    function toggleEditMode()
    {
        if (_toggleEditControls)
        {
            if (_editMode)
            {
                this.showEditControls();
            }
            else
            {
                this.hideEditControls();
            } // end else if
        }
        else
        {
            this.closeEditControls();
        } // end else if
    } // End of the function
    function closeEditControls()
    {
        this.hideEditControls();
        edit_btn._visible = false;
    } // End of the function
    function showEditControls()
    {
        edit_btn._visible = false;
        help_btn._visible = false;
        save_btn._visible = true;
        editBackground._visible = true;
        background._visible = false;
        toolBar._visible = true;
        coverList._visible = true;
        clasp.enabled = false;
        this.enableStampInteraction(true);
    } // End of the function
    function hideEditControls()
    {
        edit_btn._visible = true;
        help_btn._visible = false;
        save_btn._visible = false;
        editBackground._visible = false;
        background._visible = true;
        toolBar._visible = false;
        coverList._visible = false;
        clasp.enabled = true;
        this.enableStampInteraction(false);
    } // End of the function
    function enableStampInteraction(value)
    {
        var _loc5 = _renderers.length;
        for (var _loc3 = 0; _loc3 < _loc5; ++_loc3)
        {
            var _loc2 = _renderers[_loc3];
            _loc2.enabled = value;
            _loc2.useHandCursor = value;
            if (value)
            {
                _loc2.addEventListener("press", onStampPressed, this);
                continue;
            } // end if
            _loc2.removeEventListener("press", onStampPressed, this);
        } // end of for
    } // End of the function
    function onEditStampbookCover(event)
    {
        _editMode = true;
        this.toggleEditMode();
    } // End of the function
    function onSaveStampbookCover(event)
    {
        if (toolBar.__get__changingCategory())
        {
            toolBar.closeCategorySelector();
            return;
        } // end if
        _editMode = false;
        var _loc10 = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
        var _loc11 = _loc10.getPatternIndex();
        if (_loc11 == undefined || isNaN(_loc11))
        {
            _loc11 = com.clubpenguin.stamps.StampManager.COVER_PATTERN_NONE_ID;
        } // end if
        _model.setColourID(_loc10.getColourIndex());
        _model.setPatternID(_loc11);
        _model.setHighlightID(_loc10.getHighlightIndex());
        _model.setClaspIconArtID(_loc10.getIconIndex());
        var _loc9 = [];
        for (var _loc4 = 0; _loc4 < _renderers.length; ++_loc4)
        {
            var _loc2 = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer(_renderers[_loc4]);
            var _loc7 = com.clubpenguin.stamps.IStampBookItem(_loc2.__get__data());
            var _loc3 = _loc2._rotation;
            var _loc6 = Math.round(_loc2._x);
            var _loc8 = Math.round(_loc2._y);
            if (_loc3 < 0)
            {
                _loc3 = _loc3 + com.clubpenguin.stamps.stampbook.views.StampbookCoverView.MAX_ROTATION;
            } // end if
            var _loc5 = new com.clubpenguin.stamps.StampBookCoverItem(_loc7, new flash.geom.Point(_loc6, _loc8), _loc3, _loc2.getDepth());
            _loc9.push(_loc5);
        } // end of for
        _model.setCoverItems(_loc9);
        _stampManager.saveMyStampBookCover(com.clubpenguin.stamps.IStampBookCover(_model));
        this.toggleEditMode();
    } // End of the function
    static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.StampbookCoverView;
    static var LINKAGE_ID = "StampbookCoverView";
    static var BLANK_CLIP_LINKAGE_ID = "Blank";
    static var INVALID_ID = -1;
    static var ITEM_RENDERER = "BaseItemRenderer";
    static var ROTATION_VALUE = 15;
    static var ACTIVE_RENDERER = 100;
    static var INACTIVE_RENDERER = 50;
    static var PADDING = 10;
    static var MAX_ROTATION = 360;
    static var DROPSHADOW_DISTANCE = 4;
    static var DROPSHADOW_ANGLE = 45;
    static var DROPSHADOW_COLOR = 0;
    static var DROPSHADOW_ALPHA = 0.400000;
    static var DROPSHADOW_BLUR_X = 10;
    static var DROPSHADOW_BLUR_Y = 10;
    static var DROPSHADOW_STRENGTH = 2;
    static var DROPSHADOW_QUALITY = 3;
    static var STAMP_BOOK_ITEM_ART_SCALE = 150;
    var _toggleEditControls = false;
    var _editMode = false;
    var _isDragging = false;
} // End of Class
