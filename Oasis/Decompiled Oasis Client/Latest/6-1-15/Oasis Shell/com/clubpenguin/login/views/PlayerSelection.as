class com.clubpenguin.login.views.PlayerSelection extends com.clubpenguin.ui.views.AbstractView
{
    var _storedPlayerClips, bg_mc, _backgroundClip, login_as_diff_btn, _loginAsDiffBtn, different_penguin_txt, _differentPenguinField, redemption_badge_mc, _redemptionBadgeClip, _paperDolls, _contentTracked, _localizedTrackingName, viewManager, _savedPlayers, _numSavedPlayers, _currentPlayerScreen, _shell;
    function PlayerSelection()
    {
        super();
        this.debugTrace("instantiated");
        _storedPlayerClips = new Array();
        for (var _loc3 = 0; _loc3 < com.clubpenguin.login.views.PlayerSelection.MAX_STORED_PLAYERS; ++_loc3)
        {
            _storedPlayerClips[_loc3] = this["playerClip" + (_loc3 + 1)];
        } // end of for
        _backgroundClip = bg_mc;
        _loginAsDiffBtn = login_as_diff_btn;
        _differentPenguinField = different_penguin_txt;
        _redemptionBadgeClip = redemption_badge_mc;
        _backgroundClip.onRelease = undefined;
        _backgroundClip.useHandCursor = false;
        _backgroundClip.tabEnabled = false;
        _paperDolls = new Array();
        _contentTracked = false;
        _localizedTrackingName = "";
    } // End of the function
    function setupPlayerSelection()
    {
        this.debugTrace("setupPlayerSelection");
        _loginAsDiffBtn.onRelease = com.clubpenguin.util.Delegate.create(viewManager, (com.clubpenguin.login.views.ViewManager)(viewManager).gotoNewPlayer);
        this.setRedemptionForPlayerSelection();
        this.translatePlayerSelection();
        _savedPlayers = com.clubpenguin.login.LocalData.getSavedPlayers();
        _numSavedPlayers = _savedPlayers.length;
        if (_numSavedPlayers < 1)
        {
            (com.clubpenguin.login.views.ViewManager)(viewManager).gotoStart();
            return;
        } // end if
        _currentPlayerScreen = this.getPlayerScreen();
        this.setupPlayerCards();
        this.show();
    } // End of the function
    function setRedemptionForPlayerSelection()
    {
        _redemptionBadgeClip._visible = false;
        if ((com.clubpenguin.login.views.ViewManager)(viewManager).getRedemptionStatus())
        {
            _redemptionBadgeClip._visible = true;
        } // end if
    } // End of the function
    function setLanguageAbbr(abbr)
    {
        super.setLanguageAbbr(abbr);
        _redemptionBadgeClip._redeemablesIconClip.gotoAndStop(abbr);
        _localizedTrackingName = com.clubpenguin.login.views.PlayerSelection.TRACKING_NAME + abbr.toLowerCase();
    } // End of the function
    function show()
    {
        super.show();
        if (!_contentTracked && _localizedTrackingName.length > 0)
        {
            _contentTracked = true;
            _shell.trackContent(_localizedTrackingName);
        } // end if
    } // End of the function
    function translatePlayerSelection()
    {
        _differentPenguinField.text = _shell.getLocalizedString("Login as a different penguin");
    } // End of the function
    function getPlayerScreen()
    {
        this.hideAllPlayers();
        if (_numSavedPlayers > 0 && _numSavedPlayers <= com.clubpenguin.login.views.PlayerSelection.MAX_STORED_PLAYERS)
        {
            return (_storedPlayerClips[_numSavedPlayers - 1]);
        } // end if
        _shell.$e("[login] getPlayerScreen() -> no players saved");
        return (_storedPlayerClips[0]);
    } // End of the function
    function setupPlayerCards()
    {
        var _loc9 = _numSavedPlayers;
        for (var _loc3 = 0; _loc3 < _loc9; ++_loc3)
        {
            var _loc5 = _savedPlayers[_loc3];
            var _loc7 = _loc5.Username.toUpperCase();
            var _loc2 = _currentPlayerScreen["item" + _loc3 + "_mc"];
            _loc2.nickname1_txt.text = _loc7;
            if (_loc2.originalNicknameYPosition == null)
            {
                _loc2.originalNicknameYPosition = _loc2.nickname1_txt._y;
            }
            else
            {
                _loc2.nickname1_txt._y = _loc2.originalNicknameYPosition;
            } // end else if
            com.clubpenguin.login.Tools.ResizeTextToFit(_loc2.nickname1_txt);
            var _loc4 = new com.clubpenguin.ui.PaperDoll();
            _loc4.__set__shell(_shell);
            _loc4.__set__paperDollClip(_loc2.paper_mc);
            _loc4.__set__fadeAfterLoad(true);
            _loc4.__set__colourID(_loc5.Colour);
            for (var _loc8 in _shell.PAPERDOLL_DEFAULT_LAYER_DEPTHS)
            {
                var _loc6 = _loc8.substr(0, 1).toUpperCase() + _loc8.substr(1);
                _loc4.addItem(_loc8, _loc5[_loc6] || 0);
            } // end of for...in
            _loc2.playerData = _loc5;
            _loc2.paperDoll = _loc4;
            _loc2.onRelease = com.clubpenguin.util.Delegate.create(this, selectPlayer, _loc3);
            _loc2.onRollOver = com.clubpenguin.util.Delegate.create(this, highlightPlayer, _loc3);
            _loc2.onRollOut = com.clubpenguin.util.Delegate.create(this, dullPlayer, _loc3);
            _loc2.onDragOut = com.clubpenguin.util.Delegate.create(this, dullPlayer, _loc3);
            _loc2.tabIndex = _currentTabIndex++;
            _paperDolls[_loc3] = _loc2;
        } // end of for
        _currentPlayerScreen._visible = true;
        _loginAsDiffBtn.tabIndex = _currentTabIndex;
    } // End of the function
    function selectPlayer(playerIdx)
    {
        var _loc2 = new Object();
        _loc2.playerData = _paperDolls[playerIdx].playerData;
        _loc2.paperDoll = _paperDolls[playerIdx].paperDoll;
        (com.clubpenguin.login.views.ViewManager)(viewManager).gotoPlayerLogin(_loc2);
    } // End of the function
    function highlightPlayer(playerIdx)
    {
        _paperDolls[playerIdx].background_mc.gotoAndStop("_over");
    } // End of the function
    function dullPlayer(playerIdx)
    {
        _paperDolls[playerIdx].background_mc.gotoAndStop("_up");
    } // End of the function
    function hideAllPlayers()
    {
        var _loc2 = 0;
        if (_loc2 >= com.clubpenguin.login.views.PlayerSelection.MAX_STORED_PLAYERS)
        {
            return;
        } // end if
        _storedPlayerClips[_loc2]._visible = false;
        ++_loc2;
        
    } // End of the function
    function debugTrace(msg)
    {
        if (!com.clubpenguin.login.views.PlayerSelection._debugTracesActive)
        {
            return;
        } // end if
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.login.views.PlayerSelection";
    static var _debugTracesActive = true;
    static var MAX_STORED_PLAYERS = 6;
    static var TRACKING_NAME = "select_penguin_";
    var _currentTabIndex = 0;
} // End of Class
