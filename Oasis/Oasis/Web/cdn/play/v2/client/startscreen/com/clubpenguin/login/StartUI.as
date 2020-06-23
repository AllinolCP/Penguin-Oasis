class com.clubpenguin.login.StartUI extends MovieClip
{
    var _shell, _langAbbreviation, _startText, attachMovie, _createPenguinClip, _learnMemberClip, _redemptionClip, _startButton, _joinButton, getURL, updateListeners;
    function StartUI()
    {
        super();
        com.clubpenguin.util.EventDispatcher.initialize(this);
        this.localize();
        this.attachButtonActions();
        this.setupTabIndexes();
    } // End of the function
    function localize()
    {
        _shell = _global.getCurrentShell();
        _langAbbreviation = _shell.getLanguageAbbriviation();
        var _loc3 = _global.getCurrentShell().getLocalizedFrame();
        _startText.gotoAndStop(_loc3);
        _createPenguinClip = this.attachMovie(com.clubpenguin.login.StartUI.CREATE_PENGUIN_LINKAGE_ID + _langAbbreviation.toUpperCase(), "_createPenguinClip", 1, {_x: com.clubpenguin.login.StartUI.CREATE_PENGUIN_X, _y: com.clubpenguin.login.StartUI.CREATE_PENGUIN_Y});
        _learnMemberClip = this.attachMovie(com.clubpenguin.login.StartUI.LEARN_MEMBER_LINKAGE_ID + _langAbbreviation.toUpperCase(), "_learnMemberClip", 2, {_x: com.clubpenguin.login.StartUI.LEARN_MEMBER_X, _y: com.clubpenguin.login.StartUI.LEARN_MEMBER_Y});
        _redemptionClip._badgeClip._redeemablesIconClip.gotoAndStop(_langAbbreviation);
    } // End of the function
    function attachButtonActions()
    {
        _startButton.onRelease = com.clubpenguin.util.Delegate.create(this, startRelease);
        _joinButton.onRelease = com.clubpenguin.util.Delegate.create(this, joinRelease);
        _redemptionClip.onRelease = com.clubpenguin.util.Delegate.create(this, redemptionRelease);
    } // End of the function
    function setupTabIndexes()
    {
        _startButton.tabIndex = 0;
        _redemptionClip.tabIndex = 1;
        _createPenguinClip.tabIndex = 2;
        _learnMemberClip.tabIndex = 3;
    } // End of the function
    function joinRelease()
    {
        this.getURL("https://account.oasis.ps/join/", "_blank");
    } // End of the function
    function startRelease()
    {
        this.debugTrace("startRelease cb");
        this.updateListeners(com.clubpenguin.login.StartUI.START_RELEASE);
    } // End of the function
    function redemptionRelease()
    {
        this.updateListeners(com.clubpenguin.login.StartUI.REDEMPTION_RELEASE);
    } // End of the function
    function memberRelease()
    {
        this.debugTrace("memberRelease cb");
        this.updateListeners(com.clubpenguin.login.StartUI.MEMBERSHIP_RELEASE);
    } // End of the function
    function memberRollOver()
    {
        _learnMemberClip.gotoAndStop(com.clubpenguin.login.StartUI.OVER_FRAME);
    } // End of the function
    function memberRollOut()
    {
        _learnMemberClip.gotoAndStop(com.clubpenguin.login.StartUI.UP_FRAME);
    } // End of the function
    function createPenguinRelease()
    {
        this.updateListeners(com.clubpenguin.login.StartUI.CREATE_PENGUIN_RELEASE);
    } // End of the function
    function createPenguinRollOut()
    {
        _createPenguinClip.gotoAndStop(com.clubpenguin.login.StartUI.UP_FRAME);
    } // End of the function
    function createPenguinRollOver()
    {
        _createPenguinClip.gotoAndStop(com.clubpenguin.login.StartUI.OVER_FRAME);
    } // End of the function
    function debugTrace(msg)
    {
        if (debugTracesActive)
        {
        } // end if
    } // End of the function
    static var LINKAGE_ID = "StartUISymbol";
    static var REDEMPTION_RELEASE = "redemptionRelease";
    static var START_RELEASE = "startRelease";
    static var CREATE_PENGUIN_RELEASE = "createPenguinRelease";
    static var MEMBERSHIP_RELEASE = "MembershipRelease";
    static var OVER_FRAME = 2;
    static var UP_FRAME = 1;
    static var CREATE_PENGUIN_LINKAGE_ID = "CreatePenguin";
    static var CREATE_PENGUIN_X = 485;
    static var CREATE_PENGUIN_Y = 358;
    static var LEARN_MEMBER_LINKAGE_ID = "LearnMembership";
    static var LEARN_MEMBER_X = 485;
    static var LEARN_MEMBER_Y = 400;
    var debugTracesActive = true;
} // End of Class
