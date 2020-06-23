class com.clubpenguin.lib.movieclip.TimedAnimation extends MovieClip
{
    var stop, __criticalFrames, __percent, _totalframes, gotoAndStop;
    function TimedAnimation()
    {
        super();
        this.stop();
        this.createKeyframes();
    } // End of the function
    function createKeyframes()
    {
        __criticalFrames = [1, 2, 3, 4, 5];
    } // End of the function
    function progress(_percent)
    {
        _percent = _percent % 100;
        __percent = Math.round(_percent);
        var _loc2 = Math.round(_totalframes * __percent / 100);
        if (_loc2 >= __criticalFrames[__nextCritical])
        {
            this.gotoAndStop(__criticalFrames[__nextCritical]);
            ++__nextCritical;
            if (__nextCritical >= __criticalFrames.length)
            {
                __nextCritical = 0;
            } // end if
        }
        else
        {
            this.gotoAndStop(_loc2);
        } // end else if
    } // End of the function
    function reset()
    {
        __percent = 0;
        __nextCritical = 0;
        this.gotoAndStop(1);
    } // End of the function
    var __nextCritical = 0;
} // End of Class
