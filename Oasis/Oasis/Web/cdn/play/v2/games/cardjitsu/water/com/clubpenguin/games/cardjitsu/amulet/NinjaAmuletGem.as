class com.clubpenguin.games.cardjitsu.amulet.NinjaAmuletGem extends MovieClip
{
    var __active, __pulsing, stop, __awardCompleteCallback, gotoAndPlay, _currentframe, _totalframes, gotoAndStop, __name, __get__name, __get__active, __set__name;
    function NinjaAmuletGem()
    {
        super();
        __active = false;
        __pulsing = false;
    } // End of the function
    function stopFrame()
    {
        this.stop();
    } // End of the function
    function award(_callback)
    {
        __active = true;
        __pulsing = false;
        __awardCompleteCallback = _callback;
        this.gotoAndPlay("award");
    } // End of the function
    function awardComplete()
    {
        if (__awardCompleteCallback != null)
        {
            this.__awardCompleteCallback();
        } // end if
        __awardCompleteCallback = null;
    } // End of the function
    function pulse()
    {
        if (_currentframe < com.clubpenguin.games.cardjitsu.amulet.NinjaAmuletGem.PULSE_FRAME || _currentframe == _totalframes)
        {
            __active = true;
            __pulsing = true;
            this.gotoAndPlay("pulse");
        } // end if
    } // End of the function
    function pulseComplete()
    {
        if (__pulsing)
        {
            this.gotoAndPlay("pulse");
        }
        else
        {
            this.stopPulse();
        } // end else if
    } // End of the function
    function stopPulse()
    {
        if (__pulsing)
        {
            __pulsing = false;
            if (__active)
            {
                this.show();
            }
            else
            {
                this.hide();
            } // end if
        } // end else if
    } // End of the function
    function show()
    {
        __active = true;
        if (!__pulsing)
        {
            this.gotoAndStop("shown");
        }
        else
        {
            this.stopPulse();
        } // end else if
    } // End of the function
    function hide()
    {
        __active = false;
        __pulsing = false;
        this.gotoAndStop("hidden");
    } // End of the function
    function get active()
    {
        return (__active);
    } // End of the function
    function set name(_val)
    {
        __name = _val;
        //return (this.name());
        null;
    } // End of the function
    function get name()
    {
        return (__name);
    } // End of the function
    static var PULSE_FRAME = 51;
} // End of Class
