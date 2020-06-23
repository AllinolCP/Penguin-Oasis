class com.clubpenguin.hud.phone.mediator.FieldOpObjectiveMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
{
    var _context, SHELL, fieldOpObjectiveView, mainView, previousMedalsTotal, epfService, _agentStatusPresed, player, gamesURL, view, onClosed, setLanguageCode, gameName, gameContainer, objectiveViewWidth, objectiveViewHeight, __get__agentStatusPresed;
    function FieldOpObjectiveMediator(view, context)
    {
        super(view, context.appClosed, context.languageCode);
        _context = context;
        SHELL = context.SHELL;
        fieldOpObjectiveView = view;
        mainView = fieldOpObjectiveView._parent;
        previousMedalsTotal = 0;
        epfService = context.epfService;
        epfService.__get__fieldOpStatusReceived().add(onFieldOpStatusReceived, this);
        epfService.__get__pointsReceived().add(updatePoints, this);
        _agentStatusPresed = new org.osflash.signals.Signal(com.clubpenguin.hud.phone.model.PhoneState);
        fieldOpObjectiveView.agentStatus.onPress = com.clubpenguin.util.Delegate.create(_agentStatusPresed, _agentStatusPresed.dispatch);
        player = context.player;
        gamesURL = context.gamesURL;
        fieldOpObjectiveView.membership.onPress = com.clubpenguin.util.Delegate.create(this, getMembershipURL);
    } // End of the function
    function initView(view)
    {
        this.view = view;
        fieldOpObjectiveView = view;
        view.closed.add(onClosed, this);
        fieldOpObjectiveView.agentStatus.onPress = com.clubpenguin.util.Delegate.create(_agentStatusPresed, _agentStatusPresed.dispatch);
        fieldOpObjectiveView.membership.onPress = com.clubpenguin.util.Delegate.create(this, getMembershipURL);
        this.setLanguageCode(_context.languageCode);
    } // End of the function
    function getMembershipURL()
    {
        getURL(SHELL.getPath("member_web"), "_blank");
    } // End of the function
    function get agentStatusPresed()
    {
        return (_agentStatusPresed);
    } // End of the function
    function updatePoints(totalPoints, unusedPoints)
    {
        previousMedalsTotal = totalPoints;
    } // End of the function
    function onFieldOpTriggered(gameName)
    {
        fieldOpObjectiveView.loading._visible = true;
        fieldOpObjectiveView.memberVictory._visible = false;
        mainView.deleteObjectiveMovie();
        this.gameName = gameName;
        var _loc3 = mainView.getNextHighestDepth();
        gameContainer = mainView.createEmptyMovieClip("gameHolder", _loc3);
        objectiveViewWidth = fieldOpObjectiveView._height;
        objectiveViewHeight = fieldOpObjectiveView._width;
        var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onGameViewLoaded));
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onGameLoadError));
        _loc2.loadClip(gamesURL + gameName + "/" + gameName + ".swf", gameContainer);
        epfService.getPoints();
    } // End of the function
    function onGameViewLoaded(event)
    {
        var _loc2 = gameContainer.getBounds(mainView);
        var _loc3 = _loc2.xMax - _loc2.xMin;
        var _loc4 = objectiveViewWidth / com.clubpenguin.hud.phone.mediator.FieldOpObjectiveMediator.GAME_WIDTH;
        gameContainer._rotation = -90;
        gameContainer._y = 480;
        if (!gameContainer.completed)
        {
            return;
        } // end if
        fieldOpObjectiveView.loading._visible = false;
        mainView.hideFieldOpObjective();
        gameContainer.completed.add(onCompleted, this);
    } // End of the function
    function onCompleted()
    {
        mainView.deleteObjectiveMovie();
        this.initView(mainView.showFieldOpObjective());
        fieldOpObjectiveView.loading._visible = false;
        epfService.setFieldOpStatus(com.clubpenguin.hud.phone.model.FieldOpStatus.DONE);
    } // End of the function
    function onFieldOpStatusReceived(fieldOpstatus)
    {
        if (fieldOpstatus == com.clubpenguin.hud.phone.model.FieldOpStatus.DONE)
        {
            epfService.__get__pointsReceived().remove(updatePoints, this);
            epfService.getPoints().add(onPointsReceived, this);
        } // end if
    } // End of the function
    function onPointsReceived(unusedPoints, totalPoints)
    {
        fieldOpObjectiveView.showMemberVictory(unusedPoints);
        SHELL.getStampManager().checkForEPFFieldOpsMedalStamps(totalPoints);
    } // End of the function
    function onGameLoadError(event)
    {
    } // End of the function
    static var GAME_WIDTH = 480;
    static var GAME_HEIGHT = 300;
    static var GAME_FILE_EXTENSION = ".swf";
} // End of Class
