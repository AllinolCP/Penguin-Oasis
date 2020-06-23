class com.clubpenguin.games.cardjitsu.water.event.MotionEvent extends com.clubpenguin.lib.event.Event
{
    function MotionEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var PROGRESS = "motionProgressEvent";
    static var COMPLETE = "motionCompleteEvent";
    static var BEGIN = "motionBeginEvent";
} // End of Class
