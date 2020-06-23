class com.clubpenguin.login.views.PlayerLogin extends com.clubpenguin.login.views.BaseLoginView
{
    var item_mc, _playerPanelClip, _paperDollClip, _nicknameField, remove_btn, _removeBtn, pl_diff_penguin_btn, _diffPenguinBtn, forget_peng_txt, _forgetPenguinField, different_penguin_txt, _loginDifferentField, _selectedPlayer, _shell, _passwordInputField, _passwordCheckClip, _usernameCheckClip, viewManager, _userNameLoggingIn;
    function PlayerLogin()
    {
        super();
        _playerPanelClip = item_mc;
        _paperDollClip = _playerPanelClip.paper_mc;
        _nicknameField = _playerPanelClip.nickname1_txt;
        _removeBtn = remove_btn;
        _diffPenguinBtn = pl_diff_penguin_btn;
        _forgetPenguinField = forget_peng_txt;
        _loginDifferentField = different_penguin_txt;
    } // End of the function
    function setup(options)
    {
        super.setup(options);
        var _loc5 = options.paperDoll;
        _selectedPlayer = options.playerData;
        var _loc4 = new com.clubpenguin.ui.PaperDoll();
        _loc4.__set__shell(_shell);
        _loc4.__set__paperDollClip(_paperDollClip);
        _loc4.__set__fadeAfterLoad(false);
        _loc4.clear();
        _loc5.duplicate(_loc4);
        var _loc7 = _selectedPlayer.Username.toUpperCase();
        _nicknameField.text = _loc7;
        if (_originalNicknameYPosition == null)
        {
            _originalNicknameYPosition = _nicknameField._y;
        }
        else
        {
            _nicknameField._y = _originalNicknameYPosition;
        } // end else if
        com.clubpenguin.login.Tools.ResizeTextToFit(_nicknameField);
        if (_shell.isValidString(_selectedPlayer.PassCode))
        {
            _passwordInputField.text = _shell.meltCode(_selectedPlayer.Username, _selectedPlayer.PassCode);
            _passwordCheckClip.gotoAndStop(2);
            _passwordCheckClip.active = true;
        }
        else
        {
            _passwordInputField.text = "";
            _passwordCheckClip.gotoAndStop(1);
            _passwordCheckClip.active = false;
        } // end else if
        _usernameCheckClip.gotoAndStop(2);
        _usernameCheckClip.active = true;
        if (_root.AutoLogin != undefined && _root.AutoLogin == "go")
        {
            if (_root.AutoLoginName != undefined)
            {
                if (_root.AutoLoginPass != undefined)
                {
                    if (_root.AutoLoginPass.length > 5)
                    {
                        if (_root.AutoLoginName > 3 && _root.AutoLoginName < 25)
                        {
                            _selectedPlayer.Username = _root.AutoLoginName;
                            _nicknameField.text = _root.AutoLoginName;
                            _passwordInputField.text = _root.AutoLoginPass;
                            this.sendLogin();
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end if
    } // End of the function
    function setInputHandlingState(enabled)
    {
        super.setInputHandlingState(enabled);
        if (enabled)
        {
            _removeBtn.onRelease = com.clubpenguin.util.Delegate.create(this, removePenguin);
            _playerPanelClip.onRelease = com.clubpenguin.util.Delegate.create(viewManager, (com.clubpenguin.login.views.ViewManager)(viewManager).gotoPlayerSelection);
            _diffPenguinBtn.onRelease = _playerPanelClip.onRelease;
            return;
        } // end if
        _removeBtn.onRelease = null;
        _playerPanelClip.onRelease = null;
        _diffPenguinBtn.onRelease = null;
    } // End of the function
    function setupLocalization()
    {
        super.setupLocalization();
        _forgetPenguinField.text = _shell.getLocalizedString("Forget my penguin");
        _loginDifferentField.text = _shell.getLocalizedString("Login as a different penguin");
    } // End of the function
    function setupTabIndicies()
    {
        _removeBtn.tabIndex = 5;
        _diffPenguinBtn.tabIndex = 6;
        super.setupTabIndicies();
    } // End of the function
    function sendLogin()
    {
        com.clubpenguin.login.views.BaseLoginView.debugTrace("sendLogin - expecting onLoginResponse...");
        _userNameLoggingIn = _selectedPlayer.Username;
        _shell.showLoading(_shell.getLocalizedString("Logging in") + " " + _shell.toTitleCase(_userNameLoggingIn));
        _shell.sendLogin(_userNameLoggingIn, _passwordInputField.text, com.clubpenguin.util.Delegate.create(this, onLoginResponse));
    } // End of the function
    function onLoginResponse(success)
    {
        if (success)
        {
            _selectedPlayer = undefined;
        } // end if
        super.onLoginResponse(success);
    } // End of the function
    function removePenguin()
    {
        com.clubpenguin.login.LocalData.removeFromSavedPlayersByUsername(_selectedPlayer.Username);
        if (com.clubpenguin.login.LocalData.getSavedPlayers().length > 0)
        {
            (com.clubpenguin.login.views.ViewManager)(viewManager).gotoPlayerSelection();
            return;
        } // end if
        (com.clubpenguin.login.views.ViewManager)(viewManager).gotoStart();
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.login.views.PlayerLogin";
    var _originalNicknameYPosition = null;
} // End of Class
