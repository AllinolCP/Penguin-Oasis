class com.clubpenguin.login.views.WorldSelection extends com.clubpenguin.ui.views.AbstractView
{
    var bg_mc, _backgroundClip, world_04_mc, world_03_mc, world_02_mc, world_01_mc, world_00_mc, _suggestedWorldClips, redemption_mc, _redemptionBadgeClip, select_world_txt, _selectWorldField, buddies_txt, _buddiesField, amount_peng_txt, _numPenguinsOnlineField, ultimate_safe_txt, _ultimateSafeChatField, more_servers_btn, _moreServersClip, pl, _plMC, _contentTracked, _localizedTrackingName, _languageAbbreviation, viewManager, _visible, _shell, hide, _selectedWorldID;
    function WorldSelection()
    {
        super();
        com.clubpenguin.login.views.WorldSelection.debugTrace("instantiated");
        _backgroundClip = bg_mc;
        _suggestedWorldClips = new Array(world_00_mc, world_01_mc, world_02_mc, world_03_mc, world_04_mc);
        _backgroundClip.onRelease = undefined;
        _backgroundClip.useHandCursor = false;
        _backgroundClip.tabEnabled = false;
        _redemptionBadgeClip = redemption_mc;
        _selectWorldField = select_world_txt;
        _buddiesField = buddies_txt;
        _numPenguinsOnlineField = amount_peng_txt;
        _ultimateSafeChatField = ultimate_safe_txt;
        _moreServersClip = more_servers_btn;
        _plMC = pl;
        _moreServersClip.onRelease = com.clubpenguin.util.Delegate.create(this, showMoreServersOnRelease);
        _contentTracked = false;
        _localizedTrackingName = "";
    } // End of the function
    function setLanguageAbbr(abbr)
    {
        _languageAbbreviation = abbr;
        _localizedTrackingName = com.clubpenguin.login.views.WorldSelection.TRACKING_NAME + abbr.toLowerCase();
    } // End of the function
    function show()
    {
        com.clubpenguin.login.views.WorldSelection.debugTrace("show - isMoreServersActive: " + (com.clubpenguin.login.views.ViewManager)(viewManager).isMoreServersActive());
        if (!(com.clubpenguin.login.views.ViewManager)(viewManager).isMoreServersActive())
        {
            _visible = true;
        } // end if
        if (!_contentTracked && _localizedTrackingName.length > 0)
        {
            _contentTracked = true;
            _shell.trackContent(_localizedTrackingName);
        } // end if
        _plMC.player_mc.user_txt.text = "Welcome, " + _shell.myUser;
    } // End of the function
    function showMoreServersOnRelease()
    {
        this.hide();
        (com.clubpenguin.login.views.ViewManager)(viewManager).gotoMoreServers();
    } // End of the function
    function setupWorldSelection()
    {
        com.clubpenguin.login.views.WorldSelection.debugTrace("setupWorldSelection");
        this.setRedemptionForWorldSelection();
        this.translateWorldSelection();
        com.clubpenguin.login.Keyboard.clearOnEnterFunction();
        this.chooseServerScreen();
        this.show();
    } // End of the function
    function setRedemptionForWorldSelection()
    {
        _redemptionBadgeClip._visible = false;
        delete _redemptionBadgeClip.onRelease;
        if (_languageAbbreviation == _shell.EN_ABBR)
        {
            _redemptionBadgeClip._visible = true;
            _redemptionBadgeClip.onRelease = com.clubpenguin.util.Delegate.create(this, onRedemptionPress);
        } // end if
    } // End of the function
    function onRedemptionPress()
    {
        _shell.gotoState(_shell.MERCH_STATE);
    } // End of the function
    function translateWorldSelection()
    {
        _buddiesField.text = _shell.getLocalizedString("Buddies online");
        _numPenguinsOnlineField.text = _shell.getLocalizedString("Amount of penguins online");
        _ultimateSafeChatField.text = _shell.getLocalizedString("Ultimate safe chat");
        var _loc2 = _shell.getLocalizedFrame();
        _moreServersClip.gotoAndStop(_loc2);
    } // End of the function
    function chooseServerScreen()
    {
        var _loc2 = com.clubpenguin.login.LocalData.getLastWorldIdForActivePlayer();
        var _loc3 = _shell.getSortedWorldList();
        if (_loc2 != undefined)
        {
            this.showReturnUser(_loc3, _loc2);
            return;
        } // end if
        this.setupWorldClips(_loc3);
    } // End of the function
    function showReturnUser(serverList, lastWorldId)
    {
        var _loc4 = serverList.length;
        for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
        {
            if (serverList[_loc2].id == lastWorldId)
            {
                serverList.splice(_loc2, 1);
                break;
            } // end if
        } // end of for
        var _loc6 = _shell.getWorldById(lastWorldId);
        if (_loc6.population == com.clubpenguin.login.views.WorldSelection.FULL_POPULATION)
        {
            serverList.splice(1, 0, _loc6);
        }
        else
        {
            serverList.splice(0, 0, _loc6);
        } // end else if
        this.setupWorldClips(serverList);
    } // End of the function
    function setupWorldClips(data)
    {
        var _loc6 = _suggestedWorldClips.length;
        var _loc3 = 0;
        if (_loc3 >= _loc6)
        {
            return;
        } // end if
        var _loc2 = _suggestedWorldClips[_loc3];
        if (data[_loc3] == undefined)
        {
            _loc2._visible = false;
        }
        else
        {
            _loc2.name_txt.text = data[_loc3].name;
            com.clubpenguin.login.Tools.ResizeTextToFit(_loc2.name_txt);
            _loc2.pop_mc.gotoAndStop(data[_loc3].population);
            _loc2.population = data[_loc3].population;
            var _loc5 = false;
            if (_loc2.population == com.clubpenguin.login.views.WorldSelection.FULL_POPULATION)
            {
                _loc2.name_txt.text = "[FULL] " + _loc2.name_txt.text;
                _loc5 = true;
            } // end if
            if (data[_loc3].isOnline == false)
            {
                _loc2.name_txt.text = "[DOWN] " + _loc2.name_txt.text;
                _loc5 = true;
            } // end if
            _loc2.id = data[_loc3].id;
            _loc2.onRollOver = com.clubpenguin.util.Delegate.create(this, rollOverWorldSelection, _loc2);
            _loc2.onDragOver = _loc2.onRollOver;
            _loc2.onRollOut = com.clubpenguin.util.Delegate.create(this, rollOutWorldSelection, _loc2);
            _loc2.onDragOut = _loc2.onRollOut;
            if (_loc5 == false)
            {
                _loc2.onRelease = com.clubpenguin.util.Delegate.create(this, connectToWorld, _loc2);
            } // end if
            _loc2.hover_mc._visible = false;
            _loc2.pop_mc.buddy_mc.gotoAndStop(1);
            if (data[_loc3].has_buddies)
            {
                _loc2.pop_mc.buddy_mc.gotoAndStop(2);
            } // end if
            if (data[_loc3].is_safe)
            {
                _loc2.pop_mc.safe_chat_mc._visible = true;
            }
            else
            {
                _loc2.pop_mc.safe_chat_mc._visible = false;
            } // end else if
            _loc2.onlineUsers.text = data[_loc3].onlineUsers != undefined ? (data[_loc3].onlineUsers) : ("0");
            _loc2.online_buds.text = data[_loc3].onlineBuds != undefined ? (data[_loc3].onlineBuds + " budd" + (data[_loc3].onlineBuds == 1 ? ("y") : ("ies")) + " online") : ("0 buddies online");
            trace (data[_loc3].id + ":" + data[_loc3].typeOfServer);
            switch (data[_loc3].typeOfServer)
            {
                case 1:
                case "normal":
                case "1":
                {
                    _loc2.typeOfServer.gotoAndStop(2);
                    _loc2.typeOfServerLbl.text = "Normal Server";
                    break;
                } 
                case 2:
                case "game":
                case "2":
                {
                    _loc2.typeOfServer.gotoAndStop(1);
                    _loc2.typeOfServerLbl.text = "Game Server";
                    break;
                } 
                default:
                {
                    _loc2.typeOfServer.gotoAndStop(2);
                    _loc2.typeOfServerLbl.text = "Normal Server";
                    break;
                } 
            } // End of switch
        } // end else if
        ++_loc3;
        
    } // End of the function
    function rollOverWorldSelection(worldClip)
    {
        worldClip.hover_mc._visible = true;
    } // End of the function
    function rollOutWorldSelection(worldClip)
    {
        worldClip.hover_mc._visible = false;
    } // End of the function
    function connectToWorld(worldClip)
    {
        if (worldClip.population == undefined || worldClip.population < com.clubpenguin.login.views.WorldSelection.FULL_POPULATION)
        {
            _selectedWorldID = worldClip.id;
            _shell.setWorldForConnection(_selectedWorldID);
            return;
        } // end if
        _shell.$e("[login] createServer() -> Server is full!", {error_code: _shell.SERVER_FULL});
    } // End of the function
    static function debugTrace(msg)
    {
        if (!com.clubpenguin.login.views.WorldSelection._debugTracesActive)
        {
            return;
        } // end if
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.login.views.WorldSelection";
    static var FULL_POPULATION = 6;
    static var TARGET_POPULATION = 3;
    static var SUGGESTED_WORLD_DISPLAY_COUNT = 5;
    static var TRACKING_NAME = "select_server_";
    static var _debugTracesActive = true;
} // End of Class
