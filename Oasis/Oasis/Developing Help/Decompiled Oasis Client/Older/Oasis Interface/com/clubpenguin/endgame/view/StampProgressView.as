class com.clubpenguin.endgame.view.StampProgressView extends MovieClip
{
    var _shell, bar_mc, _bar, progress_txt, _txLabel, gotoAndStop;
    function StampProgressView()
    {
        super();
        this.initReferences();
    } // End of the function
    function setShell(shell)
    {
        _shell = shell;
    } // End of the function
    function initReferences()
    {
        _bar = bar_mc;
        _txLabel = progress_txt;
    } // End of the function
    function displayProgress(completedPercent)
    {
        var _loc2 = _shell.getLocalizedString("percent");
        _loc2 = com.clubpenguin.util.StringUtils.replaceString("%percentage%", String(completedPercent), _loc2);
        _txLabel.text = _loc2;
        this.gotoAndStop(completedPercent + 1);
        var _loc3 = _bar._width + _bar._x;
        var _loc4 = _txLabel.textWidth;
        if (_bar._width - _loc3 < _loc4 + com.clubpenguin.endgame.view.StampProgressView.PROGRESS_GAGUE_LABEL_PADDING)
        {
            _txLabel._x = com.clubpenguin.endgame.view.StampProgressView.PROGRESS_GAGUE_LABEL_START_X + _loc3 - _loc4 - com.clubpenguin.endgame.view.StampProgressView.PROGRESS_GAGUE_LABEL_PADDING;
            _txLabel.textColor = com.clubpenguin.endgame.view.StampProgressView.FONT_COLOR_PROGRESS_INSIDE;
        }
        else
        {
            _txLabel._x = _loc3 + com.clubpenguin.endgame.view.StampProgressView.PROGRESS_GAGUE_LABEL_START_X + com.clubpenguin.endgame.view.StampProgressView.PROGRESS_GAGUE_LABEL_PADDING;
            _txLabel.textColor = com.clubpenguin.endgame.view.StampProgressView.FONT_COLOR_PROGRESS_OUTSIDE;
        } // end else if
    } // End of the function
    static var PROGRESS_GAGUE_LABEL_START_X = -97;
    static var PROGRESS_GAGUE_LABEL_PADDING = 5;
    static var FONT_COLOR_PROGRESS_INSIDE = 3355443;
    static var FONT_COLOR_PROGRESS_OUTSIDE = 16777215;
} // End of Class
