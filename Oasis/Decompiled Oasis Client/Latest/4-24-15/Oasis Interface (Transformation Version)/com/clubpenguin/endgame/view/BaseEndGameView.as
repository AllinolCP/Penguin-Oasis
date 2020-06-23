class com.clubpenguin.endgame.view.BaseEndGameView extends MovieClip
{
    var _x, _y, block_mc, _mcBlock, _endGameClosed, stop, _visible, _shell, _model, _params, onEnterFrame, _currentFrameLabel, gotoAndStop, close_btn, _closeBtn, how_to_btn, _howToBtn, title_mc, _title, stamps_mc, _earnedStampsTxt, _earnedStampsShadowTxt, _totalStampsTxt, info_txt, _infoTxt, progress_gague_mc, _progressGague, stampList, _stampViewer, howto_txt, _descriptionBox, getNextHighestDepth, createEmptyMovieClip, _howToLoc, __get__endGameClosed;
    function BaseEndGameView()
    {
        super();
        _x = com.clubpenguin.endgame.view.BaseEndGameView.END_GAME_POS_X;
        _y = com.clubpenguin.endgame.view.BaseEndGameView.END_GAME_POS_Y;
        _mcBlock = block_mc;
        _mcBlock.useHandCursor = false;
        _mcBlock.tabEnabled = false;
        _mcBlock.onRelease = null;
        _endGameClosed = new org.osflash.signals.Signal();
        this.stop();
        _visible = false;
    } // End of the function
    function get endGameClosed()
    {
        return (_endGameClosed);
    } // End of the function
    function setShell(shell)
    {
        _shell = shell;
    } // End of the function
    function setModel(model)
    {
        _model = model;
    } // End of the function
    function initialize()
    {
        _params = _model.endGameParams;
        this.debugTrace("initialize BaseEndGameView _params = " + _params);
        this.updateView();
        this.initReferences();
    } // End of the function
    function updateView()
    {
        this.debugTrace("updateView()");
        if (_params == null)
        {
            this.debugTrace("_params == null   abort updateView");
            return;
        } // end if
        if (_params.numTotalStamps <= 0)
        {
            this.gotoNoStamps();
        }
        else if (_params.numTotalStamps > 0 && _params.numCompletedStamps == _params.numTotalStamps)
        {
            if (_model.__get__isJustCompleted())
            {
                this.gotoCongrats();
            }
            else
            {
                this.gotoCompleted();
            } // end else if
        }
        else if (_params.newStamps.length == 0)
        {
            this.gotoNoNewStamps();
        }
        else
        {
            this.gotoProgress();
        } // end else if
    } // End of the function
    function delayInitCall(initFunc)
    {
        onEnterFrame = mx.utils.Delegate.create(this, function ()
        {
            onEnterFrame = null;
            _visible = true;
            initFunc.call(this);
        });
    } // End of the function
    function gotoNoStamps()
    {
        _currentFrameLabel = com.clubpenguin.endgame.view.BaseEndGameView.FRAME_NO_STAMPS;
        this.gotoAndStop(_currentFrameLabel);
        this.delayInitCall(initNoStamps);
    } // End of the function
    function gotoNoNewStamps()
    {
        _currentFrameLabel = com.clubpenguin.endgame.view.BaseEndGameView.FRAME_NO_NEW_STAMPS;
        this.gotoAndStop(_currentFrameLabel);
        this.delayInitCall(initNoNewStamps);
    } // End of the function
    function gotoHowTo()
    {
        _currentFrameLabel = com.clubpenguin.endgame.view.BaseEndGameView.FRAME_HOWTO;
        this.gotoAndStop(_currentFrameLabel);
        this.delayInitCall(initHowTo);
    } // End of the function
    function gotoCongrats()
    {
        _currentFrameLabel = com.clubpenguin.endgame.view.BaseEndGameView.FRAME_CONGRATS;
        this.gotoAndStop(_currentFrameLabel);
        this.delayInitCall(initCongrats);
    } // End of the function
    function gotoCompleted()
    {
        _currentFrameLabel = com.clubpenguin.endgame.view.BaseEndGameView.FRAME_COMPLETED;
        this.gotoAndStop(_currentFrameLabel);
        this.delayInitCall(initCompleted);
    } // End of the function
    function gotoProgress()
    {
        _currentFrameLabel = com.clubpenguin.endgame.view.BaseEndGameView.FRAME_PROGRESS;
        this.gotoAndStop(_currentFrameLabel);
        this.delayInitCall(initProgress);
    } // End of the function
    function initReferences()
    {
        this.debugTrace("initReferences");
        _closeBtn = close_btn;
        _howToBtn = how_to_btn;
        _title = title_mc;
        _earnedStampsTxt = stamps_mc.earned_txt;
        _earnedStampsShadowTxt = stamps_mc.earned_shadow_txt;
        _totalStampsTxt = stamps_mc.total_txt;
        _infoTxt = info_txt;
        _progressGague = progress_gague_mc;
        _stampViewer = stampList;
    } // End of the function
    function setupComponents()
    {
        this.setupDescriptionBox();
        this.setupStamps();
        this.setupInfo();
        this.setupProgressGague();
        this.setupStampViewer();
        this.setupTitle();
    } // End of the function
    function initNoStamps()
    {
        this.debugTrace("initNoStamps");
        _isShowingProgressGague = false;
        _isShowingStampViewer = false;
        this.setupComponents();
        _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
    } // End of the function
    function initNoNewStamps()
    {
        this.debugTrace("initNoNewStamps");
        _isShowingProgressGague = true;
        _isShowingStampViewer = false;
        this.setupComponents();
        var _loc2 = howto_txt;
        _loc2.text = _shell.getLocalizedString("end_game_howto_btn");
        com.clubpenguin.util.StringUtils.ResizeTextToFit(_loc2);
        _howToBtn.onRelease = mx.utils.Delegate.create(this, gotoHowTo);
        _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
    } // End of the function
    function initHowTo()
    {
        this.debugTrace("initHowTo");
        _isShowingProgressGague = false;
        _isShowingStampViewer = false;
        this.setupComponents();
        this.setupHowTo();
        _closeBtn.onRelease = mx.utils.Delegate.create(this, closeHowTo);
    } // End of the function
    function initCongrats()
    {
        this.debugTrace("initCongrats");
        _isShowingProgressGague = false;
        _isShowingStampViewer = true;
        this.setupComponents();
        _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
    } // End of the function
    function initCompleted()
    {
        this.debugTrace("initCompleted");
        _isShowingProgressGague = false;
        _isShowingStampViewer = false;
        this.setupComponents();
        _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
    } // End of the function
    function initProgress()
    {
        this.debugTrace("initProgress");
        _isShowingProgressGague = true;
        _isShowingStampViewer = true;
        this.setupComponents();
        _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
    } // End of the function
    function setupDescriptionBox()
    {
        if (_descriptionBox != null)
        {
            _descriptionBox.removeMovieClip();
        } // end if
        var _loc2 = _stampViewer.__get__paginationHolder().attachMovie(com.clubpenguin.stamps.stampbook.controls.DescriptionBox.LINKAGE_ID, "_descriptionBox", com.clubpenguin.endgame.view.BaseEndGameView.DESCRIPTION_BOX_DEPTH);
        _descriptionBox = (com.clubpenguin.stamps.stampbook.controls.DescriptionBox)(_loc2);
        _descriptionBox._visible = false;
    } // End of the function
    function setupTitle()
    {
        var _loc2 = _model.__get__gameName();
        _title.title_txt.text = _loc2;
        _title.title_shadow_txt.text = _loc2;
        _title.earned_txt.text = _shell.getLocalizedString("end_game_earned");
    } // End of the function
    function setupStamps()
    {
        if (_currentFrameLabel == com.clubpenguin.endgame.view.BaseEndGameView.FRAME_NO_STAMPS || _currentFrameLabel == com.clubpenguin.endgame.view.BaseEndGameView.FRAME_HOWTO)
        {
            return;
        } // end if
        var _loc2 = "end_game_stamps_earned";
        _loc2 = _shell.getLocalizedString(_loc2);
        _loc2 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_params.numCompletedStamps), _loc2);
        _loc2 = com.clubpenguin.util.StringUtils.replaceString("%total%", String(_params.numTotalStamps), _loc2);
        var _loc3 = _shell.getLocalizedString("game_name_stamps");
        _loc3 = com.clubpenguin.util.StringUtils.replaceString("%game_name%", String(_model.__get__gameName()), _loc3);
        _earnedStampsTxt.text = _loc2;
        _earnedStampsShadowTxt.text = _loc2;
        _totalStampsTxt.text = _loc3;
    } // End of the function
    function setupInfo()
    {
        if (_currentFrameLabel == com.clubpenguin.endgame.view.BaseEndGameView.FRAME_HOWTO || _currentFrameLabel == com.clubpenguin.endgame.view.BaseEndGameView.FRAME_NO_STAMPS)
        {
            return;
        } // end if
        var _loc2 = "";
        if (_params.numCompletedStamps == _params.numTotalStamps)
        {
            _loc2 = this.createCongratsMessage();
        } // end if
        _infoTxt.text = _loc2;
    } // End of the function
    function setupProgressGague()
    {
        if (!_isShowingProgressGague)
        {
            return;
        } // end if
        var _loc2 = new com.clubpenguin.endgame.model.StampProgressModel(_shell, _params.numCompletedStamps, _params.numTotalStamps);
        var _loc3 = new com.clubpenguin.endgame.mediator.StampProgressMediator(_progressGague, _loc2);
        _loc3.init();
    } // End of the function
    function setupStampViewer()
    {
        if (!_isShowingStampViewer)
        {
            return;
        } // end if
        _stampViewer.stampIconRolledOver.add(onStampIconRollOver, this);
        _stampViewer.stampIconRolledOut.add(onStampIconRollOut, this);
        var _loc3 = new com.clubpenguin.endgame.model.StampListModel(_shell, _params.newStamps);
        var _loc2 = new com.clubpenguin.endgame.mediator.StampListMediator(_stampViewer, _loc3);
        _loc2.init();
    } // End of the function
    function onStampIconRollOver(target, stamp)
    {
        _descriptionBox._visible = true;
        _descriptionBox.setModel(stamp);
        _descriptionBox._x = target._x + com.clubpenguin.endgame.view.BaseEndGameView.DESCRIPTION_BOX_OFFSET_X;
        _descriptionBox._y = target._y + com.clubpenguin.endgame.view.BaseEndGameView.DESCRIPTION_BOX_OFFSET_Y;
    } // End of the function
    function onStampIconRollOut()
    {
        _descriptionBox._visible = false;
    } // End of the function
    function setupHowTo()
    {
        var _loc2 = _shell.getLocalizedString("end_game_howto_title");
        _title.title_txt.text = _loc2;
        _title.title_shadow_txt.text = _loc2;
        var _loc4 = _shell.getPath("end_game_howto");
        var _loc3 = this.createEmptyMovieClip("howto_loc_mc", this.getNextHighestDepth());
        _shell.loadSWF(_loc3, _loc4, null, mx.utils.Delegate.create(this, onHowToLocLoaded), null, null);
    } // End of the function
    function onHowToLocLoaded(target)
    {
        _howToLoc = target;
        _howToLoc._x = com.clubpenguin.endgame.view.BaseEndGameView.HOW_TO_LOC_POS_X;
        _howToLoc._y = com.clubpenguin.endgame.view.BaseEndGameView.HOW_TO_LOC_POS_Y;
    } // End of the function
    function closeHowTo()
    {
        _howToLoc.unloadMovie();
        _howToLoc = undefined;
        _visible = false;
        this.gotoNoNewStamps();
    } // End of the function
    function createCongratsMessage()
    {
        var _loc2 = "";
        _loc2 = _model.__get__isJustCompleted() ? ("end_game_first_congrats") : ("end_game_congrats");
        _loc2 = _shell.getLocalizedString(_loc2);
        if (_model.__get__isJustCompleted())
        {
            _loc2 = com.clubpenguin.util.StringUtils.replaceString("%game_name%", String(_model.__get__gameName()), _loc2);
        } // end if
        return (_loc2);
    } // End of the function
    function close()
    {
        this.debugTrace("close");
        this.gotoAndStop("hidden");
        _endGameClosed.dispatch();
    } // End of the function
    function debugTrace(msg)
    {
    } // End of the function
    static var LINKAGE_ID = "com.clubpenguin.endgame.view.BaseEndGameView";
    static var FRAME_NO_STAMPS = "noStamps";
    static var FRAME_NO_NEW_STAMPS = "noNewStamps";
    static var FRAME_HOWTO = "howto";
    static var FRAME_CONGRATS = "congrats";
    static var FRAME_COMPLETED = "completed";
    static var FRAME_PROGRESS = "progress";
    static var END_GAME_POS_X = 380;
    static var END_GAME_POS_Y = 240;
    static var HOW_TO_LOC_POS_X = -133;
    static var HOW_TO_LOC_POS_Y = -114;
    static var DESCRIPTION_BOX_DEPTH = 1000;
    static var DESCRIPTION_BOX_OFFSET_X = -82;
    static var DESCRIPTION_BOX_OFFSET_Y = -110;
    var _isShowingProgressGague = false;
    var _isShowingStampViewer = false;
} // End of Class
