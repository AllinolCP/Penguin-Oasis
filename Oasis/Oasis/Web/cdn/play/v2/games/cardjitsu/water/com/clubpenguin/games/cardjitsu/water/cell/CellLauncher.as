class com.clubpenguin.games.cardjitsu.water.cell.CellLauncher extends com.clubpenguin.lib.movieclip.TriggerClip
{
    var onEnterFrame, cellFillable, __spitFrame, __cellFrame, fishy;
    function CellLauncher()
    {
        super();
        onEnterFrame = setUp;
    } // End of the function
    function setUp()
    {
        delete this.onEnterFrame;
        cellFillable.__set__launcher(this);
    } // End of the function
    function setCell(_src)
    {
        __spitFrame = _src.__get__element().letter;
        __cellFrame = _src.getDisplay().boat.element.boat.base._currentFrame;
    } // End of the function
    function triggerLaunch()
    {
        if (!__aborted)
        {
            cellFillable.reset();
            cellFillable.__get___cell().base.gotoAndStop(__cellFrame);
        } // end if
    } // End of the function
    function triggerFill()
    {
        fishy.trigger(__spitFrame);
    } // End of the function
    function abort()
    {
        __aborted = true;
        cellFillable.stop();
    } // End of the function
    function killLauncher()
    {
        cellFillable._visible = false;
    } // End of the function
    function updateCellProgress(_progress)
    {
        cellFillable.progress(_progress);
    } // End of the function
    function toString()
    {
        return ("[CellLauncher]");
    } // End of the function
    var __aborted = false;
} // End of Class
