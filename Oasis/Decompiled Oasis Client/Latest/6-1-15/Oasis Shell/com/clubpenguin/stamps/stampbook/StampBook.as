class com.clubpenguin.stamps.stampbook.StampBook extends MovieClip
{
    var _visible, _recentlyEarnedList, _isMyStampBook, getNextHighestDepth, attachMovie, _insidePagesViewClip, _categoryList, _coverStamps, _userStampsList, _stampBookCoverViewClip, createEmptyMovieClip, _storagePromptHolder, onEnterFrame, stampbookCoverView, recentlyEarnedView, insidePagesView, getURL, _parent;
    static var SHELL, __get__shell, STAMP_MANAGER, __get__stampManager, ACTIVE_PLAYER, __get__activePlayer, __set__activePlayer, __set__shell, __set__stampManager;
    function StampBook()
    {
        super();
        com.clubpenguin.stamps.stampbook.util.ShellLookUp.__set__shell(com.clubpenguin.stamps.stampbook.StampBook.SHELL);
        _visible = false;
        this.configUI();
    } // End of the function
    static function set shell(clip)
    {
        SHELL = clip;
        null;
        //return (com.clubpenguin.stamps.stampbook.StampBook.shell());
        null;
    } // End of the function
    static function set stampManager(manager)
    {
        STAMP_MANAGER = manager;
        null;
        //return (com.clubpenguin.stamps.stampbook.StampBook.stampManager());
        null;
    } // End of the function
    static function set activePlayer(activePlayerObj)
    {
        ACTIVE_PLAYER = activePlayerObj;
        null;
        //return (com.clubpenguin.stamps.stampbook.StampBook.activePlayer());
        null;
    } // End of the function
    function configUI()
    {
        if (com.clubpenguin.stamps.stampbook.StampBook.SHELL == undefined || com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER == undefined || com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER == undefined || com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id == undefined)
        {
            return;
        } // end if
        _recentlyEarnedList = [];
        _isMyStampBook = com.clubpenguin.stamps.stampbook.StampBook.SHELL.isMyPlayer(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id);
        _insidePagesViewClip = this.attachMovie("InsidePagesView", com.clubpenguin.stamps.stampbook.StampBook.INSIDE_PAGES_VIEW_CLIP_NAME, this.getNextHighestDepth());
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.addListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.PLAYERS_STAMP_BOOK_CATEGORIES, handleGetPlayersStampBookCategories, this);
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.addListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.STAMP_BOOK_COVER_DETAILS, handleGetStampBookCoverDetails, this);
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.addListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.PLAYERS_STAMPS, handleGetPlayersStamps, this);
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.showLoading(com.clubpenguin.stamps.stampbook.StampBook.SHELL.getLocalizedString("Loading Content"));
        com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getPlayersStampBookCategories(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id);
    } // End of the function
    function handleGetPlayersStampBookCategories(stampCategories)
    {
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.removeListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.PLAYERS_STAMP_BOOK_CATEGORIES, handleGetPlayersStampBookCategories, this);
        _categoryList = stampCategories;
        com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getStampBookCoverDetails(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id);
    } // End of the function
    function handleGetStampBookCoverDetails(stampBookCover)
    {
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.removeListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.STAMP_BOOK_COVER_DETAILS, handleGetStampBookCoverDetails, this);
        _coverStamps = stampBookCover;
        com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getPlayersStamps(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id);
    } // End of the function
    function handleGetPlayersStamps(stampsList)
    {
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.removeListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.PLAYERS_STAMPS, handleGetPlayersStamps, this);
        _userStampsList = stampsList;
        com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance().initialize(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER, _categoryList, _userStampsList, _coverStamps, com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER);
        _stampBookCoverViewClip = this.attachMovie("StampbookCoverView", com.clubpenguin.stamps.stampbook.StampBook.STAMPBOOK_COVER_VIEW_CLIP_NAME, this.getNextHighestDepth());
        if (_isMyStampBook)
        {
            com.clubpenguin.stamps.stampbook.StampBook.SHELL.addListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.MY_RECENTLY_EARNED_STAMPS, handleGetMyRecentlyEarnedStamps, this);
            com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getMyRecentlyEarnedStamps();
        }
        else
        {
            this.drawUI();
        } // end else if
    } // End of the function
    function handleGetMyRecentlyEarnedStamps(stampsList)
    {
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.removeListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.MY_RECENTLY_EARNED_STAMPS, handleGetMyRecentlyEarnedStamps, this);
        _recentlyEarnedList = stampsList;
        this.drawUI();
    } // End of the function
    function drawUI()
    {
        function onEnterFrame()
        {
            if (_stampBookCoverViewClip._width > 0 && _insidePagesViewClip._width > 0)
            {
                if (com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id == com.clubpenguin.stamps.stampbook.StampBook.SHELL.getMyPlayerId() && com.clubpenguin.stamps.stampbook.StampBook._isFirstView && !com.clubpenguin.stamps.stampbook.StampBook.SHELL.isPlayerMemberById(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id) && com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getHasModifiedStampCover())
                {
                    _isFirstView = false;
                    var _loc3 = com.clubpenguin.stamps.stampbook.StampBook.SHELL.getPath("stampbook_cover_storage");
                    _storagePromptHolder = this.createEmptyMovieClip("_storagePromptHolder", this.getNextHighestDepth());
                    var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                    _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onStoragePromptLoaded));
                    _loc2.loadClip(_loc3, _storagePromptHolder);
                }
                else
                {
                    com.clubpenguin.stamps.stampbook.StampBook.SHELL.hideLoading();
                    _visible = true;
                } // end else if
                delete this.onEnterFrame;
            } // end if
        } // End of the function
        stampbookCoverView._visible = true;
        stampbookCoverView = com.clubpenguin.stamps.stampbook.views.StampbookCoverView(_stampBookCoverViewClip);
        stampbookCoverView.addEventListener("claspClicked", onContinueToInsidePages, this);
        stampbookCoverView.setModel(_coverStamps);
        stampbookCoverView.__set__closeStampBookFunction(mx.utils.Delegate.create(this, handleCloseStampBook));
        stampbookCoverView.__set__toggleEditControls(_isMyStampBook && com.clubpenguin.stamps.stampbook.StampBook.SHELL.isPlayerMemberById(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id) ? (true) : (false));
        if (_recentlyEarnedList.length > 0)
        {
            recentlyEarnedView = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView(this.attachMovie("RecentlyEarnedStampsView", com.clubpenguin.stamps.stampbook.StampBook.RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME, this.getNextHighestDepth()));
            recentlyEarnedView.setModel(_recentlyEarnedList);
            recentlyEarnedView.addEventListener("close", onCloseRecentlyEarnedView, this);
            recentlyEarnedView._x = Stage.width - recentlyEarnedView.getWidth() >> 1;
            recentlyEarnedView._y = Stage.height - recentlyEarnedView.getHeight() >> 1;
        } // end if
        insidePagesView = com.clubpenguin.stamps.stampbook.views.InsidePagesView(_insidePagesViewClip);
        insidePagesView.addEventListener("close", onGoBackToCover, this);
        insidePagesView.addEventListener("closeStampBook", handleCloseStampBook, this);
        insidePagesView._visible = false;
    } // End of the function
    function onStoragePromptLoaded(event)
    {
        var _loc2 = event.target;
        _loc2.blocker_mc.tabEnabled = false;
        _loc2.blocker_mc.onPress = null;
        _loc2.blocker_mc.useHandCursor = false;
        _loc2.screen_mc.close_btn.onRelease = mx.utils.Delegate.create(this, onStoragePromptClose);
        _loc2.screen_mc.buy_btn.onRelease = mx.utils.Delegate.create(this, onStoragePromptBuy);
        com.clubpenguin.stamps.stampbook.StampBook.SHELL.hideLoading();
        _visible = true;
    } // End of the function
    function onStoragePromptClose()
    {
        _storagePromptHolder.removeMovieClip();
    } // End of the function
    function onStoragePromptBuy()
    {
        _storagePromptHolder.removeMovieClip();
        this.getURL(com.clubpenguin.stamps.stampbook.StampBook.SHELL.getPath("member_web") + com.clubpenguin.stamps.stampbook.StampBook.OOPS_MESSAGE_TRACKING + com.clubpenguin.stamps.stampbook.StampBook.SHELL.getLanguageAbbriviation(), "_blank");
    } // End of the function
    function onContinueToInsidePages(event)
    {
        stampbookCoverView._visible = false;
        insidePagesView.setModel(_categoryList);
        insidePagesView._visible = true;
    } // End of the function
    function onGoBackToCover(event)
    {
        insidePagesView._visible = false;
        stampbookCoverView._visible = true;
    } // End of the function
    function onCloseRecentlyEarnedView(event)
    {
        recentlyEarnedView._visible = false;
    } // End of the function
    function handleCloseStampBook()
    {
        _parent._root.close();
    } // End of the function
    function cleanUp()
    {
        insidePagesView.removeEventListener("close", onGoBackToCover, this);
        insidePagesView.removeEventListener("closeStampBook", handleCloseStampBook, this);
        stampbookCoverView.removeEventListener("claspClicked", onContinueToInsidePages, this);
        if (_recentlyEarnedList.length > 0)
        {
            this[com.clubpenguin.stamps.stampbook.StampBook.RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME].removeMovieClip();
            recentlyEarnedView.removeEventListener("close", onCloseRecentlyEarnedView, this);
        } // end if
        recentlyEarnedView.cleanUp();
        stampbookCoverView.cleanUp();
        insidePagesView.cleanUp();
        _stampBookCoverViewClip.removeMovieClip();
        _insidePagesViewClip.removeMovieClip();
    } // End of the function
    static var STAMPBOOK_COVER_VIEW_CLIP_NAME = "stampBookCoverView";
    static var RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME = "recentlyEarnedStampsView";
    static var INSIDE_PAGES_VIEW_CLIP_NAME = "insidePagesView";
    static var OOPS_MESSAGE_TRACKING = "?oops_stampbook_";
    static var _isFirstView = true;
} // End of Class
