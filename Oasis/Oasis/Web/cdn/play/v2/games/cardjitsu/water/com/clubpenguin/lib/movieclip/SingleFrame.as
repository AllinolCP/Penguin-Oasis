class com.clubpenguin.lib.movieclip.SingleFrame extends MovieClip
{
    var _totalframes, __selectedFrame, onEnterFrame, _currentframe, gotoAndStop, nextFrame;
    function SingleFrame()
    {
        super();
        this.selectRandomFrame();
    } // End of the function
    function selectRandomFrame()
    {
        var _loc2;
        _loc2 = Math.ceil(Math.random() * _totalframes);
        __selectedFrame = _loc2;
        onEnterFrame = setFrame;
        return (_loc2);
    } // End of the function
    function setFrame()
    {
        delete this.onEnterFrame;
        if (_currentframe != __selectedFrame)
        {
            this.gotoAndStop(__selectedFrame);
        } // end if
    } // End of the function
    function config(_selFrame)
    {
        var _loc2;
        var _loc3;
        _loc2 = parseInt(String(_selFrame));
        if (isNaN(_loc2))
        {
            _loc3 = String(_selFrame);
            this.gotoAndStop(_loc3);
        }
        else
        {
            this.gotoAndStop(_loc2);
        } // end else if
    } // End of the function
    function gotoAndPlay(_frame)
    {
        this.gotoAndStop(_frame);
    } // End of the function
    function play()
    {
        this.nextFrame();
    } // End of the function
} // End of Class
