class com.clubpenguin.login.views.BaseLoginView extends com.clubpenguin.ui.views.AbstractView
{
    var bg_mc, _backgroundClip, password_input, _passwordInputField, password_check, _passwordCheckClip, username_check, _usernameCheckClip, login_btn, _loginBtn, forgot_btn, _forgotBtn, redemption_badge_mc, _redemptionBadgeClip, pass_txt, _passwordField, remember_peng_txt, _rememberPenguinField, remember_pass_txt, _rememberPasswordField, sign_in_txt, _signInField, forgot_pass_txt, _forgotPasswordField, note_mc, _passwordNoteClip, _contentTracked, _shell, _parent, _prompt, getURL, viewManager, _userNameLoggingIn;
    function BaseLoginView()
    {
        super();
        _backgroundClip = bg_mc;
        _passwordInputField = password_input;
        _passwordCheckClip = password_check;
        _usernameCheckClip = username_check;
        _loginBtn = login_btn;
        _forgotBtn = forgot_btn;
        _redemptionBadgeClip = redemption_badge_mc;
        _passwordField = pass_txt;
        _rememberPenguinField = remember_peng_txt;
        _rememberPasswordField = remember_pass_txt;
        _signInField = sign_in_txt;
        _forgotPasswordField = forgot_pass_txt;
        _passwordNoteClip = note_mc;
        _contentTracked = false;
    } // End of the function
    function setup(options)
    {
        com.clubpenguin.login.views.BaseLoginView.debugTrace("setup");
        this.setInputHandlingState(true);
        this.setupRedemption();
        this.setupLocalization();
        this.setupTabIndicies();
    } // End of the function
    function show()
    {
        super.show();
        if (_contentTracked)
        {
            return;
        } // end if
        _contentTracked = true;
        _shell.trackEvent("login_page_reached");
    } // End of the function
    function playerRememberUsername()
    {
        var _loc2 = com.clubpenguin.login.Tools.makeCheckboxToggle(_usernameCheckClip);
        _usernameCheckClip.active = _loc2;
        if (_usernameCheckClip.active)
        {
            return;
        } // end if
        if (_passwordCheckClip.active)
        {
            _passwordCheckClip.gotoAndStop(1);
            _passwordCheckClip.active = false;
        } // end if
    } // End of the function
    function setInputHandlingState(enabled)
    {
        if (enabled)
        {
            _loginBtn.onRelease = com.clubpenguin.util.Delegate.create(this, sendLogin);
            _passwordCheckClip.onRelease = com.clubpenguin.util.Delegate.create(this, playerRememberPassword);
            _usernameCheckClip.onRelease = com.clubpenguin.util.Delegate.create(this, playerRememberUsername);
            _forgotBtn.onRelease = com.clubpenguin.util.Delegate.create(this, forgotPassword);
            return;
        } // end if
        _loginBtn.onRelease = null;
        _passwordCheckClip.onRelease = null;
        _usernameCheckClip.onRelease = null;
        _forgotBtn.onRelease = null;
    } // End of the function
    function playerRememberPassword()
    {
        if (!_passwordCheckClip.active)
        {
            _shell.trackEvent("login_save_password_selected");
            _prompt = _parent.attachMovie("PublicComputerPrompt", "prompt", _parent.getNextHighestDepth());
            _prompt.yes_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onIsPublicComputer);
            _prompt.no_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onIsPrivateComputer);
            _prompt.txMessage.text = _shell.getLocalizedString("public_computer_prompt_msg");
            _prompt.yes_txt.text = _shell.getLocalizedString("Yes");
            _prompt.no_txt.text = _shell.getLocalizedString("No");
            _prompt.blocker_mc.tabEnabled = false;
            _prompt.blocker_mc.onPress = null;
            _prompt.blocker_mc.useHandCursor = false;
            return;
        } // end if
        _passwordCheckClip.active = com.clubpenguin.login.Tools.makeCheckboxToggle(_passwordCheckClip);
    } // End of the function
    function onIsPublicComputer()
    {
        _prompt.removeMovieClip();
        this.showSavePasswordPrompt();
    } // End of the function
    function onIsPrivateComputer()
    {
        _prompt.removeMovieClip();
        this.showSavePasswordPrompt();
    } // End of the function
    function showSavePasswordPrompt()
    {
        _prompt = _parent.attachMovie("SavePasswordPrompt", "prompt", _parent.getNextHighestDepth());
        _prompt.save_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onAcceptSavePassword);
        _prompt.nosave_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onDeclineSavePassword);
        _prompt.close_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onDeclineSavePassword);
        _prompt.learnmore_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onSavePasswordLearnMore);
        _prompt.save_txt.text = "measure";
        var _loc2 = _prompt.save_txt.textHeight;
        _prompt.save_txt.text = _shell.getLocalizedString("save_password");
        if (_prompt.save_txt.textHeight > _loc2 + com.clubpenguin.login.views.BaseLoginView.MULTI_LINE_SPACING / 2)
        {
            _prompt.save_txt._y = _prompt.save_txt._y - com.clubpenguin.login.views.BaseLoginView.MULTI_LINE_SPACING;
        } // end if
        _prompt.nosave_txt.text = _shell.getLocalizedString("dont_save_password");
        if (_prompt.nosave_txt.textHeight > _loc2 + com.clubpenguin.login.views.BaseLoginView.MULTI_LINE_SPACING / 2)
        {
            _prompt.nosave_txt._y = _prompt.nosave_txt._y - com.clubpenguin.login.views.BaseLoginView.MULTI_LINE_SPACING;
        } // end if
        _prompt.learnmore_txt.text = _shell.getLocalizedString("learn_more");
        _prompt.message_txt.text = _shell.getLocalizedString("save_password_warning_msg");
        _prompt.messageShadow_txt.text = _prompt.message_txt.text;
        _prompt.msg1_txt.text = _shell.getLocalizedString("player_safety_lose_coins");
        _prompt.msg2_txt.text = _shell.getLocalizedString("player_safety_changed_igloo");
        _prompt.msg3_txt.text = _shell.getLocalizedString("player_safety_banned");
        _prompt.blocker_mc.tabEnabled = false;
        _prompt.blocker_mc.onPress = null;
        _prompt.blocker_mc.useHandCursor = false;
    } // End of the function
    function onSavePasswordLearnMore()
    {
        _shell.trackEvent("login_save_password_more_info_selected");
        this.getURL(_shell.getPath("player_safety"));
    } // End of the function
    function onAcceptSavePassword()
    {
        _shell.trackEvent("login_save_password_prompt_accepted");
        var _loc2 = com.clubpenguin.login.Tools.makeCheckboxToggle(_passwordCheckClip);
        _passwordCheckClip.active = _loc2;
        if (!_usernameCheckClip.active)
        {
            _usernameCheckClip.onRelease();
        } // end if
        _prompt.removeMovieClip();
    } // End of the function
    function onDeclineSavePassword()
    {
        _shell.trackEvent("login_save_password_prompt_declined");
        _prompt.removeMovieClip();
    } // End of the function
    function setupRedemption()
    {
        if ((com.clubpenguin.login.views.ViewManager)(viewManager).getRedemptionStatus())
        {
            _redemptionBadgeClip._visible = true;
            return;
        } // end if
        _redemptionBadgeClip._visible = false;
    } // End of the function
    function setLanguageAbbr(abbr)
    {
        super.setLanguageAbbr(abbr);
        _redemptionBadgeClip._redeemablesIconClip.gotoAndStop(abbr);
    } // End of the function
    function setupLocalization()
    {
        _passwordField.text = _shell.getLocalizedString("Password:");
        _rememberPenguinField.text = _shell.getLocalizedString("Remember me on this computer");
        _rememberPasswordField.text = _shell.getLocalizedString("Remember my password");
        _signInField.text = _shell.getLocalizedString("Login");
        _forgotPasswordField.text = _shell.getLocalizedString("Forgot your password?");
        var _loc2 = _shell.getLocalizedFrame();
        _passwordNoteClip.gotoAndStop(_loc2);
    } // End of the function
    function setupTabIndicies()
    {
        _passwordInputField.tabIndex = 0;
        _usernameCheckClip.tabIndex = 1;
        _passwordCheckClip.tabIndex = 2;
        _loginBtn.tabIndex = 3;
        _forgotBtn.tabIndex = 4;
        if (!_shell.isValidString(_passwordInputField.text))
        {
            Selection.setFocus(_passwordInputField);
        } // end if
        com.clubpenguin.login.Keyboard.setOnEnterFunction(_loginBtn.onRelease);
    } // End of the function
    function sendLogin()
    {
    } // End of the function
    function onLoginResponse(success)
    {
        com.clubpenguin.login.views.BaseLoginView.debugTrace("onLoginResponse - " + success);
        if (success)
        {
            _shell.hideLoading();
            var _loc2 = {};
            _loc2.Username = _userNameLoggingIn.toLowerCase();
            _loc2.Password = _passwordInputField.text;
            _loc2.isRememberUsername = _usernameCheckClip.active || false;
            _loc2.isRememberPassword = _passwordCheckClip.active || false;
            com.clubpenguin.login.LocalData.setPlayerObjectToSave(_loc2);
            com.clubpenguin.login.LocalData.saveNicknameToCookie(_loc2.Username);
            if ((com.clubpenguin.login.views.ViewManager)(viewManager).getRedemptionStatus())
            {
                com.clubpenguin.login.Keyboard.clearOnEnterFunction();
                _shell.gotoState(_shell.MERCH_STATE);
            } // end if
            (com.clubpenguin.login.views.ViewManager)(viewManager).gotoWorldSelection();
            var _loc3 = System.capabilities.version.split(" ");
            var _loc5 = _loc3[0];
            var _loc4 = _loc3[1];
            _shell.trackEvent("login_successful", [_loc4, _loc5]);
            return;
        } // end if
        _shell.$e("onLoginResponse() -> Login Failed", {error_code: _shell.NO_CONNECTION});
    } // End of the function
    function forgotPassword()
    {
        this.getURL(_shell.getPath("forgot_password_web") + com.clubpenguin.login.Tools.getTrackingAppend());
    } // End of the function
    static function debugTrace(msg)
    {
        if (!com.clubpenguin.login.views.BaseLoginView.debugTracesActive)
        {
            return;
        } // end if
    } // End of the function
    static var LINKAGE_ID = "";
    static var MULTI_LINE_SPACING = 6;
    static var debugTracesActive = true;
} // End of Class
