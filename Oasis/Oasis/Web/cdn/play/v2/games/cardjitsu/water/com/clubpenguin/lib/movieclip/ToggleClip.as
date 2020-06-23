class com.clubpenguin.lib.movieclip.ToggleClip extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, stop;
    function ToggleClip()
    {
        super();
        $_instanceCount = ++com.clubpenguin.lib.movieclip.ToggleClip.$_instanceCount;
        __uid = com.clubpenguin.lib.movieclip.ToggleClip.$_instanceCount;
        this.stop();
    } // End of the function
    function getUniqueName()
    {
        return ("[ToggleClip<" + __uid + ">]");
    } // End of the function
    function gotoAndStop(_frame)
    {
        switch (_frame)
        {
            case "on":
            {
                this.setStateOn();
                break;
            } 
            case "off":
            {
                this.setStateOff();
                break;
            } 
        } // End of switch
    } // End of the function
    function toggle(_state)
    {
        this.gotoAndStop(_state);
    } // End of the function
    function setStateOff()
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ToggleEvent(this, com.clubpenguin.lib.event.ToggleEvent.OFF));
        this.gotoAndStop(com.clubpenguin.lib.movieclip.ToggleClip.TOGGLE_OFF);
    } // End of the function
    function setStateOn()
    {
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ToggleEvent(this, com.clubpenguin.lib.event.ToggleEvent.ON));
        this.gotoAndStop(com.clubpenguin.lib.movieclip.ToggleClip.TOGGLE_ON);
    } // End of the function
    static var TOGGLE_OFF = 1;
    static var TOGGLE_ON = 2;
    static var $_instanceCount = 0;
} // End of Class
