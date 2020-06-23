class com.clubpenguin.games.cardjitsu.water.cell.CellFillable extends com.clubpenguin.lib.movieclip.TimedAnimation
{
    var __criticalFrames, __launcher, cell, __get__launcher, __get___cell, __set__launcher;
    function CellFillable()
    {
        super();
    } // End of the function
    function createKeyframes()
    {
        __criticalFrames = [1, 81, 95];
    } // End of the function
    function triggerFill()
    {
        __launcher.triggerFill();
    } // End of the function
    function launchComplete()
    {
    } // End of the function
    function get _cell()
    {
        return (cell);
    } // End of the function
    function set launcher(_launcher)
    {
        __launcher = _launcher;
        //return (this.launcher());
        null;
    } // End of the function
} // End of Class
