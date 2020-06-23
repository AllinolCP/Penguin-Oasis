class com.clubpenguin.login.views.NewPlayer extends com.clubpenguin.login.views.BaseLoginView
{
    var username_input, _usernameInputField, peng_name_txt, _penguinNameField, create_account_btn, _createAccountBtn, back_btn, _backBtn, redemption_txt, _redemptionTitleField, dont_have_txt, _dontHaveAPenguinField, create_free_txt, _createFreePenguinField, back_txt, _backField, viewManager, _shell, _passwordInputField, _usernameCheckClip, _passwordCheckClip, _loginBtn, _forgotBtn, _userNameLoggingIn, onLoginResponse;
    function NewPlayer()
    {
        super();
        _usernameInputField = username_input;
        _penguinNameField = peng_name_txt;
        _createAccountBtn = create_account_btn;
        _backBtn = back_btn;
        _redemptionTitleField = redemption_txt;
        _dontHaveAPenguinField = dont_have_txt;
        _createFreePenguinField = create_free_txt;
        _backField = back_txt;
    } // End of the function
    function setup(options)
    {
        super.setup(options);
    } // End of the function
    function setupRedemption()
    {
        super.setupRedemption();
        _redemptionTitleField._visible = false;
        if ((com.clubpenguin.login.views.ViewManager)(viewManager).getRedemptionStatus())
        {
            _redemptionTitleField._visible = true;
        } // end if
    } // End of the function
    function setupLocalization()
    {
        super.setupLocalization();
        _penguinNameField.text = _shell.getLocalizedString("Penguin Name:");
        _dontHaveAPenguinField.text = _shell.getLocalizedString("Don\'t have a penguin?");
        _createFreePenguinField.text = _shell.getLocalizedString("Create a free account now");
        _backField.text = _shell.getLocalizedString("Back");
        _redemptionTitleField.text = _shell.getLocalizedString("Login to Unlock Your Items");
    } // End of the function
    function setupTabIndicies()
    {
        _usernameInputField.tabIndex = 0;
        _passwordInputField.tabIndex = 1;
        _usernameCheckClip.tabIndex = 2;
        _passwordCheckClip.tabIndex = 3;
        _loginBtn.tabIndex = 4;
        _forgotBtn.tabIndex = 5;
        _createAccountBtn.tabIndex = 6;
        _backBtn.tabIndex = 7;
        Selection.setFocus(_usernameInputField);
        com.clubpenguin.login.Keyboard.setOnEnterFunction(_loginBtn.onRelease);
    } // End of the function
    function sendLogin()
    {
        com.clubpenguin.login.views.BaseLoginView.debugTrace("sendLogin - expecting onLoginResponse ...");
        _userNameLoggingIn = _usernameInputField.text;
        if (com.clubpenguin.login.Tools.isValidUsername(_userNameLoggingIn))
        {
            if (com.clubpenguin.login.Tools.isValidPassword(_passwordInputField.text))
            {
                _shell.showLoading(_shell.getLocalizedString("Logging in") + " " + _shell.toTitleCase(_userNameLoggingIn));
                _shell.sendLogin(_userNameLoggingIn, _passwordInputField.text, com.clubpenguin.util.Delegate.create(this, onLoginResponse));
            } // end if
        } // end if
    } // End of the function
    function createPenguinRelease()
    {
        _shell.getCreateFile();
    } // End of the function
    function setInputHandlingState(enabled)
    {
        super.setInputHandlingState(enabled);
        if (enabled)
        {
            _backBtn.onRelease = com.clubpenguin.util.Delegate.create(viewManager, (com.clubpenguin.login.views.ViewManager)(viewManager).gotoStart);
            _createAccountBtn.onRelease = com.clubpenguin.util.Delegate.create(this, createPenguinRelease);
            return;
        } // end if
        _backBtn.onRelease = null;
        _createAccountBtn.onRelease = null;
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.login.views.NewPlayer";
} // End of Class
